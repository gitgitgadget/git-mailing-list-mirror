Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4271F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbeGSSNm (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:13:42 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42434 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbeGSSNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:13:41 -0400
Received: by mail-yb0-f193.google.com with SMTP id c10-v6so3568908ybf.9
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+VRjtWmF+L+7Q26tk8/Er8qxhkv3psD9eiRDjVa4Ls=;
        b=e/wINrhTE+3gl3Vr16sL1UBup05jWZn10Eb9fWErz4oSUoJlsLZkcEgswUAc1dIR/G
         CeoH9ywAChBQCqSh2n2w1d1zh0gINvBGRxT5Q7lJb6knCI8y24npEpYm1rRLRRYE5AZx
         nJVz/UPFdzNjHu8Kc2M+h1MM6zJI967ruQyuSDI1Mo6RkMliwRZOIWyIZhUlVfHdORwW
         15XOrAXZ0mMEKeANYUbs7NLmYYp5NvdajgSJiwedIP3DK07P1EvQ39H/FDPEf45e0ldi
         t3WM7AySNkIja5sEzbvWAC1sVbKmQTLQc7ejKUgo/zWrJXnY6yy0MXssKv/9DYLFFiM+
         0Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+VRjtWmF+L+7Q26tk8/Er8qxhkv3psD9eiRDjVa4Ls=;
        b=XCw/rW6IV7SIYVw4W4jhkppvYDRttdRQjIjVKAol4+TZWiOmUepskX6XwL4PFjId72
         PL7kETzvN0BMbWr8PHENeq4utWdMiX6EX1hsLuC0Jg+OKST3FCpQ6z/eYKT9DV1cJYCf
         4QD8Xc0rK/JNCMwsxnKIvC7qOJ/X9wjJ87Cij/TIQNeGS1NeodQbSzHp5GeSr/KgAuWI
         8xbbezCeUIDSif8PJ8OMDiTmdeZQ59RV3MiKI9VabxB5BLl3vcx7krpM/9ASzh4AwbTR
         wtTjju57KrjDooh0CbeEDvWlsNqqtB4zF99SQJDtrsEdlOlYVuuAM8GU7dQQZAz8GIvh
         i+Zg==
X-Gm-Message-State: AOUpUlHm3ejJt50WR4GIfqrgcPxgXa2Bjh/RLwxXj9z3QvA6m8WRDb6e
        FYUXoHHn2qIME7rq9VLovH6oXU7lwKEMHoCNShAvlA==
X-Google-Smtp-Source: AAOMgpecz4kMQw2lNwJNr9Tt/DqYuEBJyqPX2DcYelBJjr26hVjyedgUWy1j2WuxduSgnF+zEflH58SLhe2qzV0jE/g=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr6052175ybb.292.1532021371920;
 Thu, 19 Jul 2018 10:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180718005311.136329-1-sbeller@google.com> <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbOxD-GomEYGkOPe9bPT8sgik77hLaTHK1xN9Hk=g+BvA@mail.gmail.com> <xmqqtvovgped.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvovgped.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jul 2018 10:29:21 -0700
Message-ID: <CAGZ79kZvHvMy6Lf-_Dtzbfaz2BFY2WonOfw-dDQVCOnS-a0=sA@mail.gmail.com>
Subject: Re: [PATCH] diff.c: offer config option to control ws handling in
 move detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 9:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > On Wed, Jul 18, 2018 at 10:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Stefan Beller <sbeller@google.com> writes:
> >>
> >> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> >> > index 143acd9417e..8da7fed4e22 100644
> >> > --- a/Documentation/diff-options.txt
> >> > +++ b/Documentation/diff-options.txt
> >> > @@ -294,8 +294,11 @@ dimmed_zebra::
> >> >
> >> >  --color-moved-ws=<modes>::
> >> >       This configures how white spaces are ignored when performing the
> >> > -     move detection for `--color-moved`. These modes can be given
> >> > -     as a comma separated list:
> >> > +     move detection for `--color-moved`.
> >> > +ifdef::git-diff[]
> >> > +     It can be set by the `diff.colorMovedWS` configuration setting.
> >> > +endif::git-diff[]
> >>
> >> The patch to diff.c::git_diff_ui_config() we see below does not seem
> >> to make any effort to make sure that this new configuration applies
> >> only to "git diff" and that other commands like "git log" that call
> >> git_diff_ui_config() are not affected.
> >
> > That is as intended. (We want to have it in git-log)
>
> Ah, I think what is going on here, and I think I asked a wrong
> question.
>
>  * diff-options.txt is used by the family of diff plumbing commands
>    (which actively do not want to participate in the coloring game
>    and do not call git_diff_ui_config()) as well as log family of
>    commands (which do pay attention to the config).
>
>  * "git grep '^:git-diff:'" hits only Documentation/git-diff.txt.
>
> What the system currently does (which may not match what it should
> do) is that Porcelain "diff", "log", etc. pay attention to the
> configuration while plumbing "diff-{files,index,tree}" don't, and
> use of ifdef/endif achieves only half of that (i.e. excludes the
> sentence from plumbing manual pages).  It excludes too much and does
> not say "log", "show", etc. also honor the configuration.
>
> I think the set of asciidoc attrs diff-options.txt files uses need
> some serious clean-up.  For example, it defines :git-diff-core: that
> is only used once, whose intent seems to be "we are describing diff
> plumbing".  However, the way it does so is by excluding known
> Porcelain; if we ever add new diff porcelain (e.g. "range-diff"),
> that way of 'definition by exclusion' would break.  The scheme is
> already broken by forcing git-show.txt to define 'git-log' just like
> git-log.txt does, meaning that it is not possible to make "show" to
> be described differently from "log".  But let's leave that outside
> this topic.

Then let's call this #leftoverbits ?

> Back to a more on-topic tangent.
>
> How does this patch (and all the recent "color" options you added
> recently) avoid spending unnecessary cycles and contaminating "git
> format-patch" output, by the way?  builtin/log.c::cmd_format_patch()
> seems to eventually call into git_log_config() that ends with a call
> to diff_ui_config().

The color options are only using CPU cycles when we actually need to
color things (if no-color is set, then the move detection is off).

"git format-patch HEAD^ --color" produces red/green output
(like git log would), so I do not see why --color-moved should impact
format-patch differently. (i.e. if the user requests format-patch with
color-moved we can do it, otherwise, when colors are off, we do not
spend cycles to compute the moves)

Maybe I did not understand the gist of your question, still?
Stefan
