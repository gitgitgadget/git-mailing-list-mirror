Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9602E62C
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429079; cv=none; b=e9cPi8qhoch4DkNpQ1ZdRuq2vL4uG+DCKjSn6rGRi0Xgm9IHVzfNSDUcxS7KtQhiO3TZWBekoT4b96dCXACABAVN4hJuqxRpWq2xeX4wg5NGbfGTmVNEy32jYMcV2+PpaXBWRUnw+Hj/HDMv+9BPBS6MYbdn9cChddss/D5NCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429079; c=relaxed/simple;
	bh=lvXBwQABecm4sM5QHTbJeH0gTZgrMPM3GAiwt4lURko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9crRKgaK6JOiMx8idSZuZ/WMX5gfS/9nsG0q8RayctgMebIHT2rgtzYd3RyvcjgrubvKBR2SqocpS5XQyc52CHYx2GdCM6Fqn9YPJ6RQneFz3Tw5DBcEmJjoJEH4Jp4ANqG9Au1+TkUPXxGOt+xFWtZtqPC90h//qdmuMMw27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xj+gu/Ro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BzLwv567; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xj+gu/Ro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzLwv567"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B7F6F1140175;
	Mon,  5 May 2025 03:11:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 05 May 2025 03:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746429076; x=1746515476; bh=NsqHB4RkOb
	hRg0GMNS1Bg/D3eoLWsJsIChf/9T69GGs=; b=Xj+gu/Ro268OImck72NLFGtMaZ
	kAV4VlYjFCzoAr/I3cBCHnAWk/7M81BEyY+og7z3yWwypPJcV70PFxQ7kREkBLn7
	wi+LKr3uPl6M6MQBaXz0Topp5Rgz5LsUBmkfY+LlqNq0iFJOrSaPvpBoqy8wxgYY
	7X9037Q7K9seecNdoPiB8mQ6Iq/QKcvXCktQSCRlq2r6Y3Flxwlmczxv2fZTxICj
	yA7bw37LA2Um7sqmdHoCkdIHokii/zr5PCkkW5dAt/KgyG71rMMZfZ61xAalG3mb
	kwOahdybsa/SuB0AN5fGXcKFEdM/3A6WcXk2nxymDkdI9nJB4hAWtyglxt5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746429076; x=1746515476; bh=NsqHB4RkObhRg0GMNS1Bg/D3eoLWsJsIChf
	/9T69GGs=; b=BzLwv567VPL6hea4KOQeDxabqOx4A1ak6HF/elcGT1/IAkH+xC6
	kU41I5WhzA5fPMigaYdktKq0SSUTddHsxyW5k1njDjMh8ukby4tWkjM9pw2En48B
	ylkQu6pMmoaM4Yy4rxZjIS7nFv3ss7BtJwYN+fS5CTE/nw89UMEZR8wu7tOBYFf1
	9xLyHBkoxZ66evyv/R/lzcqzj4YTCRXzunrLuxgvrTOagOQNk8kX0wD6OTF87bNP
	wMVOYt6n+VY2+C5y+1gr7elyejSRPJrXgQ6eLY3tlKkdEdKScGdpYCIx1twBDvPf
	oztVc5VqfbcS2rS4jm6ULYHa9Om+1L0XNjA==
X-ME-Sender: <xms:lGQYaFawoxj2Fgs-Vm8ckeu-46Db2z9i3CiTGUZ1wc283zbHi5nnnQ>
    <xme:lGQYaMZ0XfmtAXIYWciRw6SMSJo1u1JJ4gDgzm3r8vXI7lUTCXicJg915ORDUhevV
    9nCAHmyAxSD3P3nCw>
X-ME-Received: <xmr:lGQYaH_0nHXSDw_Lo4bsMSrRNDQOv1YeZWUTkSu-Ic2aXvWJ1c1u5HrMiogD98adctTnkpJUVvy6p3NOdgpQIdsMfq4gqZymhpShK3fDodTbDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lGQYaDqgdeN_N9Vj__bDCqR4q8DA6cHxdKifESq1HiB9ALYgQy-Iig>
    <xmx:lGQYaAoZxcSWEaDKY3OfxVtS-sKKhyV7s26PRXY3VloN_1hdUrHuRw>
    <xmx:lGQYaJRBiR5zJG0tOzmoZKoJVwWJp1mCLByb_l25mBK95vnXR56tmA>
    <xmx:lGQYaIp1aZCXrqrPGaivk4Ou41ObPC6UbCw_WDMZ9rGgN0KDQj0UPg>
    <xmx:lGQYaJ_FvHDEdwWY-jA5fjYcbB47N5HHznhdubd6F7Sei-ZfMJu_OJb->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 03:11:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8e4df50 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 07:11:13 +0000 (UTC)
Date: Mon, 5 May 2025 09:11:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] pack-bitmap: enable lookup tables by default, misc.
 cleanups
Message-ID: <aBhkjGtlA2N7yTVw@pks.im>
References: <cover.1744924321.git.me@ttaylorr.com>
 <xmqqfrhmu2s4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrhmu2s4.fsf@gitster.g>

On Fri, May 02, 2025 at 02:21:47PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > This is a short series I extracted from a larger topic on reusing
> > "external"[^1] deltas during verbatim pack reuse.
> >
> > As part of performance-testing that series, I realized that bitmap
> > lookup tables are not written by default. Since it has been a
> > significant period of time since their introduction, the first patch of
> > this series makes writing the lookup table extension the default
> > behavior. This is:
> >
> >   * pack-bitmap: write lookup table extension by default
> >
> > The next three patches clean up some t/perf scripts that were redundant
> > now that lookup tables are the default behavior. Those are:
> >
> >   * p5312: removed duplicate performance test script
> >   * t/perf: avoid testing bitmaps without lookup table
> >   * t/perf/lib-bitmap.sh: avoid test_perf during setup
> >
> > Thanks in advance for your review :-).
> >
> > [^1]: The term I'm using to describe delta/base pairs which either (a)
> > are represented from different packs in a MIDX bitmap, or (b) the client
> > is known to already have the base.
> >
> > Taylor Blau (4):
> >   pack-bitmap: write lookup table extension by default
> >   p5312: removed duplicate performance test script
> >   t/perf: avoid testing bitmaps without lookup table
> >   t/perf/lib-bitmap.sh: avoid test_perf during setup
> 
> Peff and I were the only two people who read these patches?
> Is this topic still viable, or has it been backburnered?

I read through the patch series, but didn't have anything to add over
what has already been discussed. Overall I think that it makes sense to
enable lookup tables -- we've had them enabled since February 2023 for
all users of GitLab.

Patrick
