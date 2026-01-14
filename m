Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0719C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420486; cv=none; b=l5QGV67xPupauWZVkAy3mTHo16QeL09V5tu5PxM/acEI7/AiItv+9/MtFvUYJPG85133igcPUHsRqtmxnqTqP7/rlNudHVMwbK7/f7/6t2kVYtd5G5eThmZng2uZZnlQZeqFxIeIuEEwVoaY5n3tX8SQM7XvszFtIg+/2P22ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420486; c=relaxed/simple;
	bh=hQx8FG3pg+FUK5NuYjvpCgPB2gMvhR9xKIYcqgn7/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMg2R0ZXJl/InLSJTt791TLxw0amuJmWCWQsyIqQJiTsxfdTO0uA8K1g23y8jXonBbJ7gs8UuVvFv5VDL9chrw2bKoqst70DobWIO5RmVMluN2H529FvuAfOsk0LZy4RRcm9Wk52jTVX5as9ujwdYRFtil6WoW2+7GUCGUQkLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Jg5tLYuJ; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Jg5tLYuJ"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78fb7704cb4so1303647b3.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420481; x=1769025281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svOLqU6VhQvI8Bzq74WmKRRKl1oO5/aXtlFOlBAFLds=;
        b=Jg5tLYuJt2k+Ly1OgLqGsMFvDd8093NDCyX3HjfMAygLar5kkSgfLdZ9pz0iDojhzf
         BdyTIq4+JlNRL/getZJGW2gYH9gCnfs9tVxRZzLEIgUS3Rl6tBjnRv50ReA1ue+lyv0Q
         JTSyWWrupVD/2G/mihbkLNHsRdQwJvuZL7goJ+Qoiy5an6hkvB4kJWZNlbqgqZ8mKVxo
         okuW0ZmPDRDZz+OvdGqGoxXET1Mc9tZI/cOLWLmxlQifcy3gwUgVB5rIGMcf4DCdqANi
         wXw851xSGlc5+141/3E6mtHyzKXck06YmLwX9TAH+X60OdOVTK1tOupUaqELmw8m3UdM
         lCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420481; x=1769025281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svOLqU6VhQvI8Bzq74WmKRRKl1oO5/aXtlFOlBAFLds=;
        b=OGZd84ib7y7jd9qd9/dbEu243fzXdU8Uhw91Ls/JDEmBpcPY6ShOq1otHzlAhRQ6Em
         K+1Di2AwQBBveXvbGrHVdKJieDMPSMPVRJOpwBj1/EI2bOW2SiD3EENs9Pzf8mruc3gu
         1bIW2XaAC3OkNh8vHNivModjVqVtmIMIuNgV6C28fDO5unCPwXYyrKpJtQi9J7duPoD2
         vZvLZPeMfGDJAVBK63TxW1aKR+gHpMRCL2wr58AyHZRk7UKpCDK9xX7D9zDzlTTAlOLP
         ufxDXWeUYcS5UrYJwS6IBDCWKKZrWAh0LgGo6y2Aq9buPPxbX/gk00LvWlP31l0Xkky3
         ox+Q==
X-Gm-Message-State: AOJu0Yyt0umglZxJnSOGh3wJcZxxs12IVEtIoC7jdeqM00VSaQ4DgYpU
	/otKqnkCSkgnbu9MgRIeCVXYQTi0ZWPx5OnGisGppfi+68DkcEh2KFC8UEXZKD7GRH85J9N3CDi
	IjFMftQH9iJnN
X-Gm-Gg: AY/fxX6n9/iz8FtsdmNEyVdFdIH/DMi2xh2lcos8S7KWic5N+4eg9P695hhGXRakU0L
	hwr7O6iIxwWK3q/AVDzzYs71KFhsyOJKrGUryCJNddQ+o094Uk+/3BBt+u19ThAjmJjK8aYP66Z
	PH1H/JCOxbhipT//1C8o+l9Rd56XHgdH81s5wf5NO0kEiGZlrAXQiahlxiSY+NnYBJ+0nJk8bk6
	11Z+/M74fYjtm0bmVV9zFf4LP32gDFQOwTtggmweksYC/iLeeiqikMnONeJErhfoA6zkob8T8X4
	IvpQCJIPRR8dkEmqUWcbErnPsnoTNvQ7Vqd7MMcUYvih4TE3QWjgj4ogRe7YUqB5o4O1kfXvVyZ
	jE8QSlEZ+LXUtNWhINRhtOQZtc7cyUYAz4sMB0rUj+3wXDWtE6Yrh0vTscixVn9uAVAi9J+5oJ6
	xkn4SVzrMdV2TBUxF82QjH1RvKh28BOTAiOzw+VbSfCYv6z3uZ+AY9zmm0/GrWzWwoKvo/B6u4e
	BbLOSrgUa73GaEFXA==
X-Received: by 2002:a05:690e:4087:b0:641:718:8a28 with SMTP id 956f58d0204a3-64901ac9e35mr3263281d50.40.1768420481065;
        Wed, 14 Jan 2026 11:54:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2623sm10881373d50.20.2026.01.14.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:40 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/18] midx-write.c: don't use `pack_perm` when assigning
 `bitmap_pos`
Message-ID: <315a0ea2985894f5ae5f166bdd1685ce0981fb23.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

In midx_pack_order(), we compute for each bitmapped pack the first bit
to correspond to an object in that pack, along with how many bits were
assigned to object(s) in that pack.

Initially, each bitmap_nr value is set to zero, and each bitmap_pos
value is set to the sentinel BITMAP_POS_UNKNOWN. This is done to ensure
that there are no packs who have an unknown bit position but a somehow
non-zero number of objects (cf. `write_midx_bitmapped_packs()` in
midx-write.c).

Once the pack order is fully determined, midx_pack_order() sets the
bitmap_pos field for any bitmapped packs to zero if they are still
listed as BITMAP_POS_UNKNOWN.

However, we enumerate the bitmapped packs in order of `ctx->pack_perm`.
This is fine for existing cases, since the only time the
`ctx->pack_perm` array holds a value outside of the addressable range of
`ctx->info` is when there are expired packs, which only occurs via 'git
multi-pack-index expire', which does not support writing MIDX bitmaps.
As a result, the range of ctx->pack_perm covers all values in [0,
`ctx->nr`), so enumerating in this order isn't an issue.

A future change necessary for compaction will complicate this further by
introducing a wrapper around the `ctx->pack_perm` array, which turns the
given `pack_int_id` into one that is relative to the lower end of the
compaction range. As a result, indexing into `ctx->pack_perm` through
this helper, say, with "0" will produce a crash when the lower end of
the compaction range has >0 pack(s) in its base layer, since the
subtraction will wrap around the 32-bit unsigned range, resulting in an
uninitialized read.

But the process is completely unnecessary in the first place: we are
enumerating all values of `ctx->info`, and there is no reason to process
them in a different order than they appear in memory. Index `ctx->info`
directly to reflect that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 13171d7e9c4..da9c5a7c295 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -637,7 +637,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 		pack_order[i] = data[i].nr;
 	}
 	for (i = 0; i < ctx->nr; i++) {
-		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
+		struct pack_info *pack = &ctx->info[i];
 		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
 			pack->bitmap_pos = 0;
 	}
-- 
2.52.0.457.gb599f1ad4b0

