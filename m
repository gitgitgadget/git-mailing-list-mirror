Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B1C2C9
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972293; cv=none; b=FInJ34S9hltrwRlDqDsmsxj37lSnaQcCG3Pf5fhsY8VeELkRyXpbpP8qytscXh1AvucSl8gC3LYP76gA102eO3CVDFfkj09iYO1zUuEfIJXOgdt+FIi1896YzJb8BwBa+qYJmpyrb1zPXl4w7MqXQZITb0UUiaxTuyyOlEGmPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972293; c=relaxed/simple;
	bh=nhRrt/hYkGyu2a2/I6IPOCfWiUgtVoCWb+/Ndfh63sY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utMQPqp1qRbv8TRMIm2A1drnJZ4N3Ycikmq1FmuThqJ7EaRTyVL/sQLy2oVEmT2UqaPfPnnDFyzsSoLjuIuNc44BYYRLGa89vKoaHayORfkwv/ipJx5p2VQ2Ve+y82gk3OarA5Vxl6c4H8TyBr/pbWNokMaw3OZysehp73ekOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CysVbISm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CysVbISm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2402b5396cdso31401195ad.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754972291; x=1755577091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IRmRglRwPWCCVsg/W8So/WU+pG0erezuc2ItPn6a/s=;
        b=CysVbISmmVhXjG0m7RHqbz5t8JevR3hf2gXrltg+HeySJsyN0EA/dzKmbL8qUbZuxI
         F/zZ5nXEtH0JFycScV06ZBDUZEEek3rP8GyYIwCq6L60YxJ+bJcSpA677mNn6VqF2JgM
         tq+HQ1a7mbzy9FGeOSf43AYxa+8t577/biJNlxU/4FtNN4fgGia8G1JSJFLY1ZWeZoV3
         2NuKuuDfIei/akiP4XjrwQOWnG+66LKLmqNH68bl9UVf7jI12PN243tycjUmkY5HpKjm
         VoL08vFL1dpW7PVj1pv+zssGNbk6VsKwlR0bo2W0/WkhmL5CLec3PuZsrADgg9CdPvkr
         kgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754972291; x=1755577091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IRmRglRwPWCCVsg/W8So/WU+pG0erezuc2ItPn6a/s=;
        b=J4j6Pe5aE9Of/GFD78QpxENZYoofOjB3Kz8nZLFmny8jle2AUVn5QpAh5G+oJzD9of
         C0eFiIGg6fOza+s2nRSiUzoLajWcVUcLkZod9INfdz4wxY1GzfWojTgaQK8YmJxu7AM0
         Z5oy7gb7L6IzBBOVU4SMjI7Ckzg+v2NQ8d7UoP7t972oYDQnXgYeKRZ2TmWuK3JmZSLa
         jChHwWP5UOD1skwE4ks6bDbb4AS+6vEw4HVby2shImPFClcrQJcgX713WNtodwXc5LbO
         mGPFmOXqwRz3C7OOMNb1cVDdrXZmSw0ufGmp9rrK2e7Ol8Zji+zuBSXkhst+H8dsFIrk
         20tA==
X-Forwarded-Encrypted: i=1; AJvYcCVRx2m001KXBmPpISQp9jwBc01xNHVrkLbQDHz2RnxFiOKlQOG6Wa1gRJ4ry37hkgvFnOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTV8Qc0QVNv1YxQT2lSOR5G02bP9bQIATqDjPY529idEMPTSp
	oufjJU4pK0SCMHuhUUO+vG9BUvk901k7kbzrJrgWgZWyw3EFptkiSNhQ
X-Gm-Gg: ASbGncuJtEi7XrXXILVtrXZRdQ494gksYidNt6O8swbPiXSLytRwHKboE0qjdkeMVEY
	1hWrTDUe4t6GUL19DmIXcgs3X/3hlICOEQdIREW6d1f7sYej9esctDxM51l4WE6Iv/LiL77hyQa
	rYZpfgPtM1ht+sf+2BDmDHC9K/WeAAdELAMPUm6D2xKwroXqrZi0SsAEIqCHMdLiKIuOaeMCZyS
	FptV65QFDReHsiTqWWet1wsd/5ZyksmpIWagb/SE7b8XagWN9di3nWKcQiu0DiWBTji1Xyszz7g
	5HAJdRZfgnPCgYToUlFTMd/4xCxBUF2rBXK8g/BOGCE1kK6n1Kok/iRe7n9eXMXBzxqeBHRb7gZ
	hkXnYcPGXqycMdh8X0vSByJ0lVNGPROmXiUZaBJpDFwvEarbydiIaC/4uPezd1aLRXO3aJs65Wg
	qoJHmreVJm5mUX5bY=
X-Google-Smtp-Source: AGHT+IEFfKrxXnuXMvkauiGcWrXC1BwhgUf73672/shpYNHzd7aYuwsIU8AgAvzKnaiTHjbwlHBCbw==
X-Received: by 2002:a17:903:2408:b0:234:914b:3841 with SMTP id d9443c01a7336-242fc340444mr30372425ad.39.1754972291292;
        Mon, 11 Aug 2025 21:18:11 -0700 (PDT)
Received: from Reys-MacBook-Air.local (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5970sm285383555ad.20.2025.08.11.21.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 21:18:10 -0700 (PDT)
From: Carlo Arenas <carenas@gmail.com>
X-Google-Original-From: Carlo Arenas <carenas@reys-macbook-air.local>
Date: Mon, 11 Aug 2025 21:18:09 -0700
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
Message-ID: <qruwf2zjl2uvf33mp4ajklvgx7wq7ctghu53rxzbgndfojudvh@ylr4otznu2og>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
 <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
 <CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
 <aJBNHzE3RQBZZTcU@pks.im>
 <xmqqwm7i527l.fsf@gitster.g>
 <aJGNaQwnd6_A0Ppw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJGNaQwnd6_A0Ppw@pks.im>

On Tue, Aug 05, 2025 at 06:49:45AM -0800, Patrick Steinhardt wrote:
> On Mon, Aug 04, 2025 at 12:14:22PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > Yeah, in general I'm also of the opinion that we shouldn't bother. But
> > > in libgit2 we have pipelines that use such older compilers, and we don't
> > > want to drop those for now. So I think we should treat the reftable
> > > library specially, doubly so as this is the only instance that causes
> > > problems.
> > 
> > Hmph.  Shouldn't there be some kind of "shim" layer where these
> > things are defined per project convention and/or toolchain being
> > used?  So when building for git proper, you'd use {0} just as
> > everybody else do, but for others your include file supplied by that
> > project would use something else (like {{0}} in this case)?  That
> > kind of approach would be a better solution than open coding QSORT()
> > in the longer term, for example.
> 
> We do have a shim layer, but I don't think it makes sense to use it for
> every small piece. The intent of that layer is to paper over platform
> differences that we cannot easily hide away in a generic fashion. So
> things like mmap, random numbers, handling includes or registering
> lockfiles via atexit(3p).
> 
> But I don't think it makes sense to use the shim layer for things like
> `{0}` vs `{{0}}`

I think the suggestion for using a shim layer solution is relevant, because
additionally to the compatibility issues of the zero initializer, you also
need to take into consideration that the proposed solution will still trigger
warnings when compiled as C++ (where {0} should be instead {}).

Why not do instead something like?

diff --git a/reftable/stack.c b/reftable/stack.c
index 4caf96aa1d..80ce8a7083 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -704,8 +704,6 @@ struct reftable_addition {
 	uint64_t next_update_index;
 };
 
-#define REFTABLE_ADDITION_INIT {0}
-
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,
 					unsigned int flags)
@@ -859,7 +857,7 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 				unsigned int flags)
 {
 	int err = 0;
-	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+	static const struct reftable_addition empty;
 
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
 	if (!*dest)
@@ -879,8 +877,11 @@ static int stack_try_add(struct reftable_stack *st,
 					    void *arg),
 			 void *arg)
 {
-	struct reftable_addition add = REFTABLE_ADDITION_INIT;
-	int err = reftable_stack_init_addition(&add, st, 0);
+	struct reftable_addition add;
+	int err;
+
+	memset(&add, 0, sizeof(add));
+	err = reftable_stack_init_addition(&add, st, 0);
 	if (err < 0)
 		goto done;
 
Carlo
