Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB51C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 19:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352778AbiBKTU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:20:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350999AbiBKTU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 14:20:56 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39449CEC
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:20:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id k10so10839403ljq.2
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4L+Dh9C/qk8qriJSwVQe2C7pzfzrNKKJXdvnYy7+szE=;
        b=PMpeMMdVhVHBxcqKQY4DrhaBeKxlpv3o8O5GvtiXT105Yd5aTP5V0NkO3UNyxCh9GK
         HAAshxZN/FYi2gOl33Iv8srRJt+cJAAM6J5hlgXOvfWkr4bwHFrIAmBWUgkM11Y/s4oa
         vXDRQzqX96sW2u3ppDT3ySoNbx/B/AV1Aoq/5XNNzkS/rY/HBZl6w4ubJ31eXdoIASOZ
         SPri6DM7vkfEB2VUgI6hybKIwLqHjW4l+0HHV8sN48hWKNTUN9G+ArPBN5AXxRbWbq4C
         yzjvqQcHcWCjAGw0L/eHJNohL8Vv8zdK9HAvGOLvt6AkyJUk2eKiwsomLh7IEOihIf1s
         hrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4L+Dh9C/qk8qriJSwVQe2C7pzfzrNKKJXdvnYy7+szE=;
        b=dO36ryB0lz3SMbaRZuMREQ6v4ztlqQe9kOMsrC1MtiqYwNBIh/LH4/Ul31xasdZEQa
         EdDkBsKlSD6fQSR115bytxAEjhRK4UimuyL9DChfNWnklAmx5U0IwZNls4JFltQg1RNP
         n7j3uSOOauqgh/4biK2hzrvMJvBKzvx2IEbDWW4p5PkWaYZBNK0CNckTmjj8FkuBkf7o
         sYtynAvcP/HsBRVVY8wlTgkx0eavjdbHcWWTmvg5P/XqlVQJkchNnFew2OvMQNGjnXC+
         yBZ8pXomChUNqMNvRnnT85y39al9tl9l59BG33IxdQlohNGpgXSU+OApFmTX1A9yC2X4
         C8Bw==
X-Gm-Message-State: AOAM531WVn7xd8b4pV7XbUEYYQf+8BYGjDhcRQcGrJ5LROt+bIPGv3t+
        +BcOwZSkcwOc5mMCWtbZ43pxpCBA+WLyAYcu4cQ=
X-Google-Smtp-Source: ABdhPJzKgFolOmfVJtKVEZAxfU/Ezqr/ULtU8BRcTD+nYPK8gVM1uDz6JXD9K04y+5sX1KhCXOdvz7MEKcbTXBg59KA=
X-Received: by 2002:a2e:a307:: with SMTP id l7mr1793410lje.363.1644607253335;
 Fri, 11 Feb 2022 11:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
 <20220211163627.598166-2-alexhenrie24@gmail.com> <xmqqa6exb51o.fsf@gitster.g>
In-Reply-To: <xmqqa6exb51o.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 12:20:42 -0700
Message-ID: <CAMMLpeQ_L+ogWtVj53gLB9ouVZeQ9-cr8oT63fGD4jJ_R4xj5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] log: add a --no-graph option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 12:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -934,6 +934,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> >               parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
> >       }
> >  parse_done:
> > +     revision_opts_finish(&revs);
>
> This ...
>
> > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> > index e7f7af5de3..228d782754 100644
> > --- a/builtin/shortlog.c
> > +++ b/builtin/shortlog.c
> > @@ -388,6 +388,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
> >               parse_revision_opt(&rev, &ctx, options, shortlog_usage);
> >       }
> >  parse_done:
> > +     revision_opts_finish(&rev);
> >       argc = parse_options_end(&ctx);
> >
> >       if (nongit && argc > 1) {
>
> ... and this.  It is a bit scary that we have to make sure all the
> users of parse_revision_opt() users need to call this new helper.
> Didn't we recently gain new documentation to help novices write
> their first revision-traversal-API-using program?  Does it need to
> be updated for this change (I didn't check)?

I don't see any documentation on how to use parse_revision_opt
directly; I only see documentation on how to use setup_revisions,
whose interface did not change.

Another approach would be to make a parse_rev_options_step function
that wraps parse_options_step and does the final steps when
parse_options_step returns PARSE_OPT_DONE. Would that be better?

> > diff --git a/revision.c b/revision.c
> > index 816061f3d9..a39fd1c278 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2424,10 +2424,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >               revs->pretty_given = 1;
> >               revs->abbrev_commit = 1;
> >       } else if (!strcmp(arg, "--graph")) {
> > -             revs->topo_order = 1;
> > -             revs->rewrite_parents = 1;
> >               graph_clear(revs->graph);
> >               revs->graph = graph_init(revs);
> > +     } else if (!strcmp(arg, "--no-graph")) {
> > +             graph_clear(revs->graph);
> > +             revs->graph = NULL;
> >       } else if (!strcmp(arg, "--encode-email-headers")) {
> >               revs->encode_email_headers = 1;
> >       } else if (!strcmp(arg, "--no-encode-email-headers")) {
> > @@ -2524,8 +2525,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >                       unkv[(*unkc)++] = arg;
> >               return opts;
> >       }
> > -     if (revs->graph && revs->track_linear)
> > -             die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");
> >
> >       return 1;
> >  }
>
> As a later "--no" can clear an earlier "--graph", we cannot
> incrementally check if options are compatible, until the end, at
> which time we can be sure that "--graph" is being asked.

Exactly. This is intentional, to avoid erroring out unnecessarily.

-Alex
