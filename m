Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F111AB511
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911397; cv=none; b=Zv9VDirkP4VSQa/ThH4mr87JtByjB7YBsRMzNcH8ds7FL5VG73qI7U8LywyLApzUDrV6IQJuIO+LBbYa/9tAM3Lf1xjxEMXZF2gnVqyddma5YBfzUMHI8Aag4Z3ctwzTqCdX/LNq6y5QJVTPnncTK/V+/sbrjwdeSb5BOFP2l6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911397; c=relaxed/simple;
	bh=RNL7uPiiDXFvq4OwfBZFqJRPiOKakHwFjTv8wtf/Tk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETASA5n1fQ/7EaB4NnWwqovHOuLsbPEIrfnJPxL5wRglH21nNfIsXv7jse2q4IjkXGf2w0U9VshBn2gz2JSoLRP7qUdybSlU8xP+jPl1OqeRSQ3O/siui+9j/DJK4ehSUPypaWFWjsNWpHDvHpaKTc+qy/a7IoZzARUtitNUdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TvtEzmZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cobvShes; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TvtEzmZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cobvShes"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 873BA138049A;
	Mon, 14 Oct 2024 09:09:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 09:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728911395; x=1728997795; bh=zomGLdjhNu
	UAsPaVnTWHbzVUtdsb9hHFeQrtue8ysus=; b=TvtEzmZ2GiFdsD+/eZxhN+pV5u
	bagh5exM2674I9Q6EnwF9+iLPOPDNNU7amtR8ZrmTqqB3UQaxMRXqyTbhgipLw+i
	Eld5+oK1LeH+za8EHUQkF9SqvHoRB7os/xvju0ogYo6oRNbk9/DRzn9kAueUtwj5
	RfWW23xDNQQaON6V9O2nP1DR62+zXU5qUhzq4mlGR3hzShvwqW575y99n6Hw+H16
	ABW4j0VNzphIhr+RtUiBgjqFbmryBsYLueyyoZOtEGLRVGVPLr9Y9e3BybUo1uUp
	gbaOccrdmbJJGzU2K/Lh0/wotyp2N06g9RAHmRCgO8/f4qvsUwBHWFWKVeYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728911395; x=1728997795; bh=zomGLdjhNuUAsPaVnTWHbzVUtdsb
	9hHFeQrtue8ysus=; b=cobvShescyOVl36Z9265OJylIHdu7qXEB/P/EEzjh5aC
	fSyQa0fTLh0wMw9DbjDBS8lnHzxQMTnKjsTGjKADxxVroWTJBZUKSeops9rhmH5m
	aj9lItB2sCS3LXtZUclbQJYghz5w0lJ71UM+Wzyd553i28wQqRhLkeAy3PiinRno
	TZ0qb5jIP0hRTz5y8wP7ERMyd0iGR7fRU3hfoCn+fmZ70B42Y+08jzkuS98nMIFR
	Sm5qKlAZdcG/43Ufl5dOCcs2jE6nL3YACbz42LQEtZBxD5Fwdi4qzxn/0gCjCaxh
	u13rhslz4XG3QWW+SWXvgZbUIgVjIQDQJwfqUhhemQ==
X-ME-Sender: <xms:IxgNZ8uCf-eMcjoQXb9SQjiLAzjlKeo1Z-Ai43G5noDVu3KWnqIFKg>
    <xme:IxgNZ5cu5wV6B2W7xmzO4odW-_LebpdV-l1Ty6qv6kDrzIIDXqeYDo1tY1c4EFAZE
    ppO0EsAKPFethfJBA>
X-ME-Received: <xmr:IxgNZ3zY3hMJlkbxjDUyPSSeBMWhHL_tWF4mOPgpQlT5qUSsNS27TDDcBbOkHzZ_GYEzti0oEdb4SbRNuPk1q3IT_6DJMEL7OAg-L2NQZD2P-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IxgNZ_MAlQvnAJWni57LcxH8FUvl4DBcnFVybIVp84yB98nTXB6vtA>
    <xmx:IxgNZ899k6Mr1YhQZNvqldrYtFlff3ubn9wOgJsb4zN9m4q34nP9tg>
    <xmx:IxgNZ3UnjybKKCwXfTjblDTUCbsUlCCbU60pwd8xEtCYz0FLRAB_IA>
    <xmx:IxgNZ1d84FAQ6KQuScIcL6_zI0p4Qv-I__0_KLHXlkTAelWdl8E0_g>
    <xmx:IxgNZ7YmhybvPUyg0tA0AzfeihHirUXc9BLt9DMvcVcKj_R-mcFbNwoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:09:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3551d7ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:08:41 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:09:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 00/10] reftable: stop using `struct strbuf`
Message-ID: <Zw0YIJp-kl7glf_U@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <CAOLa=ZR_fcq0NyraV01FQBeOZ=uv7JWLV0+tSsi=zsvt+VZOdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR_fcq0NyraV01FQBeOZ=uv7JWLV0+tSsi=zsvt+VZOdw@mail.gmail.com>

On Fri, Oct 11, 2024 at 05:18:26AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this is the second patch series on my quest to make the reftable library
> > become a standalone library again that can be used by libgit2 without
> > pulling in all kinds of dependencies from the Git codebase. This part
> > makes us lose the dependency on `struct strbuf`, which is done due to
> > three reasons:
> >
> >   - To make us independent of libgit.a.
> >
> >   - To ensure that we use the pluggable allocators that users can set up
> >     via `reftable_set_alloc()`.
> >
> >   - To make it possible to handle memory allocation failures.
> >
> > While this leads to some duplication, we're only talking about ~70 lines
> > of code.
> >
> 
> I only have a few small comments, but overall this series looks good.
> Thanks

Thanks for your review!

Patrick
