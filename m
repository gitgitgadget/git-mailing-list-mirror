Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA01F6690
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572172; cv=none; b=RgvAxd9EC3g7YQvtW2m4+L8XWOJZDDqjnkH9d4q7fhx4raNm42uZTOkio00KeehOdUOhmoFrN7qxOtSjETDxz1skJtmkSDzxp4c9H4RD0Rn9RqDyBfv4Kj5LZJ6422J81JhZMFV2H7n0t7XaQe866OsGC27oqmuC+3qJmwd60rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572172; c=relaxed/simple;
	bh=MgQY9u8wg/M1YZcHHiYSMEYT3D8zoJx+GAxHqqvNZks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqjVjVbL1vOweCZwllLp3ZgHtHzc86Tv+vT2Kt//wKlt9EXotatmfXpfkV9cSI66+hr7Rrx5CTazztijSshWNypjwNgvOjNz4jMCU+RlfTgU2zoSKuP5BoihirljfYDw+zn47FkxsBuTsnVN+8FddosnIyG1v/patwsfqvrEvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XtafBiqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLLtMr44; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XtafBiqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLLtMr44"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EBB271140155;
	Thu, 14 Nov 2024 03:16:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Nov 2024 03:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731572169; x=1731658569; bh=CtqwuywKnW
	FGZpRcI96LdfSHBa9vrVETD6DSfdoOa1U=; b=XtafBiqghnWeHz99bC3aVVqQzu
	aJZCW4ZOw3AX/ZvAn5x9ah5M3aJcBw+Bc0/FaNowCesEjjs3skj3BQmpRLy7uzo5
	0dYnrKp2KuIrqJqHRKb/OC9ATaN/IFxoyh7P7t4CCy1kKWoZW6RWpwvBpOu4MoD+
	71+M2YRY8mCxGsjkrB2NOqE4lfUOrHO91VSgfI1dMybvZPQKmEYdVNnl6nf923jc
	r2VXzgBMz6pkTzif0ZPAf5oiPP9j5h++ao+uSqJ7ft6MCA/b/Vw7Cej7E5dyM1gL
	gqCN/laK6nChqElJHckL60ELXFoBjSCSW0bzqAHDiIAFDSZ/sxiBLEyKUkug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731572169; x=1731658569; bh=CtqwuywKnWFGZpRcI96LdfSHBa9vrVETD6D
	SfdoOa1U=; b=RLLtMr44Sxymg11H6/AP4Y5yhLafQF2JsfkEB93ODDCzrAtbLw4
	i2OPmlsO8moknc3ZkuIMHRnVtdNuHgONHfGGizxjekGudJW76CFjj2B5QpVyQsxj
	Ez1SA6ZAHloO3nLSnuypFmqZYDSr1axnKf4xO2ZSB7MZb4En5XTSH9Tb8D263/Ut
	eL0+wOcPNMPn4kgjE1EB1eO5jE9RddQ1mch6eVboWdNOubalMoEUyntZewT7jnCL
	NjfrbL/w2D6UEc8pLngNjSMa4cjgaNHONQXEFMBhDQG5rl7v1IaPgWiR0E+LJsj8
	BIHOUqKGRd1UTxov68uJx53cPCndYyGK3vQ==
X-ME-Sender: <xms:ybE1Z-J4S0p6zLa4YTm-lMv5F_RcolUxtQ7q3-lEsKcQWVGUJ6Ftrg>
    <xme:ybE1Z2KgCyVcLJE4SLbQrfpxgmUVQOUqzbR-xADzByVgd20QcFRmkyffTIkGhOYjh
    QeBu3wi2-5TmeAjRw>
X-ME-Received: <xmr:ybE1Z-utwwWOFIxug6HZw-WIbfHJ9k5dCdYz8tXQODgxZ8rFRxrqiVmOwQB26MGdrraULxvBqk56sKwD5ANM_bktuEqS5qSiOEWL8DK42EZx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghp
    thhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:ybE1ZzabGabsubNmWKooBkNg0UrOMIIIliOuy0eVxF4R1MNR6nN3MA>
    <xmx:ybE1Z1ZeZeBVMf4WXQkyhMX6B0lDpjA0OYAIhg-PwPg1rA7SvgvLRw>
    <xmx:ybE1Z_AKGaqHC804RNYR1sWXkVPxBTLyD02TwiVc6sl3ff7IRrGWaw>
    <xmx:ybE1Z7bZWpQif1xEy4kgYvb0zldiBIXX39w8pqBrzP9VeB3cV2DEZQ>
    <xmx:ybE1Z3n1QxFTQ0HSB6dC_ha_QjV0fnyKzzokwoxE2FxOQ9Lgxr9iSIfo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 03:16:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17d2dfdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Nov 2024 08:15:27 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:15:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>, David Aguilar <davvid@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzWxvnn3Vu0rW7_A@pks.im>
References: <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
 <ZzRvsOeLsq3dJbGw@gmail.com>
 <ZzSprTl5Z3uIx0_d@pks.im>
 <xmqqo72i788q.fsf@gitster.g>
 <a2b5e007-776f-4c70-bd8b-38f1ec9808e3@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b5e007-776f-4c70-bd8b-38f1ec9808e3@gentoo.org>

On Wed, Nov 13, 2024 at 11:46:32PM -0500, Eli Schwartz wrote:
> On 11/13/24 11:24 PM, Junio C Hamano wrote:
> > Is there a way to disable that?  These symbolic-links pretending to
> > be installed files are quite annoying---when the target file is lost,
> > the links become useless.
> 
> INSTALL_SYMLINKS=1 in the existing Makefile is of course the one true
> way... (and really, why would you expect the target file to be lost for
> any reason).
> 
> That being said, it doesn't appear the patch series implements any of
> the other multiplicity of choice in what kind of filesystem object gets
> used for multiple copies of the same file. No hardlink or copy support
> has been rigged up.
> 
> (Meson doesn't have a builtin function for performing hardlinks, by the
> way. I don't really think I've seen people desire to do this outside of
> one project being discussed right here right now. hardlinks are mainly
> good at fooling people who look at them into not understanding the
> association between the two, and at breaking across multiple
> filesystems. It's definitely impossible to get it right automatically,
> and asking users to make an informed choice here is just not something
> that projects other than git seem to find valuable, for whatever reason.
> So basically, it's fairly understandable that meson hasn't previously
> added hardlink support.)

Yeah, for now we exclusively use symlinks for this and I didn't wire up
an alternative. This was mostly to keep things simple while still ending
up with a fully functional Git distribution. I also couldn't think of a
scenario where symlinks would be an issue -- Meson also supports them on
Windows, so that would not be an issue.

If this is a requirement I can adapt though. While Meson does not
support hardlinks natively, we can of of course manually wire up them
if required.

Patrick
