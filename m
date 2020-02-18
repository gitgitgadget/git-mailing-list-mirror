Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A0C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 16:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239D0207FD
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 16:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Wy2juA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRQAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:00:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34828 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 11:00:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so20017896otd.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJmmig2ozWg6Fi2GptVjtHTR4zVQvBIakD478C+2GzA=;
        b=E4Wy2juAXtSpWd6+7h6s7ElVGH+b3utOC10I6QiJEbPgDpjXsLAW8nba0Uj8p7o04A
         /FOFn/a71NbBgPQpwAIKMGwAUddCHkvQOLg5sW0hMw04zGJQsCTG+LZa5KHd+5Sjz0n3
         XPD4Bhmd6IszR0jT3HAFOzipA/LuyaSD+dvDqyCgNAOZbSk/WsLnfQXlQJOGWcQMmE42
         m95wUzAPHeSIwyLcY3g5DeJsyEnIdvz5wxp8bpuMW5ha9ylWK8zEr6q/DOzQxefPCH/9
         /VQcJOcsSi30RR54AjXfLqqsqjNjr28wRhv/u+uEfim6KtEAn/i0+au5ybnC/GX2nCNc
         nRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJmmig2ozWg6Fi2GptVjtHTR4zVQvBIakD478C+2GzA=;
        b=CMe+MIpz6XRI0g+uy43CGTcF9tlUCqvQXO5ho22z+FgMYlaP91NctPXNxxnzTK1O5u
         Kv+YWgyF4CecYPIaJtt/35tcBrJnztHF64RTWiBNR0Zxwct3oRz6cdYcQbez3MbxDsGu
         36tEw1y448WsmG2GgKSDHP3CJPfbQIVcCc8r8pxL4ZT3md+gx1A7evT5BPJobKsxlzRF
         r7ZcRr4Y0qJ246U52oOmL6vstF+1z9I21XxNJBsag/RVjJIQXKsLhaFcJTR4I2msfIXM
         fzesPkD6IrjZr1OCJSUIXp+ulXLY9WCKGhFXMCyAJm6+3A5JUkN+13zxwaZ9fF7+0yZj
         XpWA==
X-Gm-Message-State: APjAAAUfuypWql/Ll8uoas7Xhk4xwGmYcv/Mc+jpWGAyufElTIeUlEeU
        zHqpLRpkyp82v0pkyvjn2MJWQpVsEsL+XiyM47w=
X-Google-Smtp-Source: APXvYqyw2gQDA0KTDsudldAd2haosH7FFooI28QhW9ZKRxnB2l/AP3v6JlmTtOYhLq8D+qcidXX9WDO85oppenXqvYI=
X-Received: by 2002:a9d:6e0d:: with SMTP id e13mr1714298otr.316.1582041599432;
 Tue, 18 Feb 2020 07:59:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
 <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com> <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com>
In-Reply-To: <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Feb 2020 07:59:48 -0800
Message-ID: <CABPp-BHBv+_HkExM1q6WAZZyMhR=UPNQZDhE8jFSQFNoCtgytg@mail.gmail.com>
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like failure
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 7:05 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 17/02/2020 19:12, Elijah Newren wrote:
> > I forgot to add some cc's in GitGitGadget before submitting; adding now...
> >
> > On Mon, Feb 17, 2020 at 9:15 AM Elijah Newren via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> A user discovered a case where they had a stack of 20 simple commits to
> >> rebase, and the rebase would succeed in picking the first commit and
> >> then error out with a pair of "Could not execute the todo command" and
> >> "Your local changes to the following files would be overwritten by
> >> merge" messages.
> >>
> >> Their steps actually made use of the -i flag, but I switched it over to
> >> -m to make it simpler to trigger the bug.  With that flag, it bisects
> >> back to commit 68aa495b590d (rebase: implement --merge via the
> >> interactive machinery, 2018-12-11), but that's misleading.  If you
> >> change the -m flag to --keep-empty, then the problem persists and will
> >> bisect back to 356ee4659bb5 (sequencer: try to commit without forking
> >> 'git commit', 2017-11-24)
> >>
> >> After playing with the testcase for a bit, I discovered that added
> >> --exec "sleep 1" to the command line makes the rebase succeed, making me
> >> suspect there is some kind of discard and reloading of caches that lead
> >> us to believe that something is stat dirty, but I didn't succeed in
> >> digging any further than that.
>
> Intriguing - it's strange that it errors out picking commit2, not
> commit1 I'll try and have a look at it. There seem to be some leftover
> bits at the start of the test that want removing see below

I know, right?  It's kinda weird.

> >> +test_expect_success 'setup' '
> >> +       rm -rf ../stupid &&
> >> +       git init ../stupid &&
> >> +       cd ../stupid &&
>
> I think these 3 lines must be left over from you trying this out before
> making it a test

Whoops, yes you are exactly right.  I'll remove them.
