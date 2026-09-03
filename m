Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C673890EC
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411929; cv=none; b=Ft5JMXqP/dOH5U1c0/EBbjhUqL0mP3JqGAiwdvx0DGXmojVuFuBd7qtsv7APec57olr65Pp1BVTK66EoZn7ViE0ToDSObWGidiFcNZDYgkuMs1I9f3zZphe3YG0yy9o/BckjDCEqBMw433hBoxGl4Hwj3E74meAaLbBNuywMimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411929; c=relaxed/simple;
	bh=bk9Jx45bHrnJeZJXRE5UIXDJfx//PSiBYU6PNmYCLRE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=icIBSSAI/iMlMP9/+3uTr++9NBKmwS6BL1xORnxO7Yownr/hMybxMjw4dAJeZfyJFarJHgUqPYEuO0ASt47qj2l6cvfR8smvW4eE7j+sdbh903TR3KjiYVyT3CN67D7SWCJrC9RViji2f3YNXrecE+rhb6RqyiY2aYm4CFzGHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Obk+GElF; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Obk+GElF"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cc107c451so12468426d6.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411926; x=1789016726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iiZUNxUXB7pL/0ftCqPCiMRI1K0XnxDWsFliDPMMDEI=;
        b=Obk+GElFsfK9fGqkkLr+GMUMPZC9o5oTbQgeUc1QcJ6+GO+364/4n9gGcSsKS1wVnR
         u9lbP4yavDmCbHcIPC/xg3E+DPAD8BuPYRczxL4M/ya+aNVj0WAfpGRI7jDxbT1/PKkA
         Ks1YI8tiQ0nDyhQr35sNKus5tG1eHxaHVYCrBrqmsupTE9JFtvgAVMERJYIOmb4K0/Hf
         oRLh1xmkyX7g+O7OX0cpjji9yk/bNY/sruISFu1dLBwE7woeCwg9PAQB5pT/MdWt5KcN
         X+CsRa9L7IWR0z4L8ldictFl0YOb6efw+65IMpQQ9GrvaKPMa/qlL0P3O7r2ZjKP3gnA
         MVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411926; x=1789016726;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iiZUNxUXB7pL/0ftCqPCiMRI1K0XnxDWsFliDPMMDEI=;
        b=mc1w796lFqbyfTfgqT+BAZDxEwU3WOeujbSyB+Os0ANYFp57KhFBZ61Gc0e2P3B/Jz
         eePwYRnZh6M/a/BJ3aqVVRuYAQLpr/IOG2VF1DMRiWqaCFrjNS/rJPwzuhszxua5OyiX
         8o894Ygh7a28lCqSvRggulAKtm4pB7inKJtSVWIkuA+F4o7yi6mI0Wesa2GHJYiYOitY
         J5BRavCnqHgWhMubbEP5dDv1zXrRwa7B49t5+qBthqh11tQnrNlhC8ixd43nVHGK9hFv
         5SskcT/Tvy7Ds/FtKRtbTkafIYHv98qr43j1qxBWhSL5x19W7xFXcXAqOBqWuC2PFCOX
         gsTQ==
X-Gm-Message-State: AFuF++kYohpDXf+Ne97z9vh3XoJjjYshzqWNCEqQFthsLyzquwIDuKV/
	9A4XU/jx0UK7xd6IgVgYS8EX2L4iiA+sufrSHztsQxJ6IdPCQ5hPvekeD4FxktjB
X-Gm-Gg: AYBFou3u20q4+8L3S2DLqDLeaoKDeW1KNx32+5zUkFDM659a57lJXH9EWjAup7Zk0lu
	zPWUt5IS+LMZvK1HfpUUIsdktJkZx1DfFEGYjDm3gTxsTaA4U53fkZ+K8lN3vl1syw82dlky5/s
	2J72btEViJQG2AP/DnkBwqkWkDAmqyAKszgQZJYOg565F4Oq7q/ddySum9RODzKjkOLqVV2mGYi
	fvAGQMHTNOHe0n1RagvygyaD0X8mDOoUpH7/r/FwEhgec6GLiUPm2kkCbtF8gd93V9vE9wUp5ks
	HVs+7/MTOFhrNPLNa5fQ/5PnMGzTg7tO5zOnBQPxw1Fre0ec8Vzt10IIEAXVIey0N9FWDL4GJm4
	+DRYb/o65xi4Zc5ocVD1QYlezOM03obd00iGOudSma+hOPPzETrsNBeGd3EdUb4wZr8xU85y2P8
	cv3L1yhd8aN8R3KvTrWfcNpAwDSvyIBTNYBbLyD6l5yZog7xi/E6nAJZAFcsNungRn
X-Received: by 2002:a05:6214:2b89:b0:90e:9aa6:dbea with SMTP id 6a1803df08f44-90ebabc5101mr118183806d6.24.1788411926037;
        Wed, 02 Sep 2026 22:05:26 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm34405556d6.2.2026.09.02.22.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:25 -0700 (PDT)
Message-Id: <6b13c13ae72a24504aaa23be8d63571e6197aa1e.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:16 +0000
Subject: [PATCH v3 4/7] diff: extract a line-range diff helper for reuse
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Extract logic for initializing the line-range filter and running a diff
for a specific line range. This logic is needed for any diff that
targets a line range independent of the current patch display path.

The subsequent commits use this logic to enable additional line range
targeted diff modes.

No logical behavior change.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c | 87 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/diff.c b/diff.c
index cb1a85c624..a7604a773a 100644
--- a/diff.c
+++ b/diff.c
@@ -2517,6 +2517,18 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
+static void line_range_filter_init(struct line_range_filter *filter,
+				   const struct range_set *ranges,
+				   xdiff_emit_line_fn line_fn,
+				   void *cb_data)
+{
+	memset(filter, 0, sizeof(*filter));
+	filter->orig_line_fn = line_fn;
+	filter->orig_cb_data = cb_data;
+	filter->range_sets_to_filter_by = ranges;
+	strbuf_init(&filter->accumulating_hunk.lines, 0);
+}
+
 static void begin_range_hunk(struct line_range_filter *filter)
 {
 	filter->accumulating_hunk.active = 1;
@@ -2650,6 +2662,37 @@ static int line_range_line_fn(void *priv, char *line, unsigned long len)
 	return filter->ret;
 }
 
+
+static int line_range_filter_diff(struct line_range_filter *filter,
+				  mmfile_t *mf1, mmfile_t *mf2,
+				  xpparam_t *xpp, xdemitconf_t *xecfg)
+{
+	const struct range_set *ranges = filter->range_sets_to_filter_by;
+	long max_span = 0;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ranges->nr; i++) {
+		long span = ranges->ranges[i].end - ranges->ranges[i].start;
+		if (span > max_span)
+			max_span = span;
+	}
+	if (max_span > xecfg->ctxlen)
+		xecfg->ctxlen = max_span;
+
+	/* the filter seeds its per-image position from hunk headers */
+	xecfg->flags &= ~XDL_EMIT_NO_HUNK_HDR;
+
+	ret = xdi_diff_outf(mf1, mf2, line_range_hunk_fn,
+			    line_range_line_fn, filter, xpp, xecfg);
+	if (!ret) {
+		flush_range_hunk(filter);
+		ret = filter->ret;
+	}
+	strbuf_release(&filter->accumulating_hunk.lines);
+	return ret;
+}
+
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old_name = a;
@@ -3994,49 +4037,15 @@ static void builtin_diff(const char *name_a,
 			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
 				      &ecbdata, &xpp, &xecfg);
 		} else if (line_ranges) {
-			struct line_range_filter lr_state;
-			unsigned int i;
-			long max_span = 0;
+			struct line_range_filter lr_filter;
 
-			memset(&lr_state, 0, sizeof(lr_state));
-			lr_state.orig_line_fn = fn_out_consume;
-			lr_state.orig_cb_data = &ecbdata;
-			lr_state.range_sets_to_filter_by = line_ranges;
-			strbuf_init(&lr_state.accumulating_hunk.lines, 0);
-
-			/*
-			 * Inflate ctxlen so that all changes within
-			 * any single range are merged into one xdiff
-			 * hunk and the inter-change context is emitted.
-			 * The callback clips back to range boundaries.
-			 *
-			 * The optimal ctxlen depends on where changes
-			 * fall within the range, which is only known
-			 * after xdiff runs; the max range span is the
-			 * upper bound that guarantees correctness in a
-			 * single pass.
-			 */
-			for (i = 0; i < line_ranges->nr; i++) {
-				long span = line_ranges->ranges[i].end -
-					    line_ranges->ranges[i].start;
-				if (span > max_span)
-					max_span = span;
-			}
-			if (max_span > xecfg.ctxlen)
-				xecfg.ctxlen = max_span;
-
-			if (xdi_diff_outf(&mf1, &mf2,
-					  line_range_hunk_fn,
-					  line_range_line_fn,
-					  &lr_state, &xpp, &xecfg))
-				die("unable to generate diff for %s",
-				    one->path);
+			line_range_filter_init(&lr_filter, line_ranges,
+					       fn_out_consume, &ecbdata);
 
-			flush_range_hunk(&lr_state);
-			if (lr_state.ret)
+			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+						   &xpp, &xecfg))
 				die("unable to generate diff for %s",
 				    one->path);
-			strbuf_release(&lr_state.accumulating_hunk.lines);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
-- 
gitgitgadget

