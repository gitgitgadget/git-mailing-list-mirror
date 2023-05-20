Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FDC77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 09:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjETJlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjETJlo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 05:41:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC61BD
        for <git@vger.kernel.org>; Sat, 20 May 2023 02:41:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f2676d62a2so4541577e87.0
        for <git@vger.kernel.org>; Sat, 20 May 2023 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684575701; x=1687167701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pdxTb3ouMRviMUNS4iq/8XP34Iyj5GeHnm3ikoNHLQ=;
        b=Q8rcXwD1EPIq6CG+v5QbBubrVJIfbcneRmo9QPCWbsonjk8kfecSmomHwkRBx1ZVi3
         iwC21AQxwKpI9ptRSjjoxtE+JU8TksbLwDdizRra6X9iO5RUfp/u6aMSqnhcMNwG7QUd
         pqdoK/DB+XW7bSSyAwZbnJYcKDiAPmevOifl92zanArrPKesPiCk36cSpBEgYnzRhSKY
         ROZBHUbXbiZ2ynGJM08CndUE53up/rFBGdcVyhsIJEXmwvVJgGu7UN50RT2c6IPHk+sF
         5aMQ2L940S9NfWqrcsddaIXKiadlNa/xLJi7U7/xPPti1CVtP1hneKvnsP7tzWXwd/2b
         S6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684575701; x=1687167701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pdxTb3ouMRviMUNS4iq/8XP34Iyj5GeHnm3ikoNHLQ=;
        b=EIWkWycVPuVH5uBmuHynHM8HE8KS0kSF1UpcOY6BqqZe49dGZi+fp5LVK+Ax+QYJdR
         +DNQrdsNfwnG9Zcy7cbpkg5RRrNsTfJs2r8SW898CiLuQRIkZ8YH2ImeC4mVdyf/Jrzf
         t73HXc+qRa6X+U8/EHfI64AsFJo1bEFwVob2a9Ko7Esu5W5j9vdGOcB0WEoK6cjiVMq6
         a64jPJ/D5+9UpaCYYNRkkJNccbaMjWpwfpq1HnWRAAloeRXrk+nIIMANAXo6vZ3++uRI
         J9FcqVeQsvvTSDFkaHkgml8/U1EWcTxaUHHVC9BoYwFLHEVP5gozE3VUlFU+wpNKZAam
         imSg==
X-Gm-Message-State: AC+VfDxOq4MjBwzUr3Hfb3CW/TVupFH1R/vwdtaO7I33PfgRjhu0J5Uz
        y7Aa9Wcif4w6jgvBEJoEVEErYRC2uLpQIGUKJ7g=
X-Google-Smtp-Source: ACHHUZ7rYQhJxTpPNBy0IGenvxP+/+cPlI2780ix2E0KrMfkniwgGdvf2brhhnUXWHWMm6uHwibRIEwRIACTn2oi+hw=
X-Received: by 2002:a19:5213:0:b0:4f1:1ec4:109b with SMTP id
 m19-20020a195213000000b004f11ec4109bmr1458380lfb.15.1684575701176; Sat, 20
 May 2023 02:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
 <c6337eba029bd5a53f76433c51bbe86c82faf507.1684571874.git.code@khaugsbakk.name>
 <CAOQx3Aa9_cW-s6YoeYLac0j8VuhJ8cvEdGieS-+K-gD7D7TBRQ@mail.gmail.com>
In-Reply-To: <CAOQx3Aa9_cW-s6YoeYLac0j8VuhJ8cvEdGieS-+K-gD7D7TBRQ@mail.gmail.com>
From:   Minnie Shi <minnie.shi@gmail.com>
Date:   Sat, 20 May 2023 11:41:15 +0200
Message-ID: <CAOQx3Ab8BoWpZJWMQsyutNi5GZpck+qwMhKbhM5aeOGHqbRESg@mail.gmail.com>
Subject: Re: [PATCH] doc: merge: fix mention of `ORIG_HEAD`
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, i read one more time, i think it should be read as

Before the operation,
-`ORIG_HEAD` is set to the tip of the "current" branch (`G`)

instead of
Before the operation,
-`ORIG_HEAD` is set to the tip of the "current" branch (`C`)

On Sat, May 20, 2023 at 11:25=E2=80=AFAM Minnie Shi <minnie.shi@gmail.com> =
wrote:
>
> The document says the =E2=80=9Ccurrent=E2=80=9D branch is master , which =
means the
> HEAD is (G), which does not matter, it is not what I am challenging.
>
> What I am challenging is that it continues the context and says:
>
> Before the operation,
> -`ORIG_HEAD` is set to the tip of the "current" branch (`C`).
>
> that is not true, current branch is master, and it is (G), Maybe it
> should be changed to "topic branch", so it reads like this:
>
> Before the operation,
> -`ORIG_HEAD` is set to the tip of the =E2=80=9Dtopic=E2=80=9D branch (`C`=
).
>
>
> Min
>
> On Sat, May 20, 2023 at 10:45=E2=80=AFAM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
> >
> > `ORIG_HEAD` before the attempted merge points at the commit that you ar=
e
> > on (the tip of `master`), not the tip of the branch that you are trying
> > to merge in.
> >
> > Reported-by: Minnie Shi <minnie.shi@gmail.com>
> > Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > ---
> >  Documentation/git-merge.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> > index 0aeff572a59..9019b6a1e50 100644
> > --- a/Documentation/git-merge.txt
> > +++ b/Documentation/git-merge.txt
> > @@ -38,7 +38,7 @@ Then "`git merge topic`" will replay the changes made=
 on the
> >  its current commit (`C`) on top of `master`, and record the result
> >  in a new commit along with the names of the two parent commits and
> >  a log message from the user describing the changes. Before the operati=
on,
> > -`ORIG_HEAD` is set to the tip of the current branch (`C`).
> > +`ORIG_HEAD` is set to the tip of the current branch (`G`).
> >
> >  ------------
> >           A---B---C topic
> > --
> > 2.41.0.rc1
> >
>
>
> --
> Kind regards
> Min



--=20
Kind regards
Min
