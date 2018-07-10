Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355651F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeGJSUY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:20:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46693 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbeGJSUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:20:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so15589511wra.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HiiQbYSIqi37RJ5/2+JH+wNkF/PISrWpUT7l7Efzk4E=;
        b=idyNx9mT/Tu2zINNGU+SN3DBjM8kAIfoyhLCX7p1s1dNZndFy+D/t9w6awp3jzuLNY
         LhumNkiazAS8dnOg2uwnODfOEpVRAVKe5dEg704x3U+DgeWR8It/Xme3byeN3CErDAiI
         OXhHapkMxUERxlVMFWbgx12VlxC7zBlYBiLvIqEjUC6W3zQgsN54Rftsq96KbOJQLA/Y
         u0SDnNATIsdd1rxfk9uqXzHkcEdIN8oT8zJxfbdXufmNS8pfYZaCY5fHvxB/9wP12rbB
         MRXKP8xCflzZCgopZcmSFCLeb/Kw1rpCblgOKphcxDY5M86uk4qZQVUpbiklV8oz+BX/
         +Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HiiQbYSIqi37RJ5/2+JH+wNkF/PISrWpUT7l7Efzk4E=;
        b=FL/VBAwVDA6wzsihxheGw9y+S80Tcl/IRdW6j/7HALBxyKkYxIhSTC+92uMvT/ejQW
         1sYVmQF8ElNW1FeyKv1z2MmBBF6s5WOL+lpZ1eltmzgmgZ2hdR0IZOtco6S3z6MB9ec5
         EijVZqwPZfnaR3tJaMWpfjeh1JtVooCWBaBI+NPNJeIZHbpqKC9CVS72OmH3YXrVqjje
         940/+i7PNlj0Dbfi5l0ldkixzHOnghov9YCCOKvYNY0G9UrdTpTe6rtYFFbWPnhb0K8J
         fWeqN6pVDAKAF8mVsp/FaOf7l0QPkjVVIBB+jzfrFC2rMRzNZZj8xKIcVFrmLRJSCIBr
         wYfA==
X-Gm-Message-State: APt69E0EPrXwIIkzbxmiTQTjwuyKds+KsdGSNOPc0H+HD3L9LA0PRfS4
        uY8zpFdbQTVeObQU5h4NQ/I=
X-Google-Smtp-Source: AAOMgpcF2rc4pN1mG5RDWKzv8r0EagODRdUs0mePAyJ9hPZWHMRix7xW4ASEKl1g0//d+DdDicIgCg==
X-Received: by 2002:adf:ce88:: with SMTP id r8-v6mr17635392wrn.112.1531246814188;
        Tue, 10 Jul 2018 11:20:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w9-v6sm12442982wrr.77.2018.07.10.11.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:20:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 06/13] rebase -i: rewrite setup_reflog_action() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-7-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:20:13 -0700
In-Reply-To: <20180710121557.6698-7-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:50 +0200")
Message-ID: <xmqqlgaj6jhe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites (the misnamed) setup_reflog_action() from shell to C. The
> new version is called prepare_branch_to_be_rebased().
>
> A new command is added to rebase--helper.c, “checkout-base”, as well as
> a new flag, “verbose”, to avoid silencing the output of the checkout
> operation called by checkout_base_commit().
>
> The function `run_git_checkout()` will also be used in the next commit,
> therefore its code is not part of `checkout_base_commit()`.
>
> The shell version is then stripped in favour of a call to the helper.
>
> As $GIT_REFLOG_ACTION is no longer set at the first call of
> checkout_onto(), a call to comment_for_reflog() is added at the
> beginning of this function.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--helper.c   | 10 ++++++++--
>  git-rebase--interactive.sh | 16 ++--------------
>  sequencer.c                | 30 ++++++++++++++++++++++++++++++
>  sequencer.h                |  2 ++
>  4 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index 731a64971..76bdc6fdb 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -13,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
...
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -28,6 +28,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
>  		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>  			 N_("keep original branch points of cousins")),
> +		OPT__VERBOSE(&verbose, N_("be verbose")),
...
> @@ -60,6 +63,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  	opts.action = REPLAY_INTERACTIVE_REBASE;
>  	opts.allow_ff = 1;
>  	opts.allow_empty = 1;
> +	opts.verbose = verbose;
>  
>  	argc = parse_options(argc, argv, NULL, options,
>  			builtin_rebase_helper_usage, PARSE_OPT_KEEP_ARGV0);
> @@ -94,5 +98,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!append_todo_help(0, keep_empty);
>  	if (command == EDIT_TODO && argc == 1)
>  		return !!edit_todo_list(flags);
> +	if (command == PREPARE_BRANCH && argc == 2)
> +		return !!prepare_branch_to_be_rebased(&opts, argv[1]);

Not passing verbose as a separate parameter, and using opts.verbose
that already exists instead, is a sensible improvement from the
previous round.  I wonder if we need a new local variable, though?
Just like &opts.allow_ff is used directly in options[] array, can't
we give &opts.verbose to OPT__VERBOSE(), or would we break something
if we did so?


