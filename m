Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31B3C3BF3
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595061; cv=none; b=VzH+oPeNA7ZMvKP6shIJ+fUGGt4vFkDYDh6DTBqtPc8NqSsa806BfBVFBMCn0wJfENRALzrl4oJTXCG89OHcMKopLWdYF8rsnArx0x3eFcQCY/sNqrHtn7xU12IAjhFs5nwvIvzNZnlb1nLPTstSTMcQfj5gWBKrD7m8E1I/qYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595061; c=relaxed/simple;
	bh=D5TImQUEclS02i24LTm+X6w4vYM9I3ssLAskc36EQTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9GIGBuCdaXgII/ZKx/nco1ZgTlfKn+fXpRZhihiTEjz5klvIpLVEaPOH1b4TYvvXhDNAJMjqLGocOWxz2R+fcylR1C+v50Pfs4VZZjBZF/0wS/RKZJXz9h08uUnC4DkSQQNuQOxtutZ88OGl73ZZI3e41s5+dpJgE109aJxFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vg6hyoVo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=33GbqNx1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vg6hyoVo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="33GbqNx1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C7C51EC0267;
	Fri, 27 Mar 2026 03:04:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 03:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774595049; x=1774681449; bh=3D9ObeSpY/
	kveXa1QbZ7/Rx3p18RFJ0mumkSq7lPZ94=; b=Vg6hyoVoO/vJ82xqpl2x6zRIH2
	Svtwv1zC2LWUuhYjrYriYtyABs1k1divVYSip2VJwAEemXsOBCUPOAepKH5n0Mz/
	5q0CT5pkgiWoCBAO3q+ZdRuovvZzhTjw17iN2x+QhtqbKae8erxJm+h/G44YEQoR
	6eiYjd8wZXYNHDraAunzVVpttjG1Kba5xYMQs9iR1dYOdE9Szr/Ldi5Ppb/CiuZV
	HwspEbRVVOzWsyymnBeQG1uNyJ6o9DVzFF8oMMQTn80IueUvuRqYKQQ+CW8oTZTC
	+E0XWF1IcIO00aHGgG5G6HJ/LDwZyV3ATgiS1MqPte5PulYlkmLsDKkAHnFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774595049; x=1774681449; bh=3D9ObeSpY/kveXa1QbZ7/Rx3p18RFJ0mumk
	Sq7lPZ94=; b=33GbqNx1nqYYQDeDl94ICFm6P2pJm/45JHk4fGhYfBC4gxPbXBZ
	Lew4xori6MDiszq9FXsLhNtyOcL694pPQzol/pubHS0X014uCUYbBh+cIG6/E5po
	0wfMEfW74Q887AH8RnITaYz2QcSbdDETf4i2BihQkPxBJIDAS0kIZzWrzOiOLztk
	guGRQrgub4H+Ez7sWmuzEGJo/DB1JVr1wUVVaE2zXSJIyAQDY5E6aORLNikL+M/Y
	U7EaGOPXPNo3rUevmAqt2x8DzgIW5mmFy6hDyNQc/eVi4WBOVFec2Q+K2PohqiVI
	0nZ8pkXGjqcbSXAoW5rI2IRVh8pR6wUO3tw==
X-ME-Sender: <xms:6SvGafWrzSLaQWAZqTND--xxkl-oykXy99lAbhToYbpeZr_QCpXCVA>
    <xme:6SvGafBMvke1Mjn_5LoLGiWC-Fhh13mzlW_Cp92uRWMkZO-VZmrQkartQkOY3Y2yl
    z0AE0FIwXsNB6aRTPJD3FGG709ejwFYKvIGn5m7wxCefmNZbZ-K3w>
X-ME-Received: <xmr:6SvGaYxq5MZ1znu-CCWVfSEk03E_GGF-pH1Ouco-MGEiFbjh5SzM9-RzKIZUiKJh3RV4usNaHz3A2p7Mbi9n7aW6hqfT5h3WfLWP35eYHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghprg
    htvghrshhonhesphhmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:6SvGaUCp1XCNmrYBOgxeVf3rme_mBXk855YDt3eJgVkMxIHK2j6Jwg>
    <xmx:6SvGadYLavLp9B6lEOE8YN0jcXEUw-cjjAYiFSehCaRA-iNo4kd3Vw>
    <xmx:6SvGaUjPogU6Kk8sZvCWNo2mg8r-ez4Q4JpmQQyFo85X6KaWsCPlwA>
    <xmx:6SvGaX77v6BbYULFhsGj2g-1CoVG8jINwelwja5KGer_41RdJX45uw>
    <xmx:6SvGaTCDA5e82mS3yJncnNHviXLbBY08OA_tQwxxqXW01q9hlpU5LTDi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:04:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c753d47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:04:06 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:04:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: apaterson@pm.me
Cc: Aaron Paterson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] odb: add write_packfile, for_each_unique_abbrev,
 convert_object_id
Message-ID: <acYr5DZTPuOlyxvi@pks.im>
References: <pull.2074.git.1774530437562.gitgitgadget@gmail.com>
 <pull.2074.v2.git.1774532383055.gitgitgadget@gmail.com>
 <acU7eJ0MpUVhCs6-@pks.im>
 <DpRTZzuEPU7m8kvCckzHYEK380REXLfunHXO4hE3qgAZsKPSNtyqkBT2oRzusMxvIDgLVkt4FOis0HKBTEJPIRQgcbYM6QZdpzN6-Y-F7WE=@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DpRTZzuEPU7m8kvCckzHYEK380REXLfunHXO4hE3qgAZsKPSNtyqkBT2oRzusMxvIDgLVkt4FOis0HKBTEJPIRQgcbYM6QZdpzN6-Y-F7WE=@pm.me>

On Thu, Mar 26, 2026 at 02:21:07PM +0000, apaterson@pm.me wrote:
> Of course, and my apologies, gitgadget is not formatting these
> messages as clearly as I would like them to be.
> 
> Both this series and the last were adapted from my fork that supports
> [1] with a feature similar to gitremote-helpers. My hope is that the
> fork can converge with master so that sqlite-git can become
> redistributable. The local backends vtable was already a step in this
> direction, so the question is if letting users bring their own local
> backends, the way they currently can with helpers for remote backends,
> is in scope for git core.

Thanks for the context! This also matches with our eventual goal, even
though we rather envision that it makes more sense to maybe use a plugin
in the form of a shared object instead of using a helper executable.

> Either way, it sounds like series 1 will be covered by upstream, so
> next I would like to contribute support for git-local-* helpers. This
> allows users to create .git repositories with storage formats other
> than packs and builtin alternatives like reftables, which seems
> appropriate as direct sqlite support would probably be out of scope
> for core. Local helpers are already implemented in [2] but if it makes
> sense to hold off and rebuild it after e.g.
> ps/odb-generic-object-name-handling is merged, I am not in such a
> rush.

I've currently got around 10 more patch series pending that are mostly
ready to be sent out, but that all build on one another. As said, there
is a ton of stuff changing in the area of pluggable object databases,
and I expect it'll probably take two more Git releases until we have
fully carved out the foundation. Once that's done I think it should
become quieter, and at that point it'll become easier to also do
drive-by contributions without requiring too much coordination.

You can have a look at [1], which is our (non-official and
GitLab-specific) epic for the work that we have planned over the next
few months. Maybe it helps you a bit to figure out where we're going.

More concretely, next steps will be:

  - I plan to turn in-memory, loose and packed backends into proper ODB
    sources.

  - I plan to introduce backend-specific consistency checks.

  - I plan to introduce backend-specific logic for optimizations.

  - I plan to introduce backend-specific logic of generating packfiles.

  - Justin is revamping how writes work and plans to refactor existing
    callers that do ad-hoc transactions. This will also eventually cover
    writing packfiles into the ODB.

If you'd like to get involved earlier I'd propose that we sync off-list
to figure out how to collaborate without stepping on each others toes
all the time :)

Thanks!

Patrick
