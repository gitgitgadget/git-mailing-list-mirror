Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E92E630
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726636296; cv=none; b=Fzvq4ssh6Io91RHfB82oJ0D9FnAJVjsGBnqfPWsUUQvkm03mDAC7jLP/+h6/78v7DV0sbuo5BwJSzWu8Fp0rIcMOgJXtgQEzy5wh31d0J1FbwS9Wz88o7oXLpSt23HPy64ActhgDtke/DEz60r3yMPjBPrmXLMetpchOQGtN6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726636296; c=relaxed/simple;
	bh=a0B8vL8XDBE4fAQGl6FBSFWYSOC007j0l2ZJGKPw4+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIty0kKNZ0oDAr0V4UE5ptDwY5mL2gM4Q2UAEJ0c0z9r+yL02xKSfScJx4vyZ/9CHJUbM1HSJz8U+sfvgmy6M4B7gwBVEUKMoFGnULbOouQnOrbBo7342iHp2yZHZzVv20VTr71OwCGU7gQHvIpvcYL+RFRGeTp/p8kGHBOPOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UIFB3Og8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwImmzpY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UIFB3Og8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwImmzpY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 14A7A1380267;
	Wed, 18 Sep 2024 01:11:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 18 Sep 2024 01:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726636294;
	 x=1726722694; bh=+AM11uH+d++veDHcsQsPmFfsX2WMcnJ+yRQMiXMab/8=; b=
	UIFB3Og8f0wTznUqBNM+7WhExnXIC9z02JEu3DBNKoCudsByCrPMgvsmm7mMD8TE
	aTkFAKseuwmPOkt65PCFVukwwuVzCil7gG2slUYnlFunl96QIvFnxuu4+8K9V5qs
	sQ+Yz171Ju0pqX4aaVYseQaZy/pI1JnmDRfE5G7R0IuysPMfLkx9baCUOHVRkwSd
	cI4pZ/xqBvPCs44a2WUnRz5qPsaQrF78UT2Jz25WLE3BiFZqKx/Uu7M+sjw/p0YH
	nlTLXoAFCayJ9pDWFNhkuNVv2g6BtDIoU0rOKMhan5raOh1psQeYprHm4s5QzgGA
	TMZLPVc+t01v86GamXZhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726636294; x=
	1726722694; bh=+AM11uH+d++veDHcsQsPmFfsX2WMcnJ+yRQMiXMab/8=; b=C
	wImmzpYS8KRM6uZGNSbwgKF/M3lUdyqt7P8tnqLco1Lk5MoCel1PkDhqLCo5mF9f
	XDBobVgUUB423yEyKpxlvcLtqcpZBFUQOzFVj7ZNYyYaQhzas0wY77t4cXzwQRRB
	+mOclYWlEQAChSo/2rJlbi+s37/kfo4akmYfZM1U/dnPkPMeK8krSE5HcWQ/NM7L
	4OiBtI04EYUGqwZxeB9hsraKxdMd7fu2xRSpGk/dcB/13C2q4g0JegNKh5VQHYf9
	FujaIk5Y5RpvVsnoKiHldDxftGi4NQJPYF8b4sDor/qa2D4Uq4dsRVCgzYqbAQ8T
	e2cWDrjOrYGTPZBLlgdqQ==
X-ME-Sender: <xms:BWHqZsgqhb-6D5pls8N6puOVG4cBcf7fcqVgicoh6kXtP4gQft-02A>
    <xme:BWHqZlADeVjBSNbiVfZh4tP7vjqv-wtIGVxLPDMDloU3frL1TZCG_0S3Fyl09r4UK
    g5qjzW-cuuMCYsNPg>
X-ME-Received: <xmr:BWHqZkGhoMlHpNbpdbi-QSxfK9Ge3au4N56TI4jM84UBs5kFtg96cV7XRUb8i1aLWo_z7WCiNYii4Ik1q3KDRclmyOGanIYkNTWEaJcf7pjyXHwi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BWHqZtR6FHUFe2F45FRBzC5MfYhHV4WqhsuNF-l-ZqCVp2t34RxeZQ>
    <xmx:BWHqZpyIxo-1Ze3G8NbNYfNLLyxzfHfoCaTAaJoqiM6OhQMTQtcelA>
    <xmx:BWHqZr7u-k5bCII1esB8l7wtGbtl3oFhHUhbrfhcWEJyFxMq1JGPVQ>
    <xmx:BWHqZmzsG2FqkadrFpwEQTObBkZ5YLIyk6cQKG39qpPncg49p4nZ7Q>
    <xmx:BmHqZk-NxzaiHuiIZOlCylr51nzKDFlKxHb-hLfvEFZPbjYhVrh3TgUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 01:11:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d264beb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 05:11:11 +0000 (UTC)
Date: Wed, 18 Sep 2024 07:11:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] cache-tree: refactor verification to return error
 codes
Message-ID: <Zupg_VUWOfa_i7kU@pks.im>
References: <cover.1726556195.git.ps@pks.im>
 <1f13bc0e3259ea9b76f1417303a8ef063f3a7cbe.1726556195.git.ps@pks.im>
 <CAPig+cQ472dzChHKgrL_DNRe4KMNHNVxR1Qh3n6M=OgtBkG1+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ472dzChHKgrL_DNRe4KMNHNVxR1Qh3n6M=OgtBkG1+w@mail.gmail.com>

On Tue, Sep 17, 2024 at 01:05:50PM -0400, Eric Sunshine wrote:
> On Tue, Sep 17, 2024 at 3:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/cache-tree.c b/cache-tree.c
> > @@ -890,18 +892,23 @@ static int verify_one(struct repository *r,
> >         struct strbuf tree_buf = STRBUF_INIT;
> >         for (i = 0; i < it->subtree_nr; i++) {
> >                 strbuf_addf(path, "%s/", it->down[i]->name);
> > -               if (verify_one(r, istate, it->down[i]->cache_tree, path))
> > -                       return 1;
> > +               ret = verify_one(r, istate, it->down[i]->cache_tree, path);
> > +               if (ret)
> > +                       goto out;
> 
> Assuming I am understanding correctly that the original code was
> leaking the strbuf by returning early, I was surprised that the commit
> message didn't mention that the patch is also fixing the leak.
> (Probably not worth a reroll, though.)

It just wasn't my main motivation here, so I forgot to mention it. Added
it now though, so it's included in case I'll have to reroll. Thanks!

Patrick
