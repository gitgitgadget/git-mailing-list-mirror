Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDC32036D
	for <e@80x24.org>; Fri, 24 Nov 2017 16:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbdKXQOO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 11:14:14 -0500
Received: from mout.web.de ([217.72.192.78]:59321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdKXQON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 11:14:13 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgVn-1f2MHV2lvj-00k6Z9; Fri, 24
 Nov 2017 17:14:10 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, ashishnegi33@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/1] convert: tighten the safe autocrlf handling
Date:   Fri, 24 Nov 2017 17:14:07 +0100
Message-Id: <20171124161407.30698-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.0.278.gbd97f72a1b.dirty
In-Reply-To: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:52vjgM/NNmrBLpK7hmdP/jl0dG4WMYPzpuBdsu/H8WxrrbPGGXu
 8Fu+RtJ/kGr5QR6gaXXETm16DqQTgb1BfiL8bL+zwiw10yHHOuhdpwHHR9F8lmi2dp7GCwv
 2mbUVlKHmjc6fUdHeBqTym/fhBYmMNt6PVH/pM1e0h62qO2uGzlhJJnq5Te7ujwG8FIh1mT
 YOdXxP6hzuuuA0NiqrbpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xCvj9gpbWPE=:sfQx/F3w1RGv03dSS5vGn7
 PwP6uMEqxxtsEFf5Tt/iM6Z9zOfP6XwHf08o3hRR7NDAWnFLgx54r2NAGFaReVAfX2Pm82B38
 X/WC8A5NbZcfhRomQUX2QruEb/OpLqrCChq+wuHl3g3kuGEhnSidsFCc1kklxgRC4R5BU4M9E
 to0EjCkD82HwT8pbylXpbpWOPzgguZzLp2oZTeRhYiUm3clCQr8kgK9NBUWODAcXnxsh3pPzX
 Wk85sFjY15BbeEzEcBGORjsKd7JaZ4TbAfLltBsU4BN4lp5lKbLooQOyPcQVMwEMfa+GusCXt
 U+s8w6Lt6aQlH8pvLb52bcq7EdE/8DILcc73IMEetyI//SxgckKcHB+842buwl6jTa4Hn4ovh
 j8UgFIRu7NcQEo/3laa9oQ9+lNc2JW1DDAbwv8RxbJOK73HZ5PRT+kU+gU2M2prkH7r6KOkNp
 vBppQmXQDxNsRdjwQ8/3jCfaekEuCsaEpOASUXZrQVWWTcTYlBsnkt9EuzfCc/O6Wn63pP+nq
 MU3Acb61w2BIdMi4Dp8wf4ho8Gt7a+p5EVPhHPyWFyD6bH68NQ3CiwZxnHSeRfTMlHm8mzE5s
 ag9phX+1UE0QguPV9kWuf1tFgUzYVEj5AM6fVB7UYVbldSTNtKrTDJJSx6Pg90WGH5kPPYy0I
 XcJyvcrqiBFfWKFhrbcetZnk1wFp/G4LrjqSRZ27WQVE1N3ZaS5n7hO5ADlgW3EJwP8F2npEM
 hfGXbsbBrLvS7Qo6cM0a5qexm3/I52tr9SLCiQdfzmOaEQFd+zebQdJZwUR4bqb7mAr/YWeXZ
 Jn9B4XVkloht9VzCWjzO3Cij2dvl9gx7OJr63lleQJ1Fk4RS+4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When a text file had been commited with CRLF and the file is commited
again, the CRLF are kept if .gitattributs has "text=auto".
This is done by analyzing the content of the blob stored in the index:
If a '\r' is found, Git assumes that the blob was commited with CRLF.

The simple search for a '\r' does not always work as expected:
A file is encoded in UTF-16 with CRLF and commited. Git treats it as binary.
Now the content is converted into UTF-8. At the next commit Git treats the
file as text, the CRLF should be converted into LF, but isn't.

Solution:
Replace has_cr_in_index() with has_crlf_in_index(). When no '\r' is found,
0 is returned directly, this is the most common case.
If a '\r' is found, the content is analyzed more deeply.

Reported-By: Ashish Negi <ashishnegi33@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 convert.c            | 19 +++++++++----
 t/t0027-auto-crlf.sh | 76 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 20d7ab67bd..63ef799239 100644
--- a/convert.c
+++ b/convert.c
@@ -220,18 +220,27 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 	}
 }
 
-static int has_cr_in_index(const struct index_state *istate, const char *path)
+static int has_crlf_in_index(const struct index_state *istate, const char *path)
 {
 	unsigned long sz;
 	void *data;
-	int has_cr;
+	const char *crp;
+	int has_crlf = 0;
 
 	data = read_blob_data_from_index(istate, path, &sz);
 	if (!data)
 		return 0;
-	has_cr = memchr(data, '\r', sz) != NULL;
+
+	crp = memchr(data, '\r', sz);
+	if (crp && (crp[1] == '\n')) {
+		unsigned int ret_stats;
+		ret_stats = gather_convert_stats(data, sz);
+		if (!(ret_stats & CONVERT_STAT_BITS_BIN) &&
+		    (ret_stats & CONVERT_STAT_BITS_TXT_CRLF))
+			has_crlf = 1;
+	}
 	free(data);
-	return has_cr;
+	return has_crlf;
 }
 
 static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
@@ -290,7 +299,7 @@ static int crlf_to_git(const struct index_state *istate,
 		 * cherry-pick.
 		 */
 		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
-		    has_cr_in_index(istate, path))
+		    has_crlf_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
 	if ((checksafe == SAFE_CRLF_WARN ||
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 68108d956a..0af35cfb1f 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -43,19 +43,31 @@ create_gitattributes () {
 	} >.gitattributes
 }
 
-create_NNO_files () {
+# Create 2 sets of files:
+# The NNO files are "Not NOrmalized in the repo. We use CRLF_mix_LF and store
+#   it under different names for the different test cases, see ${pfx}
+#   Depending on .gitattributes they are normalized at the next commit (or not)
+# The MIX files have different contents in the repo.
+#   Depending on its contents, the "new safer autocrlf" may kick in.
+create_NNO_MIX_files () {
 	for crlf in false true input
 	do
 		for attr in "" auto text -text
 		do
 			for aeol in "" lf crlf
 			do
-				pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
+				pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf} &&
 				cp CRLF_mix_LF ${pfx}_LF.txt &&
 				cp CRLF_mix_LF ${pfx}_CRLF.txt &&
 				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
 				cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
-				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
+				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt &&
+				pfx=MIX_attr_${attr}_aeol_${aeol}_${crlf} &&
+				cp LF          ${pfx}_LF.txt &&
+				cp CRLF        ${pfx}_CRLF.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
+				cp LF_mix_CR   ${pfx}_LF_mix_CR.txt &&
+				cp CRLF_nul    ${pfx}_CRLF_nul.txt
 			done
 		done
 	done
@@ -136,6 +148,49 @@ commit_chk_wrnNNO () {
 	'
 }
 
+# Commit a file with mixed line endings on top of different files
+# in the index. Check for warnings
+commit_MIX_chkwrn () {
+	attr=$1 ; shift
+	aeol=$1 ; shift
+	crlf=$1 ; shift
+	lfwarn=$1 ; shift
+	crlfwarn=$1 ; shift
+	lfmixcrlf=$1 ; shift
+	lfmixcr=$1 ; shift
+	crlfnul=$1 ; shift
+	pfx=MIX_attr_${attr}_aeol_${aeol}_${crlf}
+	#Commit file with CLRF_mix_LF on top of existing file
+	create_gitattributes "$attr" $aeol &&
+	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
+	do
+		fname=${pfx}_$f.txt &&
+		cp CRLF_mix_LF $fname &&
+		printf Z >>"$fname" &&
+		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
+	done
+
+	test_expect_success "commit file with mixed EOL crlf=$crlf attr=$attr LF" '
+		check_warning "$lfwarn" ${pfx}_LF.err
+	'
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF" '
+		check_warning "$crlfwarn" ${pfx}_CRLF.err
+	'
+
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
+		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
+	'
+
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
+		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
+	'
+
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
+		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+	'
+}
+
+
 stats_ascii () {
 	case "$1" in
 	LF)
@@ -323,8 +378,8 @@ test_expect_success 'setup master' '
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\nLINETWO\nLINETHREE" | q_to_nul >LF_nul &&
-	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF &&
-	git -c core.autocrlf=false add NNO_*.txt &&
+	create_NNO_MIX_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF &&
+	git -c core.autocrlf=false add NNO_*.txt MIX_*.txt &&
 	git commit -m "mixed line endings" &&
 	test_tick
 '
@@ -385,6 +440,17 @@ test_expect_success 'commit files attr=crlf' '
 	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" ""
 '
 
+# Commit "CRLFmixLF" on top of these files already in the repo:
+# LF, CRLF, CRLFmixLF LF_mix_CR CRLFNULL
+#                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
+commit_MIX_chkwrn ""      ""      false   ""        ""        ""          ""          ""
+commit_MIX_chkwrn ""      ""      true    "LF_CRLF" ""        ""          "LF_CRLF"   "LF_CRLF"
+commit_MIX_chkwrn ""      ""      input   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+
+commit_MIX_chkwrn "auto"  ""      false   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+commit_MIX_chkwrn "auto"  ""      true    "LF_CRLF" ""        ""          "LF_CRLF"   "LF_CRLF"
+commit_MIX_chkwrn "auto"  ""      input   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+
 #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
 commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
 commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
-- 
2.15.0.278.gbd97f72a1b.dirty

