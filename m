Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD58259CB2
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053098; cv=none; b=nFwRM2sDWjW2Kr4+yaVDbaW3wI97o2hCT26D3z8nBpqzhVkegwuc6iG7v93HND3Ar0fLtjndDGkCofICCaKbUl7fhio+UIQg95nBrGpYBfrsQYJ30IGW7QRF688qZbknxSkH0A64+S16lmDXI1o9FsjK4NHIxKwwrXZx2RTrSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053098; c=relaxed/simple;
	bh=uEiew1SQ2qFVlfB8cWg5CLIHVnReCIYXqnmnzj4iD/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrEsLtmdW+f409n6yJrtKPaZmXXWvQJUXIpzE5Sp1ZC48LXRWaGO5YsCKvdB1tXccMbYY3me0xrbeR6J+ainLyMsl6KHj2E8IDKjratGPW1o4RkwaGInUmHfcFiHUe21PUwDZbTdcXfsYtUOnjw+U2OpaKfCaY+kQyNKFLXqmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AG9x0X+c; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AG9x0X+c"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7815092cd0bso28092677b3.2
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053095; x=1765657895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dISg4acW1vHcExim1ixlCQq9scQHgRhkcSqizJLxRgw=;
        b=AG9x0X+c71crTDyDGLN/sUhyTGq2G3e+Ff64irDNVjnSpWZz3o0h+5EyMlTf0zdG7w
         SmOGiegiWup9VM+guxuySsT1R8puzEL/fUFKKlJ1FNYjyHwhNQaW7I7A/NdjnjGGI0Sb
         GMiw0l5bLLZoQAhMEKu+0lntk6L9WsIzqSrcXqLA7FMmDZYBDsIzr4+1rLBzvdA8m5B6
         PuMA03ZYKmvmK0cE5WXczmhQEXg8Sbr/cXxZR1E1FR+hYbzMJRUyY3QvqizvlfP2sbpK
         lNXSJkk7TYLUqvUm0E0WihyI6+AH1rqPLyeBLw1RfEDQlF+hXJVMmcC6WuCAG89Gfvwa
         Ptnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053095; x=1765657895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dISg4acW1vHcExim1ixlCQq9scQHgRhkcSqizJLxRgw=;
        b=TBch1m+MAJAdIu+PXLDpuAvFsmTNDvTpGS9hYz6VJbeM+zNa4mpu12aaN61fbVnex9
         Qxk5sr4Iipx2Kbyq1NOSv8RmBIHpEbogaRFlDAUIUp6WTFe+IqS+zw0zCvqASyGqAjIb
         b3qpfW8Hx/vVomR7eB6Hx1FLWjXy3F/Mf393+cvnTnxi9Dd8Hy7C7s6XMXWiozklcAYk
         NoNXOqcMYz4ePdY4NTXewNlJd490qzkVGQRJcLeizEIfkc26ZD2E2pBdPEd2RnkTBpdQ
         7roRzr7cFc5geLuvasW1i28PmRMug2I/Y3qSzGckTgoQv3FU1IYRqORivUz5Ft+V2qnD
         P/6g==
X-Gm-Message-State: AOJu0YzQeEL7ztfJPvOcwHuMYz9AoSUWuMCPb2NNotZasDnYKuVNR5E5
	SQqhzOlr6PPc0WdS+hSo/Hj2LOpIIrXbr7k9MlSAJZTlbs7X7XuN8mg15b+TfUqR4/1qEdvI5IT
	UJ6aBCCQ=
X-Gm-Gg: ASbGncuaPtrpQ4NudJ6mraCnon+NDIhaksJadre3ucGsBPiXhp1oGoRZW40fvATHCzV
	fiFC8bx4BjqykGyE7BI3ZzAUT+SZRajDYDfYvTC6KJRMWVcC65AMIWWnprZAk5hxu3UXXgBPXIY
	In8vjdiLEDKtvy8r5t8vjMQ+VVFBIpC/YJ/Tw7sUIDdO0NPP0J/mFOxn12O+/BAJhLVYnjoDaXK
	kCE7gEOdqAUhnJntgj2y/88PjI8PMQrHAvRrYNlffyh0gougCPU78SpN26vvGqgsjSH3uALCYmU
	+Z0IDmGNiKv4cQF+uG6BwJt2PGWT9wDtwVGaWHZJf+gBXLayoqEKJC23vKGxiNGcAZnveR1oBHd
	nznWtr6Q4rP+rHYHXoT3j6rx3yces0ZktjfaksE567aGPeer+aWOreGexX54zBQOboyN7KXCbm7
	uXxbPMEd6skDHpCR6oPp3RbjMI3aMxpZQCZfA5ITMsqYizyYbvtxeORTx+RrnoomCxgYrL/9P84
	rOaYlxa8gEJ0rBwrUgulWIAX0yf
X-Google-Smtp-Source: AGHT+IEQS8LsgbGYLM0UShIE/FRvASFF/n3DRHlNStfN28SsVDgBThjpJsQOMu5Gtm9eUc0ZgZTrEg==
X-Received: by 2002:a05:690c:a87:b0:786:9774:a3b8 with SMTP id 00721157ae682-78c33c171b3mr61731657b3.35.1765053095646;
        Sat, 06 Dec 2025 12:31:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f5b0c2fsm3349627d50.19.2025.12.06.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:35 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 12/17] midx-write.c: extract `fill_pack_from_midx()`
Message-ID: <d13fce5c79578720912d779d73287c786bb54368.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

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
index 4a1a16431a6..5927691f6a0 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -910,6 +910,21 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
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
@@ -918,13 +933,13 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
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
2.52.0.171.gd6a4e6b6955

