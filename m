Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F1A22B8A4
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717953; cv=none; b=CWjBz9OCosb/jhAEeRFPvv6qp08ObxxfxM8IIHhFXcnVMM1LHTYKrMH2gkMEqMx0mLph41bjPYm3Yig1uKcj0O4jjEB2izvtjkuYOdSMfDE9u4/B1qT1nyMqartCtFkMAS4EvxRej2i/rFmbVpS90J5pxt0ro/cuqYYRCL3Vxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717953; c=relaxed/simple;
	bh=oV7bCwZzJF2zEgs8EQ7vdxOL3Kl04ymHif9jsxuse1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAjZaMPllqmLHx025pQkApgZmsZ3s8PfWWULqtlOmCjNfZnbUau55rBtykOVltpKH+OgJVdJN2fdGsrPzUUgDp3CseYoZR2moxScx8eHbXA3mtgX9ZysUQaNNah++PajRE+I025+yH1WS8pKGWomJPND6Ejxjb5VWv9AN+VRYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=f+Gg5fSN; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="f+Gg5fSN"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so2905294276.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717948; x=1751322748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+b5x/lFFmMiJy0pq1GhQqZJGpL6WBf8DinwfX37yns=;
        b=f+Gg5fSNWVGzv1AVBb6rIiV7NdPcQdAzedgR9ZsU+KyCGzAQBx7YajwW1ac+T7O1RO
         X0hC3EHH9BOLscL4X1+bi4dl5uvkAOGILFa8JuyMtfx/sK1SDQKGDIPASng0LAADUiLE
         8lazq0GHUryfO4vnF0M6e/rMeFZc+kPmMTDwohpijht54D6Tehb4hXNfM9dkbdArlgtb
         R1F9mCUHJqvAE09QFjHNL9+IVBH3hP2yNfFoCtbuRrLY+CzNwxiChc73Amo6bsmuh1Ni
         VVS664//Io9KBRcdJiCS78zsifu8pSnwtuw7cm/PbWtegC5xdL1jjSObMZQP0MAGY0f9
         LJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717948; x=1751322748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+b5x/lFFmMiJy0pq1GhQqZJGpL6WBf8DinwfX37yns=;
        b=M4HNyHRpiTmM9JSz56dmkGFS+hpxTTH87LIj72Qrhh0o4DjGuOTPQvkiZJlYFOxSdA
         nvMVybHlQmQoo+hLzmakZdq6z0eIcqRLRn4jPQr6Ivsgvul0QvBAt0SKlmiCmN83TTA3
         6Ff6bhktcuRG3UPSZ2trYwwtqH6wpTxBjCpLxtlNxCgasHCamVFQbMUZ3DgfE8pDbtah
         KS7H8h1sOdpND7yKc+kmrUS2X6b2+K8KUug5Mk43cwAvJobxxWu96QZwfD/MI0K5UOZ5
         fPdU7/moMjl6MN3NAdpOlGuKMSOxoqn/oNJtV+jl3uQM7DEPWDGFg8lt4KFwJTsuPsRa
         9BSw==
X-Gm-Message-State: AOJu0YxiItgeNy/RXAu0CYdjyMVQAOfvud63sHA8lb9wxdGNIx4JZvtT
	P5I5uv6bPx/c8Hh+etwWOhc9IWEVsxipGE9BQxHAfIyDg792nZ9wYvszxzZSz11Hl4KecurDiHs
	doXib
X-Gm-Gg: ASbGnctitj0qOWlN9NdqT4Y2z9eQPPWoswpcn6nFWTCpydt7/wSTB4aqSoEM83cWcrk
	q8wDngW5ChMFoy7+ajRCDgV8AlMDYWMJbTw6qnJwHu2dxs6Y31VmgqVnCVTOBwH6l95iBkMsj2y
	PJF3QxvYjQDD7ujZDdvdxLE5KL42jN6EUaQLsAtYk+xID/T6WFy77drp4siM3px0seXrgzdU6Xn
	Um9/3oq3CzijmJz8sbQ7NO6UmuDdUAs/A3itnK4vX1/SgMWeYIsj0rxbHn2bxtIQgRWZ2eyyR/q
	V+hkpb1P4BsQNpFxvzVgB8mwBp2x+SStEFXha7gN2+/oahcdufhvnQ02NiggDkUMchR3eNzMs5k
	+sGQpOZ03/CTJZj46xTKT0XR+GyCw7Rqxng==
X-Google-Smtp-Source: AGHT+IHnjH1w7QOoLEPE+N2QCgkILzLdqbC7adXOhSa+rr2jE/d/pi/+EpT0hzYvurJqEB9H2aTrfg==
X-Received: by 2002:a05:6902:18d0:b0:e84:cbc:6b14 with SMTP id 3f1490d57ef6-e842bd1740cmr17665746276.45.1750717948396;
        Mon, 23 Jun 2025 15:32:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842acb3947sm2692849276.54.2025.06.23.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:28 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 7/9] pack-objects: swap 'show_{object,commit}_pack_hint'
Message-ID: <5d15055985a8d4eb5fd7f7b9026633c74d6c86a9.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

show_commit_pack_hint() has heretofore been a noop, so its position
within its compilation unit only needs to appear before its first use.

But the following commit will sometimes have `show_commit_pack_hint()`
call `show_object_pack_hint()`, so reorder the former to appear after
the latter to minimize the code movement in that patch.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9580b4ea1a..f44447a3f9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3748,12 +3748,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit UNUSED,
-				  void *data UNUSED)
-{
-	/* nothing to do; commits don't have a namehash */
-}
-
 static void show_object_pack_hint(struct object *object, const char *name,
 				  void *data UNUSED)
 {
@@ -3776,6 +3770,12 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	stdin_packs_hints_nr++;
 }
 
+static void show_commit_pack_hint(struct commit *commit UNUSED,
+				  void *data UNUSED)
+{
+	/* nothing to do; commits don't have a namehash */
+}
+
 static int pack_mtime_cmp(const void *_a, const void *_b)
 {
 	struct packed_git *a = ((const struct string_list_item*)_a)->util;
-- 
2.50.0.61.g1981e40f2d

