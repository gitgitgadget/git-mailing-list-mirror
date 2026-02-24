Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD362EACF9
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960092; cv=none; b=bbddogjKLGDwU2v+sB/miR7KTUXhXj5GUNm6LcAPwSP2O9d0eImlc8qnfNecSmhU1/m4MbBGjKeKhmYiJ6JVtwvfrHE6hUjeOiewZKCwtntGASzrqD6w93v0KWI8PEq5X3nFVLcQpVVQ4gLUqbBs3/GuvT2u+lwfEcXIzxuyIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960092; c=relaxed/simple;
	bh=P+jPXEB0I/o4aTaogc9OsTPxVXzN0fjxTtQ6bU6kMdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liUm0m9JVj5lGYUCj0gSoAH2+xOVxiJmsNAH/VJlPsWuJzGbQmkfcrT/YVmrOM6/aMYhViK1eabCFWO5Izxjy33VfxpvwNxQIKDkDD2hxBPr6EndnRE1jKifrWREJLkRraSuw8z3unwaLbfIyoRFxjiygljioVQZL/EkWxGNEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cfN1wPth; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cfN1wPth"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb20bcff5aso602753685a.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771960090; x=1772564890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IINThSeLwgA16Z7d3cxbP1d5smMyCd0Lc8MEEhz9XEQ=;
        b=cfN1wPthOQg9w6IImf1/kzSY+bZJ8gEGxMm3baAtpsd79h0NOoYjGtx782nTHhHz0L
         EZuG6Aeas6s/K1LkLqqpiN/D4pu+Gk3bNmNM+NV+9G+TZBWBZIInTSnV35QBWZNqXoTI
         HaGs0m3qYAnvBm0Vx6X6FllTH3tSMKn6kXr5duy2hP7cHN90d3LyZGQWoeIvJ4kAOqVe
         Cj3GEoBkHK6PvbRVGG0wDNcl7tM4BBX8zM/MoQWmr8zumpe4AbAYFgmp1kawJdy6pFE/
         /OWPhvme/fXcL+SK/HS1740QhuetJ1ZiujFZ2tQKeQ7IbxSt677SiTkvdKy9nu4n2lBl
         LO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960090; x=1772564890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IINThSeLwgA16Z7d3cxbP1d5smMyCd0Lc8MEEhz9XEQ=;
        b=Lm1gH3S+Pw5kJ2/qTOPiAqCUNkmj5CGdqyRTZO+ch/8r5nm4wTaX4TQocQJ9r1Ab7H
         9/KRp+P6nFWQ1J8cg+rSBVzcppCDx8Hnb87LbQKrY3p8A/u4Rj5lPMQ4183BtuObUPRp
         z8B033LN4o+3bghT3A6jGj6Pc8E1fx+qxeCvHDOLBJKtoowFQkBGRRP5yc8kgwQFA5Zq
         Qg5RW8YFwD7LARHs9s5h6eiqTIhnRZF6cnp78rA76ue+W4M6rn6dPBSxyDnLERllfzj4
         bo14NgZRjbjKKFg1KIZfi1csJyZHkP+6W/VNU/Fc5uRsaGPGrSA3WlhrTRyqkmRJLboZ
         UgOQ==
X-Gm-Message-State: AOJu0YzOapmkvwF+VKErNZf2YwsK47vc3Ge9TtSml0Sli2rbYOEnGn3L
	zPM6skjmKqA5LbpzUAsTbBS7CFthq84V6Pxd5RD8zjsMn978FUR54p7A8ZRQWL2ehrEnw1I42D1
	VzMQDSekCeg==
X-Gm-Gg: AZuq6aLclCSNmMl4andWevPT1wUjtWyJLNtbnGaPc4+32EXzDFTkhX4VCGaHJl+2sRc
	oiih6ghONZwEO/YMwtMj4EmUDSk2S+SkFcdVEHegEWXbUhlK0+ng0C3KqvgJw+h0jHCsgKtKqIi
	L60A3EO0/u85fRO+gmnZ5k9SgLNvlNepCcrvlggmzL6wPWWlbLA7OzddosTS24sP2B9NfRHyHq/
	zVcJDFVaQtTl9r0udrjqJlmf6KeA+N9Kn0U6aIwOAEFoRSBP427gny4wKAotyBil5k8pkihppwh
	L8liOGUFuf5kK2TzKTgnyAzIngczFRGz2efg7g0OUBoTt72WRW+uZ9fBQxqK40hw8sbwnT3HhYJ
	rV9u6DHh1CsZH4ovfZke49IG2XSXzHM+quVDHnIkXkhc/x3rpd+3iJRh9IqtIZgV/GNutv3FTvV
	u9iw2Xx+w0rSIQfHcvZmmU5FawMOHX+GKNHSZ8qAPAK5hidtY0/1bFG6BxK6zwogOCrkLK3KQw7
	EGiTnh13swifrvXPajHrMmRvteOcQ==
X-Received: by 2002:a05:622a:1113:b0:501:3e36:1513 with SMTP id d75a77b69052e-5070bb8283fmr181282711cf.6.1771959624175;
        Tue, 24 Feb 2026 11:00:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c62fcsm102729701cf.23.2026.02.24.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:23 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:21 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/17] midx-write.c: extract `fill_pack_from_midx()`
Message-ID: <f3952f7db36585642145f5dc7c2192e5ddff7610.1771959555.git.me@ttaylorr.com>
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

When filling packs from an existing MIDX, `fill_packs_from_midx()`
handles preparing a MIDX'd pack, and reading out its pack name from the
existing MIDX.

MIDX compaction will want to perform an identical operation, though the
caller will look quite different than `fill_packs_from_midx()`. To
reduce any future code duplication, extract `fill_pack_from_midx()`
from `fill_packs_from_midx()` to prepare to call our new helper function
in a future change.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 9d345fb4737..c54113cdc84 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -913,6 +913,21 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	return ret;
 }
 
+static int fill_pack_from_midx(struct pack_info *info,
+			       struct multi_pack_index *m,
+			       uint32_t pack_int_id)
+{
+	if (prepare_midx_pack(m, pack_int_id))
+		return error(_("could not load pack %d"), pack_int_id);
+
+	fill_pack_info(info,
+		       m->packs[pack_int_id - m->num_packs_in_base],
+		       m->pack_names[pack_int_id - m->num_packs_in_base],
+		       pack_int_id);
+
+	return 0;
+}
+
 static int fill_packs_from_midx(struct write_midx_context *ctx)
 {
 	struct multi_pack_index *m;
@@ -921,13 +936,13 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
 		uint32_t i;
 
 		for (i = 0; i < m->num_packs; i++) {
-			if (prepare_midx_pack(m, m->num_packs_in_base + i))
-				return error(_("could not load pack"));
-
 			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
-				       m->pack_names[i],
-				       m->num_packs_in_base + i);
+
+			if (fill_pack_from_midx(&ctx->info[ctx->nr], m,
+						m->num_packs_in_base + i) < 0)
+				return -1;
+
+			ctx->nr++;
 		}
 	}
 	return 0;
-- 
2.53.0.171.gde83996e422

