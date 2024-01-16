Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3934208D0
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442981; cv=none; b=YtkAOFj/P14gL/Xy1WrmxziurkPesyMRWDrXTu97T2DksIwZcV1odOKb/i0KAY7IDccdnJnXytk3lxCgwCIDwro9NzTPxaxmev71OEYV3Wi7sd9UeHRLF01iSiGQkus67ewGurk+dpQ0vbml6bvtBgzejwByKQ+xMqlxJaEHBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442981; c=relaxed/simple;
	bh=PFihLOAGJeiXFMOkopSLql7ALrJgI82J0XketBAPwT8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DdNSEHHufiIqDVf54gBXxjmlHqAgSlh2AVlKeTGLhzPnc2oZjOVDsBdx8LtwzMDYzKoFyUkyd6XqMkqhjIVURj6YIeYCaLyHBoP/R5ah+m2oLv/anxOHrmWC7PA3GveodK2ymkarXJlCAJw8elcI0PrnHs7IFpL9JWbG4NdQu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kQp2vfQs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kQp2vfQs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78336bfc489so818661685a.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442978; x=1706047778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsr4MwU9Zr9AKyAeizHU6UWPXptne0C0hlPQNbr05lo=;
        b=kQp2vfQsb50tixTEpQZGagdvs7piK3DRso+DuT2EWfsP/+s+W7oCMswbOyvH0l0f7f
         a1txUrkKJR2KRWRQKgTMgwLI8SJb9g5Q1fAo0ybSgi3jNlEvgY906jfzxfgKkIpRriAZ
         OcXi0Q8KUiT8ksdWSN/Oj06VlVGg0MA3/KOxHAyyT526EiQbiuJdDy15Z3oq940Jjx+n
         Sjx3JEL3sh0vJc0mM2aFKxtZPMRXAZrUmj2B9vjCm0/hnl4jZlrgDlox54CHe/BSTsSb
         6ibau8cJImlpPlGKEZCoulc7j+Ss6qeFeupavyIRDoaVf2FxEo88+DMjKLL2JlqecTLZ
         1WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442978; x=1706047778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsr4MwU9Zr9AKyAeizHU6UWPXptne0C0hlPQNbr05lo=;
        b=EuZOIMCwB/QeH+S32Hk09w1wj8xMheVixww0kWqCuLXfu6KI3AaFd/7CghCR6emGf7
         idWXLhDArMnTEjP5s+mYvX5/Yw9EAhyUtb5Ml78HGSN/3NofjHLFjfFXmMdWcMobYBBU
         vF3h8LKak5dJA8OovhJ+LrMKx3VWwwVBSTJ8SsbUPgbCym+YItQ6/H/JT0cXOWxaiLoY
         vLPn/a6U9MKyQXklp9snFLklwytHvQUo3GxSNpqQ6qLbFJaROkPAEk1Vj1y8N5YeAHCk
         c/lg7Sb4CZUVJz5AFodSGP+04yk+mB9QtxtHc/peonylDreNH00u3JbCBW/IB4V9Qp5/
         O34g==
X-Gm-Message-State: AOJu0YxSG3Nl05Nbm98oHWcV04r+SmSf5KryznwL0AJ8wtHgnRN7d6T7
	LU65x31B5KJZ5db7h5HnZQny9y6GgpZiQBcJjCKd471L6dWZpw==
X-Google-Smtp-Source: AGHT+IHdigsRNV7WfzCBocyd/lzjNq0Ce3TxDKrorrwii0JDTbsx3tjM2cTnNo5dQMyLvH5/HR0g1A==
X-Received: by 2002:a05:620a:8420:b0:781:7591:80c8 with SMTP id pc32-20020a05620a842000b00781759180c8mr8360899qkn.86.1705442978419;
        Tue, 16 Jan 2024 14:09:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a10bb00b0076db5b792basm4029335qkk.75.2024.01.16.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:38 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 12/17] bloom: prepare to discard incompatible Bloom filters
Message-ID: <ddfd1ba32a0ea03eb8297f6700b24690eb63e684.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

Callers use the inline `get_bloom_filter()` implementation as a thin
wrapper around `get_or_compute_bloom_filter()`. The former calls the
latter with a value of "0" for `compute_if_not_present`, making
`get_bloom_filter()` the default read-only path for fetching an existing
Bloom filter.

Callers expect the value returned from `get_bloom_filter()` is usable,
that is that it's compatible with the configured value corresponding to
`commitGraph.changedPathsVersion`.

This is OK, since the commit-graph machinery only initializes its BDAT
chunk (thereby enabling it to service Bloom filter queries) when the
Bloom filter hash_version is compatible with our settings. So any value
returned by `get_bloom_filter()` is trivially useable.

However, subsequent commits will load the BDAT chunk even when the Bloom
filters are built with incompatible hash versions. Prepare to handle
this by teaching `get_bloom_filter()` to discard filters that are
incompatible with the configured hash version.

Callers who wish to read incompatible filters (e.g., for upgrading
filters from v1 to v2) may use the lower level routine,
`get_or_compute_bloom_filter()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 20 +++++++++++++++++++-
 bloom.h | 20 ++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index 9284b88e95..323d8012b8 100644
--- a/bloom.c
+++ b/bloom.c
@@ -283,6 +283,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 	filter->version = version;
 }
 
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
+{
+	struct bloom_filter *filter;
+	int hash_version;
+
+	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
+	if (!filter)
+		return NULL;
+
+	prepare_repo_settings(r);
+	hash_version = r->settings.commit_graph_changed_paths_version;
+
+	if (!(hash_version == -1 || hash_version == filter->version))
+		return NULL; /* unusable filter */
+	return filter;
+}
+
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
@@ -308,7 +325,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if (filter->data && filter->len)
+	if ((filter->data && filter->len) &&
+	    (!settings || settings->hash_version == filter->version))
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/bloom.h b/bloom.h
index 330a140520..bfe389e29c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -110,8 +110,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed);
 
-#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL, NULL)
+/*
+ * Find the Bloom filter associated with the given commit "c".
+ *
+ * If any of the following are true
+ *
+ *   - the repository does not have a commit-graph, or
+ *   - the repository disables reading from the commit-graph, or
+ *   - the given commit does not have a Bloom filter computed, or
+ *   - there is a Bloom filter for commit "c", but it cannot be read
+ *     because the filter uses an incompatible version of murmur3
+ *
+ * , then `get_bloom_filter()` will return NULL. Otherwise, the corresponding
+ * Bloom filter will be returned.
+ *
+ * For callers who wish to inspect Bloom filters with incompatible hash
+ * versions, use get_or_compute_bloom_filter().
+ */
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c);
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
-- 
2.43.0.334.gd4dbce1db5.dirty

