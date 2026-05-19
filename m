Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02C3EA96F
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206270; cv=none; b=DtTUUd5O0OWlyThveCGjrZ1VJRrRfm4fY5OeyJ0HmdwosNmjuUZjaDGsQ32C+jqCZZf5iDj/AqjChUO1q0A8y99r6ut66ntXuNGkceE+18wnxV+Y/JFh+Dh4e1b0D4PrzMcR1FdQDSNHf+tKSz7gXm3wYpBKlZC+Gx9WQT3oG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206270; c=relaxed/simple;
	bh=u3B4GdbQmZa82crLKU2apOvfnZvVZXQtdAddPO56Kwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXvE1ZbF7UY2CEnyk9sHm60HueDSym4cXnF4BuFnUjWKcpRq2BSq36Y3+f1W2HOZaPL7yNGcxTDoah3UN35ICCNaitDdnve3kM0CKqO+y0w7c4QjdNBzY3uAibK3cucgWWFulChjh6ITRYBYasS1B4pGQK5TRO8X/JqO3GWYSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lAHi993s; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lAHi993s"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd6f65c781so29772817b3.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206267; x=1779811067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=urahjN4t6zswVA3c2cQAWG9BOQmG7KunuHeyj/fKf6I=;
        b=lAHi993sDZB2JHItjHam2Qjpv0jZjq9fZjcIYoqsGjhngp0vJEV6yUpX6OBJn0fUSP
         x3VAnXfvZRkoRQ0ZRB98i41tOlUHwDxFK3UtILqmyuwsynAEH9IkCgzd9dfo+hjt7udP
         t1Z/0NP/mSmSo8zfHdJgJHg+xv1h5KN8IbPvlg/zKgXcT3ozknzYg0gQQVciMUX7+lRC
         ClcsEicwHHAyZNVXsfen9YR379D0SM8bQrg9xsHvC8UeonnzpnJ7w+Ajjq0LDDq2G0h9
         Eby0SFNSgc7S2HWoGrR8WZvQQlZ9i57R8qrzxrJUtCf4GoWfk4r2E9IpM5m6Adr9S0qA
         E5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206267; x=1779811067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urahjN4t6zswVA3c2cQAWG9BOQmG7KunuHeyj/fKf6I=;
        b=YAHHyrBAhEkgk1/FPbZJYtko5bihi6JjKCghYwqqPidAOKpuLqTUNKzS5XSV19CMOw
         m3HJrtVG21ss3mpZlxPXRggMrOEaWoaSGgWGQpmdIU8P39lLUyHXJEfKnwnGyFO9C5fV
         PE+w418WLucc7F0aV5M7KNYf+/TvNixM1tsd7V3OUZugaIqRy98QZgHCCZmYkNl4VH9N
         g3dKJVlx+162p5IB426eCZHyy5WFDiGvlpoTkE/GRJsfKDI3SI7VpPuZTxj7Zb3uqmin
         jxHZDBfaU0Q4/Y7i8Ca6bNLg6jXNAJTdj8gmvSlDMPyfX6sXblhQWph2c96g4h3vVQiz
         mvhA==
X-Gm-Message-State: AOJu0YyoobSf73axZa53FIzou4g+6NnNWZs7K1ZuTggGHKqANicDUPHN
	2t65x8Nzz3P8zDhZ/Av8VzQ6qgI54LTgR3LPDVjYfWU6Gx/DREqmhNbBzfBt1IEob6hUPc7a914
	OuBLAcWsyyQ==
X-Gm-Gg: Acq92OH2Lqcbl7lPZe4nwZU8pKZip6MpOLNNbaO9/GHVNw7aVI7hzYh2TFYhhYOHdhL
	OCmjf6fQkzGeTf5StXfvBXbZDVK5HJkSTyhlYsGAPWTPxtApsHk8CEyCrI7JMCw7mENi1LcTLnq
	7X3MSBWZzAlH9GWyBBkR/n31UvMSbdAAq8aP+Dwfo1gVQYuIWv4g/rL7ygWRShTZKUWdgH/GQzj
	PzZjn/26qn186A16L1RQsxHZcXKCxrUoaaBCa9n5JVzFu+sdaPaoKPevycRPFPbltUDaCSUt6eD
	ibw2d0xEIFFn20UaAwC3lYiIax3cmi6y0/dz0ofg/WXp8sj1t7rzr7bTxid1FR8KRjeH9BxMJHd
	YFtDXcmJ4FiKspmwa1OVfJ43y49LWKIbyax8GXALGupBo8f/QmSusSngKCgqomT6OmIaKm5kmyp
	y+dWEMiWhcH0Wmo4D0nyJ/hDCIpGGK6AwePKZQA5XiBZvsI5P17AT6ZIVZ50ZEykcu6r3Xroiwa
	chXVu9aS4PL5IXV5oOOSWWFYxawAKPrqd2Xa+TpKq8RjFfi0JqE7x5087XxkOL8P+XpwrTS8vm3
	YgOGam9X43zCg7Vb
X-Received: by 2002:a05:690c:e652:10b0:7bd:7a1c:9ae8 with SMTP id 00721157ae682-7c7e87f16bdmr146510867b3.26.1779206266879;
        Tue, 19 May 2026 08:57:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18b056sm39038787b3.46.2026.05.19.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:46 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 03/16] midx: build `keep_hashes` array in order
Message-ID: <5609d1941e6339b3819ea8d07e15ab9e9108f079.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

Instead of filling the keep_hashes array using reverse indexing (e.g.,
`keep_hashes[count - i - 1]`) while traversing linked lists forward,
collect linked list nodes into a temporary `layers` array and then
iterate it backwards to fill `keep_hashes` sequentially.

This makes the filling logic easier to follow, since each segment of the
array is filled with a simple forward-marching index. Moreover, this
change prepares us for a subsequent commit that will switch to using a
`strvec`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 66 ++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 9328f65a201..55c778a97cb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1731,6 +1731,9 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
+		struct multi_pack_index **layers = NULL;
+		size_t layers_nr = 0, layers_alloc = 0;
+		size_t j = 0;
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
@@ -1751,46 +1754,49 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		strbuf_release(&final_midx_name);
 
 		if (ctx.compact) {
-			struct multi_pack_index *m;
-			uint32_t num_layers_before_from = 0;
-			uint32_t i;
+			struct multi_pack_index *mp;
 
-			for (m = ctx.base_midx; m; m = m->base_midx)
-				num_layers_before_from++;
-
-			m = ctx.base_midx;
-			for (i = 0; i < num_layers_before_from; i++) {
-				uint32_t j = num_layers_before_from - i - 1;
-
-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
-				m = m->base_midx;
+			for (mp = ctx.base_midx; mp; mp = mp->base_midx) {
+				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
+				layers[layers_nr++] = mp;
 			}
+			while (layers_nr)
+				keep_hashes[j++] =
+					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
 
-			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
-								   r->hash_algo));
+			keep_hashes[j++] =
+				xstrdup(hash_to_hex_algop(midx_hash,
+							  r->hash_algo));
 
-			i = 0;
-			for (m = ctx.m;
-			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
-			     m = m->base_midx) {
-				keep_hashes[keep_hashes_nr - i - 1] =
-					xstrdup(midx_get_checksum_hex(m));
-				i++;
+			for (mp = ctx.m;
+			     mp && midx_hashcmp(mp, ctx.compact_to,
+						r->hash_algo);
+			     mp = mp->base_midx) {
+				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
+				layers[layers_nr++] = mp;
 			}
+			while (layers_nr)
+				keep_hashes[j++] =
+					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
 		} else {
-			keep_hashes[ctx.num_multi_pack_indexes_before] =
+			for (; m; m = m->base_midx) {
+				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
+				layers[layers_nr++] = m;
+			}
+			while (layers_nr)
+				keep_hashes[j++] =
+					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+
+			keep_hashes[j++] =
 				xstrdup(hash_to_hex_algop(midx_hash,
 							  r->hash_algo));
-
-			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
-				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
-
-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
-				m = m->base_midx;
-			}
 		}
 
-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
+		ASSERT(j == keep_hashes_nr);
+
+		free(layers);
+
+		for (uint32_t i = 0; i < j; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-- 
2.54.0.175.g8bd0ec98dc3

