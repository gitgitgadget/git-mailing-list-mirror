Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E91FE471
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341066; cv=none; b=L6R0t2maGir/AzTJTSso53gFLuhZA6p8FYghLJwTUTSXH+GTyfXw3uCR5wmtCt9wx246glCYAMQ12YfZbvIEgnxuemoYIs37LEtXXXtMvimeZnAbYhjdJyn+yMgtBYyjmVxt2HNBlCbo1ZwZUCSAEYV5PxDLzpOxgEWtGoeilqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341066; c=relaxed/simple;
	bh=hT5Z7JwdAcdhtRX0oiiE/UckUnsreX9rLiKNSNIdXr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzw7/hh1Vw0ZvODS6xgPt9XuyrjUdK4W+3eKz8tWOPLQVV/8WFTRHae0ldlt06hwQm3D/XqqXsI01lwKv3M1yq8YUWqWDUOWBLU5dXqCWdagSnPdqOg0nqyWgtyREZZlx1lvnIHjhePKO2mlMg01pez+k49ZV0KexJWbzkfoW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z0Duobxt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e93Aw8I+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z0Duobxt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e93Aw8I+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C7CBEC00B4;
	Mon, 10 Aug 2026 01:51:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 10 Aug 2026 01:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786341063; x=1786427463; bh=d07AZkvsqw
	LrUIaBC6K8i94y7bE3Fs8BlUV/7eQOYHA=; b=Z0DuobxtIEabRDNuBeK/GdYoH0
	Q10YSQsJZHIT5HVu57l9BHBjRPuxAYBEEHSdvXxZmQgr0kwPVs85iSKe+XKcR6eB
	sLXEt+40mZXodd2i5d152sF95D0Ym3FVeq+mhDN5fUhyp0W2CunORq84AJs24/Am
	luMJbAco4x6NZSo9+Lpz3+1mD9KxWHdXNjzEvuELIHbHCCbom7+qcb6zIuS+vEw8
	zH1CtfZ7fp6rQZrXWI9dHLaA0KPoxBIAieyp0KlyrVaerjc/+1OviANFSvlOlIVW
	0Icw7RTdu0+Src5r7nBJrkGONbvqSZl9KqmJnxjwDTME1a1PjgISWEPjZLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786341063; x=1786427463; bh=d07AZkvsqwLrUIaBC6K8i94y7bE3Fs8BlUV
	/7eQOYHA=; b=e93Aw8I+UhdHldrRmsEK7JZgKOoYxBjUTCO9SlQhitlSeeNysEC
	CZy9iriO6GfAbNbLbz/2l3yckJmlRwJjCDBhdUvlPJJB3d4DrIHxnXxA8Lm2wUYh
	wp09QqQdMZfYV0A3o3mJqHh51emLU/T+WZJdIGxruYD9DJde0BlBVzMHKuNxjfS8
	WzqzQw+yoT+TfBUxkzNeIkWkGbsxbRSKhiGAw0ugcC86RqRSzc6r2QkKM9rdtnFV
	mu7cZs7yGrc6L9TXz7n9m+j7VnMq6J3wzs910b6FB9pbpTqoljfbuNJ8mHweZB4e
	MJqZDTp8U5D1hftRBJaMqt8qZzBe0UjmPkQ==
X-ME-Sender: <xms:x2Z5al9xJRQ5VxA4p24Pv77ySq4k_IGkBmgStrMfyFse9CFdP7td9g>
    <xme:x2Z5ahKXMs-gDhzMf8eHSGjI3pNnBvmTrPjDA97ab-ViHd51GprZxX-gae6kwA7Gu
    M6igdiSbY83w3lPSzvI-e-1wznlgvSPA2OZwMem_OP4FwzDIjMAgGI>
X-ME-Received: <xmr:x2Z5agaHWsEZcvJBYxS7M7zJ3sAAIyWO30rM2gKlEoI7eXuCCH_baWvGA0sRcJ4Ad8_PdQOSm5c2X1wrtT1cHh1h2lkXRfCw7NVPi7YZPw>
X-ME-Proxy-Cause: dmFkZTERQi+x03YzTyJR/t5dFxQU4YAUNzzc6W5OawDIRRgH7uW1Q4q7L3WS92DYoF8N9X
    r/UBBclgCkHUK8ordgxQdTSK13etDBig6mpxwbgsT+acX7jK5pqQ9DhdCMxdUxc6AgNikt
    X30HegqpaMjyq+GohpKOuabsz4xPJHcdo4py5RlZA+tLBlNJIwJv3FvpJdhtiADaJ/7n95
    /8oi7LidQWM3q/KlHwJPyfO6od/dqAuarSHY7JrhbqmIOq3Wg5Yv591zXSpY4P3cTrv0Cx
    bN66Wmbn/NfkHx5OnjYzYgzKQAdiFZATZnD/Y7a3oBuTVDNaFQcEWBE9fTKrj/r/ELG8aX
    iSuQ9h8fQSJZhiympXmh+h7whj2TqlpLZE6C83vOwTn7VwPOQv+zqjjsGUJUWZCHx9n7E0
    gliVUp6TkV+A7afPHaX/Rhot2CdiaqV2qrcHWC49mAf7D4jUEcBBLbQ2Rny28xOjAzfQ1k
    ENaVeKrx0c6YGX/pQsg3mNuJF8e87Qulx2pv9QwCHkIfT84OjoowcSPXoZ7/m0Vni1wfNq
    /GWr/L5ulaDo0w7lEQRUaHCizJ+Cl9NlUHES0ss44syQOIDlcquBBb6CDw7oijpAamqAAy
    QlfrRxnPRA3IJMqbJKmNEVYSy/k3EhPVFFicTqACjkCVtDb4x+NvaTVt4M2g
X-ME-Proxy: <xmx:x2Z5ajJlLT_DqACQTRo9www5OYGAnF8io2mxvjgf1TN3w55-eKDSEg>
    <xmx:x2Z5auB9uL_YHmuSd5C-mq-JcmvA375cleaJYvB6Qy4Gro7lkljnOg>
    <xmx:x2Z5aopZtrfVCqZku9Dt3hnNjedmgBM5AtX56g-Wud1WL0fkD3CY0w>
    <xmx:x2Z5apglIbI3xb67XzH2C8_myEbbnE3Be4u6gR9jJYcaSDoc8Co17Q>
    <xmx:x2Z5aj1na1iKqn9QOzQRO7RZ19rcsnqFbH1zWeLbhWK1d9nfFpxNQbJw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 01:51:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07135112 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 05:51:00 +0000 (UTC)
Date: Mon, 10 Aug 2026 07:50:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] environment: clean up repository config handling
Message-ID: <anlmwaEtwcCPse1N@pks.im>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260807085932.3958759-1-cat@malon.dev>
 <anW7wHfUxYj9cj0P@pks.im>
 <xmqq1pc9eivn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pc9eivn.fsf@gitster.g>

On Fri, Aug 07, 2026 at 02:11:08PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Aug 07, 2026 at 04:59:29PM +0800, Tian Yuchen wrote:
> >> Hi all,
> >> 
> >> This series contains several cleanup patches for repository configuration
> >> handling.
> >> 
> >> No functional changes are intended. The patches make the related code
> >> more consistent and easier to maintain by improving documentation,
> >> formatting, and the organization of repo_config_values.
> >> 
> >> RFC:
> >> If there are other small cleanups in this area that would be useful to
> >> include, suggestions are welcome.
> >
> > Somewhat unrelated to this patch series, but I was wondering whether you
> > plan to drop the limitation in `repo_config_values()` that requires that
> > the passed-in repository is `the_repository`. This limitation is
> > starting to create problems as more and more of our infrastructure is
> > migrating into `struct repo_config_values`, so using a different repo
> > than `the_repository` is starting to become harder and harder in our
> > codebase.
> >
> > Thanks!
> >
> > Patrick
> 
> Hmph, that is an interesting point.  What is our plan to really
> enable the use of repository instances other than 'the_repository'
> here?  They of course need to be initialized with repo_init(),
> but is that enough to sensibly use the embedded 'repo_settings'
> and 'repo_config_values' structures?  (By the way, it is not
> entirely clear to me why we need both and how we sift variables
> between them.)

Yeah, this split is adding to the confusion indeed. I think that we
should make it a goal to unify those going forward.

[snip]
> In any case, all of that has little to do with this series, I
> suspect, unless we are redesigning these configurations and
> settings in such a way that they are not necessarily tied to
> any repository instance.  While I do not know the exact details,
> I can imagine a hierarchical system where system- and
> user-wide sets of setting values are known independently of any
> repository, only to be overridden by per-repository settings
> using a last-one-wins strategy at lookup time.

I've been wondering for a while whether we're operating at the wrong
level here. Both `repo_settings` and `repo_config_values` indicates that
we're operating in the context of a repository, but as you mention that
may not even be the case.

I don't think the approach is inherently flawed though. From my point
of view, the best way forward is to merge those two and then generalize
them into something like `git_config_values` or `git_settings`,
depending on which of both variants we want to retain. We would then
have two levels:

  - One on the repository level as we have it today.

  - One truly global variable, because that stuff in fact _is_ global.

We'd then adapt `repo_config_values()` so that it knows to populate
either of those variables depending on whether or not the user passes a
valid repository, and returns a constant pointer to the respective
structure. Callers MUST NOT modify that structure -- if they want to,
they'll have to make a copy and pass it down the calling stack.

The last part about not modifying that structure could be quite a bit
painful though, as it would mean that we might have to adapt call chains
to pass down a `struct git_config_values` instead of a `struct
repository`. But arguably, that's the right thing to do anyway for at
least some subsystems that are independent of repositories.

As you say though, none of this is really related to this patch series
at hand, and I don't think we need to resolve this discussion before we
can merge it. I just want to make sure that we have a plan for how to
get rid of `the_repository` instead of only shuffling stuff around.

Patrick
