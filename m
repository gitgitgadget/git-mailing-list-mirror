Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60867C7B
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442988; cv=none; b=pugt4fxPFz527A0R/AEoYhob7V9w7jsQgMa6JlhSk8HDcQqA5paGpwR6Tse0jyRaRQS4QMv+Dn0ZPAGWvAP3yIyPdIvXLYpcxvs2DuNWIKHv22iCtWIS+sVl1wv5f6dm34yjkE64odppML5MgOz4Gu5V9oPI7+3GHq5ZdYTK31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442988; c=relaxed/simple;
	bh=xnYeMQ3HhqUftzICV3tavgVci5QpiYn8kDLlSnOuT0Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ho5GFpgib3BLk+wJhz5Yg43i075DHqcvEtiWBUUTSpCdT6+TUWQMZGs3aUkaVjPUDIlprn/HMZi9JZv4YBvbdnXh0ZvnGcU/3Es92yNtxwZwoGU14eKkcDjE+en/nV8/UtmGnpXoHyLFtvTaisZUsLIYEnO/QFJbzpgXHM9br+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dQ4yvBpI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dQ4yvBpI"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a029c8e62so6356501cf.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442985; x=1706047785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWx5+UTeuBcy9EdfxiH4bZ1HlcQmsyhhWeSJxv/FmxY=;
        b=dQ4yvBpIC/ri/XDjfiIHJOSAZMDso4RI3aAOMyzD6Oojxvm1stpMKtqwp4zyg4wEiW
         WqzrCtxjqKxqgWLbdQGRANhDIkh848FyvV0/sFavd4TtYaXyoiSBjoUP/80qmpF5pktA
         yrOUCq5Wc96FEx9Hg3rxNsda7K32mqm65u6vV1iRzH0RFHwz3pg5xG5u9L9TnS7tMOkX
         MnHpxzQQK21sZBp/TzU8nFd5sUhhIB8sHBAHIulFJPs4hIsFSA/WNVQKes8Pio4I8I+g
         fS818aqqXBTltw0Fr2AfIWw7vqxi6jgR/yjQSwh4ddmvZbNFuMQdu3Nq6K9JaqPaNWHe
         mHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442985; x=1706047785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWx5+UTeuBcy9EdfxiH4bZ1HlcQmsyhhWeSJxv/FmxY=;
        b=oBia8LvjK4OqwR/X/5XQwlHW3XJwxmzdDb+yMBeDDiPGkxFFoOuKwKmIrnz7TyvxGc
         nv2n9ecg/vEILhdC3b5VxKXKGmycJo5Cct5PPaeQcgM+8IGAS+wkgOq97lbhYTn2OFar
         ZeKarfzr/F6Bdm/sKtE3FUuIyMIaFJLrjAUfnEHlFyOzJZCNmRSvu7WpsB7S2b9J3oyz
         FlHkPVAvJf/F85AWZEtSH2NE6AuVB8DxAMeBdMOHv31RxSL2HwGfp9Qo+ACacBw3uY6Q
         WEOhgjaGhdm3JyXDeyV6bij16uvb1aYnJbESpbCy9fhKDexm6yZRW5UROkiaqvBJb88V
         s3sA==
X-Gm-Message-State: AOJu0YwSDxtE62rw+ggwT+qzzZPAe28IieS47AO9s1RATk7A/robtHGQ
	PB8DzN09KLiBcOYcVT2F/aPSEs0xZPjsX+KQ0PJjHjdwW1boVw==
X-Google-Smtp-Source: AGHT+IHiSmrMZ8urnxK2Rdq8W8Bmbj6P/n8QgTz9TJN6Twpw802/4mk98OnYcgSJFUOQqH+J0BSmRw==
X-Received: by 2002:a05:622a:44d:b0:429:7412:a30b with SMTP id o13-20020a05622a044d00b004297412a30bmr10742234qtx.6.1705442985496;
        Tue, 16 Jan 2024 14:09:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fb18-20020a05622a481200b004281ce041f6sm5257501qtb.21.2024.01.16.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:45 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 14/17] commit-graph: drop unnecessary
 `graph_read_bloom_data_context`
Message-ID: <526beb9766a25dc97b9a4913fc02701908c0612e.1705442923.git.me@ttaylorr.com>
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

The `graph_read_bloom_data_context` struct was introduced in an earlier
commit in order to pass pointers to the commit-graph and changed-path
Bloom filter version when reading the BDAT chunk.

The previous commit no longer writes through the changed_paths_version
pointer, making the surrounding context structure unnecessary. Drop it
and pass a pointer to the commit-graph directly when reading the BDAT
chunk.

Noticed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a2063d5f91..a02556716d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -340,16 +340,10 @@ static int graph_read_bloom_index(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct graph_read_bloom_data_context {
-	struct commit_graph *g;
-	int *commit_graph_changed_paths_version;
-};
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
-	struct graph_read_bloom_data_context *c = data;
-	struct commit_graph *g = c->g;
+	struct commit_graph *g = data;
 	uint32_t hash_version;
 
 	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
@@ -463,14 +457,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_changed_paths_version) {
-		struct graph_read_bloom_data_context context = {
-			.g = graph,
-			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
-		};
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   graph_read_bloom_index, graph);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			   graph_read_bloom_data, &context);
+			   graph_read_bloom_data, graph);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
-- 
2.43.0.334.gd4dbce1db5.dirty

