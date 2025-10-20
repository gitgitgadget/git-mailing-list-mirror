Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0724DD09
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976366; cv=none; b=PJ77dt/hk0r5H5f8LAsU1gTFNyYPcKNoSoCIDkRChmXr4VpjXKzZ3KfuedeZRUeCx3JUaZIm5/g0hG6ml6130mJkWp+MCX+O2JGqMs7+/ncJp/LycN48h5Y68GxE3No58p6Vt8kOx87puslaeqUzDRwQIQqdHKs66XeEc5rwQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976366; c=relaxed/simple;
	bh=ahxBxmJYNbmmnBNMAtFjpJvY6ZZHH3CNPO85z71pQP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KadKu9iWAtgNDuIVhqZLunT46sngwI/gbT9fffezXGwpgmkA4DZzbbP34ZW5r39mWd63ovdhiNhqeDHwAltbDxLe2PAi5xcl4v/oXE40pxurwL9xCdfoo/OAAX5tRNABNJwvhesSrLa6qniYa80T0BkCUFx5HwNMi74ZtMYnbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZIQ4r0Si; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RzkNxdjw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZIQ4r0Si";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RzkNxdjw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C1537A016B;
	Mon, 20 Oct 2025 12:05:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 20 Oct 2025 12:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760976359; x=1761062759; bh=31WGTh2y77
	9OoLABbW81uHFB3eqAPR23jnvG/8kP3OQ=; b=ZIQ4r0SiC0ylI9yJWThwtSCdYa
	+sX8nZ6yqvvZ4lNmPN59/RMsK66WflYnfVQsR0gEgWyfMrgbzmPuyCwPfXsxJpSj
	4rgNttYlf8Phcj0MIf2H7FT4eFtnB69UuuyXXyyTZMj4sX34sF9/i4jFGjqqLML2
	sPjj9zDc+ghfn7eEaMrqRPTR6ZbUQ4Egm3lTEZjWp5IjiV3jJCE8ySa7BOn7DykA
	I0JwNUVhYIx/EOh59cQvz8627EzJJ8IokcsxyzKQL5u2318Xu5mWH/VOffqFEgSo
	XU655hb+K/4Ge9N9ybkvyvZg0XeWEdB7VbOKRU+RhCcBAuCDBqzPCU77Ekyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760976359; x=1761062759; bh=31WGTh2y779OoLABbW81uHFB3eqAPR23jnv
	G/8kP3OQ=; b=RzkNxdjwq9Z6ZzQYqiuDtCYPxzZgRWQJxRlSCv3/32y5e/yNMCw
	ztIfqGgoNY8MJsgioMLj/KvtSqI/QKQzf2LRrGfi1h9nnObBwSbElqjQhqQ/lx/I
	Mhphj+rG6GgXtGqsJVG1uU+k1vRfe7HPQQL4FgqyGJfVoNyAFiHGOqTma8Q2G4+3
	Gq8FZ7r4fHcBdhFIQOOnhf3wF3bDpL+8lZsbaKxx+YRc1LNf1TA1/R19NKrEA49S
	V+RYtScMb0JYqe5MM7GKMXhHqpbRFzkqDvBR9r6aPDI7riufsO+p7c0j3Lfwv6GD
	1H2SMpwaRWj/DmrtfWhX1vSOspeO+08K7dw==
X-ME-Sender: <xms:5132aHXc58XOhIEJusJ_TNRc-wQbxCUzS_6d4qrUUMgcbkhmRXtemQ>
    <xme:5132aGfi0mBmebjIytyYREtJ90B5OlTXx1OlGRTzBfof82q6AyaMdrfxozOm1EnKD
    zgwVMGFWQerNmzPPyV_0XK-MFiMwjVvyfD7Sv2dqpvgwgRNdlaDGsI>
X-ME-Received: <xmr:5132aLuCOV14Z1guKD8Bl5nd_CuDwe9rd5AVg7Ru1n0nr2QpDzWTW_eSZ6MyF6ykvo7uq0VZqUmJIqbqfGRnFuqKE66hCvAML-kj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghnthhonhhinhesuggvlhhpvghutghhrdgvuhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5132aN_V9ZAAcLa7NcZtXdMKqLLo6yirHrvf7Vhmsk391e2s92Hg0A>
    <xmx:5132aO0mfFdKPtPgFxR9paAUy4j0wVQJILk7a3C4hZAOmJ6m7QGSSw>
    <xmx:5132aKDaTTcJArnOVN5tfhnTeggy5jUONhivI6E1Xnfw6C3dkrI76Q>
    <xmx:5132aCceSyCNeXiJy3F6BGvYV1SidV32kt8iThrM7mIl1icaqnPC5Q>
    <xmx:5132aGbM8lXPgARPFJ3LRz5DPcr2Xy504JOFXd6hDalQYJyHbMR6Iway>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:05:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Antonin
 Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH] blame: make diff algorithm configurable
In-Reply-To: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com> (Antonin
	Delpeuch via GitGitGadget's message of "Mon, 20 Oct 2025 14:56:02
	+0000")
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
Date: Mon, 20 Oct 2025 09:05:57 -0700
Message-ID: <xmqqldl51rtm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> The diff algorithm used in 'git-blame(1)' can be configured using the
> `--diff-algorithm` option or the `diff.algorithm` config variable.
> Myers diff remains the default.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.  This hasn't changed since your first commit to this
project a few years ago.

And when read with that expectation, I was surprised that "blame"
already paid attention to the command line option and configuration
variable, as that paragraph was supposed to explain what happens
without the patch being proposed.  It was a pleasant surprise that
turned out to be untrue X-<.

> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---
>     blame: make diff algorithm configurable
>     
>     There has been long-standing interest in changing the default diff
>     algorithm to "histogram", and Git 3.0 was floated as a possible occasion
>     for that: https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/
>     
>     As a preparation, it is worth making sure that the diff algorithm is
>     configurable where useful. It can have significant impact on the output
>     of the git-blame command, so I propose to make it configurable there
>     too. I have followed the convention of other commands (such as git-diff)
>     to introduce a --diff-algorithm option.

All of the above are good materials to be in the proposed log
message, not under the three-dash line, to explain the motivation
behind the change.

>     I understand that this command is a user-facing (porcelain) one, so I
>     think making it honor the diff.algorithm UI config variable is also
>     appropriate. The git-blame command has a machine-readable format that
>     can be enabled with --porcelain (which should be called --plumbing if
>     you ask me) so I wonder if the diff.algorithm variable should still be
>     honored in this case, as there could be the desire to keep it
>     independent from UI config variables (similarly to git-merge-file, a
>     plumbing command which doesn't honor diff.algorithm).

Good consideration and something we should make sure we do the right
thing for our users.  Personally, I would not be concerned---the
only folks that possibly affected are those who save old blame
output and wants a fresh "git blame" run they make today would
produce bit-for-bit identical output, but if they use newer versions
of Git with improved xdiff implementation, they cannot expect that
with or without the configuration knob _anyway_.  This is just my
personal opinion.  Others may differ.

>     If the general idea of this patch is judged worthwhile, I would be happy
>     to add tests to demonstrate the impact of the diff algorithm on blame
>     output.

Do not ever say this here.

I've seen from time to time people ask "I am thinking of doing this;
will a patch be accepted?  If so, I'll work on it." before showing
any work, and my response always has been:

 (1) We don't know how useful and interesting your contribution would
     be for our audience, until we see it; and

 (2) If you truly believe in your work (find it useful, find writing
     it fun, etc.), that would be incentive enough for you to work
     on it, whether or not the result will land in my tree.  You
     should instead aim for something so brilliant that we would
     come to you begging for your permission to include it in our
     project.

> diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
> index e438d28625..4beb2df551 100644
> --- a/Documentation/git-blame.adoc
> +++ b/Documentation/git-blame.adoc
> @@ -85,6 +85,27 @@ include::blame-options.adoc[]
>  	Ignore whitespace when comparing the parent's version and
>  	the child's to find where the lines came from.
>  
> +`--diff-algorithm=(patience|minimal|histogram|myers)`::
> +	Choose a diff algorithm. The variants are as follows:
> ++
> +--
> +   `default`;;
> +   `myers`;;
> +	The basic greedy diff algorithm. Currently, this is the default.
> +   `minimal`;;
> +	Spend extra time to make sure the smallest possible diff is
> +	produced.
> +   `patience`;;
> +	Use "patience diff" algorithm when generating patches.
> +   `histogram`;;
> +	This algorithm extends the patience algorithm to "support
> +	low-occurrence common elements".
> +--
> ++
> +For instance, if you configured the `diff.algorithm` variable to a
> +non-default value and want to use the default one, then you
> +have to use `--diff-algorithm=default` option.

Is this copied from somewhere else, or did you come up with the
above text yourself?  If the former, perhaps it is a good idea to
reduce the duplicattion.  Use of "include::line-range-format.adoc[]"
in Documentation/blame-options.adoc (which in turn is included by
Documentation/git-blame.adoc) may serve as a good model to include
the same text in multiple places (the "line-range" syntax thing is
included directly or indirectly and its text appears in a handful of
places as the result).  Copy the original text out into a new file
to be included (say, "diff-algorithm-option.adoc"), replace the
original text with "include::diff-algorithm-option.adoc[]", and then
add another "include::diff-algorithm-option.adoc[]" here in
git-blame documentation instead of duplicating the text like the
above hunk does.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 2703820258..177b606e81 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -779,6 +779,19 @@ static int git_blame_config(const char *var, const char *value,
>  		}
>  	}
>  
> +	if (!strcmp(var, "diff.algorithm")) {
> +		long diff_algorithm;
> +		if (!value)
> +			return config_error_nonbool(var);
> +		diff_algorithm = parse_algorithm_value(value);
> +		if (diff_algorithm < 0)
> +			return error(_("unknown value for config '%s': %s"),
> +				     var, value);

OK, this message is copied from git_diff_ui_config(), which is where
"git log" and 4 commands in the "git diff" family gets their error
message when "git -c diff.algorithm=bogus <cmd>" is run.  It is a
bit suboptimal, but users would know how to read the documentation
(even though in practice they never do), so let's say this is OK, at
least for now.

    For future reference (note: this is a #leftoverbits comment that is
    left here for the benefit of those who scan the list archive for
    ideas on what to do when they are absolutely bored without anything
    interesting to do, not meant as a suggestion to do anything of this
    sort before this patch lands), in addition to "git log" and 4
    commands in the "git diff" family,

     - merge-ort.c has the same message.
     - builtin/merge-file.c gives a bit nicer message but that is a bit
       of maintenance burden.
     - curiously "git log" and four commands in the "git diff" family
       give a much nicer message when a --diff-algorithm=bogus is given
       from the command line, but not in the configuration file.

    we may want to consolidate the error message into one place (a
    constant or "extern const char *diff_algorithm_error_message",
    or something else that is i18n friendly) and use it from all these
    places I just identified.

> +		xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> +		xdl_opts |= diff_algorithm;
> +		return 0;
> +	}

>  	if (git_diff_heuristic_config(var, value, cb) < 0)
>  		return -1;

This one relies on git_diff_heuristic_config() to give message when
it returns negative, so we do not have to do anything.  OK.

    Contination of the above #leftoverbits may be to see if
    parse_algorithm_value() is a good place to consolidate the error
    message, after auditing all its callers (if such a change turns
    out to be a good idea, they need to lose their own messages).

> @@ -824,6 +837,26 @@ static int blame_move_callback(const struct option *option, const char *arg, int
>  	return 0;
>  }
>  
> +static int blame_diff_algorithm_callback(const struct option *option,
> +					 const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +	long value = parse_algorithm_value(arg);
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (value < 0)
> +		return error(_("option diff-algorithm accepts \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));

You inherited the same "config error gets a message that requires
users to consult the manual, option error gets something a bit more
useful but is a maintenance burden" trait from "git diff" and family
here.  Let's say this is OK, too, at least for now.

> +	// ignore any previous --minimal setting, following git-diff's behavior

We do not do // comments around here, outside borrowed code.

> +	*opt &= ~XDF_NEED_MINIMAL;
> +	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
> +	*opt |= value;
> +
> +	return 0;
> +}
> +
>  static int is_a_rev(const char *name)
>  {
>  	struct object_id oid;
> @@ -908,13 +941,16 @@ int cmd_blame(int argc,
>  		OPT_BIT('f', "show-name", &output_option, N_("show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
>  		OPT_BIT('n', "show-number", &output_option, N_("show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
>  		OPT_BIT('p', "porcelain", &output_option, N_("show in a format designed for machine consumption"), OUTPUT_PORCELAIN),
> -		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
> +		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN | OUTPUT_LINE_PORCELAIN),

WHY?

>  		OPT_BIT('c', NULL, &output_option, N_("use the same output mode as git-annotate (Default: off)"), OUTPUT_ANNOTATE_COMPAT),
>  		OPT_BIT('t', NULL, &output_option, N_("show raw timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
>  		OPT_BIT('l', NULL, &output_option, N_("show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
>  		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>  		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>  		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
> +		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
> +			       N_("choose a diff algorithm"),
> +			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),

OK.

>  		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
>  		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
>  		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>
> base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
