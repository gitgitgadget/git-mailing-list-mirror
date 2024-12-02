Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836721FE457
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145864; cv=none; b=XQt+G14sHF1R9pTkDuHjkZmpzziTWa9Ft3QHnRxN2D8jRPgzpsEinOqf+oBQi6cNCr7U78LZF3poHJb9wKO0diZTUlB5yEH2OF6buzPl5fKNO978MYOwTcGW9X0z3/t79dPWssvCIXcKbfnFPxRyGcfaRSY47qs8ihKaXUBhLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145864; c=relaxed/simple;
	bh=8P4TN+3MhofsSn8FRpJKTiAjK3zm5ez9OcwPd7etomY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBAloFncdpuE30ig6ywTLe8iJwHVHHhKkCRDOHG7T4b7+tEyZde8xoixUS0Q+0EhF4SQQYLd8iGWUUYOa9Vt+xhXjABL2ZQ0ORpgYvVs40eZgmIgkw5cOVgNC6ra6bCzPhdLTfuUfhdg2tqR/H9PZCPUkA8LO/3m0Q1QXrCI4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KElApobi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d47gq22t; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KElApobi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d47gq22t"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9740F254009D;
	Mon,  2 Dec 2024 08:24:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 08:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733145861; x=1733232261; bh=NHcwIQ+th9
	70EjrKGM8hzzne7FqARhxUhx7gFLIfGrI=; b=KElApobinC5MNB5eBHQygg5uve
	l5IXl1vObDxZtze89xxym7KRTVuM7YE/xy6FGKK+XIgZ6xg+pDN5+IbfBK/xiUmL
	XoR3dEy7oufmLpU1nLo0acdlOSREsOhoqaNSLeJwK8L8jb9FmNwp2k008a2IW1Df
	Em+K6XNt9CAE/5xxA0vAmg3fPEChv94L8uqUg9/aHgxgAb12gWDYnO9rI8GY4yzZ
	TYRckEPTGV0KtkIZ86aJTiAaXPXPHDINubY/SANafqLTOzTMYxktbnOyPHftYaQy
	Mtitj6ZhGDsRGFJbfjhyAk/qgmAnbVLdhnGz1ucIuXU5Xq30Rs9W85WR4Low==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733145861; x=1733232261; bh=NHcwIQ+th970EjrKGM8hzzne7FqARhxUhx7
	gFLIfGrI=; b=d47gq22tEUylO3oAJnHNg7oGzTHBEX2A1t2wKGFJXP8o4JckVSs
	QFDug5lGyMHkmI3DLTIvp7uaXszjil5iEM+S9TX1axSKfRAv9pkRvFDQcOqMuDWO
	J9sznAG/5Y37UELIDZgoH91pvY+cbdO8+GxBnMPXZe+wQCqeO1vIbQVJBEiQ+y4X
	DSue2hC2UmC0yYtNHQ2N7gwB9iF4dKxvfhs6Gtou1UKoGd+6FRq2Y2v8HUDoXYpb
	saKLmyVJZpQQlEqy80v8hBXk4BSNYmPm84vpPp2lKc9wKyqsIDuDmV327Zpi1PAi
	AKeZxDLF5Ay4D2F1v/x18pb7Y+Bb8USA2jQ==
X-ME-Sender: <xms:BbVNZ1Tbo231zpJ6aepz6pk3ZnCY69goJkoCiZg_EY40Mxw-ULA6Fw>
    <xme:BbVNZ-z2NzdNF2jtmGS4hgv8YeDH-iFcM6qj8weMyMAT1njN0WT3xfMvZkF13oeYd
    sMxHMOgr1G7vPEA0Q>
X-ME-Received: <xmr:BbVNZ62CnAukBXqxyVKc3P0D4UVX6RB8-rnpJqLkwfPGqiPbh_B4s_DZDG3nkZd1qdYeCn-S4pkfAdmkim2ZskZ6HFTt_Awu9KL4zhkEB8SjQj7nYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:BbVNZ9B9alEKSLlRY0DPixQPdXb2TFJ_YWYpjDaZ1vqWZkyHyz2WeA>
    <xmx:BbVNZ-g1ZO-gsbFKRPj4huIbid6m1subcnyz7KoG9iXrkxphkKwJGQ>
    <xmx:BbVNZxoA4FhdG8NseJ-5964xZ4BlKW0F2stPQe07jitD7FfjdYcgMA>
    <xmx:BbVNZ5j4DC5mLy7PBDUg49mQjETVggxcq4432P1WRZKhpbqkejuuWQ>
    <xmx:BbVNZ_uOWqQIpgGDtx_5Lzt0j4wZskZyRl5r9AfSbOoGvBegC185eJW3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 08:24:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e183210 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 13:23:01 +0000 (UTC)
Date: Mon, 2 Dec 2024 14:24:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 12/14] builtin/patch-id: fix type of
 `get_one_patchid()`
Message-ID: <Z020838LPcl9jp_8@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
 <20241202-pks-sign-compare-v2-12-e7f0ad92a749@pks.im>
 <Z02zq7Wc1A2ot-Oe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z02zq7Wc1A2ot-Oe@ArchLinux>

On Mon, Dec 02, 2024 at 09:18:35PM +0800, shejialuo wrote:
> On Mon, Dec 02, 2024 at 01:04:44PM +0100, Patrick Steinhardt wrote:
> > In `get_one_patchid()` we assign either the result of `strlen()` or
> > `remove_space()` to `len`. But while the former correctly returns a
> > `size_t`, the latter returns an `int` to indicate the length of the
> 
> It is a little misleading about the statement "the latte returns an
> `int` to indicate the length of the string".
> 
> Should "without spaces" be appended into the last? However, don't worth
> a reroll.

I'll say "stripped string" to keep things short. I won't send a reroll
just for this, but will send it out if there's going to be a v3 of this
series.

Thanks!

Patrick
