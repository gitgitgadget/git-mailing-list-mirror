Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94509C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 06:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4440E64EBA
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 06:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBIGRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 01:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBIGRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 01:17:44 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCC6C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 22:17:04 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id k10so14171493otl.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 22:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=et0LzOy7UsKFOh9+Al1p1XXZ68jB4ezCYXJJSKVv8ec=;
        b=UwXpMDVunnO7TpcJ42/ujWin9wI2vJIIAPUU22a//v1UhhjfrbC78hjwgr8OzlGLAk
         1OXJbmNUpVjZaPyeuRTjANoFCcOZsR5LNueYb6h3daYtWX8owh2uMNrM9ziVF+Fl36gS
         SitwROEfMoZeZO6aZdj8HXJ1gW2rwAUB40wpfxjWmPaddk4QoDfI92GbJnMJgazdEbLs
         2E5LYZTsAs03FgLC+W38miSRQO4yWROBLbSAOorH5GAxodB7E+yagGwiqjQHmig/IHzj
         NcMOuVpJkPh8gXWJjRdO3W7aRJzIWdyevTQHxPj83jSXaTvthFWcvlqdUpEDhBiCeZz0
         B5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=et0LzOy7UsKFOh9+Al1p1XXZ68jB4ezCYXJJSKVv8ec=;
        b=fO8uis0LPuuIpjvtIyABdWpj6SV9JQ5wkcfeZ4e9QQPKfN64c9SNK6jT7+iQbpOLbb
         6FeXtGY1URjhaC+qt2lA1mM5LDfEXJdkC5dzizJnnLXv+hCYumWnHknKMaXmJStUnYpG
         Fjaj5fCM+kIBWUSf7iVcxs8yfJ4BY+ZocpFTYO1CrpWFMy2SVO0Fs/rfwQJzHYN0n7Ld
         CU2a7QDU9U0dcTNsltTu/+mjmgHGPC2b5FU2O6ekFQIeHUpTVLf6xVJaso7BGP/0z5LE
         xtKBbsrJ6/dHWdpVcEbPo95k3h4Y93Yaa4aHTESokwiJFYNfoB06lH72HQ6iu3naKkfh
         AaEQ==
X-Gm-Message-State: AOAM533tVuVW3BVAlZFIPWren+CpApLyLWOczv8Gvy4UVkH4uP2q50zM
        tt2h0ZmCpBBnLTizARR89ERSKAkFEGSbJdBO9rE=
X-Google-Smtp-Source: ABdhPJzPWI81Y3Z+S09pnmLK4hciXcCnqtL6H0BKd28BjjiRWhjHMds3vDtrBPVV2PsAAzOsG3Fq/Mm0/0qPKeo96aE=
X-Received: by 2002:a9d:3ec:: with SMTP id f99mr858404otf.299.1612851423484;
 Mon, 08 Feb 2021 22:17:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
 <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com> <CAJDDKr4AyxuS-MQ+62XGnK4UvJ+cFDdnMwOK1GSn-oiFrWoxyw@mail.gmail.com>
 <xmqq4kim3zhq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kim3zhq.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 9 Feb 2021 14:19:13 +0800
Message-ID: <CAOLTT8StBRZcgLopTQ5i9pRbCbbGochv5fTfMPVF3xt7BaG8iQ@mail.gmail.com>
Subject: Re: [PATCH v2] git-difftool-helper.sh: learn a new way go back to
 last save point
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A
>
> David Aguilar <davvid@gmail.com> writes:
>
> > What if instead of global state, maybe the user could specify a path
> > that difftool could skip forward to?   For example, we could teach
> > difftool to resume by telling it where we last left off:
> >
> >    git difftool --resume-from=3Dfoo/bar099.txt
> >
> > Then we don't need the global counter state file?
>
> Does it have to be the second and subsequent invocation to pass the
> new "resume-from" option?  As we do not have "global" state, I would
> presume that we do not even know if it is the first invocation, so
> perhaps a better name would be "--start-from=3D$pathname"?
>
Thank you for your thinking, I agree with your point of view.
As you said before: an accurate file name may be more suitable
for users than `possible last file`.
However, without the support of the global `difftool-save-point`,
it may not be possible to know the last exit point of the user.
Even if the global state is allowed, it may need to do more work
to avoid the competition for the global state under multiple
processes.
So "--start-from=3D$pathname" is more suitable to provide users
with a way to quickly index to specified files.
Then I shift the front and start thinking about how to realize it! :)
> > Finally, I'm going to plug what I believe to be the right tool for the
> > job here.  Have you tried git cola?[1]  Difftool is tightly
> > integrated, and the UI is such that you can trivially choose any of
> > the modified/staged files and difftool them by using the Ctrl-d
> > hotkey.
> >
> > https://github.com/git-cola/git-cola/
> >
> > Cola is purpose-built for driving difftool, and for interactive
> > staging, so not mentioning it in the context of wanting a better UI
> > for difftool would be a disservice to difftool users.
>
> ;-)
Thanks again!
