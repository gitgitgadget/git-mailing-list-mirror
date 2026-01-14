Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A73119C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420505; cv=none; b=ppqWMmx+xd5/23R60mVvb1Z8WGKeKyWrAx8Hp986IPYEHyV1Rx7KDr32qxvNpo2UhQLcba+NqLhaX0AMaZMXK7zRM6HeQrZiK+eeiPGY2gm0k93yUSne1D9BshYv95X6g/30EAl424JKP10Abf+izGJSwVz7Z5VD4IcgjanXjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420505; c=relaxed/simple;
	bh=+zyeEhuhD0eQJ5viy66c4bW8GxnmXkVeoqoqpfbZM1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1wUan2KpxDfEMGTrBCVN//cSE25ehrrnk8gAXQeV0e8FhADTjiHOeFsy8crrUi/HRLZezdYIPDsyvOX3LprVAISmPQF3IH6FOaNdJ54I/tduAf8rvfQBpxvdRvi0oTIQkAWq2YHY3WLFXqoIE12en4FIkeq1xZ6WEUPasNCvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iltY8nvf; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iltY8nvf"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-792815157f3so1421837b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420503; x=1769025303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TARmckEL9D4Hn34VnmUs/2TBdN8jD3pNRhxxY1Wdso=;
        b=iltY8nvfSFq1FS4khm+YU8S8Oo2Izr0GEzF4Gtb2X0tsR//je3AWSEfk1fqROuzy2P
         YFcirHc7C6j41ZNkS+n2isuBP9PUTEM/PLzdgS5yfP27VtTUDdpiHjNO87t8BmAQl2xv
         9ds988ykblEd58NCOOCADcM2RHeSfKFtGgQQ/BHK4sQaHN1pUgRQmo7xkg+j+IWj2+Xh
         hfuC8ZwgdKB8gRq3igDjvR0n74FvEjbv/Bbb3Bm8EAR53ytGru/HpfX3Y89LDuWvU9v6
         Mn2ifu1Un7mEfImwxhsQMMZjWJkPFhTmnEaAvlWN7KB19Gto0clJAPq4zWllMvj61GGE
         dFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420503; x=1769025303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TARmckEL9D4Hn34VnmUs/2TBdN8jD3pNRhxxY1Wdso=;
        b=MekI3mZQ8IwRRO0Y6obfPoCNQuApFUO0SarML/WLBvoOZFk9d6xsRPKNlte6nAVse1
         O+p/tc2mlcJ6kJ4ShdH5eJVhs6X5P08EcAVts8bGNsrmHfIe4LUd9apO2PY2hpN2HX65
         igQaEXuB1/CwmygFK8zsGN+dN45EXHbUra9TmLFlpXnfvaqVLikJrMds0BfIyqGm71aY
         f1RWX58MiprQAp05dLC+O9MT87i8rVebX8X0TaVzkJALDGxnsfBwWmk1nLeT02vA4LEp
         jAC3ZCWiyWu4srjm7wxmZjXdNf1Qb0yrUPrX7VLqRs/rltpydaZ5ZATUInKUBCq8wDwe
         HI7A==
X-Gm-Message-State: AOJu0Yxcamdm+hJfmJJzjvi/IGeMTBYEbWa5oOGVOFUrMzvZKu/GrkpV
	RBajxztLC/uwVUDqtlR+wKQZuzptMXqmGdhdiZwKBnrObkQrM/aOQeITvjgIHgAY8g3ZGaqIPQp
	YJDGQcmPKyXNe
X-Gm-Gg: AY/fxX4qrkfvNXgXiHkByGCTRk4hOnK+JvY0AJeloF7lNZXlJ2umAE/IBn1SzRK5pG3
	46JtuFwS04UlaJc/5LuNrrL23fYRdHNZOmc2g1f1rKXvuxiwPgmYz8DXgjIs61v2E7LdsTLAwgM
	IcTPERJFJR2w1btPeOieTUJHO6naod+82p0NbTmCZpkjRP8+SWYvxgLwbTsKBJagfoeIWuCjCQp
	cnPlENFn9Bi/vUiptNhfKX9BBqR6pyIxJDPVekl5vTZ86nlJhYI0cCjTeEmz7JSWVoQ0F6owCUH
	Sil8XOdeJ5b+BEUhWx/kpi4bJs1a9M/tVRNSXLbpnpIRsJ2MPLuX3Xdwi0wh/ENzprMnptqmoHk
	tBZ6OeEQwQFrHxnUhG5DsKkbHPmvtik2lq59nXYY028vGDqkrrSTY0gDuUGEYXlWBn7X8a9GItm
	S/6v7160pcB4M11/BCcujGfe19HrD0BMOccV7ubqLrrXIUx0PSfWJeBkcTYUY8f/Tjy0WTv4vXN
	5HecqtTYrOgYmOljg==
X-Received: by 2002:a05:690c:84:b0:78c:10d6:1e8b with SMTP id 00721157ae682-793a19c93fcmr31542457b3.26.1768420502601;
        Wed, 14 Jan 2026 11:55:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa670b16sm94064527b3.35.2026.01.14.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:55:02 -0800 (PST)
Date: Wed, 14 Jan 2026 14:55:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/18] midx-write.c: factor fanout layering from
 `compute_sorted_entries()`
Message-ID: <e71aa5754631d6458658220390021cea7dc2bd56.1768420450.git.me@ttaylorr.com>
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

When computing the set of objects to appear in a MIDX, we use
compute_sorted_entries(), which handles objects from various existing
sources one fanout layer at a time.

The process for computing this set is slightly different during MIDX
compaction, so factor out the existing functionality into its own
routine to prevent `compute_sorted_entries()` from becoming too
difficult to read.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 80334914d3e..ca2469213e6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -328,6 +328,30 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 	}
 }
 
+static void midx_fanout_add(struct midx_fanout *fanout,
+			    struct write_midx_context *ctx,
+			    uint32_t start_pack,
+			    uint32_t cur_fanout)
+{
+	uint32_t cur_pack;
+
+	if (ctx->m && !ctx->incremental)
+		midx_fanout_add_midx_fanout(fanout, ctx->m, cur_fanout,
+					    ctx->preferred_pack_idx);
+
+	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
+		int preferred = cur_pack == ctx->preferred_pack_idx;
+		midx_fanout_add_pack_fanout(fanout, ctx->info, cur_pack,
+					    preferred, cur_fanout);
+	}
+
+	if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
+	    ctx->preferred_pack_idx < start_pack)
+		midx_fanout_add_pack_fanout(fanout, ctx->info,
+					    ctx->preferred_pack_idx, 1,
+					    cur_fanout);
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -364,23 +388,7 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (ctx->m && !ctx->incremental)
-			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
-						    ctx->preferred_pack_idx);
-
-		for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
-			int preferred = cur_pack == ctx->preferred_pack_idx;
-			midx_fanout_add_pack_fanout(&fanout,
-						    ctx->info, cur_pack,
-						    preferred, cur_fanout);
-		}
-
-		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
-		    ctx->preferred_pack_idx < start_pack)
-			midx_fanout_add_pack_fanout(&fanout, ctx->info,
-						    ctx->preferred_pack_idx, 1,
-						    cur_fanout);
-
+		midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
 		midx_fanout_sort(&fanout);
 
 		/*
-- 
2.52.0.457.gb599f1ad4b0

