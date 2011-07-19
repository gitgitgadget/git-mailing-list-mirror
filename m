From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: [PATCH] tests: cleanup binary images usage
Date: Tue, 19 Jul 2011 20:21:47 +0300
Message-ID: <1311096107.8532.39.camel@vivanov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vitalivanov@gmail.com
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:22:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDzd-0004O7-Ip
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab1GSRVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 13:21:54 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:45673 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1GSRVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:21:50 -0400
Received: by fxd18 with SMTP id 18so319808fxd.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=JX6TYyNEXRj6cjpZLkGhf3Q9wEIb9sBJbnlGfYIZb/8=;
        b=VgzyhbyR0bqIKG0VtFNAheWmK+PWo5fZ9eFUOWw5T9Do1+OI/Yob3NCKAS/XSViQEn
         nBcKeNJIvOfdQwoOWfyVB7SUkkk1ki4mbIV5wE7jOWaJtcgNPm06+CpRvPsJoNIWZm9I
         mIgOtoPi/Lzxe4PK+q6Bnx5+aefFmlXVqXpKY=
Received: by 10.223.68.193 with SMTP id w1mr1335886fai.85.1311096108648;
        Tue, 19 Jul 2011 10:21:48 -0700 (PDT)
Received: from [172.20.1.188] (gw01.toroki.com.ua [194.44.247.181])
        by mx.google.com with ESMTPS id h10sm85659fai.43.2011.07.19.10.21.47
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:21:48 -0700 (PDT)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177484>

Images are being shared between tests:

Tue Jul 19 19:45:14
[vitaliy.ivanov@vivanov git]$ grep -r test4012.png *
t/t4012-diff-binary.sh:  cat "$TEST_DIRECTORY"/test4012.png >b &&
t/t6023-merge-file.sh:          orig.txt "$TEST_DIRECTORY"/test4012.png=
 new1.txt 2> merge.err &&
t/t3307-notes-man.sh:   cp "$TEST_DIRECTORY"/test4012.png . &&
t/t3307-notes-man.sh:   blob=3D$(git hash-object -w test4012.png) &&
t/t3307-notes-man.sh:   test_cmp test4012.png actual
t/t6027-merge-binary.sh:        cat "$TEST_DIRECTORY"/test4012.png >m &=
&

So, this is incorrect to name images depending on specific test. This p=
atch cleanups binary images that are used in tests.

The results of running tests before and after the changes:

fixed   0
success 7129
failed  0
broken  32
total   7262

---
>From bff3916939fcd226278a2e983ddc77bb711296e7 Mon Sep 17 00:00:00 2001
=46rom: Vitaliy Ivanov <vitalivanov@gmail.com>
Date: Tue, 19 Jul 2011 20:07:08 +0300
Subject: [PATCH] tests: cleanup binary images usage

Images are being shared between tests and this is OK.
By this patch I name images independently of tests plus
remove unneeded images.

Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
---
 t/t3307-notes-man.sh           |    6 +++---
 t/t4012-diff-binary.sh         |    2 +-
 t/t6023-merge-file.sh          |    2 +-
 t/t6027-merge-binary.sh        |    2 +-
 t/t9200-git-cvsexportcommit.sh |   14 +++++++-------
 t/test-image1.png              |  Bin 0 -> 5660 bytes
 t/test-image2.png              |  Bin 0 -> 275 bytes
 t/test4012.png                 |  Bin 5660 -> 0 bytes
 t/test9200a.png                |  Bin 5660 -> 0 bytes
 t/test9200b.png                |  Bin 275 -> 0 bytes
 10 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 t/test-image1.png
 create mode 100644 t/test-image2.png
 delete mode 100644 t/test4012.png
 delete mode 100644 t/test9200a.png
 delete mode 100644 t/test9200b.png

diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index 2ea3be6..3c7fc1b 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -26,13 +26,13 @@ test_expect_success 'example 1: notes to add an Ack=
ed-by line' '
 '
=20
 test_expect_success 'example 2: binary notes' '
-	cp "$TEST_DIRECTORY"/test4012.png . &&
+	cp "$TEST_DIRECTORY"/test-image1.png . &&
 	git checkout B &&
-	blob=3D$(git hash-object -w test4012.png) &&
+	blob=3D$(git hash-object -w test-image1.png) &&
 	git notes --ref=3Dlogo add -C "$blob" &&
 	git notes --ref=3Dlogo copy B C &&
 	git notes --ref=3Dlogo show C >actual &&
-	test_cmp test4012.png actual
+	test_cmp test-image1.png actual
 '
=20
 test_done
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 05ec062..037dbc1 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -12,7 +12,7 @@ test_expect_success 'prepare repository' \
 	'echo AIT >a && echo BIT >b && echo CIT >c && echo DIT >d &&
 	 git update-index --add a b c d &&
 	 echo git >a &&
-	 cat "$TEST_DIRECTORY"/test4012.png >b &&
+	 cat "$TEST_DIRECTORY"/test-image1.png >b &&
 	 echo git >c &&
 	 cat b b >d'
=20
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index d9f3439..f165914 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -154,7 +154,7 @@ test_expect_success "expected conflict markers" "te=
st_cmp expect out"
=20
 test_expect_success 'binary files cannot be merged' '
 	test_must_fail git merge-file -p \
-		orig.txt "$TEST_DIRECTORY"/test4012.png new1.txt 2> merge.err &&
+		orig.txt "$TEST_DIRECTORY"/test-image1.png new1.txt 2> merge.err &&
 	grep "Cannot merge binary files" merge.err
 '
=20
diff --git a/t/t6027-merge-binary.sh b/t/t6027-merge-binary.sh
index b519626..da4ae21 100755
--- a/t/t6027-merge-binary.sh
+++ b/t/t6027-merge-binary.sh
@@ -6,7 +6,7 @@ test_description=3D'ask merge-recursive to merge binary=
 files'
=20
 test_expect_success setup '
=20
-	cat "$TEST_DIRECTORY"/test4012.png >m &&
+	cat "$TEST_DIRECTORY"/test-image1.png >m &&
 	git add m &&
 	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
 	test_tick &&
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index e5da65b..25b0550 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -50,8 +50,8 @@ test_expect_success \
     'mkdir A B C D E F &&
      echo hello1 >A/newfile1.txt &&
      echo hello2 >B/newfile2.txt &&
-     cp "$TEST_DIRECTORY"/test9200a.png C/newfile3.png &&
-     cp "$TEST_DIRECTORY"/test9200a.png D/newfile4.png &&
+     cp "$TEST_DIRECTORY"/test-image1.png C/newfile3.png &&
+     cp "$TEST_DIRECTORY"/test-image1.png D/newfile4.png &&
      git add A/newfile1.txt &&
      git add B/newfile2.txt &&
      git add C/newfile3.png &&
@@ -76,8 +76,8 @@ test_expect_success \
      rm -f B/newfile2.txt &&
      rm -f C/newfile3.png &&
      echo Hello5  >E/newfile5.txt &&
-     cp "$TEST_DIRECTORY"/test9200b.png D/newfile4.png &&
-     cp "$TEST_DIRECTORY"/test9200a.png F/newfile6.png &&
+     cp "$TEST_DIRECTORY"/test-image2.png D/newfile4.png &&
+     cp "$TEST_DIRECTORY"/test-image1.png F/newfile6.png &&
      git add E/newfile5.txt &&
      git add F/newfile6.png &&
      git commit -a -m "Test: Remove, add and update" &&
@@ -165,7 +165,7 @@ test_expect_success \
      'mkdir "G g" &&
       echo ok then >"G g/with spaces.txt" &&
       git add "G g/with spaces.txt" && \
-      cp "$TEST_DIRECTORY"/test9200a.png "G g/with spaces.png" && \
+      cp "$TEST_DIRECTORY"/test-image1.png "G g/with spaces.png" && \
       git add "G g/with spaces.png" &&
       git commit -a -m "With spaces" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
@@ -177,7 +177,7 @@ test_expect_success \
 test_expect_success \
      'Update file with spaces in file name' \
      'echo Ok then >>"G g/with spaces.txt" &&
-      cat "$TEST_DIRECTORY"/test9200a.png >>"G g/with spaces.png" && \
+      cat "$TEST_DIRECTORY"/test-image1.png >>"G g/with spaces.png" &&=
 \
       git add "G g/with spaces.png" &&
       git commit -a -m "Update with spaces" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
@@ -202,7 +202,7 @@ test_expect_success \
      'mkdir -p =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/=
w/x/y/z/=C3=A5/=C3=A4/=C3=B6 &&
       echo Foo >=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v=
/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt &&
       git add =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w=
/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt &&
-      cp "$TEST_DIRECTORY"/test9200a.png =C3=85/goo/a/b/c/d/e/f/g/h/i/=
j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5=
g=C3=A5rdet.png &&
+      cp "$TEST_DIRECTORY"/test-image1.png =C3=85/goo/a/b/c/d/e/f/g/h/=
i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=
=A5g=C3=A5rdet.png &&
       git add =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w=
/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png &&
       git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
diff --git a/t/test-image1.png b/t/test-image1.png
new file mode 100644
index 0000000000000000000000000000000000000000..7b181d15cebb4c86a6ad7fe=
d3dbf30ce2223b4c5
GIT binary patch
literal 5660
zcmYLNbyQSev>sqc34tLUx=3DXqS5RmRtN<wPrkWL9{q@{B}327LbK@p^5=3DmzPQ8brxA
zzqj66?~il$S$o~P?>T#adw*x2I9+WOA_7_h002OwrmCoqmhk@u9uE2`GlnCC7C6=3D#
zDvE$&03+ax@KXu}T7&PQYT^X|JZJfDVEBKL^+hXjz16goaObeGK-d!bT|z-<6`i+|
zvA2S|tE-)xH$cJD&dS@)meJ4A+kx?wgB_!anwIXVEt?wvKoO><DF4cT>7>Bb1@wA(
z;IT7g@ymCuJiLhbPfJr|i5H4;)mjji#JOK|U)hzPX8i5ho0BF*QXf6}{V_RmjX^h8
z<UC<RiCjbT`;XPXfXc<iSn-vLhFKEpI9JlruBDPLxZQHd3m5y<mZm0q=3Dy;cFU8sKL
z$#3sJkZ)cEM`n8vd(2LCTr$Q~PepkljJPoNR6GZ=3Dq4zuK_+^E=3DwSxmI6pMKeqYV<{
z;Dp=3D5CTs_NiDuN>BX9QX=3D3g&vi&AGE{oEKtLP%V(w6-2<2<D5q%|1kL_OIZYj^zEF
z^lGbNd)C|LtPp$aGXYL0tqO>(l+h-nm!Hmw@v)rNU2(v7(ZQ1OQ+h$~Qc!!FTf57o
zu@)h>i~DEs@uRKF6UyxAS&3G<*BiMjfLv_bQk;T##&v(4!pgG<+=3DYYE3cc(axf8D9
zEEhtoFt%jRU1M;}oLSBkd3UE+Bp6q6dcVEAvKKT8h56DsbkcsuTR<;ULeL+`fs<Se
zYZDYzJ7*bHRuSWn{?irogx9<mZ>ARWL=3DkI0d{qqjDcA8beq&VqMECGM`@nbtHGW~M
zVgSM};mmy>`nnA#(QCN?Baj(X%|*?D80!1maWLA8wjEi;G#0;OVGMoH)_Pcp$ery0
zjs>Q-gtJ$l@)T}w%&Z^$)Y2wNbTYowJmp2ztd9e|I_BXcEKR<=3DvvYxUi1R{eofw4(
zMn>91(?+TULadq}xsDau-@@Y(1<-!VbRi6SK0dN5AE40;n;cI&kg4VgwFoy&V_kkw
zMpno-g;(Q79&+8Y7g|7Mw8fTt*t^$t#3+Cmsj7Wxt-F|Tn&i!&)O9T_bFYg7{O{1~
zI_7r$E{te8LodhD-=3D41?TV6m!a2rR2BpX4tl@qt)kKy`LSmzZhS@=3D3dqH<2LSlS7G
zqexi>4h67BIPL)zq|QpF%1Wk*b481+X8bG9OE<0Rs)8KvheMithBa8p@K<lQQ<Hc1
z3ZnAEP3#oi(<*ki+A&;Pm`Wxq_N?X(gH7wtIGwlI)Q0J@n*tn#*}j;BiyaoAzMrwo
zbY=3DDg_&bOyq$K3--_gcD)8ccoGv}IlLqEQ=3Dpbb*Wm!#Zl(QoUnTeuJ<i(6SsfN>J!
zGDzAwDsJz>&;~0Po|7fsG|CN~p2KI)lJFfeqeau#ui)<nAYA+=3DC*b$F$!%O^(%vmr
z;#n^fz0XGr-dstyJ6Q6WXq^ffE!!>mq*Mu1LEyUtt@jB~KexY3_c>~fyvfggniw}&
zdnxRc9x^A~u&L>fk9SNr2W_yq%?ouL9vWra=3D|z6#ETbznso<Mc2x>0QZ}oTY6UA({
zEKp{AT0f&U=3DJusDJ>4v2y3=3DYUWi8TF4+O--;H0HrapHBQb&xgm4<K^t^y_Wo%G6_%
z>7GmLa9oPLK<}STSm3r&wP;{e>M5Rw?8<KR-J40>m00o*DjrM^O}oz3{S)!bHrKzY
z0mX3mj9w>xMA&MlpZ#5kr6mJqc$k~!{q)+=3Dp8+H^IsKyP_yxT@-(3;)n>-V`S0HRb
zlR^=3D$1Z8p$2-DBTEZtLK+Jcm4#FA*l=3D?r-&tiFI|%@DPtQGcF%BhI9jCYh~7Y8_3e
zz*{EaCZ757z09w~MrgKXoqIprKzuDd2A%jVh2yU%YJ1XdAO@X5Aic;6&cdcQBDAw(
zfwp;ITKp@*0Ecfb{qSjx^=3D2m9s`3^QxP7=3DJ8L3(4Hy1k~8fi-nL|CpGHiJUNgWVX*
z33>WWc7$DpSM{FI7{}rh2UR@~lR6n@Nu(SjKo3Oc3Rco%9Pw;4_y_MDEUA!kY4RT=3D
zMD*$LpKv0(5ME{59VMJ8tZ{FW?Q+63(tz)d-MK#sR+wAGSV{53?*fq}R*dn?nEF#g
zpQUJd=3Dw!*_7A&r}2#~y$XuH`Pn?59m6Cf%ML**0R0b6KxHeF&gk$#f$jWerg-j#r`
z<TkNLt4Hs58v7FJCL*v*ZwFCxgO&7c$V2IamRk}uxB?1xLUjBy=3DG_G&-83zZiQ7@u
zkk;Z|868p}#_8kwqYz?_Q<t|u?dbi-XgXzOKK9~({)99g=3D^_RpT;6MYzfq@t<yx$h
z@tD@o7%x`+JRf5=3DJ0fOjAMrvy2A{GDncK6hO7f)!YbTZ6zCjBeVG}%YD(7G<IH1Rj
zbZkLUi4e#be>iX4!S$h)0_asLcO!h;#k&=3DzOlbC|5s^-l!7<-}O<s<rmD|S^8dCaT
zR<*!EM(WK`lvbh{=3DL#j~aOK^|H0fNRnU^|*otSc2kEssQ=3D<9b}@4N+{WW>ZZ9^aA!
zhrGGI8ooJ)Pz<Lt#iTN+@#iBiS}Y3pX|R{ZQx&M3<mE)19^9S3;0A<Hs)R%7oQ}b1
za7yAXZ&huh%cn+prfM?K2#Aw{%I55@yp(iIMqW#2n36N|)}EJAquqyUV%0;gMyJj*
zi5Rw!Pp>8peMO>osg~`oBb5<fCSlxOzZZ>J0xBb4@h=3Dy1l7U9%b^2SYar^9#-f|;-
z^CdSO22=3DU$bMhUi#i^@|=3DHK{U4Y!X#^Ho~>4Ji>#n_MG9hstW!va&0K!Xr81VzkRS
zmq4hLdgQr}-WH1j&Z&Kt44MY>I($WF#~kF8Qh#N%dx+2~v62bG8HLfs`Q@Wb!GQ<;
zKoi*a=3DU^a0MiOqfc%DDx^<)XT*j|VHm_-T1z%Tear)ig;#fs;m^VAFM&?!VPWbdOW
zDy8emY;zOMaX<L`^-CVFOwH1iSrzh5K0R$>!No3-%XYAIk#M#nQ{;e)_@V<Q5H{yg
z(6e1Igh>`R6m}+^`pP|9G$>og=3D}k^lFBzgtP7a6BF605y6thdiZ7al`>^Wwe%VkXs
z9h>Dz^hXo%U@C=3D7Q-gQlAI4NwiN@p!H?}-w>kDLU4M@3EPj!-WYT6D;&>!G<ahM_C
zh|%+VA;*3{^@WvT(a<2v$*v)k)jV+GP7nwml)NV=3D1uBy3;c@Yow23`q_;xNA_BoZn
ztK-KwPcz-`Kzo}V0(l#%y`l%w6f^b24hiY_lI)hxna8%NTo-tFb-mT1sXM!{<`r3;
z`gH7FViNl;X}QLIWya)#xVA-2#it_k&f6;jv;Zy~xirSlQ$d(ffae+@idbs^(gZ#s
zA~`BPAH+JS4y0cWv2pXHC1n(tc{dmzp?^m;3FR1UBviWLDTS4zOQc9q#M{7uc;<vy
zyh%c<xNcng5Zbg=3Dvc{K$oPsp*$}U9@*<u#SI^!awI(4(UAUjXxvKC+7U8A?~!Qm$`
zC0=3D#~{V>5?z9DI(4ac#n<6Bdi6IDKX&u9K7hKy>Bzf;OZ1syrvwr`4W(X`5`PL3IV
zOeAwoaR^-2SRMcY8X6u|)m>be$Hhm!cj-H9=3Dd7D`?HLc17`z=3D(EsXf;F$g!tej_uq
zKDf1R433)i7*V^<J9fzzHqLQ5HYqj`bYr$!X8a0xn*Kbev!{t~vct|sE#6Z$P)<8}
z@~MJQV2aB<I45lUT4?n9LjRn@3}uCq5{6>VZGE}6>D)Diu*{FKV{+&i2H#7)(d738
zVcEP2dTA6M`i<7>!d6;_B(A8Ta<QKbstX=3DxAJ=3DTi{GE&r<djpI=3D|S7sCTwwzp>Lf=
w
zcVQh*4VYp$-qMp#gxC)qhkL~cIz=3D(KB?WH1ghU@ol|x>TaFC*~MpqPwVst29%e?Dw
zMF4~o`0fl9=3Dw|Zl$VcyH#E_9!AwP}RjgBRkhiQ@~GbkSEjB`l$%|0EUe}Jx}G23xM
z5(1j~<lWQg^0@^#o^dLpps1;f&o0qM6BlAYZ|xxF&CEqHPocH5)x9%pB)g6)TXCYQ
z`g0*J044x5)Jc&MSXH0v*opp4Vf#PL0~#J0+;U36J7sU?)KRq&04qt^;fzP`8M{d#
zwwUjgqSR(xC9nL~tDm}=3DHTPv;q{U6J#Z=3Do3aZl%UPR&V#g{yaIl#FuX%R<Pilty<&
z3Dinx|0is5JmMdUSfLOixm9RvXnNGMTum@9(46JQ7xRpqb4}@jH(gQ6NO@YS{Mz%*
zW<b>;T+mlPbv+GBo=3D14t>@4@t9`20!)uI#DHmUcfQF3pzlM6e!-sO{g8D=3DPlw5Y~v
zJ^5zy8&(4ae>PW6JWOVY&+d>7P|?VM9t!5ZOrmHOWH(GYk4->OkC@(92NG>4)4`oW
zXXm_(wv(k4??xN^=3DWJ;6JKV2cj7dl+$TbB@aB%o(2b^dMp7l*QpoEXi^Qii|mc#w{
z{5lkx4p-W+v^Ir>sQ;}h;^lj@9?CRCI!gDj6{{J%{Qth-|Jnl#E#{rbi-Nx_uuXtE
z<(}1UjeMj!<{$~~;Dv$Wc@Hr9hWzj4o*wE^Ac85csjmgY+>EsE$81!#Wma<9u(Xp2
z8KC%afHePiY^mR)0FHK&=3DeHNvQ5ljNm-V&^)R#^dl~<}AHz%s#g0T-0*H^LEVZ`fC
zzc-5i;B@BvoXJe1ud^)By(ARd^JGqMTZk*aNrWWSy+~dlU9++p_7pu0N1Ix~?btlW
zl>U3}4O&&jCr=3DBYSf%d!z@Ve@a|`=3D7hWWWa#@9!a$hR1Fe5!L4ym-YoMM{~)VnnF?
zF9F8q<04MjWPUaN_PGaVy&&YqGt3HCrU}i)34{3-5L2+icbeiX1Zi1zj%|=3D8;yAJX
zUT(r9S7nhfjfLBpQv@7HjT1N&Ent$no&E6winqTR&sYOU1J8El27`=3D%Cm4YnP6VQ=3D
z<0E)}(P4#_Dr-60T^~IL2)!#L<X(HR8okobiP3!*#*bu6z=3Dx(K=3Dn7v95TZukaGh#;
z>Qvt~#DLl0+^YXg1+lc2%T(RsGi2jgR3+Ika~0*%RSSu<27&D`xup+6<Z+cj#nmkI
zrkQr=3D^JTB)`wqkBjw6|ToZQ?$=3D4#&HJET2ctp%NKEHyj(U$6RcZ8NsB6k7HFOrRRL
zKdM3|T$v^PU;j1;^IxIx5ha0n-7-djS%*DSB#x%OX#73vC7E1XOFHeoC8m0ACdUc-
zF($tL@$k^8+Pss}$H&M2_N0{q;Ww5mY7BRnY%B8d^DAv`7TsE}s;P-$#EbsjfI!fh
zo14cDY^Af0=3DYR;J>VyAzu7p0`gFH1UP8J%l>bfon-ap>^t<J9oogyRxQTv~ZVtTF2
zI(=3DPNCd#z(qI-Hqd+S)W-oI}xd~vhSB7KjVE|ax!cIGMc-^AC61aHG!XVCA}hur#>
z%{%oRXW{Sc?^oEnXv-~sc3o~s{17l%qU7M>(uYMN9k$qHzjgQTQX=3D@TK#SXId^(4Y
zQ=3DkbTx3I3Mi9G1fG0nBGl3p=3Dqd}UC`VP(0lzJ5e)?emWxKYo7jy$NxstgnBH_O61t
zIb9UEz1pB$8}{`pHw9(21%j3#^iD87KAs)%=3DWw>lxYL*K&*{4Rkn?b3e#C^spu7oj
zTJ73@yB_shd58Pwc(D{;7yzQ6fHgN$w64FGqDlII=3DkUyX9|@be&J%Z6mZ%PG>4Q5?
z*9Tleg}@jmT4=3D|XciU?@)|j=3DY5vs@q87L?yRG!+8=3DMSL@X@sFE8+U}>etzP^!^66=
U
zhGOHTJ3pGC6NNPgHCLZA4jBL8?T6g{fwi_$ArOeasA(OqL(`Egew~nS&hyX9uIsy#
zw)KjqW9$&G`DHDRhB%5eL)NFJB8+*<ZUdF{kW*8eG@KU~4-hPyO??Rr8SJYCn`EoS
zMms>*#)eh3X)}S8-|u{Qi5LVDUm)dYJ^S@FH9h^G(R+U5`nP8G(@!SW0+0AUWo4Cq
z{tO%&8>?NHssSx+Z=3Dn6~0ga`6nIKA|TC<*}i5CfeYXP`CMzxwXp!W~|_Vy1Bth#?^
zS-y`Gb)Nf$I+*ULOJ`N{igJIr`{&^5`ZMHuwfy$M=3DV<N=3D!570C)2N%9z*nzd!_aZc
z;<xOtG$=3DniX<aX=3Dt8-tuwFtfUaapJj4;xp?$jD%#On|{)7#!O9000VwqQ>+ufj}UQ
zKdQ^8%XLaiOIdi3b=3D^1I#Prg!TLZ~9{{Gas#NhAYSh$V8oBjR$E7wRF8JUGnKmJ+^
z1cb|N=3DGh!{G&@{{Aq4b<>N)DJS*WtHk!(HqlBmUXIXW|wGGEG1`_gA;XUBgdit21i
zga5#yuC|t#A@~gA{l6V51J`#We60er=3DKn#Wv=3Dplj@rTy;ctNmoi62|%{fpn-w{FrX
zq=3DIp)8=3DYI{iP(I23nH_$s|zf9k4mr1<KgFL$Qr*mY&HfZ54^kk`!4wL{#qjRL7ISo
zz++lV-0EQJi*c8~AXywRqG$UPJBYxfaODD>-dP@~eLXa6wvuHZ<mBZscE|E!hKJQx
z0`>~B#l~_tU;$;ppZ1<R)>$Mta*j@@`1pu^t*R0YEn1W3=3DH`|rhoJNR$<@_WMP1#s
zQiZ(~GKPeqzdPjC<KM-OnnEY!^OFbx$CxMx{C30CaCUt?d9N_Y%`7t#4K{Q&iABfN
z<kIipSN$icz$??h4*zrJrKP2_qq=3DX}>dQnVB&BtABt;>AXmD_F^tqa}^2A7UKJA>9
zIXOA$n<Tk#^YQ)c`G70vJjW}PuQvH3e$0BY5JVhvzL~&Zf=3D*|2lx;;WkZZG4mcikO
zplheH<1(G1r1*G(*pk?9_b2YQys}ty1W_X2CcZdhe9xEkI=3Dj1^Aa`u1_Y@HkLHF07
zCzQP3S(2sG(&w4Am`KcDzm8g4Tg&gJjAM^tB}0=3DW4G!c*HluT@897hrs2s@^Ig<6d
zZ<s+CiFUoZAzM4U;X`)#??<c1YIRSo|1IoT_^3x!-E_0Ce*>h1L>|PFfM4D!`PCYp
zX3A~CK=3D0EBtH$R;?`Ss0pCYk1RL+-4FQ!=3DcP|K+jXcAq*5&?LNk)&m)B@J=3D9M~A<=
-
zzQPM!;zThn))lr`<=3D+POSrlXZs^a_57MO|t?AH70n6rDyTAEe>8}%y+X#MC#Q9AE<
zmC|QfI-ed)WT7g71*Z)J2VK&d6!n=3D8taU*pX6gw=3D0Qq;@kcWHj04FlpiMvyyy3K8l
zc`eIc&wu+vI<;HKB_5DLI`6<}%$!97P?)NC_H4_N#Io!dcj!~#QuKLU41XT6@YK)X
z7P_ik-m%^^BCF9V7|{-E$h|LX()h0YbH-&H_*XPzQr152yXy%4^lDe{C>6l^BvIS1
zZ?ZFV0ZCANBv;P!3M@CYDLvXH8mp@Y__qOQJ_hLp3xvZSfDd;8pnKVRqp<*5^i?L;
wB)iFf!5~HcZ%ohvO_R*UYX6BwgGUmE)3jjAGZHKGr7b{BNn5e@<=3Dcq=3D0b0Y+i2wiq

literal 0
HcmV?d00001

diff --git a/t/test-image2.png b/t/test-image2.png
new file mode 100644
index 0000000000000000000000000000000000000000..ac22ccbd3ee9f03a3b38249=
ac8efdbe96b5da2cd
GIT binary patch
literal 275
zcmeAS@N?(olHy`uVBq!ia0vp^9zZP3!VDyJZ(h*_aRPioToo7?5)xuJtY5{@z;N#D
z@dFGDFJ3(R{{7qk|No7uYm$J<7)yfuf*Bm1-ADs*lDyqr7&=3D&GL8fsQctjR6FmMZl
zFeAgPITAoY_7YEDSN3bH%%X-S`j4JZ016d)x;TbtoKN<6ufXCZA)&>gl@*-uLV<^+
zZOfu-7cOu}w0W9H3$HwJqlx472Q4Ervph31wm>lpQB&rr2^-hlWNOq5Vkv20<q=3D-Z
z@v30LY2AXTcBx4_L=3DO5$-0^JfxTAF7fm=3DY}A_nHk3XTg7IPfqqTq@aCrp)Sh2xvKj
Mr>mdKI;Vst05+voj{pDw

literal 0
HcmV?d00001

diff --git a/t/test4012.png b/t/test4012.png
deleted file mode 100644
index 7b181d15cebb4c86a6ad7fed3dbf30ce2223b4c5..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 5660
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
w
zcVQh*4VYp$-qMp#gxC)qhkL~cIz=3D(KB?WH1ghU@ol|x>TaFC*~MpqPwVst29%e?Dw
zMF4~o`0fl9=3Dw|Zl$VcyH#E_9!AwP}RjgBRkhiQ@~GbkSEjB`l$%|0EUe}Jx}G23xM
z5(1j~<lWQg^0@^#o^dLpps1;f&o0qM6BlAYZ|xxF&CEqHPocH5)x9%pB)g6)TXCYQ
z`g0*J044x5)Jc&MSXH0v*opp4Vf#PL0~#J0+;U36J7sU?)KRq&04qt^;fzP`8M{d#
zwwUjgqSR(xC9nL~tDm}=3DHTPv;q{U6J#Z=3Do3aZl%UPR&V#g{yaIl#FuX%R<Pilty<&
z3Dinx|0is5JmMdUSfLOixm9RvXnNGMTum@9(46JQ7xRpqb4}@jH(gQ6NO@YS{Mz%*
zW<b>;T+mlPbv+GBo=3D14t>@4@t9`20!)uI#DHmUcfQF3pzlM6e!-sO{g8D=3DPlw5Y~v
zJ^5zy8&(4ae>PW6JWOVY&+d>7P|?VM9t!5ZOrmHOWH(GYk4->OkC@(92NG>4)4`oW
zXXm_(wv(k4??xN^=3DWJ;6JKV2cj7dl+$TbB@aB%o(2b^dMp7l*QpoEXi^Qii|mc#w{
z{5lkx4p-W+v^Ir>sQ;}h;^lj@9?CRCI!gDj6{{J%{Qth-|Jnl#E#{rbi-Nx_uuXtE
z<(}1UjeMj!<{$~~;Dv$Wc@Hr9hWzj4o*wE^Ac85csjmgY+>EsE$81!#Wma<9u(Xp2
z8KC%afHePiY^mR)0FHK&=3DeHNvQ5ljNm-V&^)R#^dl~<}AHz%s#g0T-0*H^LEVZ`fC
zzc-5i;B@BvoXJe1ud^)By(ARd^JGqMTZk*aNrWWSy+~dlU9++p_7pu0N1Ix~?btlW
zl>U3}4O&&jCr=3DBYSf%d!z@Ve@a|`=3D7hWWWa#@9!a$hR1Fe5!L4ym-YoMM{~)VnnF?
zF9F8q<04MjWPUaN_PGaVy&&YqGt3HCrU}i)34{3-5L2+icbeiX1Zi1zj%|=3D8;yAJX
zUT(r9S7nhfjfLBpQv@7HjT1N&Ent$no&E6winqTR&sYOU1J8El27`=3D%Cm4YnP6VQ=3D
z<0E)}(P4#_Dr-60T^~IL2)!#L<X(HR8okobiP3!*#*bu6z=3Dx(K=3Dn7v95TZukaGh#;
z>Qvt~#DLl0+^YXg1+lc2%T(RsGi2jgR3+Ika~0*%RSSu<27&D`xup+6<Z+cj#nmkI
zrkQr=3D^JTB)`wqkBjw6|ToZQ?$=3D4#&HJET2ctp%NKEHyj(U$6RcZ8NsB6k7HFOrRRL
zKdM3|T$v^PU;j1;^IxIx5ha0n-7-djS%*DSB#x%OX#73vC7E1XOFHeoC8m0ACdUc-
zF($tL@$k^8+Pss}$H&M2_N0{q;Ww5mY7BRnY%B8d^DAv`7TsE}s;P-$#EbsjfI!fh
zo14cDY^Af0=3DYR;J>VyAzu7p0`gFH1UP8J%l>bfon-ap>^t<J9oogyRxQTv~ZVtTF2
zI(=3DPNCd#z(qI-Hqd+S)W-oI}xd~vhSB7KjVE|ax!cIGMc-^AC61aHG!XVCA}hur#>
z%{%oRXW{Sc?^oEnXv-~sc3o~s{17l%qU7M>(uYMN9k$qHzjgQTQX=3D@TK#SXId^(4Y
zQ=3DkbTx3I3Mi9G1fG0nBGl3p=3Dqd}UC`VP(0lzJ5e)?emWxKYo7jy$NxstgnBH_O61t
zIb9UEz1pB$8}{`pHw9(21%j3#^iD87KAs)%=3DWw>lxYL*K&*{4Rkn?b3e#C^spu7oj
zTJ73@yB_shd58Pwc(D{;7yzQ6fHgN$w64FGqDlII=3DkUyX9|@be&J%Z6mZ%PG>4Q5?
z*9Tleg}@jmT4=3D|XciU?@)|j=3DY5vs@q87L?yRG!+8=3DMSL@X@sFE8+U}>etzP^!^66=
U
zhGOHTJ3pGC6NNPgHCLZA4jBL8?T6g{fwi_$ArOeasA(OqL(`Egew~nS&hyX9uIsy#
zw)KjqW9$&G`DHDRhB%5eL)NFJB8+*<ZUdF{kW*8eG@KU~4-hPyO??Rr8SJYCn`EoS
zMms>*#)eh3X)}S8-|u{Qi5LVDUm)dYJ^S@FH9h^G(R+U5`nP8G(@!SW0+0AUWo4Cq
z{tO%&8>?NHssSx+Z=3Dn6~0ga`6nIKA|TC<*}i5CfeYXP`CMzxwXp!W~|_Vy1Bth#?^
zS-y`Gb)Nf$I+*ULOJ`N{igJIr`{&^5`ZMHuwfy$M=3DV<N=3D!570C)2N%9z*nzd!_aZc
z;<xOtG$=3DniX<aX=3Dt8-tuwFtfUaapJj4;xp?$jD%#On|{)7#!O9000VwqQ>+ufj}UQ
zKdQ^8%XLaiOIdi3b=3D^1I#Prg!TLZ~9{{Gas#NhAYSh$V8oBjR$E7wRF8JUGnKmJ+^
z1cb|N=3DGh!{G&@{{Aq4b<>N)DJS*WtHk!(HqlBmUXIXW|wGGEG1`_gA;XUBgdit21i
zga5#yuC|t#A@~gA{l6V51J`#We60er=3DKn#Wv=3Dplj@rTy;ctNmoi62|%{fpn-w{FrX
zq=3DIp)8=3DYI{iP(I23nH_$s|zf9k4mr1<KgFL$Qr*mY&HfZ54^kk`!4wL{#qjRL7ISo
zz++lV-0EQJi*c8~AXywRqG$UPJBYxfaODD>-dP@~eLXa6wvuHZ<mBZscE|E!hKJQx
z0`>~B#l~_tU;$;ppZ1<R)>$Mta*j@@`1pu^t*R0YEn1W3=3DH`|rhoJNR$<@_WMP1#s
zQiZ(~GKPeqzdPjC<KM-OnnEY!^OFbx$CxMx{C30CaCUt?d9N_Y%`7t#4K{Q&iABfN
z<kIipSN$icz$??h4*zrJrKP2_qq=3DX}>dQnVB&BtABt;>AXmD_F^tqa}^2A7UKJA>9
zIXOA$n<Tk#^YQ)c`G70vJjW}PuQvH3e$0BY5JVhvzL~&Zf=3D*|2lx;;WkZZG4mcikO
zplheH<1(G1r1*G(*pk?9_b2YQys}ty1W_X2CcZdhe9xEkI=3Dj1^Aa`u1_Y@HkLHF07
zCzQP3S(2sG(&w4Am`KcDzm8g4Tg&gJjAM^tB}0=3DW4G!c*HluT@897hrs2s@^Ig<6d
zZ<s+CiFUoZAzM4U;X`)#??<c1YIRSo|1IoT_^3x!-E_0Ce*>h1L>|PFfM4D!`PCYp
zX3A~CK=3D0EBtH$R;?`Ss0pCYk1RL+-4FQ!=3DcP|K+jXcAq*5&?LNk)&m)B@J=3D9M~A<=
-
zzQPM!;zThn))lr`<=3D+POSrlXZs^a_57MO|t?AH70n6rDyTAEe>8}%y+X#MC#Q9AE<
zmC|QfI-ed)WT7g71*Z)J2VK&d6!n=3D8taU*pX6gw=3D0Qq;@kcWHj04FlpiMvyyy3K8l
zc`eIc&wu+vI<;HKB_5DLI`6<}%$!97P?)NC_H4_N#Io!dcj!~#QuKLU41XT6@YK)X
z7P_ik-m%^^BCF9V7|{-E$h|LX()h0YbH-&H_*XPzQr152yXy%4^lDe{C>6l^BvIS1
zZ?ZFV0ZCANBv;P!3M@CYDLvXH8mp@Y__qOQJ_hLp3xvZSfDd;8pnKVRqp<*5^i?L;
wB)iFf!5~HcZ%ohvO_R*UYX6BwgGUmE)3jjAGZHKGr7b{BNn5e@<=3Dcq=3D0b0Y+i2wiq

diff --git a/t/test9200a.png b/t/test9200a.png
deleted file mode 100644
index 7b181d15cebb4c86a6ad7fed3dbf30ce2223b4c5..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 5660
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
w
zcVQh*4VYp$-qMp#gxC)qhkL~cIz=3D(KB?WH1ghU@ol|x>TaFC*~MpqPwVst29%e?Dw
zMF4~o`0fl9=3Dw|Zl$VcyH#E_9!AwP}RjgBRkhiQ@~GbkSEjB`l$%|0EUe}Jx}G23xM
z5(1j~<lWQg^0@^#o^dLpps1;f&o0qM6BlAYZ|xxF&CEqHPocH5)x9%pB)g6)TXCYQ
z`g0*J044x5)Jc&MSXH0v*opp4Vf#PL0~#J0+;U36J7sU?)KRq&04qt^;fzP`8M{d#
zwwUjgqSR(xC9nL~tDm}=3DHTPv;q{U6J#Z=3Do3aZl%UPR&V#g{yaIl#FuX%R<Pilty<&
z3Dinx|0is5JmMdUSfLOixm9RvXnNGMTum@9(46JQ7xRpqb4}@jH(gQ6NO@YS{Mz%*
zW<b>;T+mlPbv+GBo=3D14t>@4@t9`20!)uI#DHmUcfQF3pzlM6e!-sO{g8D=3DPlw5Y~v
zJ^5zy8&(4ae>PW6JWOVY&+d>7P|?VM9t!5ZOrmHOWH(GYk4->OkC@(92NG>4)4`oW
zXXm_(wv(k4??xN^=3DWJ;6JKV2cj7dl+$TbB@aB%o(2b^dMp7l*QpoEXi^Qii|mc#w{
z{5lkx4p-W+v^Ir>sQ;}h;^lj@9?CRCI!gDj6{{J%{Qth-|Jnl#E#{rbi-Nx_uuXtE
z<(}1UjeMj!<{$~~;Dv$Wc@Hr9hWzj4o*wE^Ac85csjmgY+>EsE$81!#Wma<9u(Xp2
z8KC%afHePiY^mR)0FHK&=3DeHNvQ5ljNm-V&^)R#^dl~<}AHz%s#g0T-0*H^LEVZ`fC
zzc-5i;B@BvoXJe1ud^)By(ARd^JGqMTZk*aNrWWSy+~dlU9++p_7pu0N1Ix~?btlW
zl>U3}4O&&jCr=3DBYSf%d!z@Ve@a|`=3D7hWWWa#@9!a$hR1Fe5!L4ym-YoMM{~)VnnF?
zF9F8q<04MjWPUaN_PGaVy&&YqGt3HCrU}i)34{3-5L2+icbeiX1Zi1zj%|=3D8;yAJX
zUT(r9S7nhfjfLBpQv@7HjT1N&Ent$no&E6winqTR&sYOU1J8El27`=3D%Cm4YnP6VQ=3D
z<0E)}(P4#_Dr-60T^~IL2)!#L<X(HR8okobiP3!*#*bu6z=3Dx(K=3Dn7v95TZukaGh#;
z>Qvt~#DLl0+^YXg1+lc2%T(RsGi2jgR3+Ika~0*%RSSu<27&D`xup+6<Z+cj#nmkI
zrkQr=3D^JTB)`wqkBjw6|ToZQ?$=3D4#&HJET2ctp%NKEHyj(U$6RcZ8NsB6k7HFOrRRL
zKdM3|T$v^PU;j1;^IxIx5ha0n-7-djS%*DSB#x%OX#73vC7E1XOFHeoC8m0ACdUc-
zF($tL@$k^8+Pss}$H&M2_N0{q;Ww5mY7BRnY%B8d^DAv`7TsE}s;P-$#EbsjfI!fh
zo14cDY^Af0=3DYR;J>VyAzu7p0`gFH1UP8J%l>bfon-ap>^t<J9oogyRxQTv~ZVtTF2
zI(=3DPNCd#z(qI-Hqd+S)W-oI}xd~vhSB7KjVE|ax!cIGMc-^AC61aHG!XVCA}hur#>
z%{%oRXW{Sc?^oEnXv-~sc3o~s{17l%qU7M>(uYMN9k$qHzjgQTQX=3D@TK#SXId^(4Y
zQ=3DkbTx3I3Mi9G1fG0nBGl3p=3Dqd}UC`VP(0lzJ5e)?emWxKYo7jy$NxstgnBH_O61t
zIb9UEz1pB$8}{`pHw9(21%j3#^iD87KAs)%=3DWw>lxYL*K&*{4Rkn?b3e#C^spu7oj
zTJ73@yB_shd58Pwc(D{;7yzQ6fHgN$w64FGqDlII=3DkUyX9|@be&J%Z6mZ%PG>4Q5?
z*9Tleg}@jmT4=3D|XciU?@)|j=3DY5vs@q87L?yRG!+8=3DMSL@X@sFE8+U}>etzP^!^66=
U
zhGOHTJ3pGC6NNPgHCLZA4jBL8?T6g{fwi_$ArOeasA(OqL(`Egew~nS&hyX9uIsy#
zw)KjqW9$&G`DHDRhB%5eL)NFJB8+*<ZUdF{kW*8eG@KU~4-hPyO??Rr8SJYCn`EoS
zMms>*#)eh3X)}S8-|u{Qi5LVDUm)dYJ^S@FH9h^G(R+U5`nP8G(@!SW0+0AUWo4Cq
z{tO%&8>?NHssSx+Z=3Dn6~0ga`6nIKA|TC<*}i5CfeYXP`CMzxwXp!W~|_Vy1Bth#?^
zS-y`Gb)Nf$I+*ULOJ`N{igJIr`{&^5`ZMHuwfy$M=3DV<N=3D!570C)2N%9z*nzd!_aZc
z;<xOtG$=3DniX<aX=3Dt8-tuwFtfUaapJj4;xp?$jD%#On|{)7#!O9000VwqQ>+ufj}UQ
zKdQ^8%XLaiOIdi3b=3D^1I#Prg!TLZ~9{{Gas#NhAYSh$V8oBjR$E7wRF8JUGnKmJ+^
z1cb|N=3DGh!{G&@{{Aq4b<>N)DJS*WtHk!(HqlBmUXIXW|wGGEG1`_gA;XUBgdit21i
zga5#yuC|t#A@~gA{l6V51J`#We60er=3DKn#Wv=3Dplj@rTy;ctNmoi62|%{fpn-w{FrX
zq=3DIp)8=3DYI{iP(I23nH_$s|zf9k4mr1<KgFL$Qr*mY&HfZ54^kk`!4wL{#qjRL7ISo
zz++lV-0EQJi*c8~AXywRqG$UPJBYxfaODD>-dP@~eLXa6wvuHZ<mBZscE|E!hKJQx
z0`>~B#l~_tU;$;ppZ1<R)>$Mta*j@@`1pu^t*R0YEn1W3=3DH`|rhoJNR$<@_WMP1#s
zQiZ(~GKPeqzdPjC<KM-OnnEY!^OFbx$CxMx{C30CaCUt?d9N_Y%`7t#4K{Q&iABfN
z<kIipSN$icz$??h4*zrJrKP2_qq=3DX}>dQnVB&BtABt;>AXmD_F^tqa}^2A7UKJA>9
zIXOA$n<Tk#^YQ)c`G70vJjW}PuQvH3e$0BY5JVhvzL~&Zf=3D*|2lx;;WkZZG4mcikO
zplheH<1(G1r1*G(*pk?9_b2YQys}ty1W_X2CcZdhe9xEkI=3Dj1^Aa`u1_Y@HkLHF07
zCzQP3S(2sG(&w4Am`KcDzm8g4Tg&gJjAM^tB}0=3DW4G!c*HluT@897hrs2s@^Ig<6d
zZ<s+CiFUoZAzM4U;X`)#??<c1YIRSo|1IoT_^3x!-E_0Ce*>h1L>|PFfM4D!`PCYp
zX3A~CK=3D0EBtH$R;?`Ss0pCYk1RL+-4FQ!=3DcP|K+jXcAq*5&?LNk)&m)B@J=3D9M~A<=
-
zzQPM!;zThn))lr`<=3D+POSrlXZs^a_57MO|t?AH70n6rDyTAEe>8}%y+X#MC#Q9AE<
zmC|QfI-ed)WT7g71*Z)J2VK&d6!n=3D8taU*pX6gw=3D0Qq;@kcWHj04FlpiMvyyy3K8l
zc`eIc&wu+vI<;HKB_5DLI`6<}%$!97P?)NC_H4_N#Io!dcj!~#QuKLU41XT6@YK)X
z7P_ik-m%^^BCF9V7|{-E$h|LX()h0YbH-&H_*XPzQr152yXy%4^lDe{C>6l^BvIS1
zZ?ZFV0ZCANBv;P!3M@CYDLvXH8mp@Y__qOQJ_hLp3xvZSfDd;8pnKVRqp<*5^i?L;
wB)iFf!5~HcZ%ohvO_R*UYX6BwgGUmE)3jjAGZHKGr7b{BNn5e@<=3Dcq=3D0b0Y+i2wiq

diff --git a/t/test9200b.png b/t/test9200b.png
deleted file mode 100644
index ac22ccbd3ee9f03a3b38249ac8efdbe96b5da2cd..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 275
zcmeAS@N?(olHy`uVBq!ia0vp^9zZP3!VDyJZ(h*_aRPioToo7?5)xuJtY5{@z;N#D
z@dFGDFJ3(R{{7qk|No7uYm$J<7)yfuf*Bm1-ADs*lDyqr7&=3D&GL8fsQctjR6FmMZl
zFeAgPITAoY_7YEDSN3bH%%X-S`j4JZ016d)x;TbtoKN<6ufXCZA)&>gl@*-uLV<^+
zZOfu-7cOu}w0W9H3$HwJqlx472Q4Ervph31wm>lpQB&rr2^-hlWNOq5Vkv20<q=3D-Z
z@v30LY2AXTcBx4_L=3DO5$-0^JfxTAF7fm=3DY}A_nHk3XTg7IPfqqTq@aCrp)Sh2xvKj
Mr>mdKI;Vst05+voj{pDw

--=20
1.7.0.4
