Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C85338934
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714034; cv=none; b=feJYUOeahNuQVdj9MlTBzYX0TMKZ2Vd0N8H64gbw6jGX56WnwQGQM7FCFKS6ti3BjbsbdoQrGtwifsp4S8fkQ7MqgmiFQmg1Dx15HhkPtky5UFF84QRenrgoqGIbhAY1YUG2dQGSljnXv3iEluDy5l1xHIl/shtjyU7BYyqiNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714034; c=relaxed/simple;
	bh=A+UenSIL6gdc2ARnzGwBPS+E2KUPY900pB3PCFtHjKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHK01nvVObawnhZKEIwTtE4gs/9CdnpIearMjewEd7oLdcG8qbeUDqzvKmofYQ5PyxumLiQiMRjDJv32Y8G1nbKD+5w6Rb7gyq69Bi/rQfffzqssyPoCqgoxYWSWqwE/J0wWVPKnhup7MeqP+T+7jtuFbmX7PW5GQQfbO0z0W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T+yPTTjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bMgluFnR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T+yPTTjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMgluFnR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 457391D000BF;
	Tue,  6 Jan 2026 10:40:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 06 Jan 2026 10:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767714031; x=1767800431; bh=oOV4vi07qm
	iLneeQfW3r5v82RkO7x+XQIKsvB81HGHU=; b=T+yPTTjxMaq3sUsH7AxakMTJXO
	JB5Di4oljCYu8oEnS4eJOexN8MUZRBk9hbx+WUTL01XbKnkZA+A002NIiX+PSo4j
	TUMLL8Le9WGME3UW+9jQ00Q5hKF6gkH3qDw4XStLH0du2PZgsYwVwt5yzyvv1o2C
	6/falk93xSmtW5zWLqGcSgZ03HgI0W6bq04+U6AbZCccE8a5Ag9OpUhLCpbAghWm
	7NnSJsLml2EM26+069mffS04W1lnB8j3e8/LIPTeb1eJfia4UaJcMNy/1ZUqewT2
	npAnXsBVtI4FhL3zoEQeGOEVvDmsD3X+hqwhq3YccBjfaKuL6wXhBdtvKyvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767714031; x=1767800431; bh=oOV4vi07qmiLneeQfW3r5v82RkO7x+XQIKs
	vB81HGHU=; b=bMgluFnR6ulLb9fvp22cTO6KW1xL8bmsDMUNC9NYQsE+kK4jL/Z
	2b21pSxr3MB2SdoRDCATar/7a41TghUu68o7dczU57ACEBKwb8dQG7oUCHtaaXR4
	eMnVQsm2uwG1lhSFvRTh3Iz39Na+MKR94k3ky+W6nGVVXOIKpPTaz9Zedrtob0wo
	Byoll/wH80bCCZD86leHkWHl1D+whDArvIWdixnuMPBnDFqlj0qx0SDRqTbjdFs3
	VWiWgQ4qrAgXl5XFx1oIyjJbvca4Fnpy2C6WDxCD1VnniqyrmPrNl2Gzjdb9dt8P
	EM4cv2MwFoo+GoqPWyzpRj+gNnFZCoQOCIw==
X-ME-Sender: <xms:7ixdaQRvQKWAzd2i9vC3ya-d4Wvz0xB1czNd9EvU4CI8GZMzLKgOGQ>
    <xme:7ixdaedKjJ743Mf5glDMc91-E-eg-Bkgkxzv10Bsl7klrCjDYd5WOv0aOZzv1AbyT
    MYoFkW_O_QrasV9txblxtwIUSjL8WoFXFmjKkXCViDXQjaPLl7-7w>
X-ME-Received: <xmr:7ixdacBCsDNmJ6oJ78iw3Ct1RUmLYMXBmO_KrdEDMkDk1j0WPvEKdAgi1pAyqwxS6rGfsbd-dHIiUDkWpvpPWO2TxhdXp7fnOb3QSAGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgrshdrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7ixdaYlLUrnYdH1Tcq1Ca3Rzl80YZ4LCpL_e9rPT2uEPQ_bkT5hEpQ>
    <xmx:7ixdafeaDbzZPCrwBUjsncvAGuu1kuPhXkoEaWH7KzJ47gYhUnsRJg>
    <xmx:7ixdaUTgIefzu-XjBRJVHXItbwYTldDysY-FBYfHPWQpn3oF2aAbTA>
    <xmx:7ixdaetSJiOn6aqMdgqwfcj-fNSEG78RtPjlzNDcYaEAhGsOa9pAng>
    <xmx:7yxdadet-Ne7oDQ_e2ncZOUolAZ5Qo5Zjl_-8qSPouNPVX7failA6AZf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 10:40:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e3b6952 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 15:40:28 +0000 (UTC)
Date: Tue, 6 Jan 2026 16:40:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthias Beyer <mail@beyermatthias.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aV0s6cFwPFQ-Pmhj@pks.im>
References: <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
 <xmqqms3qh13e.fsf@gitster.g>
 <aUVDax0PbkaXGB61@pks.im>
 <91bd9241-96c1-4b34-98a9-af3bad345c4d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bd9241-96c1-4b34-98a9-af3bad345c4d@gmail.com>

On Mon, Dec 22, 2025 at 10:46:12AM +0000, Phillip Wood wrote:
> On 19/12/2025 12:22, Patrick Steinhardt wrote:
> > 
> > But in our case we're not working with ranges, we are working with a
> > singular commit. In my head this meant that we'd have to basically do a
> > revision walk that starts from all of our branches so that we can figure
> > out which of them would eventually reach the commit that we are about to
> > rewrite. And that of course doesn't scale.
> 
> I'm not so sure about that. In repositories with lots of refs most of them
> are likely to be tags or remote tracking branches rather than local branches
> so I'd hope that the number of refs we have to walk was manageable. I'd also
> expect the commit we're rewriting to be relatively recent so the revision
> walk should quickly prune any branches that point to commits older than the
> one we're rewriting which should further reduce the number of commits we
> need to walk.
> 
> > But now that I've thought about the problem a bit I think we can avoid
> > that issue by implicitly identifying the range: it's all the commits
> > between the commit we're about to rewrite and HEAD. So, same as with
> > git-replay(1), the set of branches that we'd need to rewrite is any one
> > branch that points into that range. It keeps the UI simple as the user
> > still only has to think about a singular commit, should be sufficiently
> > fast to compute in most cases, and it allows mega-merge workflows like
> > JJ supports.
> 
> I agree that users should not have to think about commit ranges, but using
> an implicit range between the commit we're about to rewrite and HEAD will
> not rewrite all the branches descended from that commit, instead it will
> behave like "git rebase --update-refs".
> 
> > Does that make sense to everyone? If so, I'll revise my stance and will
> > adapt the current implementation to do exactly that.
> 
> I'd much rather rewrite all the branches descended from the commit we're
> about the rewrite rather than those that happen to point into the revision
> range between that commit and HEAD as I think that ends up being confusing.

Yeah, my next version of this patch series will do that now. I'll
probably send it out tomorrow.

Thanks for your thoughts!

Patrick
