From: tboegi@web.de
Subject: [PATCH v5 3/4] t0027: test cases for combined attributes
Date: Tue, 19 Apr 2016 15:26:02 +0200
Message-ID: <1461072362-2835-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:22:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVbY-0004Mu-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbcDSNWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 09:22:06 -0400
Received: from mout.web.de ([212.227.15.4]:53092 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbcDSNWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:22:04 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MIkOm-1auiWX3Feq-002E2E; Tue, 19 Apr 2016 15:22:01
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:3flLGzJVPPyodf2Lp1apdzYY/A0Q0P+Ml/vSYVhM5Sl2UlIK2Bc
 gtgLq2DlZVvM3NF3KO+RXVYT5UvGFC6/mOhzW5WWKpdr/Nx19ecKdsy+NdeIPK18CieZCYZ
 Nm45bMByH/mEWdAnz1NsuGCJEuc9OrEIf8YmKusIb+W0NZJejNKjHnCe+lVtpUwo1z6H/xr
 +dP6PcTTXOJno0sIGlXYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sjzaK2KNXtc=:VyMlD2pfQw9bV155D1AfzW
 69eP7wFIMStt+4bmCzWUh5NNJIXlofjqdWjYqQUgdNfd3Fd4lDq0Xbcr4X3Ed2qSxA3bZ5NjS
 AoVqW3OIa1M9dfSkwdka4SZjSXO1nkrertIEWvzfX5Wl3qEE+DAGV60Wl9So2QE+eYPJO7FJ6
 H78TmOK6rkECe7TyzYJEx2MrecsRVl1K5Q8G/x6JIoW5AHb3qbGjx5xeERji0ufrjvwObBFme
 6NSYRe8uqoclKtrFVKYmIKPXX9ebeGStCFidkmcCfQEhzbLHQ80pYbbwnCm3Ka5IYweUHtKNM
 iLajZBtbWMuuxUWBqu6ONG1b1WfsavvTgjbhX+SuLE9AuGpwhx/EtoCk83oAZ6XBRVk6F0ogk
 so6C6r+DqZ9IJ5xPl7sSmIUkj7R1RYV8h3t9Brh70bfvyUaA9yKVXBli4IIKcIka/tBPJIXbz
 KVDHzWMpPVfVxWMYCUQU/KzAlAbVumIiw3Bqn3FeKFWcD2KVOp6jLMUkA9e8WHBoxkb93OdDo
 OKGIo5uVpR3gwJ73Dd9vO3RIuVL71maJRmRw1DYEGazcku8UFgba93h+iyvagiS+H+g52PQ2/
 iFok8VLiKavaVeLYvSUN51seMXFGaSryzJyENXS+ZNNLDSRSYbNyazxAOdx/sZGL9doir+FaA
 91ePQK9P5iF9xdcH8FDJ2qexdJYOIX3Rg6/kKVgiuAkfXUcZuj1I60G8o+zKTDLkgGnC9m02O
 iRX7dURjPquN3AXNeDF3/SuiFB8LvIhwEnR6c5akoVn9scu1eB+ZmwPQNvhEOY7iTq+u193L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291861>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Add more test cases for the not normalized files ("NNO").  The
"text" attribute is most important, use it as the first parameter.
"ident", if set, is the second paramater followed by the eol
attribute.  The eol attribute overrides core.autocrlf, which
overrides core.eol.
indent is not yet uses, this will be done in the next commit.

Use loops to test more combinations of attributes, like
"* text eol=3Dcrlf" or especially "*text=3Dauto eol=3Dcrlf".

Currently "* text=3Dauto eol=3Dlf" does the same as "* text eol=3Dlf",
as the eol attribute overrides "text=3Dauto", this will change in
future.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 298 ++++++++++++++++++++++---------------------=
--------
 1 file changed, 129 insertions(+), 169 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 9fe539b..fd5e326 100755
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
@@ -122,19 +126,19 @@ commit_chk_wrnNNO () {
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
@@ -163,6 +167,7 @@ stats_ascii () {
=20
 # contruct the attr/ returned by git ls-files --eol
 # Take none (=3Dempty), one or two args
+# convert.c: eol=3DXX overrides text=3Dauto
 attr_ascii () {
 	case $1,$2 in
 	-text,*)   echo "-text" ;;
@@ -170,8 +175,8 @@ attr_ascii () {
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
@@ -196,28 +201,29 @@ check_files_in_repo () {
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
@@ -232,7 +238,7 @@ checkout_files () {
 	lfmixcrlf=3D$1 ; shift
 	lfmixcr=3D$1 ; shift
 	crlfnul=3D$1 ; shift
-	create_gitattributes "$attr" "$ident" &&
+	create_gitattributes "$attr" $ident $aeol &&
 	git config core.autocrlf $crlf &&
 	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
@@ -245,7 +251,7 @@ checkout_files () {
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
@@ -260,19 +266,19 @@ checkout_files () {
 		sort >actual &&
 		test_cmp expect actual
 	'
-	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DLF" "
+	test_expect_success "checkout attr=3D$attr $ident aeol=3D$aeol core.a=
utocrlf=3D$crlf core.eol=3D$ceol file=3DLF" "
 		compare_ws_file $pfx $lfname    crlf_false_attr__LF.txt
 	"
-	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DCRLF" "
+	test_expect_success "checkout attr=3D$attr $ident aeol=3D$aeol core.a=
utocrlf=3D$crlf core.eol=3D$ceol file=3DCRLF" "
 		compare_ws_file $pfx $crlfname  crlf_false_attr__CRLF.txt
 	"
-	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DCRLF_mix_LF" "
+	test_expect_success "checkout attr=3D$attr $ident aeol=3D$aeol core.a=
utocrlf=3D$crlf core.eol=3D$ceol file=3DCRLF_mix_LF" "
 		compare_ws_file $pfx $lfmixcrlf crlf_false_attr__CRLF_mix_LF.txt
 	"
-	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DLF_mix_CR" "
+	test_expect_success "checkout attr=3D$attr $ident aeol=3D$aeol core.a=
utocrlf=3D$crlf core.eol=3D$ceol file=3DLF_mix_CR" "
 		compare_ws_file $pfx $lfmixcr   crlf_false_attr__LF_mix_CR.txt
 	"
-	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DLF_nul" "
+	test_expect_success "checkout attr=3D$attr $ident aeol=3D$aeol core.a=
utocrlf=3D$crlf core.eol=3D$ceol file=3DLF_nul" "
 		compare_ws_file $pfx $crlfnul   crlf_false_attr__LF_nul.txt
 	"
 }
@@ -386,31 +392,31 @@ test_expect_success 'commit files attr=3Dcrlf' '
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
+for crlf in true false input
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
@@ -441,24 +447,20 @@ test_expect_success 'commit -text' '
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
+for crlf in true false input
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
@@ -490,89 +492,47 @@ LFNUL=3DLF_nul
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
-for id in "" ident;
+# Same handling with and without ident
+for id in ""
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
+	for ceol in lf crlf native
+	do
+		for crlf in true false input
+		do
+			# -text overrides core.autocrlf and core.eol
+			# text and eol=3Dcrlf or eol=3Dlf override core.autocrlf and core.e=
ol
+			checkout_files -text "$id" ""     "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			checkout_files -text "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			checkout_files -text "$id" "crlf" "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			# text
+			checkout_files text  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			checkout_files text  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
+			# currently the same as text, eol=3DXXX
+			checkout_files auto  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			checkout_files auto  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
+		done
+
+		# core.autocrlf false, different core.eol
+		checkout_files   ""    "$id" ""     false   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		# core.autocrlf true
+		checkout_files   ""    "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		# text: core.autocrlf =3D true overrides core.eol
+		checkout_files   auto  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46         LF_mix_CR    LF_nul
+		checkout_files   text  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46         CRLF_mix_CR  CRLF_nul
+		# text: core.autocrlf =3D input overrides core.eol
+		checkout_files   text  "$id" ""     input   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files   auto  "$id" ""     input   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		# text=3Dauto + eol=3DXXX
+	done
+	# text: core.autocrlf=3Dfalse uses core.eol
+	checkout_files     text  "$id" ""     false   crlf     CRLF  CRLF  CR=
LF         CRLF_mix_CR  CRLF_nul
+	checkout_files     text  "$id" ""     false   lf       LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+	# text: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
+	checkout_files     text  "$id" ""     false   ""       $NL   CRLF  $M=
IX_CRLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files     text  "$id" ""     false   native   $NL   CRLF  $M=
IX_CRLF_LF $MIX_LF_CR   $LFNUL
+	# auto: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
+	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  $M=
IX_CRLF_LF LF_mix_CR    LF_nul
+	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  $M=
IX_CRLF_LF LF_mix_CR    LF_nul
 done
=20
 # Should be the last test case: remove some files from the worktree
--=20
2.8.0.rc2.2.g1a4d45a.dirty
