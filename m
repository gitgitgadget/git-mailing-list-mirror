Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54662C11D0
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780433; cv=none; b=BXAIwnGNPmXnwnW0GVclWHoqagUuPT6jOdoqO3dqurN7Mb8bBE8mwiUk6Bk+JRPeZHtUtd0qEQnY2Afg+N+sx8rdw67JZu5ps6v4IOdQTM8qJV9jwmi812gVtijv/FiRXtidmF9zA5IOX0ZynzkXEU1AiQNJdF7hoMhxV03ITgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780433; c=relaxed/simple;
	bh=hIs2js69pL9eEbu3Nk966kIaDg38x+KoZQ81p5q1N0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC98s4NYQqjCZG0bNowgJGqIlql3SDbQxKyVzVlYx+HReWZAViqJf51cpYIdshGHNjY8jxRzNXzX3mP/Q8rceSIVfKxDi7BOnIDWiBhfdXIsFB8LNe3inVMLI/klvJxxy8JrnHBJvOZNTi/WWdmjoj/eAyNxHzngbTMjdUy6XUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nl/mLJUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlKM49UH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nl/mLJUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlKM49UH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1562FEC0554;
	Fri, 30 Jan 2026 08:40:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 08:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769780431;
	 x=1769866831; bh=7Rm7VDRaQua0g43mz/lgr4MUkCdM3Kfan6H7WqielQ0=; b=
	Nl/mLJUSttNbHla3eyZIKcu7koKu3cNtJOVU1melLzvjrUm3AW34v9GUXw8yIMI2
	7QNPDqzCX8/jBmYVvrwTzo5uvrh/Oyt//qZ/XTQjEITpor8nx1ryipVaG1rjyAwY
	GzsWWxj3/y6bC+N1tNFrS/duah9UdwGp8DhTo3JstCBujk4zx4K+ifE3KY2l5JaJ
	8UmjT3IGg1IO3aVcFYAlJ7mXI2AIum6hNo0F9ifcUCqUaMBbHc+AU8U/PKjxPhIl
	MKSGABqUcNj9PRqj5da/LA19G2YJ6a/3oWII3gzv5xw422rl4mvhkudcfBvvo/vZ
	cnWY1Pn8OWvYS9QSFvAv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769780431; x=
	1769866831; bh=7Rm7VDRaQua0g43mz/lgr4MUkCdM3Kfan6H7WqielQ0=; b=n
	lKM49UHTezD4UwkjnWXFE2lIoAKmRl7jIFc1JwwMxYwtbm/aOXUlagtGdq0c5T+N
	wzbWCtfL3ZkwFqiqq6DJJ7Rafz8/ozT8sha0arX2WN5leYtfZdpup+vjjQQIgV8j
	QKUMxWtRAIkMkmiiUiN4dS0+JhVN/cnC9/uKx60b8AzJjMGCdvuIXZVVrxFrwnJ3
	570benS8+tdGWramDqXfcKYzAikOedqgh5wNvyj2+XyKVJzINbQn885q424glFkR
	2Ills+LcOftk89QXS/8h/IiCBQ8Y+Xw2QCn2HzVKMcbr9ULTDZzTVx7RlhX9/k0O
	NtFEy7IlATBpAAnvVOZ8A==
X-ME-Sender: <xms:zrR8aYYa6XLPWRQhOsYslXvZTZ8cY67vKQl5MhQWWgBVzirw7cIZzw>
    <xme:zrR8aaZvy2WXf6ckZV2bijWHdrj7pmWXlwBNUEq7Pp5orYo29fF-dT1LgXFcyUT8K
    qCqV1RZAykFyE4Mx-kcF35heI8UObjnx-ubP6FzUk0zdpdUH9KJzA>
X-ME-Received: <xmr:zrR8aX-732xmZ-vGYQikBULREHghvw1FH_iW362pyKrHls4VMFJoVzUcQvFyR4kf1XHEzuDubo8HitKCsvzf54iGr4B1UWFTDQcT0PFW0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrg
    hltghmshhmnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zrR8aRj96jGijrrV96rD7lb8Hm1VVgeLxhq1f3Wzz4sQHdFMBCkCVw>
    <xmx:zrR8afeI0i-Xy4mFEt6IrhhVwXGipJXHEjlsQhHi5Rm2k59ycXcOrg>
    <xmx:zrR8aQqJ_EfmOSAsqHq0_kNIGson73VKxmFiagA93IKcT5q2TqHwmA>
    <xmx:zrR8acBoyBI-UFBEZSL21CnfZtpcJf__PgYAZELupQE8sZawmu5OMw>
    <xmx:z7R8aZowf-t8AbzkHGKHUZ1k02Fp73NPmPDe9mfnCU-eHIqU2rJJ48WB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 08:40:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2237c8d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 13:40:27 +0000 (UTC)
Date: Fri, 30 Jan 2026 14:40:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH] show-index: warn when falling back to SHA-1 outside a
 repository
Message-ID: <aXy0bife-Ubi9gnn@pks.im>
References: <aXvpSPpfvulKu57P@fruit.crustytoothpaste.net>
 <20260130090525.254665-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130090525.254665-1-shreyanshpaliwalcmsmn@gmail.com>

On Fri, Jan 30, 2026 at 02:34:53PM +0530, Shreyansh Paliwal wrote:
> > On 2026-01-29 at 15:36:55, Shreyansh Paliwal wrote:
> > >	/*
> > >	 * Fallback to SHA1 if we are running outside of a repository.
> > >	 *
> > > -	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
> > > -	 *       the index file passed in and use that instead.
> > > +	 * TODO: If a future implementation of index file version encodes the hash
> > > +	 *       algorithm in its header, enable show-index to infer it from the
> > > +	 *       header rather than relying on repository context or a default fallback.
> > >	 */
> > > -	if (!the_hash_algo)
> > > +	if (!the_hash_algo) {
> > > +		warning(_("assuming SHA-1; use --object-format to override"));
> > >		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> > 
> > If we're going to start producing a warning, can we also learn a
> > `--quiet` option to silence it?
> 
> Hi,
> 
> That is a good point.
> However, the warning is only shown for a particular usecase: when 
> 'git show-index' is run outside of a repository and --object-format
> is not specified. Given that narrow scope, I’m wondering whether
> adding a dedicated --quiet option for only this warning would be worthwhile.
> 
> Let me know what you think :)

I also wonder whether "--quiet" might be a bit _too_ generic in this
context. I would rather want to use this flag for something that you
actually have a good reason to silence, instead of only for a warning.

In theory, the user already has the ability to silence the warning: they
can simply pass "--object-format=sha256". If you think that's not enough
I'd buid on top of our `advice_if_enabled()` infra, so that the warning
can be globally disabled by setting a config option.

Thanks!

Patrick
