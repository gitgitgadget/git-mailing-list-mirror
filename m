Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398E28E8
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743760814; cv=none; b=rCJEeoXopYSo/GTlr8528wm0oGa5Y9sS2giHP5aeSh63UXUUYBJvNhZ7WQqT6Jh1+Jc4RySkOmagy0u3rjCAoxz6EE3gBDfcZQdNMgNIDkyU4K8Hq/Yf6uPDl+ZRD0GwNeGypK1l3UM0EU+S3S3AxYxxFSyaVrGL3RjsoeHyCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743760814; c=relaxed/simple;
	bh=0dHT0d0MMm0jkB3SKTaoQ6EV4fNHFTXU7TtmtGqTN2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYJT3jZDOgJXLgjfSZn6yjMY+U60HrYk8D2pawbG/Vyz6zy8aAqSg6EI1n58dfPFzkBT6cGIhMiU5mVDBPTtq2sku9KcO75RpdhO7/VR3szyC8Yu+9WfN/njK6QBmwP5fGdl9gGlHSEDkpt19F+4KkEQdEqSJU8578DW58cescc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=df3kf5vk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzZ8Sid/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="df3kf5vk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzZ8Sid/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 262AF1140146;
	Fri,  4 Apr 2025 06:00:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 04 Apr 2025 06:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743760811;
	 x=1743847211; bh=iGMy1sszCyqty1jxwiPLA9HjojjjG/SuHBPsCl28eE4=; b=
	df3kf5vk2qsj68PoGIdsu0v2dHdLR/PknztbXFgV7zIfGwU3phRs0pxoMut5Bryv
	QGkWmbcxnWkjeR9cr+iVOLQebeR/x6OWDYuYf+7swLSFPQwNV/NQ6pEH1VE4baKA
	ooFdGnotZs16C8N0zSsPsB8GPXV9FuLsKRXAdpGSkorBoIsPQIM/dPM6TW3HSSLd
	73lliqac3EX8twHNwavHpOxeuWIZycpQoJ5OWmdqPi2w1GFQnPD9FVTkOErmPAay
	Y1gKtilkUEznScVJQcxgodsv/EKfuNaUOUugdDsSY98WWfsgnktMGyydmA7KtEgI
	PhKp1uh1yyneUSobumtZyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743760811; x=
	1743847211; bh=iGMy1sszCyqty1jxwiPLA9HjojjjG/SuHBPsCl28eE4=; b=H
	zZ8Sid/6lArsHbvy/pqp2ztfPsboYdGAFFkjuMzIfFi4+R4WVmlh/ugqvusC6q9W
	i+BnYG2bqcUpJVjjeiBJojfqe40gndOmBAEaIpengylpUoAu1g18TVRiflCYtPwo
	PGi0heugskEXitFX1nCNzNGOXUj27Xv4YAfikAGti+lXg4aiEoX8B6iuieUElgLg
	TD9vY/UwgTddl1kVD4O/0HYAdH3L9oJZfPBgsPY6ZFG5LO+ZejKQ/XL5XLwvxupE
	UH8UgCXkWd8v5nKmDo8kQbDrt6c1Sek27BXIN6iOVJNkd4mYZZgyW3wuvEIWHUw9
	h9wZ7YqmnW3gQKY/kqQ9Q==
X-ME-Sender: <xms:qq3vZyzTwmjOIPXIpgZfCkk0BV3Reh2RX2GCV69a3csGYbT9iBR1uw>
    <xme:qq3vZ-SNM8HMsROewDLqY12_SPox5iWOZNMSmX8Kg5amE5wVPhwIMs2vhXJcyGENr
    ziItn1WxYLFvd-buw>
X-ME-Received: <xmr:qq3vZ0Wa_hECGxp2-g7xjsOsjaJjF1641EjFJH8kG1kJlDZlra0Jtzy-3rImgo4ZJvpxg7zuAfuT1HMt4r2qeSCcJKmzMCZ47qkXELen1nn31Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhhvghjihgr
    lhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfh
    grmhhilhihrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:qq3vZ4gZgbppYgYTMasLuMbG_5pXdoB90F3udN9RAEIvIMnVMZtRWw>
    <xmx:qq3vZ0DTixvo1mNmjrXt7fO682MXvFLcwu1ugIpQd5sLrKkdw-1FxQ>
    <xmx:qq3vZ5IOOxrlm33mSAJG3NbdjKgSqHatRXY8ucYXCijCeXdhvMLOTw>
    <xmx:qq3vZ7DxcbfZKAaiMv2OTcJuSnkBWXlw7jxm4rkjEfjGDmMMu0h36Q>
    <xmx:qq3vZ2GMC_WN9mEH1rWpAEkjnwdmkfZzW5D_9uP84o63b1j3QjvQjifD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 06:00:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id beddb0d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 10:00:07 +0000 (UTC)
Date: Fri, 4 Apr 2025 12:00:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Message-ID: <Z--tomMthXftrdYA@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
 <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
 <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>

On Thu, Apr 03, 2025 at 12:56:39PM -0700, Elijah Newren wrote:
> On Wed, Mar 12, 2025 at 11:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> 
> > @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >                                             &iter->oid, iter->flags))
> >                         continue;
> >
> > +               while (prefix && *prefix) {
> > +                       if (*refname < *prefix)
> > +                               BUG("packed-refs backend yielded reference preceding its prefix");
> 
> I just triggered this bug upon a "git pull" in an internal repository:
> 
> $ git pull
> remote: Enumerating objects: 161255, done.
> remote: Counting objects: 100% (55884/55884), done.
> remote: Compressing objects: 100% (5518/5518), done.
> remote: Total 161255 (delta 54253), reused 50509 (delta 50364),
> pack-reused 105371 (from 4)
> Receiving objects: 100% (161255/161255), 309.90 MiB | 16.87 MiB/s, done.
> Resolving deltas: 100% (118048/118048), completed with 13416 local objects.
> From github.com:github/github
>    97ab7ae3f3745..8fb2f9fa180ed  master
>                     -> origin/master
> [...snip many screenfuls of updates to origin remotes...]
> BUG: refs/packed-backend.c:984: packed-refs backend yielded reference
> preceding its prefix
> error: fetch died of signal 6
> 
> I made a backup of the repo with rsync.

Thanks, I can indeed reproduce the issue rather easily:

	test_expect_success 'list refs with unicode characters' '
		test_when_finished "rm -rf repo" &&
		git init repo &&
		(
			cd repo &&
			test_commit A &&
			git update-ref refs/heads/ HEAD &&
			git pack-refs --all &&
			git for-each-ref refs/heads/z
		)
	'

I'll investigate.

Patrick
