Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9667C7B
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442983; cv=none; b=kHu0wrP8/DW38mzWVaelBEfL0dnke/xcbsKdRnN90J3EPyNA0csybIQNE1muqnwXOOC92LlQlONOVd8GFHdCw1VJFKxwR/aAZ3VKYnNXv1QeyDQzejeC10rrJ3FodSi1i/PAZTNeXXoISVL5bZJvYegZKb/kAZ+N0KFpDbgGsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442983; c=relaxed/simple;
	bh=qA4WQsDr2t6ADuVD3ZLuX28MtV0qd2DXrr/Ll8LGC48=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jgoHJLdREDbcaeXLc/AlGGTFPWaTkaBi+fy5FiigN8xbhFdTO9v04z3hZQSZJMSnGYlzv+6ETNQ5kUocDc7o0rQUEyqdq8YHDMWjmNDsNQ+zfWCkWgnw6tOjr/BDnVWzbTEAx8SNHhWrc4zYHyjvlTeKJZsKmGHG+fvdB0QxIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LFURnGS5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LFURnGS5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7835aea8012so140134585a.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442981; x=1706047781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ6a8tmwL2Kcf8AgYsQbTKMtqUW3PoNTF+YWVM0HU4E=;
        b=LFURnGS5eRdmkyAIBRdc+7WDPHZaV/AQP41mmaMNfmIxP/aLatZW1gH0ZS3WKu1AYW
         1FcfHszNBk+ATMDmenbV0aPN4wLm4jX4NxUy3r9Ymz7OQTjwVahhq2DY2ibzOoLZH9fR
         kbUFz8z3s8UX7pyf8YuONldb6r5KF4yJ+I5+AB5es2wbYNtQt69kBBx9ufTz3M9oAjn2
         /hPVEtkVFHMPyNkQFUv/+bTeWT5CO2/XAiBFkJX0PaTwLdA5iT7BMloUm3KrcRQ6j9Cd
         rDYPlaE7Yp+hTPVWDmG2a1L80psjSYQO5uqJvXxmOdcoYOlUO4s0I0e3U0O9xaKt3oSN
         UOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442981; x=1706047781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ6a8tmwL2Kcf8AgYsQbTKMtqUW3PoNTF+YWVM0HU4E=;
        b=q27PR13EpKkR6Tb4KRzHbjBqSxjhY7o9K26wdSjUDbCWC0xNxk+Q9LqmUTvab0cWSG
         JZxdSrxSihOwxglU8D1JMa/XdTjVcDoT4U15EPLwK8utnekA/GKbSeW25AboaFhUxhCp
         ki/IK5yMCM9JdoaWwd36JhVnDW9pwGMtV4gu15yOGSSzPTLv/R7QQAbJXb88YUv0G7N0
         GrVrvkp0UCgR7TXU4GXOP60gqUO3pum9NE9NAMOWFAYqp1oNhpJkjD5VTPB80yfYp1nn
         PoqKbJUC2/AsuYGPfMgaZnIuxMv0I4jTO2hjKLo/IuPIrUOyJho3SHA2/De2Gd0Jw00/
         PIvw==
X-Gm-Message-State: AOJu0YzHvFYHo9f8zaUBF9DP9S1hlqRed9hMRFQgDodmHXKutb+O8ACn
	oTkUe9nDmaHg7UvrX9s+uuW1qEq+pyoIhowNHvlZ121FgswqpA==
X-Google-Smtp-Source: AGHT+IFlqXNikD9OV+OR8OOrqiDecdJ2OvFxwOMpOOcnDDjlkDtiuxXzQ4GPWI4wHJcsmrGSgZDE3A==
X-Received: by 2002:a05:620a:8111:b0:783:3790:71f5 with SMTP id os17-20020a05620a811100b00783379071f5mr8401299qkn.57.1705442981353;
        Tue, 16 Jan 2024 14:09:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a034500b0078363648c4csm1481798qkm.117.2024.01.16.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:41 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 13/17] commit-graph.c: unconditionally load Bloom filters
Message-ID: <72aabd289b9e455b5fa0331fe27f73d4e6792794.1705442923.git.me@ttaylorr.com>
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
 commit-graph.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 22237e7dfc..a2063d5f91 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -362,11 +362,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 
 	hash_version = get_be32(chunk_start);
 
-	if (*c->commit_graph_changed_paths_version == -1)
-		*c->commit_graph_changed_paths_version = hash_version;
-	else if (hash_version != *c->commit_graph_changed_paths_version)
-		return 0;
-
 	g->chunk_bloom_data = chunk_start;
 	g->chunk_bloom_data_size = chunk_size;
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
@@ -2532,8 +2527,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
-	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
-		? 2 : 1;
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2565,10 +2559,18 @@ int write_commit_graph(struct object_directory *odb,
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
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
2.43.0.334.gd4dbce1db5.dirty

