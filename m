Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CD57302
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442996; cv=none; b=J9cG1kmDirBCEG+37dlK+MFRCsayNllXrsWToMJvbm4IPDRrBVb1ibh8Bql4TwD/Q3k7OyWH8g6EEpOJDn5K/SamYg32pkGnL+khJvcnpUt7nY7586ecVgYdEJ6Awh1O3r0N/5px6usFzvQ47OlLUGdcg+UwOl1vaq23DEBfCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442996; c=relaxed/simple;
	bh=jXv0e7vl7xxRbLuml1Ep0eWejDjf4awpXIOYEIfYS9A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=POfcjfNDLg/57vD6cP8sr6PX7CpQHljDN5E6hlqkB9+aiwBTJwYSzaXikY1zm9NoLXpOpbQK/roHXJm+qDkDkKsPrNY47iLjyasNnLcSRrFoGHSzcmebfryS2e+yvkfaS1rdhxG53cqPwioyrHat8j8QrXk51A0SQRV0JIpvj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QfDdPVTC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QfDdPVTC"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68175861f3eso4618516d6.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442994; x=1706047794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20F2pHVGsJi0lMQBok531KeHnqA3E6H/Lw1Uc5J8/FI=;
        b=QfDdPVTCXUsFNgu9bIShZvOJyc0mD+R8t1EXFibdW8KRXaswPSeBH8Eannfev9wE6j
         hikQnC4cn5PutQBVm0QKIudJW55xz9Dtg/PNgNuzQKvy1UHYcUKdxyBQH1iieBxGzqr5
         H+bLwie+9Z6KXE92mmtXZyrshsnEZw+nhSfPLcewZ8IG77vM1En8+2fxZ9c6AsfvpuIh
         VF/9igc8/vmgbKjt3UvYzDIP5dKPm91pBiI4nZ07r6N37EzznpqFPHRuTmBI0RmjLWQY
         PoksoSPpXuCEHdZhqfeDpwsM3d1kt5EvSzfHdUYj7ynHF7S3dXXsVCJGjipMJ/teWUKv
         q2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442994; x=1706047794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20F2pHVGsJi0lMQBok531KeHnqA3E6H/Lw1Uc5J8/FI=;
        b=PTTInTUMWbU9KmlePqXC3QJQeBHoPKHEFVIk3hFBa5ft5RhmB/LjEAQhit1QUTJ+bf
         cW6KrmguEpvribQ80SDMOFTCMRk0e89TupPg8aenC5V566fwU8ilEjDe7cO2olQAbA8U
         yqWLln4mNZApEtJ1UEgmLZTLYpidqAfiqv4yXvutgKA2G1JyW1boGenUFkPz9+cTPo73
         yXx6TEGfYIQVQD/AIL/WNcdSBJQBiiE9t06k08o3Yo460QdsY+TuhuM4wDg2uYq5wXYl
         /T7zYE/aOVXjrIJsrFg8G15R/lXm5X2ZPJOjlpFYLxKiJfqoTY4nRTWpKjxQBMWjMnc2
         uuHg==
X-Gm-Message-State: AOJu0YxEur+m8KEo1hZCJkaG+yZClWqLCzAm7l3kicUBjXrRFiu/rnBC
	KaZg1Sy40xoOZQyYzBOZqncLj9s7feiWHQlw8moXodf+TI5eeQ==
X-Google-Smtp-Source: AGHT+IEu6p1jhLUcGuyahQTDE4Gppk+YdyTkgPSidovfsoSSUa4V1NdKyk4a+0rLhSbdCtu2qi8g6w==
X-Received: by 2002:a05:6214:c4b:b0:681:77e8:be93 with SMTP id r11-20020a0562140c4b00b0068177e8be93mr951991qvj.67.1705442994258;
        Tue, 16 Jan 2024 14:09:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ee20-20020a0562140a5400b0067f3a71ad96sm4499601qvb.72.2024.01.16.14.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:54 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 17/17] bloom: introduce `deinit_bloom_filters()`
Message-ID: <7daa0d8833ebe9aba0de90f43f279dd6d87d634f.1705442923.git.me@ttaylorr.com>
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

After we are done using Bloom filters, we do not currently clean up any
memory allocated by the commit slab used to store those filters in the
first place.

Besides the bloom_filter structures themselves, there is mostly nothing
to free() in the first place, since in the read-only path all Bloom
filter's `data` members point to a memory mapped region in the
commit-graph file itself.

But when generating Bloom filters from scratch (or initializing
truncated filters) we allocate additional memory to store the filter's
data.

Keep track of when we need to free() this additional chunk of memory by
using an extra pointer `to_free`. Most of the time this will be NULL
(indicating that we are representing an existing Bloom filter stored in
a memory mapped region). When it is non-NULL, free it before discarding
the Bloom filters slab.

Suggested-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c        | 16 +++++++++++++++-
 bloom.h        |  3 +++
 commit-graph.c |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index a1c616bc71..dbcc0f4f50 100644
--- a/bloom.c
+++ b/bloom.c
@@ -92,6 +92,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
 	filter->version = g->bloom_filter_settings->hash_version;
+	filter->to_free = NULL;
 
 	return 1;
 }
@@ -264,6 +265,18 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }
 
+static void free_one_bloom_filter(struct bloom_filter *filter)
+{
+	if (!filter)
+		return;
+	free(filter->to_free);
+}
+
+void deinit_bloom_filters(void)
+{
+	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -280,7 +293,7 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 static void init_truncated_large_filter(struct bloom_filter *filter,
 					int version)
 {
-	filter->data = xmalloc(1);
+	filter->data = filter->to_free = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
 	filter->version = version;
@@ -482,6 +495,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			filter->len = 1;
 		}
 		CALLOC_ARRAY(filter->data, filter->len);
+		filter->to_free = filter->data;
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
diff --git a/bloom.h b/bloom.h
index e3a9b68905..d20e64bfbb 100644
--- a/bloom.h
+++ b/bloom.h
@@ -56,6 +56,8 @@ struct bloom_filter {
 	unsigned char *data;
 	size_t len;
 	int version;
+
+	void *to_free;
 };
 
 /*
@@ -96,6 +98,7 @@ void add_key_to_filter(const struct bloom_key *key,
 		       const struct bloom_filter_settings *settings);
 
 void init_bloom_filters(void);
+void deinit_bloom_filters(void);
 
 enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
diff --git a/commit-graph.c b/commit-graph.c
index b285e32043..1841638801 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -830,6 +830,7 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 void close_commit_graph(struct raw_object_store *o)
 {
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
+	deinit_bloom_filters();
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
 }
@@ -2648,6 +2649,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);
 
-- 
2.43.0.334.gd4dbce1db5.dirty
