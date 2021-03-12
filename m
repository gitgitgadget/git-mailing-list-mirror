Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17854C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC9F64F80
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCLHRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhCLHRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 02:17:16 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF17CC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:17:15 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id x78so25938922oix.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbJd2DbCsCCTmD8KDzU+YTB+QJpcyTzKUSC3oo21EYE=;
        b=qGqzfxsEXFmBkn8OCnJKAZCk/kFq2IR+Oq464xYfTqB3q2cacPcUcywWNBR6bduACf
         TN+k51+qYoSvyf2eYty2JuJhJtI+exoXG1seom/s9MOJveP1993vTtyHlD6aNR6hVekf
         0uGfZCffVUnBmNbEPMGVu4EDKG/KNSaUTZ4JAvR0LZb2sJymtYq+DZbuxK0x5d5Ot+79
         yaN70QzZV/V4tx21sfzPruD6nKhpfebarM29DH06LlL+J7VDJLSrN6kLbU0ClsQBNBr1
         4qMxTo4pGroz8ZCKJwkbOgji+r27Sns2rq+NUSsz06ZQNoT3x9W6gBeHVzJaz/lHGQK4
         9DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbJd2DbCsCCTmD8KDzU+YTB+QJpcyTzKUSC3oo21EYE=;
        b=daqiMkRpTZKVljuBmaj4x3YcuFCsQqdA7fiSdqmrrflCBBnU3pYt132BnpqwEClmU1
         R0r8QCRvA541n7Bds7MeyARO/F/Vxqkp/PqzKK73TPiwM+Ru4COCjQp0mmd604HlgfTf
         NpUoadSYHQvFb3jDNSJLvbtly/k4z+ql2DbdMefpzHVQltTPwI9w9vUUrDHjGA/86c8B
         1M7ArT++PMtIu6asTREndwAzIyC6xr8ko2jPSBAtovI6UrTdXOpzInpQP8/GU14YuX+n
         W3jThYocSbrK5mnub2DzgcBOHHAucQlUPsK9VHEjRRkRXLBPr+svWFl/WgujxRA+CCv/
         f1LA==
X-Gm-Message-State: AOAM531Lk8hbEnp56AT6QqhFJiXLKdzmrwGWiB0FRl0h3LvvhafhX8Dg
        yTCg104pg6w2CfNPibWO8TpBlv1iHLtrqao4cqc=
X-Google-Smtp-Source: ABdhPJz44O222N9WXCQiR/FIN+1Qaa6750d3NlwdqZaJ6jaPz9qp43mwp2VwZKjrrnkctNfbgu0NBP2r3h+xdNkcX8s=
X-Received: by 2002:aca:b489:: with SMTP id d131mr9091909oif.39.1615533435208;
 Thu, 11 Mar 2021 23:17:15 -0800 (PST)
MIME-Version: 1.0
References: <875z1xwznd.fsf@gnu.org> <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
 <87a6r9o1yo.fsf@gnu.org> <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
 <CAPx1GvfguSyXznaaeQYB8JY96vmZmzOJyTnXX1yP3omeXptqXw@mail.gmail.com>
In-Reply-To: <CAPx1GvfguSyXznaaeQYB8JY96vmZmzOJyTnXX1yP3omeXptqXw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Mar 2021 23:17:04 -0800
Message-ID: <CABPp-BG=EupfdjZXs5JZu4RPUyv61Rkxf0MQpR2xpGoYk2w6jQ@mail.gmail.com>
Subject: Re: [Bug] Stashing during merge loses MERGING state
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Tassilo Horn <tsdh@gnu.org>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 11:07 PM Chris Torek <chris.torek@gmail.com> wrote:
>
> On Thu, Mar 11, 2021 at 9:19 PM Phil Hord <phil.hord@gmail.com> wrote:
> > I wonder if a fix could be as simple as recording the MERGE_HEAD as
> > the third parent commit of the stash ref.
>
> There is already a third parent, but only when using -u / -a: this
> third-parent commit holds the untracked files (which are then removed
> a la `git clean`).
>
> A better trick would, I think, be able to save a partial merge state
> in general, including the unmerged statuses of various files, the
> ongoing action (merge or one of the other things that use it), and
> so on, in a form that could be restored later.  A plain `git stash` in
> any partially-merged state should tell you: no, use the fancier
> merge-state-saver instead.
>
> > I think being able to stash during a merge conflict could be very
> > useful.  I do sometimes need to get back to a working state
> > momentarily and a merge conflict represents a long pole to doing so.
> > Similarly, it could be useful to stash a conflicted `git rebase` so I
> > could return to it later and pick up where I left off.  Now we really
> > would need to store some extra metadata, though, like the todo-list
> > and ORIG_HEAD.  And we would definitely need some extra command line
> > switch to tell stash (or rebase) that I want to include all the rebase
> > state and also "pause" the rebase by restoring to my starting point.
>
> This is the sort of thing I'm thinking of, for the "superstash" (terrible
> name for it). Note that whatever this becomes, it should be send-able
> (via push and/or email) so that you can have multiple people work
> on resolving a particularly hairy merge.

You can use git-imerge (https://github.com/mhagger/git-imerge) for
that...just not once you've already started a merge (unless you're
willing to undo and restart).

As per my other email, I'm pretty worried about attempting to stash a
merge, given that stash allows its contents to be "reapplied" on top
of a different commit.  That works fine for single-parent commits, but
merges have multiple parents and it'd be rather tricky to reapply such
a stash on a different base without creating an evil merge.  Perhaps
if "superstash" forced you to only reapply on the same base then it'd
be fine...but it's starting to no longer be a "stash" anymore but
something else.
