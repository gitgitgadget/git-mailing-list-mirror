From: tboegi@web.de
Subject: [PATCH v2 4/7] t0027: TC for combined attributes
Date: Fri,  1 Apr 2016 18:08:28 +0200
Message-ID: <1459526908-19907-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 18:05:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1Zy-0006WA-8C
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbcDAQFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 12:05:35 -0400
Received: from mout.web.de ([212.227.17.12]:61628 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbcDAQFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:05:33 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MF3jD-1aWMX81CXL-00GHaD; Fri, 01 Apr 2016 18:05:25
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:KkDZfwrQUUv1c1BB7wvtRrW+Ldno+3XA5wQ7YIH1EYCZitiQdDM
 Woj7vmOcNVwjeZaWHBMwl2UA5eSKvzJ1FjYeg42UjBDEJ3jr1IfiMPmTAPaRzdo40b7kuAg
 xnXM0ufNBvM013EPppacR/CKf64mHSGPi6ULpTkzs3ywdDCJVcnHQhnakQloWU5WqSdyWCl
 YOHdzvfrCDitoN1QjF/2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RNsGAAna3Q4=:oWmoKhr96f1nOrmhJjuU+J
 oCKk3h3Ncc3Cb8qaoTRM4rH2tywCHMCZAc2ngEdtJs/m5yjeyhY5DockjebTGAWkxgRLgHn1F
 CHhaBWqBFNSfIMXA1Ku2D/hFoRV28k+jAulmou8QxQ4wCI9u9UQ5Ek7R0mMIilcbmsm0WMDLK
 mhyodAjguITdZBl+TOQq+pcKhL5mmhcSBt+F3qI9Q2OUqBN0ospAsyf2wWfYiEZzES1J3wLrc
 7oEYnaqY4+5dTSi78vA9YiNrsy9pU1hmlU2VJQAZ0btlQF7FmTCWyhKZGOrmKOzkz/ppYcROg
 mgGKNMy5CYl/YIae/gSBrovap+OYdGLbJ5ZguaNNfX184rihg3LbQqLpwaKF536xnoh+noni2
 PjUH6RX21ZojmpdrPda89kWJ/I9zAd+TGjFVJ0rYw1JH8wInbdTIWZWWk8yCuxC43HANSkUNW
 FuZADnM8mFZE3CV2FSL7zdH5pPU81IjhlApg3w83YR+pU1x98yjt7RVwxmIO0ZRxF7YpzW1mU
 LciUuDybisltiOGZ42ZlT6YlncorqzqoPgXb3uFvfWc2untoStuqwS0/A9a+lL0eHoMZQGn6Y
 39/z8cQC5jsQMaxMP/ymkeuDBzsw8hWccZVinGCP6iHGbPvkQTkvyqbg/FryxShEf18tmg+bv
 Rjnze2XhP8fpNNV2usSrahbGt0A41SR6jCirXgWmA0NErTQ+3kASc9pIIqr+0YPuTSqtXUR9c
 b/PCQHdLRzhadKXyo4sBAP5alJjHBAuSKTUVD/onAl6AuMMcCeroKCy3yHxfXgW2q2Ue+s/e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290552>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Add more test cases for the not normalized files ("NNO").
The  "text" attribute is most important, use it as the first parameter.
"ident", if set, is the second paramater followed by the eol attribute.
The eol attribute overrides core.autocrlf, which overrides core.eol.

Use loops to test more combinations of attributes, like
"* text eol=3Dcrlf" or especially "*text=3Dauto eol=3Dcrlf".

Currently "* text=3Dauto eol=3Dlf" does the same as "* text eol=3Dlf", =
as the
eol attribute overrides "text=3Dauto", this will change in future.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 321 +++++++++++++++++++++++++------------------=
--------
 1 file changed, 158 insertions(+), 163 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index f33962b..55f45d3 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -52,14 +52,17 @@ create_gitattributes () {
 create_NNO_files () {
 	for crlf in false true input
 	do
-		for attr in "" auto text -text lf crlf
+		for attr in "" auto text -text
 		do
-			pfx=3DNNO_${crlf}_attr_${attr} &&
-			cp CRLF_mix_LF ${pfx}_LF.txt &&
-			cp CRLF_mix_LF ${pfx}_CRLF.txt &&
-			cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
-			cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
-			cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
+			for aeol in "" lf crlf
+			do
+				pfx=3DNNO_attr_${attr}_aeol_${aeol}_${crlf}
+				cp CRLF_mix_LF ${pfx}_LF.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
+				cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
+			done
 		done
 	done
 }
@@ -100,16 +103,17 @@ commit_check_warn () {
 }
=20
 commit_chk_wrnNNO () {
-	crlf=3D$1
-	attr=3D$2
-	lfwarn=3D$3
-	crlfwarn=3D$4
-	lfmixcrlf=3D$5
-	lfmixcr=3D$6
-	crlfnul=3D$7
-	pfx=3DNNO_${crlf}_attr_${attr}
+	attr=3D$1 ; shift
+	aeol=3D$1 ; shift
+	crlf=3D$1 ; shift
+	lfwarn=3D$1 ; shift
+	crlfwarn=3D$1 ; shift
+	lfmixcrlf=3D$1 ; shift
+	lfmixcr=3D$1 ; shift
+	crlfnul=3D$1 ; shift
+	pfx=3DNNO_attr_${attr}_aeol_${aeol}_${crlf}
 	#Commit files on top of existing file
-	create_gitattributes "$attr" &&
+	create_gitattributes "$attr" $aeol &&
 	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
@@ -121,19 +125,19 @@ commit_chk_wrnNNO () {
 	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF" '
 		check_warning "$lfwarn" ${pfx}_LF.err
 	'
-	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF"=
 '
+	test_expect_success "commit NNO files attr=3D$attr aeol=3D$aeol crlf=3D=
$crlf CRLF" '
 		check_warning "$crlfwarn" ${pfx}_CRLF.err
 	'
=20
-	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF_=
mix_LF" '
+	test_expect_success "commit NNO files attr=3D$attr aeol=3D$aeol crlf=3D=
$crlf CRLF_mix_LF" '
 		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
 	'
=20
-	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF_mi=
x_cr" '
+	test_expect_success "commit NNO files attr=3D$attr aeol=3D$aeol crlf=3D=
$crlf LF_mix_cr" '
 		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
 	'
=20
-	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF_=
nul" '
+	test_expect_success "commit NNO files attr=3D$attr aeol=3D$aeol crlf=3D=
$crlf CRLF_nul" '
 		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 	'
 }
@@ -162,6 +166,7 @@ stats_ascii () {
=20
 # contruct the attr/ returned by git ls-files --eol
 # Take none (=3Dempty), one or two args
+# convert.c: eol=3DXX overrides text=3Dauto
 attr_ascii () {
 	case $1,$2 in
 	-text,*)   echo "-text" ;;
@@ -169,8 +174,8 @@ attr_ascii () {
 	text,lf)   echo "text eol=3Dlf" ;;
 	text,crlf) echo "text eol=3Dcrlf" ;;
 	auto,)     echo "text=3Dauto" ;;
-	auto,lf)   echo "text=3Dauto eol=3Dlf" ;;
-	auto,crlf) echo "text=3Dauto eol=3Dcrlf" ;;
+	auto,lf)   echo "text eol=3Dlf" ;;
+	auto,crlf) echo "text eol=3Dcrlf" ;;
 	lf,)       echo "text eol=3Dlf" ;;
 	crlf,)     echo "text eol=3Dcrlf" ;;
 	,) echo "" ;;
@@ -195,28 +200,29 @@ check_files_in_repo () {
 }
=20
 check_in_repo_NNO () {
-	crlf=3D$1
-	attr=3D$2
-	lfname=3D$3
-	crlfname=3D$4
-	lfmixcrlf=3D$5
-	lfmixcr=3D$6
-	crlfnul=3D$7
-	pfx=3DNNO_${crlf}_attr_${attr}_
-	test_expect_success "compare_files $lfname ${pfx}LF.txt" '
-		compare_files $lfname ${pfx}LF.txt
+	attr=3D$1 ; shift
+	aeol=3D$1 ; shift
+	crlf=3D$1 ; shift
+	lfname=3D$1 ; shift
+	crlfname=3D$1 ; shift
+	lfmixcrlf=3D$1 ; shift
+	lfmixcr=3D$1 ; shift
+	crlfnul=3D$1 ; shift
+	pfx=3DNNO_attr_${attr}_aeol_${aeol}_${crlf}
+	test_expect_success "compare_files $lfname ${pfx}_LF.txt" '
+		compare_files $lfname ${pfx}_LF.txt
 	'
-	test_expect_success "compare_files $crlfname ${pfx}CRLF.txt" '
-		compare_files $crlfname ${pfx}CRLF.txt
+	test_expect_success "compare_files $crlfname ${pfx}_CRLF.txt" '
+		compare_files $crlfname ${pfx}_CRLF.txt
 	'
-	test_expect_success "compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt" =
'
-		compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt
+	test_expect_success "compare_files $lfmixcrlf ${pfx}_CRLF_mix_LF.txt"=
 '
+		compare_files $lfmixcrlf ${pfx}_CRLF_mix_LF.txt
 	'
-	test_expect_success "compare_files $lfmixcr ${pfx}LF_mix_CR.txt" '
-		compare_files $lfmixcr ${pfx}LF_mix_CR.txt
+	test_expect_success "compare_files $lfmixcr ${pfx}_LF_mix_CR.txt" '
+		compare_files $lfmixcr ${pfx}_LF_mix_CR.txt
 	'
-	test_expect_success "compare_files $crlfnul ${pfx}CRLF_nul.txt" '
-		compare_files $crlfnul ${pfx}CRLF_nul.txt
+	test_expect_success "compare_files $crlfnul ${pfx}_CRLF_nul.txt" '
+		compare_files $crlfnul ${pfx}_CRLF_nul.txt
 	'
 }
=20
@@ -231,7 +237,7 @@ checkout_files () {
 	lfmixcrlf=3D$1 ; shift
 	lfmixcr=3D$1 ; shift
 	crlfnul=3D$1 ; shift
-	create_gitattributes "$attr" "$ident" &&
+	create_gitattributes "$attr" $ident $aeol &&
 	git config core.autocrlf $crlf &&
 	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
@@ -244,7 +250,7 @@ checkout_files () {
 		fi
 	done
=20
-	test_expect_success "ls-files --eol attr=3D$attr $ident $aeol core.au=
tocrlf=3D$crlf core.eol=3D$ceol" '
+	test_expect_success "ls-files --eol attr=3D$attr $ident aeol=3D$aeol =
core.autocrlf=3D$crlf core.eol=3D$ceol" '
 		test_when_finished "rm expect actual" &&
 		sort <<-EOF >expect &&
 		i/crlf w/$(stats_ascii $crlfname) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__CRLF.txt
@@ -385,31 +391,31 @@ test_expect_success 'commit files attr=3Dcrlf' '
 	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
 '
=20
-#                       attr   LF        CRLF      CRLFmixLF 	 LF_mix_=
CR   CRLFNUL
-commit_chk_wrnNNO false ""     ""        ""        ""        	 ""     =
   	 ""
-commit_chk_wrnNNO true  ""     "LF_CRLF" ""        ""        	 ""     =
   	 ""
-commit_chk_wrnNNO input ""     ""        ""        ""        	 ""     =
   	 ""
-
+#                 attr                    LF        CRLF      CRLFmixL=
=46   LF_mix_CR   CRLFNUL
+commit_chk_wrnNNO ""      ""      false   ""        ""        ""      =
    ""          ""
+commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""      =
    ""          ""
+commit_chk_wrnNNO ""      ""      input   ""        ""        ""      =
    ""          ""
=20
-commit_chk_wrnNNO false "auto" "$WILC"   "$WICL"   "$WAMIX"  	 ""     =
   	 ""
-commit_chk_wrnNNO true  "auto" "LF_CRLF" ""        "LF_CRLF" 	 ""     =
   	 ""
-commit_chk_wrnNNO input "auto" ""        "CRLF_LF" "CRLF_LF" 	 ""     =
   	 ""
+commit_chk_wrnNNO "auto"  ""      false   "$WILC"   "$WICL"   "$WAMIX"=
    ""          ""
+commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        LF_CRLF =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      input   ""        CRLF_LF   CRLF_LF =
    ""          ""
=20
-commit_chk_wrnNNO false "text" "$WILC"   "$WICL"   "$WAMIX"  	 "$WILC"=
   	 "$WICL"
-commit_chk_wrnNNO true  "text" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
-commit_chk_wrnNNO input "text" ""        "CRLF_LF" "CRLF_LF" 	 ""     =
   	 "CRLF_LF"
-
-commit_chk_wrnNNO false "-text" ""       ""        ""        	 ""     =
   	 ""
-commit_chk_wrnNNO true  "-text" ""       ""        ""        	 ""     =
   	 ""
-commit_chk_wrnNNO input "-text" ""       ""        ""        	 ""     =
   	 ""
-
-commit_chk_wrnNNO false "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   	 "CRLF_LF"
-commit_chk_wrnNNO true  "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   	 "CRLF_LF"
-commit_chk_wrnNNO input "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   	 "CRLF_LF"
+for crlf in true false input;
+do
+	commit_chk_wrnNNO -text ""      $crlf   ""        ""        ""       =
   ""          ""
+	commit_chk_wrnNNO -text lf      $crlf   ""        ""        ""       =
   ""          ""
+	commit_chk_wrnNNO -text crlf    $crlf   ""        ""        ""       =
   ""          ""
+	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF  =
    ""         CRLF_LF
+	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF  =
   LF_CRLF     ""
+	commit_chk_wrnNNO auto  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
+	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
+	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
+	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
+done
=20
-commit_chk_wrnNNO false "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
-commit_chk_wrnNNO true  "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
-commit_chk_wrnNNO input "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"=
    "$WILC"     "$WICL"
+commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF =
    LF_CRLF     ""
+commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF =
    ""          CRLF_LF
=20
 test_expect_success 'create files cleanup' '
 	rm -f *.txt &&
@@ -440,24 +446,20 @@ test_expect_success 'commit -text' '
 	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul
 '
=20
-#                       attr    LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLFNUL
-check_in_repo_NNO false ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
-check_in_repo_NNO true  ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
-check_in_repo_NNO input ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
-
-check_in_repo_NNO false "auto"  LF        LF        LF           LF_mi=
x_CR 	CRLF_nul
-check_in_repo_NNO true  "auto"  LF        LF        LF           LF_mi=
x_CR 	CRLF_nul
-check_in_repo_NNO input "auto"  LF        LF        LF           LF_mi=
x_CR 	CRLF_nul
-
-check_in_repo_NNO false "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
-check_in_repo_NNO true  "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
-check_in_repo_NNO input "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
-
-check_in_repo_NNO false "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
-check_in_repo_NNO true  "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
-check_in_repo_NNO input "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
-
-
+for crlf in true false input;
+do
+	#                 attr  aeol           LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLFNUL
+	check_in_repo_NNO ""    ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO -text ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO -text lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO -text crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO auto  ""     $crlf   LF  LF    LF           LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO auto  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO auto  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO text  ""     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO text  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO text  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+done
 ######################################################################=
##########
 # Check how files in the repo are changed when they are checked out
 # How to read the table below:
@@ -489,89 +491,82 @@ LFNUL=3DLF_nul
 fi
 export CRLF_MIX_LF_CR MIX NL
=20
-checkout_files ""      "" 	 ""    false  ""       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    false  crlf     LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    false  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    false  native   LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    input  ""       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    input  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    true   ""       CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    true   crlf     CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    true   lf       CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      "" 	 ""    true   native   CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    false  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    false  crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    false  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    false  native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    input  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    input  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    true   ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    true   crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    true   lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files ""      ident ""    true   native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    false  ""       $NL   CRLF  $MIX_CRL=
=46_LF LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    false  crlf     CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    false  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    false  native   $NL   CRLF  $MIX_CRL=
=46_LF LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    input  ""       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    input  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    true   ""       CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    true   crlf     CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    true   lf       CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
-checkout_files "auto"  "" 	 ""    true   native   CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    false  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    false  crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    false  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    false  native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    input  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    input  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    true   ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    true   crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    true   lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-checkout_files "auto"  ident ""    true   native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
-
+# Same handling with and without ident
 for id in "" ident;
 do
-	checkout_files "crlf"  "$id" ""    false  ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    false  crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    false  lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    false  native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    input  ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    input  lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    true   ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    true   crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    true   lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "crlf"  "$id" ""    true   native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "lf"    "$id" ""    false  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    false  crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    false  native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    true   ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    true   crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    true   lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "lf"    "$id" ""    true   native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "text"  "$id" ""    false  ""       $NL   CRLF  $MIX_C=
RLF_LF $MIX_LF_CR   $LFNUL
-	checkout_files "text"  "$id" ""    false  crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "text"  "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "text"  "$id" ""    false  native   $NL   CRLF  $MIX_C=
RLF_LF $MIX_LF_CR   $LFNUL
-	checkout_files "text"  "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "text"  "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "text"  "$id" ""    true   ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "text"  "$id" ""    true   crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "text"  "$id" ""    true   lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "text"  "$id" ""    true   native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
-	checkout_files "-text" "$id" ""    false  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    false  crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    false  native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    true   ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    true   crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    true   lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
-	checkout_files "-text" "$id" ""    true   native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	# -text overrides core.autocrlf and core.eol
+	# text and eol=3Dcrlf or eol=3Dlf override core.autocrlf and core.eol
+	for crlf in true false input;
+	do
+		for ceol in "" lf crlf native;
+		do
+			checkout_files "-text" "$id" ""     "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "-text" "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "-text" "$id" "crlf" "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "text"  "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "text"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF =
 CRLF         CRLF_mix_CR  CRLF_nul
+		done
+	done
+	# text: core.autocrlf=3Dfalse uses core.eol
+	checkout_files "text"  "$id"  ""    false  crlf     CRLF  CRLF  CRLF =
        CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id"  ""    false  lf       LF    CRLF  CRLF_=
mix_LF  LF_mix_CR    LF_nul
+	# text: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
+	checkout_files "text"  "$id"  ""    false  ""       $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id"  ""    false  native   $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "auto"  "$id"  ""    false  ""       $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "auto"  "$id"  ""    false  native   $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
+
+	for ceol in "" lf crlf native;
+	do
+		# text: core.autocrlf =3D true overrides core.eol
+		checkout_files "text"  "$id"  ""    true   "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
+		# text: core.autocrlf =3D input overrides core.eol
+		checkout_files "text"  "$id"  ""    input  "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id"  ""    input  "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+	done
+	# No text attr
+	for ceol in "" lf crlf native;
+	do
+		# core.autocrlf!=3Dtrue gives LF (or mixed) at checkout
+		for crlf in false input;
+		do
+			checkout_files ""    "$id" ""    "$crlf" "$ceol"  LF    CRLF  CRLF_=
mix_LF  LF_mix_CR    LF_nul
+		done
+	done
+done
+
+#Handling without ident
+for id in "";
+do
+	for ceol in "" lf crlf native;
+	do
+		# core.autocrlf=3Dtrue
+		checkout_files ""      "$id" ""    true   "$ceol"   CRLF  CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id" ""    true   "$ceol"   CRLF  CRLF  CRLF=
         LF_mix_CR    LF_nul
+		# text=3Dauto + eol=3DXXX
+		# currently the same as text, eol=3DXXX
+		checkout_files "auto"  "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF  =
CRLF_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF  =
CRLF         CRLF_mix_CR  CRLF_nul
+	done
+done
+
+#Handling with ident
+for id in ident;
+do
+	for crlf in "" true false input;
+	do
+		for ceol in "" lf crlf native;
+		do
+			# ident does not react on core.autocrlf=3Dtrue
+			checkout_files ""      "$id" ""   "$crlf" "$ceol"   LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+			# ident does not react on text=3Dauto
+			checkout_files "auto"  "$id" ""    true   "$ceol"   LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+			# text=3Dauto + eol=3DXXX
+			# currently the same as text, eol=3DXXX
+			checkout_files "auto"  "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "auto"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF =
 CRLF         CRLF_mix_CR  CRLF_nul
+		done
+	done
 done
=20
 # Should be the last test case: remove some files from the worktree
--=20
2.8.0.rc2.2.g1a4d45a.dirty
