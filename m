Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA1C35257
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5925720719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb20mPp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBWw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJBWw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 18:52:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C4C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 15:52:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l15so2002222wmh.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otkn7HUVacyN8huDjFah20ctc9YefuC1Xno5etV43Ho=;
        b=gb20mPp1wYCJVIVSJ5OFR7sTfZkKy0UEmXKjrL78OkxAou67WgmzrFoX8YrH2J1JZN
         z+HUMLRjyDSUPrLqutbfeqxnpe2xkFea12cORkLeDUO5w4GVxrXlgzfRLrDEDi4gBn+M
         UiHXaI1DKgj9av31v/dba4G2G3vgWA0iaSscyJFPkRav1CNiTsICk0zh6HxONJPhSbWB
         wXNJWuXQus5z5DXEv4nIc7rgI0xVmCEESj9Yl8GiU26adVa6xIuJPgNNvr2xgXTYW6RR
         DVQ3WfgqX7t1VnApzsY7pgC2qhAeeZdYIbu0D52nn4ahIj5iVR0Gxx1pvnrQjL0uUt9Y
         IaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otkn7HUVacyN8huDjFah20ctc9YefuC1Xno5etV43Ho=;
        b=cYmR9SYnVp1RxRqGo4nms8jaBZKvxcglD4barkRSpX4kRfLUdD9dT9tPsydEtu8tET
         j3DbZ5/lyfo1k7jVXN7Y1yuCGKsuvsUS+ZIeNb/FTx1EAyFZ8dGHe4mY0cERAKftn7ud
         apLJ9Vnde3DYjFhsRIBI6OwJX5iiWnhuMN+3zjQF2LVp+Fr3dOR/OVWVhX+o1reXNXHK
         lT4cvuFrDhrN5omoMwAEDN0EyFsX8UUMIAcUSAQRBVeLz3bGv1JMP0GmDWims+dFSC8D
         01hx8KUM+NY8e5ByRieABDFOuQPm3mX05pZnedgtPEtd8jOzm6vDvnPqNqz+L+BTtPks
         uV0w==
X-Gm-Message-State: AOAM530UE7QqnSU93wCr+GkN7dhdbZ1dEKAN/m6hhXw1HZmt3M/2faLd
        TKSnvgygYTExcAgtzuheVmCvn4EiY5Zlc271pI/j7h6PdHM=
X-Google-Smtp-Source: ABdhPJxf0MLnYTZrPrQ76ewfpYNK0oyLNpZ4eR7dTXmmXzmXJ3l0KqRPNGucS/DFceFn65pFh+z5cmZVF67pj+Bc2TE=
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr5329256wmt.189.1601679176507;
 Fri, 02 Oct 2020 15:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLeu+x-z4ntmBezcVUWssZrCm03Md6ZR8-ZQmjkeB5YT89caQ@mail.gmail.com>
 <d805f025-fbfb-0249-a50c-ff857dc2e29d@web.de> <3e9b34f9-f61e-f3f1-45a3-6352641e434a@google.com>
In-Reply-To: <3e9b34f9-f61e-f3f1-45a3-6352641e434a@google.com>
From:   Harrison McCullough <mccullough.harrison@gmail.com>
Date:   Fri, 2 Oct 2020 16:52:45 -0600
Message-ID: <CAHLeu+zSaTwPEDQ=CuFua0NdEppM+OjFaREU+Yiy9udK1OUK4w@mail.gmail.com>
Subject: Re: git blame --ignore-rev does not work
To:     Barret Rhoden <brho@google.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your feedback! I do have some more information to
provide that is confusing.

I tried running `git blame -w`, and this correctly ignores the
revision I tried to ignore with `--ignore-rev`, etc. So it appears
that the algorithm to attribute lines to commits is capable of
ignoring the commit in question (in the lines I've inspected) but it's
not doing it when I use the "ignore-rev" capability=E2=80=94only the "ignor=
e
whitespace changes" capability.

Does anyone have any ideas about why that may be the case? Does the
"ignore whitespace" and "ignore commit" algorithms use different
logic? I would have assumed that they shared most of the logic.

I would love to provide a concrete example, but the only time I've
been able to reproduce this is with proprietary code. I'll try to
create a new repository with a similar commit and see if I can ignore
it there.

For the information of those interested, the commit I'm trying to
ignore is a "reformat the world" commit. We introduced the tool
"astyle" into our codebase, and as part of that effort I ran astyle
over our entire codebase.

Is it possible that the commit isn't being ignored because it's too
big? It did change over 1300 files....

On Fri, Oct 2, 2020 at 4:44 PM Barret Rhoden <brho@google.com> wrote:
>
> Hi -
>
> On 10/2/20 5:40 PM, Ren=C3=A9 Scharfe wrote:
> [snip]
> > I don't know if these revisions are not ignored due to bugs or because
> > the feature just isn't strong enough, yet, but I would expect your
> > particular case to be represented by at least one of these...
>
> Correct.
>
> When skipping a revision, the algorithm attempts to find another
> revision that could be responsible for the change.  But it might not be
> able to find anything.  Consider a commit that just adds a few lines to
> a file with only 'foo' and 'bar':
>
> commit: "Adding Lines"
> -------------
>   foo
> +No commit
> +ever touched
> +these lines
>   bar
>
> If we ignored that revision, which commit do we assign those lines to?
> If they were "similar" to the existing lines, then the algorithm might
> match.  But in general, we can't find 'correct' (as defined by a user)
> matches for arbitrary changes.
>
> I usually run git with these settings:
>
> [blame]
>          ignorerevsfile =3D .git-blame-ignore-revs
>          markIgnoredLines =3D true
>          markUnblamableLines =3D true
>
> Which points out when --ignore-revs is doing something.
>
> Thanks,
>
> Barret
>
>


--=20
-Harrison McCullough
