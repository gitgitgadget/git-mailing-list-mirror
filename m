Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B39378D9F
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149331; cv=none; b=GzWXtUNo7zqekQAaEJey/KBeNW62gOE3myyWVT4KIj87zUv2A6H531+1CJSwbdCpp/uA+hB5h2vNJCeIWoK/elCfCBWqAHdFdGCJZplp06WgMF7o5KgESOxfHg6RJUoiuofMcxN2yDYT1QgbfGENAK/QA6iHVyw8oC5uQrkFkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149331; c=relaxed/simple;
	bh=uZF39K18cfLnVUJg3WEkkLcu09VNV3AAZ/PIio2zEPg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ubft9OV/U3kXn3vMA4XV0OzsQkIwkL4VJNEqphRljjcyTCkZvJlSWXbFk2tbVYe54vzc0/UijNxcOB/E6u5j3sidbI40f82pW+v/TfIhYkopqyyXwwBgwo1RR57sjrw6d4tHEcDsQc8CImkxJZryHxX4Zrk7CBgfDKW+NBq0GC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3MYgq1d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3MYgq1d"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8e5be46f663so18091016d6.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149329; x=1784754129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uIVDa9HCBNGi+Nd6d4sUOasWsoiXn/awu2Lc5ntsm60=;
        b=C3MYgq1d6/JMAB4XRgjFMaUa7CbiKoYxA41Ny+5JMd+92eHK932ZmfebZtHLg5Bokw
         iXSZ8RYo4T7HJR7AOW3yY/zHm9WGNC9P/tHKaP2F5F/zlkivOgXbtuYxUFGkP9RPbQgC
         lIhv6+w8UwXxWUuDs/geo0CsF9njX4xt8nMAF0mcJt5ehgsiasgaDdLcRkDISXDoKtiS
         ZuZ3ReWkkc5fJStHGfftBO4WAVZid6Hjzuzsmxqk3KptAIcZ5dBgd2dS/PJcrq9cRTyt
         TBYc3BzGtLCz+gxSicWDe4W49FcjmPcXsBEsTAH4cs0jfxARV35Ny/I6ue1DC0hf/RnS
         juRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149329; x=1784754129;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIVDa9HCBNGi+Nd6d4sUOasWsoiXn/awu2Lc5ntsm60=;
        b=hL26wkqoUFxTqKktR3WsLAJ3Qyv4kx9bQOPi65fk06XsDjrmHr42Q2bYylr6qeGmm6
         i+4xtJKdp6Yau4BRzdgSnpPONISj+61dSo1z5y/wjTb71NJQo/ZFhZZGp3RUle1Vffbb
         liz7YQIcQS8sgyh9OKjVarHwaq9Jj+1r1c2iu4G02tQrLgT7yelUWOMkmP57DtDYfx6a
         tC/Gjyut/9qL5eBheRFH+eBeLNFu66+EkOoIPRj7gCMoLSsTJHXxAZ09E43aIWqC+ncP
         uulK/yY+CabGyjhMNzVtMkX6KKAlI+BWkrIlR/h9PCc28x2LMOtac3I+AyV0WmS0uWfP
         kR5g==
X-Gm-Message-State: AOJu0Yy1I+b2wJDCyfeJfRfMzIo+/yC5uoUWZiBqSPlwbRJvUswTZit1
	NnrrQlNDJRUGVVWWFhto9Y80I5OrPluK+/qPrYBJrdfmegiVfQl8e53SDIZEiw==
X-Gm-Gg: AfdE7ckxoiaagpUfuoCbjK93BRlYeeJ9sxYAoEjAR07+r7x+CGPzkfhJEcXFiuJz9pq
	oUtC04v88442XcktoXjFmfbTc454J1kbHBnk9qYj/Y7vEZ57x8n5PuhbnX6Oe0fAeR7+M783aWB
	vx9+APzqV0SWQD7ouFP1gxFjAn/0hAEmuHS1/IVHp2wdSOR1DW7YT7qgx2DQ0iQVeIGx8Ioyvu6
	Rj9uiRc1ATcRKNnqys9lyzs/2w/GhAUZbLy0JNYrFn8W7H4zRg5HqEaEI4oALjKgXXeQhMh8Imp
	Vh/jfFapqRfmt2YgsJmCterJINaAAp4IF4Htok5BBhVgJuzZmhQqVfMdpMmDw+pXCiJlR60Ec8I
	5Gam0QTCGeda/3HgrhomJYURqHtRLEmEipaoUrYakRP4GIZ2mBMB8hXrMpcuL/BSLWyjOIZXY2H
	mGbO828Q==
X-Received: by 2002:a05:6214:5f82:b0:8e9:f62b:8f9e with SMTP id 6a1803df08f44-90401b7dba8mr212405116d6.51.1784149328536;
        Wed, 15 Jul 2026 14:02:08 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90725bc050esm84420386d6.28.2026.07.15.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:07 -0700 (PDT)
Message-Id: <20045025497f08f3859646de8506d8f702bfc75f.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:55 +0000
Subject: [PATCH v5 2/9] xdiff: support external hunks via xpparam_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add two new xpparam_t fields (external_hunks, external_hunks_nr)
that let callers supply pre-computed hunks.  When set, xdl_diff()
populates the changed[] arrays from these hunks instead of running
the diff algorithm, then continues through compaction and emission
as usual.

Validate supplied hunks before use.  Out-of-bounds line numbers,
overlapping or out-of-order hunks, and misaligned unchanged runs are
treated as a malformed tool response: xdl_populate_hunks_from_external()
warns, returns -1, and xdl_diff() falls back to the builtin diff
algorithm for that file.  The run of unchanged lines between two hunks
(and before the first and after the last) must be the same length on
both sides; xdl_build_script() walks the two files in lockstep over
unchanged lines, so a balanced total is not enough.  Non-negative
counts and 1-based starts are instead caller preconditions, checked
with BUG(), since the caller normalizes hunks before this point.

On rejection xdl_diff() frees the environment it prepared and falls
through to xdl_do_diff(), which prepares a fresh one for the builtin
pass.

Skip trim_common_tail() in xdi_diff() when external hunks are
present, since external hunks reference line numbers in the
original content.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 xdiff-interface.c |  7 +++-
 xdiff/xdiff.h     | 16 +++++++++
 xdiff/xdiffi.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++--
 xdiff/xprepare.c  | 10 ++++++
 xdiff/xprepare.h  |  1 +
 5 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index db6938689f..1fa16af668 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -124,7 +124,12 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
 		return -1;
 
-	if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
+	/*
+	 * External hunks reference line numbers in the original content;
+	 * trimming the tail would change line counts and invalidate them.
+	 */
+	if (!xpp->external_hunks &&
+	    !xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
 		trim_common_tail(&a, &b);
 
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index dc370712e9..4736bcdb07 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -78,6 +78,18 @@ typedef struct s_mmbuffer {
 	long size;
 } mmbuffer_t;
 
+/*
+ * Hunk descriptor for externally computed diffs, in xdiff's own
+ * coordinates: line numbers are 1-based and a hunk's start is the
+ * first line it covers.  A caller translates any external "empty side"
+ * idiom (such as git diff's start-0/count-0) to a 1-based start before
+ * handing hunks over.
+ */
+struct xdl_hunk {
+	long old_start, old_count;
+	long new_start, new_count;
+};
+
 typedef struct s_xpparam {
 	unsigned long flags;
 
@@ -88,6 +100,10 @@ typedef struct s_xpparam {
 	/* See Documentation/diff-options.adoc. */
 	char **anchors;
 	size_t anchors_nr;
+
+	/* Externally computed hunks: bypass the diff algorithm.  Owned by caller. */
+	struct xdl_hunk *external_hunks;
+	size_t external_hunks_nr;
 } xpparam_t;
 
 typedef struct s_xdemitcb {
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index c5a892f91e..73a456f5dd 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1085,16 +1085,96 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 	}
 }
 
+/*
+ * Populate the changed[] arrays from externally supplied hunks,
+ * bypassing the diff algorithm.  The caller normalizes and validates
+ * the hunks first (order, overlap, and lockstep alignment), so this
+ * only marks lines changed after asserting the memory-safety
+ * preconditions it depends on: non-negative counts and 1-based starts
+ * (checked with BUG()), and an in-bounds range (a silent -1 so the
+ * caller can fall back to the builtin diff rather than index changed[]
+ * out of range).  Keeping this diagnostic-free leaves user-facing
+ * messages to the git layer.
+ *
+ * Returns 0 on success, -1 if a hunk is out of range.
+ */
+static int xdl_populate_hunks_from_external(xdfenv_t *xe,
+					    struct xdl_hunk *hunks,
+					    size_t nr_hunks)
+{
+	size_t i;
+	long j;
+
+	/*
+	 * xdl_prepare_env() may dirty changed[] via xdl_cleanup_records().
+	 * Clear them so only the external hunks are marked.
+	 */
+	xdl_clear_changed(&xe->xdf1);
+	xdl_clear_changed(&xe->xdf2);
+
+	for (i = 0; i < nr_hunks; i++) {
+		struct xdl_hunk *h = &hunks[i];
+
+		/*
+		 * Non-negative counts and 1-based starts are caller
+		 * preconditions (it normalizes hunks into xdiff coordinates
+		 * before this point), so a violation is a bug, not a bad
+		 * tool response.
+		 */
+		if (h->old_count < 0 || h->new_count < 0)
+			BUG("external hunk %"PRIuMAX": "
+				"negative count (old=%ld, new=%ld)",
+				(uintmax_t)(i + 1),
+				h->old_count, h->new_count);
+		if (h->old_start < 1 || h->new_start < 1)
+			BUG("external hunk %"PRIuMAX": "
+				"start not 1-based (old=%ld, new=%ld)",
+				(uintmax_t)(i + 1),
+				h->old_start, h->new_start);
+
+		/*
+		 * The caller validates ordering, overlap and lockstep
+		 * alignment (and diagnoses a bad response).  This is only a
+		 * silent in-bounds guard so the marking loop cannot index
+		 * changed[] out of range: start + count - 1 <= nrec,
+		 * rewritten to avoid overflow.  A count of 0 (pure
+		 * insert/delete) allows start == nrec + 1, the position
+		 * after the last line.  On a miss, return -1 and let the
+		 * caller fall back to the builtin diff.
+		 */
+		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1 ||
+		    h->new_count > (long)xe->xdf2.nrec - h->new_start + 1)
+			return -1;
+
+		for (j = 0; j < h->old_count; j++)
+			xe->xdf1.changed[h->old_start - 1 + j] = true;
+		for (j = 0; j < h->new_count; j++)
+			xe->xdf2.changed[h->new_start - 1 + j] = true;
+	}
+
+	return 0;
+}
+
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
 	xdfenv_t xe;
 	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
 
-	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
+	if (xpp->external_hunks) {
+		if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
+			return -1;
+		if (xdl_populate_hunks_from_external(&xe,
+						     xpp->external_hunks,
+						     xpp->external_hunks_nr) == 0)
+			goto diff_done;
+		xdl_free_env(&xe);
+	}
 
+	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
 		return -1;
-	}
+
+diff_done:
 	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 11bada2608..f4ab935332 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -471,3 +471,13 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 	return 0;
 }
+
+/*
+ * Reset the changed[] array so that no lines are marked as changed.
+ * Also clears the sentinel slots at changed[-1] and changed[nrec]
+ * that xdl_change_compact() relies on during backward scans.
+ */
+void xdl_clear_changed(xdfile_t *xdf)
+{
+	memset(xdf->changed - 1, 0, (xdf->nrec + 2) * sizeof(bool));
+}
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
index 947d9fc1bb..0413baf07b 100644
--- a/xdiff/xprepare.h
+++ b/xdiff/xprepare.h
@@ -28,6 +28,7 @@
 int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe);
 void xdl_free_env(xdfenv_t *xe);
+void xdl_clear_changed(xdfile_t *xdf);
 
 
 
-- 
gitgitgadget

