Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63917993
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400998; cv=none; b=Zc0+A9qIVh6oj/q0Vpi2bkE3wEEAADppme4MSAmSqnMzVJbqPNRvL6Th+FON2YzQbYwSwLwj2PmwsSv1dyCAilxj9ibtaKR9ODxOJgbpnJ1lA5w8C+kU4woN20SRTGpjIN3uIbuNBS0ZgY9v3mi8vbDP8gAjKs9TTMM5OX8OA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400998; c=relaxed/simple;
	bh=aYTMptL0jAHRJuENh0m+Bxa84Eoj8U+oQAEuwn3r3as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=saOYxSXunhSMb8X8m3PTPzQJfGTgGfdrJYDeIR1KgRXdfDSeWYCTmJGPQfhdl94UYa48v/IuwepE+Gx5AP8qbwMlIdoahUQTQk1+7nagMFYXrz4qjGw0vM333u3ekPMlzdog0slvGAubMJbxIceX69Iy6GySizSIvP2CW5/3+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xvO+Ivvt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w6hBYsWW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xvO+Ivvt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w6hBYsWW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 212D61400078;
	Fri,  6 Feb 2026 13:03:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 13:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770400997; x=1770487397; bh=u+o8Z/WPXj
	lbf8lhrsSX/D44yTgn9m6A6z7NsnXQB6E=; b=xvO+IvvttMZmIksJs8XMp844fB
	tKd4R5QHcqGRM69EZhsOhgpAf409a8DkpxIkoG16P9YuTggxaO3UjyOPSkeLb66w
	V7RE2WetMBo/E1tcGgcNGDoKr0U16ig8YOFoqbAgVbkfeirFkjXmHWZthiHZopBP
	t+2/xNl/ccMIYtvlH8H1lM01xFuBI4ApYDlCPVLSpt0DQWYUZAwRrQSxMEf8A2TQ
	yROlT3FEtx/yGcjF/+ldzrmuh7c7GeMtmhxtaRvxX/mtrOnv6nq2oN+Rg1iTaydI
	RiAhQgyqCMzansvJQCA2u5rMOWzKBMtDecLisL+T3+0D2vJOz4Aj6D23vcdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770400997; x=1770487397; bh=u+o8Z/WPXjlbf8lhrsSX/D44yTgn9m6A6z7
	NsnXQB6E=; b=w6hBYsWWRc/g1GYNl7hzNE0wMNTye/d0uiPzsjC6UrG+D9KQqP5
	SE+naHnGf3aSaTrjYs1Ty80JFSXvZ5AqZW01pAUbtjekokBaBNubeiD1CYJzxNyp
	zOHIyKqgTJQP/+DbJGG/8j5kiGe/Bnvpz9HHDQ7RTGQBdx65/hx+r73uiqF52alq
	w8NI8zieELJ/nsLtXAupCBk+xBtD9+c9N5UOzVkR3FjkfaHAIY7+RCM4vN6NryoS
	innp4Q25DBeXEEZYEqVUE3tg6hovk2wyKeJefEiRW1/4IHg6SbbnWew2V6BPmJwg
	imz/X76Eb4TUPnxcH1ybe0EwpXHxXwGlt6w==
X-ME-Sender: <xms:5SyGaeV9tdqqxn_GlZz-a8cxaFBD4GKh0JrwmS7kwkIwt4uH1e_JjQ>
    <xme:5SyGaXI_Sktn8AT6XZEeTPTiRKWuvDROheOjXhDJOPzs76_AX3yTyxcw84n3XOc6F
    DCGKhNPuXsfJbU1g8aV4qkuKy4TsMR5PUBgCrhUyXXODmeGHnSv5Q>
X-ME-Received: <xmr:5SyGaW2oW5B9C_PCCAN4eSpg9FPVpXNR7Z4VhwQ1e0e4Z9sf6fKAP8cGGsxFyiXv8WS4SrQ-eb6Tep2GoqMJcuEr4NHRkmfh7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkuhhmrghrrgihuhhshhhjhhgruddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshh
    hirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphef
    heduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5SyGacKlScvFUdfhhRJSq7NuqBW1evTmLIAnHhwyOpeiW6Oh4Lg1dQ>
    <xmx:5SyGaZi3PSAgvghusEDCqgRTIzeKR6qyY-jG4ES-5yxr1QHhNMBTkA>
    <xmx:5SyGaUAzXBZ6Mrm6l5Lp5Yw5UONk8pkZWrsQ9G30NtfE0_5uiedpnA>
    <xmx:5SyGaT67Da5tGvHrRa-QV4SDdAEaYNiGP6y92t1zq9BpOA6fN-FiPg>
    <xmx:5SyGaT-8ft4qmZCFhf9QcGa1NisT4vfd8OMF5HnCsqUQ4Z6m0bbs7UFn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 13:03:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Jha <kumarayushjha123@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] [RFC][GSoC 2026] builtin/repo: avoid global state in
 get_layout_bare
In-Reply-To: <20260206152002.1244-1-kumarayushjha123@gmail.com> (Ayush Jha's
	message of "Fri, 6 Feb 2026 20:50:02 +0530")
References: <20260206152002.1244-1-kumarayushjha123@gmail.com>
Date: Fri, 06 Feb 2026 10:03:15 -0800
Message-ID: <xmqqfr7dg36k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Jha <kumarayushjha123@gmail.com> writes:

> The get_layout_bare() function accepts a struct repository *repo
> argument but marks it UNUSED and instead relies on
> is_bare_repository(), which depends on global state.
>
> As bareness is a per-repository property, this causes the function
> to always report the status of the global repository, even when a
> specific repository instance is provided.
>
> This change computes the bare status using the passed-in repository
> instance (based on core.bare and the absence of a worktree),
> thereby removing the dependency on global state.
>
> This patch is sent as an RFC to solicit feedback on whether using
> repository-local state here is the preferred approach.
>
> Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> ---

I'll let others to suggest improvements above the three-dash line.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 0ea045abc1..b2619cc77c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -35,9 +35,12 @@ struct field {
>  	get_value_fn *get_value;
>  };
>  
> -static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
> +static int get_layout_bare(struct repository *repo, struct strbuf *buf)
>  {
> -	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
> +	int is_bare_cfg = -1;
> +	repo_config_get_bool(repo, "core.bare", &is_bare_cfg);
> +
> +	strbuf_addstr(buf, is_bare_cfg && !repo_get_work_tree(repo) ? "true" : "false");
>  	return 0;
>  }


As git.c:commands[] lists "repo" with RUN_SETUP, we know that in
cmd_repo(), after passing parse_options(), repo is guaranteed to
be a non-NULL pointer that is the_repository.  So this new version
of the function that assumes repo can be safely passed to
repo_config_get_bool() and repo_get_work_tree() would probably be
OK.  I didn't dig to find out is_bare_repository() does exactly the
same thing as what the new code does when the_repository is given to
the "repo" parameter, though.

Having said all that.

In general, anything in builtin/soething.c is an implementation of
"git something" command and cannot be reused outside the context of
that "something" command, so it is much less interesting to get rid
of dependencies on the_repository from these files.  The design
choice to work with a single repository at a time is with the
"something" command, and as long as that design choice stays, there
isn't point in hiding the fact that we work only on the_repository.

If we were moving the logic implemented by the helper functions that
are used by cmd_repo() function to a shared and reusable library-ish
part of the system (perhaps in repo.c at the top-level), that is when
it becomes much more interesting and releavnt to make sure that a
function that takes "repo" as its parameter does work on that
repository and not the_repository.

But until then, ...

Thanks.

