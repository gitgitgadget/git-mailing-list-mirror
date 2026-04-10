Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BB330B14
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797079; cv=none; b=UWPZXo3dc/qw8rNe7cXvrKkeLsqJ0klcB5/nG5Krr+AVE8H1S2de2JDBKe+PL3KuqoR5MPuFBrIM3+Rgxp98WYUC2dYkFqf5Sr0pgiPKISUFp9dlyxgj/FmkC6KPGMhBXc2wMw9a8PqaJPbRSxINe92C4jRPd1NlHRg0YpcG/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797079; c=relaxed/simple;
	bh=jOGSS53qlPEbsPe1qTv38ejfyUP/63mOiXahLZGwK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv1cTFWFMB7yZxM1gwuNnk5Q8uNUhyK6cXEzjJKG0egpCjQSHxUHQzReDWJ+Xt95g/zErIJlyMI0Oin4xAlmzs7QsSM0bFMUcUyrg8f1iWbhRsUyv38KMcBRVQvsvsoRmHoDxaZ1hXRoSz8hgwdoKur0rOOkWFIdVK5680QTzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iA6Z4qhc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L++qloEn; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iA6Z4qhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L++qloEn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 87AB7EC0402;
	Fri, 10 Apr 2026 00:57:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 10 Apr 2026 00:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775797077; x=1775883477; bh=10k1e/k074
	a+l2RERmnsbvWiJBk/J2lk1zkjLTO2y2A=; b=iA6Z4qhcd1dPhGG3uKHYWMOXe7
	yodyRQV2sT8ttPgbf3skC88fNwkiG0jAtBAtWWaRoeV63yppe9dxZCcZA8qYIeVd
	DTTR7mxOt49DVoLuKVfNVuz+4AYnMK7rDfy+zxLqE9y/0Xyc80AgVfSicJJ/EXt8
	BD+spSQK8wfSyhUwWRCixzphC6tBWnb0zH4aWe4zFZ6g4cP3Y9JASah8QwL3Oe1n
	YuW35K7+n8y37e1MF42x/vR9nqJAgOdZsawB3+xB/t9Mxj50AH5odwkoDPNd2taD
	PtGSs8BvVXJozpg+l1CZ0vnH0MDBte+cvKSv2pDctYTBKb9BmTp8TuUY94Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775797077; x=1775883477; bh=10k1e/k074a+l2RERmnsbvWiJBk/J2lk1zk
	jLTO2y2A=; b=L++qloEn398/4TcsddaVUzEEy99vfsEYEk32doKU+zR2awJBxPB
	rXmatMoRyttf97Pd095Sx2Hs0rFulDKddtkQ7qD6IG8je8dXBPDYTRY3unELyQCZ
	GxM4r5Es+lqq4/Kr6sX+dSzD/KHGO8chudcT7hGBjLM7J4RvU2ikNQWffcmx+Jk0
	2wyzGNxnQ9+FHV3qEC2tfi399haVEFgr/A9D0aJuLuMknHI0BavKU9AHgWo9pliZ
	h4QqY8OKh1G+KLu/2oj5XXZZRc306LAGyaVtqwFLDJyAzCc8UgSU3udvV2844zVp
	mwXyzXGXnp54aEwHxvHkfHvuOaRDLIfqtCA==
X-ME-Sender: <xms:VYPYaR1WdFauOD1Bl7A2BC79O3u2Rp3EqWlaYaxBoTQ7D-fP-flD3Q>
    <xme:VYPYafF40UBkTfU4FhScW9RctJ0rOS4W_YFaOMBM8jX0Z2l4gF1edainSmOxzHUz6
    Itqz0u4AkSr8ZT_zi3gfUgdIeskGyUfBcCmsLwS0GF5dInDoNuw4Q>
X-ME-Received: <xmr:VYPYaW4S77W8rVHxoS9o2icq6vyvmepdDko_n8zBa1qADwjL7GBndFp6tHCdp9oVmV0Tnu6fURlamewcgRgy-XMc4W2E9sdSvOjy4Qb4u9LEIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvth
X-ME-Proxy: <xmx:VYPYadu64Xv_iTpPdfRdHu_lD60jyWHXqq1xuU4AT-IMTyTCgZ6IYg>
    <xmx:VYPYaf6GImZKLc0Kc5lGIu3LqUAB3F4lPL04Tw1lnHDIH_-v-c-V6w>
    <xmx:VYPYaQX8uYZhhDYmoNXtRuVlLiMDpUob46XvegRAM-B7GipB5bUPDg>
    <xmx:VYPYaZ_fI6gXV6usEFgQqCfVMJlswXwOZyqr8n-DUEgOdAiMKzVsvA>
    <xmx:VYPYaS6DFdlZsAPP_95S5iOUbhAM4fcjrJPdTrN6fuuydOeVLIuzd_Zd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 00:57:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd44290a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 04:57:55 +0000 (UTC)
Date: Fri, 10 Apr 2026 06:57:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Re* 2.54.0-rc1 NO_WRITEV=Nope  does not work
Message-ID: <adiDUFOl6OaoResZ@pks.im>
References: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
 <20260409211049.GA3119065@coredump.intra.peff.net>
 <xmqqmrzbreav.fsf_-_@gitster.g>
 <20260409222131.GA3130242@coredump.intra.peff.net>
 <xmqqik9zrcj1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik9zrcj1.fsf@gitster.g>

On Thu, Apr 09, 2026 at 03:31:46PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Apr 09, 2026 at 02:53:28PM -0700, Junio C Hamano wrote:
> >
> >> > Yuck. I think for 2.54 we either have to truly implement MAX_IO_SIZE
> >> > support, or we have to revert the use of writev() in send_sideband()
> >> > until we do.
> >> 
> >> Sigh again.
> >
> > Yeah, I feel the same way. :(
> >
> > I would be happy if somebody could prove me wrong, though.
> >
> >> $ git log -Swritev --oneline 8023abc632^..
> >> 89152af176 cmake: use writev(3p) wrapper as needed
> >> 26986f4cba sideband: use writev(3p) to send pktlines
> >> 1970fcef93 wrapper: introduce writev(3p) wrappers
> >> 3b9b2c2a29 compat/posix: introduce writev(3p) wrapper
> >> 
> >> Reverting them gave us the following patch relative to the tip of
> >> 'master'.
> >
> > If we are planning to improve the topic post-release (and I think that
> > is a good idea), then we can do a much smaller revert. If we just revert
> > 26986f4cba (sideband: use writev(3p) to send pktlines, 2026-03-13), then
> > nobody calls writev (neither the real one nor our fallback). The
> > wrappers are dead code until we bring it back, but it may make things
> > easier for fixing post-2.54.
> >
> > -Peff
> 
> Yes and no.  While excising know callers is certainly safer in the
> code space, I do not want to hear about some compilers complaining
> about dead code, etc.

I guess they wouldn't as the function signature is part of a header.

> I am preparing another set of integration to be pushed out, queueing
> the reverts in 'seen'.

But anyway, I'm okay with this as the safest way forward. I'll then
reintroduce early in the next release cycle and hopefully weed out the
existing issues.

Thanks, all!

Patrick
