//マスの周囲8方向を調べ、石を打てるか判定
boolean validMove(int i, int j){
  if(i<1||8<i || j<1||8<j){return false;} //盤外には打てない
  if (board[i][j]!=0) {return false;} //空マスでなければ打てない
  
  //board[i][j] = bw; //石を仮に打つ
  
  //注目するマスの周囲8方向に対し、石を打てるか調べる
  int ri, rj; //調べるマスを移動させるのに使う変数
  for (int di=-1; di<=1; di++){ //横方向
    for (int dj=-1; dj<=1; dj++){ //縦方向
      ri = i+di;  rj = j+dj; //調べるマスの初期値を与える
      
      //調べるマスが「盤の中」かつ「相手の石」ならループ
      while (board[ri][rj]!=2 && board[ri][rj]==-bw){
        ri+=di; rj+=dj; //次のマスに移動
        
        //同色の石に出会った(打てると分かった)時
        if (board[ri][rj]==bw){
          board[i][j]=0; //仮に打った石を取る
          return true; //打てると判定
        }
      }
    }
  }
  //board[i][j]=0; //仮に打った石を取る
  
  return false; //打てないと判定
}

//石を打ち、マスの周囲8方向の返せる石を反転
void movePiece(int i, int j){
  board[i][j] = bw; //石を打つ
  
  int ri, rj; //調べるマスを移動させるのに使う変数
  for (int di=-1; di<=1; di++){ //横方向
    for (int dj=-1; dj<=1; dj++){ //縦方向
      ri = i+di;  rj = j+dj; //調べるマスの初期値を与える
      
      //調べるマスが「盤の中」かつ「相手の石」ならループ
      while (board[ri][rj]!=2 && board[ri][rj]==-bw){
        ri+=di; rj+=dj; //次のマスに移動
        
        //同色の石に出会った時、打った石まで戻りつつ間の石を反転
        if (board[ri][rj]==bw){
          ri-=di; rj-=dj; //1マス戻る
          
          while (!(i==ri&&j==rj)){ //元のマスに戻るまで
            board[ri][rj] = bw; //自分の石にする(石を返す)
            ri-=di; rj-=dj; //また1マス戻る
          }
        }
      }
    }
  }
}

#盤面の記録と呼び出し
void recorder(boolean inout) {
  if(inout==true){
    for (int k=1;k<=8;k++){ //石の配置を記録
      for (int l=1;l<=8;l++) {board_rec[move][k][l] = board[k][l];}
    }
    bw_rec[move]=bw;
  }
  else if(inout==false){
    for (int k=1;k<=8;k++) { //石の配置を呼び出す
      for (int l=1;l<=8;l++) {board[k][l] = board_rec[move][k][l];}
    }
    bw=bw_rec[move];
    pass=0;
  }
}
