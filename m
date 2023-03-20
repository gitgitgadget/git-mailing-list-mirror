Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F557C76195
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjCTR0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjCTRZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:25:54 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8F39CC0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:21:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d7so13940052qtr.12
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yAZL9/1p8bh6GnSjtqDcJ5h5VEyt6f0k1NbGuwZi/s=;
        b=RrQbnV+qqRoSAvuxwu2iSUPIDPW7T1qNm/eQVIUe5XrqTqj5h11Z75TC9/mM195acf
         sL8HfAT2VxGx/ZthK4UDoRR16EqHeVny0Xz+8Xzm7S4lL2vJyd/ZF1Jjr/vtzHu4C8eE
         bNFwSxB2mQnI6gcQBde8verIAdR1TGmf1EiGT+ZgreRHQlIHKhfrBnfIQ/Uu4LxWjU5q
         dN9Os76tfDoifZlTLrfxKaKW8l/+8vSZtgZ825folVcxdL5QPODwdDAoQ6VtYO50J7DF
         YddqQa1fPI1fTB23zA5QpegS3kLZuW2NDNOfkmLOfFVw+Il7MrNwBozOkB1y5c/zT8c9
         a24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yAZL9/1p8bh6GnSjtqDcJ5h5VEyt6f0k1NbGuwZi/s=;
        b=dWjYXcmGDcug2h8ddjLAJ+AkC28NxIJMVmGLm4NbaJ6vCb3nS5ziYeeJ2mx4U1Kf3Z
         fWCdgvVbOmgxcWhzu2Zc7nGW/4qmyungcg2vwh4MKVV5zLn6gZynHNrY9OZdA/z92GJE
         hk/H3AOjQSmLVpKtxQL/4eH0FBRcYcpWPBgNhVyVZfkqrCPqs30/XXuuRqgD9/AXF6EP
         Y/5ACuZcHUmWlMlI5snyGQtT/Mj5epph9vo58oNDKdKxc2Gie2wDr1PP/pJIaKfKzOjV
         ZFlummf2Dk4TQPSOg/os7vmV8rsBf1E7JShRc/i7LLr1qszp7dLKtyRIh5M2sp6pFiqg
         mkHA==
X-Gm-Message-State: AO0yUKXozoEfD4RmtibpYQbeMWe4nCsiZFLBqPxGgfmK+phOtn/BUFT0
        wBav/2ZUg6zbuGvW4OBj02wWUIJL7H3RtU6ZlHPKq4C8RzZ6Qg==
X-Google-Smtp-Source: AK7set+at2fSnM/HSd0yZDUXedRIfsTBB0ThPAhM9KftZGHHiKoqHxRxL5cixfYah2cOvwQboHDDReRdMTPcQjpYh64=
X-Received: by 2002:a05:622a:40f:b0:3de:d15a:847f with SMTP id
 n15-20020a05622a040f00b003ded15a847fmr9110qtx.0.1679332880445; Mon, 20 Mar
 2023 10:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
 <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com> <20230320170158.GA2614670@coredump.intra.peff.net>
In-Reply-To: <20230320170158.GA2614670@coredump.intra.peff.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 19:20:44 +0200
Message-ID: <CAHp75VeMoXZdr++6BiOMhOnSqm5rPe+t0bNzpLJsCuGp8NU=wA@mail.gmail.com>
Subject: Re: git rebase issue
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 7:02=E2=80=AFPM Jeff King <peff@peff.net> wrote:


> [Please don't put random folks in the to/cc unless you think they have
> specific knowledge related to your problem.]

Sorry about that, but my reaction was to the silence. I found your
name is a top contributor, so that's why I have chosen your name.

> On Mon, Mar 20, 2023 at 02:10:38PM +0200, Andy Shevchenko wrote:
>
> > > > With the new release I have got an error
> > > >
> > > >   fatal: 'netboot' is already checked out at ...
> > > >
> > > > To work around this I have to split the above to
> > > >
> > > >   git checkout --ignore-other-worktrees "$branch"
> > > >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
> > > >
> > > > which makes all these too inconvenient.
> > > >
> > > > Any suggestions?
> >
> > So, what should I do? Today I got again to help manually with my (used
> > to working) scripts.
>
> Running "git log --grep=3Dalready.checked.out" suggests that it may be
> b5cabb4a967 (rebase: refuse to switch to branch already checked out
> elsewhere, 2020-02-23).

Thank you.

Indeed, reverting that (manually as it's a conflict with v2.40.0
current tree) fixes my issue.

> Adding its author to the cc, who may be able to say more. But my
> understanding is that this was probably fixing a bug (though I don't
> know all the implications of having a branch checked out in multiple
> worktrees).

Note, in my case it's "checked" in the BARE repository, which means
it's actually not.
This case shouldn't be an impediment or racy AFAIU.

--=20
With Best Regards,
Andy Shevchenko
