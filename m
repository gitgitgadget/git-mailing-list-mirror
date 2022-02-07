Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FEC4332F
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiBGIHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbiBGICy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 03:02:54 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB2C043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 00:02:54 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id o17so18364145ljp.1
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fHJmC7NVYqzFTeBAuD6nMKdq8Se7Q9PevqYrBJJM+TQ=;
        b=H6q+gOx1eofkvJh+u5nHJLgJ0KCGf14KhrFWBOTVh/5fGM6TZq4VewqvZn1J8WpX0w
         T77yiGiRhcyB8iAH4at2Tg9Pm+7KMNy063TrFGngsDQLsnb6FNExuanVmSaWLBWNPHkJ
         EriP4Wheb99WDhoC/oc8EaQcDBEwJDdele+M57LVSPrQ6zUc2v0oNYqFvCv1w8Kv7W85
         xR8RmbYfC2/vpcoCq4qV5qO7mevOCvczjBiI0DR5lkSSqQWD33Zc20NTP2raNYm/EUCa
         RaeK++EkmEKzESr/pNGo5ebBS20oBwV5KFe0WTFCJotOXQK3byPE9bqy6PXVfJ5ZU1df
         JQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHJmC7NVYqzFTeBAuD6nMKdq8Se7Q9PevqYrBJJM+TQ=;
        b=YKS60QbZjPkAPUzFeSEy+fBukS+Fvayl/HCn2YTY2vPhQhjyAwXaxMcysYFQ6UO8gq
         BeYIsa/rbCf+mWBRYF+m2P0bDcSNvB1AhKzsJ/Nc84WR94CtFpgzFr/0UMxWpClu47yb
         Vy0Q11ZIqzp9hrojfvH7JjbBvF4ibvymd/CMFgg05QsmuhmyV08X/pi+wrvUPdJB11M7
         aA3TBg1tGqH7dh3gtNXFOPG+20oad0tyDqTiZTKEvPcmDpPu/yRG5k7fgi0pASwov5tr
         idNF8GUFy1D1rvmTmo7SWY2nIypEpIYRN2UX2uLGl+9UCo4LvmhWLfKRTB3bFYoSXgYR
         6Z1Q==
X-Gm-Message-State: AOAM532AlEt6w9NeFxHzEibYXYEmHzYyPpxOimhiQTHsJZoJOajGde+D
        k5S4/2VvoS8TjeCs8BikTWbC1WWfvvWOKcoj2d4=
X-Google-Smtp-Source: ABdhPJy3kx+pNNEKpMYxRt42+qPtd7dP5jYcS3xpI//Qf3lxcKOadg2Z/pMvd6yOcEHSTReEVAlP68Vq9mothwbAC9k=
X-Received: by 2002:a05:651c:39e:: with SMTP id e30mr8371091ljp.60.1644220972056;
 Mon, 07 Feb 2022 00:02:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
 <20220129063538.24038-1-bojun.cbj@gmail.com> <xmqqczk6b3pt.fsf@gitster.g>
 <CADuS7AoAbtbC3RKrXR=SGvfs7C-n57Y9zkaGne_XrfyJh46zXg@mail.gmail.com> <CANYiYbHbFmjbMOCKc=UTDEwcL1bpGRrKRafFCUuYxvuHYVkhTg@mail.gmail.com>
In-Reply-To: <CANYiYbHbFmjbMOCKc=UTDEwcL1bpGRrKRafFCUuYxvuHYVkhTg@mail.gmail.com>
From:   Bojun Chen <bojun.cbj@gmail.com>
Date:   Mon, 7 Feb 2022 16:02:40 +0800
Message-ID: <CADuS7Ao0f+zqYL9=QxWM5FvwZ1H5QwbVvWsHij+8V3AdcZUXxw@mail.gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=80 11:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Feb 5, 2022 at 4:15 PM Bojun Chen <bojun.cbj@gmail.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 06:51=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Chen BoJun <bojun.cbj@gmail.com> writes:
> > >
> > > > From: Chen Bojun <bojun.cbj@alibaba-inc.com>
> > > >
> > > > When pushing a hidden ref, e.g.:
> > > >
> > > >     $ git push origin HEAD:refs/hidden/foo
> > > >
> > > > "receive-pack" will reject our request with an error message like t=
his:
> > > >
> > > >     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hi=
dden ref)
> > > >
> > > > The remote side ("git-receive-pack") will not create the hidden ref=
 as
> > > > expected, but the pack file sent by "git-send-pack" is left inside =
the
> > > > remote repository. I.e. the quarantine directory is not purged as i=
t
> > > > should be.
> > >
> > > I was puzzled by the reference to "pushing a hidden ref" at the
> > > beginning of the proposed log message, as it wasn't quite clear that
> > > it was merely an easy-to-reproduce recipe to fall into such a
> > > situation where all ref updates are rejected.
> > >
> >
> > Thanks for the suggestion. Do I have to rewrite this commit message on =
the v3?
>
> You can start your commit message like this:
>
>     receive-pack: purge temporary data if no command is ready to run
>
>     When pushing to "receive-pack", commands may have already been
>     marked with error_string or skip_update before being fed to the
>     "pre-receive" hook. E.g.:
>
>      * inconsistent push options for signed push.
>      * not permited shallow updates.
>      * encounter connectivity issues.
>      * push to hidden references.
>
>     Take pushing to hidden references as an example.
>
>     In order to reduce the size of reference advertisement for git-push
>     from a client which does not support protocol v2 and push negotiation=
,
>     the administrator may set certain config variables to hide some
>     references like:
>
>         $ git config --system --add receive.hideRefs refs/merge-requests
>
>     Then, if a user made a push like this:
>
>         $ git push origin HEAD:refs/merge-requests/123/head
>
>     ...
>
> --
> Jiang Xin

Thanks a lot for your suggestion.
