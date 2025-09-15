Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470582C0F67
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922281; cv=none; b=O6G/tETuNhBVlG7gAeGQseDCgBo6gkSqrDvBfHnax2NgmdCK2OFSSJRixJ7bJUd+ndYctq5/C1el5eVHNO0lK7iJ0z4xCCqymQ2aBUHXttYGa9F3abJdn7RSxdYh7F+SnxZwhY9j1S7NK75F0mSIAPg7b7nP1+1YHp++Evynp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922281; c=relaxed/simple;
	bh=2cD4A7grQ9TkmAghOQYuIZL5yCP8KfSilF1+GmXugpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtcHpeqeox87Kieroe9fi0JtfbjHr7ztKD2TVXL075UzGXno8LEPOML8KEqQMqt439X5li1nQSz4bNzC4UaPR7xh6D+KOCN1nEVEQBoSY0E4JIQB37SJSudZ9dG85zw4M8YsG89lyASLKpzNeXNvvoioMsWAUgLgkdKI0P5VrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jS2D1nUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=juM/G0j5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jS2D1nUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="juM/G0j5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 831A8EC0239;
	Mon, 15 Sep 2025 03:44:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 03:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757922278; x=1758008678; bh=6rvEoZq/6z
	QJERVQFgrGhmrjfFhhou5EyXmwZT+ljCQ=; b=jS2D1nUQn5M83NoWUJJPThhsNQ
	SL2vB8HuUNvjpil1t5UNK9Njp2+Z3EBcai+HQu0sS48F1re3VLf3APTnf71iZOsC
	kDhun9kE9wOEs2SFyybbiwg22YRI0JsRxzNJcEFTpI2yw66jMD9x5dTED+OdQGAp
	z1jCLtNHohGdax4TsjnixlYVeIEBN2kUx49zpkGfHoVJsbm9Jl2amBcvJuYmuzVy
	iUWlwH3Wrk5HVAxu4/gtDpI8gDhQxCUgUMpm/O7dEujBbLbd6YDCeR38g/Dacm62
	dk65bsE0YUrrgWLmR0WVMLEaGkOTw2BDI2dpCdpHR4tiih+gmDIqweDliPOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757922278; x=1758008678; bh=6rvEoZq/6zQJERVQFgrGhmrjfFhhou5EyXm
	wZT+ljCQ=; b=juM/G0j5C1niqbOr8xtFFDo8VT1HbItymZBn/WomHGyrdqa8j7V
	qgpGXwTeoocqbo5k2V0YCeC/y0nQXvZXLvJWyCYnX01m61Rh2eGq1XXOCb+ENMUw
	VGT2XzAEPVb72BWXSTc/Fzzsh8grjbU/Nqb2XZv9EfFrxYl8eZ9q11IHC2mjFfgd
	yr8LBqThI1+KhrkMuu0BxcoWcoBQWTGUjfq2U0ZQfKclsrLtJI90Y4NyGO4x3J+2
	plWVT2MKSmvkThR52Eg3WUPSUWJpjvumUv7nWCgNBMu/GwSHKXWiSCDRVk5R3XnO
	nEb4sp1byxMMPrTJbwDFUTNAc3yTDJ0CRfg==
X-ME-Sender: <xms:5sPHaAxkDBvgbvF4Oz1t-LK67uN1Hnw0AgqH7zBKa3tH7RtdpgPjGg>
    <xme:5sPHaO1uI7eAPExxOCSpbtbe-wsKANkSrmJ_Cb0qrpqW3VplmdQs3l0b6_uGlP81j
    VpWFMWTnjgLFYs5pA>
X-ME-Received: <xmr:5sPHaO42W3FCeepDhdc6mncdD7OrRSSrxvi8W2Fw-Iw-ed4aMVIUXiCmskDsxFyLlKG6G-aQWQgG1D4kNBpzwZ2QIvlJrKC2SYqqJnD88_1Nkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:5sPHaBVt2esnQd0o0vSA6_bYpSN09Bq4rxl_PvJTjW4KEaqb6gIQZA>
    <xmx:5sPHaNCdhtdo8zpTnkxXUqKZr7YSlcBrqoCCCc594Kwmp9GKpN1GTA>
    <xmx:5sPHaA4lxRlxWeHDsCdVYLYnqQBLZZtD8qS9rus9CBv5lmNsxbJ7XQ>
    <xmx:5sPHaIxBUID49YyjQQH75d0X8KrFx0751eMMU5XLGEnzLvqOB6zM8g>
    <xmx:5sPHaPo1qb0PYbX1o5rk5iRiPwGgwgN3FmCxTu795Tmi33JMWQh1j7Dz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 03:44:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10ccfc54 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 07:44:36 +0000 (UTC)
Date: Mon, 15 Sep 2025 09:44:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aMfD4JuwJPHmh5WI@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
 <aKz0/WNu/GRYh3/W@nand.local>
 <aLav4UAcfQjvNzMF@pks.im>
 <aMNYaPSnf6JP7bNj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNYaPSnf6JP7bNj@nand.local>

On Thu, Sep 11, 2025 at 07:16:56PM -0400, Taylor Blau wrote:
> On Tue, Sep 02, 2025 at 10:50:41AM +0200, Patrick Steinhardt wrote:
> > > > diff --git a/packfile.c b/packfile.c
> > > > index 8fbf1cfc2d..6478e4cc30 100644
> > > > --- a/packfile.c
> > > > +++ b/packfile.c
> > > > @@ -2344,5 +2339,23 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
> > > >
> > > >  void packfile_store_free(struct packfile_store *store)
> > > >  {
> > > > +	packfile_store_close(store);
> > >
> > > Seeing a call to packfile_store_close() here was a little surprising to
> > > me. The code that you are moving has a comment that says:
> > >
> > >    * `close_object_store()` only closes the packfiles, but doesn't free
> > >    * them. We thus have to do this manually.
> > >
> > > , so I would have expected to preserve that behavior.
> >
> > This behaviour is preserved though. Calling `packfile_store_close()`
> > does not free the packfiles, it only closes them. And we continue to
> > call `packfile_store_close()` in `close_object_store()`, so nothing
> > changes.
> >
> > The only change in behaviour is that we now also know to close packfiles
> > when freeing the packfile store.
> 
> Why is that change necessary? I am not trying to be overly pedantic
> here, but as you note above this code is extremely fragile, so I am
> trying to avoid any changes that are not strictly necessary.

Hm, okay. I'll drop that part then. We can revisit this at a later point
in time once we move the logic to close the object database into the
respective sources.

Patrick
