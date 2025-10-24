Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F452BD03
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284734; cv=none; b=nSX+VA3oY8s0vm1l275gESslNV6jaIBQ58P3c6lfesqg7+WZCVUGWxl2Yu6yHcuxQufj7gvrtVjlii0yaCRI4rnq+kZV7ljwebU3FPpUHkGF3RG4XqOsDZ0qZ8GBwmcltudm/nKPlAue3EjvaqSXeu08mRY3n8MHHZXwqO5cWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284734; c=relaxed/simple;
	bh=BsjnGCuZ1IiRRRRs4BUKEQ+ITEJpFOiPMNT6J1ddy7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2N2KLxDh5Z0WWJ+J2CUk7GSZDrTpGi3+mcPtlHVWx6IVaLP/xiCNa0Am0ZxHBLZ+BRT0sqWlUFjASAoVXYEMj/U6EHc+T1XjGUeVrmPhQv+bBlrQXWq8VEtX25ScPvboWsTZnz8/hVAWe7rRmvbNo0epdh18ixRm7Sye6WFR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=epUhXkGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbqxI9Wg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="epUhXkGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbqxI9Wg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2FD87A0062;
	Fri, 24 Oct 2025 01:45:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 01:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761284731; x=1761371131; bh=hmeGOQ2X+r
	Ub8tpT77VHV+aSk/0WUKHWAw0IWZXUV8c=; b=epUhXkGs+zMf4+UHc52jvbIYvq
	08wrbUhrJWmP7LIsAM4F6w55SFrkOZ2bfUrGojIeNiSZxHCfEqOeB79l5exvH1Jl
	KaYI18e9wOjpsCZOL2xzS3zWxlioA/72QqVeQl8ZnxrkUrfGMRpEwwK7rwZlGI7C
	azyTB03r/9I5MAw4slDDhrYaSX5wl1NizhQaPLh3fk9woy4QbPqKLJQGxME8IpX1
	v8EIqqnTYoOMFb0/J/pjwKUHudtqJ/5jUoEKbD2mNkViblM8g33/tqMOW73VJk/O
	rt0KkddFkY3LslErVVC6NXgLwT+VBqPac398kCGjFlMtbAEQ/kKxBziGVhfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761284731; x=1761371131; bh=hmeGOQ2X+rUb8tpT77VHV+aSk/0WUKHWAw0
	IWZXUV8c=; b=qbqxI9WgZtZXVn2X9NJlua8cdui4LufyHQMbr+C4MYfX/wJ9QA0
	WefOY5zuZOchQmanC6sUF4KPTXPHRGlZ3f93rm7rU86iwkyG5GH0iAGZV0GDVhUL
	yUeIav/eSDnkB53/cy57cICC2VY0pUNm4HZewXFkvoXQnut6iJQYQGVS9eypcjur
	bIBRBbUPnbwX40bk03bln8jRDIAgCg94aa6aLxKc1qvk4yRWnPg4OTeY/tTeuBb2
	f/9L/O64d1veFbvg0vgCsRngLsk0nnV5hiuijA8H4FKhQQSFWetmn4lQ7d6acqSM
	MTYdy2Of1gNkh1b3EvFR0ttn67cWodu8B/Q==
X-ME-Sender: <xms:exL7aE_rpIwcfrgK7eQ4xMuQKXxw-0Exf_FcFnryaVkEJuM3SQgO6Q>
    <xme:exL7aEIiRy4Yp9RpnIqmOZZm7LinSTUGFVaCWvUqvtlJ2uU3rW0aly41yzDiFE9PQ
    5_vXQLKKAU4Vwf04bhe9k-KuJKidL-j6-oHJ1V7vFAhX5ryEnNQ>
X-ME-Received: <xmr:exL7aHbqZqLo2CpoWzlhqcrlHf4CA8lFOSn9tM3L19ZOrsk1zip9Lj5EYH9lJansQhgDjgJnC8La4ZYTA0lcqSuu6JnQEIm0khIxlN_Wxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:exL7aOJbCv7L7OVKuu9k97jnMl80jBLFfzx9PBPQnbg09hAXAbf2IQ>
    <xmx:exL7aNCmr5OZjgxXaytasfnbfN4Sj8evDuMSdcOVAeoyRP4VR5H3cA>
    <xmx:exL7aLpn-uM-KuTsaQZu5S_ZMIdgYiB8-_g_UmQDSBu0hfsSL_Af-w>
    <xmx:exL7aAhQGmRuoZwQTxRSDZRt5QoUkAe2_sKrrEK4lQRk82o3SjLL0Q>
    <xmx:exL7aOkJxoEJxWKv_yWwjYX-vrgpav2e6N08zhvIPkvMy4l538kVcfa0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 01:45:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18a33361 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 05:45:30 +0000 (UTC)
Date: Fri, 24 Oct 2025 07:45:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 9/9] builtin/maintenance: introduce "geometric"
 strategy
Message-ID: <aPsSd_4iFogbE0FL@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-9-f0d727832b80@pks.im>
 <aPqi71+zRE2KsnCk@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPqi71+zRE2KsnCk@nand.local>

On Thu, Oct 23, 2025 at 05:49:35PM -0400, Taylor Blau wrote:
> On Tue, Oct 21, 2025 at 04:13:31PM +0200, Patrick Steinhardt wrote:
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index aaff0bae15..9739bb0ea2 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1878,12 +1878,31 @@ static const struct maintenance_strategy incremental_strategy = {
> >  	},
> >  };
> >
> > +static const struct maintenance_strategy geometric_strategy = {
> > +	.tasks = {
> > +		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> > +		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
> > +		[TASK_GEOMETRIC_REPACK].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> > +		[TASK_GEOMETRIC_REPACK].schedule = SCHEDULE_DAILY,
> > +		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> > +		[TASK_PACK_REFS].schedule = SCHEDULE_DAILY,
> > +		[TASK_RERERE_GC].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> > +		[TASK_RERERE_GC].schedule = SCHEDULE_WEEKLY,
> > +		[TASK_REFLOG_EXPIRE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> > +		[TASK_REFLOG_EXPIRE].schedule = SCHEDULE_WEEKLY,
> > +		[TASK_WORKTREE_PRUNE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> > +		[TASK_WORKTREE_PRUNE].schedule = SCHEDULE_WEEKLY,
> > +	},
> > +};
> > +
> 
> What you wrote here all makes sense to me, so I don't have any comments
> on the technical content of 'geometric_strategy'.
> 
> As an aside, I wonder if we should use a nested designated initializer
> here? It seems a little cleaner to me than doing:
> 
>     .tasks = {
>         [TASK_FOO].type = ...,
>         [TASK_FOO].schedule = ...,
>     }
> 
> It's inconsistent with the style of the rest of this file, so if you did
> make this change I'd suggest adding a prerequisite change that modifies
> existing strategies to match the new style. But you could imagine
> something like the following on top:

It's more verbose, but it indeed reads a lot nicer. I'll take your
suggestion, thanks!

Patrick
