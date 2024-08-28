Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C69176259
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849411; cv=none; b=vC3W+0G2ejujYkveMA8lNL/KHXXGi4re2LxP9V1b4YGFdAPKLr64AdrGW4GBQRlwVxV5098jz6e6cJ5COWtAyraSnFOstgwXsLvIeVsLsERhwoyjLmVLy5AEADaWKtAkpES2uX1FpaGpcM7coe+U3UJbE9KmkkYekdzfQACTKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849411; c=relaxed/simple;
	bh=gPNJGw2Q73gSXR9YZQ9dsh5sF8hlkbkYg9BZKUSn2Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeOakCzILFAulw2/8ySbmTwYL2OuHZekzsqocqL/F+wDgmo/5UI8MYTon4YQuwQ2UY6INThhdcQDdffDvlKUVn9V8j1uNZohNiJ2st3L+3G5oty4BT6qPKroDSXHZ+auvLS1yF7dzeiIDCYmT6/FE1IIICX/z5ZK3qzKMzLUUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fZWKKy84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rIwg+6V7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fZWKKy84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rIwg+6V7"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5DBDD138FFD1;
	Wed, 28 Aug 2024 08:50:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 28 Aug 2024 08:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724849408; x=1724935808; bh=LM1VgZbNUb
	Em1EEw3+PXaeik9zsgoCLYm9fbuM9/KJM=; b=fZWKKy84W6JOy9tJ9aVf2LuQVS
	wmmtnEWJL2SvYgOVbYKwuWW5vjJW2mziShpegPcncFHVZ4iRzmx4aeBy/OM/l5zv
	t6ekcbaDFZ105rNRqE5vr/EDF6BGq5t+jGp0ghWJI2676MgFKb3cDjkhsIqUW54n
	eGL/7GH/5ktdAsVyfFUJ0OGaOf6dpJmEfdQ8cboeRzKF7Vcs2BCD0Hp1iGMZ4y7K
	FjSaCR3d34MoupwBrX5FadbV9Giem1/xXuPyt17G0PsINoRRjaL+2lirasFO/siy
	Y1moJn7nEqfARW/JynlY2Mi8vbjo7zaLyAvqUfJAxvjltUr9rhZoWVsNfOeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724849408; x=1724935808; bh=LM1VgZbNUbEm1EEw3+PXaeik9zsg
	oCLYm9fbuM9/KJM=; b=rIwg+6V7K05q7UY9rWhLPvwUFB/DdynBtjtxw0YuNAOm
	mPr9tUwUyE5DiUuH9hz1rjbv9dDtSrxMvNy4ENNRlljmGq1rubpGigz2ZrJfDsGn
	Bd8vsvrDp5jpi9usA0GVGThF7ZYO8cGw0hBfyRP+2JmnDT3bcemyA7vxpaoaDWYb
	97ouFD3KGc9Q/WX8lzhLxOkiboNlKOpP5Yz6cSIVBCuFjwEyQyQzTGLj3iqmpXBl
	AhaYg9/HcMnNL7b+fYOVj59/aEBtAIW0LKLzVS0S1Ahn/ZfVDRLO92Kzpv2ZprEz
	yww8p3/ipjDSd1Gqk1uEdBXaMruAh6dI9pYJ6Ntyig==
X-ME-Sender: <xms:AB3PZjBQGAE8BUqrx_7CvAxvmuWgOgu-skcg4GhGT_nNXvKAve9c6w>
    <xme:AB3PZphgmyP1F4HFXEbQbPkuctmC0_QaSxD3pR2pJX_hqBiRYc12c0jlI3NbLS855
    U4v_tFvutUmmF4c_g>
X-ME-Received: <xmr:AB3PZukIcZXVdpCpXjWuqXwD9uZqX3VJHv9V9Fvx7FnwrHbRtGegv4aArirHAaPheTDB13-Tq1bFiR8-TYO_t8gP6Ehm5Lvxc4cDbvyZa4qs4J0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AB3PZlyN0bj_tvq2WE184hUAMKVVO3EYB0SSQU2ZRTDqEcWONsw0dA>
    <xmx:AB3PZoScTUsrgL38n6gDtBWQ4CmqY6DZeNFcjirXTA_2_CxW5rXRFQ>
    <xmx:AB3PZobYQA16gu3yKCdA3gQVoEmJMWw0J8p6aygXKYMzVDCwApznMw>
    <xmx:AB3PZpQmSilJ-g9JrC2Kh3uT7bFeFsoA4p8E9v8HJqPrsaajmdW6xA>
    <xmx:AB3PZuNz2jQw_pb-rbCksUeTrLNrtspRSHKpsq8nPo3PeJj7LC3nDhEO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 08:50:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d973e23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 12:50:01 +0000 (UTC)
Date: Wed, 28 Aug 2024 14:50:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zs8c_vuqOSSWJjpd@tanuki>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs353oLDaw2SbNQs@ArchLinux>
 <xmqqjzg1aksx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzg1aksx.fsf@gitster.g>

On Tue, Aug 27, 2024 at 11:21:34AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> > @@ -170,6 +173,12 @@
> >  `nullSha1`::
> >  	(WARN) Tree contains entries pointing to a null sha1.
> >  
> > +`refMissingNewline`::
> > +	(INFO) A valid ref does not end with newline.
> > +
> > +`trailingRefContent`::
> > +	(INFO) A ref has trailing contents.
> > +
> >  `treeNotSorted`::
> >  	(ERROR) A tree is not properly sorted.
> 
> There is no mention of "you shouldn't promote these to error" here,
> which is good.  But wouldn't we want to tell users to report such
> curiously formatted loose refs, after figuring out who created them,
> to help us to eventually make the check stricter in the future?
> 
> Git 3.0 boundary might be a good time to tighten interoperability
> rules such that we won't accept anything we wouldn't have written
> ourselves (not limited to loose ref format, but this applies to
> anything on-disk or on-wire), but we'd need enough preparation if we
> want to be able to do so in the future.

I quite like this idea. Jialuo, would you maybe want to include another
patch on top that adds a paragraph to Documentation/BreakingChanges.txt?
It should note that this is not yet settled and depends on whether or
not we see complaints with your new checks.

I guess another prereq for the change is to integrate `git refs verify`
with git-fsck(1), because otherwise people likely wouldn't see the new
messages in the first place.

Patrick
