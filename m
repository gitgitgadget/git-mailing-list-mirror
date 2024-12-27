Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819A80BFF
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735294594; cv=none; b=CpFEDQOpVbrtNlv9+kHX8pnnaOiJYX+HgZQ2zQM3QR1vnA5gOSQaBj0rF9UMX2TFuzfbCWoeL2T1jWK3sPAOIk+jJHaYdzql55UEIO6Dq9gD5PyI+S9rDaQsEM2k7a2/CE6+OVWNgPa4UPAwK0fpUadqQGm5u46hFLCEGB0tjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735294594; c=relaxed/simple;
	bh=hx9lpb/NHoyJfJDKSCtWYo2NGROfhwo88i/iH4v9QeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF/OYkMINRCPPRBHI4QUN/1EMszPzh4qcLzzo0hXvLnpL7nQdXnJhKjmJf1H0ZRRckjdJ2fvPSOYkxyaLNaoIyOS99XfrEtJAsfXcy7ngiLTAcv97ErfErn93Yqvs9Ge1GcqRU9qIY3+LV7O/Nxem/k9vGzIgEyzG5doN7WrI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bq5zXtqj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6rqko2c; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bq5zXtqj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6rqko2c"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 97FD913801BE;
	Fri, 27 Dec 2024 05:16:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 05:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735294590;
	 x=1735380990; bh=1qJvxVdmrz3z7bkBxQ8OjwmTsl33dc04yuPU12MArvI=; b=
	bq5zXtqj16yyoTItY6R93nR3KPrbnhHekoqi7DfEmIHwMZMRCIdE+NL0b4KbUFdu
	Y0WznCKXn/n3wi1dgKK56uUYhyfAJu5mF+2NNA0KboTHO6wuX4KLXGlwDNtFlLgQ
	ZBYiHrl7ng054FsFsMa7egw3Q0O9pXLzcFRYI6ar2p2OHmFO7m9LqIK2BepgEBDV
	2GjiQn/kb9x9Zk3+WgSSZEo/zkIWUk6/jVgFNx8uAp12RKBfTLqNWwpVb4Bw8Sm9
	ixwYPMX7wHpHTVcpbNncqna35J0Q4skLBFPKddL2pX6Tv5j1elHkC2KjEia0Sy6t
	rCB3cnhBVGn58YadXy1l5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735294590; x=
	1735380990; bh=1qJvxVdmrz3z7bkBxQ8OjwmTsl33dc04yuPU12MArvI=; b=C
	6rqko2c3MYyi3A6vP6uxda17hI0GAy1xZ8rjmpjcoaZsXB2+fmmmrOKHlKjVNGnW
	OfvehOjm4eDsfNA9XfjCkMhhCy8WLELivyfmSJtpHP1nagqLvHctJTJ3gMIFTCav
	e9tEJWmbZvU+Ok1ugd9YwuJOxZgU8RWL93pPhsuCQVrneX8FvGC8WtckuC4fTuaG
	jxwodyuHWYsIXGundEh1OiRaV1dvcZfsHbrtdBNHlxpq3tb4bhkbbw2DYyZqog8+
	rizOLFcF7lhcL8zPvtZCVBkUe+COJdxvW4Dnu3tQ1MeCdtLe/T22soMq0Dp7gDNw
	dqouuKFpoHK6FUtc8R/XA==
X-ME-Sender: <xms:fX5uZ7cq3EOHLxVbek0pKTJ_nlRaBYz3ajkgzR4PWFSeWzliCeBaKw>
    <xme:fX5uZxO2yA0XthhQAwUtSTUcypQucLxY9wKC5_ljphyjMiFxgCrFcl8zOxDKLcn9L
    oJ75JoN7xGu03_9wA>
X-ME-Received: <xmr:fX5uZ0jw7nyrHUCpUHsksO1olBeGJdQdarwXrt02Yi4Upv0jekRVvaIg3HGPCiAw2iVjVOQbglOPbHLAWbGrXGdnh3hw06N2gvnPCNrHXi2oLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvg
    htrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fX5uZ89q4BRQooCHBxL9v3mcFBPlq-_sSZiN8FYkjFZo61W4tywDmA>
    <xmx:fX5uZ3s4m7i9j_Akm6-1TuHW3qZACXalWExhYzyLe1iwhczcrkVi3g>
    <xmx:fX5uZ7EqIEtpNDu8eCWDwMNM0u6s-gKNVpCb_koxNNdH3pyMwoo6Mg>
    <xmx:fX5uZ-PE1i5k3K1xXouZZ37v2E46zbIwvXN2jbHXXPPfPyufVhfDhA>
    <xmx:fn5uZ3LV5qlubn-tUOJe9ARyIfoV6d3fJuuy3ru4KcxfXSIW2L89Kb6D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:16:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5ca289a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:14:25 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:16:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
Message-ID: <Z25-aaS7s3baU7ly@pks.im>
References: <20241223110407.3308-1-soekkle@freenet.de>
 <20241223110407.3308-2-soekkle@freenet.de>
 <xmqq34iaxh7r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq34iaxh7r.fsf@gitster.g>

On Thu, Dec 26, 2024 at 01:33:12PM -0800, Junio C Hamano wrote:
> Sören Krecker <soekkle@freenet.de> writes:
> > @@ -1624,10 +1629,11 @@ static int patch_update_file(struct add_p_state *s,
> >  			else if (0 < response && response <= file_diff->hunk_nr)
> >  				hunk_index = response - 1;
> >  			else
> > -				err(s, Q_("Sorry, only %d hunk available.",
> > -					  "Sorry, only %d hunks available.",
> > -					  file_diff->hunk_nr),
> > -				    (int)file_diff->hunk_nr);
> > +				err(s,
> > +				    Q_("Sorry, only %"PRIuMAX" hunk available.",
> > +				       "Sorry, only %"PRIuMAX" hunks available.",
> > +				       (uintmax_t)file_diff->hunk_nr),
> > +				    (uintmax_t)file_diff->hunk_nr);
> 
> Again, this hunk may be needed, as the "hunk_nr" uses size_t, which
> probably is overly wide.
> 
> So, I do not mind too much to adjust the code around hunk_nr,
> hunk_alloc and other things that are already size_t (but before
> doing so, we probably should see if it makes more sense to use ulong
> for these members instead of size_t), hbut I am not sure if it is a
> sensible move to change old_offset, count, etc. that count in number
> of lines and use ulong (not bytes) to use size_t instead.
> 
> size_t _might_ be wider than some other forms of unsigned integers,
> but it is not necessarily the widest, so "because on msvc ulong is
> merely 32-bit and I want wider integer like everybody else!" is not
> a good excuse for such a change (if it were, we'd all coding with
> nothing but uintmax_t).
> 
> So I dunno.

In practice, the number of bytes and number of lines _can_ be the same
when the file consists of newlines, only. That is of course unlikely to
be the case in any sane input, but may be the case when processing input
that was specifically crafted to trigger such an edge case. So using a
type that can store the maximum size of a theoretically possible object
feels like a sensible safeguard to me and requires us to worry less
about such weird edge cases.

I also doubt that widening the type to `size_t` would have a meaningful
impact on performance, so I don't see a strong reason not to go there.
I tend to think that using `size_t` in such size-like-fields should be
our default unless there is a good reason not to pick it.

Patrick
