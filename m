Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CFC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A4660ED5
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhHTQQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhHTQQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 12:16:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438EC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:15:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so14862193oth.7
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Go+xeDRWhZ7ir4f3bULpcuDcHmUe8qXhYypyT1fZVdk=;
        b=jIxX3Kvtz6QQHDUSoHXb7iroe7zdvoGLRaPlVCsAss3VqtXwMkPc7Mw/TsKtb3oUCE
         DwwfnP1fSahqGPSdUZvgVOE3Y4JWvvvmwnQedUvOE4QOj63/uiAjmcB62eYyw2laIhuL
         IT07wwV5AdLSjNCprI7SAgl85zOJ5p4AyXryvoUzFqQ/AsQu1RepVAXi6vcRlLOFftFC
         sVZNg1VrOGkqCaVkrloQ071630jXSW29c6oxBy5yM5h9lY2mhgQnNxoBcSH4emGEoEnq
         ypPqtjIsnMevuKm4XNPv2Ancevw5R5StBOnYJK2cT5pi3lhnARnr2CFk0Nj+6ZivvXyW
         66KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Go+xeDRWhZ7ir4f3bULpcuDcHmUe8qXhYypyT1fZVdk=;
        b=i0iLKXLOkD3RecfP+7s1dqs+AbzrALK8VlftdMsyh1oMTwLzKvn02JX6oqrfU0VXd2
         QGns6CbHEz1Izv4IQndU0BqokfI6s3h852XB3MVPktKWwHV2r2xfOHg4lucG/pFJGPNY
         WirarWcGr6m3+8VykvN63ibIyjiV5roQRoM2pkIiXEUIh4drMZYXZmzbjDhhlRsBbUhI
         xbax8TPtJjvRMyXb63+8OOhvbdIDwNfkxztkaBXndLUV30C1FlrlGstL4j2PkIwOVqsL
         joiJLeUIjliG79vBjZOsrWX3TZVILm3yunQNSxdNgbTcAW9oBMM1mO0sqtSGb4cuW+F8
         7G2g==
X-Gm-Message-State: AOAM533uKMlDqbADUJIRQwQtSaJc/ZH/O4bjjuJxKQN28SfvBIDmD9qy
        uHuPjFDzf/Fhk03xAiFf+Z32HqlwarCafkdYYnI=
X-Google-Smtp-Source: ABdhPJwPdkXaV268Ffo5RFyuvxf8O9wDsaaSNhGLoIvOvY+TskGhXMVggvb/FolL28+DYAnE+CagTVWENKri/XOHSIg=
X-Received: by 2002:a9d:448:: with SMTP id 66mr17603212otc.345.1629476158440;
 Fri, 20 Aug 2021 09:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <febef675f051eb08896751bb5661b6deb5579ead.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet> <643d67a9-054f-bc22-cf30-763fc082e9d3@gmail.com>
In-Reply-To: <643d67a9-054f-bc22-cf30-763fc082e9d3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 09:15:47 -0700
Message-ID: <CABPp-BE0V3LQdCYH5D2Xv8HnubWAnYxHSCUo4JTpgGHkAoOLGw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] sparse-checkout: clear tracked sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 8:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/19/2021 4:48 AM, Johannes Schindelin wrote:
> > On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
> > This description makes sense, and is easy to explain.
> >
> > It does not cover the case where untracked files are found and the
> > directory is _not_ removed as a consequence, though. I would like to ask
> > to add this to the commit message, because it is kind of important.
>
> Right. I should have modified the message from my earlier version when
> the issues with untracked files came up.

:+1:

> > The implementation of this behavior looks fine to me.
> >
> > About this behavior itself: in my experience, the more tricky a feature is
> > to explain, the more likely the design should have been adjusted in the
> > first place. And I find myself struggling a little bit to explain what
> > files `git switch` touches in cone mode in addition to tracked files.
>
> Keep in mind that 'git switch' does not change the sparse-checkout cone,
> and the activity being described is something that would happen within
> 'git sparse-checkout set' or 'git sparse-checkout reapply'.

Good points.

> > So I wonder whether an easier-to-explain behavior would be the following:
> > ignored files in directories that fell out of the sparse-checkout cone are
> > deleted. (Even if there are untracked, unignored files in the same
> > directory tree.)
> >
> > This is different than what this patch implements: we would now have to
> > delete the ignored and out-of-cone files _also_ when there are untracked
> > files in the same directory, i.e. we could no longer use the sweet
> > `remove_dir_recursively()` call. Therefore, the implementation of what I
> > suggested would be much more complicated: you would have to enumerate the
> > ignored files and remove them individually.
>
> Outside of "it's harder to write that feature"

I don't think it is; see my other email.

> perhaps I could convince
> you that it is better to do nothing in the presence of untracked files.
>
> If a user has an untracked file within a directory that is leaving the
> sparse cone, then that means they were doing something in that space and
> perhaps has unfinished work. By leaving the files on-disk, they have an
> opportunity to revert the change to the sparse-checkout cone and continue
> their work interrupted. This includes keeping things like build artifacts
> (that are ignored) so they can incrementally build from that position.
>
> The general thought I have here is: having untracked, not-ignored files
> in a directory that is leaving the sparse-checkout cone is an unexpected
> behavior, so we should do as little as possible in that scenario.
>
> It also makes it more clear to the user what happened: "You had untracked
> files here, so we left them alone" is easier to understand than "You had
> untracked files here, so we deleted the ones that were ignored and kept
> the rest."

This explanation seems reasonable, but it certainly belongs in the
commit message.

However, doesn't it defeat the point of your removing the ignored
files?  Not only do you have directories full of files, but you won't
be able to have sparse directory entries due to the need to have
.gitignore files from underneath them.

Perhaps this is okay because we expect this to be an unusual case.
But, if so, do we want a more verbose warning (not with every
directory that fails to be deleted, but just at the end if there were
any), suggesting to the user that they clean up the relevant
directories and do a sparse-checkout reapply?  And, ultimately, once
the directory is gone, is that good enough to allow us to keep our
indexes sparse and fast, or are we looking at a huge amount of effort
spent on .gitignore files underneath sparse directories?

> > Having said that, even after mulling over this behavior and sleeping over
> > it, I am unsure what the best way forward would be. Just because it is
> > easy to explain does not make it right.
>
> Of course, you already have a retort to my claim that "simpler is better",
> but I'll just focus on the point that "simpler for the user to understand"
> is a different point than "simpler to implement".

I'm confused now.  Which behavior are you arguing is simpler for the
user to understand?
