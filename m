Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D82BC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 08:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiCKIof (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiCKIoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 03:44:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F19186202
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 00:43:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y22so10053563eds.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=23/7QRaotwhxpZprLvyMesMrYB+DzuOC9c4hf8kCaFQ=;
        b=FMOfQShcEf+uPFWZLORSpWB9KrJx/vKW33u/ANLnJ5daU8KjyevbDbk/X8tm5BT8Dr
         67jEX0O2/bdZDV8yPCHLN3hfbtZBr45AXyp6WSwbKKzFcrCC2iW8Ah8QDMUH9Az6cWOT
         Yxdj2Qx/Zcu04ypEB+lrRqKQ+3w8oVa7zUZ+zqCv/xvj3+x2+GJ4uRbBFNkLpZGbFLx3
         xYq3rfMwfDxuX/X8dBwn09Ia1CZb1tL3eGrCzDhOCfYQflFmlS3wqjwjQxX9p8nGmQZ2
         gLcmhSNSbXBcqCWGzAuaUFGTtg9SWYdZ8CgyCsnJBHOgKjOrdwLJ4N2SvHgdF08ufWd/
         Sakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=23/7QRaotwhxpZprLvyMesMrYB+DzuOC9c4hf8kCaFQ=;
        b=dthikR4JKhUY9MWwYDBfCxTDgWAvrde+j11XlylzAksANiTaaIdTjxVmJomP53KMIj
         1PAmqQsSpZpvaEmNon3bVRA8Vqh0JkLNx9N2XRvRuVeDD+aMO5swQfP55rEfxQsxg0nl
         OkcHNpNBWJMoN0Scn6atS563vHq6OeIw5WRwPFbFeN7s+4fg7AlqocbTPvQKUr0cUWc6
         qtBJlBD4sHTvMyTNj0B7cBFBaCqmoKGeGsqpDkhquwXK4zLCOr4fGV9aKOjHGtaCMNft
         TofEWPoZdq2eMIjjNzOcNDlekAbIoXhr012lKK4KS/Ji1gLtiYu1U+00rtrze7xOdByZ
         hXbQ==
X-Gm-Message-State: AOAM533GHH8MkVhTWA1/oid77664yOqEqeBOTjD37oNVqfeR6g2ftGov
        BT/qgT2MGpHlnYrIV9DbtGHZvi3J1JfdXg==
X-Google-Smtp-Source: ABdhPJzgC8kai5KVvamJbEOJGuFG914qZSvXuesgI0MR9ZAdmfHo4LHWtUb3oOfygUGaDzH8A8RZmw==
X-Received: by 2002:a05:6402:386:b0:415:ead8:ced with SMTP id o6-20020a056402038600b00415ead80cedmr7927684edv.407.1646988209425;
        Fri, 11 Mar 2022 00:43:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm3186907eda.2.2022.03.11.00.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:43:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSarw-000v7N-6D;
        Fri, 11 Mar 2022 09:43:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
Date:   Fri, 11 Mar 2022 08:48:51 +0100
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
 <xmqqo82dd0qv.fsf@gitster.g>
 <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
 <xmqqfsnpcxdm.fsf@gitster.g>
 <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
 <CAHk-=wj0ZfmTEhc4iPJSbn_FxzU94qZfK9WcgujKUcZK9a2UvQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAHk-=wj0ZfmTEhc4iPJSbn_FxzU94qZfK9WcgujKUcZK9a2UvQ@mail.gmail.com>
Message-ID: <220311.867d90j2vj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, Linus Torvalds wrote:

> On Thu, Mar 10, 2022 at 2:13 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

If it's not too much trouble inline patches like those you send to the
LKML would be preferred :) Re-arranging things a bit to quote them....

> diff --git a/diff.c b/diff.c
> index 2bd5e0d817..f37f0b383a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1254,6 +1254,8 @@ static void emit_line_ws_markup(struct diff_options *o,
>  	const char *ws = NULL;
>  	int sign = o->output_indicators[sign_index];
>  
> +	if (!sign)
> +		return;
>  	if (o->ws_error_highlight & ws_rule) {
>  		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
>  		if (!*ws)
> @@ -4986,6 +4988,10 @@ static int diff_opt_char(const struct option *opt,
>  {
>  	char *value = opt->value;
>  
> +	if (unset) {
> +		*value = 0;
> +		return 0;
> +	}
>  	BUG_ON_OPT_NEG(unset);
>  	if (arg[1])
>  		return error(_("%s expects a character, got '%s'"),
> @@ -4994,6 +5000,17 @@ static int diff_opt_char(const struct option *opt,
>  	return 0;
>  }
>  
> +static int diff_opt_no_char(const struct option *opt,
> +			 const char *arg, int unset)
> +{
> +	char *value = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +	*value = 0;
> +	return 0;
> +}
> +
>  static int diff_opt_color_moved(const struct option *opt,
>  				const char *arg, int unset)
>  {
> @@ -5476,17 +5493,27 @@ static void prep_parse_options(struct diff_options *options)
>  			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
>  			       N_("<char>"),
>  			       N_("specify the character to indicate a new line instead of '+'"),
> -			       PARSE_OPT_NONEG, diff_opt_char),
> +			       0, diff_opt_char),
>  		OPT_CALLBACK_F(0, "output-indicator-old",
>  			       &options->output_indicators[OUTPUT_INDICATOR_OLD],
>  			       N_("<char>"),
>  			       N_("specify the character to indicate an old line instead of '-'"),
> -			       PARSE_OPT_NONEG, diff_opt_char),
> +			       0, diff_opt_char),
>  		OPT_CALLBACK_F(0, "output-indicator-context",
>  			       &options->output_indicators[OUTPUT_INDICATOR_CONTEXT],
>  			       N_("<char>"),
>  			       N_("specify the character to indicate a context instead of ' '"),
>  			       PARSE_OPT_NONEG, diff_opt_char),
> +		OPT_CALLBACK_F(0, "new-only",
> +			       &options->output_indicators[OUTPUT_INDICATOR_OLD], NULL,
> +			       N_("show only new lines in diff"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_char),
> +		OPT_CALLBACK_F(0, "old-only",
> +			       &options->output_indicators[OUTPUT_INDICATOR_NEW], NULL,
> +			       N_("show only old lines in diff"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_char),
> +		OPT_ALIAS(0, "new", "new-only"),
> +		OPT_ALIAS(0, "old", "old-only"),
>  

FWIW the reason...

>>
>> Here's the stupid patch that "works" but doesn't allow the shortened
>> version. Maybe somebody can point out what silly thing I did wrong.
>
> I just created a short alias to do this. Maybe there's some smarter
> option, but this seems to work.

..you needed to do that is because we pass PARSE_OPT_KEEP_UNKNOWN
parse_options() there, which turns off our abbreviation discovery logic,
i.e. where we'll take a --foo, --foob, --fooba if we have a --foobar
option defined.

Looking at it there appears to be no good reason for why it's so
overzelous. If I remove the relevant PARSE_OPT_KEEP_UNKNOWN logic in
parse-options.c our entire test suite passes, except for one obscure
part where "git format-patch --output=x" needs to not abbreviate to "git
format-patch --output-directory=x".

Which, for reasons is something where we do option parsing in two
passes, i.e. we hand the "output" option off to the revision walker.

We really should just teach those callsites to "grab" the revisions.c
options and do the parse in one pass, but in the meantime this is a less
invasive way to have that case work, which makes your code work without
the OPT_ALIAS() hunk:

	diff --git a/builtin/log.c b/builtin/log.c
	index c211d66d1d0..adacc65bc7e 100644
	--- a/builtin/log.c
	+++ b/builtin/log.c
	@@ -1811,7 +1811,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
	 			    PARSE_OPT_NONEG, subject_prefix_callback),
	 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
	 			    N_("dir"), N_("store resulting files in <dir>"),
	-			    PARSE_OPT_NONEG, output_directory_callback),
	+			    PARSE_OPT_NONEG | PARSE_OPT_NO_ABBREV,
	+			    output_directory_callback),
	 		OPT_CALLBACK_F('k', "keep-subject", &rev, NULL,
	 			    N_("don't strip/add [PATCH]"),
	 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback),
	diff --git a/parse-options.c b/parse-options.c
	index 6e57744fd22..9d0c4694482 100644
	--- a/parse-options.c
	+++ b/parse-options.c
	@@ -332,7 +332,7 @@ static enum parse_opt_result parse_long_opt(
	 			rest = NULL;
	 		if (!rest) {
	 			/* abbreviated? */
	-			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
	+			if (!(options->flags & PARSE_OPT_NO_ABBREV) &&
	 			    !strncmp(long_name, arg, arg_end - arg)) {
	 is_abbreviated:
	 				if (abbrev_option &&
	diff --git a/parse-options.h b/parse-options.h
	index 685fccac137..f6372f60edb 100644
	--- a/parse-options.h
	+++ b/parse-options.h
	@@ -48,6 +48,7 @@ enum parse_opt_option_flags {
	 	PARSE_OPT_NOCOMPLETE = 1 << 9,
	 	PARSE_OPT_COMP_ARG = 1 << 10,
	 	PARSE_OPT_CMDMODE = 1 << 11,
	+	PARSE_OPT_NO_ABBREV = 1 << 12,
	 };
	 
	 enum parse_opt_result {

Of course that also makes --new and --old work (even --ne and --ol), but
we generally accept that in other places, so... :)

> I've updated the commit message - I kept the --no-output-indicator-xyz
> form since it really logically ends up being exactly that, but I guess
> those changes could also be dropped.

I see this interacts nicely with the -I option, at least in my testing,
i.e. (with my change applied) this will ignore the first hunk of your
patch:

    --new -p -I'sign|return'

What this doesn't interact "well" with, or perhaps it's what we actually
want is e.g. -G:

    git log -1 -p -G'PARSE_OPT_NONEG, diff_opt_char' --new

If the user is expecting us to search through the displayed hunks this
should not show your change, but it does.

FWIW I have a local patch I've been meaning to submit which extends -G
to allow you to search through the full displayed context, right now we
strip it down to the "+" and "-" lines and regex match on that.

So you could do, in this case:

    git log --pickaxe-patch -G'^-.*diff_opt_char' -1

To search through your removed hunks.

All of which is to say that I think the core semantics you're
implementing here make sense, it's just worth thinking about, and we
should have tests for some of the edge cases for a non-RFC. I.e. it's
not obvious that we have a couple of diff "passes", and -G, -I and these
--new-only and --old-only options search through different versions of
that diff.
