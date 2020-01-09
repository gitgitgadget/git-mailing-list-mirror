Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF9C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751C20678
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 17:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH1JfTkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgAIRxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:53:42 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40957 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgAIRxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 12:53:42 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so6621104oib.7
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uazl2sWAThu4S/FkHhKjCCWT7NFOoKy+IjMvYDn3nho=;
        b=KH1JfTkp81SRxxGS4QmIzm+v4dYL2hXCM+Xo1orj2tF9F4yfToWISrwKvP6yWwFWWE
         B4D8sT4wsMywxGnZMBwz+pz2wMIcJgU4u7lgkzNKS1DPUuEF5WbPDXRwDOJn0pLJ9PU3
         t2SKlDwIbc6bbJv2If3vawYreWnkDNX9l4pv8YTuddsQ6pqyEFDQKiJrPNha8fmyB9Mm
         w/g7ljCFZ/d/auuUJ/FN2TPCFU8CHmFIigvOx0JRIi1V6m3KeKlHgysjmJdSW4rruS28
         SM2ewNEKsnENLT7gGo4+tCtT4A5HRtPN8x+iZ6iRZJgovFzbOpBwwzZLOSVdzgOve6gy
         OSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uazl2sWAThu4S/FkHhKjCCWT7NFOoKy+IjMvYDn3nho=;
        b=AZHguQE7cfrsWQ3zV24qKHNpx8eAvQgKB81+UBuiW4on/dOFY9IRxP6iKIjLSjbrkb
         34XdwK+dL3oTgYTF0PJCkds3CueNvvUuj6mouKfCmV7SXP531MlMKMhbmqIvXgiu9a+F
         dkuHV93Cmtd6+fO9xqAzzrTXr5S53Kf9vYTihyEy0kIRCRi/G7OmFYc2rsyNx6OUqZnz
         WIo5RBTeOOO0AqgeNCqmovLqLvneXzFuBHJ8VAMODhFKwDWPdhhDLz/RhH8p0GGQubW2
         6fy4Zi2qR1XN0sSEAxSK1uh04IFm7m13Ype99kYlv7AO5VYkoOXvdTGI/TpUxuhEOm+E
         eKjQ==
X-Gm-Message-State: APjAAAXwL9GYldhb985fzWM4j2OrsBx+dSFHOPzs2u1OoyZ43cPO/JCz
        Gxc5NqMKYp/frRDDyuhvqV3hViDTHvBCQPJWpYA=
X-Google-Smtp-Source: APXvYqy1Jill7i3KjjhRzMMV/4n+jrx2x3hEZXSttyNXKO9pnEtj3V9VIOPuddXAcCiKwcqNt7vTP0EHXrmle0qEe6Y=
X-Received: by 2002:aca:ba88:: with SMTP id k130mr4323353oif.167.1578592421771;
 Thu, 09 Jan 2020 09:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20200108214349.GA17624@lxhi-065.adit-jv.com> <20200108223557.GE32750@szeder.dev>
 <CABPp-BHsy75UGm4wTOP2_AYik_dZi-_BxtAn-hyi-ZrNRRWGuw@mail.gmail.com> <20200109150332.GF32750@szeder.dev>
In-Reply-To: <20200109150332.GF32750@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Jan 2020 09:53:30 -0800
Message-ID: <CABPp-BEQn83MJKLdOh+9BUWsOeD5seP9Zf8hbVhkAPCOaivHaw@mail.gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 9, 2020 at 7:03 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Wed, Jan 08, 2020 at 04:55:46PM -0800, Elijah Newren wrote:
> > > Alas, there is unexpected bad news: with that commit the runtime of
> > > your 'git rebase --onto' command goes from <1sec to over 50secs.
> > > Cc-ing Elijah, author of that patch...
> >
> > I see slowdown, but not nearly as big as you report:
>
> The linux repo is big, my notebook is small, the poor thing :)

It went to just over 64secs on my home laptop (older and with spinny
disks), so yeah, a big difference from my work machine which has an
SSD.

> > $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
> > warning: inexact rename detection was skipped due to too many files.
> > warning: you may want to set your merge.renamelimit variable to at
> > least 7216 and retry the command.
> > Successfully rebased and updated detached HEAD.
> >
> > real 0m13.305s
> > user 0m9.644s
> > sys 0m3.620s
>
> > Interestingly, turning off rename detection only speeds it up a little =
bit:
> > $ time git rebase -m -Xno-renames --onto v4.18 463fa44eec2fef50~
> > 463fa44eec2fef50
> > Successfully rebased and updated detached HEAD.
> >
> > real 0m11.955s
> > user 0m8.732s
> > sys 0m3.424s
> >
> >
> > This is an interesting testcase; I'm going to try to find some time to
> > dig in further.
>
> The culprits are two seemingly unnecessary back-and-forth checkouts.
>
> I didn't realize I could use 'git rebase -m', so ran some tests with
> it, and turns out that the slowdown started with 68aa495b59 (rebase:
> implement --merge via the interactive machinery, 2018-12-11), where
> the runtime suddenly went from <1.5s to 45+s.
>
> Running 'git rebase -i --onto <those-same-commits>' is just as slow,
> and it appears that it has always been (the oldest I tried was
> v1.8.0), and it spends a long time both before and after popping up
> the editor for the rebase instructions.  That's highly suspicious, so:
>
>   $ git log --oneline -1
>   94710cac0ef4 (HEAD, tag: v4.18) Linux 4.18
>   $ git rebase -i --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
>   hint: Waiting for your editor to close the file...
>   # Hit ctrl-z in the editor
>   $ git log --oneline -1
>   463fa44eec2f (HEAD) Input: atmel_mxt_ts - disable IRQ across suspend
>
> Oh.
>
> So 'git rebase -i' apparently checks out the tip commit of the
> to-be-rebased revision range before invoking the editor for the rebase
> instructions, only to check out the --onto commit (i.e. the commit
> we've started from!) to apply the selected commit on top.
>
> And indeed those two checkouts account for all the wasted runtime:
>
>   $ time { git checkout 463fa44eec2fef50 && git checkout v4.18 ; }
>   Updating files: 100% (49483/49483), done.
>   Previous HEAD position was 94710cac0ef4 Linux 4.18
>   HEAD is now at 463fa44eec2f Input: atmel_mxt_ts - disable IRQ across su=
spend
>   Updating files: 100% (49483/49483), done.
>   Previous HEAD position was 463fa44eec2f Input: atmel_mxt_ts - disable I=
RQ across suspend
>   HEAD is now at 94710cac0ef4 Linux 4.18
>
>   real    0m48.801s
>   user    0m13.963s
>   sys     0m5.114s

Oh, cool, sounds like you're already investigating and found the problem.
