Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97043C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 23:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357FA2100A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 23:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFLOWhih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbgKXXrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 18:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389467AbgKXXrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 18:47:17 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0707C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 15:47:16 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id y78so254720vsy.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 15:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xml6t/o+nAFwyEt8x1taya7UCguSvCf0MwtY3/gMcoM=;
        b=iFLOWhihuYaM5FkrIXdNjUYKjNcCxKxlyiYlTn7PaA5ehZ1Q9NjOgHwrg3vDaj2IgB
         bi03/5oyrsGPgH0rnc9otc/yDeVxmnQWtFnmKIfK0/xGE1dXvSSpIWOGbGQ9UvVte50m
         4X/rMIqecPjMWOtYTgoyB99cBHhqL64J7i9Jou2aVH23/gQQBr9bCyrYUdBPXM+//45A
         dJDJ329aZWVrCF/4O0DT7h40j1300558MD4SeArRkK1L+y+wCqki3pret1rG/EtUB5/L
         kFHZGIVJBCLnC6s/aTC6ZaMA3nkwANCslemxcZd1BLtnb72vNvwMfKeBErE7uamXjfKC
         QLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xml6t/o+nAFwyEt8x1taya7UCguSvCf0MwtY3/gMcoM=;
        b=jiLjblEt4du42PBOxWO6UuumjTrDnVpw66u2lxUjW78KVcTmFYO9bY0/Lh1exER7Rl
         dp+EiCg7MhCj3HWeUXm7zGffEgCxkztWzlu750MPoHj3XRFl3WG/V6gYTbo0kcs2rQ8M
         0+tiNVYMxNAztfkce7iuIeidOLLzK4rq9JlMOyZv1fzx87pnN56pyBMyNXL7LJ2dPBkF
         3V59heod/tmTzlKG1qKUMMO96SUllxvrUyGnjfGiQ8j1tq5tpKME5hCA1CN64zembZ/n
         lSBPnrat8tcjyBX3qyFOk7hU0qSRmQ8b7vrlHvrCj8qSydFzoG6O9coTXeM1bbOeIHJq
         V2OQ==
X-Gm-Message-State: AOAM532UmBteB9fMSkeIKvUFgAgGalaJpTE8a8xkdaaIe5rV+5ToDZVj
        wvjIgZmHup9gR/Rz3CjupWR8gsJL5wzXylqH4TnoZxtkzH8=
X-Google-Smtp-Source: ABdhPJyJQN+B/ZTyVqjH7iLzl5XwkKTUWDd4nZilnjZbvZIBP/QnuFdaa6TEMZsxDEyETOh2p76MM7YwDaXbsWu+ACE=
X-Received: by 2002:a67:f8c5:: with SMTP id c5mr502323vsp.18.1606261636223;
 Tue, 24 Nov 2020 15:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
 <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
 <xmqqo8jmgyrd.fsf@gitster.c.googlers.com> <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
 <xmqqk0uagxei.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0uagxei.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 24 Nov 2020 15:47:05 -0800
Message-ID: <CA+P7+xp_iTnkdbWoDSRZustvjk5BRJOPD=snae8D1Fe_uXqO7g@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 3:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> >> Worse yet, @{4} does not refer to HEAD@{4} but refers to the 4-th
> >> previous commit the current branch pointed at, so a mnemonic for the
> >> end user to remember the distinction between the two is that a bare
> >> "@" is different from HEAD, which is a total opposite X-<.
> >>
> >
> > However, @{0} *does* refer to what is currently checked out, which
> > would be head.. So in a sense @ meaning "the current branch" and
> > applying @{0} would always be HEAD, no?
>
> Not really.
>
> It happens to hold true for @{0}, because by definition you couldn't
> have been on a different branch than the current one when you made
> the topmost commit on the current branch.  For @{1} and higher, it
> is always "where was the current branch at N commits ago?" which is
> different from "where was the HEAD at N commits ago?", unless you
> always use a single branch and never switch away.
>

Right, once you add anything greater than zero it breaks down.. but
think about it a little differently: "@{N}" is sort of eliding the
branch name, which means we use the current branch. "branch@" (if it
were valid syntax) would be eliding the number which means "the most
recent version of branch". Thus, eliding both and using just "@" would
mean "the most recent version of the current branch", which cannot be
anything other than HEAD.

Of course I agree that "@ == HEAD" can't be used to go *backwards*
through that logic at all. But if you're moving forwards through it,
then "@" on its own can make sense as HEAD, but only as an implication
of "the most recent version of the current branch can't be anything
else"

Thanks,
Jake
