Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D9DC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 04:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiCBEWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCBEWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 23:22:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D71C920
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 20:21:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y11so27521eda.12
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 20:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBbPc9owcgC1sa/ywnBVTrtYSNrpvTMevyi2b2kAZos=;
        b=bZmRGd3V3J2sUg9dAlVQpajyMw//4aZP08Q/mNS9p9qB+fUpZD0U8eijb3B59HnE1j
         FRN+P+fOVSCg0pLDn6EzUikODG7I0GLN7u8F6zC/jwbf5QeQsB6PHmPBjD6YZUJvx+yp
         jr9o2k23H6qzKUpx7ECHbkv+79wF8ziH+gYMUR353XQvYOPFJup3YIlY45VJKyiXC0r6
         LSFBviCAMWwpuXITfMHG9G+AzNlKv8VKoXyGdWRzvDWl2UCaPGEwd6f+0N8O9ii+jxZB
         MDcXDY7t32SXz04KKJt2A2LwLvb98ehSWQN7vigDbQKeBrIGXQ8eNujyM4Q8Uj8HM9pG
         F8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBbPc9owcgC1sa/ywnBVTrtYSNrpvTMevyi2b2kAZos=;
        b=frd0lKFANgmfX79Vd19EPRSYlLON2AcWLX081tlsdjPAIu/78TDm4sNBx8P+z+K4Yh
         S+8v3plnnkWYUcqjyNRk49TPpbgLbchxj7kFx2vvqYzi5NwfWg/tCHrujjdZWPLiVDAk
         twLhl3GAOlbNr1UJ35wPowqN4AdFkQp48u6mSWd+nN+OWfDJAu/yoMEWv09Y8XkbZvDt
         fI6iCg/tPeDhz0bu52FcJ3S4PEw7hePXz7V+0Clfpjiv8Q4vq2JlS4Yl9/s9rprdTl/m
         2F5e9IRGAbadxlj55HNl6m52nOXeikdYDYNhx7I4q57iNFWqcQz6PrzbhKqoxD0DObNF
         lsqA==
X-Gm-Message-State: AOAM532ULssB10gz+rpalQUaZMKTQuMHtUR7/x/Lne1G/U+bR+6UfOw1
        I0aCFuvupqCu2aOwarjXSFoNkIU2JyTZLi7X5vw=
X-Google-Smtp-Source: ABdhPJwExsDzhZ5WYs98iGVQReqCSf0KNvJRtZHtY1PeCzT1CfGxJvHvgqpb9Uq6JRZWs+W7kMuhdl5gD+Nb80LCJDE=
X-Received: by 2002:a05:6402:50d4:b0:413:2a27:6b56 with SMTP id
 h20-20020a05640250d400b004132a276b56mr27814540edb.228.1646194907967; Tue, 01
 Mar 2022 20:21:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1121.git.1645079923090.gitgitgadget@gmail.com>
 <xmqqsfsh5btd.fsf@gitster.g> <xmqqwnheuq79.fsf@gitster.g> <CABPp-BFgLfjLBEK96SLaLxoq6Nspse=FBgViKfiQPk4GaQadFQ@mail.gmail.com>
In-Reply-To: <CABPp-BFgLfjLBEK96SLaLxoq6Nspse=FBgViKfiQPk4GaQadFQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Mar 2022 20:21:36 -0800
Message-ID: <CABPp-BHZF8O_cOQL8hazDOs4LhZB+REfXarNYqmJbqTYU8fzpg@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: make informational messages from recursive
 merges clearer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 6:32 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 10:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > >> One other thing to note here, that I didn't notice until typing up this
> > >> commit message, is that merge-recursive does not print any messages from
> > >> the inner merges by default; the extra verbosity has to be requested.
> > >> merge-ort currently has no verbosity controls and always prints these.
> > >> We may also want to change that, but for now, just make the output
> > >> clearer with these extra markings and indentation.
> > >
> > > Yup, I found that the messages on inner conflicts, especially when
> > > they "cancel out" at the outer merge, are mostly noise that carries
> > > very little useful information (by being noisy, the user gets a sense
> > > of how complex the histories being merged are).  Reducing the default
> > > messaging level would probably be a good idea.
> >
> > Here is what I just had to scroll through to update 'next' by
> > merging back 'master', only to grab the updates to the release
> > notes.  Needless to say, this would have been somewhat baffling
> > if I didn't know to expect it.
> >
> > It would be good to squelch it before we hear another complaints
> > from old-timer power users ;-)
>
> I'll submit a patch soon.

https://lore.kernel.org/git/pull.1167.git.1646194761463.gitgitgadget@gmail.com/,
which would drop all the "From inner merge:" lines below.

>
> >
> > $ git merge -m 'Sync with master' --no-log master
> >   From inner merge:  Auto-merging blame.c
> >   From inner merge:  Auto-merging builtin/am.c
> >   From inner merge:  Auto-merging builtin/blame.c
> >   From inner merge:  Auto-merging builtin/clone.c
> >   From inner merge:  Auto-merging builtin/clone.c
> >   From inner merge:  Auto-merging builtin/commit.c
> >   From inner merge:  Auto-merging builtin/fetch.c
> >   From inner merge:  Auto-merging builtin/fetch.c
> >   From inner merge:  Auto-merging builtin/grep.c
> >   From inner merge:  Auto-merging builtin/hash-object.c
> >   From inner merge:  Auto-merging builtin/log.c
> >   From inner merge:  Auto-merging builtin/log.c
> >   From inner merge:  Auto-merging builtin/pack-objects.c
> >   From inner merge:  Auto-merging builtin/pull.c
> >   From inner merge:  Auto-merging builtin/pull.c
> >   From inner merge:  Auto-merging builtin/rebase.c
> >   From inner merge:  Auto-merging builtin/rebase.c
> >   From inner merge:  Auto-merging builtin/reflog.c
> >   From inner merge:  CONFLICT (content): Merge conflict in builtin/reflog.c
> > Auto-merging builtin/reflog.c
> >   From inner merge:  Auto-merging builtin/reset.c
> >   From inner merge:  Auto-merging builtin/sparse-checkout.c
> >   From inner merge:  Auto-merging builtin/sparse-checkout.c
> >   From inner merge:  Auto-merging builtin/submodule--helper.c
> >   From inner merge:  Auto-merging builtin/submodule--helper.c
> >   From inner merge:  CONFLICT (content): Merge conflict in builtin/submodule--helper.c
> > Auto-merging builtin/submodule--helper.c
> >   From inner merge:  Auto-merging builtin/worktree.c
> >   From inner merge:  Auto-merging cache.h
> >   From inner merge:  Auto-merging config.c
> >   From inner merge:  Auto-merging config.h
> >   From inner merge:  Auto-merging diff-merges.c
> >   From inner merge:  Auto-merging diff.c
> >   From inner merge:  Auto-merging git.c
> >   From inner merge:  Auto-merging gpg-interface.c
> >   From inner merge:  Auto-merging grep.c
> >   From inner merge:  Auto-merging grep.c
> >   From inner merge:  Auto-merging notes-merge.c
> >   From inner merge:  Auto-merging object-name.c
> >   From inner merge:  Auto-merging pack-bitmap-write.c
> >   From inner merge:  Auto-merging parse-options.c
> >   From inner merge:  CONFLICT (content): Merge conflict in parse-options.c
> >   From inner merge:  Auto-merging parse-options.h
> >   From inner merge:  CONFLICT (content): Merge conflict in parse-options.h
> >   From inner merge:  Auto-merging refs.c
> >   From inner merge:  Auto-merging revision.c
> >   From inner merge:  Auto-merging sequencer.c
> >   From inner merge:  Auto-merging sequencer.c
> >   From inner merge:  Auto-merging sparse-index.c
> >   From inner merge:  Auto-merging submodule-config.c
> >   From inner merge:  Auto-merging t/t1091-sparse-checkout-builtin.sh
> >   From inner merge:  CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
> > Auto-merging t/t1091-sparse-checkout-builtin.sh
> >   From inner merge:  Auto-merging t/t1512-rev-parse-disambiguation.sh
> >   From inner merge:  Auto-merging t/t4202-log.sh
> >   From inner merge:  Auto-merging t/t4202-log.sh
> >   From inner merge:    Auto-merging t/t4202-log.sh
> >   From inner merge:  Auto-merging t/t4202-log.sh
> >   From inner merge:  Auto-merging t/t4202-log.sh
> >   From inner merge:  Auto-merging t/t5316-pack-delta-depth.sh
> >   From inner merge:  Auto-merging t/t6120-describe.sh
> >   From inner merge:    Auto-merging t/t6120-describe.sh
> >   From inner merge:  Auto-merging worktree.c
> > Merge made by the 'ort' strategy.
> >  Documentation/RelNotes/2.36.0.txt | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> >
