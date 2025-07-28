Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC98F6E
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716840; cv=none; b=mg+f7PUdHBAeXV9xGgWS4z8L49mojvwojt6u8tkonU86s3O3qhRUgXU6OohR0wAMMeHLCmmikMSe6UJOKKk5wRWjP7UoxT/XKkKUDuB2qrq9NIf/MC/O5RI664uX++NkBWOgrlytxi4d3FSbkvjIyHHlwaY2pp8DEUQmDFeC00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716840; c=relaxed/simple;
	bh=uKc8NUCJGaaDzfKVGd84zBV+a/ytfiU0gDiC17NE4SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y++64GDVqL9KCmE4sb/qU30TerRFGFzLqPDhOiASutbiyG6C3/QMXeAwIdS1DWVPEuveyEZOqKJ1YepbMKPYzWNmauYluYgNwIgahb1QkYseQg6LhUXAkoJKnlD0TLAA54HpgbRyLaFu+kj4HmjnBjXbdkCAY9m0vhoahQRcxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BL9iET84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=esLpsh4j; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BL9iET84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="esLpsh4j"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DA18EC11A0;
	Mon, 28 Jul 2025 11:33:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 28 Jul 2025 11:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753716837; x=1753803237; bh=MojqmXwRYg
	YZfIVYnOzmasQRYZvZiEmaM+kzTD0Os2k=; b=BL9iET848fwzzTKncvvVFAev3Y
	uowH7UQOdDoWGKWcRU+OrMr7HuPDGF7xVVbWXB00kxy/7pfXWVpguG/0eYdXo50Z
	p6dw/0CV1N66qWMMa2GpyRdYtnpsw8RRpPGFBQRbtDeIvpXDH+wD/EjhdigSDzoV
	/ZWam8veQAoL/K036SewUr1D2goo74dYVuiGIxkg9zFTVkG3OYs1TttgsyCPiErL
	U0Z5YL64X+xjHKTZrfP85zYSVbofw/kl3/RmsZHZwhJCxPjxT0NqcSpubEylpsHs
	a/aQOPkvrG4i1hD9NNd2s3BKLOiS4jqCSRJXKhasQPsG0okOQMjBuxUDXrYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753716837; x=1753803237; bh=MojqmXwRYgYZfIVYnOzmasQRYZvZiEmaM+k
	zTD0Os2k=; b=esLpsh4juuSgDJbyF8d3nHfbS7sRQgpwcgvvPn2zFiaVRADMuf9
	w7kz0OMu9RaNAXHRpaRT+Khscxwkqoo3jdsLXQBc/rbx5mnlAjy1gQV0UjGGFj0n
	6K9PiMsBgqWSebSH2GjPDfuzMCfuUGmztx4EI5cP7ZkUEdYHKI3Nvtsf6K7RvYpm
	ZXQxuk/i2lYCOuB4pRJbdm++/UplZlauKK3Oglx6uJwR5c7mNMSphImYtDO7AdkO
	9Hc8BDAMnUZx9BK9WzGb+0ftvNvT/H5LS945z1QwT9zaRG554gWRhrxXiS+b/HcT
	0Z/7pEJO6GlBHm4EMF51oG0iFAmcOmawTOw==
X-ME-Sender: <xms:ZZiHaKJLadi7HF69ODVS7HE_AZBysrkHKGwafpIS7F6d8nf0o_mRUQ>
    <xme:ZZiHaPF9rYcDXooVTNImp4AjYfTvosP7Dc6tyUKqyx1bH_7y5bGURir9HJA4WCH_4
    LO4tY7OtBND3LFZAQ>
X-ME-Received: <xmr:ZZiHaGVDGjH6N0vZPb2wfRsaiBM8hLlwKg0dJv2oqqm58JyrCBo0L0Q1z32p5t0RLiSr3MgLW_sAadANI9DuTwncWAgx9fqfBvfaP_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlvghsshhlvgihuggvnhhnihhnghhtohhnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrhihurdgthhgrnhgu
    vghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZZiHaHz-FWCbjdMqzpPGC1vnj44GAvpgafv0uHIshQUiYNCD3OkKHg>
    <xmx:ZZiHaLTACK-6lsSNI5l-VyyfJKOlIcer9caTlmwryVoILbfdxW1DWA>
    <xmx:ZZiHaDgVj6Sgecmk_S4LrWnLqXN9GsU-g3BDHi0QyV5QtU35cazLzw>
    <xmx:ZZiHaCk5UPBf-ulkixFOYkDye1kpZyCmmiWs1Eq5NmbLC7-_Q5eteA>
    <xmx:ZZiHaKe1oijDeLpquz_M26DdW6BqSFdeYmQm5ke2yIJl9aYBYswqP__T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:33:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Lessley Dennington <lessleydennington@gmail.com>,
  Jeff King <peff@peff.net>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH 3/4] builtin: also setup gently for --help-all
In-Reply-To: <20250726165320.4039-4-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sat, 26 Jul 2025 12:53:13 -0400")
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
	<20250726165320.4039-4-ben.knoble+github@gmail.com>
Date: Mon, 28 Jul 2025 08:33:55 -0700
Message-ID: <xmqqcy9kxrbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>     I originally considered leaving out the changes to
>     show_usage_with_options_if_asked and relying on the parse-options API to
>     do the right thing. Unfortunately, most commands can't make it all the
>     way to parse-options when setting up gently, and trying to parse options
>     without a repo creates myriad dependency problems (like: we might read
>     config after parsing CLI options, so we have to make sure the parsed
>     options overrride config).
>     
>     Some usage.c callers, like check-ref-format, probably deserve to be
>     ported to parse-options at this point.

It is unclear what you mean by all of the above, but hopefully it
would become clear as we read the code changes.

>     I opted not to do anything too invasive with merge-recursive (like a
>     prepatory "migrate to newer usage APIs") since I think it's going the
>     way of the dodo?

I think this is fine.

> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index 03b5100cfa..17aa4db37a 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -38,7 +38,8 @@ int cmd_merge_recursive(int argc,
>  	if (argv[0] && ends_with(argv[0], "-subtree"))
>  		o.subtree_shift = "";
>  
> -	if (argc == 2 && !strcmp(argv[1], "-h")) {
> +	if (argc == 2 && (!strcmp(argv[1], "-h") ||
> +			  !strcmp(argv[1], "--help-all"))) {
>  		struct strbuf msg = STRBUF_INIT;
>  		strbuf_addf(&msg, builtin_merge_recursive_usage, argv[0]);
>  		show_usage_if_asked(argc, argv, msg.buf);

;-)

> diff --git a/git.c b/git.c
> index 07a5fe39fb..40d3df1b76 100644
> --- a/git.c
> +++ b/git.c
> @@ -445,7 +445,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	const char *prefix;
>  	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
>  
> -	help = argc == 2 && !strcmp(argv[1], "-h");
> +	help = argc == 2 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help-all"));
>  	if (help && (run_setup & RUN_SETUP))
>  		/* demote to GENTLY to allow 'git cmd -h' outside repo */
>  		run_setup = RUN_SETUP_GENTLY;

OK.  That's obvious and straight-forward.  Behave as closely as the
case when "-h" is given, and let the lower-layer deal with the
differences between "-h" and "--help-all".

> diff --git a/parse-options.c b/parse-options.c
> index c3222cc9bb..e3ed42f709 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1464,9 +1464,14 @@ void show_usage_with_options_if_asked(int ac, const char **av,
>  				      const char * const *usagestr,
>  				      const struct option *opts)
>  {
> -	if (ac == 2 && !strcmp(av[1], "-h")) {
> -		usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
> -		exit(129);
> +	if (ac == 2) {
> +		if (!strcmp(av[1], "-h")) {
> +			usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
> +			exit(129);
> +		} else if (!strcmp(av[1], "--help-all")) {
> +			usage_with_options_internal(NULL, usagestr, opts, style_full, to_out);
> +			exit(129);
> +		}
>  	}
>  }

Again, that is obvious and straight-forward.

> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index e235ecccde..b26a03d8a0 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -127,6 +127,10 @@
>  		test_expect_code 129 nongit git $cmd -h >usage &&
>  		test_grep "[Uu]sage: git $cmd " usage
>  	'
> +	test_$expect_outcome "'git $cmd --help-all' outside a repository" '
> +		test_expect_code 129 nongit git $cmd --help-all >usage &&
> +		test_grep "[Uu]sage: git $cmd " usage
> +	'
>  done
>  
>  test_expect_success 'prune does not crash with -h' '
> diff --git a/usage.c b/usage.c
> index 81913236a4..4c245ba0cb 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -192,7 +192,8 @@ static void show_usage_if_asked_helper(const char *err, ...)
>  
>  void show_usage_if_asked(int ac, const char **av, const char *err)
>  {
> -	if (ac == 2 && !strcmp(av[1], "-h"))
> +	if (ac == 2 && (!strcmp(av[1], "-h") ||
> +			!strcmp(av[1], "--help-all")))
>  		show_usage_if_asked_helper(err);
>  }

This looks good.

I don't understand your "I originally considered leaving out ..." at
all.  We are special casing a lone "-h" here already because we know
this is where we should stop without exercising unnecessary code
because we may not even have repo!=NULL and that is the reason why
this function exists in the first place.  It is obvious to me that
we need the same special casing for "--help-all".

In other words, I think all the above changes are good.

Thanks.
