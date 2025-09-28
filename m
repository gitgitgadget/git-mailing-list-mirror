Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD502BD58A
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097304; cv=none; b=FA2/DDCO6+Qe3eI7R1nvqNuOQ6kpX1xDM+IYXRDZFySBgj09QxD404x318yjrHlpAogMMZVh493f6Fcc2tq7WRTLDDB4tRG3GbYlkbscT5SNsJ4DXIRSrbNwFy880+hbgkDaivSMvZ4TsNXDF3Ew/Kb8TWp89NImEE+SErdIN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097304; c=relaxed/simple;
	bh=tp7tO9ZPHhkX3Ii43AIfUHK7TtF0+n1kFw76x2pwkdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDr6a604T5NIiN4p6Grw7KsP+wMpVYNCcCtd6mcN1C+T8To27AZQMYj/+P41l9h7WtPY6uUsyFHTXGCSBahJOpNSVA9vKb7/sFK5mPbmazfiBjM8FY4lrM78HtNyQF+qcvYwNBmfCebruEGS57fKgSHz2/OuKe1HZp9wGr11IZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mLOm46D0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mLOm46D0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603acc23so37839027b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097302; x=1759702102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Oy0EWthpLkHebQAzlKniAr6Iqej06FfqWZfA94Vwc=;
        b=mLOm46D01y9kF6HbKpwYl7tNTn48oaDJEBouurH/5V7Mn/222rDKILa3EkNP2Uj8j4
         BVW9m9H0B0Lc6QfI2f9IjEc6lJg5bjaeyBATBBUJeBDuH+Mx9JekE76dbuvbAFNGomhp
         X3EvrlGjdHLJBgAmRUbxUk9u2vl4xPAZoY/PPDSi5VO7nBonjhwbs0z3C35XnGVLkbEQ
         kS/tsn964xSHLByO80b+/q8rGT4PJQNAMts3GVoiyTv3ZC/+FVyt2YbtLlnq9uMvEcuN
         UDllbyWi1dERuatCdNqOQGNdXS/hqK0xQE6BCQ5A+8QZSubWk36+vZW/YuYv1FKu5kDV
         gojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097302; x=1759702102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Oy0EWthpLkHebQAzlKniAr6Iqej06FfqWZfA94Vwc=;
        b=YpkVCIxnroOfT+pM/8ZcAYWG8g2AR2Tf8I13Wbgz+Hxw2607DxYyI9/g6hRLRplOK1
         yEJIrMgTjQ4qsRCJVp5fp4u11i37KycvUrFS0Bk7UIwd3K83AGMVppAvdQkKcAXKyKmP
         butTRXp+3pGngqaNhouD5K8S3qfgN/j/uUB1I+v6MQu1jQEnq3ZTiPLFeiBh1yn43fKu
         OSiNCSk9WjhEFsmLaJxvdEex3Izk+5vZ8j9s++CYIiGD6I/Ar4rQueZF3O9W81VXLi0O
         Kclz4U291c8WgGx8JSEATnETTSRXaLdgeNIJIUlQzYNSU8ooTreSjS7IW8vMnaY5RY2h
         X+RA==
X-Gm-Message-State: AOJu0Yyn3YAiNARJDlpO5zHkvg/oEtwExj8fAr/3t0nEEcaevKMt/I1G
	phE/9uKMtdP1eb6f6x7KmABjQJ5u140Vo+ElKnKgy5wihy32E+b6li3/TCCznhk5O28nrfRR4ZY
	2xvrfqSo=
X-Gm-Gg: ASbGnctRolxVksOM3m/wl5Oe/Krjo0JAfXil6cfuTmHScwtCbalVbC8iu9vn/YGtEuN
	HqpeiFEBbMOVkZ/jjko8JW8rr1XRsl/03Slw6ZgZZwcfU1VbTtHBMeAmwh4a4LGWzKooIOW9okB
	7iHSQdSo29/y2k7QxtIZ7TBAbZr4xBeqJg7SkePLNEBq1xgY+ZP83lVASkaZDvOoE59YSb1Zro2
	ahw1qFRYPXEdacPnjYh//0MUH86MI61B1kF4mh3RebfDexLe0rtNf9AsTRAa40ApsbPgOYrpf+A
	DP2B3vhrjYfh/SP6W7qEE/IWwIUmV3qtPFXw6qGVM0vZDGHNZ7DX3kiJkfrxl89/h2ODngSwsdf
	HEqV97T9xT5RwtFECPXiPgHnjXGCA5OuqYWVdo29LJEUUrP3Cim+rKn7/tyg95I8B+0rbOVlKqV
	c7rmSSLe3FMa/oBnSsZVM7gCa72g==
X-Google-Smtp-Source: AGHT+IFRyBW5FXQW5GLDbfIk+jzmXHWTW3H91ZHfifHWqTqAdVpIKdcyRucjq5KU4rdAAOyhYddBlg==
X-Received: by 2002:a05:690c:45c9:b0:74e:d990:5550 with SMTP id 00721157ae682-76403423548mr185243587b3.39.1759097302106;
        Sun, 28 Sep 2025 15:08:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765be47f630sm23242817b3.29.2025.09.28.15.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:21 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 18/49] builtin/repack.c: avoid unnecessary numeric casts in
 existing_packs
Message-ID: <f413f958ebb44acce37cd2f0555d820ad7600c0c.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

There are a couple of spots that cause warnings within the
existing_packs API without DISABLE_SIGN_COMPARE_WARNINGS under
DEVELOPER=1 mode.

In both cases, we have int values that are being compared against size_t
ones. Neither of these two cases are incorrect, and the cast is
completely OK in practice. But both are unnecessary, since:

 - in existing_packs_mark_for_deletion_1(), 'hexsz' should be defined as
   a size_t anyway, since algop->hexsz is.

 - in existing_packs_collect(), 'i' should be defined as a size_t since
   it is counting up to the value of a string_list's 'nr' field.

(This patch is a little bit of noise, but I would rather see us squelch
these warnings ahead of moving the existing_packs API into a separate
compilation unit to avoid having to define DISABLE_SIGN_COMPARE_WARNINGS
in repack.c.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c5a88eda12..e13943b637 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -156,7 +156,7 @@ static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop
 					       struct string_list *list)
 {
 	struct string_list_item *item;
-	const int hexsz = algop->hexsz;
+	const size_t hexsz = algop->hexsz;
 
 	for_each_string_list_item(item, list) {
 		char *sha1;
@@ -250,7 +250,7 @@ static void existing_packs_collect(struct existing_packs *existing,
 	struct strbuf buf = STRBUF_INIT;
 
 	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
-		int i;
+		size_t i;
 		const char *base;
 
 		if (!p->pack_local)
-- 
2.51.0.243.g16eca91f2c0

