Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA511F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbeGKWMx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:12:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40389 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733130AbeGKWMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:12:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so19632479wrn.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C8fLvORvPxKb2ForyRs7A1e3mbfKWBuYnM5Tr/C1Y5I=;
        b=enG1Fj9IWmcUYIagx3A66Df0VBxeg5qqTaqd9a2D4eG5ECAqrmQddlAqd6J/hz2rGO
         Guc+MvHkyQUMP8jRywpvrMNpRbeUWtXEP1HsX+gvLXa8wS7NPio8IanUePg8CIVjY/a0
         wocjDZQNjLpo5UJTIBl80Wdzt7Q07amYk/keSKvrUjgHsU8cCLAivaAoaLQ42lr2CV83
         lDCdKWJLnVF9no1eV6MEPuHUci564w6Nw5PKVRKSsFP4hV9iBNZMLrE4OrVat5smvdsD
         H5R1XXPXAN5/PTc0mFo+y8+w41yXuEWk08p4x8XwOkyFB7bBAhjRLVWWFBbn+sI9LQOE
         zhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C8fLvORvPxKb2ForyRs7A1e3mbfKWBuYnM5Tr/C1Y5I=;
        b=Ze2pV32QayWz+F36yQdGK1h3TmnKtPcK5j5UhOCbb3UsRwap0VXYZSGn06WhoT+5ci
         5XzDkO4IKrHaBMsVULs18kN6XnxMKKw4wwjI3uunXR7/Bhgl7Ww3y8+btuzOfOVCuEMn
         +6x+GA+J0ICek4CC3PwptPZNyjjyP8XK/symEs3JygDa2ol5pvX9VqKC5yMsQz5njFfn
         TkGUs/E9S0LoRFOEYLu0zxaWrYw2UTG55BYpC6ZwFNKbF2d/U6VY+dE8Anrmesgp+naj
         PEwgG9g2I0oFbZMF4sLHUiQQKA77CeZBGbZ7s7FBOFSKAD3UHmuvwir2BEXcW9FdCnE2
         pG2Q==
X-Gm-Message-State: AOUpUlFFjTLYMslAnis+lkxt8tY+PnDgSW+0mN08UPiau7cHR3u+lkRv
        YxNY2osd5Yt7EfQu8NFu/Xg=
X-Google-Smtp-Source: AAOMgpfYePhJP0aQrbLIv34HWm+oxwOqOzG1t3wwR9CEyN2nPHB7Q9vlvI7p3F/SNWduOdAR7U0WYQ==
X-Received: by 2002:a5d:60c5:: with SMTP id x5-v6mr281837wrt.232.1531346786598;
        Wed, 11 Jul 2018 15:06:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p3-v6sm35068725wrg.47.2018.07.11.15.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 15:06:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] merge: allow reading the merge commit message from a file
References: <pull.8.git.gitgitgadget@gmail.com>
        <9e2c1fe83178f7047d8f2aacaa961381a4894081.1531312689.git.gitgitgadget@gmail.com>
Date:   Wed, 11 Jul 2018 15:06:25 -0700
In-Reply-To: <9e2c1fe83178f7047d8f2aacaa961381a4894081.1531312689.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 22 Dec 2017
        15:10:02 +0100")
Message-ID: <xmqqbmbd1l7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is consistent with `git commit` which, like `git merge`, supports
> passing the commit message via `-m <msg>` and, unlike `git merge` before
> this patch, via `-F <file>`.
>
> It is useful to allow this for scripted use, or for the upcoming patch
> to allow (re-)creating octopus merges in `git rebase --rebase-merges`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-merge.txt | 10 +++++++++-
>  builtin/merge.c             | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 6a5c00e2c..537dca7fa 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
>  	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>  	[--[no-]allow-unrelated-histories]
> -	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
> +	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
>  'git merge' --abort
>  'git merge' --continue
>  
> @@ -75,6 +75,14 @@ The 'git fmt-merge-msg' command can be
>  used to give a good default for automated 'git merge'
>  invocations. The automated message can include the branch description.
>  
> +-F <file>::
> +--file=<file>::
> +	Read the commit message to be used for the merge commit (in
> +	case one is created).
> ++
> +If `--log` is specified, a shortlog of the commits being merged
> +will be appended to the specified message.
> +
>  --[no-]rerere-autoupdate::
>  	Allow the rerere mechanism to update the index with the
>  	result of auto-conflict resolution if possible.
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 4a4c09496..b0e907751 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -111,6 +111,35 @@ static int option_parse_message(const struct option *opt,
>  	return 0;
>  }
>  
> +static int option_read_message(struct parse_opt_ctx_t *ctx,
> +			       const struct option *opt, int unset)
> +{
> +	struct strbuf *buf = opt->value;
> +	const char *arg;
> +
> +	if (unset)
> +		BUG("-F cannot be negated");

The message "-F cannot be negated" looks as if it is pointing out a
mistake by the end user, and does not mesh well with the real reason
why this is BUG() and is not die().

I understand that this is BUG() not die() because options[] array
tells this callback not to be called with unset by having the
PARSE_OPT_NONEG bit there.

> +	if (ctx->opt) {
> +		arg = ctx->opt;
> +		ctx->opt = NULL;
> +	} else if (ctx->argc > 1) {
> +		ctx->argc--;
> +		arg = *++ctx->argv;
> +	} else
> +		return opterror(opt, "requires a value", 0);
> +
> +	if (buf->len)
> +		strbuf_addch(buf, '\n');

Do we assume that buf, if it is not empty, is properly terminated
with LF already?  I am wondering if the real reason we do these two
lines is to make sure we have a separating blank line between what
is already there (if there already is something) and what we add, in
which case the above would want to say

	if (buf->len) {
		strbuf_complete_line(buf);
		strbuf_addch(buf, '\n');
	}

instead.

> +	if (ctx->prefix && !is_absolute_path(arg))
> +		arg = prefix_filename(ctx->prefix, arg);
> +	if (strbuf_read_file(buf, arg, 0) < 0)
> +		return error(_("could not read file '%s'"), arg);
> +	have_message = 1;

A similar question is what we would want to do when the file ends
with an incomplete line.  With "--log", we would be appending more
stuff to buf, and we'd want to complete such an incomplete line
before that happens, either here or in the code immediately before
"--log" is processed.

> +
> +	return 0;
> +}
> +
>  static struct strategy *get_strategy(const char *name)
>  {
>  	int i;
> @@ -228,6 +257,9 @@ static struct option builtin_merge_options[] = {
>  	OPT_CALLBACK('m', "message", &merge_msg, N_("message"),
>  		N_("merge commit message (for a non-fast-forward merge)"),
>  		option_parse_message),
> +	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
> +		N_("read message from file"), PARSE_OPT_NONEG,
> +		(parse_opt_cb *) option_read_message },
>  	OPT__VERBOSITY(&verbosity),
>  	OPT_BOOL(0, "abort", &abort_current_merge,
>  		N_("abort the current in-progress merge")),
