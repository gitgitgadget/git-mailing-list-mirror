Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE428C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5661354
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 12:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFIMtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFIMtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 08:49:31 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D26C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 05:47:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b5so25646584ilc.12
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PuFMV3VF4TOUSp/ecCIVkEniWZvBRmkravzINo9a0Cs=;
        b=tLNAgcyis4IOdpIWaUcUND+pMiW9GjreMwmTmnkFjZrrwi5jqwEWyWsWWCNDVjVfUk
         9n2g/k6NifhktslgVrI4qOv15Usm+Wog4RyiIb/zK0ebmhQhLlt6EAUyanza3V94YqD/
         2iI9ez/D9glddAwS97WJmPTlvIQQ4xkjnqykNkcI7RJsYtq6e8//58FPeCFB+05AVkhV
         z5x04m7EsCLaljMVgLaqmCUtDGIz9oZbPM0ZN2/bYnZ089IDqgX0Rj8tYTLGnY+356JZ
         FZ6c6fp5ea7OzRAEOkmz82Q94uqNkimZzVd1OMi7zvvbtxJsSvo9MK/Oj5fz6bCnIbPB
         VPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PuFMV3VF4TOUSp/ecCIVkEniWZvBRmkravzINo9a0Cs=;
        b=aENPTsXT0j4MHzJk/MXxooSAwZ6F6ii3TG592cGJdeovMWuvGZDVBRcxDVAPLf8S17
         hPUWkHgcx+Mzqme0L9w0Zu9HoUSP+qiKU/4Tu41LMnBxxt28TwYnbyFxfanSN3HnN0RS
         zPHztLkpk1KOVIQvz/4lYeX8i/BmiOzvF42+3zHT2rL3/1cbyzu2KalPtxFSBugvGq0W
         vdfExFITfNK7Pt55nZedTAi5FVbUt0UGBemUWIbQ+utiRzmI5Z3iCn0Ja3B0l/f73Sro
         Qu9dk+2QNXnzTKzXWR5Yt6pAbKMKE+gzNqwrXjDmA4m35LmpsSDA8X9c6ZOJ99KYMybR
         dD9g==
X-Gm-Message-State: AOAM533Rs+x2GZN/29dk0emOLIlMulfFpGlgWN1UI8FaKr6Flc9bDiGy
        QCpH6JulCPUgoz8u0p9mfg+x5M/8iMczhD6trSo=
X-Google-Smtp-Source: ABdhPJypQsX+vL7XRv+krXTDn/wnrxSoYA25o03hMNEyLDDyknB+6xeKAdSQBe+bsT9KFf0b3LtunwcBHNvrvDclaYc=
X-Received: by 2002:a05:6638:1602:: with SMTP id x2mr23669538jas.130.1623242841176;
 Wed, 09 Jun 2021 05:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <xmqq7dj6w7a6.fsf@gitster.g> <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
 <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
 <CAOLTT8TSue=Cx8xos20vnGSi3oOd8+=jTfTw2h82gXmmd4KyLg@mail.gmail.com>
 <xmqqk0n4q1t6.fsf@gitster.g> <xmqq4ke7jzee.fsf@gitster.g>
In-Reply-To: <xmqq4ke7jzee.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 9 Jun 2021 20:47:09 +0800
Message-ID: <CAOLTT8QQPfYdE3GzNt9BEPvLvPdJg8zS6-Dn3L26BdQ6M7Tk6g@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:00=E5=86=99=E9=81=93=EF=BC=9A
>
> I think I kind-of see what is going on here.  There is
>
>     git cat-file blob --textconv --path=3D"$path" "$blob_object_name"
>
> that allows a blob to be fed to the command, pretend as if it
> appears at $path in a tree object and grab attribute for it, and
> show the blob contents converted using the textconv filter.  If we
> were to mimic it by extending the format based substitutions, a
> design consistent with the behaviour is to teach --format=3D%(raw)
> to show the contents after applying the textconv filter instead of
> the raw blob contents.
>

Yes, this is exactly what cat-file --textconv does.

> And there is a corresponding
>
>     git cat-file --batch --textconv
>
> The "--path=3D$path" parameter is omitted when using --batch, as each
> object would sit at different path in the tree (so the input stream
> would be given as a run of "<blob> <path>" to give each item its own
> path).
>

Just like let --batch omitted --path, --rest is meaningless for "for-ech-re=
f".

> So to answer my question in the previous message, yes, this is an
> attempt to support the "cat-file --textconv".  So in the context of
> that command, something may need to be added.  But I do not think it
> makes any sense to expose that to for-each-ref and friends, even if
> we were to share the internal machinery (after all, sharing of the
> internal machinery is a mere means to an end that is to make it
> easier to give the same syntax and same behaviour to end users and
> is not a goal itself; "because we use the same machinery, the users
> have to tolerate that irrelevant %(atoms) are accepted by the parser"
> is not making a good excuse for a sloppy implementation).
>

Because "git cat-file --batch" will only print the contents of the object o=
nce,
so when implements the function of textconv/filters in ref-filter,
we should really consider whether we should let something like
"%(raw) %(raw) %(raw) %(raw:size)" all pass the conversion of textconv/filt=
ers.
If it is my previous %(raw:textconv) or %(raw:filter), they can only print
the converted content separately, and we need:

$ git for-ecah-ref --format=3D"%(raw:filters) %(raw:filters)
%(raw:filters) %(raw:filters:size)"

As you said it might be too complicated for the user....

> Having said all that, I somehow doubt that the "--batch=3D<format>"
> was designed to interact sensibly with the "--textconv" option.
> builtin/cat-file.c::expand_atom() does not know anything at all that
> the data could be modified from the raw contents of the blob, so
> --batch=3D"%(contents) %(size)" --textconv, if existed, may show the
> conveted contents with size of blob before conversion, or something
> incoherent like that.  And if your rewrite using the shared internal
> machinery results in a more coherent behaviour, that would be
> excellent.  For example, we could imagine that the machinery, when
> textconv (or filter) is in use, would first grab the blob contents
> and run the requested conversion, and then work solely on that
> conveted contents when computing what to fill with %(raw:size) and
> other blob-related atoms.
>

And with your --textconv/--filters, we only need:

$ git for-ecah-ref --format=3D"%(raw) %(raw) %(raw) %(raw:size)" --filters

This will be more concise for users. I will try to build --filters, --textc=
onv
for ref-filter . But as stated in the previous reply, it needs to be placed
after the transplant of cat-file --batch (Because --path is useless for
for-each-ref, and at the same time we need proper testing for
--filter/--textconv.)

Thanks, your reply is very reasonable,
--
ZheNing Hu
