Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E04C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C82260238
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhGZI6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhGZI6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 04:58:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393EC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:38:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id da26so9741735edb.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SyI2F5Yknm7oVXHzWVMajtR/n7M/3BwINDRGmfgxY68=;
        b=gzbeIYZMWxyOXE7T5T18f0Zjge7F7vwy1OCr8MN1Hf2DqMpoZkSWbDv3voih/z2myR
         NcKDDLBUkTOxMEvcDe3cRs07YmVtU/zHR6WsGAQUJXRAD9lxvensF2abXMNWeCzCNq/Z
         w+pFe2vul1RaCMqeUnumNSgBJ9YTZ5BX84B1R2GUKdwKCn/NV3BdjtagjKJwPgLcxllH
         OxWic+e/Lo4qPjh0Y2jaWUKwrgUKKuSxo8xyr5wAbVm/kO6C5ddNYYf6BnRq6+vpOAqM
         jft2+3suJCZ+cmnimMG16XK4DYQ1BLGbjtYnDkDBy240zo64e2AlEIqxRC0/rsw7uPyU
         xT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SyI2F5Yknm7oVXHzWVMajtR/n7M/3BwINDRGmfgxY68=;
        b=gSWxZ5eyTBY/7BdsH5OzKqjAWxhYT1V45x3VgR2Y99jUOIY06kPLxtoM0t4k+w53X3
         fLNYip+2rwjxZRTxIUMdxFuvSVoKY4Cfx1HLSoCe2ACiUF45sC4Wwl+wrMqGW0oGRqF0
         XMI13f9TjxEvBf95pUfVrsFDu+0rcwK+aqgsnSjRr1yBj49q7zoxwQXW5d17HhP9R9D/
         yY5iQTW+5if/aZbVVYYGQs4HuBanyPf2+JmWw8/da46HrnLxdXewybSi1jLMeM+7+pID
         1A3VwUcqyDyUND2n3SABSHxV4xFRPAmgeWl0LJ9hk8Pm/dq49rOiOv21MIdrHxM2TSde
         dVLg==
X-Gm-Message-State: AOAM530uY+5d4043UI8yG7tZwVkV4ztdc5I4J1y2TohMhGT+k5rMOBZI
        UOjh/9G1RpWVShqqgz50cOCPYLo6yTZwWYpaKVA=
X-Google-Smtp-Source: ABdhPJyF1TpXzUZ0W7ke5wAwvynn7VZNdwnzZg+OvM57uBsBMGE61Flo8rJd3ReyRVBxcVYa1ksM9+1meWhWiSRtA5o=
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr20156323edy.362.1627292311618;
 Mon, 26 Jul 2021 02:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
 <87im0zs8wn.fsf@evledraar.gmail.com> <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
In-Reply-To: <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Jul 2021 11:38:20 +0200
Message-ID: <CAP8UFD1szPO-qmusSqiLRWxynV0gcy8UsnZORNn0USYAmRUGVw@mail.gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 25, 2021 at 2:04 PM ZheNing Hu <adlternative@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:23=E5=
=86=99=E9=81=93=EF=BC=9A

> > Having skimmed it I'm a bit confused about this in reference to
> > performance generally. I haven't looked into the case you're discussing=
,
> > but as I noted in
> > https://lore.kernel.org/git/87im1p6x34.fsf@evledraar.gmail.com/ the
> > profiling clearly shows that the main problem is that you've added
> > object lookups we skipped before.
>
> Yeah, you showed me last time that lookup_object() took up a lot of time.

Could the document explain with some details why there are more calls
to lookup_object()? For example it could take an example `git cat-file
--batch ...` command (if possible a simple one), and say which
functions like lookup_object() it was using (and how many times) to
get the data it needs before using the ref-filter logic, and then the
same information after using the ref-filter logic.

It could be nice if there were also some data about how much time used
to be spent in lookup_object() and how much time is now spent there,
and how this compares with the whole slowdown we are seeing. If =C3=86var
already showed that, you can of course reuse what he already did.

The GIT_TRACE_PERFORMANCE, GIT_TRACE2_PERF env variables and the
associated trace_*() and trace2_*() functions might help you with
measuring how much time is spent in different functions.
