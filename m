Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1C202998
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269280; cv=none; b=iE4HTIA1FfhHPcEjrf9SBbizaGrLZ288blIObcKuTy3acBX1QwKUz31liwELvq/rEqYlsAeTdY6kS0pFPNwiUbyQGMOeuaBasazXWt0DIXTWGFTjSsGdxKyIUbPF9L+MV27pEt3g95+pjSyDC8sXau28kmRgsKyCm5/grU0fkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269280; c=relaxed/simple;
	bh=kXbQmPQtQxGLHydteYCOEQfF76NsYJogiHQaIq4XbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtIwmYZZzsHrknOUaF6IMl9c2Wopxws8WiA2IfIaWWUJ2WUv95lDdcEatCl2KsKhlFHSb5ewKPxNcEoxZeV5toNJ6aY0EhNUFuGFrSvm8Jm/i2yQIQRelKoT9R4tVEb6TO6JKfUwDXNIXL5XXDWUmNrorXTOzcm8x7MY5pIjVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eF7+AG0p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BwYcJOzj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eF7+AG0p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BwYcJOzj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FE4A1380321;
	Mon, 26 May 2025 10:21:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 May 2025 10:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748269276; x=1748355676; bh=Em9AxiPvjC
	u6FWNBb4YF3DE3DNkxLaAZDjDGPePpLdA=; b=eF7+AG0p8NXT0vGvfidIcY3Rxr
	DdAxX8w9Q2pOYPyLOLtJtF/sF3hELrIeHB2RszgQ5vo8peqj0t/4FY8p4XYoPUKy
	LV7NkDXiESVOkHWeB66f5hRKpTQ2Zlqkp7z6gTuI4lJSUoXONhb8Hu08TlCDyeIU
	Jtetb9eBc2nNu8l41d3Gwxd8wg2Bz7RcLDPulxSEOpf1JALSL7mDYiPijPZ//wjR
	S+FeYCPCnG78idLmtjChURMUFuO+j4iJTeWxuc7U+L84qsfzIlabW8hyOZbVuekb
	0zYOe2gewWLe4sSiQGrZTaAUFprkkU30krVSIYzETAvEN838hcHjMS6B7fRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748269276; x=1748355676; bh=Em9AxiPvjCu6FWNBb4YF3DE3DNkxLaAZDjD
	GPePpLdA=; b=BwYcJOzjAF8a2ZC0ENvOT4p+wrqb59uDmzXZPZ2UwnnviMXXfDd
	fzMd7iDMdjzEvqKeM1YSDC5h7cht44guiqwI78VcPMLaRd0azNXvUNOkXPTwGR8x
	L5nLosIILaBaAfUjPS5begBvzamBi//0f+TwdIQf/jDCyW/TddbbvEIojKduHiHF
	QnaFQRpWE2BBwMXYsUzl8z8FQeW3kJ4GVNMnxjhbHsYZAALM/bazUf/3PLMAlvw+
	C01yauXzefAWHzlo1caK162IvvQWXXkaxVhflGspERSEhpPNJgMNQV6/csK6lt9k
	xQdWurJ2zgQ3GeSsjRRU4kXuXW8fswH5oqA==
X-ME-Sender: <xms:3Hg0aNsDiWS_AVakRegQQuBjnCGJqRKs5yDKD1tht0t4OrCdEFlacg>
    <xme:3Hg0aGeCp6fgpDNpc23AXMLza8HBv1yrWfcHhVlJe98sw75LM_BWnd8q24Vz9FVrh
    K7xgLS2Mzr8KKF4SQ>
X-ME-Received: <xmr:3Hg0aAxoz2H1BLbHgoWRmyNcyED2Y7G-y7fpULKfK-9CwiE8jKH-vLTdqBjYCHYTlRFgBNsYY6btNDM0edH7JzXCUPHI4NkBRgzqTlw4yBCrhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeejheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:3Hg0aEOBvZQWX4BoxBPH4WaRgUjlK-4ILK7BVmwX75FG25mIsxwxWw>
    <xmx:3Hg0aN__2RaA1Xm_z7wF7trIH2IcrS_2gLcrXAJXatZaZwQpLbOYdQ>
    <xmx:3Hg0aEXoLls-V8EopRqlca-PzYnSePoNm6Vtu0Wh0yBr4oLrDMVWRA>
    <xmx:3Hg0aOd04F9gFyiVopE7pWE7-tHC1GGU1lszbwRsH2IuXyzAdfIN9A>
    <xmx:3Hg0aJUm-pGYbQj7u7mUgLjuqxN7DJ6QXq_NQEBpqYXjuxrnDj9jkFI_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 10:21:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 748f6e5e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 14:21:13 +0000 (UTC)
Date: Mon, 26 May 2025 16:21:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] string-list: remove unused "insert_at" parameter
 from add_entry
Message-ID: <aDR42KocPhLEZCbn@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDU46MmoGPB60b@ArchLinux>
 <20250519075119.GE102701@coredump.intra.peff.net>
 <aDR0VS_4n8Io0QYp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDR0VS_4n8Io0QYp@ArchLinux>

On Mon, May 26, 2025 at 10:01:57PM +0800, shejialuo wrote:
> On Mon, May 19, 2025 at 03:51:19AM -0400, Jeff King wrote:
> > The answer in this case is that we used to have another function,
> > string_list_insert_at_index(), which used the extra insert_at parameter.
> > The idea being that you could call string_list_find_insert_index(),
> > decide whether there was something already there, and then insert
> > without repeating the binary search.
> > 
> > But you can see in callers like 63226218ba (mailmap: use higher level
> > string list functions, 2014-11-24) that this was not really that useful
> > (in that commit we just try to insert and check the util pointer to see
> > if we need to add the auxiliary structure).
> > 
> > So the function went away in f8c4ab611a (string_list: remove
> > string_list_insert_at_index() from its API, 2014-11-24), and I suspect
> > we won't need it again. (Also, I think these days we'd probably use a
> > strmap instead anyway).
> > 
> 
> Thanks for the hint. By seeing this commit, I totally understand the
> history. Because we delete `string_list_insert_at_index`, we simply call
> "add_entry" by specifying "auto" mode and somehow we don't delete the
> legacy check in "add_entry".
> 
> But I have one question: should I include the information in the commit
> message? I feel doing this would be chaty. But I somehow think we should
> do this.

I would recommend including such information in the commit message, yes.
It helps the reviewer to understand the context and makes it easier for
them to figure out why this seemingly nonsensical parameter exists in
the first place.

Patrick
