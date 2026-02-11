Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754532BF42
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813712; cv=none; b=Eom/jN0NYRTzYBKkuvY8mHvqO0uZ0vfYmvjMr+uYN6m8gyRAwHW8wMISxeKcjrgS/XY2aW1WyBd0XtLkkpawwuJcX3JPbg4sqompEXAS6nkwCZa8YkvYuX8SmVYe26xvtKxDrInBG5uxJGz1Iqyh7mLa4hTNmJrR552mlMWN9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813712; c=relaxed/simple;
	bh=XbVrLgcOfr1Zvb4Hzjh9kaN/wB5vG8uBAuzd3rXbjH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmpgth/7NVDZfTkuAyKqFBqRrKk1GwlWUbaAifTncND1uR1gKLejfw3LFEq5BiDyho0Xn7Dk9OdkSPMzUH4mifJwams/RtodmjbH15vyCcTH8i31YjgjqamDA2DOnovcda6VZVFXac0mhQXn9/yZ3vK8EUbpelORT1v4KN+E6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i4by3aDh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhKxKQel; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i4by3aDh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhKxKQel"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB9BC7A0063;
	Wed, 11 Feb 2026 07:41:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 07:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770813709; x=1770900109; bh=waQs4KpemS
	KMuEuf0lxuylULWnGJuhI9rjBQ7m2qF9k=; b=i4by3aDhSHOV5EcIw5tVEajJ7E
	yRNlQyssKMBlRtqDKzmLUDanMxQHXZMPqRBYOc3LQ6Ws4bHeJTc4s+ZREO01haZH
	fUjTbJNrM+hVhNcJhI4xoQgE0yM0WxPjVSyBE1PK4kTOiRioqQ/535P1Ni8+qpbj
	BY8e6TVEQcssfaUi4A7elAGFmWsb6pNWqSFJ9SxpGGM+PBqHHOKuUu7JK+AycXdq
	1790RE9igDnJFpXMo3u/Xru6CN9cUUXFA0Vw1mR0fOWQwmg37D5N0sL/j1Jr8tw9
	nmF5JWUs2WDzWc8KHbe4t4ekClgUTv0Xg3GkTOZ0xlq+TYy0XjzDy+pV/QFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770813709; x=1770900109; bh=waQs4KpemSKMuEuf0lxuylULWnGJuhI9rjB
	Q7m2qF9k=; b=MhKxKQelF2kQhWiYPaI08cvXVDzqA+1qqgFOXNX9cyLS5IAcOpG
	D+dqTNNsqbdkMk01pPFbSW7N8CEFZl/8Er2sh+SmK+vGejGFpJ0R6FqSiX2Gh/Rd
	SuyXcPxHEHOuJs5lVuPRuho2WSQMzKtag79PAB/LLGbh33SciZgUzUZVl5WkHimP
	tFmUDdJ3HoDxvsLv3/SJLrFSTOzXwpZjbm3DevenhDo0+RbjqbjEzv0GTqNoaIGk
	vbBQUEZBLPoGSotGnnKXt0slrQ8wCm4kS0NeXxoL3uI5S96wDT1EhlQkcTTodqVo
	mvWv7okDxUbOYKqY8gA/AGb8IBsVpUm8Nww==
X-ME-Sender: <xms:DXmMae9cLIiCZsUpPA90xtovy5jjPTSnduoQIFn2uq9_6rJxhx7U-Q>
    <xme:DXmMadxGH1Ows7syiLYXMGUz39mbE-23pQU8YeXo_dNH8AZi4nlIKqkeZMFgttdvZ
    T46IDv-tbYJmZM6h39VaJfm2-PHZwebJYYoybfB7aa4PRq89Orhy4A>
X-ME-Received: <xmr:DXmMaaORVywXHq3O-dwTiwkOBflHSebhR5nQYFFL85zubfr0xJSsvx_f7mpM6c5NjuFfWZe8pEjU8SI6QethbS1Ibdu4htn9mdS9F6JZDu-6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegr
    vhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprggurhhirg
    hnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DXmMaS-STp_oTcfFtS_W8GGOBDZ405gMoXVaZQVoHC6URNozjaKW3A>
    <xmx:DXmMaX4GXRkwdDc4mXAO2_S2CQ8ASrxcHrY9InBiPaa9ollru85yJQ>
    <xmx:DXmMaY71UIFn3vi7CotQ0l_0cDijPvTVpl40MlNHuew6bACJ_jaTsw>
    <xmx:DXmMaQpywdHFF675IUaJf7oZ0TA2LODtN2VpI8yhOHq4N6qTdaqrNg>
    <xmx:DXmMaQqOx0ohuAwKKK-pJF4ip0VFU3YB9jxfhxwxZTdhcoaVlPfDVFGX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 07:41:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2151a6e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 12:41:46 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:41:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/4] hook: allow parallel hook execution
Message-ID: <aYx5B-nf4dlFpw3v@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260204173328.1601807-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204173328.1601807-3-adrian.ratiu@collabora.com>

On Wed, Feb 04, 2026 at 07:33:26PM +0200, Adrian Ratiu wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> In many cases, there's no reason not to allow hooks to execute in
> parallel, if more than one was provided.
> 
> hook.c already calls run_processes_parallel() so all we need to do is
> allow its job count to be greater than 1.
> 
> Serial execution is achieved by setting .jobs == 1 at compile time via
> RUN_HOOKS_OPT_INIT_SERIAL or by setting the 'hook.jobs' config to 1.
> This matches the behavior prior to this commit.
> 
> The compile-time 'struct run_hooks_opt.jobs' parameter has the highest
> priority if non-zero, followed by the 'hook.jobs' user config, then the
> processor count from online_cpus() is the last fallback.

Wait, the compile-time parameter overrides the user configuration? That
doesn't seem right to me.

I'm also a bit sceptical whether we should really default to
`online_cpus()`. If so, we start to assume semantics of the hooks
themselves, and that they cannot conflict with one another. But this is
nothing we can really guarantee. It might be that multiple hooks want to
modify the same data structure, and if so running them in parallel would
lead to races.

So I wonder whether we should rather make this behaviour opt-in than
opt-out.

> The above ordering ensures hooks unsafe to run in parallel are always
> executed sequentially (RUN_HOOKS_OPT_INIT_SERIAL) while allowing users
> to control parallelism with an efficient default.

Ah, okay, we only let the compile-time parameter override the config in
case we know that hooks must run in serial. That makes a bit more sense.

> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index 49c7ffd82e..c394756328 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -15,3 +15,8 @@ hook.<name>.event::
>  	On the specified event, the associated `hook.<name>.command` will be
>  	executed. More than one event can be specified if you wish for
>  	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
> +
> +hook.jobs::
> +	Specifies how many hooks can be run simultaneously during parallelized
> +	hook execution. If unspecified, defaults to the number of processors on
> +	the current system.

We should probably note that some hooks will run sequentially regardless
of this setting. Maybe we should even document which ones? I expect it's
not going to be that many.

> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
> index 5f339dc48b..72c6c6d1ee 100644
> --- a/Documentation/git-hook.adoc
> +++ b/Documentation/git-hook.adoc
> @@ -128,6 +129,16 @@ OPTIONS
>  	tools that want to do a blind one-shot run of a hook that may
>  	or may not be present.
>  
> +-j::
> +--jobs::
> +	Only valid for `run`.
> ++
> +Specify how many hooks to run simultaneously. If this flag is not specified,
> +the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If the
> +config is not specified, the number of CPUs on the current system is used. Some
> +hooks may be ineligible for parallelization: for example, 'commit-msg' hooks
> +typically modify the commit message body and cannot be parallelized.

Yeah, this info is probably what I was searching for in the "hook.jobs"
description.

> diff --git a/builtin/hook.c b/builtin/hook.c
> index 4cc6dac45a..cd1f4ebe6a 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -76,7 +77,7 @@ static int run(int argc, const char **argv, const char *prefix,
>  	       struct repository *repo UNUSED)
>  {
>  	int i;
> -	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
>  	int ignore_missing = 0;
>  	const char *hook_name;
>  	struct option run_options[] = {

Hm. Assuming that the user executes `git hooks run prepare-commit-msg`
with "--jobs=2", should we really honor that request? We know that the
hook cannot run in parallel, so we might want to refuse such requests.

Taking a step back, I wonder whether it really is sensible to declare
complete classes of hooks as parallelizable or non-parallelizable. We
have to assume semantics of the hook scripts themselves to be able to
answer whether or not they can be parallelizable. For some classes of
hooks like "prepare-commit-msg" we can assume that it's almost never
correct to serialize them. But for others we cannot assume anything.

Which makes me wonder whether the design here is really the right one.
Shouldn't we stop worrying about classes of hooks, but rather worry
about the user's intent? The user will know whether two hooks can run in
parallel or not, so let them tell us that this is the case.

I think this could be achieved via the configuration:

    [hook "my-parallelizable-hook-a"]
    path = /some/script-a.sh
    parallel = true

    [hook "my-parallelizable-hook"]
    path = /some/script-b.sh
    parallel = true

    [hook "serial-hook"]
    path = /some/script-c.sh
    parallel = false

This would tell us that we can safely run two of the hooks in parallel,
but not the third one. So we'd then first execute all serial hooks in
serial, and then in a second phase we'd execute the other hooks in
parallel.

Sure, this puts more responsibility on the user. But I think this is a
more flexible approach as it also empowers the user and caters to more
use cases.

Please let me know what you think.

Thanks!

Patrick
