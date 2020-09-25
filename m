Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C404C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F02086A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUXHNbxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgIYUUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIYUSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:18:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53AC0613BF
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:00:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u6so4205945iow.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LAffJthGzhpmSUORTY6Fi6ugLUqcD4s/OejqRyxp60M=;
        b=MUXHNbxNmgppUUwjxB8FI+wqqbRMi7yELTTCZ+jKtol2v07mKKvPHhqV23yJ0u4f8G
         tP3pVkxI6cVQ3vAo6qZVtHUv31DSSrO9ZxfxAYpHTxt3qdvZNTdwvE/1rMpSnpSvHjR0
         RlQnY3zIzOfwx9jBO7ncc1GFyBnQ//k/K6+FDJI5aKfvbnQwtN/AC1Td69DBj9GD3MHc
         Th2Sy4/s9YfBMQ4fNLsRbuHd301+m6QsggWIpptpi79WLkOgTLWHchA4WIXTTf3PFSWZ
         j1uPgeNYrW6PioL8uDRAByz7Vo7dDv5RU5NWkO1zxyJILGkS/7Q5dZWEK0H+Irb/rwcz
         qT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LAffJthGzhpmSUORTY6Fi6ugLUqcD4s/OejqRyxp60M=;
        b=P3HZz8r5ThpHizP472XsD7Vrq8QqzU7wJ0s3rphsGvH3S2aKLhE6TosXKIzoNreX4O
         ZWDRF4UjX5qLg4hEFPhuKXr9ThSnz+Ltvcusf98bbgp5PcuLK95ll1jrlJCOLnm99Be+
         JC/sKGzjC5nSPiJPr+ozaYX7u1nGuMpltyZ12SXoKYcm97sw1eb2Vy+yhIv2CgyqGbrP
         XiXxkEJvBD4Bx9jW9eqQ6pTwaMkTYaNrYEKSbYEhdq1Pelhv4mnl0rsyGLCt/r/IRt+7
         UG2EaG+fwGjwHCGxFkyU6wVtEP0r6GHnO7t+YzYOySIiyCsFXJAgpMd22UvUKOvze4iJ
         edvg==
X-Gm-Message-State: AOAM530BhgjQVbgyuDcj0ZGTdvvck8TNjudIsqEvTL2z7pTjv3iDLpKW
        /ZMzSksqtgPwg8OucxHOjAep9e2tHd6TAtXPvwI=
X-Google-Smtp-Source: ABdhPJxeulMoeXFvdcgmvRDp54nA1efHn655XilgIczNd5k3pOITahbZwsh76UB6gByko/zVYNK129l3l6yZy7FBatA=
X-Received: by 2002:a05:6602:22ca:: with SMTP id e10mr169818ioe.88.1601064026189;
 Fri, 25 Sep 2020 13:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200925142552.1656596-1-uzonyi.akos@gmail.com> <xmqqlfgxlq6o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfgxlq6o.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?w4Frb3MgVXpvbnlp?= <uzonyi.akos@gmail.com>
Date:   Fri, 25 Sep 2020 21:59:49 +0200
Message-ID: <CAJrAtOWH8Upwov5dL4OfHPAb9v3NynmooC8mr3hAVA+Yo9Yi5w@mail.gmail.com>
Subject: Re: [PATCH] completion: complete refs after 'git restore -s'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for your detailed review.

On Fri, 25 Sep 2020 at 19:30, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=81kos Uzonyi <uzonyi.akos@gmail.com> writes:
>
> > From: Uzonyi =C3=81kos <uzonyi.akos@gmail.com>
> >
> > Currently only the long version (--source=3D) supports completion.
> >
> > Add completion support to the short (-s) option too.
>
> I am not too familiar with the completion library, but what makes
> the "-s" option of restore so special?  I've scanned the entire file
> and did not find that many special cases for short options that have
> their longer counterpart supported already.

There are multiple commands already having this kind of short-long
option completion. The "-c" options of commit, switch and checkout
each have longer counterparts, and both the short and long versions
have completion support for their arguments.

> I do not know if the "feature" this wants to bring in is a good
> idea---we may want to try to be more systematic (e.g. perhaps it
> involves teaching the parse-options subsystem about equivalence of
> short and long options, so that we can reuse existing support for
> the the long option "--source=3D<TAB>" to complete "-s <TAB>"), if we
> were to do something like this.  Singling out "-s" of "restore"
> smells not quite right, as the approach would not scale well.

I think these cases are not too frequent, so it doesn't seem to be a
big scaling problem.

> > Signed-off-by: =C3=81kos Uzonyi <uzonyi.akos@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index 8be4a0316e..50e6e82157 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2853,6 +2853,18 @@ _git_restore ()
> >       --*)
> >               __gitcomp_builtin restore
> >               ;;
> > +     *)
> > +             local prevword prevword=3D"${words[cword-1]}"
>
> Why duplicated prevword here?  Did you mean
>
>         local prevword=3D${words[cword-1]}
>
> instead?

Thanks, I'll fix it.

> > +
> > +             case "$prevword" in
> > +                     -s)
> > +                             __git_complete_refs
> > +                             return
> > +                             ;;
> > +                     *)
> > +                             ;;
> > +             esac
> > +             ;;
>
> Wrong indentation.  In this file, as can be seen on the line "*)"
> you added at the top of this hunk, the case arms like "-s)" and "*)"
> must align with "case" and "esac" in this file.

Thanks, I'll fix it.

By the way, I copied this piece of code from _git_switch (it's also
there in _git_checkout), so these problems have to be fixed there as
well.

Also, reading _git_commit it looks that we already have a "$prev"
variable, so I'll use that instead of "$prevword".
