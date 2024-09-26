Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AC1C6B2
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359361; cv=none; b=G79/I6WVfplPjNBZtIvGHijXFah+I5wHArpBhbgkxWAUZ06vyj7C9rTy8jmV/mWPGn0VKE78uBurQPSgJYertzUPkRos5VJ9Bg402PpJwjIBjG9SpKOzPFlYlLDr2yLfWiSO7Khx3vIfY3EKRkqBSVSCeyEtR0PPiNDgO44mkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359361; c=relaxed/simple;
	bh=UBkE73+B0fQkcX8TBtOJf54Qn/8y09591q+zf1t0fdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsUpOVFLmjWjtfQUm+EBF+Li4uKBpmNShTyevrXqCjX6YCIIvSIw/mJzm9gtyVSKFcFuIUu/6ypq+VMIm4sshF2ILm0vWzmccpLZDlIt+MvjFBeNOO0z/HkrlArDU9TIQZjLyROH0wqAeOWnzOqusW5ujXtu0bP264JYT1qflCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FeHw7+n1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWvO4XUN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FeHw7+n1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWvO4XUN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DEE81140204;
	Thu, 26 Sep 2024 10:02:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 26 Sep 2024 10:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727359359; x=1727445759; bh=VvpLRY2j+/
	HJ2dUBX4muFI4Z4rNit2pvkHsM0hd0RRQ=; b=FeHw7+n1NS/4w8yfpZgbD8CqD4
	BWbCXHmoP/XfHquytxbRBkIkAnIwzOE4IcaHLrdMUz9s2lp0J1RX3//of1ZkewqN
	19sbxc4QOnKrtoXqWxyBIoxzxW8B1rdpmsbFJg1686lLHRoEPDDhNSy9nuE3XV3a
	j8LcuH9dMkywlV2bhATirBd5bqV23+futLBixXRLTvfkcaBh2wrlW59xglJTlgJs
	LmFlk0iM4ETO1pclf43zg1g23iJF64ytm45LywOFtPMeBxPQCMQz3ZqWsxd7L19i
	T/oA0Vx4eBSund3dDUF07CwXXAYSrTGLqR1CDB7FEarnMd63bo467g5gqrww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727359359; x=1727445759; bh=VvpLRY2j+/HJ2dUBX4muFI4Z4rNi
	t2pvkHsM0hd0RRQ=; b=PWvO4XUNVkEun/aGBvtOcGfl090mLTxndmu+zhqhC8tb
	rowMdHJhtILo/ffHs5g+VCUO7m5v6YOFCEojoMz7FeIQ/iiMafiGEOblGjwxOa0N
	kCFaYw9QdG79Pufz1F+rjHV20wLUDtoALZ6olFNrLtMcEkD0fN6zHiC24PRAoclW
	jQZ5VN5cCDtBnBDKJ2H/rTjS0YljpAqzhU7FkLQVY3M/NOeCelxJ/rYLzhWa0dsB
	mURHOrj92rOlEXbBvsFTKc8nOLI9r1TbkVDBDW6OSDSw3xwxrMu7UmuD6hnoKkEc
	pAzD3xyninMcSkayEKFWv47YmnqpiMZuYeogDM1erg==
X-ME-Sender: <xms:fmn1Zn3v_zSoqu0CivnOCorl8k0FQ0xopsImshA4uODF0LrGG29MZg>
    <xme:fmn1ZmFiVfeMFskNiRsDBWgn09vtNhqMjp0EG-Gvdcj85V3cdmfzM3CBNmlmmQa6d
    bVmVoVJrV6_rcDBlQ>
X-ME-Received: <xmr:fmn1Zn5hiszOuABoiyal0eITLQRhcnT-19tXq_CupoBT6aaeUCUtNog4wJYdne_BLHVNzkXchRxI3Oyw0s7UwdqhBqpCXa5013UrXQi5qOCdhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehhvghnrhhikhdrhhholhhsthesohhuthhlohhokhdr
    tghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:fmn1Zs0ijtMho1zbOFB8r79LiUa7VxJv0K8MvHw4heANx2Cthupqyw>
    <xmx:fmn1ZqHDCN4xDfRUScR_z1GdSAFzCCw0WNXiH5fU9kCrS_iuQh8Z0Q>
    <xmx:fmn1Zt-N0OA7XfGZph_aBbBMPzzM4Aa4ka5hsN2nCecC-gszYH-QNQ>
    <xmx:fmn1ZnlTdLYOwbS8H7EnQADs-IhKg-lIi-YH7DoLY0AMzrFLfVCaFA>
    <xmx:f2n1Zt1G0F23ZKg_xtutfwVxsmrVO98_yYZDxf8czC6IrYXMDqORgfGl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 10:02:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c24419d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 14:01:57 +0000 (UTC)
Date: Thu, 26 Sep 2024 16:02:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZvVpcY5Jgp7BzuRu@pks.im>
References: <xmqqldzsrhyp.fsf@gitster.g>
 <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
 <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im>
 <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im>
 <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>

On Thu, Sep 26, 2024 at 02:55:52PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 25/09/2024 07:04, Patrick Steinhardt wrote:
> > On Wed, Sep 25, 2024 at 02:02:34AM -0400, Eli Schwartz wrote:
> > 
> > > I'm probably biased, but some of these failure modes are *weird*. And
> > > they basically never require the CMakeLists.txt to do something
> > > considered non-idiomatic in order to trigger the issue.
> > 
> > All of this is very valuable data to make my case for Meson instead of
> > CMake. Appreciated, thanks!
> 
> One thing to bear in mind is why our CMakeLists.txt was introduced in the
> first place [1]. Visual Studio's CMake integration means that so long as
> git-for-windows is installed building git is simply a case of clicking on a
> button, there is no need to install extra software or plugins. I'm not sure
> the same is true for meson and I don't think we want to end up supporting
> both.
> 
> Best Wishes
> 
> Phillip
> 
> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet/

Fair enough. The final discussion about which build system to pick is of
course still to be had. Having worked with both CMake and Meson quite a
bit in the past I'm strongly in favor of Meson myself, and so I will try
to make a strong case for it. But points like this of course need to be
considered when we have the discussion.

The nice thing is that we'll then have all serious contenders (that I am
aware of) wired up, even though the level of support will be different
across them. But it should allow folks to come to a better understanding
of what they will be signing up for.

In any case, I'm now in a state where the Meson-based build works and
tests just fine, except for t0200, which requires a bit more plumbing to
set up xgettext infra. Once I'm done with that I'll go off and test with
both macOS and Windows to check how the experience is over there. I hope
to be done with that somewhen next week, at which point I'll send things
to the mailing list.

Patrick
