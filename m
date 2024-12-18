Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EA202F9C
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550916; cv=none; b=SFbbC4j1NKuHTHFXSvLzGVWP2m7eELUtVllHbnvfuLHleH5K0+98uvcuJEqXSTfbHSxhaYuoBO+pRRkUtR1U8Xds24qq+TZoIfbB1x3rfF0yQOaeKTF/NL1eXxyN3xM1+PYdB0zKB/QXusQ6a946YFr0GONrGo8IorcVoB4H4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550916; c=relaxed/simple;
	bh=8FjpD1RHw1c0dty08YSmla/2X5JMPpHa1F9QSEoLLoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUOedBhQ/ZTWdfN6iyvHtCnwdYIx/YahSTwiFAsoqNLA7jEvAjmmjVBEZWhXlyGQXvUED4cwFjANVcDB0DWl5zdu007//juEHh7Z8iYe1zuKMkuM+0W4A/T4rVFwomuczInyrLfsSQbpWbicLW/W0PrnlHXj2kQ9NerEXdHKIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZZOTZ/xY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwOCclre; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZZOTZ/xY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwOCclre"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38F332540104;
	Wed, 18 Dec 2024 14:41:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 18 Dec 2024 14:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734550913; x=1734637313; bh=hY4zNPrOw6
	Nm54whyW6K3xOhLqZeEfreKJ24N2gc+6Q=; b=ZZOTZ/xYlB5zm3rs68IDtXhD8R
	X1RZgZdrZhqZZkXEFsUNgbp+qI73hlqSsDjYUQw27nsDKN7kYDZ7mUSK5ENnCXK4
	+j5R/4EnXMFB3MMDfjlcSJx6H3HYCgpin+2WslfUUep2aMuCGQ/a3wMpYUVN3BSV
	65qs7nbEyMes2683izNsxaQKxxQ4A6kot/XFpjx3balxq6RgvQ9kbHU66Ni8H098
	WvHShzH+57k5lj+9ihP3klIZ2MlN7zg084sakULP27GMotPDfSXmZzCbje/mH8rr
	TFesm8xh3O3Y3MOSwT9Oj0bfrxyB6jyBv1ecjF3y80RVIdK0739Tj1XZMPlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734550913; x=1734637313; bh=hY4zNPrOw6Nm54whyW6K3xOhLqZeEfreKJ2
	4N2gc+6Q=; b=QwOCclrep8zOq+1uKpOqhByxqrfT3B1MEjlIX0XJ4xcsZi9spkw
	tq7deAtqr4fB8zZO1NFvGq3Hi78md6j9CP0a2hDFEGO8p6vrFczo/ZmNlSvBm+1c
	jqai2JDsvPk5e4PuKyzl4Ui2kqEVYOyQ+bxAw5P/OaHaSCPNvmpl7VcF24zj2xEY
	W+jdsbMxVbVFsaC6BLIA6cWBc8zoZiEcCHU+oy/SixHJNjJkqtjKoPjLx/IuP4UI
	vmsER7dqB7jbiJwERMjeSb2hgMYNGj022oveeUxQYJh2yEO0yktt7K76x3V8Bu4P
	HvEJ7E+T8l2LxXXQPjGmEzM2O1g+WYlBZqg==
X-ME-Sender: <xms:gCVjZ_NeZRrdmzdFTvjYus9DBEJSeublel2wfUATdY6NLIR3JNhFXg>
    <xme:gCVjZ5_bcdqHrDjai6f9URu22aH81joWoIU92-ADKkbRWxFX4Rb0KoeXu5k5B_G1a
    TLNt4x4WKjWsj36Rg>
X-ME-Received: <xmr:gCVjZ-S0v509WTRX0TVdXw3Mg_j4oF20jjkicEPuoeLQahaRFVI38BhlBdPvORgLEEkSQfuM2ipGqq6Rkyy1KmOrOS2DJPniqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gCVjZztJOCajoYGckYYgj_WvlkykvFQS_AqnI6ipAtFvQhwK5bkehg>
    <xmx:gCVjZ3f0acCMacFjmep5CPn72ii33mPN9a8CUOarnW4WgS5Iz8b-Kw>
    <xmx:gCVjZ_2cWi8CiXX6zvKNMLer2mgddjei6a0M5yjVvkGI7SjRHBOOuw>
    <xmx:gCVjZz-3eSRg_meT4uITK3Pk5IBWjjP-XwqCkA4wBJv0jBvaZlch5Q>
    <xmx:gSVjZ_RmBFB1HZt8M79o_0YiPWdwhEPRB1OEavJeXAPmyIXbgQ4JPcKt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 14:41:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] pack-bitmap.c: ensure pack validity for all reuse packs
In-Reply-To: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 13 Dec 2024 14:20:02 -0500")
References: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
Date: Wed, 18 Dec 2024 11:41:50 -0800
Message-ID: <xmqqa5cspym9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> @@ -445,18 +444,6 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  		}
>  	}
>  
> -	if (midx_preferred_pack(bitmap_git->midx, &preferred_pack) < 0) {
> -		warning(_("could not determine MIDX preferred pack"));
> -		goto cleanup;
> -	}
> -
> -	preferred = bitmap_git->midx->packs[preferred_pack];
> -	if (!is_pack_valid(preferred)) {
> -		warning(_("preferred pack (%s) is invalid"),
> -			preferred->pack_name);
> -		goto cleanup;
> -	}
> -
>  	return 0;

This is a pure removal, not the block of code moved elsewhere.  I am
having a hard time resolving the conflict between this one and what
f34db3f6 (pack-bitmap.c: open and store incremental bitmap layers,
2024-11-19) did to the same part of the file, which is:

@@ -459,13 +478,20 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	preferred = bitmap_git->midx->packs[preferred_pack];
+	preferred = nth_midxed_pack(bitmap_git->midx, preferred_pack);
 	if (!is_pack_valid(preferred)) {
 		warning(_("preferred pack (%s) is invalid"),
 			preferred->pack_name);
 		goto cleanup;
 	}
 
+	if (midx->base_midx) {
+		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
+	} else {
+		bitmap_git->base_nr = 1;
+	}
+
 	return 0;
 
 cleanup:

Both are from you, and I am guessing that you have tried all of your
topics in flight together, if not the other topics.  I wonder what
we can do better to make sure the work a contributor has already
done (in this case, resolve interaction between two topics) is not
wasted and recreated (possibly incorrectly) by the maintainer.

Thanks.
