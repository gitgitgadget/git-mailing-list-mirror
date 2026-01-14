Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCD33ADB6
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420499; cv=none; b=FgWjThRTWSC/qmoMFUoBujSR3i1auc2387cwAeO2MXskj+MHOczqbL5apHeUSQhJeLr3zs7K0hiOYITzjE32pFQSGqpmL8YXe50MV6mKpao+doLWAtsRl4madd9N7TTVGfQShCTMMjCV85AJOORP9LnCnSK/Og1BMJTB2cuWzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420499; c=relaxed/simple;
	bh=h9v/6mHKB/2XVI7C4llEQx5d7jCd1/a8T+sP47jwUIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2ZymYPELfBMYHduuzR9eC7gZHl0DtsBwadhLODESpbY1Eg7+pueElYH17s2boPnRfp615lZCGpTxnbZNBFCV5wEsbOaj3syHutesuw9e8yzOxvAIcYiJeUU2fZaYE6cYQmRqPWl53Ehaq43WXDca858a+JDyts3tjgKwAcvMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Vn0Ft1TT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Vn0Ft1TT"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fb6c7874cso1722757b3.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420497; x=1769025297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ja0pbNqT3etIdpfAVVDCjjLY/BwTEqkbnzOPGeA1MBA=;
        b=Vn0Ft1TT0YKA6lfpCNPYuy2zDbC4YlhJ4hYqHK6GKLrGAytuRmnnBzfIkqrxWtD61k
         gqfm91stTKvhj+banSw0bB6iJMJ5Mg73D6rWnbzYxlYg8RVqeidaHARJWxGC6c/+zxPR
         Hz7GbBe3w8FTbZeptZmbszRI596IrFqdiZy4hp5x5CQ/P0KfY0GRIuNqJwi5FHvExH8r
         myBr6JH+GgUGr4ELKyoxFYT9sjMV2lum5otCmIGy5rkltUAqAy9UzlCXEVvZKl2s5ZKF
         ythIVkoLfVngzu7tjUK5hcpMtCkG9E3EclL22KDm1cULrq6pIYpsgd/1spIb3cJhSMhy
         LnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420497; x=1769025297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja0pbNqT3etIdpfAVVDCjjLY/BwTEqkbnzOPGeA1MBA=;
        b=uWKX7GnswB1GLE1PNAhXTJTG0GTOpcV57v+dGapsH+/si8S/qFs01/JeiP6y1RVFpj
         b82gTZ9HThFipEoNY3z+SFSPtcffizDeyysU6WLkoVqF4nJ8+s7ktFr14m9zj+PxINFZ
         SgielRux5Jap87CRhFQYODPTgUEGbPP1dLvlnz17LeMgJlP5IM7LyFBoWGu/xIw/N+Q1
         tSzzqme+lnhRhgrxxdAXn3DgC2nECmDOXuIEnYIvIBP95HxVA6pesAvLM/wBETZW7T+9
         I6aZmXWJ3vg/tWs6altMUO6RcfYvY2a++4m76SGkVLg6Moudth4JAQoi1NL/gEjIwjkc
         IU/Q==
X-Gm-Message-State: AOJu0YyzhB1Qps9oKjUOZvBEtZEvZgItRxi9S0glDyDLgLIBg+Y13WAF
	cTT36a442aGi7AIqoI9tqTka6EMusdNbC5h99dHsDi45YWYCMZ+Dq1bY+Czdu6KVLVFafzOi4mE
	mbwbN0J9tmg==
X-Gm-Gg: AY/fxX6uwap+iTO86IpA8+YE/Xwtt7nbwS+gD/nRk31cxVJvv0Vme0HsLBMdqhjzxmy
	wj/+aoAu8Pv39EYeOzYF4mDOOfKzxUsHFxXK14PLhSxWmJsGG0ipehkQL7uy6itD7FSEJZtQs7s
	CQqIg5vqoPl55obAGSo+kMEDm5fpAdfGTjaxw3Pjdi7t91d0LbiVGraTdU8CCuIyyxgzMIlWHzV
	rW0tT9pcdFmzj4oq3jJH95Z8sFr5Eh4TFSL5eEmXSnidjY/14yLwj+puf4Kzr4IjYzx57ZGNHQx
	y+/q4yZ6fYH3XWWJdEdrWp82K8X9Np1rIfPW/4RtyoQU7EpTKRefnwgm5sRFqsky8ldohUJR2/F
	JsaTiWDN93Cba6qMH+WotSEJnj3TdoXepnRTOgypMX+5hxqn5j5P7TLIFWs4m7QEoKW7T8eU1n5
	TvwmwAGawQceuGRCJHsZxs+lM4E07Ic+mdX5nV8xvtA41DmnCT2LfF2YfBn2jvBBaQPPfs+HtaS
	z4H5KIn1MytHoTKVw==
X-Received: by 2002:a05:690c:638a:b0:787:c675:ea16 with SMTP id 00721157ae682-793a1d4bae9mr32981737b3.43.1768420496482;
        Wed, 14 Jan 2026 11:54:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dc249sm94191717b3.51.2026.01.14.11.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:56 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/18] midx-write.c: extract `fill_pack_from_midx()`
Message-ID: <b9244a0429730badb6472e827a941a33855add3a.1768420450.git.me@ttaylorr.com>
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
2.52.0.457.gb599f1ad4b0

