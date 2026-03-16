Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957E35CB75
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649349; cv=none; b=JZ7qUKn4K8nJqSMbwmMKrZoq2FUYXeLQOPBHyejH0GOBZm6/dQ4CjAdIE54RKKoZ2O+jaNvAwj3NT1BApNeO/6NlXyTJg15Asr3wTrKmgcm48UxhezmlNdBvBJBDtadH/BdJaFueN/uFT/UgyYouPB/3pzutvuR0oJKClsnOEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649349; c=relaxed/simple;
	bh=bDtTlVDjtAVkW37xXrYgmsLB+9GiBTWYTsLP3HE7Kww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ2NJvP18ysvGoa6jeEnruqTj+pPal0/9W4CZvB+/zkZIeFb4a4ytGSIuHkI9FrNAAtyIlvmirc4JdtwuaOnA0wC2SkyHRFwfQJWVht/wa12jGA295WGP6kS4I4luyvME0H5ZX4gJuyHmcG72brheywQJaPoi8ji/9bce98WS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ma+o5xDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOK6Hce9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ma+o5xDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOK6Hce9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6570814000CB;
	Mon, 16 Mar 2026 04:22:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 04:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773649341; x=1773735741; bh=REorrLK2b7
	ypR+Hnp5YtV05vMZ1vxUzuwy3PVn8OuyA=; b=Ma+o5xDBGy1UdGp1Dx+2cxpIU4
	CpgRDyO53L10YFpu92xB+7799+bVS2IRI6H3mm2uZqCWEUYvDj+Q4BqBjG98sIMs
	wtNrvh09ddtCvrIqg/NeMB68Wve2cFp3Vs9TMJO4y63oRjgRW4C66g4W51R1AXrv
	+akxOnvBGQkxWuFKf4bXTEbz3RoE4boIg0dCUp8ykd9WiWy2LebKEmpkW2WOleMV
	55v4wP+Htw3r+/UqgBs+5a50pZWTzfKLduRKjxfH/ekJPxBvwdEpZICVRkK/8kLz
	6mCHv862Ak9Hz7onYxZziDHkT/ERxmCKsuc16VS3Iio6Ahae2WP6IT5/4wlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773649341; x=1773735741; bh=REorrLK2b7ypR+Hnp5YtV05vMZ1vxUzuwy3
	PVn8OuyA=; b=OOK6Hce9i3/1lmm9eSJW+Al1NdUgCj/Nmk+gHR65P9Wq9TDV25A
	RhX9KMBMwOd2s1hDR25PjHRF6Plr9YRlFGzQWm5a3MlFX/2gjhw/BrmRIe3ciEfs
	t7rK379o6dXQY55K/SiI2GW+SJnxdLMc0dYUCI2oeQnIW0L9+RcgHzHxT+In/urr
	Qnw7jC3e3JKWsJNYskbJ8psQFruL/2KRrygrKa7zLmnrSTQer0GDKEqLDt4lZw6T
	W8qvakSg9eYHvaA/NzBvBVszsa00H1okC3VJuF74auThmfUUNZ/MkWqHOeSN5dv+
	3/kkqOWUAcyzG7igCw0TSWMDDAGK8pgx1rw==
X-ME-Sender: <xms:vb23aYQuCduC7nYUBM2iXlf7z5Ry3T63uTXeVxAax4Sp-YJfr-torA>
    <xme:vb23adNdNY50uliLS2CX1dAcqENygTGVEhU8OWiXX6Yumk6rWRZzTDYHaD3wJyoZ-
    RkxNq1DIVvrmVbh_0ENZBQbEXF7Ma7RTtyMgjWMC-b9LmSROsIBNHU>
X-ME-Received: <xmr:vb23aTONBiz15W0057QZ6N6rZE8ZEF-O8BgcYOKY5Bu0BlsG49EHxKSFWf-tWNkyx2dRDOE3DRimoJY1HIZPU43OtNj4PXELzvOoE9Fih7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdgsrhgruhhnsehvihhr
    thhuvghllhdqiihuhhgruhhsvgdruggv
X-ME-Proxy: <xmx:vb23aVt0dO9zz7aOcAOZ-GMIXxs7X1UhQA5PLUKyf4K1jst5RB4nWA>
    <xmx:vb23aVXIZC12q-BQA7HUbsUmjd5ZQgbbDR85P2XsqJcdcrxD8rpj6Q>
    <xmx:vb23aVsr004Q0vwM6N1Ho-MFDkWP4M4M1ZDDNiCwIwyMO1QHtN6qLA>
    <xmx:vb23aZVBlJgpBAezzjLaO51ovw83WYjMWiRIjBAKXaGs5vCRzQSqqw>
    <xmx:vb23aXZwnxmm065abG9OpzaDLydwYP87n-BHauMkwMGo6LotbzW7FvYT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 04:22:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d119226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 08:22:18 +0000 (UTC)
Date: Mon, 16 Mar 2026 09:22:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: describe with --git-dir and --dirty outside of the repo always
 says dirty
Message-ID: <abe9uDp16zOcdzZs@pks.im>
References: <99f2ba7e-cc5f-4ef5-9b09-85896563346f@virtuell-zuhause.de>
 <xmqq8qbv4gnq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qbv4gnq.fsf@gitster.g>

On Fri, Mar 13, 2026 at 01:29:29PM -0700, Junio C Hamano wrote:
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
> > When I do
> >
> > git describe --dirty
> >
> > in clean repo of git.git I get
> >
> > v2.53.0-522-g67006b9db8
> >
> > but when I do it from outside of the repo
> >
> > cd ..
> > git --git-dir=git/.git describe --dirty
> 
> "--git-dir" tells git "I am at the root of the working tree, but the
> git directory that you usually find at ".git" (or a parent directory
> of where we are) is not where you expect but somewhere else, so I am
> telling you where it is with this argument.
> 
> So if you are not at the root of the working tree for that working
> tree, "git --git-dir=git/.git diff" would report that you have a ton
> of changes to working tree files, and "describe" would report that
> your working tree is dirty.
> 
> In other words, working as intended.
> 
> You can tell where the working tree is (instead of telling the
> command that you are at the root of the working tree, when you are
> not), with the "--work-tree" option.
> 
> $ git --git-dir=git/.git --work-tree=git describe --dirty

You can do that, but what you're probably looking for is `-C`:

    $ git -C /path/to/git describe --dirty

As Junio pointed out, "--git-dir" has a different effect, and you
typically don't have to use it unless you're doing weird stuff.

Patrick
