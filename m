Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA451F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbcHLQlx (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:41:53 -0400
Received: from mout.web.de ([212.227.15.4]:63452 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbcHLQlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:41:51 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MTQ07-1bg7Ti2dmx-00SLLm; Fri, 12 Aug 2016 18:41:45
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	peff@peff.net, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 2/2] convert: missing `LF will be replaced by CRLF
Date:	Fri, 12 Aug 2016 18:51:04 +0200
Message-Id: <1471020664-20784-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
MIME-Version: 1.0
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:p8JQ/htf2spyt+xvLaCnDomgn8H7xFsckREovKSW2s3Ncv4roxL
 qiR8Meo3vKE9YB/obDPvkE8rlZTE4Jsjb5cXIikmKy9zCEQ/Xtg8TqR8plnTlYbX+mBockw
 T6Hny3WmTgK0sGb+sir//ostLvkb2m8UJv0K5RLtty18JK6M+UF9yNz2LHV8LoBYrVODeST
 xXZt7AkcH1PYTteykmzBA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:nmsQcx2rIA4=:m4DAtsh2X/79mCHqikEX2Z
 aTDWY1RuzobBpXwOtPRNxrT60hFKuVvGOeWtnWmxrHEJ9fN+30Mv7TjTckWaeeZNB3UyoS0/f
 8g+qeBFon4APYjE/CD9tc6Lk10v4GtPpGiytME6M5gvnXA4fASaQdcMEFdcpJZpuw8dgjvJ2x
 R6ejf8XQIykBDXD3sho2bfnhJFPha4B5IYodOaQ9Zl4+1RIsllpe3jMWvn3UUSmhxoVCM5gdU
 jQfrTC+hS6jFG7YKArDEOaTuFXcpWq1UWccZGsJts53XapKSb2Mm1ntu79Mk5rezcrEDUjYu4
 Mr2Ye0PnOhJEnH4URwWWo5QP1gbTAiWV5WcV8A/yYc9r757UBaQsjXrOCkMiaKRBwjZnJmzBV
 /VD+Ot5hUByYzjAS07eB/6eJ19wv50Xv2kFy0DVLco5dYVz/r8czcsigx5oyUWSwlnQ0bD4uO
 9d9lwKsGNuWpsSyqGNMt0sFcXhFs7GfafXtbmQeS0WDeKCMAn7Fd8mHTzYC88UXEITIzdQbE4
 mgUDXhw5VR1+HWSLNUoInO+wVNGUMHEU/4rMmBOu/HPhtSZAr4FquM4uIE4Gr23NQiTmfmMJh
 2cE85+itxDEz8ebccqbYGe+G1RqCPiuj13fg3lCH9HmCMzP04Xp2ZHPLBecq8zSV0pk59cnrP
 mFLTJ5eaAa8gIW0CDxrkD0zGNcWhQhfIHCttfipKEF3rG+5RrOFxmOBOUt81swgqcv5cJrnxS
 C6LzsOBlzXEiUtNbk18IbOTa/NrbVGcNUUZfnSK5OydAtdf2JY8p5etW0ScO0TdPBOvJMIUbC
 k7SNig2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When the "new safer autocrlf-handling" was introduced in c4805393, the logic
around check_safe_crlf() should have been changed:
Once a file has been commited with CRLF (and core.autocrlf is true),
line endings are no longer converted by "git add" or "git checkout".
The line endings will not normalized by Git.
The user may run e.g. dos2unix and commit the file.

Factor out will_convert_lf_to_crlf() which returns when LF are converted
into CRLF at checkout.

Update the logic around check_safe_crlf() and do the possible CRLF-LF
conversion in "git add".
Simulate the checkout (and a possible LF-CRLF conversion) with help of
will_convert_lf_to_crlf().
---
 convert.c            | 97 ++++++++++++++++++++++++++++++----------------------
 t/t0027-auto-crlf.sh |  6 ++--
 2 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/convert.c b/convert.c
index 67d69b5..077f5e6 100644
--- a/convert.c
+++ b/convert.c
@@ -189,33 +189,25 @@ static enum eol output_eol(enum crlf_action crlf_action)
 }
 
 static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
-                            struct text_stat *stats, enum safe_crlf checksafe)
+			    struct text_stat *old_stats, struct text_stat *new_stats,
+			    enum safe_crlf checksafe)
 {
-	if (!checksafe)
-		return;
-
-	if (output_eol(crlf_action) == EOL_LF) {
+	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
-		 * CRLFs would not be restored by checkout:
-		 * check if we'd remove CRLFs
+		 * CRLFs would not be restored by checkout
 		 */
-		if (stats->crlf) {
-			if (checksafe == SAFE_CRLF_WARN)
-				warning("CRLF will be replaced by LF in %s.\nThe file will have its original line endings in your working directory.", path);
-			else /* i.e. SAFE_CRLF_FAIL */
-				die("CRLF would be replaced by LF in %s.", path);
-		}
-	} else if (output_eol(crlf_action) == EOL_CRLF) {
+		if (checksafe == SAFE_CRLF_WARN)
+			warning("CRLF will be replaced by LF in %s.\nThe file will have its original line endings in your working directory.", path);
+		else /* i.e. SAFE_CRLF_FAIL */
+			die("CRLF would be replaced by LF in %s.", path);
+	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
-		 * CRLFs would be added by checkout:
-		 * check if we have "naked" LFs
+		 * CRLFs would be added by checkout
 		 */
-		if (stats->lonelf) {
-			if (checksafe == SAFE_CRLF_WARN)
-				warning("LF will be replaced by CRLF in %s.\nThe file will have its original line endings in your working directory.", path);
-			else /* i.e. SAFE_CRLF_FAIL */
-				die("LF would be replaced by CRLF in %s", path);
-		}
+		if (checksafe == SAFE_CRLF_WARN)
+			warning("LF will be replaced by CRLF in %s.\nThe file will have its original line endings in your working directory.", path);
+		else /* i.e. SAFE_CRLF_FAIL */
+			die("LF would be replaced by CRLF in %s", path);
 	}
 }
 
@@ -233,12 +225,35 @@ static int has_cr_in_index(const char *path)
 	return has_cr;
 }
 
+static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
+				   enum crlf_action crlf_action)
+{
+	if (output_eol(crlf_action) != EOL_CRLF)
+		return 0;
+	/* No "naked" LF? Nothing to convert, regardless. */
+	if (!stats->lonelf)
+		return 0;
+
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
+		/* If we have any CR or CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats->lonecr || stats->crlf)
+			return 0;
+
+		if (convert_is_binary(len, stats))
+			return 0;
+	}
+	return 1;
+
+}
+
 static int crlf_to_git(const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
 	struct text_stat stats;
 	char *dst;
+	int convert_crlf_into_lf;
 
 	if (crlf_action == CRLF_BINARY ||
 	    (src && !len))
@@ -252,6 +267,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		return 1;
 
 	gather_stats(src, len, &stats);
+	/* Optimization: No CRLF? Nothing to convert, regardless. */
+	convert_crlf_into_lf = !!stats.crlf;
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
@@ -263,12 +280,24 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		if (checksafe == SAFE_CRLF_RENORMALIZE)
 			checksafe = SAFE_CRLF_FALSE;
 		else if (has_cr_in_index(path))
-			return 0;
+			convert_crlf_into_lf = 0;
 	}
-	check_safe_crlf(path, crlf_action, &stats, checksafe);
-
-	/* Optimization: No CRLF? Nothing to convert, regardless. */
-	if (!stats.crlf)
+	if (checksafe && len) {
+		struct text_stat new_stats;
+		memcpy(&new_stats, &stats, sizeof(new_stats));
+		/* simulate "git add" */
+		if (convert_crlf_into_lf) {
+			new_stats.lonelf += new_stats.crlf;
+			new_stats.crlf = 0;
+		}
+		/* simulate "git checkout" */
+		if (will_convert_lf_to_crlf(len, &new_stats, crlf_action)) {
+			new_stats.crlf += new_stats.lonelf;
+			new_stats.lonelf = 0;
+		}
+		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
+	}
+	if (!convert_crlf_into_lf)
 		return 0;
 
 	/*
@@ -314,21 +343,9 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 		return 0;
 
 	gather_stats(src, len, &stats);
-
-	/* No "naked" LF? Nothing to convert, regardless. */
-	if (!stats.lonelf)
+	if (!will_convert_lf_to_crlf(len, &stats, crlf_action))
 		return 0;
 
-	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
-		/* If we have any CR or CRLF line endings, we do not touch it */
-		/* This is the new safer autocrlf-handling */
-		if (stats.lonecr || stats.crlf )
-			return 0;
-
-		if (convert_is_binary(len, &stats))
-			return 0;
-	}
-
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index ab6e962..7de8364 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -393,11 +393,11 @@ test_expect_success 'commit files attr=crlf' '
 
 #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
 commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
-commit_chk_wrnNNO ""      ""      true    ""        ""        ""          ""          ""
+commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
 commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
 
 commit_chk_wrnNNO "auto"  ""      false   ""        ""        ""          ""          ""
-commit_chk_wrnNNO "auto"  ""      true    ""        ""        ""          ""          ""
+commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
 commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""
 for crlf in true false input
 do
@@ -407,7 +407,7 @@ do
 	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF      ""         CRLF_LF
 	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""          ""          ""
-	commit_chk_wrnNNO auto  crlf  	$crlf   ""        ""        ""          ""          ""
+	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF  ""        ""          ""          ""
 	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
 	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 done
-- 
2.0.0.rc1.6318.g0c2c796

