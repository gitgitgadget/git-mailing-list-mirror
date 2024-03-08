Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2D4CE05
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907278; cv=none; b=GWt7oSvMt1wYVbbqBce7N8r07WghT9Jt+PVeCDZRuReJmObNOrw9qHJbvOxRQYO8g+3MYKY5gfp3rWB7zxUN6hQ2ITeOU4DKK0gyZ853OHqU0e3dRw8ZcqfCfAyWjT6FG+uKyxpK0JtVMA+i65Sa17ZlAH9XfEAD62sV6mzBwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907278; c=relaxed/simple;
	bh=T5XxBEBaYuACA2GrzRCBSpRuI9t7YZuvFVR64MSqJ+E=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZZTJKbdvqZAySzYZHW3B/7Xr5zrQWSSqh6OHsBzp5R/T3lc61IuNOCtuLVUJcdkIiXStYtv2JK6GYOA/0nnWeXbChpm5BqhsuZ+X4dZqzR2jx3ZE7+Pe8Ij2ewMiJZboWremaWfW5wzByjzvKjFidvGYIA3LiKIYbpqIeQdmIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1RX7Zwj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1RX7Zwj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e383546c1so1272843f8f.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 06:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907275; x=1710512075; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IQe7fFSBIOKmZgTGj08sFRGzDizk0S4zIjA9PLPARo=;
        b=Y1RX7ZwjKKGTOtmoRJqxylAM8tQqTEu8gdqwMbAy3vSruWWZTPlWXSwX06OizVrC1o
         bp8uyLoSX0lH8tu/jiul/0XmvPxg9aYhhR/uPp8Fpbs8uwvHFJouallkvn3RUPChZtLx
         Y1GJ7iPALLCwSGo5xhjICf3nuOqF0Oj4JiVoSMBYqNRpLzImzOxidhHxHLTeS5P8mRct
         Vnfa9JUsF3UkaA6k84q/4KOvsQeuGVS+wXqAMPg50JmHqzB0LIDPBOocvnUNtQOnXCLX
         mPPOciDrum15BDvlBL+tiGss862uozGyFRCucO+W/0YS8nQynghGttT/xnePa7J3UH/x
         BSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907275; x=1710512075;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IQe7fFSBIOKmZgTGj08sFRGzDizk0S4zIjA9PLPARo=;
        b=OI23W6eq74tOZ8CJL6GE57TpXHzpBkn4/gt8gDuG+UyOHp34M8WExCRiRMyxzo59Ri
         xRI/kpYiTuxXkP55YEIIzDgzDPLGVgYdAoYJvm2T4/puVIewePGeuYezRd30ZvKwdVA2
         CTQanXQzuAoJ9hqMMaj5lPIbiv1W7yRYRxDAtV2FSbnvnVZSTziTavjWEfPDsZGcXJMU
         t/4Wln/XX7ExAuwAeQcIFZwkHs65uB9ieccGAze107tVP2m0+CEd6LgbN+s4AW0x9xRC
         EJyJHZBSfAiyHDF5IxmazVqmzXP8fAxxwyVKJrnf2Ths51Ct3Vt1yLla702OZPVhs6Wt
         wItw==
X-Gm-Message-State: AOJu0YxJRbgjtI7hC8s+5EpRXV7klbRFuW6T1MCRGdL1O9aqJZ5ikMaf
	9w3avVyAeorMlm4bDj+X5GrPx2z9y6+S7HkpmkCJoyvZvTOjepq0yLiZTVxf
X-Google-Smtp-Source: AGHT+IEA/BkbTnFb169cumJxTfE7VsC8kQxX9IyHrvZc2+OoxogsAl0vug9h5zBOVPFwWb1UvIpfow==
X-Received: by 2002:a5d:6d8b:0:b0:33d:354a:99b2 with SMTP id l11-20020a5d6d8b000000b0033d354a99b2mr19163765wrs.3.1709907274616;
        Fri, 08 Mar 2024 06:14:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv28-20020a0560001f1c00b0033d70dd0e04sm23377341wrb.8.2024.03.08.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:14:34 -0800 (PST)
Message-ID: <c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 14:14:29 +0000
Subject: [PATCH 3/4] merge options: add a conflict style member
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a conflict_style member to `struct merge_options` and `struct
ll_merge_options` to allow callers to override the default conflict
style. This will be used in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 merge-ll.c        | 4 +++-
 merge-ll.h        | 5 ++++-
 merge-ort.c       | 1 +
 merge-recursive.c | 3 +++
 merge-recursive.h | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 6570707297d..bf1077ae092 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -128,7 +128,9 @@ static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unuse
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
-	if (git_xmerge_style >= 0)
+	if (opts->conflict_style >= 0)
+		xmp.style = opts->conflict_style;
+	else if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
diff --git a/merge-ll.h b/merge-ll.h
index af1ee36abdb..d038ee0c1e8 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -78,11 +78,14 @@ struct ll_merge_options {
 	 */
 	unsigned extra_marker_size;
 
+	/* Override the global conflict style. */
+	int conflict_style;
+
 	/* Extra xpparam_t flags as defined in xdiff/xdiff.h. */
 	long xdl_opts;
 };
 
-#define LL_MERGE_OPTIONS_INIT {0}
+#define LL_MERGE_OPTIONS_INIT { .conflict_style = -1 }
 
 enum ll_merge_result {
 	LL_MERGE_ERROR = -1,
diff --git a/merge-ort.c b/merge-ort.c
index 4a02c3ecd99..a9ab4031451 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1966,6 +1966,7 @@ static int merge_3way(struct merge_options *opt,
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
+	ll_opts.conflict_style = opt->conflict_style;
 
 	if (opt->priv->call_depth) {
 		ll_opts.virtual_ancestor = 1;
diff --git a/merge-recursive.c b/merge-recursive.c
index 02b7b584f95..33b5f9384e8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1054,6 +1054,7 @@ static int merge_3way(struct merge_options *opt,
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
+	ll_opts.conflict_style = opt->conflict_style;
 
 	if (opt->priv->call_depth) {
 		ll_opts.virtual_ancestor = 1;
@@ -3899,6 +3900,8 @@ void init_merge_options(struct merge_options *opt,
 
 	opt->renormalize = 0;
 
+	opt->conflict_style = -1;
+
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index 3d3b3e3c295..e67d38c3030 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -31,6 +31,7 @@ struct merge_options {
 
 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
 	long xdl_opts;
+	int conflict_style;
 	enum {
 		MERGE_VARIANT_NORMAL = 0,
 		MERGE_VARIANT_OURS,
-- 
gitgitgadget

