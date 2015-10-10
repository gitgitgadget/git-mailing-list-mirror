From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] t0027: Improve test for not-normalized files
Date: Sat, 10 Oct 2015 06:23:53 +0200
Message-ID: <A496A503-08E7-4878-9EB0-342D322E245F@web.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 10 06:24:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZklhX-0003vL-ML
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 06:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbbJJEYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2015 00:24:01 -0400
Received: from mout.web.de ([212.227.17.11]:60136 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJJEYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2015 00:24:00 -0400
Received: from [192.168.209.26] ([213.66.56.100]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LvBMs-1aksRd40CQ-010MTD; Sat, 10 Oct 2015 06:23:56
 +0200
X-Mailer: Apple Mail (2.1085)
X-Provags-ID: V03:K0:vNxYU7R0PO1YWnTGeerIOfcrd43fxIQsfsIQERJYnxb9hXH82vV
 XBeIznLs3WcI5sf6JYvWbSNs0vaKh51XyQ5c15WRzieQA0uz7LpKIxZqOB/tdPyETbIhhah
 DnqEfgu6pnpn1NKx9hYlRQtDoZgw1/51xNUXbcSOZbhvQznFctT/xXgJwtNfN3guNDbc4Qn
 cniSo/TO5glKqGgeuOq4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vELohpOppo4=:KthN/cv7ngbTC80qB/ZEM2
 B/bR97JntDCP249aTPGSUNgyKrOnSxhvC8iPGfJ05w1i9jcX32X8qMYR2eI3KM8ExsrNBF/u7
 9najYu3jWq0llMvLBDbIT9XkFRvJjKMxe0oGjm8TKXpxRkx2ThTsXG9aE72WVrQS1m1EBfpNx
 Q9RggoXsHYWF2m1Ak8n7kZFuydytKR9WkzEqmPLBbENm+LThxnHTL3X5NZ4sWuvgAKCby7sZS
 9w0UCnBDiIiyDeSFAtsWxRaSnPnlx5obYQSSgoA7ayrnNxqlyO4bUVLxIUsTVP8JTjZXPoNV1
 pHFO+TriCKHOpgKF10xHzfU7yXVL4XWYwaTl8wuHPPH/acX9ysc+c9N3UqZSJ1slOHFxY3Xlg
 AGABmCuf8jU38ghkprTZwocCLNGPkME0u8ezbQqvBPQfPEsOvehszukTKio0ewjmEfdx2tX8s
 PFEQ5d/oBhuY6WcfdaYphBZTBbi8Ih9MoX+rmm10jk+UngG2EsidLbPC5pe2rfYOVfasnBC52
 QBF7OnDgBodC4N3C6JWpxh/qdYaBHH6m82HC+uyXZJwrrzJJcAYRmBw/H/lJ0GG97lCAG7ulf
 zLmUMGfIUkyzkPzbZE8PFWVeW+dkeafF9xnrEWHs66LAlPZzVqer5KaXKS2OwmeqH0K3rrX29
 STsYmqT8+lvJVnDlzSGIskm4jlFGLT2dUUy+mw7o5WdC2GEq4RPyocXsnurylv0Wiw0gayDDF
 Rq9lJlTb8Lc/D4/9bYOdEUcVFWRuVjIQTUR8TI6M5SkBcwoPsvY67qwRaCNF80Gb6diFEvOJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279321>

When a text file with mixed line endings is commited into the repo,
it is called "not normalized" (or NNO) in t0027.
The existing test case using repoMIX did not fully test all combination=
s:
(Especially when core.autocrlf =3D true)
=46iles with NL are not converted at commit, but at checkout, so a warn=
ing
NL->CRLF is given.
=46iles with CRLF are not converted at all (so no warning will be given=
),
unless they are marked as "text" or "auto".

Remove repoMIX introduced in commit 8eeab92f02, and replace it with
a combination of NNO tests.

Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
---
This is marked as V2, but is the same as V1
Probably my mail program mangled the V1 patch,
I'll try a different one (mail instead of thunderbird)


t/t0027-auto-crlf.sh | 191 ++++++++++++++++++++++++++++++++++++++++++--=
-------
1 file changed, 157 insertions(+), 34 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 1a56e5e..b343651 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -55,6 +55,26 @@ create_gitattributes () {
	esac
}

+create_NNO_files () {
+	lfname=3D$1
+	crlfname=3D$2
+	lfmixcrlf=3D$3
+	lfmixcr=3D$4
+	crlfnul=3D$5
+	for crlf in false true input
+	do
+		for attr in "" auto text -text lf crlf
+		do
+			pfx=3DNNO_${crlf}_attr_${attr} &&
+			cp $lfname    ${pfx}_LF.txt &&
+			cp $crlfname  ${pfx}_CRLF.txt &&
+			cp $lfmixcrlf ${pfx}_CRLF_mix_LF.txt &&
+			cp $lfmixcr   ${pfx}_LF_mix_CR.txt &&
+			cp $crlfnul   ${pfx}_CRLF_nul.txt
+		done
+	done
+}
+
check_warning () {
	case "$1" in
	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
@@ -62,7 +82,7 @@ check_warning () {
	'')	                                                 >"$2".expect ;;
	*) echo >&2 "Illegal 1": "$1" ; return false ;;
	esac
-	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" >"$=
2".actual
+	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" | u=
niq  >"$2".actual
	test_cmp "$2".expect "$2".actual
}

@@ -71,19 +91,10 @@ commit_check_warn () {
	attr=3D$2
	lfname=3D$3
	crlfname=3D$4
-	repoMIX=3D$5
-	lfmixcrlf=3D$6
-	lfmixcr=3D$7
-	crlfnul=3D$8
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
	pfx=3Dcrlf_${crlf}_attr_${attr}
-	# Special handling for repoMIX: It should already be in the repo
-	# with CRLF
-	f=3DrepoMIX
-	fname=3D${pfx}_$f.txt
-	echo >.gitattributes &&
-	cp $f $fname &&
-	git -c core.autocrlf=3Dfalse add $fname 2>"${pfx}_$f.err" &&
-	git commit -m "repoMIX" &&
	create_gitattributes "$attr" &&
	for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
	do
@@ -99,6 +110,45 @@ commit_check_warn () {
	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
}

+commit_chk_wrnNNO () {
+	crlf=3D$1
+	attr=3D$2
+	lfwarn=3D$3
+	crlfwarn=3D$4
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
+	pfx=3DNNO_${crlf}_attr_${attr}
+	#Commit files on top of existing file
+	create_gitattributes "$attr" &&
+	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
+	do
+		fname=3D${pfx}_$f.txt &&
+		cp $f $fname &&
+		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
+		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${pf=
x}_$f.err" 2>&1
+	done
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF" '
+		check_warning "$lfwarn" ${pfx}_LF.err
+	'
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF"=
 '
+		check_warning "$crlfwarn" ${pfx}_CRLF.err
+	'
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF_=
mix_LF" '
+		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
+	'
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF_mi=
x_cr" '
+		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
+	'
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF_=
nul" '
+		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+	'
+}
+
check_files_in_repo () {
	crlf=3D$1
	attr=3D$2
@@ -115,6 +165,31 @@ check_files_in_repo () {
	compare_files $crlfnul ${pfx}CRLF_nul.txt
}

+check_in_repo_NNO () {
+	crlf=3D$1
+	attr=3D$2
+	lfname=3D$3
+	crlfname=3D$4
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
+	pfx=3DNNO_${crlf}_attr_${attr}_
+	test_expect_success "compare_files $lfname ${pfx}LF.txt" '
+		compare_files $lfname ${pfx}LF.txt
+	'
+	test_expect_success "compare_files $crlfname ${pfx}CRLF.txt" '
+		compare_files $crlfname ${pfx}CRLF.txt
+	'
+	test_expect_success "compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt" =
'
+		compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt
+	'
+	test_expect_success "compare_files $lfmixcr ${pfx}LF_mix_CR.txt" '
+		compare_files $lfmixcr ${pfx}LF_mix_CR.txt
+	'
+	test_expect_success "compare_files $crlfnul ${pfx}CRLF_nul.txt" '
+		compare_files $crlfnul ${pfx}CRLF_nul.txt
+	'
+}

checkout_files () {
	eol=3D$1
@@ -169,7 +244,11 @@ test_expect_success 'setup master' '
	printf "line1\nline2\rline3"     >LF_mix_CR &&
	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
-	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul
+	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul &&
+	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF=
_mix_LF &&
+	git -c core.autocrlf=3Dfalse add NNO_*.txt &&
+	git commit -m "mixed line endings" &&
+	test_tick
'


@@ -191,46 +270,72 @@ else
	WAMIX=3DCRLF_LF
fi

-#                         attr   LF        CRLF      repoMIX   CRLFmix=
LF LFmixCR   CRLFNUL
+#                         attr   LF        CRLF      CRLFmixLF LFmixCR=
   CRLFNUL
test_expect_success 'commit files empty attr' '
-	commit_check_warn false ""     ""        ""        ""        ""      =
  ""        "" &&
-	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        "" &&
-	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""        ""
+	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
+	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
+	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
'

test_expect_success 'commit files attr=3Dauto' '
-	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  "$WAMIX"=
  ""        "" &&
-	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        "" &&
-	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""        ""
+	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  ""      =
  "" &&
+	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
+	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
'

test_expect_success 'commit files attr=3Dtext' '
-	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WAMIX"=
  "$WILC"   "$WICL"   &&
-	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" ""        &&
-	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""        "CRLF_LF"
+	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WILC" =
  "$WICL"   &&
+	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        &&
+	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF"
'

test_expect_success 'commit files attr=3D-text' '
-	commit_check_warn false "-text" ""       ""        ""        ""      =
  ""        "" &&
-	commit_check_warn true  "-text" ""       ""        ""        ""      =
  ""        "" &&
-	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""        ""
+	commit_check_warn false "-text" ""       ""        ""        ""      =
  "" &&
+	commit_check_warn true  "-text" ""       ""        ""        ""      =
  "" &&
+	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""
'

test_expect_success 'commit files attr=3Dlf' '
-	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""       "CRLF_LF" &&
-	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""       "CRLF_LF" &&
-	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""       "CRLF_LF"
+	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF" &&
+	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF" &&
+	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF"
'

test_expect_success 'commit files attr=3Dcrlf' '
-	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" "" &&
-	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" "" &&
-	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" ""
+	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
+	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
+	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
'

+#                       attr   LF        CRLF      CRLFmixLF 	 LF_mix_=
CR   CRLFNUL
+commit_chk_wrnNNO false ""     ""        ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO true  ""     "LF_CRLF" ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO input ""     ""        ""        ""        	 ""     =
   	 ""
+
+
+commit_chk_wrnNNO false "auto" "$WILC"   "$WICL"   "$WAMIX"  	 ""     =
   	 ""
+commit_chk_wrnNNO true  "auto" "LF_CRLF" ""        "LF_CRLF" 	 ""     =
   	 ""
+commit_chk_wrnNNO input "auto" ""        "CRLF_LF" "CRLF_LF" 	 ""     =
   	 ""
+
+commit_chk_wrnNNO false "text" "$WILC"   "$WICL"   "$WAMIX"  	 "$WILC"=
   	 "$WICL"
+commit_chk_wrnNNO true  "text" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO input "text" ""        "CRLF_LF" "CRLF_LF" 	 ""     =
   	 "CRLF_LF"
+
+commit_chk_wrnNNO false "-text" ""       ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO true  "-text" ""       ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO input "-text" ""       ""        ""        	 ""     =
   	 ""
+
+commit_chk_wrnNNO false "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   	 "CRLF_LF"
+commit_chk_wrnNNO true  "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   	 "CRLF_LF"
+commit_chk_wrnNNO input "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   	 "CRLF_LF"
+
+commit_chk_wrnNNO false "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO true  "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO input "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+
test_expect_success 'create files cleanup' '
	rm -f *.txt &&
-	git reset --hard
+	git -c core.autocrlf=3Dfalse reset --hard
'

test_expect_success 'commit empty gitattribues' '
@@ -257,6 +362,24 @@ test_expect_success 'commit -text' '
	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_n=
ul
'

+#                       attr    LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLFNUL
+check_in_repo_NNO false ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
+check_in_repo_NNO true  ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
+check_in_repo_NNO input ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
+
+check_in_repo_NNO false "auto"  LF        LF        LF           LF_mi=
x_CR 	CRLF_nul
+check_in_repo_NNO true  "auto"  LF        LF        LF           LF_mi=
x_CR 	CRLF_nul
+check_in_repo_NNO input "auto"  LF        LF        LF           LF_mi=
x_CR 	CRLF_nul
+
+check_in_repo_NNO false "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
+check_in_repo_NNO true  "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
+check_in_repo_NNO input "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
+
+check_in_repo_NNO false "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
+check_in_repo_NNO true  "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
+check_in_repo_NNO input "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR 	CRLF_nul
+
+
#######################################################################=
#########
# Check how files in the repo are changed when they are checked out
# How to read the table below:
--=20
2.5.0
