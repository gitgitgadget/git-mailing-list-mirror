Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7303EC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393F664ED3
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhBYTz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhBYTxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:53:46 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E998C06178A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 11:52:18 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id l133so7313516oib.4
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fPEYnh61FXn/djCYKuZaxQWryBpomDTZULiyphJgUA0=;
        b=dqXFVZqoAe0l71iyv+sfbuABrM8B1vWyR/yHh5TWR9unD3GhBkDlvS5sCwmUS1sCwG
         Hh1OPbSYluzTwQglGyYAt8Yqyh3bHo/5IkNzX61Wr24N9OIzk9wufNQBAvQeQXIjWNda
         52BIk+DObOTAjYnBo5pgNJorwhrDaN7m2Lm4G5HeM7ci1GiALotcAnNhGlSyN9PyNPY2
         Cpbt6tU8Kz21ozpwL21yStDDk21sPnSfx2rv0CCYHBEvuV9FSWJhL5bMvrZ/SGJcdQS0
         uhikH3asy/f3UAW6PbBJPVffBO6tPv8MmDvDegJN5SANBwmzNrGD2tELn63tGjMlqQ8w
         XcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fPEYnh61FXn/djCYKuZaxQWryBpomDTZULiyphJgUA0=;
        b=LaC5qzGvfrgJFi/7Cj1H3Uy6Y/BH2X6p/eNvQ58son1oaKoDEJib0m8CqBfhhrWhk0
         K0ioX2HU96FY9BxxmJ+14OXA3dA0jVhGRdgyFJdyG1hY3G3GOPS3zMzd1c1ffezx2z5p
         Esr1Rkgkrerp1lR/1oi5AeHqBvv0jXViXb7HTynU11jF9oD7ucO+l4B5380talzKD2Bm
         fjuInN2+2NXQFyv8vGfGfarqK7xDX+YDf7AHv34rIwW0q3RkzOA5vkUzmGKP9+BreKlc
         R94jshE8UcUkJZUL0vRqyJcf9I1oL3MTYAxI5gXKt8Uerx3S/KeRi/BteLUzry3i6eX8
         XtuA==
X-Gm-Message-State: AOAM5337oRREgML9/qYQomRJBRZtFrPdNEkNCtDps1cAWxtkH7q/JXn5
        LtMZQg6IgV1ynv3YubjcthBr2Ugpnx8REahoWdQ=
X-Google-Smtp-Source: ABdhPJz+hSUHigmNgtke71T0sQFnTC1XK3ZBHoxdAa9FOS5y24l07EF77DTjumXrCl1m3ekhrqCvjz/42hylU0jSWZM=
X-Received: by 2002:aca:4e0f:: with SMTP id c15mr7963oib.39.1614282737427;
 Thu, 25 Feb 2021 11:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20210224175834.GT6564@kitsune.suse.cz> <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
 <20210225182924.GY6564@kitsune.suse.cz>
In-Reply-To: <20210225182924.GY6564@kitsune.suse.cz>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Feb 2021 11:52:06 -0800
Message-ID: <CABPp-BGdFX6V+GNQ6JVnoY3S9cvA0mL+cKSnAhUhArQbGaD6vw@mail.gmail.com>
Subject: Re: Getting an actuallt useful merge base?
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 10:34 AM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> On Thu, Feb 25, 2021 at 02:40:59AM +0000, brian m. carlson wrote:
> > On 2021-02-24 at 17:58:34, Michal Such=C3=A1nek wrote:
> > > Hello,
> > >
> > > I find the results of git merge-base A B quite useless.
> > >
> > > Suppose you have a repository with file sets
> > >
> > > S and T
> > >
> > > where S are sources which are developed in mainline and number of sta=
ble
> > > versions, and feature branches, and T are build tools (such as autoco=
nf
> > > tests or whatever) that are largely independent of the source version=
.
> > >
> > > Because of the independence of T from S T are developed in a separate
> > > branch t which is merged into all branches developing S as needed.
> > >
> > > Fixes to S may affect more than one version, and depending on the
> > > situation it might be useful to apply fixes to S to mutiple
> > > stable/feature branche at once. For that one would need a merge base =
of
> > > the branches in question.
> > >
> > > However, merge-base almost always give a commit on branch t which is =
the
> > > merge base of files in set T and does not contain files in set S at a=
ll.
> > > In other words it is merge base only for files from set T and not set=
 S.
> > > Can I get merge base that is merge base for all files that have commo=
n
> > > history between two branches?
> >
> > The merge base is determined by the history.  In your case, I imagine
> > you have a history like this:
> >
> >  A -- B -- C -- D -- E -- F -- G (S)
> >         _/        _/        _/
> >  H -- I -- J -- K -- L -- M -- N (T)
> >
> > Here, the merge base of N and G is M, and the merge base of F and M is
> > K.  Those are the most recent common ancestors, which are typically
> > chosen as the merge base.
> >
> > In your case, you probably want to cherry-pick a commit, or maybe rebas=
e
> > a small set of commits onto another set.  That would probably work
> > better than trying to merge.  It's possible that there's something abou=
t
> > this case that I'm missing where it wouldn't work properly, but it's
> > definitely the approach I would try.
>
> It's like this
>
> T
> ----o----o----o----o----o----o----o----o----o----o----o----o---(t)---o---=
-o----
>      \             \     \                                      \\\
>       \             \     \                                      \\\
>        \             \     \                                      \\\
>         \        o----o----o\=CC=B6---o---(s)---o----o----o----o----o----=
o\=CC=B6\=CC=B6-(a)
>          \      /            \      /                                \\
> S+T  o----o----o----o----o----o----o----o----o----o----o----o----o----o\=
=CC=B6--(b)
>     /                                       /                           \
> ---o----o----o----o----o----o----o----o----o----o----o----o----o----o----=
o---(m)
>
> So (t) is common ancestor for (a) and (b) that merge-base reports but it =
is
> only ancestor for files in set T, and does not have files from set S at a=
ll.
> The common ancestor I am insterested in is (s) which is merge base for bo=
th
> sets of files.

From git-merge-base(1):

"When the history involves criss-cross merges, there can be more than
one best common ancestor for two commits...When the --all option is
not given, it is unspecified which best one is output."

Perhaps you want to specify --all to git merge-base, and then perform
additional checks on the output to select one yourself?
