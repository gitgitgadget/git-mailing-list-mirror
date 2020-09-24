Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838EBC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A7E23772
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=klerks-biz.20150623.gappssmtp.com header.i=@klerks-biz.20150623.gappssmtp.com header.b="o1RtI98w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgIXMPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgIXMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:15:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB431C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:15:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e22so3132441edq.6
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN0YYgyZu2dUnYue/Vm5VFBsJBsVkRvfOJVNicrhuGU=;
        b=o1RtI98w6NNjlAewS/Ru0ddAHbmGoW2Z3Np+kEDfqCNEIuj5qux8ns+SFK8yPK7f28
         h1qrTCqWa8d0PPAMo0MT31E2IkltsSXLYg6pO2ABZY8jhDmTtgr0NfrucoxbH2PB1Ymc
         w/+tqpFSZC+Hkn38SZZvT7cis22Rg8AUGvR0CiXDI/Tf2lLu5r4Pp/yMpB2qhIa0tm93
         9kF8LcAplu4erhCqsw+Q/yumAg7OHmbLBao2fStKwaXTS6rcgm0Hts8WerYV4I3SyH8E
         Z6ZlGtTSkaJkfAA1+VMNqeJ0yCqkJ0UTjEaYpPaenn3ANN/GAkf467J/bq4q+7Po0u/m
         4NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN0YYgyZu2dUnYue/Vm5VFBsJBsVkRvfOJVNicrhuGU=;
        b=q9WCQH+Rmnbv3Ef+X+Kp+5PiB/8bs6pOwrUYSZoOSqrqSffQksFeamL1iypv9cj2Fv
         XF2PMafXsb/tk18z+LBQ8oK+LLqKXX7mUFZcf4p6JcE/kMQMYREMiDdfJjW1HS8GYSV+
         hf8gwo/Rmh2stb0XBr/8jmhoRmkuu6Wwtcb7/GNAgd0XcsjjQG8JP/uRxHg7AYY9GYIb
         P7PU4MJzAWHVHjNn3fiAka4RKJaxy8JvMpcKqcBNuPjNCrt/6iATKhEtU8nnIXOvIBpk
         E+w1dMOjtD7orvd2zYSt6MGssW14IF8ggOE+70h/OYM1Yv2pD7AaV0Zwwi8hBbbbjYXN
         OdNw==
X-Gm-Message-State: AOAM530eqZkSbaov6ia5SFhldh3VCqTbq8ylJR/oKDMOOuxsYb7aMFbE
        SGXcbMS5EXubTHD3vCdfPOU/vALr8ArkEXoZVHbjPt7pYSrXV9Xg
X-Google-Smtp-Source: ABdhPJzeIF1C3pKLUimXv3I4DjkdSCRrrimMEz8LyEo68WGbr2UH6L2Q7FfCWT/8j0olYWeEj+KKE9t9t0KS70af8bs=
X-Received: by 2002:aa7:d6c6:: with SMTP id x6mr714858edr.338.1600949707215;
 Thu, 24 Sep 2020 05:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoj+UhKCW_k34-cGkiWFghOOu13GhPgA0V-y4ZpLVppuiA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009231238560.5061@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009231238560.5061@tvgsbejvaqbjf.bet>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 24 Sep 2020 14:14:56 +0200
Message-ID: <CAPMMpohJicVeCaKsPvommYbGEH-D1V02TTMaiVTV8ux+9z9vkQ@mail.gmail.com>
Subject: Re: Question about fsmonitor and --untracked-files=all
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the tip - unfortunately, that doesn't seem to have worked /
had any positive effect.

With "git config core.fscache false", everything/anything takes longer
except a simple "git status" with the fsmonitor enabled and the
untrackedCache enabled (in which case I guess nothing ends up needing
the filesystem). This combination (fsmonitor enabled, untrackedCache
enabled, and running simple "git status") is the *only* combination
that I've found so far that doesn't force a directory scan - and
*when* there is a directory scan (because of "--untracked-files=all",
or because the fsmonitor is disabled, or because the untrackedCache is
disabled), then having fscache disabled makes things significantly
worse/slower (20% slower to double the time, depending on the exact
combination).

I tried to stumble my way around some of the source code, and I
suspect I've found at least one explanation: The untracked cache
appears to be ignored when "--untracked-files=all" is specified, and
this appears to be intentional:
* In wt-status.c#wt_status_collect_untracked(), the "dir.flags" are
updated to include "DIR_SHOW_OTHER_DIRECTORIES" when the
"SHOW_ALL_UNTRACKED_FILES" arg is detected
* In later logic nested in dir.c#validate_untracked_cache(), the
presence of the "DIR_SHOW_OTHER_DIRECTORIES" flag causes the
validation to fail and, up one level in read_directory(), this causes
the untracked structure to be discarded

The relevant comment in "validate_untracked_cache()" says "See
treat_directory(), case index_nonexistent. Without this
[DIR_SHOW_OTHER_DIRECTORIES] flag, we may need to also cache .git file
content for the resolve_gitlink_ref() call, which we don't.". I can't
claim to understand the comment, the relationship to gitlinks, etc :(

Does this look like something solvable? It looks like supporting the
untrackedCache even with "--untracked-files=all" would make a
(potentially) large difference to git status performance in some
workflows with fsmonitor enabled.

(all that said, I still haven't understood why the presence of the
fsmonitor hook makes the difference, in terms of behavior, between
*multi-threaded* directory tree scanning for all directory contents
(without the fsmonitor), and *single-threaded* directory scanning for
untracked files specifically (with the fsmonitor))

Thanks for looking, any further thoughts will of course be most appreciated!

Tao Klerks

On Wed, Sep 23, 2020 at 4:42 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Tao,
>
> On Tue, 22 Sep 2020, Tao Klerks wrote:
>
> > I've got a couple questions about the "fsmonitor" functionality,
> > untracked files, and multithreading.
> >
> > Background:
> >
> > In a repo with:
> >  * A couple hundred thousand tracked files, and a couple hundred
> > thousand .gitignored files, across a few thousand directories
> >  * The --untracked-cache setting, tested and working
> >  * core.fsmonitor set up with watchman (with the sample integration
> > script from january)
> >  * Git version 2.27.0.windows.1
> >
> > "git status" takes about 2s
> > "git status --untracked-files=all" takes about 20s
> >
> > When I turn off "core.fsmonitor", the numbers change to something like:
> > "git status": 8s
> > "git status --untracked-files=all": 9s
> >
> > Using windows' "procmon" to observe git.exe's behavior from outside, I
> > think I've understood a couple things that surprise me:
> > 1. when you specify "--untracked-files=all", git scans the entire
> > folder tree regardless of the "fsmonitor" hook
> > 2. when you specify the "fsmonitor" hook, git does any
> > filesystem-scanning in a single-threaded fashion (as opposed to
> > multi-threaded without "fsmonitor" / normally)
> >
> > These two things combine so that with "fsmonitor" set, normal
> > command-line git status performance is great, but the performance in
> > tools that eagerly look for untracked files (like "Git Extensions" on
> > windows) actually suffers - it takes twice as long to run the 'git -c
> > diff.ignoreSubModules=none status --porcelain=2 -z
> > --untracked-files=all' command that this UI wants (and blocks on, when
> > you go to a commit dialog).
> >
> > Questions:
> >
> > 1. Is there a reason "--untracked-files=all" causes a full directory
> > tree scan even with the "fsmonitor" hook active, or is this
> > accidental?
>
> I have a hunch that this might be related to a performance hack we have in
> Git for Windows: did you enable FSCache perchance?
>
> If so, I _suspect_ that turning it off would accelerate `git status
> --untracked-files=all`.
>
> Ciao,
> Johannes
>
> > 2. Assuming that the full directory tree scan is indeed necessary even
> > with "fsmonitor" (when requesting all untracked files), could it be
> > made multithreaded?
> >
> > (my apologies for the simplistic "outside-in" observations; I don't
> > feel qualified to attempt to understand the git source code)
> >
> > Thanks for any help understanding the optimization opportunities here!
> >
> > Tao Klerks
> >
