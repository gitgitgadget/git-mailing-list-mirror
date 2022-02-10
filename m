Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B87C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244819AbiBJQuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:50:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbiBJQuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:50:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E0EE
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:50:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so11601146lfc.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umhh3kM43kWPAgJA43zHV4YWXdq6Zbs7fObKUzQLFVc=;
        b=FfEImUyAhkNVBbLj7tBEaX6J+SzUhH4gb4SR9I/UrH1XDEuFYb0e4jmrVcW/4dazxV
         k+a2xdhtqgxTKMIB0DlyCfM50uSoUx7oXAQ0RD2eaRLH9wVWFlRg7ZSgOg8YmB28VFau
         mlE1kNxritkozev983jVE0g2gyl6ZP8+uWWcccJCW78WkKp0Q1fCsO9DgR5YKmFRap5G
         IUpclI8h0/6YomScuaeRQFJVzM8f1KpdtOtd5ly2kremNxtTz9xtQZXdBmitRmYUnuz5
         9DSKcOpKWJbDQgh9QYfMXdXILulujhLSorFrh3jlLxY9UR9K8419JgauIoI8HPYSvtbw
         xh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umhh3kM43kWPAgJA43zHV4YWXdq6Zbs7fObKUzQLFVc=;
        b=YE+moeUQZYhb2Ao2/48n35K1X9yoObahzdq28nkQng5BtdYQjCNaEhDpdxqlG9A+gA
         O2SFp/1RLiLviJcM4B8tCMC4iIjWmdkWNLsTYXO3Fg7uM2nKSlj+Hy0pemdFalvTDQ36
         8A4N60bgfCrNs6cComn8NyYrRush1vgvyDLYN7NX3yaIDsa3s9iQHr21kJDGMZKL5BjT
         OUG5yYp9FNpfnDHU+VSLARyO7SemmL72z0qR3H+EgE7T/Gz0DIOZIrThczAo0XxJC85I
         iQIYuiMxiSUBdP6+lkOPuf+1tsLpLKyxuNvC05lHzPU2IGtn3wN59Mme2qSmQGkand9G
         gwcw==
X-Gm-Message-State: AOAM533xqNWKUj7exgHWTtimkUUF5JRcSPn6h0rScMUQibKL8AC/tRSa
        g/1YQpUHn0WvDESW54rIUPkTBcOdfEKa8J+8D7vyyNrg
X-Google-Smtp-Source: ABdhPJynxNKRXxVPfMbBS5t31LTPIbutikIgbZKp2Ds9PN1CSIgxNfwR7gLognRY10xXsBjeNftrapuYAIkqQs6oAwk=
X-Received: by 2002:ac2:55b3:: with SMTP id y19mr1920203lfg.656.1644511807987;
 Thu, 10 Feb 2022 08:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
 <20220209162350.169971-2-alexhenrie24@gmail.com> <xmqq4k5799sf.fsf@gitster.g>
In-Reply-To: <xmqq4k5799sf.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 10 Feb 2022 09:49:55 -0700
Message-ID: <CAMMLpeS9MrHdq4bNwDYUJ0ctAafsjLskXStcsO_vBnfngwor-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] log: add a config option for --graph
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 9, 2022 at 11:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > +     if (default_graph &&
> > +         !rev->graph &&
>
> This part I can see why we want to check ;-)
>
> > +         !rev->track_linear &&
> > +         !rev->reverse &&
> > +         !rev->reflog_info &&
> > +         !rev->no_walk) {
>
> But this makes me wonder how we plan to keep this list of "if the
> user asked for any of these options, we shouldn't turn graph on by
> default" up-to-date.  The scheme looks brittle.
>
> Also, what would happen when a developer wants to add, say
> log.reverse, configuration variable in the future?  I can see the
> block to do the equivalent of this for .log.reverse begins with
>
>         if (default_reverse &&
>             !rev->reverse &&
>
> but I am not sure what other conditions need to be checked,
> especially with 'graph'---should it check for !rev->graph or
> default_graph of both?  Are we playing with a potential
> combinatorial explosion?

In principle there's no reason why --graph and --reverse can't be
compatible. However, if both log.graph and log.reverse config options
are added while they are still incompatible, I think using them
together should trigger the existing option compatibility error in the
setup_revisions function:

        if (revs->reverse && revs->graph)
                die(_("options '%s' and '%s' cannot be used
together"), "--reverse", "--graph");

That said, we should make sure that --graph on the command line
overrides log.reverse in the config file (instead of dying), and the
same for --reverse overriding log.graph. How about this:

1. In git_log_config, initialize default_graph and default_reverse by
parsing log.graph and log.reverse.

2. In cmd_log_init_defaults, initialize rev->graph_default to
default_graph and rev->reverse_default to default_reverse.

3. In handle_revision_opt, set revs->graph if --graph is given, clear
revs->graph if --no-graph is given, and in either case clear
revs->graph_default. Set revs->reverse and revs->reverse_default
likewise.

4. In setup_revisions, if revs->graph_default is still true, set
revs->graph based on revs->reverse and revs->reverse_default. Set
revs->reverse likewise.

5. In setup_revisions, call a new revision_opts_finish function that
sets revs->topo_order and revs->rewrite_parents if necessary based on
the final value of revs->graph.

I think that would ensure that command line options interact correctly
with config options, plus it would allow adding a --no-graph command
line option, and the logic to handle defaults would be clearly linked
to the existing incompatible option checks. I realize that it will
take a bit of refactoring though. I'll send new patches shortly to
make it more clear.

Please let me know if any of your other feedback is still relevant in v2.

-Alex
