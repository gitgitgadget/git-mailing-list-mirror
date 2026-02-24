Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC51DED42
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959631; cv=none; b=K9JqsVCzjOstbMisVFy28GF4R320p3rpjk1jDYUNgqBEDn+5lXkOB9pUVCIE0MnaLk0Z3a8n56uIli8fAHke/KFsCsMW7QSBEYn40SqOfn83RMoE9sa7uuujnL4lz95JqxWGbrLALBWmHSBrdj1ULygq+Et9/i/C9LAU8sNLB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959631; c=relaxed/simple;
	bh=5l/7czIVKdacsSvtr2ntGIL0CPCf4w6//Jio5g/eHVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw1zP3ApkrZw7oKTqnLfTdweT6PHh/VnKz7GIzss1mC9TF6Og2VHcqN62Z7Cru2qJFCJDEmpktythoeCNHHqCqswux+dTVTc9PYqXFKvGxQl+3KVJO+kQyza2l+BZJI9EA+vdw/88qwXJm/2VyeB0PV9/M3RaOi3CAnvtcxyYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dvhGq/jg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dvhGq/jg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5069b3e0c66so1329791cf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959629; x=1772564429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiEU1/FltzBRp5zD4+UY+AEVcKfKNduGI5kEEFDPApM=;
        b=dvhGq/jgLE4Gdp+NcL/lxsc0QRcxWVtq4R6Mt0MZVmWheVy5FZ53pw/k4VWjr0Cj3Y
         TVbrMUYxtcVbutd4VTUHlclQkf3BmkpRC1nIXqJ6xdXd22Y6SILJMqfK+aJbvf6y+PCY
         1K3YAZV5ypHPV0sUYaEljhmfnTi/8tkpEZPjvKLbxjOBwp6ORAJ5HvW1UgkYz0V4KcEU
         2P17HxxTz0ytMeiDIEjE2OlTQySYP3OQm4N1OIq8mGwKYYgC+lJjcFhWBlI3PnZSIr0M
         i0yMZl8++RHCgXSI7hG9ey/JZ4LzH4hSvlbe51gROYEDpXAJ+e+0B+Ey4NxJqPcX9ozt
         XagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959629; x=1772564429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiEU1/FltzBRp5zD4+UY+AEVcKfKNduGI5kEEFDPApM=;
        b=sw3bmNABY+D3o+zbzXIZ8EYTLIu3gmuSIgXJJzkpXUYMP18c9zy2Cy1kfYlbd0mYG0
         Qyg/GLxl+Pceg65Ux3MUDTzd2fgrSnpMtRLFWOm38Q2pIKcY0RuEmj5HyekdCyRybA3R
         DkXAhVfWzPXVJC2bXbLXDnHkvVDAVho2m4Ym0SlwhWmDlkkyCSukgofPKUTxYkKE49PU
         ou1YlRmFRrdGsqIUueAXNpWKVpZjQfr8HT0p2QI4EymCtyZTAIZyYAbsibB0NIgMfDW0
         kretXpy+uNwMiPxs1CDurlbKKsVlK01AX+Z8dMo5Zpmqq0FA5P0NT+iEHYI2ATanAfIt
         sL9A==
X-Gm-Message-State: AOJu0YxcUX3xCF7wKIVWMGIRAqbqhxE2zDK+xuBZiS5V5BLnSWNBIXwK
	wpXS/gbUis4e814GMealxKlwdgI2tFYeeCCh7hRLokWdlFPQguU0E7DScJAZFhlMlu15fyrAyLj
	aEq/oM9QDeg==
X-Gm-Gg: AZuq6aLQ4tRKE/oVHuLU8X3r13oGGiN5QINFFJEw6HIGYRJTWvPODBoP+/XAV4qV7yS
	EQc1M1jRZVzhZRUT565ZVqDdLu4RYSW0QIuQMEhmmeLxjpz8tMukeyVUx/fQIqb4f78eC5Dp6ZU
	B7i9P7OwKCHGEIKURrOvRKipwL0XxmRdjfH/VVOpAVWXlq8GpgVDrp00L9RmlDfgyJtii8BuqKM
	fmhIQqZZJs+Tz1hGvXfwDmmZHFIID1QTreOZJ4sqIzR7eSfQEdpV/Y/KGlOwTxOJzOQlUZqbjwL
	LdS04GpEGYPnl2y/tfzgwWvPMcgkWjkRMbNb3HRh3zMohxsLWy7AjhR9UlsNIjXTYIYFl1VcDNT
	bhJ+146u1PCKjO095rtAgRLUpRFWJ9tjA+p/70SLtla316eZaKqyRDOCp1RLZyeyPPhhKcPlyDi
	QdFnFewYaRNf47e6p/Orev07FuA+9gFgYqDN84Q5YpUbkhi9OQ17sBye+F6k/wY87N2hfsRmT4S
	2pe4ClXQKasZA1vn3GIPVeXHQXNIw==
X-Received: by 2002:ac8:578e:0:b0:501:3aed:fa5f with SMTP id d75a77b69052e-507365466c1mr15923681cf.12.1771959628725;
        Tue, 24 Feb 2026 11:00:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d544cb8sm101686651cf.12.2026.02.24.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:28 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/17] midx-write.c: enumerate `pack_int_id` values
 directly
Message-ID: <238bd203eaa7629baf95ea5c94593561848dc7bb.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Our `midx-write.c::fill_packs_from_midx()` function currently enumerates
the range [0, m->num_packs), and then shifts its index variable up by
`m->num_packs_in_base` to produce a valid `pack_int_id`.

Instead, directly enumerate the range:

    [m->num_packs_in_base, m->num_packs_in_base + m->num_packs)

, which are the original pack_int_ids themselves as opposed to the
indexes of those packs relative to the MIDX layer they are contained
within.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c54113cdc84..80334914d3e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -935,11 +935,11 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
 	for (m = ctx->m; m; m = m->base_midx) {
 		uint32_t i;
 
-		for (i = 0; i < m->num_packs; i++) {
+		for (i = m->num_packs_in_base;
+		     i < m->num_packs_in_base + m->num_packs; i++) {
 			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
-			if (fill_pack_from_midx(&ctx->info[ctx->nr], m,
-						m->num_packs_in_base + i) < 0)
+			if (fill_pack_from_midx(&ctx->info[ctx->nr], m, i) < 0)
 				return -1;
 
 			ctx->nr++;
-- 
2.53.0.171.gde83996e422

