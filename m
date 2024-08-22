Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C414C5A9
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314771; cv=none; b=PbvoMoElkQiKMXWMO3SaE9zSXDKddtQgD+kdEwXjgzS2KnYl0WxE5r6hLMhe5WuKYpsGRqjJ3P/1wpyMWgbVLt9xZoSWytTnqk5DkLLEUQEZ+AZLcMf6zbfJwo7WpLZ0cXl5ufLWENPA5jr2F/ycY9trsfRN36OgS7jCCvzPhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314771; c=relaxed/simple;
	bh=/RE+faa0mLHyqSvL6wYnHdsciJj9xtu1+stQfzxsRtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JILvmhENpXE+jT/X9/NSKg87x0ngBJVB01L+SQ5dK2HvB/utSUux/LKGFPD03UwZ/qC6pfdUw036Hj/vsLZEzTS7fS4lNzv50R+sTcNr3taEXmwszAi5e0dFrjfXr671iWIb+bQ5dMUGOa2/O5ogRsZduzpUnTSlQG4Bb28++Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IAm75TEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GRizvhoG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IAm75TEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GRizvhoG"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id CBD57138FFC3;
	Thu, 22 Aug 2024 04:19:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 04:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724314768; x=1724401168; bh=NTrI+w1Gs1
	mD3gn5h7adOeZLV+GXYBrousfvSxRk5NQ=; b=IAm75TEPicjjQxHLrtEVFvcbDX
	k4OGJrjtliTaaREXwguvzagXKDDTu1P2Jn2q1IX7i5lk5+TdSDGtK1BWF7WSgZnY
	o2mthzlovTftNAZPClgChD9uK69owj2GjoMBmQXkR8UOHKeuDQxR0imuh9O47jyQ
	goHiFL/HFD54xmKSGrqlozgilKPn8HNwYiTSNKWkV7b0Yyhwh9rqqx7pKHHG55zB
	qb9TLUzvjuaniIjAGzMhiJfWLY8NkfhowUNipWyA/aoEK3V3vI8WFY3sONbnxVHO
	FaJJwJVjziGFZvqe7kEEIh7lWrzwgDNdLobGUe+04AumYWR//qnSu8Xib2og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724314768; x=1724401168; bh=NTrI+w1Gs1mD3gn5h7adOeZLV+GX
	YBrousfvSxRk5NQ=; b=GRizvhoGhm2ahBmUBoSFA03MF6738CzFl8sJKM2eBNqO
	MhZgZAzgm7FYiUg3jFvtDDkJhzsRYh1FPMBX+Pz61MKhQq93lpuhEdXmKJzunHVM
	mLyGbIcNL88vesqmDy675D6KRVkHAQtkI+pKy/SQdC5L7SAGvxdCbrIG8jnknVmq
	xC0G7DD1lC+wNXp5Iuq2WrmpITgvJCcIs5iTPBZ3GpzlMvSAYeg74UpvgqcZTlKI
	BztsmzOUFqLuwymU2ygb8Px9XeUfR1k5+/ftQSc6CpJr0l1lBo+bsiW2IlhRFCQ6
	jaHoq8t5MD29q0j0VmoaK+gGMpJBi8qgilmv+1+ZAA==
X-ME-Sender: <xms:kPTGZpcQ_TIujCqnSG3J-_Y605ReXJU17Z63S6kIi4zF0FOtKEXx6w>
    <xme:kPTGZnPW0Zf2LBhRsIlQc-a5IcLVGS3kG5Lxz2WJ60Lzm7ETbBLi2CbFRIQ4QbKDR
    ZOmLnWw2S7ARbaqcg>
X-ME-Received: <xmr:kPTGZij5Z46h-a-O4gXMs_gGJRBKgw3pc_SGhII8y1i02o8iS15TNCp3fNKU-QAw96ywzWHTaOs_nHZ7kaRd9rMSLH7ZzSdHFIiy9EIIw2WRXbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:kPTGZi9y4rFeHc-_1Q5yX4sFT3krRfsoHMqDKYweRbF58w949dALZg>
    <xmx:kPTGZlucmHGkng8Hof8KMWdcXf0lT9z9SyFX_12jNdZEwTAsPwHJ3A>
    <xmx:kPTGZhHxPgn0pZC-Hw14DnshFi4G1BHujSmBYDK1HbFl86Q5tvzpNw>
    <xmx:kPTGZsN7q-hjto--JipyUzrxe-1kGZuSevmsu-kKCQUkPStSg5tVbg>
    <xmx:kPTGZu65ukhFtgnYcTvyIKhC_icEswSkNW16-lQFQUEoH4cZ-E8drvuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:19:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00115af5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:18:51 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:19:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/20] pretty: fix memory leaks when parsing pretty
 formats
Message-ID: <Zsb0hjQj91aGKExI@tanuki>
References: <cover.1724159575.git.ps@pks.im>
 <82f3908f9620cee29e36a51f6d18ddcc8392b966.1724159575.git.ps@pks.im>
 <xmqq7ccb6if8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ccb6if8.fsf@gitster.g>

On Tue, Aug 20, 2024 at 01:36:11PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When parsing pretty formats from the config we leak the name and user
> > format whenever these are set multiple times. This is because we do not
> > free any already-set value in case there is one.
> >
> > Plugging this leak for the name is trivial. For the user format we need
> > to be a bit more careful, because we may end up assigning a pointer into
> > the allocated region when the string is prefixed with either "format" or
> > "tformat:". In order to make it safe to unconditionally free the user
> > format we thus strdup the stripped string into the field instead of a
> > pointer into the string.
> 
> Yup, the stripped one is trickier, but the change looks correct.
> 
> Will queue.
> 
> By the way, we tend to prefer no spaces after (cast) in our
> codebase, but I just noticed that it is not spelled out in the
> coding guidelines.  Comparing
> 
>     $ git grep -E -e '\((int|char \*)\) ' \*.c ':!compat/' ':!contrib/'
>     $ git grep -E -e '\((int|char \*)\)[^ ]' \*.c ':!compat/' ':!contrib/'
> 
> tells me that the extra space after the (cast) is found mostly in
> borrowed or imported sources and majority of culprits are found in
> reftable library X-<.

Not entirely surprising. I myself have typically favored adding a space
after the cast, and I remember wondering about the coding style several
times here. I never wondered enough to actually check though.

So thanks for clarifying and thanks for updating the coding guidelines
around this.

Patrick
