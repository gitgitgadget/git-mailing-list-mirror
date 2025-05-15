Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFD17A30B
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317485; cv=none; b=TeSTUjZtt97QF5k943BtiNhyYq4f199n6Ha1vPmIsFBx05BgR5lgyT7GU9OOEkJygAYWPFrt4WiAIbpI/w88VGDBjjGvKGzzO9sIFMhgnRU0DqepnvA1JLaTuYK0WDVi4RQKMOjut4LjJHD9iXDUhU0eRqgGL/9p1hLpK0bd8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317485; c=relaxed/simple;
	bh=CaeF3FxsdNT9sdODSMqkaZ4L5H+Sr0cTHs0JbYDHKU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u2xJ+S05y4h/jqUwJqK/BK1loY0JphccVhTqtIME67W/vCY4FLQBsUUsGvnaHXnGznhVe2st3ShJQrpRyhoaAXmV+YLRpNjIHQJZ3p26gr37tPG7TyQhjQY0cD3oOU6M9NoeOdnHNN96PNGh3hM2HRCHn6sZySlr47LvzNwlgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2TWafWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hawqIWnK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2TWafWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hawqIWnK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F6951140188;
	Thu, 15 May 2025 09:58:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 15 May 2025 09:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747317481; x=1747403881; bh=7Culp1mTSF
	6iUes99X1PS3XOELOL3fElBwHGw86MMYg=; b=J2TWafWJaJJ3CiTiq3Pn5wQH8d
	8r3YX4ZN8WgfBaZxEyI+g/WuAuBFCqD5q52OWH6O5nBHFkkjfackiOU5+5YukpvY
	yBXy6JZoqJdOXXeU20docabqkkaJ5nCUUO53//Y8ylWSeoQay/uj5e+3X47M5TzX
	OM5+JzzWU+3tnIAos+jZqle+9DI00LzWbcUjRczLBUpYi69zXo8UzHX9P9TeXrjV
	a8QM23t1sbAcqq/pS8k9prv/ZoI+typqxmFpf+O04UvAFlykqHe7ZgVzs3LwGWuV
	WCHaRlnJBJCwCXTFx4g0TK/JK+0mIVv8qQWh7eQzbsstHkBwtnlPMzFx6YDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747317481; x=1747403881; bh=7Culp1mTSF6iUes99X1PS3XOELOL3fElBwH
	Gw86MMYg=; b=hawqIWnKR8FQXes3/lC53HOFaNtb4v79hAdvE3qcROxtNvaDOW3
	cHFv5QA0XXtdgEfRARx4jxGKx5OVLis+kTrL0EFx+oot1gpCUsHdDqCqz5qgwsB2
	uvbpDASbMq3+6RNnVMeaqBGLmqWyPFrVGs2hdIdgVx8hrHEmiqHeiNS7oUEXFh3T
	6epNlzCiJWxMddWnzTdr2f2AupzrPMbIHExmZM+Z/Ar73394jk/mM9ehiaIr5xhF
	T4qlW5jM7wrZYa/loaMshFBT4ogW4jKLi34ecTIVS6kCtgioCUbyrJSrfUTZVlxC
	bzVJ36ET1zQTTFYeY/FSUxsbJSsw9K7hRIQ==
X-ME-Sender: <xms:6fIlaBfuv_-oJPUP9aNcopY6Oi7myG-3zocTiB3bgdcQvEChpck1hA>
    <xme:6fIlaPMlywsYeUh7D_8Qnr3N6FbDIS5cMlBOrrZG-zpi-bNQOgkfjNJYKDt9b0HWV
    ZwGl1Vs1sW7u-TlLQ>
X-ME-Received: <xmr:6fIlaKjS-zbbEpFEyu7CqnjZASRM4zfx6ASwFnS7gftNr8OCHMoS1chwSOFo89YxDxDAV-992cAfsygPjHyLLLBYf70L0-cvtpN7MCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghilhhltgehie
    duleeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6fIlaK8NP9B1Y_3hQvOSd-QxNxweTkmsTpr8cXchwP1RHuiO_NPO0g>
    <xmx:6fIlaNvRu-yHWWtX6TJ9_IiV8KSth4-KtQx7hKMWBhxQopJfGLjVeA>
    <xmx:6fIlaJG4TWus7pJuwR4j8u8c_12H8Kl1sLDkJSuQIdg-pgzylXOA1Q>
    <xmx:6fIlaENtM9oA0haxPjSpQXEscdDKoJWwAxfuK2oraSV9I8r1oN7jjw>
    <xmx:6fIlaG5f8ySMuULJJwAppX4t7ZsTQ387gXaOkdXKc30evBOfDfNBtVse>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 09:58:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mr Bill <billc56196@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Handle rebase fork-point options in pull --rebase
In-Reply-To: <06beff46-cdaf-91c8-e6a3-6557694af618@gmail.com> (Bill's message
	of "Wed, 14 May 2025 12:37:26 -0500")
References: <06beff46-cdaf-91c8-e6a3-6557694af618@gmail.com>
Date: Thu, 15 May 2025 06:57:59 -0700
Message-ID: <xmqq5xi23riw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mr Bill <billc56196@gmail.com> writes:

Welcome to the community and thanks for a patch.

>> Content-Type: text/plain; charset=utf-8; format=flowed

That is a sign that the patch itself cannot be used mechanically, as
format=flawed is known to corrupt patches.  But still, let's read on.

> This is a patch to handle --fork-point and --no-fork-point in pull --rebase.
>
> I had a recent bug report about pull --rebase not working correctly...
>
> but it was working correctly, but not doing what I expected due to always
>
> using "merge-base --fork-point"
>
> This patch implements handling the --fork-point and --no-fork-point options,
>
> and also checks the config rebase.forkpoint value...
>
> and it works to resolve my prior bug report issue.
>
> If there are any questions or comments, let me know!
>
> Thanks to all for the help and comments on my prior bug report!
>
> -Bill

The above is not quite usable as log message.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  You may want to check a few examples in "git log
--no-merges master..seen" to get yourself familialized to the style.

Also check Documentation/SubmittingPatches; you'd need to sign off
your patch with your real name, which should match the authorship
identity (i.e. "From: " line of your message and "Signed-off-by: "
trailer should both have your real name plus e-mail address).

> diff --git a/builtin/pull.c b/builtin/pull.c
> index a1ebc6a..f2d405f 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -117,6 +117,10 @@ static int opt_show_forced_updates = -1;
>  static const char *set_upstream;
>  static struct strvec opt_fetch = STRVEC_INIT;
>
> +/* options to include rebase fork-point preference */
> +static int config_fork_point = -1;
> +static int opt_fork_point = -1;
> +
>  static struct option pull_options[] = {
>     /* Shared options */
>     OPT__VERBOSITY(&opt_verbosity),

As I already said, the patch part is all whitespace damaged and this
patch will not be usable as-is, but let's see if the logic is sound.

> @@ -253,6 +257,10 @@ static struct option pull_options[] = {
>         N_("set upstream for git pull/fetch"),
>         PARSE_OPT_NOARG),
>
> +   /* rebase option to use/not use merge-base --fork-point */
> +   OPT_BOOL(0, "fork-point", &opt_fork_point,
> +       N_("rebase with 'merge-base --fork-point' to refine upstream")),
> +
>     OPT_END()
>  };
>
> @@ -366,6 +374,9 @@ static int git_pull_config(const char *var, const
> char *value,
>     if (!strcmp(var, "rebase.autostash")) {
>         config_autostash = git_config_bool(var, value);
>         return 0;
> +   } else if (!strcmp(var, "rebase.forkpoint")) {
> +       config_fork_point = git_config_bool(var, value) ? -1 : 0;
> +       return 0;

This is curious.  I would have expected it to return the value
returned by git_config_bool() as-is, because "-1" is used as
"unspecified" to initialize the config_fork_point variable.  With
this code, configuring "[rebase] forkpoint = true" is a no-op, no?

Assuming that it is fixed ...

> @@ -1059,7 +1070,17 @@ int cmd_pull(int argc,
>                 N_("pull with rebase"),
>                 _("Please commit or stash them."), 1, 0);
>
> +       if (opt_fork_point == -1)
> +           opt_fork_point = config_fork_point;
> +       if (opt_fork_point < 0)
> +           opt_fork_point = 1;

... this code looks reasonable.  opt_ and config_ are both
initialized to "-1" (unspecified), so if there is no command line
option given to affect the setting, we read from config_, and if
neither specifies the settings, we enable the fork-point option.

> +       fprintf_ln(stderr, _("rebasing %s fork-point"),
> (opt_fork_point ? "with" : "without"));

This looks like a debugging aid, not to be left for production.

Besides, interpolating literal "with" in _("localizable string") 
does not make much sense.

> +       /*
> +        * If we're *not* using fork-point, or we don't find one in
> get_rebase_fork_point(),
> +        * clear the rebase_fork_point info.
> +        */


> -       if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
> +       if (!opt_fork_point ||
> get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
>             oidclr(&rebase_fork_point, the_repository->hash_algo);

Doubly besides, until we pass this point, we do not know if we are
rebasing with fork-point.  The configuraiton, option, or the
hardcoded default might have made opt_fork_point to true, but if
get_rebase_fork_point() failed, we won't be rebasing with fork-point
so the above debugging aid message we saw earlier, even if it were
useful in production, is given way too early before we know enough
to choose between "with" or "without".

This new feature needs to have tests.

The new command line option needs documentation.

The new configuration variable needs documentation.

Thanks.
