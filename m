Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D9176AC5
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337205; cv=none; b=TEkPEr6sGWOmHLfEKedLcyCpI5Jj1kFuJrVRZiQa14vb7eJCbh2LBKix+E+CKjhAD7VMbA1wQ2mSzPNQX46lK8WyOD7IQSVBR8gXNFznMjGL82VGMBzpsW+Jx1uMSIBSHTmI69jO4TbNFcMk9VGesWcyWoV6J5gWMBgz2iu3XYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337205; c=relaxed/simple;
	bh=57yMmr9vAbwChO6+SRkpKoA11gx9FtkKwB5rQr67Y4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGANX3xOs0insD2ObDUcqM9Zne+NeV7AuYivoEzU/BhfZ+BD2CJ6A5Udek60yqPUmzmJaCfKjoH6w1BecdvLrXKh9fXycpEAEnW7jTEDnfeMEguI+o9XbItmOd8t7IhExRmeMcqZjPubbVbIXTpr3TAqb+eZ8h24/Zj4+1wGttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tMbvgk8Z; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tMbvgk8Z"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b505f11973so48774236d6.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337202; x=1719942002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvFXyyN2OaU/u75fN6VWxaQwCGVrJ/qgw7a5GtATHY8=;
        b=tMbvgk8Z/F9w7myu7EENPG/nQe+0vg+GKLtkLLBypU+kf5DVlw1IUrhSfCymzuj7of
         H2i5QCMX/4KD9fc5BvotAUlKKcGsmcZUlCV+jDPKUrWp99sdEPob7u06fXCOK/bGTjuR
         Q0FoO1uKyfc3f5mruMo/zvjWXUOQh1navpOyKewZLHz1F+98G4XYL1pNYlUMU2PKysVn
         OrTPKc9E70ZkSPuARz2XUJjmngh/xYUJFVEi6eblWxuxjjf4sr3j1JVKaZqSD5F4SVdf
         5U0NiTahd9HwHrWbyoiVWECWfuSPaaWFNnkSvt/rAf31qUVpQiMb0jgKb71jGKWgak6Y
         p9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337202; x=1719942002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvFXyyN2OaU/u75fN6VWxaQwCGVrJ/qgw7a5GtATHY8=;
        b=YBEhun+uoYIspQQEC0o+aAtAPm3bb7mn4x20DzJFi4eS5Zk0Z/8Vu1Ra0wSDKq2L9P
         2P4FlBtXQO1W9RrL1cf+ZAR5uMF6s5H1kgUthakxM7fhEkn1xyPnNjBN3qm+Ffk6P8C2
         EcxU/arwOy71pexRDQxtuiZg3qzzhMbUeMrN6R+LqKIyDEmYpRQAiGgwajwWac3cIKaQ
         zY5pgQGcHU3+hvo02M5z3vt63K/LZ+DIPqgxAtKM91KESpa6IJG6iUp2o7rQAhV+n5hB
         zgByRJFUxTdMU2BtbFayK8OuD34rs+ws1qMILUKnbQ9QEyPMw0EK64LQxNXKWwVKEF/2
         6fjg==
X-Gm-Message-State: AOJu0Yz0RVnTb8cJ4Qy/SK3QYi/TpIuY/fwEze6k+FkDbiSar1zz+gZG
	u00JCSY6bpMrKeA9MoynspylMUxNDchmxP8rqiFg1dFw99xuZFcdDHFK3jxNMwbJ8wKGLk07XUs
	unDk=
X-Google-Smtp-Source: AGHT+IF2lo8z6uSmHPtrKIgSd1sz7j+y7AgS/4H6P4e4F5jrKap7y2uBwlhJ936TKpVuIPRvyoJrpw==
X-Received: by 2002:a05:6214:301b:b0:6ad:84aa:2956 with SMTP id 6a1803df08f44-6b532038fc8mr132975776d6.13.1719337202329;
        Tue, 25 Jun 2024 10:40:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5265bc978sm41390626d6.43.2024.06.25.10.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:40:01 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:40:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 12/16] commit-graph: unconditionally load Bloom filters
Message-ID: <99e66d1dba5c4d7d57859ba5f6ef9e0d349dd356.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

In an earlier commit, we began ignoring the Bloom data ("BDAT") chunk
for commit-graphs whose Bloom filters were computed using a hash version
incompatible with the value of `commitGraph.changedPathVersion`.

Now that the Bloom API has been hardened to discard these incompatible
filters (with the exception of low-level APIs), we can safely load these
Bloom filters unconditionally.

We no longer want to return early from `graph_read_bloom_data()`, and
similarly do not want to set the bloom_settings' `hash_version` field as
a side-effect. The latter is because we want to wait until we know which
Bloom settings we're using (either the defaults, from the GIT_TEST
variables, or from the previous commit-graph layer) before deciding what
hash_version to use.

If we detect an existing BDAT chunk, we'll infer the rest of the
settings (e.g., number of hashes, bits per entry, and maximum number of
changed paths) from the earlier graph layer. The hash_version will be
inferred from the previous layer as well, unless one has already been
specified via configuration.

Once all of that is done, we normalize the value of the hash_version to
either "1" or "2".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 87b07e7b85..8129a4f5dc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -358,9 +358,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	g->chunk_bloom_data_size = chunk_size;
 	hash_version = get_be32(chunk_start);
 
-	if (hash_version != 1)
-		return 0;
-
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
 	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
@@ -2514,6 +2511,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2545,10 +2543,18 @@ int write_commit_graph(struct object_directory *odb,
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->chunk_bloom_data) {
 			ctx->changed_paths = 1;
-			ctx->bloom_settings = g->bloom_filter_settings;
+
+			/* don't propagate the hash_version unless unspecified */
+			if (bloom_settings.hash_version == -1)
+				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
+			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
+			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;
+			bloom_settings.max_changed_paths = g->bloom_filter_settings->max_changed_paths;
 		}
 	}
 
+	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
+
 	if (ctx->split) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
-- 
2.45.2.664.g446e6a2b1f

