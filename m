Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90620297E
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128576; cv=none; b=qtjqEpXFL6MuV712m6tb5yS6/jIHoT3Zg2Si4ghOMB72x1W9gV08MCSNyyO7QjtUZ3eZqwqXkvHmGRLPKkNB/f16DU/C+4hogKIFFtqp06t+Qg6hAK9cbe3xIevqsPhwWdtPKCsQaoOuj99h3FNciUwdxfXcKRsHRajfBGyAupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128576; c=relaxed/simple;
	bh=SWQNFy51Cv9mF1wdJ/R/6g0uU7cDBO6OuqnoB4//Gcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPEzTbJPXcZQNDjFgg646tXmFCok5Omewj9aX0zIIW//89+TXeN9cJJfKZ9Z1L2hjFuvKljkvAgeIKQjOuMn32lky5P0FA1f9LkknxaJheKjafEOr6wwrgEG8FQbzvGDRjC87Fmquu7fFbaNrgqts0GoBbl5k711/1xLonCik7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n80dqQd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPD3HAlK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n80dqQd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPD3HAlK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 851AA25400DD;
	Thu,  5 Jun 2025 09:02:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 05 Jun 2025 09:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749128573; x=1749214973; bh=YSC7kzS/mK
	O2xkmrnBidvVhkueffqnqvqj9xbLd2eec=; b=n80dqQd0xTftMDyVoPaPIU568A
	l0d5XkVq3k8CdgNBT4RrYqDN7ENrNmXGAWuoS42Mkv5t/sS+E8S/btbo7LwrxJO1
	t1Q3MfiOiRe+cuummcIQIfPvyiFPc8HxF/1PWyCinpdR6D6oepPEM8MwuD4ppwsZ
	BT8JjVqJeojTjUaUC87bWO4cd7mEnFFTnU5/4roEUolLwb0AEMMXenTc9AHKYoHO
	klSZDi+Wn8GvL8nEcNKLg5sSLpaD7kSB8ihiSXMwwmieGWEgT2GRA7UGHbR9BCID
	AQUgop+yKz1BHVHROoMz1nGDcM0GQSPYKQAklyikd7NL3Z0MlU+e2jxJ2rCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749128573; x=1749214973; bh=YSC7kzS/mKO2xkmrnBidvVhkueffqnqvqj9
	xbLd2eec=; b=IPD3HAlKquHGGCY6ae45l2kglQIlRpizcT0PYReY7lZefC009q/
	NCMKWEbkG0lbZ2mCOIAT+NAmDHQ4xyzeFrtBDm9LqFgqLr3TcKHqUH3K+FVcEJaC
	F6dDqOFbsYrtUt+YdhLPSgPGHXZxfOJ+Bg2I5DbxGJItKNw6v/0FLzvjh3kLtHbX
	ra4wH58hVFO5LxZLnWR2phXHUj/fYkK3Ycvm3nMlVB5q/edW01+JWHG7I1nG/zUw
	eVrhhv1UjpeHhhWk5miD3OcvFeNnmeMiEXFC7SKVIfoufMa5asLXxWia1C2aTXZr
	8Q1Nyahwus75/7tYAyUu3VHs2DD5Pf3uF2g==
X-ME-Sender: <xms:fJVBaO-laXD6ynLKihQsEANqWJlbZ4bTdOZo_nLk5vo7n_6WQoiXTg>
    <xme:fJVBaOt8WkoaIpWL9dPFa59YmovQFUPdjLZgX1OEyPJFdKsFOURcZZRGJ_b_bH8wB
    4ALuVrjUDHbRhmrnA>
X-ME-Received: <xmr:fJVBaECqxt61eI3_uPFU0fSP4DnHjTKJcDGUJKTPHX6Lz9mrb7ha2TYr-WsQjMCGUk8AgqOotxEJCEOVYPsWFA6ezZqFw-_8cM-qwRfk5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhs
    rgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopeihrhhoth
    hhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehnrghsrghm
    uhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fJVBaGdpbw_fquCcTk4CA0gwBL9_whHkGwY-9T6jA8hc-74cGWXSKw>
    <xmx:fJVBaDMvWmRoHdydn0_VuCcvK_Ruroe-wd7gZY2joajoIvS3tEDlsA>
    <xmx:fJVBaAmHuP71aq7l-_PfeMyvSVnBQJ6jaWgaYX2U-3aTo9I_OXjjyg>
    <xmx:fJVBaFsmzfpMopQGZJ6avyyf4cmndFx2SyQAnvYJgpI2hG1iOrfzmA>
    <xmx:fZVBaIvsEiBNdoTYpRYa07zonEC1dvX0CH2AdiW99rvsAsPHlZzkmlcN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 09:02:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb717832 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 13:02:49 +0000 (UTC)
Date: Thu, 5 Jun 2025 15:02:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error
 message
Message-ID: <aEGVbz7fWmm3yf1L@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
 <xmqqmsaoq244.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsaoq244.fsf@gitster.g>

On Tue, Jun 03, 2025 at 08:24:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Sometimes code wants to die in a situation where it already has written
> > an error message. To use the same error code as `die()` we have to open
> > code the code with a call to `exit(128)` in such cases, which is easy to
> > get wrong and leaves magical numbers all over our codebase.
> > ...
> >  	if (!patch_format) {
> >  		fprintf_ln(stderr, _("Patch format detection failed."));
> > -		exit(128);
> > +		die(NULL);
> 
> It is somewhat surprising that the compiler would not complain with
> "Hey, a NULL string as printf format string???" given its decl.
> 
> NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
> 
> As long as we are sure that compilers we care about are OK with
> this, it is a very nice ergonomics enhancement.

Hard to say. The documentation of -Wformat doesn't explicitly mention
what is expected to happen in that case. I tried compiling with
-Wformat=2, and that didn't generate any warnings for those calls to
`die(NULL)`. It did generate a bunch of unrelated warnings though.

I haven't seen any issues in our CI, either.

So I'm inclined to just go with this variant for now. If we ever see
that it does cause problems with some compiler it's trivial to just
`s/die(NULL)/die_silent()` or something similar.

Patrick
