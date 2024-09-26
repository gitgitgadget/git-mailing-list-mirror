Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836B1798F
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351881; cv=none; b=j4VNqMxIIRMynRhhy4ePJdjne5yAzgB6n04MCcxg7PnHtHRmOPvgNRBwnq4g+2W3E9Jh+VYIlKENdSABYgcxe640QFpbAOADbcdomMjCg6Hnb+JzQs8Qksqw3+3I3A7eohFEKvC0uE7o1QQZsSx7rh68eM92i/Bmy4mSu7aPdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351881; c=relaxed/simple;
	bh=UAUBF4Q1e31oGxDEeCHtRMicz7SzA32ar0yJyJe80OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQOOF5hZS0fSWBR78ssoowosE8w740fvnq/occex7LEyXNfppLvfXqYafm/zRgbFt9ZfbwuWtWrBDue7FeG5QxfzNvIMT9jPbiMNdMFkQ8Bmn8iGMH8NNUR4Ajnq/bfjSRIVHdxoNWQp+0q/d7mZ4Z3DVbZnJrJeWk/Q2dF15P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OC+N9lfC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U7tNGeWQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OC+N9lfC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U7tNGeWQ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 149791140287;
	Thu, 26 Sep 2024 07:57:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 07:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351879; x=1727438279; bh=ht98mdNByu
	miTjQ0Kmtrnrd5W1dSKdAMm3oNh29Xu6Q=; b=OC+N9lfCYLH9TP3k6W8B54d3kP
	fL44f66VM/esPq20OlcMsceZ0rsGTxVjrVT8WAmjm5t5UMRO1Ki5TWoo9pS4mDyo
	SOgWEk7WvFCDzBgAcljcCbfMl3lHI52c/m/KuxUcyKTUqChcNe+CV1svTEeaice6
	3L94G4lwSLcq6UB9WqYCxysei00sk1BGBqjI4xSeufO3chYk+LxNgFha7BwczaV4
	Rr399Vv5LR2w30qDjfZ0ukQZQgRz10Q4nZfNY7bDm8UxAe03Q5Mx+/Nypq2VB9uz
	ehEf/pbQQxi27SENEgqYuSBHh5bbw2mfIR3rvjLZM/+0TqfIXbyJIO4FlRZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351879; x=1727438279; bh=ht98mdNByumiTjQ0Kmtrnrd5W1dS
	KdAMm3oNh29Xu6Q=; b=U7tNGeWQH65s0pYbvuUrevGgWAPDkZfiPz1HOXs8s/ne
	rHxxLMBY03pnltwJ22qMZ00lUYrBjp3IF8EX73OCqTOVD/DEEmEd1g2UyNGfpugC
	pCZOqyS+yvtPianA4mzA9/FFGTV3ZBk2fzbuf6PqAXrL8yg1/I35yTnHIs9HlueH
	bMNipn6FCcqtlPDMIoU6K5tWysWLsnfJttnudR9JJ7N/qrgUzWmCA0PRHimwlpQO
	qi9RPTPQrmiK/Y73oHqXHjby6YPEdVEtAJsR7FmhX1VQIPqg+LXnfaeaGn0eUzDP
	7uu83EU87EV10WiDqJGJ5m6haLxtOvTyLK73vsIWZw==
X-ME-Sender: <xms:Rkz1ZhdC7LHarKEMiqBfTcN7-vLIO5Xaue1JP-QIhtqIN5KsELrbsA>
    <xme:Rkz1ZvPpIiwVvWnyflJbOKxzxZTqBfwROsFZwjaBMWpW7cPl_LSa_6sVUL7mwPiDS
    HW4iSi2_g6X-_M9kg>
X-ME-Received: <xmr:Rkz1ZqhGcoZRIOU4G9EmwpUTb20ELesvkGQxwirCiydjpBSznQ-VjfIOsnTKm3H4V1EkN9YmCXGxbSyFfmDBbTTOdx-UqizjMExAwouiyyXgZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Rkz1Zq9x5gHO05hEf9a281GvzFt3WR-mpTBSQbZs6Ndz5WtHvfTXkQ>
    <xmx:Rkz1Zttl2aT_F3_i9RJ35kOb-UgBBoR83_30kaGXs_DKwgQaJ7j0XQ>
    <xmx:Rkz1ZpG83dJRPhc62eGlvi4Kr9or7I81zi-a1qvZ1-NbZrN1tubW_g>
    <xmx:Rkz1ZkMhHQa20VtLYowUyHeqKfGwfExCSU-zTSNLpwJR9tJ8WPO2zg>
    <xmx:R0z1ZrVjWbnHX-22rEYCnP-ufQa94JOiY6eNGGEv_RuR_97GRPOPnphx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:57:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bcdae53d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:57:18 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:57:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] BreakingChanges: early adopter option
Message-ID: <ZvVMNMiyjd4xfHzY@pks.im>
References: <xmqq7cb77810.fsf@gitster.g>
 <xmqqploydn7j.fsf@gitster.g>
 <xmqqtte77f0n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtte77f0n.fsf@gitster.g>

On Sun, Sep 22, 2024 at 10:51:52AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Discussing the desire to make breaking changes, declaring that
> >> breaking changes are made at a certain version boundary, and
> >> recording these decisions in this document, are necessary but not
> >> sufficient.  We need to make sure that we can implement, test, and
> >> deploy such impactful changes.
> >>
> >> Formalize the mechanism based on the `feature.*` configuration
> >> variable to allow early adopters to opt into the breaking change in
> >> a version of Git before the planned version for the breaking change.
> >> ...
> > ... to see what it involves
> > to allow early adopters to experience Git 3.0 features/removals
> > before it actually happens.

Thanks for putting together this document! We also had this discussion
during the contributor's summit, and I certainly agree that having such
a toggle makes a ton of sense.

> Sorry for a long monologue on this important topic, while everybody
> is away.  Hopefully we'll see more comments when they get back once
> the week starts ;-)
> 
> > Switching behaviour at runtime with feature.git3 should work well,
> > and we can also add tests that checks the new behaviour by doing
> > "test_config feature.git3 true".
> > ...
> > If we are willing to burden early adopters a bit more, we could make
> > it a build-time option.  With "make GIT_BUILD_FOR_GIT3=YesPlease",
> > binaries will be built for all the then-current Git 3.0 features and
> > documentation under development.  It certainly is a simpler-to-build
> > option that is easier for us, but I am not sure if that is acceptable
> > by those who volunteer to test the upcoming big version.
> >
> > One thing to note is that depending on the nature of a change, once
> > you start using a feature only available in a newer version of Git
> > in your repository, the resulting repository may not be understood
> > by an older version of Git...
> 
> While I still am with the position that we can do this either at
> runtime or at build time, with the trade-off being that it is more
> costly for developers to do it at runtime and more cumbersome for
> early adopters to do it at build time, I realize that the last point
> above is unrelated.  If one or some of the features behind either
> feature.git3 runtime option or GIT_BUILD_FOR_GIT3 build-time option
> makes a repository inaccessible to versions of Git without these
> features, we have the extension.* mechanism to make sure nothing
> breaks, and testing that such a Git3 feature is properly protected
> by the extension.* mechanism is part of the early adopter testing.
> 
> How much more costly to do at runtime is still subject to further
> analysis, I think.  I know that it means we need to build and
> install the docs twice to support "git -c feature.git3=on help", for
> example, but I am not sure what the best way to use CI would be
> (write tests that check features with different behaviour by
> explicitly running them with "git -c feature.git3=on"?  Run the same
> set of tests in a separate job that has "[feature] git3" in its
> $HOME/.gitconfig?).

One problem with runtime toggles are commands that go away entirely. We
can of course hide them away in various different places and make it
impossible to call them. But one of the downsides is that it is not
"true" to the actual removal, as for example the dashed builtins may
still exist.

That makes me personally lean into the direction fo making this a build
time knob. The big downside of course is that we'll have less exposure
as almost nobody ever would build their Git in such a way. But the big
upside is that we end up executing the code exactly as it would look
like if it were removed, so the coverage we get e.g. both from Git devs
and from our CI would be much more telling.

Patrick
