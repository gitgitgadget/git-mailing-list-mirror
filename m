Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD913A8CD
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741572; cv=none; b=Zh4TC9uNAbjHeiVoK9aNj6ke7QBnQY8l/gSf3RpSsiBeSnwFilCRYzfOp5Wn+cvzZvLnPO6CrnkpVvH1UtJPqQIieyi7bB/p3nbJ8uAYvY6B2Sw1RZmFCDJLckI4VBDRhcFQxVXGeCL5fm/bCdqDNLy1W963lmWr4jR3YDF/wU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741572; c=relaxed/simple;
	bh=aF0u7+G9GSIyMTSV2Bc1s6QZ1I15D85QNDParD6BJbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtKAtnY0dgVr7gwjcpIucbAwJblS+S+lijJJL6bZSBEE+9e7EgW7mfqPav/3Ln45bMIjQHygXHSDLczY9cRKsJsaOuYct9kCFSya56GRdTOTLEHYzYYkr3F2f7jnOV2wxD5DMFFrJNAb1MeNH3gSCbu6f7CNGfPxY7i7/9QUoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KnN8wrTJ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KnN8wrTJ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e11cda9f6fso145222a34.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741569; x=1707346369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr+uHGJQfKi8Y8GV0ULJwVjZzWQtlGzGmxiIZWQixu0=;
        b=KnN8wrTJ3CDqRh0RBHGLyHthpeXt61FS7qy+aJUqYu3bwentaDjYCj2lxJivAuj7Ng
         NBsb6sgEFZ7HKRFqkb5A7b1t3Kh5Iwjy4bnz+m6yJZSjmPbL5O3Y5aLQXAVP9ws1wNza
         d0NE+Qdel+YvfFdUuGVrf9hwkSuRklxyV/6V0YQ1DWhhcfpaM/o8A6+BuZ+fD4BzUbmg
         JLLa6sVCfk0aFhaYDMEITOEuqZtQixY5Dx4ZqMoCgu9nEMcgbciLtjPahJllRKPFV5pZ
         coAMSv8p70W+DBlEs1FeevTjAcgmF3yc+hcWTo5J0QO40nAlXghaFyrX/8nd1/C5yWL/
         Y4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741569; x=1707346369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr+uHGJQfKi8Y8GV0ULJwVjZzWQtlGzGmxiIZWQixu0=;
        b=EdtKHARlG4OnUCM9soXjjGuA2E+muJCFFvG4KaC8zGulKe8p5g42m5jcZCpCtsaZd2
         bNtc+wN8jXmsbxZDykcN9QMCDwZbKJbuUuTd1Z+GMpTklNPvZnNZZxa7+9BKphn8rY+U
         WAfiaSGMrnHnv7QiU+dZ5wZd1lwmXCp3bMqiK4j7gAarqv3ZDnV1VzBKlHa/VrIP2XjH
         U7KaUpcDrVwahpFr5ykMpr02RlRnR5J5asogSNhOrDFd4EaKyOsz/kUJvWGqhcF/bmJY
         Q4bX/MzsUlRlI0Hf7+zF5a9qbgunOVvK+0i6memz1On9CDF7Me9DxTMNA3ajVxntvrA3
         3s6w==
X-Gm-Message-State: AOJu0Yy8vDU64EMnz+w+ZdGIo4DUykgu2aIZ8Mnltothza+c0PzPV+mI
	4f5JD9URn/RRjNFazoWs9x6sa3PHvL9gd1/kwy8swFV9nJaBng/PVQeS7/CzLwxITwGBYLC8QaQ
	WIc4=
X-Google-Smtp-Source: AGHT+IGfWWwVybbzSdcElNsyKk8glzr3A7B6FDVWEEhWHyH7CbX3pNu9flUarDaKP1WKoX6ytA3VNQ==
X-Received: by 2002:a05:6830:1256:b0:6dd:e00c:8350 with SMTP id s22-20020a056830125600b006dde00c8350mr2978984otp.15.1706741569684;
        Wed, 31 Jan 2024 14:52:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ck9-20020a05622a230900b00427e0e9c22dsm1092042qtb.54.2024.01.31.14.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:49 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 11/16] bloom: prepare to discard incompatible Bloom filters
Message-ID: <d4995ef6005b2b00d4d42dc6bc1e65006ff6faba.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

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
index e64e53bc4c..c24489dbcf 100644
--- a/bloom.c
+++ b/bloom.c
@@ -220,6 +220,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
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
@@ -245,7 +262,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if (filter->data && filter->len)
+	if ((filter->data && filter->len) &&
+	    (!settings || settings->hash_version == filter->version))
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/bloom.h b/bloom.h
index c9dd7d4022..052a993aab 100644
--- a/bloom.h
+++ b/bloom.h
@@ -108,8 +108,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
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
2.43.0.509.g253f65a7fc

