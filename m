Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC0C388F2
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85354206F8
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liW2bsxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgKCKP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgKCKP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 05:15:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A6C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 02:15:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e6so615059wro.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLsijYEFvZ6tPZ1Y4ruSQgVbq2QXjtaHuSp79nCjRDY=;
        b=liW2bsxmnoGRFlIib86r+GnodBQ23UQ3l/96ZjiCQ+SyRtI5gSIOJiK0lE1LxdeEeY
         V5N/6jcdftX2b7SyJx0T6LDad2mabzWgOfWAdEFi2Qk9ZeOHEAJsMR/uGfQc+u67ZQmX
         36qxaLcvPjAzXbtJh+/5lE3J6Rwc6lH6K84IexOoCsA2GQJQdZG8irDzvioELziv+30Y
         UthtBZthc+azWHNBBHUdzHtQ+0yw5+l4v8WwCNL2yFH0Z0FU/nizKe2emcOnHjadnYm2
         quqLN8YiSJhpEjSoSDmzkVDk9JZTCdFxe0cleMUdLN50fPREpgZBnpfowXGypIkoyST/
         xOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLsijYEFvZ6tPZ1Y4ruSQgVbq2QXjtaHuSp79nCjRDY=;
        b=lz/YgCW6ILrcSYebvz/DMnhVCbZnLnM3CLuQBfsqh2Z1fGM26G5oLmL6/4xZSgiowm
         IaVBXe1U79s8abt6jY69HoS2A5PynpHQk+h+c+0t/pNJFcgCjp6TdirsCtRexuQT3fL+
         puCPAUGAMJB3jY1hpPcPW7zuU9D6OqdVIFFTGw+r8BC6RutwkDJ0FZoS9LIV+HPdHcMG
         lzhPFKzkPkHagO0GPdARWw8mKZqBWdt38z8lDkpM0X/S+ol5EliNW2fOzDdAA1ztcNpi
         x6ny/7Xa8eWRtDF/M/48qTEb6wg2jiYNNZEShuSOhODKnV2SR7i9CnPdgWC+svRjhzAa
         gGVg==
X-Gm-Message-State: AOAM530VOK5saMLrBdR6LZV+yOZszk4U9AJescK1qsH6YuiluglFI/cH
        M73ssgcxbnBrcrtza9vnvszLiD6LTN0=
X-Google-Smtp-Source: ABdhPJxLMXL7S1Xb9WYT8okr93b9FpfbuFwO47vT9n1MS4W8KzvW3ruxA/0HBKsZZrJm+3tWnK1Fdw==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr24955608wrl.325.1604398555541;
        Tue, 03 Nov 2020 02:15:55 -0800 (PST)
Received: from szeder.dev (94-21-29-156.pool.digikabel.hu. [94.21.29.156])
        by smtp.gmail.com with ESMTPSA id l16sm24916405wrx.5.2020.11.03.02.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 02:15:55 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:15:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
Message-ID: <20201103101553.GH24813@szeder.dev>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102144321.GA3962443@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 09:43:21AM -0500, Jeff King wrote:
> On Mon, Nov 02, 2020 at 03:59:59PM +0200, Sathyajith Bhat wrote:
> 
> > Simple repro steps
> > 
> >         mkdir git_segfault_test && cd git_segfault_test && echo
> > "Hello" > hello.log
> >         git init && git add hello.log && git commit -m "init commit"
> > 
> > Now, use git log to show commit logs using command
> > 
> >         git log  --follow -L 1,1:hello.log -- hello.log

While Git should never segfault, no matter what, this is a bogus git
invocation to begin with: the second sentence in the description of
'git log -L' clearly states that "You may not give any pathspec
limiters", so this command should have errored out from early days,
but, unfortunately, it was never enforced.  This also means that '-L'
and '--follow' are incompatible, because while the former forbids any
pathspecs, the latter requires exactly one; and line-level
log does its own rename following anyway.

VS Code should be fixed to call 'git log -L 1,1:hello.log' instead,
without '--follow' and without pathspec.

> > What did you expect to happen? (Expected behavior)
> > Git should not segfault
> 
> Thanks for making this reproduction recipe! I can easily see the problem
> on my system. Looks like the segfault was introduced by a2bb801f6a
> (line-log: avoid unnecessary full tree diffs, 2019-08-21). I've cc'd the
> author.
> 
> That commit causes the line-log to clear the set of pathspecs, but the
> --follow option requires exactly one pathspec (and it even makes sure
> the user gives us one, but that happens before we clear it internally).
> Something like this makes the segfault go away:
> 
> diff --git a/line-log.c b/line-log.c
> index 42c5e41f68..f789863928 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -847,6 +847,7 @@ static void queue_diffs(struct line_log_data *range,
>  		clear_pathspec(&opt->pathspec);
>  		parse_pathspec_from_ranges(&opt->pathspec, range);
>  	}
> +	opt->flags.follow_renames = 0;
>  	DIFF_QUEUE_CLEAR(&diff_queued_diff);
>  	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
>  	if (opt->detect_rename && diff_might_be_rename()) {
> 
> but I'm not clear on how "--follow" and "-L" are supposed to interact.

They shouldn't, I would say.  Though it would be great if their
rename-following logic would be unified.  In particular, line-level
log does a better job at rename following in some ways, notably it can
track multiple files at once, while '--follow' can only handle a
single file.  So I think the rename following logic should be
extracted from 'line-log.c' and made more generic, and it should be
used to implement '--follow', removing some restrictions of the
latter, not to mention removing the duplicated logic.

(This might be a good GSoC project, though some of Linus' remarks in
750f7b668f (Finally implement "git log --follow", 2007-06-19) like
"you did have to know and understand the internal git diff generation
machinery pretty well, and had to really be able to follow how commit
generation interacts with generating patches and generating the log"
and "this patch does seem to be firmly in the core "Linus or Junio"
territory" are worrying...)

> I
> wouldn't expect --follow to do anything at all with line-log (nor for it
> to be useful to specify pathspecs outside of the -L option). So possibly
> this is restoring the behavior prior to that commit, or possibly it's
> just papering over a breakage. ;)

Perhaps, though arguably the original breakage was that 'git log
-L...:file -- file' was meant to error out, but it didn't.

