Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F21C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC136113A
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhDHNaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhDHNaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:30:01 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20582C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:29:50 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o15so1742949ilf.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8pvknI6B4ydHln8UxWGGH0SoiosLcOZW9HZHEc/iyJQ=;
        b=oXdmYOk63hNBHlOztRIqOZx35GizAx1YXPbpdzza4Rg0VUJKJ8KCIQwwoTBe2gG/L/
         G9LAVgZw23uAlBti1Q6oapdc0yEL0MZvac1QWqZBGEwwMpU6hXp6LyfRP9zdKD5v75Fx
         maPsSj6I4YQF+R74hgyf3icmGd/CD8kYbH5k0tZrYp3ZtRTHBol9MKNiTdtzB9hLFlQP
         aPCvgr36fhPH0VwePGj9UQNl3YH4Y+pX2M6WEdTbD6UlWB7fSeZQLaAae8kBefES/UiE
         Q3QEzwRJZsXXSRNSCEGjgrykf4FRvGg5bObkIq7uTTRk0jA9i+sXWBBSO3MJS18ajppJ
         cX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8pvknI6B4ydHln8UxWGGH0SoiosLcOZW9HZHEc/iyJQ=;
        b=BQcm5do52lPPX+YY9t8d537AJyBLuLJ1aP6N320rOJk2m17lXDD8xXbalqV8B3YNLY
         X3lMMRV84CHKdf7USI5f2rByOH41H3aa8/LmL8Hde+ferr7NN3yubsl4SzMjJvlRbzkp
         MFLAozAiM1XcJ0vObbgYIlB2JJhaq/mbXOJQDL5n+eErebj6VemWuS55k75odZV/fZwR
         cnnH4GxDx7RaUSPxAYWU9v26WLn5HVgEE6RHcYlPcE2LbJ8y54CrHtON3BwQuPtJOoJn
         kvaC1MbxhZ4ofaCfUiq1k5zroFqxIExcrIhKvk5s4wFVx/vLQwT446Qzqr2Wu6yF4SsE
         0gtw==
X-Gm-Message-State: AOAM533EaPPMVcvVBzLV68M/GaImkULcmRHeUXHVrg6/jcqwyfz4Iszy
        8QPyGhmMDbiu8KflcDrD4DXbqCaXOku+Q64EYMU=
X-Google-Smtp-Source: ABdhPJy/bCAbSF6GENmo1lk2CrGPaZsxFQSiPsaMx30c+7BvKdM7fTm4p3jmUSOkFLCyRRMQVEugMdOHUsX4G+lyU1k=
X-Received: by 2002:a05:6e02:19c6:: with SMTP id r6mr6880951ill.174.1617888589578;
 Thu, 08 Apr 2021 06:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <YGc6ybE1wD1ck0uB@coredump.intra.peff.net> <CAOLTT8R_kmdNhJaMjj60H0SEzs6-KrzTQhBHzShQ82aoDa5vzw@mail.gmail.com>
 <YG4H3wXI8pZT+zDI@coredump.intra.peff.net>
In-Reply-To: <YG4H3wXI8pZT+zDI@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 8 Apr 2021 21:29:38 +0800
Message-ID: <CAOLTT8QSxgMBLVk2dqt2b863z0oxYTcczF5FcPFtiKQh4p_j9w@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=888=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Apr 03, 2021 at 10:27:39PM +0800, ZheNing Hu wrote:
>
> > >   - figure out which data will be needed for each item based on the
> > >     parsed format, and then do the minimum amount of work to get that
> > >     data (using "oid_object_info_extended()" helps here, because it
> > >     likewise tries to do as little work as possible to satisfy the
> > >     request, but there are many elements that it doesn't know about)
> > >
> >
> > I have indeed noticed that `oid_object_info_extended()`
> > can get information about the object which we actually want.
> > In `cat-file.c`, It has been used in `batch_object_write()`, and
> > `expanding_atom()` specify what data we need.
> > In `ref-filter.c`, It has been used in `get_object()`.
> > I am not sure what you mean about "many elements that it
> > doesn't know about", For the time being, `cat-file` can get 5
> > kind of objects info it need.
>
> I think there are things one might want to format that
> oid_object_info_extended() does not know about. For example, if you are
> asking about %(authorname), it can't provide that. But we want to do as
> little work as possible to satisfy the request. So for example, with the
> format "%(objectsize)", we'd prefer _not_ to load the contents of each
> object, and just ask oid_object_info_extended() for the size. But if we
> are asked for "%(authorname)", we know we'll have to read and parse the
> object contents.
>

OK, I understand it now, `%(authorname)` needs to grub info in object conte=
nt
so that content must be parsed, If we need to let cat-file learn
`%(authorname)`,
It takes extra work to extract from the object.

> So this notion of "figure out the least amount of work" will have to be
> part of the format code (and ref-filter and the pretty.c formatters do
> make an attempt at this; I'm saying that a universal formatter will want
> to keep this behavior).
>

You're right. %(tree) %(parent) ... reliant on commit object info,
%(tagger) %(taggername) ... reliant on tag object info.But If it is
some %(objectsize) or %(objectname) content, we do not need
to parse the content of the objects. Future work we should also
keep avoid parsing of non-dependent info.

> > Maybe you think that `cat-file` can learn some features in
> > `ref-filter` to extend the function of `cat-file --batch`?
> > E.g. %(objectname:short)? I think I may have a better
> > understanding of the topic of this mini-project now.
> > We may not want to port the logic of cat-file,but to learn some
> > design in `ref-filter`, right?
>
> Yes, I think the goal is for all of the commands that allow format
> specifiers to support the same set (at least where it makes sense;
> obviously you cannot ask for %(refname) in cat-file).
>

The future new API may need to deny such access.

> And IMHO the best way to do that is to write a new universal formatting
> API that takes the best parts from all of the existing ones. It _could_
> also be done by choosing ref-filter as the best implementation, slowly
> teaching it formats the other commands know (which is what Olga had
> started with), and then cleaning up any performance deficiencies. But I
> think that last part would actually be easier when starting from scratch
> (e.g., I think it would help to actually produce an abstract syntax tree
> of the parsed format, and then walk that tree to fill in the values).
>
> -Peff

It is the unified "%an" and "%author" you said last time.
I think maybe Olga and Hariom might have done similar things:
Calling `ref-filter` results in slower speed.

And you said we may can refactor to abstract syntax tree, this is
a good idea, and this may be a big project, In particular, pre-knowledge
of compilation principles is required, and we may also need to deal with
each different atom carefully.

Thanks.
--
ZheNing Hu
