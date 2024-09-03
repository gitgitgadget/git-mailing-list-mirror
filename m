Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592B1AD262
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358190; cv=none; b=XGlnQKJe+WYDbQ+ojWU++f1BSUAW4VyWtrvYv/y/q1c/54qwUrjWM0w8GY5vL2ItJEWB7zCDllZLVc2vbOrrLJifNWfX4mssnfvR/POHgLiXLTj/Zq4R3nXqlC/OD9G1GFPLpkWSO7ugzaOBQn/JFjtfJbMYqhu+HYoprR684lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358190; c=relaxed/simple;
	bh=FrY3hVOfYWJFUajiEYX6QfEmjZgKFjrYYg2W1+oiCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAsnt/y+KP0JMspn3bTyp6GMob90HEOEfBf4V9zI1z3j1Gwo5eS+zVoKnbcIj8WRcxBURjpYYxFZ+9FCDPOe6JrKu7n3sb2mVRXEprDctm0bC9dXCR02YQUkxasbedviCrG2eVwEAm2cETuPZvlFRUZ2vaixFq/Whi/IA4GS4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qEO2OaUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhQTIFnC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qEO2OaUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhQTIFnC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45BB51140349;
	Tue,  3 Sep 2024 06:09:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Sep 2024 06:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725358188; x=1725444588; bh=I29czEe1P8
	u/rCZqcbQA2GDX/VqGEeHfBDdNj6C/OSg=; b=qEO2OaUj/Yjesxnqn8zQzUb0wx
	ZOWxwZy4ADSoZNk5R7AlLji+FmjzJlAtOulOJbxbwEaAPsi3dkHyZmreCpyszKsp
	QJumaQyssnO0eBlUDqFWquiFxbGvq/l5KZiTZh7H630B0A8h4j0h2hlH5RjO9YcB
	3lg0JMQ6ZzHxbJJBC8Wn98OK9J6mPjGD0UbMEUAJZT3CiEsGGmK+jHVRJC4AFPvl
	auHM6fCv5ke6gWf1PXgLTBvlN6vubbyKZJlbR5OASpVyOK9PrXDLFCoc0P9skTwC
	2kE8qBZVG+pEAw2QB6LTKY39zu4mbyppJj+vseLDqSvP1PLUpwl36vUYzYzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725358188; x=1725444588; bh=I29czEe1P8u/rCZqcbQA2GDX/VqG
	EeHfBDdNj6C/OSg=; b=IhQTIFnCFDSlAlXBg9IM1NztmNcV6s1KsnyLHYte7yvT
	4u3WFsO6bA0HO4ROQ5s9PXtD8If3pG4ZSmZJZ/ej22rTRJWV3WXkKpgZ7y7i5a1q
	/IVLZo5dGS3jrZhRbzPfEoHbzFAWtz0fbComhdrIiCtSL7SIa9wjzMegf96ob7S2
	AgiMC+rbtpob6DeFKy9AKfhp9ypVA6x6F7XcSXwBfs/8MTb6xFJaP/uGvRixwq+w
	DODt6iiucDgFNjHlfeNxc07QQEG5AaQpJZa90tUBZ4sDCEaPYmIjCEJLXDAOp3QT
	aeZH19jm83bZ/hChck4E+M76TCPn1BIUVR6pHOHyjA==
X-ME-Sender: <xms:bODWZi-WDuTl4ttu4X-3AIr-2Xn_a-QIZBiRoXTgU_4ZWT0aAU419A>
    <xme:bODWZitIbrI9gNiq4n1k6haj-2Ft9RkAJthf3kgNxXnXLs1zlSfOnmenPwphr54BC
    mGoLnh3kenq_knNrA>
X-ME-Received: <xmr:bODWZoC0z9bRepPmRL0thfFuBvF_sv2TP-zurrI50gKaAK0n2JvGuaxtztbY8FK8nL3elH8UBAgSxLlm5_UZ-F3WK_MUX2tOLLKcfNoduWHeVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsuhhpthgpgihinhhggihinhesudeifedrtghomhdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegsmhifihhllh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepgihinhhggihinhdrgiigsegshihtvggu
    rghntggvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:bODWZqdGfr1el2kfQ2uGur2ZpZZtpBzd93RD1UR3IP_m1LYkUAOD_g>
    <xmx:bODWZnPjdVLhe3WHWmr0AuG3m5RoV9DQQRkr-3RKt0iZYElpgufXUQ>
    <xmx:bODWZknGde-gsUC1EkoX0pXnU9guS8CIvko0Y5RHhStCL32WgsO5nQ>
    <xmx:bODWZpuUNFH1LUhvAj4ROEDXVqKbhFkld5xbwdu31RCdc1Y2Hherww>
    <xmx:bODWZjDlmV1wKvEXmgc50oA-3oiU_N9EsP4wgYcHXJbPrsLXkX7o-vxN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 06:09:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 084323f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 10:09:40 +0000 (UTC)
Date: Tue, 3 Sep 2024 12:09:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 3/4] builtin/clone.c: recognize fetch.serverOption
 configuration
Message-ID: <ZtbgafDQwbU9tBoq@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>

On Mon, Sep 02, 2024 at 12:13:55PM +0000, Xing Xin via GitGitGadget wrote:
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 8e925db7e9c..105645ed685 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -149,6 +149,9 @@ objects from the source repository into a pack in the cloned repository.
>  	unknown ones, is server-specific.
>  	When multiple ++--server-option=++__<option>__ are given, they are all
>  	sent to the other side in the order listed on the command line.
> +	When no ++--server-option=++__<option>__ is given from the command
> +	line, the values of configuration variable `fetch.serverOption`
> +	are used instead.
>  
>  `-n`::
>  `--no-checkout`::

I'm not a 100% sure, but I don't think that `fetch.*` configs typically
impact git-clone(1). So this here is a tad surprising to me.

It makes me wonder whether it is actually sensible to implement this as
part of the `fetch` namespace in the first place. I'm not yet quite sure
where this whole series slots in, that is why one would want to set up
default server options in the first place. So what I'm wondering right
now is whether the server options are something that you want to apply
globally for all remotes, or whether you'd rather want to set them up
per remote.

In the latter case I could see that it may make sense to instead make
this `remote.<name>.serverOption`. This would also remove the unclean
design that a fetch-related config now impacts clones, even though it
now works differently than our push options.

I guess this depends on the actual usecase.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 269b6e18a4e..5a1e2e769af 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -847,6 +848,12 @@ static int git_clone_config(const char *k, const char *v,
>  		config_reject_shallow = git_config_bool(k, v);
>  	if (!strcmp(k, "clone.filtersubmodules"))
>  		config_filter_submodules = git_config_bool(k, v);
> +	if (!strcmp(k, "fetch.serveroption")) {
> +		if (!v)
> +			return config_error_nonbool(k);
> +		parse_transport_option(v, &config_server_options);
> +		return 0;
> +	}
>  
>  	return git_default_config(k, v, ctx, cb);
>  }

Seeing that we always have the `config_error_nonbool()` call, would it
make sense to also move that into `parse_transport_option()` and have it
return an error code for us?

Patrick
