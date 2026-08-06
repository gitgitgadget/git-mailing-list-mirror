Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD33DA7F1
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997739; cv=none; b=EXSaSB9zGScO3UQvaCQnm12sc+rH4RY2m2C+epJgUQwXorXPoV+6BsI6b36B06cGmeDN57ZJ2efYKT7GtEtOAn6Nux5W2hZkJkSZR1lrqyjenYVmYtlEbWauXEKTUslKo05+3VeZq7gnXpz/jY9qAmqQFUP2KpBGeGzDhijLNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997739; c=relaxed/simple;
	bh=WmMjzSqNJOMQjnZ8UO0eEcnq6yWkyfGBwkK+XkeG7lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9mXWLBMdVdDvKR/LagQCw/Ad76G+MDh9XFOi1PXbeNeFxd66wZf4EGTPrd/Uz8HTlukjr/ElzT4hoX7sJktFpSVMRhZW4VuW40JPNtxogMfiQIT6tTYkDeLpEzYfbAJ9Iw0giCvRsHCc6mdFI2mqbqx5bAtnAZVnVxeu+/J6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9NwcfMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVayBoEg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9NwcfMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVayBoEg"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 971B07A016C;
	Thu,  6 Aug 2026 02:28:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Aug 2026 02:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785997737; x=1786084137; bh=aiZw7Fsafm
	2vKxXLmiyl9wIXubtICqyzydjc1V/OnII=; b=R9NwcfMm4eZIG1ddV5W0HF5mDX
	cHJW+IsI61yvWRsSFOGokVF3iWz3rl2qDELktftih/5d7Xr/1r81D2Xo1Nn6XGRw
	Fr05x7JM1Y8cYhELDjCAbjwvwgg3K5PoCwhjM3yXAtYwGZZ4L9UF8kEz8q8E5nM9
	FQ0SiACZymAvQbvUYKrq1wLMr6cnO+xdXo1kg3HTyj78vKcsoguizg9PNmQbdKfn
	tL+zrBtFmV+TLNLtHDrBN6eD5ta2hcPUxzI84A7bLMECEcko7b8Y+BqaRD2MqYSn
	ofi5IlpgTWqH/OXaBox6FWWjyA3JRsSeSrdmQ+eGq/OTd5t7+JbDjX3ZAdMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785997737; x=1786084137; bh=aiZw7Fsafm2vKxXLmiyl9wIXubtICqyzydj
	c1V/OnII=; b=DVayBoEgSdTmJWxOBp7rQKMxR8e9WLxcT2puIecAOaPqsigb1oK
	FklSJhkw8703tq1TS1vDVFaLKfvCmazHZoWi3Z/WU839LEiGdcZzWjddnls9rPxi
	Qx2rIsEtNN+0HeJSnRxwKvAed4Dago0t9NtzdbAax/6hl/gODAyq46L+miZPzPEb
	KU2JIjq7jvSEACdmyXVgGL+BlKTWLniouRnZ8+LjqBTuTr+zT1AOPK8+heRo62PC
	1ID+/AH6v2s2tf5FBhYgpoWHprNwvju51z9Mtr3WxOWV8N1J3JfN28lIqC7oYYxs
	lRTJ/aSTrTiUkdvyqZ9Cbl5sWMGm4w3kQaQ==
X-ME-Sender: <xms:qCl0apFyGVNQu-qpLieY_PZIM0ImxDi_3APsP7SiLIALMmFiR_R38w>
    <xme:qCl0ajTD_Kch7-q2j-0BsNB7Yr7M-h6poHJiUoQdXHhan2BuHujr3X-SH04QbltRl
    2BSMdeKmGGppLSmqho_V6jsE7wBI57TSnshJ5fC-QgLchxE1Y350g8>
X-ME-Received: <xmr:qCl0avYEcCvj1LszQNGN62LJMp4j2l5jNC8UyEMRctv_ABrJgFl6K1get06ng3iJ_T4FvGoUNnHzvlh6Gjm_7saV3fZUN0b8pgUPjAKomd4>
X-ME-Proxy-Cause: dmFkZTFpJrE/RFQbAlmrxkmtDdeHz48/yMExxkrlwuvRwskUqrod6Tr1ijhDpWUAtL5u0Y
    aWOuzcNWXKAdnhHb6NqmOx7MVEQoso7UEhhYlwa6kJD5Wa5+Df8ByGrAzWZP0RaNhBshMe
    obA4O3xXf+qc6mGNIBTmouYPoFiOjamL4Iol2wM9sUrztazi6LW+YvPHS8icoSd1bxOryH
    D9CIR3q4Zr5Az/BJgwijpXmYfunnqrr+LIqBWzF/XaJLvqRVAmQG2e8akv7ne6Ty+vBMq5
    2wrBkwLmODNWs57GIOunKFDGFWGvuy9qa7HkgWM1hoZVDcvXcnid4XcLqqzlJkkoKZPTGH
    Hhg8hFXDBjmkIKL6vMf9NXFcsMq7+ndWViE6mHiG9FIVMd3joq1WodA7K7pbUB7R2i5j4e
    WjNZKXaFOYiPeoSP5AkO6F//Y38af7cNcddoUil3lNO4/xFveZKk6FQ0+ZbcWeXWhx4TLz
    KrBepccmTG7jVzKtjAloDaqEKNDFsthqqX0oYaI2l5+bGWAcBmnd3bxmjOjFfxVjNZT8DV
    HIe16yRUbiEJ4/s7RT6mjV7RyJlTkcBxixT7pWEaj3E9b45QjUvpxOXY7Epy8pMNQ+8x/9
    g+/QTF2E90IkWZgq3za0AB8Gr1WKDSFMH4Cfbp32F5cQ9o4hJyN87Qe1oKfg
X-ME-Proxy: <xmx:qCl0au3WkBs62_DaedPGgJ2fjoLBjZ90TGFckd5Gxc504XeC4xM9Kg>
    <xmx:qCl0aiptR0_LyKCw0k9Q2T0hSRNDtULtV1TsxbnmCfow3Kr9xUW-5w>
    <xmx:qCl0atMdAXTYfzt0WWysX7iQgylZ_xceTuZAy2cvA5pZaC3uBIhtrg>
    <xmx:qCl0arp9b1GHzla1YymslNvOhKDWCQC661lGzE_X5hKU3BjkO6A5gw>
    <xmx:qSl0aplY0pKHqnmScQvMihO544ADNEUl7OcoNhR7Wg0_b1uV56IF1OO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:28:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d792802c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 06:28:53 +0000 (UTC)
Date: Thu, 6 Aug 2026 08:28:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
Message-ID: <anQpop92SCAA2C9z@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
 <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
 <xmqqo6fso2s8.fsf@gitster.g>
 <anL0nIk6uzkYR9Oc@pks.im>
 <xmqqy0ekr0bm.fsf@gitster.g>
 <2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org>
 <xmqqpkzwpg1g.fsf@gitster.g>
 <8ff3c3ea-2604-4d65-8a7d-6acd6218b7c2@kdbg.org>
 <xmqqa4r0payv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4r0payv.fsf@gitster.g>

On Wed, Aug 05, 2026 at 01:29:44PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 05.08.26 um 20:40 schrieb Junio C Hamano:
> >> I think it is OK to explicitly document that any writev(2) emulation
> >> is allowed to be non-atomic, and it is also OK to declare that using
> >> writev(2) in this application to allow competing writes to the same
> >> destination is a bug.
> >
> > These are fine.
> >
> > But I'm not worried about current uses of writev, I'm worried about
> > future uses: "Look, we already use writev elsewhere. Let's use it here,
> > too, where we can take adavantage of the atomicity of the write." It's
> > too easy to miss a note about non-atomic emulations when the function
> > name advertises more than can be guaranteed. For this reason, I strongly
> > suggest to use a different name.
> 
> That is why I added the "it is also OK to declare" in the above.

We could of course trivially restore the non-interleaving property by
only ever writing the first iovec. POSIX doesn't guarantee that the full
iovec is being written, and write(3p) is already non-interleaving. It
wouldn't even be less efficient compared to the current implementation,
as we have to loop around write(3p) anyway in our compatibility wrapper.

Patrick
