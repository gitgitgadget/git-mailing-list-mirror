Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B420DD7
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442977; cv=none; b=KtuAPlpK6uOUJE717pYwMDD1iJiU/06Pbt+eOLGxTgeCmnflfFBtBFUrej1Wg1nZ7jEQgZHIM9d0tIZkF+Ab3c7Y29Z3igT6G6+v9GWHkL96RVrLHZKw++mvV/DvGXqyiZlCAmc5v0AxJ8KboUcpfK0ALH7wBidGm9bOdrtXIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442977; c=relaxed/simple;
	bh=/tYvyrWw8Z03OpIP2g2toYGv5Z/FbuT7FVFBM8CivB4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SxygqK4CREfdCW396tI50hmymbDxNuh3Ffut400IxPeLfWX/yz6yrMvu7CWkh1EhbmSFgPhkF3pq10BhgkW919snmISO+8PdKWAsxfkpaIOEZS6a7n6ix2OFnufRvPJNmXtXnHEkoNtylh4PgSUsSP4Biy3hCTJDGeMp0Lb9/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mAJ23vva; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mAJ23vva"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7831c604a84so766778185a.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442975; x=1706047775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1X2EQuxGdrpinUTRzo9QBjTczTIMyYB3Z1D8Gx3CFGo=;
        b=mAJ23vvaYnebVkkfrm89Jb+GFaoACefQCtmUKxgxGLGiG0VY5R4a7O9JzEeSHe4WHk
         iqixQi0+OlkboSlvYum+vay6+qHTD/dT7UGElQ5/Q+cCBvCqjORVGziOTvNY1UK/d/hR
         aWWqq6nyJlC9Uyda5TrP87Jn+XvE70EI4kMSSE8TvpHdPppjajoAxON2sbDFkLfUh2w/
         2OfckLaja0Y+705cVaLX88VfnmKqyYCBWWwGFHbDzuW12mrEiHW1SzVGrHDUVsoK7ZC/
         Ec5pRzXv6JL1E6slKBEWVIqY56RY+VLrQph661SZgrvYx+JKfa5AcE4cWHUFNIiIzatj
         zQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442975; x=1706047775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X2EQuxGdrpinUTRzo9QBjTczTIMyYB3Z1D8Gx3CFGo=;
        b=lS4EjV3dRnFgU7/r/AgQVNK4W312AL/euD++Z+pQ6X6DVJAns2SE715i2S0tGtyBmp
         1+L0na+e3O3Z+rpPv66vJvPjQIbarrHXBkcHqGRBcA6hUfyS8H4bQS8ADjNhJs7itegz
         x1Q7ZQHrNlTxixoT0vhlGAKHciWYk3j0vzR1E2jvOdMF8a8KOAjw4YzOPoPRc+H+7PYI
         CarrmiQAg0WThbkW0Q00OHc0XVg+97fD+gtKWpDW2Timk1naaotd9l79h2DEvNkr+4qq
         vYOu3QujYPZOf+2BlNO4+uBctXWmB+i/BrbT9nPKB1rlhGRep9AshxRUpZIdhAxDJQmZ
         bNnA==
X-Gm-Message-State: AOJu0YxWG9yacj60NNvnlhMAISPoDHmkVjAy8rTZw8KJC8vyNHeYwjEU
	E6xQBjBikx7eLmFx833UMVmxF71xQyGsmOw08wn/XHTAvv7UQQ==
X-Google-Smtp-Source: AGHT+IFc5B+iQ9TnJYe45P5TfyiQGGlts7h9x7UR2nT5kSROahvQtIM0No6vci7yHp+mv9ELyIqMFg==
X-Received: by 2002:a05:6214:1cc4:b0:681:563d:1003 with SMTP id g4-20020a0562141cc400b00681563d1003mr5892072qvd.113.1705442975364;
        Tue, 16 Jan 2024 14:09:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ee14-20020a0562140a4e00b0067f64c06bcesm4488080qvb.102.2024.01.16.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:35 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 11/17] bloom: annotate filters with hash version
Message-ID: <b56e94cad7379e229b4a915d378ca2a036864c73.1705442923.git.me@ttaylorr.com>
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

In subsequent commits, we will want to load existing Bloom filters out
of a commit-graph, even when the hash version they were computed with
does not match the value of `commitGraph.changedPathVersion`.

In order to differentiate between the two, add a "version" field to each
Bloom filter.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 11 ++++++++---
 bloom.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index e9361b1c1f..9284b88e95 100644
--- a/bloom.c
+++ b/bloom.c
@@ -88,6 +88,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
+	filter->version = g->bloom_filter_settings->hash_version;
 
 	return 1;
 }
@@ -273,11 +274,13 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 	return strcmp(e1->path, e2->path);
 }
 
-static void init_truncated_large_filter(struct bloom_filter *filter)
+static void init_truncated_large_filter(struct bloom_filter *filter,
+					int version)
 {
 	filter->data = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
+	filter->version = version;
 }
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
@@ -362,13 +365,15 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		}
 
 		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
-			init_truncated_large_filter(filter);
+			init_truncated_large_filter(filter,
+						    settings->hash_version);
 			if (computed)
 				*computed |= BLOOM_TRUNC_LARGE;
 			goto cleanup;
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->version = settings->hash_version;
 		if (!filter->len) {
 			if (computed)
 				*computed |= BLOOM_TRUNC_EMPTY;
@@ -388,7 +393,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
-		init_truncated_large_filter(filter);
+		init_truncated_large_filter(filter, settings->hash_version);
 
 		if (computed)
 			*computed |= BLOOM_TRUNC_LARGE;
diff --git a/bloom.h b/bloom.h
index 138d57a86b..330a140520 100644
--- a/bloom.h
+++ b/bloom.h
@@ -55,6 +55,7 @@ struct bloom_filter_settings {
 struct bloom_filter {
 	unsigned char *data;
 	size_t len;
+	int version;
 };
 
 /*
-- 
2.43.0.334.gd4dbce1db5.dirty

