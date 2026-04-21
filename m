Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5663446C7
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803869; cv=none; b=WiA9RCGQaGR/D5xVE2Un+o8Wlyetvify4lhJCxGDuvzx79LTcLVK7pDur4JNsoLMUUvmpX7WZvT31mkwpLrSgcoVdIuoFd9iB2NFzJNug6sx0eC/aDgzET8/ZJu38SHygn8SICq3ukfZfC1UGkxrqYY8AT75xU+9Tn1wXLf4Uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803869; c=relaxed/simple;
	bh=vZMYU7Oi2ii68whuYOe0Heyct+zWYa8lGUMnrAgkdo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2A6TB0gDUj2Q9SDkZfiOqiZeNUNxjrOkYUd/xoi104EyiGKfkS8G5NnsMEfMOliDykEV6qa5WdUeojxVvQh96H4Sduc61AF+bxL9KsD0rqS9zBxvPP2adUs6C4mlkfPOC0h2hDx+jvOSSU7MzBOgVUhJOqgRjTfWcAaRBfdb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=KWg3TIj7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="KWg3TIj7"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd17e19b6so1090382a34.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803867; x=1777408667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txgDckvIOiSpRoAJHquC7IUCF9lBWnC3K41Kw8jkJOU=;
        b=KWg3TIj74Yha8Y46zHyscxCLO/eTPRx/B0eUFEQpBbW+waSxpZudl6IQf6jGVOWQsa
         HZkpam9pz7br2coCeedopdZTNvevYMzhPhKFBZzbt9JDixI1Hy357VbMXjZW7D454Fdr
         rb7mfxL+QRB8I7EE3UT3VrtP8gNxa5em54Q/kKVaSjGpm2iI5rEHKy7bL9hkSV34X2H7
         IPLvaU9TIZayUuN10bfP6QpmESAcuJ9NdBSr+cqCbTc0s6QiSeVzNLq7LKtpRLxpsFwW
         GCMO/yUE8HoUENjnylFi+4cYOLjmdTwP9dVkGQNZVkuDum2dTkp/mvA/w9AZhcDIGB0w
         2C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803867; x=1777408667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txgDckvIOiSpRoAJHquC7IUCF9lBWnC3K41Kw8jkJOU=;
        b=qeTI48q2VenMsKZf3Zo1REkS+K102w4CRFjUMlWzGfPihDirTMoTy2yqtDc/bErLSJ
         Q2AKzfqpFkEzyRkLH0qbzlPbOdzGQN7HwI+2UzOPqxZ67/qB5wJrvqx+syariE9XinOE
         Xv/mPBh2LJ1xeEhhOiAFvWgHzKOR3KdydnDG5Vmui00qTR5ulu4qjVZBP/c1Q9JxALPT
         Iu9pt25a4U/db8En4MO8hCDNp5waG+ckl1tAFTYRpH/y455cLhBLcHXPiraRVLFT9n8u
         ZBjmhMUa+UmroFhFUKXE3sDsJ3bR1l51IVo6+58/OGJ/wN9VNqq7aHyIJ04BAKbO129P
         7A+g==
X-Gm-Message-State: AOJu0Yxi0S4DhNuu8x7xY+s+WK4ZcT9kIXJocAGR4CRnmZbE3JUVkLu1
	a0WvXBaItR0PPoGjs3hYKqsnJlFlnvqbH0LXVOAoYBiXvK797TF8qFc3ju/7o+imwf2EXqXhbnX
	ujV65k6M=
X-Gm-Gg: AeBDievWwaKhTkIGiYpqmZwLSRRE/LeEYcJjdlk8UWV5HeG58Ooh4QqvCKwsg2CYFrj
	8cRnVKr4zHOAtMToNd0HmdDVjkb1JN1iDdQQAAGEg/JPLMgJMvYvDQCOQr0D5AYCOyY2TzXoG9c
	SjtD7+KCIcqavoTwUzw6UqFF++1Qpn+ihyEvAjjlB0qz6CGpitQDghQtHEQHZ+SBdvf2SdpKsLW
	/9fg6jk2pM4fiL0skK1GhsZvvM192x+9UN9Uidp5fzIE/DIPZ87ZaNMxpYmh051P0gMGt317l6x
	JUvEuRFjSYg4Er6eK5jZKc57Ijg6qtI9JLRaku+cakP2ou+7sRJ3QQ0itX1iGNRqrK40icgGdjL
	KiAkQJNlW8C5RXUf81lNOLwTrFU5RpfH+1OJr3vn5KTN1TvTVWIPr+rg/f9rl1Ktgfwp7czr+Xt
	2E1SrZYfQM2Z09h8WZMaB4YSMWHkVlW2mw9XF9DYfq0A4w81SvWqht/wcVU0dxp7FjfL697ZwZH
	4n0MfTdkxEQd9W69Kt8QLNeRuMCqi3wbMhUK4xMtDuPA14qKMFa2r8haRm0HJCxxmdPFm+MsbC6
	CZb2bg5k428nijqLV/OoYcMNUxA=
X-Received: by 2002:a05:6830:4ac1:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7dc94fac1e7mr11821341a34.5.1776803866784;
        Tue, 21 Apr 2026 13:37:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dccfe912edsm4003944a34.16.2026.04.21.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:46 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 11/16] repack-geometry: prepare for incremental MIDX
 repacking
Message-ID: <f5642a46bbd1cb092c525a14b5f7e2233db3ea56.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

Teach `pack_geometry_init()` to optionally restrict the set of
repacking candidates to only packs in the tip MIDX layer when a
`midx_layer_threshold` is configured. If the tip layer has fewer packs
than the threshold, those packs are excluded entirely; otherwise only
packs in that layer participate in the geometric repack.

Also track whether any tip-layer packs were included in the rollup
(`midx_tip_rewritten`), which a subsequent commit will use to decide
how to update the MIDX chain after repacking.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-geometry.c | 35 +++++++++++++++++++++++++++++++++++
 repack.h          |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/repack-geometry.c b/repack-geometry.c
index 7cebd0cb45f..2408b8a3cc2 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -4,6 +4,7 @@
 #include "repack.h"
 #include "repository.h"
 #include "hex.h"
+#include "midx.h"
 #include "packfile.h"
 
 static uint32_t pack_geometry_weight(struct packed_git *p)
@@ -31,8 +32,28 @@ void pack_geometry_init(struct pack_geometry *geometry,
 {
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
+	struct multi_pack_index *m = get_multi_pack_index(existing->source);
 
 	repo_for_each_pack(existing->repo, p) {
+		if (geometry->midx_layer_threshold_set && m &&
+		    p->multi_pack_index) {
+			/*
+			 * When writing MIDX layers incrementally,
+			 * ignore packs unless they are in the most
+			 * recent MIDX layer *and* there are at least
+			 * 'midx_layer_threshold' packs in that layer.
+			 *
+			 * Otherwise 'p' is either in an older layer, or
+			 * the youngest layer does not have enough packs
+			 * to consider its packs as candidates for
+			 * repacking. In either of those cases we want
+			 * to ignore the pack.
+			 */
+			if (m->num_packs < geometry->midx_layer_threshold ||
+			    !midx_layer_contains_pack(m, pack_basename(p)))
+				continue;
+		}
+
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
@@ -173,6 +194,20 @@ void pack_geometry_split(struct pack_geometry *geometry)
 	geometry->promisor_split = compute_pack_geometry_split(geometry->promisor_pack,
 							       geometry->promisor_pack_nr,
 							       geometry->split_factor);
+	for (uint32_t i = 0; i < geometry->split; i++) {
+		struct packed_git *p = geometry->pack[i];
+		/*
+		 * During incremental MIDX/bitmap repacking, any packs
+		 * included in the rollup are either (a) not MIDX'd, or
+		 * (b) contained in the tip layer iff it has at least
+		 * the threshold number of packs.
+		 *
+		 * In the latter case, we can safely conclude that the
+		 * tip of the MIDX chain will be rewritten.
+		 */
+		if (p->multi_pack_index)
+			geometry->midx_tip_rewritten = true;
+	}
 }
 
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
diff --git a/repack.h b/repack.h
index c0e9f0ca647..77d24ee45fb 100644
--- a/repack.h
+++ b/repack.h
@@ -108,6 +108,10 @@ struct pack_geometry {
 	uint32_t promisor_pack_nr, promisor_pack_alloc;
 	uint32_t promisor_split;
 
+	uint32_t midx_layer_threshold;
+	bool midx_layer_threshold_set;
+	bool midx_tip_rewritten;
+
 	int split_factor;
 };
 
-- 
2.54.0.9.gb905fd5d0ae

