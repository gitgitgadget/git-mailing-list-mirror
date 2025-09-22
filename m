Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F1309EED
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546290; cv=none; b=dxPUIRJ/kw3X8iwXZLwNBgRsUl8Hv6UUy4h0evC8SGXqnIno0BjtGoq+2evMmcYW0invfQ2vLxrxu6+9TNmGHPp1Vti50+ZQfyG3hLPi0/zyjTTky4dSXzy2w/czmbq1NlV3+7T2tb60P+dJ48ziNgqUAvLesV5IvIGKOmoKSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546290; c=relaxed/simple;
	bh=pnP9VYrYjB5d9v4rr7qOk5CojPY52UJR5EdReY8Qdto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGlVWnbicQY2jAMSlsr512t1LZhEu4lb+8rnyOdXJBqUMlW6h9yyMuLOOKF4grnUP52QLP9r1SsFxbbheEyn0Fcj23km32qHDgNvH2xnYYDQl5c87CD1S7+a02QBYvUUlGN1hzKWvI2JwaOFWIcOPfqJ9gfaZZUII5IXTq/+I5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WGn320vG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EbNzlPpY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WGn320vG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EbNzlPpY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A3CF91D0013B;
	Mon, 22 Sep 2025 09:04:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 09:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758546287; x=1758632687; bh=OcEu9cqlok
	XObfLl2H+i1U2oxuqmRwjxVepm38cj15k=; b=WGn320vGlboddhcfaNE8rS8KbC
	IE8UYyeJlYOfPzE2VxI3Gd+FeQ1KbPkYjT6gimv4rHCgC8KsS9b/qtk97hS4ZnUa
	z+BrQGiS3eYtsjfRZBgMPiwhsnjySDpNPdqyHWmycPvLCOpe97Z7lf1uSOmpKAkL
	ra3SEfjVJKcVeaVVrPB1bP+nu1U+eZqbvyALzzHKuIgjFOB0aIFOTl4oyIpV8P+0
	zKoxgVJOLRgtlsJTth6b8KlOBNMDihcQoQQXsh2fokD7RDbflBkBZcHtK/Y3R8cP
	PfXF/se/asBFVo0bJO1WPVCwms3yDPuxMpotr26K+Ecpv4ViUIRo+X093CkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758546287; x=1758632687; bh=OcEu9cqlokXObfLl2H+i1U2oxuqmRwjxVep
	m38cj15k=; b=EbNzlPpY4yJzm747LRUxOXHqeuUoLcV2KxBDD5C8dqr3KcPX9P7
	RzBdoMquE4s3TO1+/Q88hqhh0RTJMsbG2qyKpfxLMp/v6f0mQ238tDTI5NHo8daf
	ceyALzr2ofDO5sZWsH0bcZlgkplneN7DkK02/K+rsfJKofVGEbiwpXEx2z+ZkueN
	3goTP3KkOBSQxzn0Pgja09nPrDNPUw5ZVYpaYzFtTvINqzICP5JCy3pfXkw//eJy
	K1vTZ1ITriAqU+Oog8RKPEuLTUSxydUoodvPmajJ1xO3t9VSBLUUFuKIlobmoUGJ
	1+bPDjQCB6Bbs866wM5gzb1o3LnCxOpluUQ==
X-ME-Sender: <xms:b0nRaFpTyZR77c9kNBCUu6Ps8w0Z9zplYIDxrI2XZ8p9RiE9TOXeJg>
    <xme:b0nRaCNnfYtdoY3J6TVJ0DGrJWgEKXTc_SjadXexNj6m2jYon30MFgxMdnTFsRHV4
    d3YyLiy6X62_tANYg>
X-ME-Received: <xmr:b0nRaOxpclbLAQkCbdc75H6YXdiKupXym1lvuAvvzNAs5Kl2bK03V-4rR-tPHQFfhLQYWYxQ3stvomCHtzoZtwXLydGIlWQ8yxaXyxSBlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:b0nRaDtXspQpT0WbTjgMuDna_RrFFe4gAuluPukYheWrhfYHQgOxFg>
    <xmx:b0nRaP5zSG0nA9Q6vcUnsEcnhaPFKj1quVPg5CunaExHdloG9PUhWQ>
    <xmx:b0nRaKSqIlrjTiX79JfH52H-OQmkHmhT502WjEWW7zzbfYk5iZHuvQ>
    <xmx:b0nRaGrmbihaWVtOrcA9qrOcG54RbwRG7f_QfDNtjzEcqX0jupUEyg>
    <xmx:b0nRaLa2xHLzohySL7ORBLoWMWowqGaaqU4G161q_4oH-XCmAVuk7_sz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:04:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f194894 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:04:45 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:04:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/5] builtin/config: special-case retrieving colors
 without a key
Message-ID: <aNFJanpSY8wd8-b1@pks.im>
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
 <20250918-pks-config-color-v3-4-08ea618cae26@pks.im>
 <xmqqikhg9rwx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikhg9rwx.fsf@gitster.g>

On Wed, Sep 17, 2025 at 11:49:18PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Our documentation for git-config(1) has a section where it explains how
> > to parse and use colors as Git would configure them. In order to get the
> > ANSI color escape sequence to reset the colors to normal we recommend
> > the following command:
> >
> >     $ git config get --type=color --default="reset" ""
> >
> > This command is not supposed to parse any configuration keys. Instead,
> > it is expected to parse the "reset" default value and turn it into a
> > proper ANSI color escape sequence.
> >
> > It was reported though [1] that this command doesn't work:
> >
> >     $ git config get --type=color --default="reset" ""
> >     error: key does not contain a section:
> >
> > This error was introduced in 4e51389000 (builtin/config: introduce "get"
> > subcommand, 2024-05-06), where we introduced the "get" subcommand to
> > retrieve configuration values. The preimage of that commit used `git
> > config --get-color "" "reset"` instead, which still works.
> >
> > This use case is really quite specific to parsing colors, as it wouldn't
> > make sense to give git-config(1) a default value and an empty config key
> > only to return that default value unmodified. But with `--type=color` we
> > don't return the value directly; we instead parse the value into an ANSI
> > escape sequence.
> >
> > As such, we can easily special-case this one use case:
> >
> >     - If the provided config key is empty;
> >
> >     - the user is asking for a color code and the user; and
> 
> "and the user;" -> ";" perhaps?

Oh, yeah, thanks.

> >     - the user has provided a default value,
> >
> > then we call `get_color()` directly. Do so to make the documented
> > command work as expected.
> 
> If we are willing to handle this as a special case anyway, I wonder
> if it can easily be arranged to take this as a(nother) special case.
> 
>     $ git config get --type=color --default="reset"
> 
> I.e., instead of (or in addition to) "if the config key is empty",
> special case "if the config key is not given", which may be slightly
> more intuitive.
> 
> But even without it, what is presented is a vast improvement enough
> ;-)

We probably could, yeah. But it starts to become even weirder than it
already is, so I'd honestly just leave it as-is for now :) I doubt that
there's too many users out there that care about this anyway.

Patrick
