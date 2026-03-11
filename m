Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90843E1229
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221187; cv=none; b=DlHlEysWURKmfKA9/z4//pBbKFiSS1dxtgTnStBII89pIsEtFkRAKFuzSQ6Fg0vuNHjC5MVBdzf5Tg6Lld2sUpV7HoA1XIlqxagl/ZKCcEvwtESImXmwdRaJQMlfHRz73DaU3WEWKyHHuNUdwXHCk9CQ2zGNhAIErn6NNtc8YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221187; c=relaxed/simple;
	bh=Y4qhe/sK+l4NwH7EXUIhfwBPDlpgwXxEzyJWm01KcM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StqKx0xbxfJjAiMTZoz0tITBEwsvlgXhfnmgabNXJKT/O7M0tt9tPCp5VvMkj3Vv2v3Bdru+S9gb3dg0CLOWJwKREf82/SlLmKuPKqlDE21XUvbI3rymtesJZ2qDd6EkJJ95Cd/ueCeRLcudgDx475khwiHvX2ETTyy1m53L4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ew2vtd6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hk8AY3BL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ew2vtd6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hk8AY3BL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC2D77A0163;
	Wed, 11 Mar 2026 05:26:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 05:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773221183;
	 x=1773307583; bh=T9X7nnPoJlcal/B3PrBsyAJDyiTS06UCbC8WzVaMWls=; b=
	Ew2vtd6jSAAWpMd7naMLZ9WslBw9ZL98dSCgsIJdEt+dyxy9JAqlD2l4Ha+/ZkKY
	Sl1sFXEjXlQdRcqHhV3HMvGU5AzCzC6wp5s1/SkMUL1gUYd+P4w242eD/f0GA3Zh
	torvf8YCj2O1UloeQkJJN7GZwdPlChlk9DqqTsZlAZpomG4mnAkjmocJiLKFRGPu
	ZLk+utHLax352fvJiJ3iOODJSJP+/c6GI2q+a/u58y9Hkswa/HxMwFlozJP2sWeJ
	RIVRCIRZi1w/JTh0hahn5QP6dUCqS5tf8Y2qAKtgBjGKUsPimiiSrBTiqCGRDonJ
	YuHAyb283RJ6yhp5TElTTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773221183; x=
	1773307583; bh=T9X7nnPoJlcal/B3PrBsyAJDyiTS06UCbC8WzVaMWls=; b=h
	k8AY3BL8eVlUDRm4TmfKK+5BDHdhFuVBJ8BAcIF5Tsk8WC3MCzWvNoUJVUvLqkTT
	YL3HjY6DMsxv08vkK/SkwNUKU6aL+WZDNbvaqowlKA8LoTN0qJWn/EvOBfT1/KCp
	zx9A8OZ8BhoY3/7x1zbd7aluZ+UQ/04JAcdScEWgNpyxgrba0GOY0X9tH3tP/pCW
	re0A91fmMcQhpf/Ecw+7a/LESRTgpNtL6s3/Wl6Sx492Jk3akLhxAP7pbmzFjl1P
	LFVXSUuk7arco59G0PgCe66IE/llzse5EfQz2RYLoqnQs/2bEhmJ9l1TcpNTKtyu
	oqTlxMPT9kMYlAnZNRpIw==
X-ME-Sender: <xms:PzWxaRfqJhItolvjyvLIyQM9--jJQn634h0YZe9GyAlftV5-AevpdA>
    <xme:PzWxaWpN6CGwawSe3uRsu4IIaAMNy4Pka4_BhL1ep_wVLr6sloMMkYLij7Q4Ur_a6
    3nG8joTi2JyiabeL6D0Jkia_LN-saQcEQoQkJgKX9iPXBploPSOrg>
X-ME-Received: <xmr:PzWxaX46rKMWpV0qsqBfJ7JTsOX-bKrMhJOnLXEcMgHpM4ppZH_8hmsjXgBl_7JKpxPuvGIVqbEH_-cKP2BpH7wYYaO0FyPs2I480AHL-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:PzWxaUqf1IXKczdMsgakNWkcaABqVZ_tXR6liOsDf83HPLd55ZNQow>
    <xmx:PzWxaRjKPXFU_gzlFq2lQTOD5wKlLRz3TFABryYv8GYZVgAMXMY4iA>
    <xmx:PzWxaWIdkuM-OdeLQrUWxGAN5vKQL-wu1cO9jCiw2bcXS_T3jYCsYw>
    <xmx:PzWxaZCYx6s5YllO3Nii5QljZij8eOHcHTPRRrKy7ikw7sMcbD5ClQ>
    <xmx:PzWxaVFsaSL00YOMNoqeO-BEOWu7BlyBiwPaxVdH-tC_f2FcY_kcqPUu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:26:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 973984e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 09:26:22 +0000 (UTC)
Date: Wed, 11 Mar 2026 10:26:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 8/8] builtin/history: implement "split" subcommand
Message-ID: <abE1PPWRdPaHMaAs@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
 <20260302-pks-history-split-v1-8-444fc987a324@pks.im>
 <CALnO6CC_UMnQvcyCe37mCan8eASugknK-WbVp-KWXWptvrsJDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CC_UMnQvcyCe37mCan8eASugknK-WbVp-KWXWptvrsJDg@mail.gmail.com>

On Tue, Mar 03, 2026 at 01:47:27PM -0500, D. Ben Knoble wrote:
> On Mon, Mar 2, 2026 at 7:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index cc019de697..24dc907033 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -57,6 +58,26 @@ The following commands are available to rewrite history in different ways:
> >         details of this commit remain unchanged. This command will spawn an
> >         editor with the current message of that commit.
> >
> > +`split <commit> [--] [<pathspec>...]`::
> > +       Interactively split up <commit> into two commits by choosing
> > +       hunks introduced by it that will be moved into the new split-out
> > +       commit. These hunks will then be written into a new commit that
> > +       becomes the parent of the previous commit. The original commit
> > +       stays intact, except that its parent will be the newly split-out
> > +       commit.
> > ++
> > +The commit messages of the split-up commits will be asked for by launching
> > +the configured editor. Authorship of the commit will be the same as for the
> > +original commit.
> > ++
> > +If passed, _<pathspec>_ can be used to limit which changes shall be split out
> > +of the original commit. Files not matching any of the pathspecs will remain
> > +part of the original commit. For more details, see the 'pathspec' entry in
> > +linkgit:gitglossary[7].
> 
> That is quite convenient when changes to 2 independent areas have
> become mixed. Nice.
> 
> > +It is invalid to select either all or no hunks, as that would lead to
> > +one of the commits becoming empty.
> 
> Is it easy to make this a no-op? It could be done later if that
> suggestion is contentions. But I figure rather than error we can
> silently do nothing, since we have performed the desired split. (Or
> even use this to split an "--allow-empty" commit, but… why that's
> desirable, I can't guess.)
> 
> So yeah, probably for later.

I mean we could make it a no-op, but wouldn't that make the interface
even more confusing? You don't really split a commit in the case where
you select everything or nothing, as you'd only end up with a single
commit in that case. Making one of the commits completely empty would
probably be an accident in almost all cases, I would claim.

But yeah, if there actually are use cases for this I would say that we
could then introduce "--allow-empty" for this command at a later point.

Patrick
