Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A47187FE1
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420573; cv=none; b=An5tLOB9E8WhMW154JorGSi3EVJ/oELzY1/w0cbUmQiy0H90/bPaoV9b8Ef+d4yXLt4CJN9p/ueunH1SmfSTS7yP5m4vyye9wiepLm0U4BPbZ0yee5YbV552GTQvAFh9kLejcIDi6ikBYEZXR48EMOMemF9TQGtKVauygkdqBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420573; c=relaxed/simple;
	bh=HsvCSVrPiJSV4PPyR2g66PJCV4j03FtOxHaNsYkqsYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP9eD8jtakD+77PgtDIoOBQWmyk2XyFC3KW76kFPUF0k+JWNgfd4gGchr5ulIHb/eca7rX6av9/4QF9GAX8wodE6RH6cRNhkhe5MGpriE+DA0BGzFM3AzSDUElAdP8TqAp7VCUG7SbRLeu5nKor7cUOv65vZUi6i7PMe9CnnO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xy5DfRQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQ3qWTar; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xy5DfRQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQ3qWTar"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4B6AF114F8E8;
	Fri, 23 Aug 2024 09:42:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 23 Aug 2024 09:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724420570; x=1724506970; bh=GWztUamOxl
	3QWhZiNNLN7hUfTHtuQPJgmRLzuBn9czA=; b=Xy5DfRQ+1jx1cVAKe7QoWA1Ia9
	xkHnyXlUc3CRAQKra74nSOEbkAdo/rabId8rR6zJWSx66cM+uVhLhuaoJ0u3mp8p
	qGqNdLrcZ3JpG8e+0BLNR0OsYHN96+B1lWVD0BXcAsSoNnLB95jmX82cN1BBBhA/
	2jV7gWbjzj9742p4t4oiz+j8GtiqX1yaupNg6ks5z6lFv8oQVyHZBZjoLD5QSnyN
	B5Sd197TDcxgVDuVzelrC4toIuRZgMAir8h83VWlZ3nmom1SpkRPXviFxVCFPZTr
	w08Uo4MCsW80Cl4F8Igf9eUvShIPdsAcseT2ZkzxGRP4eHlNaKcQBhOEOWgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724420570; x=1724506970; bh=GWztUamOxl3QWhZiNNLN7hUfTHtu
	QPJgmRLzuBn9czA=; b=gQ3qWTarhg8Q5H46CPotUlSqgC8kpZ4XX+J/ObpUJY4H
	JKUItcMsEg01iD9Q785YVEOPCwL6v8pAYoyrWmTKzmvdgsjvX883l1iNP81K8y2K
	xmo/ou8L8zQZEl1+y2jnut63xoz72JZB7wQllCYZpEWistm8TzcL+97M2+wgxlfP
	xICq9UW7zq47s+NgaVxZtG+tWdPnL5Ebor676yPjFVr26CWOcO8NY2B0FWiJjZQM
	/45CV3xkw3bsIiPBnVcbn36aYrfoDVLY1GMwh0bUavn7zD6TZFL30PYVN0aqDQWl
	w60hlfVTM2c0Wmw+f9jMkum/ag1U+KmgU8/VzQmIGQ==
X-ME-Sender: <xms:2pHIZiB4gsPOfq0fNzrCmu9MAifNV7dJTW0B2Y7QYZKoV-KDqijmaQ>
    <xme:2pHIZsgB8Du-Vh7F4qXCajd9cXpplAAxGvB9bILjjtq9aio4S0DkZ_uA2vdTdqbNX
    8fzO_LH742TbHjbxQ>
X-ME-Received: <xmr:2pHIZlnKijLYGJo5WgYRzySRbgMCoQsfSu4ynz4Jg0JjW3Zmlv4gKt7EeCGwXf1i_41K_BMbf-6rcc-QDgp97c-Jc2vC3R6mYDYLMjDegYYh1p3mGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2pHIZgyK0zOeotM33hjzZtSgXSeS_bje2G-QPBRmAqFSpG_xWCK_9Q>
    <xmx:2pHIZnRTbAYqb0ZjAyVFhoj8uv27SLnP8kSORa-pW1FhJA4NjCzM0A>
    <xmx:2pHIZrZc8BZc8nvn4p8OsFMZJEdvzkNqFz3vvIaVGJ752fXbleFyIg>
    <xmx:2pHIZgSPCHbFWIohDG5VVOUo4mrZ75eFH-6uBpezVHocuTPo69oXDg>
    <xmx:2pHIZhdjh5SV7LTzUDelu3-dGYzFKbwR2qX97pc-QOFGrR9zUub3a_BK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 09:42:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 72e5df9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 13:42:10 +0000 (UTC)
Date: Fri, 23 Aug 2024 15:42:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] reftable/reader: keep readers alive during
 iteration
Message-ID: <ZsiRzzRqI-VDu0-S@tanuki>
References: <cover.1724080006.git.ps@pks.im>
 <026820562882afb31d7224c90722e09bef835340.1724080006.git.ps@pks.im>
 <CAOLa=ZQarx37De=xmD73D3dPzxp0j8pfb-TBc4u6nKkJn_TT1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQarx37De=xmD73D3dPzxp0j8pfb-TBc4u6nKkJn_TT1g@mail.gmail.com>

On Fri, Aug 23, 2024 at 03:21:27AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> > index bc3bf77274..91e716dc0a 100644
> > --- a/reftable/stack_test.c
> > +++ b/reftable/stack_test.c
> > @@ -1076,6 +1076,54 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
> >  	clear_dir(dir);
> >  }
> >
> > +static void test_reftable_stack_read_across_reload(void)
> > +{
> > +	struct reftable_write_options opts = { 0 };
> > +	struct reftable_stack *st1 = NULL, *st2 = NULL;
> > +	struct reftable_ref_record rec = { 0 };
> > +	struct reftable_iterator it = { 0 };
> > +	char *dir = get_tmp_dir(__LINE__);
> > +	int err;
> > +
> > +	/* Create a first stack and set up an iterator for it. */
> > +	err = reftable_new_stack(&st1, dir, &opts);
> > +	EXPECT_ERR(err);
> > +	write_n_ref_tables(st1, 2);
> > +	EXPECT(st1->merged->readers_len == 2);
> > +	reftable_stack_init_ref_iterator(st1, &it);
> > +	err = reftable_iterator_seek_ref(&it, "");
> > +	EXPECT_ERR(err);
> > +
> > +	/* Set up a second stack for the same directory and compact it. */
> > +	err = reftable_new_stack(&st2, dir, &opts);
> > +	EXPECT_ERR(err);
> > +	EXPECT(st2->merged->readers_len == 2);
> > +	err = reftable_stack_compact_all(st2, NULL);
> 
> Shouldn't we verify that `EXPECT(st2->merged->readers_len == 1);` here?

Yes, we should.

> > +	EXPECT_ERR(err);
> > +
> > +	/*
> > +	 * Verify that we can continue to use the old iterator even after we
> > +	 * have reloaded its stack.
> > +	 */
> > +	err = reftable_stack_reload(st1);
> > +	EXPECT_ERR(err);
> > +	EXPECT(st2->merged->readers_len == 1);
> 
> Oh we do it here, I would've expected it above the `st1` reload. And
> probably expected `EXPECT(st1->merged->readers_len == 2);` here to
> confirm that we still have the readers.

And yes, this was a typo, it should've been `st1` indeed. Good eyes,
thanks!

Patrick
