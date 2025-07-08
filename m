Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27722837F
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017328; cv=none; b=oRFZ803OxY9whHtc2k6/aUjGLR440aNDYJM19lo10gCebF4twDKFP/gQ7I0GjyXLHVxmlmkjDgygoZ9hD3qVAqqPcbvI+PCLDQZ4PGUDWToYt/BZXY0TPr67IIUy6pc82Rh9Lj+8eY9jrGJyMl2fBhu/tnX/J+YHS0lBQ6k1KMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017328; c=relaxed/simple;
	bh=Q04dhnI6HiSkyXrKyd5z1iVD3FwrOiQSMUTdqY9SIKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQiJONsjXX9ElIFITFrOIkK9Pz78ekfKRiwfbJIDejgJb+fO8Z/Eyt2s882m0+WSBz9dHPHCaZXk+dpS3+xrIAe667dQt1npJve9RTOkw7FylIzZcp1WWlBT36w7CGcxAXeYtrsn0lskvuO751x48tfyPmLQiq8XP/wKatYtLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T/FiZOxa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoWD4bSN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/FiZOxa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoWD4bSN"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D6CA8EC0B39;
	Tue,  8 Jul 2025 19:28:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 08 Jul 2025 19:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752017324; x=1752103724; bh=M5lsAd7FCB
	TTY1yW8zN3boFSLTEj/WP8AB5IVWwtFWw=; b=T/FiZOxa8tJ4puEfV06GCJqRXJ
	FJNk5czirOSiL5NNmeTxVepJmM18L+0eWHwysnZzY8aL5ri7p7GBmAPedj2+QX5D
	Fd7u1mYddUU0JvLaUP/++r2U3FeSCSg+4VjAn2avDc0LPDBOvSGBzdDIdAjiVLxl
	RMLdpXb3BotS0myAm+nnx0v1qK04wFn1UcYEkJ5BrhDIHgHWQC3odR9HPVWjqGSP
	4P8IB6NHW6xrJAuuD1k8+SrQWpjHIMFcnKwVLK7Kaq3lBRIQVf0rsgPGB1C7df0X
	E5boeLkggeo4Rn58h7dOrbUBOBjcHzC4p366EfZZwiA0W//nEILJxsLTJ18A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752017324; x=1752103724; bh=M5lsAd7FCBTTY1yW8zN3boFSLTEj/WP8AB5
	IVWwtFWw=; b=KoWD4bSNXE4420Xk0ombixsryCOcVHqvbAtbJ+ISCLWQpfZEfow
	FqXLHVHyMOS0DOwwDIQ8usYkLkt7hF3Ep4OMQCRQwMyYzfG0f+OJPCTc5FXZKA++
	s0PNXU197Mogj2j1eDOfPwmmdiG7Cszjnmhy28Xn1wH94UMSWSi76IxvZeTn3WyO
	iZkpVLi+dFw83wTPUyqpiWHAL/Vpg7U/d257GYTJ4mqt58hRKmBSYr7ewuhWi6RF
	vWgP4S1f0DVoyGcUkSrl0m7livklAoV8zTyZfSGHfOwL6gWzrKfCmhkig9rSIgFX
	2MSc0iV42AeWEHFiNKg2iMJRK9/7bfsztgg==
X-ME-Sender: <xms:rKltaDjJx3cCOsSVUa7T-lpl7wp8O5P4I2OmIDBipUMXaxe7acaUDw>
    <xme:rKltaNK5jsOsyL2H0uqAtGguO1nM8c35yWXEeAvSDjYHAZCudJe3VDNrM6fX9b-gT
    OidTAnM8W3vBOU-1A>
X-ME-Received: <xmr:rKltaCEkTOw05Q8jsKbgCM0nusSZWqDVOq0gC4U95j89tqWzVPE7NN86YzNAEg55vlK28D8sQG_VjZBb2BuSkjPFfGB0YO8J_ekASoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetieejgfeiudehfffhteeggeegtddvfeeiieduvdduteekteegfeetjeejgffh
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopegtvgguvghrsehlhihsrghtohhrrdhlihhurdhs
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rKltaBRQhkcmKNG0VttW6UH8lvKvcQ9rP1Y0U4-n2TNMc7A4qQBOag>
    <xmx:rKltaOdRA0KMZFkEK1rLirSc7CPAywGyIwhaIwAwhqXRG8SrTjEKNA>
    <xmx:rKltaArEtjJuqewHrLpSTeuZw8Bzf1pWIjHtaX9I-AGfvBlydmvs8Q>
    <xmx:rKltaP_jFxVWxvpOyWU-FJF2yhtm3vK7fd9cP9beUwehuflPboKHNw>
    <xmx:rKltaP5sHMNoTf9DdGJNfxzTiCiVidruRWXVPAoqkGoM8Bn5u6hbGE-M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 19:28:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Per Cederqvist <ceder@lysator.liu.se>,
  git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
In-Reply-To: <20250708225946.GC1180568@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 8 Jul 2025 18:59:46 -0400")
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
	<20250705165750.GA1951664@coredump.intra.peff.net>
	<20250705185842.GA2496172@coredump.intra.peff.net>
	<aGuP3Q5xykmRNp0m@pks.im>
	<20250707202801.GA3115893@coredump.intra.peff.net>
	<xmqqtt3n3e7g.fsf@gitster.g>
	<20250708225946.GC1180568@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 08 Jul 2025 16:28:43 -0700
Message-ID: <xmqq5xg2s1n8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jul 07, 2025 at 02:04:19PM -0700, Junio C Hamano wrote:
>
>> > IMHO we should probably avoid the underscore pattern. It's OK here, but
>> > it runs close to violating the reserved names rules (a global variable
>> > variable _name is bad, and _Name anywhere is bad).
>> 
>> "name_" is available.  In fact I think it is a very common pattern
>> in this codebase to name an incoming parameter with trailing "_",
>> and assign it to a local variable with the right name and with the
>> right type at the top of the function.
>
> Yeah, that is legal and is a pattern we use (though I admit that I find
> any underscores kind of ugly and easy to miss). I was curious how often
> each pattern appeared:
>
>   ["v" prefix: vdata, va, etc]
>   $ git grep 'void \*v' '*.c' | wc -l
>   51
>
>   [leading underscore: _data, _a, etc]
>   $ git grep 'void \*_' '*.c' | wc -l
>   52
>
>   [trailing underscore: mostly a_, b_ in comparators]
>   $ git grep 'void \*[a-zA-Z0-9]_' '*.c'  | wc -l
>   30

Only a single letter followed by an underscore, which may be
followed by more letters legal in names (like a_bcde)?

A more fair pattern may be something like

$ git grep 'void \*[A-Za-z_0-9]*_[^A-Za-z_0-9]' \*.c | wc -l
52

>   [just calling it "data"]
>   $ git grep 'void \*data' '*.c' | wc -l
>   314
>
> The last one is cheating a little because it catches function pointer
> declarations, too, but grepping for "= data;" returns over a hundred
> hits, too.

Also "void *cb_data" is fairly common, I think, as we have some
callback API functions.

$ git grep 'void \*cb_data' \*.c | wc -l
234

> So that was mostly for fun, and I think any is OK. ;) But here is the
> patch again with the void pointer just called "data".

Yeah, I think any would be fine.  I was a bit surprised that
v-something was so widely used, though, as I find that it makes the
least sense among all possibilities (and "data" is the distant
second, as it would become awkward when you have to have more than
one, like my_custom_cmp(void *left, void *right), if your rule says
that you must say "data").

> Although I think we're all a bit lukewarm on the concept, I feel like it
> won't hurt anything, isn't too much code, and disables a potential (if
> somewhat rare) footgun. So probably worth doing?

Even though it does not cover all cases, at least those coming from
"git remote" will be able to avoid surprises, so let me replace with
this version, wait for a few days for more inputs from others and
then mark it for 'next' if nobody sees any downsides.


> -- >8 --
> Subject: [PATCH] remote: detect collisions in remote names
>
> When two remotes collide in the destinations of their fetch refspecs,
> the results can be confusing. For example, in this silly example:
>
>   git config remote.one.url [...]
>   git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
>   git config remote.two.url [...]
>   git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*
>   git fetch --all
>
> we may try to write to the same ref twice (once for each remote we're
> fetching). There's also a more subtle version of this. If you have
> remotes "outer/inner" and "outer", then the ref "inner/branch" on the
> second remote will conflict with just "branch" on the former (they both
> want to write to "refs/remotes/outer/inner/branch").
>
> We probably don't want to forbid this kind of overlap completely. While
> the results can be confusing, there are legitimate reasons to have
> multiple refs write into the same namespace (e.g., if one is a "backup"
> of the other that is rarely fetched from).
>
> But it may be worth limiting the porcelain "git remote" command to avoid
> this confusion. The example above cannot be done with "git remote",
> because it always[1] matches the refspecs to the remote name, and you
> can only have one instance of each remote name. But you can still
> trigger the more subtle variant like this:
>
>   git remote add outer [...]
>   git remote add outer/inner [...]
>
> So let's detect that kind of name collision (in both directions) and
> forbid it. You can still do whatever you like by manipulating the config
> directly, but this should prevent the most obvious foot-gun.
>
> [1] Almost always. With the --mirror option, the resulting refspec will
>     just write into "refs/*"; the remote name does not appear in the ref
>     namespace at all.
>
>     Our new "names must not overlap" rule is not necessary for that
>     case, but it seems reasonable to enforce it consistently. We already
>     require all remote names to be valid in the ref namespace, even
>     though we won't ever use them in that context for --mirror remotes.
>
>     Likewise, our new rule doesn't help with overlap here. Any two
>     mirror remotes will always overlap (in fact, any mirror remote along
>     with any other single one, since refs/remotes/ is a subset of the
>     mirrored refs). I'm not sure this is worth worrying about, but if it
>     is, we'd want an additional rule like "mirror remotes must be the
>     only remote".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Subject: [PATCH] remote: detect collisions in remote names
>
> When two remotes collide in the destinations of their fetch refspecs,
> the results can be confusing. For example, in this silly example:
>
>   git config remote.one.url [...]
>   git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
>   git config remote.two.url [...]
>   git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*
>   git fetch --all
>
> we may try to write to the same ref twice (once for each remote we're
> fetching). There's also a more subtle version of this. If you have
> remotes "outer/inner" and "outer", then the ref "inner/branch" on the
> second remote will conflict with just "branch" on the former (they both
> want to write to "refs/remotes/outer/inner/branch").
>
> We probably don't want to forbid this kind of overlap completely. While
> the results can be confusing, there are legitimate reasons to have
> multiple refs write into the same namespace (e.g., if one is a "backup"
> of the other that is rarely fetched from).
>
> But it may be worth limiting the porcelain "git remote" command to avoid
> this confusion. The example above cannot be done with "git remote",
> because it always[1] matches the refspecs to the remote name, and you
> can only have one instance of each remote name. But you can still
> trigger the more subtle variant like this:
>
>   git remote add outer [...]
>   git remote add outer/inner [...]
>
> So let's detect that kind of name collision (in both directions) and
> forbid it. You can still do whatever you like by manipulating the config
> directly, but this should prevent the most obvious foot-gun.
>
> [1] Almost always. With the --mirror option, the resulting refspec will
>     just write into "refs/*"; the remote name does not appear in the ref
>     namespace at all.
>
>     Our new "names must not overlap" rule is not necessary for that
>     case, but it seems reasonable to enforce it consistently. We already
>     require all remote names to be valid in the ref namespace, even
>     though we won't ever use them in that context for --mirror remotes.
>
>     Likewise, our new rule doesn't help with overlap here. Any two
>     mirror remotes will always overlap (in fact, any mirror remote along
>     with any other single one, since refs/remotes/ is a subset of the
>     mirrored refs). I'm not sure this is worth worrying about, but if it
>     is, we'd want an additional rule like "mirror remotes must be the
>     only remote".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/remote.c  | 17 +++++++++++++++++
>  t/t5505-remote.sh | 14 ++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 0d6755bcb7..a770df669c 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -157,6 +157,21 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
>  	return 0;
>  }
>  
> +static int check_remote_collision(struct remote *remote, void *data)
> +{
> +	const char *name = data;
> +	const char *p;
> +
> +	if (skip_prefix(name, remote->name, &p) && *p == '/')
> +		die(_("remote name '%s' is a subset of existing remote '%s'"),
> +		    name, remote->name);
> +	if (skip_prefix(remote->name, name, &p) && *p == '/')
> +		die(_("remote name '%s' is a superset of existing remote '%s'"),
> +		    name, remote->name);
> +
> +	return 0;
> +}
> +
>  static int add(int argc, const char **argv, const char *prefix,
>  	       struct repository *repo UNUSED)
>  {
> @@ -208,6 +223,8 @@ static int add(int argc, const char **argv, const char *prefix,
>  	if (!valid_remote_name(name))
>  		die(_("'%s' is not a valid remote name"), name);
>  
> +	for_each_remote(check_remote_collision, (void *)name);
> +
>  	strbuf_addf(&buf, "remote.%s.url", name);
>  	git_config_set(buf.buf, url);
>  
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index bef0250e89..2701eef85e 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1644,4 +1644,18 @@ test_expect_success 'empty config clears remote.*.pushurl list' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'forbid adding subset of existing remote' '
> +	test_when_finished "git remote rm outer" &&
> +	git remote add outer url &&
> +	test_must_fail git remote add outer/inner url 2>err &&
> +	test_grep ".outer/inner. is a subset of existing remote .outer." err
> +'
> +
> +test_expect_success 'forbid adding superset of existing remote' '
> +	test_when_finished "git remote rm outer/inner" &&
> +	git remote add outer/inner url &&
> +	test_must_fail git remote add outer url 2>err &&
> +	test_grep ".outer. is a superset of existing remote .outer/inner." err
> +'
> +
>  test_done
