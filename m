Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B511BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbiGHOUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbiGHOUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7826E24F15
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so30762297wrd.8
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgv+eu1DihmDf2Wug9WsVqJiAHTnLTeXvP+NlvaxqxY=;
        b=fuJCe24hurJGv7b3+AKP9YIzRpZ7cQI76zgcOTViFNyHMqS0mF4yhLWWdD+WhS21/P
         JwPKNWdQAXhWkXg6kTsDvB9hI3gz3na/OeiCwixTGU/V6H1XvFIUXVWbPSNuqFWVzLbf
         AJBYh8EsJg98JQHb0XZFbnBL0vWc1kB6LL6MSrzvmgmJfvxu2wXw40Gs3CGBsEUcOGYt
         2tWtrPvs6IJGLZ+VoDu3AJt1++xOb0VXDfjw19ksiECKEfyM5Mv8EiF2K954LzLdKse3
         Q+TfRMdOa7rApo2s37wP7w060QblcmicoiHBB6GVS+mXGf1MEkdHM0rjr1D58L3OnEUk
         O3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgv+eu1DihmDf2Wug9WsVqJiAHTnLTeXvP+NlvaxqxY=;
        b=aqmksFTB3a3rxKEWpH+bx6tJxvPV5izmCrlWBpzjAGE/HSEvOGWGGvGxKowDjGmBWI
         eE05cOBiWi/gCcbnbKU8vBRnpDALqvnSk3IaK6Cv4D/grsuxkbWMaEwHrrtbbLB2j7Bv
         DDrfFSzxyWPJKBVmnwBP9N2iJJEg2OYgo7Pe3SxeEmoempdCI3gHRE931DipLPGH+tNt
         BgXPu+5ivmEoTikXo6u474Es8CIQFinrx/wCSmSN5ezhF1oj4R4sAQDQbdxnuQLL9pD2
         aUgpSAFZ5taVTbpuJFRMFspynqTr1CUq9oB9wu8zp3dsrTWpYUX5femEN3YWL37SN5Zp
         NOAQ==
X-Gm-Message-State: AJIora8qbrfA7NWLOqysq+EPlIHupL0RbCRANXiZNYKRP7+q4JEUrRef
        6Gxf3oc2WlKhYmvoLQH0ThRG8hs2hqI=
X-Google-Smtp-Source: AGRyM1ticjVXoubRd+hEPlkc/j3D1bgW2QGxjhH5nTZN0xokAyjr98JlbZLcmZy+3oqDMPfFrfv2tA==
X-Received: by 2002:adf:fb49:0:b0:21a:3ccc:fb77 with SMTP id c9-20020adffb49000000b0021a3cccfb77mr3551098wrs.280.1657290032663;
        Fri, 08 Jul 2022 07:20:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] xdiff: simplify freeing patterns around xdl_free_env()
Date:   Fri,  8 Jul 2022 16:20:13 +0200
Message-Id: <patch-1.7-ad61f4e20b1-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the invocations of xdl_free_env() so that only the function
that allocated the "xe" variable frees it, rather than passing it to a
function that might use "&xe", and on failure having that function
free it.

This simplifies the allocation management, since due to the new "{ 0
}" initialization we can pass "&xe" to xdl_free_env() without
accounting for the "&xe" not being initialized yet.

This change was originally suggested as an amendment of the series
that since got merged in 47be28e51e6 (Merge branch
'pw/xdiff-alloc-fail', 2022-03-09) in [1]. The "avoid double free of
xe2" in that series is one of the pattern we can simplify here.

1. https://lore.kernel.org/git/220216.86tuczt7js.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xdiffi.c | 40 ++++++++++++++++------------------------
 xdiff/xmerge.c | 47 ++++++++++++++++++++++++++++-------------------
 xdiff/xutils.c | 12 ++++++++----
 3 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 53e803e6bcb..6fded43e87d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -320,15 +320,11 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
 		return -1;
 
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
-		res = xdl_do_patience_diff(mf1, mf2, xpp, xe);
-		goto out;
-	}
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF)
+		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
 
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
-		res = xdl_do_histogram_diff(mf1, mf2, xpp, xe);
-		goto out;
-	}
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
+		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
 
 	/*
 	 * Allocate and setup K vectors to be used by the differential
@@ -337,11 +333,8 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	 * One is to store the forward path and one to store the backward path.
 	 */
 	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
-	if (!XDL_ALLOC_ARRAY(kvd, 2 * ndiags + 2)) {
-
-		xdl_free_env(xe);
+	if (!XDL_ALLOC_ARRAY(kvd, 2 * ndiags + 2))
 		return -1;
-	}
 	kvdf = kvd;
 	kvdb = kvdf + ndiags;
 	kvdf += xe->xdf2.nreff + 1;
@@ -366,9 +359,6 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
 			   &xenv);
 	xdl_free(kvd);
- out:
-	if (res < 0)
-		xdl_free_env(xe);
 
 	return res;
 }
@@ -1054,19 +1044,19 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
-	xdfenv_t xe;
+	xdfenv_t xe = { 0 };
 	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
+	int status = 0;
 
 	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
-
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
-
-		xdl_free_env(&xe);
-		return -1;
+		status = -1;
+		goto cleanup;
 	}
 	if (xscr) {
 		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
@@ -1078,12 +1068,14 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {
 
 			xdl_free_script(xscr);
-			xdl_free_env(&xe);
-			return -1;
+			status = -1;
+			goto cleanup;
 		}
 		xdl_free_script(xscr);
 	}
+
+cleanup:
 	xdl_free_env(&xe);
 
-	return 0;
+	return status;
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index af40c88a5b3..ac0cf52f3be 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -365,7 +365,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 {
 	for (; m; m = m->next) {
 		mmfile_t t1, t2;
-		xdfenv_t xe;
+		xdfenv_t xe = { 0 };
 		xdchange_t *xscr, *x;
 		int i1 = m->i1, i2 = m->i2;
 
@@ -387,8 +387,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
 		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
 			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.ptr;
-		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
+		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0) {
+			xdl_free_env(&xe);
 			return -1;
+		}
 		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 		    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 		    xdl_build_script(&xe, &xscr) < 0) {
@@ -684,30 +686,37 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, mmbuffer_t *result)
 {
-	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
-	xdfenv_t xe1, xe2;
-	int status = -1;
+	xdchange_t *xscr1, *xscr2;
+	xdfenv_t xe1 = { 0 };
+	xdfenv_t xe2 = { 0 };
+	int status;
 	xpparam_t const *xpp = &xmp->xpp;
 
 	result->ptr = NULL;
 	result->size = 0;
 
-	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0)
-		return -1;
-
-	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0)
-		goto free_xe1; /* avoid double free of xe2 */
-
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
+		status = -1;
+		goto cleanup;
+	}
+	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
+		status = -1;
+		goto cleanup;
+	}
 	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
-	    xdl_build_script(&xe1, &xscr1) < 0)
-		goto out;
-
+	    xdl_build_script(&xe1, &xscr1) < 0) {
+		status = -1;
+		goto cleanup;
+	}
 	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
-	    xdl_build_script(&xe2, &xscr2) < 0)
-		goto out;
-
+	    xdl_build_script(&xe2, &xscr2) < 0) {
+		xdl_free_script(xscr1);
+		status = -1;
+		goto cleanup;
+	}
+	status = 0;
 	if (!xscr1) {
 		result->ptr = xdl_malloc(mf2->size);
 		if (!result->ptr)
@@ -731,9 +740,9 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	xdl_free_script(xscr1);
 	xdl_free_script(xscr2);
 
-	xdl_free_env(&xe2);
- free_xe1:
+cleanup:
 	xdl_free_env(&xe1);
+	xdl_free_env(&xe2);
 
 	return status;
 }
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e36f24875d..a6f10353cff 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -414,7 +414,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	 * ranges of lines instead of the whole files.
 	 */
 	mmfile_t subfile1, subfile2;
-	xdfenv_t env;
+	xdfenv_t env = { 0 };
+	int status = 0;
 
 	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
 	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
@@ -422,15 +423,18 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
 	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
 		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
-	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
-		return -1;
+	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0) {
+		status = -1;
+		goto cleanup;
+	}
 
 	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
 	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
 
+cleanup:
 	xdl_free_env(&env);
 
-	return 0;
+	return status;
 }
 
 void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
-- 
2.37.0.913.g189dca38629

