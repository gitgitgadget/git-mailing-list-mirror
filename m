Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27812BE7C6
	for <git@vger.kernel.org>; Mon, 18 May 2026 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090411; cv=none; b=nutxWKIvvFtrnO0NHNHTnsgTfKXFresgBoDjmdF0Kpm8knBQX2GeacgbHajcoRRXFZSgzdyWG4coOO4rQObil6yMChXSgeqikjNBp1mwJ82oZj8MPuF3Bt/cGpbtSHaQVfNRK9pW6GLONugyblciHpAIu6TO0cXbKw2m/i8EBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090411; c=relaxed/simple;
	bh=611gtJYv19MlIsZblJoMsNoQ27INFBA8z70lUyOyjeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIRl7dlmnkK+VqB+LvSf4hr3AD8XxCZHjLrSZzUnZggcGU/Pyhm0q2XKZ4ebu7ERQT+zsnmaV2ajgKkCRfF9Nn/G0ckeAvwBYLuJ/yqL8r0ArgDtJbeZd81anDdZRnbTeWcl7AXG3joDTNtQUv7CNqJzKSU9J3aKz5lD7usSd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eeaPUTYC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUoiNRnJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eeaPUTYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUoiNRnJ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A1AE41D000E5;
	Mon, 18 May 2026 03:46:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 18 May 2026 03:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779090408; x=1779176808; bh=81aelIryxR
	AkDcphw4bldm2+AGbBeS7i4JJdHTn49ZA=; b=eeaPUTYCJPAUlGjDp1axhlDMvC
	53VRZC1o/vzZCtwRJcoNvVsjGeNmCsY1P9ghL6utseAfQOsn+vXxmoOI4EnvAJzb
	Hu54/7FfGuTzOG28bVdOQ2WkGGDsmdWODAaUVVsAvRwxm6I6HudxHakYZ0/goeBs
	9PSiL57GMz+WKCzybqWxT57/Sy70XbIqHubzczsBOKhTNCbbw6N569JSScdEy8Kd
	sXqDWyoXcuFfXnh+Dfh6aa0gSGhlwtCswKe0Nrv7BkfdiflLzQDahMo1nyoEi21u
	kZrl+0BQQkgl1xO/Tv55VXZGRw9uk+EWglyLn3GFWgL0NkxvCAl1XY36bvjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779090408; x=1779176808; bh=81aelIryxRAkDcphw4bldm2+AGbBeS7i4JJ
	dHTn49ZA=; b=mUoiNRnJEHRobGj1DzbdBM+eh9UtrT/PDE/awscyxWRrd9Ei1ez
	2fUxW4PdewdGTt1FK21BCK98N5WGDtAXY3F/Flgy7nTzzjXOowElRZKYisSPuz98
	MPoSd/yS8t/VeB76fzYpwQK4ohvXaFoKFHY/GKFG2JqAWH0u9HmJBHhR2wUcNTZ/
	LGiB/9rd9x4T2YhsJclPYp5p0P+hLbS/uL/7BTZlTz0K7VmlmAhAAoC3ehx3RUz5
	KblXCAwaDTgar15H3Lfv6fpJ4zYS/uFQTQ0yBm8KoLg3e6lOXXrZWcZfT8bMuHvs
	9p4biHKur810wD0sCcf8lzYHj1vk5G2KjYw==
X-ME-Sender: <xms:6MMKakfyuMwpumBUhymY9wZOGUGy1doHbABSA_nr8LQF703T3nIncQ>
    <xme:6MMKatHYC1sX-2mnIzzPszEhWTXFUXMJ7Nt4g_hRPXPMC7OQbRNfSKta7yce2Jf16
    msWVeOJIyP1mFVT2ibSLkyUfCpuLvilV3ONMYTJOOiKs2knDaYAOQ>
X-ME-Received: <xmr:6MMKat2plSpuMm8WpDY3Uda7sn8OPoimp0jwLS8F7wxSXJtlxyfQX7nO5BVaXKhB6Q40CAlY__4VE4O17hS3vBwj5-r8faUlDp3VJEZm5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6MMKalkLs1vOwF5wahLG_wwgQ4emwvDhntPMyYmpsKC2IoFKALiLlA>
    <xmx:6MMKat-Hj8C0ZdA985ntYC7_XA3nOhvXvHTjJvOocUeOXM1uYmvdyw>
    <xmx:6MMKaqqNv5gDxKq_RqBEBl8G6wFNSHVTvr_S8ZjJ-MRICc4M_b2-hQ>
    <xmx:6MMKamlVx33YE8aY7lKeKpxDAW0IrlFQK-3cwCNPVXuKWHYpvf2-8w>
    <xmx:6MMKamW_iTZQC5neX-1j0ThPCQRwgFjfGF9MRpsil7S1HraiUMVOsrpB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 03:46:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b83a8e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 07:46:44 +0000 (UTC)
Date: Mon, 18 May 2026 09:46:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
Message-ID: <agrD4p1AIPtwa5gW@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
 <20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
 <4d9604e2-036b-485e-aa93-53c35d539bed@malon.dev>
 <xmqqa4txd2p5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4txd2p5.fsf@gitster.g>

On Mon, May 18, 2026 at 08:41:10AM +0900, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
> > On 4/20/26 16:22, Patrick Steinhardt wrote:
> >
> > I've noticed something that does not entirely convince me:
> >
> >> @@ -477,11 +476,13 @@ int is_inside_git_dir(void)
> >>  	return inside_git_dir;
> >>  }
> >>  
> >> -int is_inside_work_tree(void)
> >> +int is_inside_work_tree(struct repository *repo)
> >>  {
> >> -	if (inside_work_tree < 0)
> >> -		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
> >> -	return inside_work_tree;
> >> +	static struct strbuf buf = STRBUF_INIT;
> >> +	const char *worktree = repo_get_work_tree(repo);
> >> +	if (!worktree)
> >> +		return 0;
> >> +	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
> >>  }
> >> 
> >
> > Is it correct to statically allocate memory for the cache here? Could 
> > this lead
> > to memory overwriting issues in a multi-threaded environment?
> 
> I do not offhand know if other code paths that are called from this
> function are thread-safe, but yeah, this use of file-scope static is
> not a safe thing to do.

In the current status quo this is a safe conversion to do, as we still
have the assumption ingrained that this only works for a single repo.
We were using static variables before, and we're still using static
variables now.

That being said, I wouldn't mind dropping the static variable if this is
something we'd rather want to get rid of. It's a smell that I'm not
particularly happy about myself.

I'll send a revised version in a bit, thanks!

Patrick
