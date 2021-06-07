Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BEC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F147C61246
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhFGMHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:07:02 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:41830 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGMHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:07:01 -0400
Received: by mail-io1-f43.google.com with SMTP id p66so16127281iod.8
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pnsirGZYC9PEwS+pQPo7ccS/C8y41TySGUOGZCdFsrg=;
        b=pj60snnqOR9FQq4p8J3Vq/OMXWtBP3x2kMjoVDBpjDLBarrbtOowyx7GIcQnWSZE7/
         WFfFxPzh1ggqV5jdypRn8s7QQMRsoO5A0fbpGiY319poUWl8ElQ4FfXEL+M+U8XjI1rN
         OGdo4fwcSC0A5tJ6TYj1jZJIT1Vl01/GK2i5YI3Qy9cN8lbxXEMnIKEj1Zi1dMGqmRvK
         lFMVny7iwN0hqnBkHxMqDsTe6m+fB4PgZvQFg+x3T3SBIKEw4vlxRSUo0IVlhtODzFvl
         gi4Pxp4toOWvDcIdJpTJaewR6NLhr87VAiovSrRqPFM1MWeIpgVn8g2zGOitOKon126V
         lrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pnsirGZYC9PEwS+pQPo7ccS/C8y41TySGUOGZCdFsrg=;
        b=ISfdYeOrgBEOLve1WdOs0fmcE8x2d8yf3JO8WdnuEkaGKIGlrNra8IoSflzG3tFSoi
         xsXZ6xNzAwo//tNpeKBTP2t153munripSaVnsPbso6oTE4ul1fI6x3E8Liez7xCIR8IR
         an1f6Jqk4oZAHlqgqrAmOp8JljKrnQ1brwX435O8Z5M7B4pZKrpER1J1wq8Rq/zVhWMQ
         8fqX+h+d2kwcE+8ihs6q9D9gOQMqu3mTBbIqnaI7B2YdIllnDb6PpcYRRr3UEfABYfoZ
         hcRxsWv0BpRmpSErmt+/ENc934YyxceFSuZUxt4mL/oimpmeIY2RNuj/ax3qCMq/zizS
         vtBg==
X-Gm-Message-State: AOAM533y7CFZXAFAX/h9MTS4s/9TUPMpkpN3je0/6evBX0gXw8fwhdO1
        52h+xaBS3pblu+unNzcXwpq8PKMSuJ/gkIOnfww=
X-Google-Smtp-Source: ABdhPJwxeYfcNzROb6pYnbh2USrvC4aYa0MoML+Syp428CUg3McUUJEUzuzMRrnkwfUS8wJ9cr64F0g02Wa4J8PU6M4=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr13932154ioo.203.1623067437130;
 Mon, 07 Jun 2021 05:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SJkVeSQKB7eN5Lw+OepeRXiZXWf_t-E09KxT1pmYBMag@mail.gmail.com>
 <CAP8UFD0WpfvWpGiQE9yizyzKL+HTie4KJHwWAzijT8N5RL1A=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0WpfvWpGiQE9yizyzKL+HTie4KJHwWAzijT8N5RL1A=Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 7 Jun 2021 20:03:46 +0800
Message-ID: <CAOLTT8QTq1izxs3oE=TnwTR=W=+nGixpcEvktRRo8YdiEa=FTA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 3
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:45=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sun, Jun 6, 2021 at 5:21 PM ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > My third week blog finished:
> > The web version is here:
> > https://adlternative.github.io/GSOC-Git-Blog-3/
>
> Thanks!
>
> > -----
> >
> > ## Week3: Meticulousness is very important
> >
> > ### What happened this week
> > - I found a `git cat-file` bug this week, see:
> >
> > ```bash
> > git cat-file --batch=3Dbatman --batch-all-objects
> > batman
> > fatal: object 00345b5fe0aa8f45e9d1289ceb299f0489ea3fe1 changed type!?
> > ```
> >
> > It seems that Git died for a strange reason: the type of
> > an object changed? Is my Git object damaged? (Just like
> > a friend of mine, use `find . -type f -print0 | xargs -0 sed
>
> Maybe: s/, use/ used/
> or: s/, use/, who used/
>
> > -i "s/\r//g"` remove all the '\r' of all files in a Git repository,
>
> s/remove/to remove/
>
> > this caused most of his Git commands to fail.) So I tested
> > it under different linux platforms, they all have this same
>
> s/linux/Linux/
>
> > damage.
>
> Maybe: s/damage/breakage/
>
> >
> > After a series of testing and debugging, I found that
> > `oid_object_info_extended()` did not get the type of
> > object.
> >
> > So I submitted the patch for fix this bug to the Git mailing list in
> > [[PATCH] [GSOC] cat-file: fix --batch report changed-type
> > bug](https://lore.kernel.org/git/pull.965.git.1622363366722.gitgitgadge=
t@gmail.com/),
> > Peff tell us the essential reason for this bug:
>
> Maybe: s/tell/told/
>
> >
> > In `845de33a5b (cat-file: avoid noop calls to
> > sha1_object_info_extended, 2016-05-18)`, this patches
>
> s/patches/patch/
>
> > skips the call to `oid_object_info_extended()` entirely when
> > `--batch-all-objects` is in use, and the custom format does
> > not include any placeholders that require calling it. The correct
> > solution is to put checking if `object_info` is empty after
>
> s/put checking/check/
>
> > setting `object_info.typep`.
> >
> > Finally, thanks to the help of Jeff, I summit final patch in
>
> s/summit/submitted a/
>
> > [[PATCH v2 1/2] [GSOC] cat-file: handle trivial --batch format with
> > --batch-all-objects](https://lore.kernel.org/git/4af3b958dd056e2162fdc5=
d7f6600bcedde210b8.1622737766.git.gitgitgadget@gmail.com/).
> >
> > Talk of experience as a story: Even experienced programmers
> > make small mistakes, writing any code requires very careful thinking.
> > - The checkpoints for rejecting `%(raw)` and `--<lang>` are incorrect.
> > At Junio=E2=80=99s reminder, I changed the checkpoint from
> > `parse_ref_filter_atom()` to `verify_ref_format()`. My mentor Christian
> > pointed out some grammatical errors in the cover letter.
> > - At the suggestion of Junio, I rebased `0efed94 ([GSOC]
> > ref-filter: add %(raw) atom)` on `1197f1a (ref-filter: introduce
> > enum atom_type)`, they have a clash, after resolving the conflict,
>
> Maybe: s/have/had/ and s/clash, after/clash. After/
>
> or: s/they have a clash, after/they clashed. After/
>
> > it's better for me to consider the code I implemented before and
> > the code I wrote now at the same time, I can find more problems
> > and find better solutions.
> > - I submitted the patch about `%(rest)`, `%(raw:textconv)` and
> > `%(raw:filters)` for `ref-filter`, they are used to simulate some
>
> s/, they/. They/
>
> > functions of `git cat-file`, my mentor Hariom noticed one of the
>
> s/, my/. My/
>
> > formatting issues, I am waiting for more reviews for the time being.
> >
> > ### What's the next step
> >
> > As long as new atoms `%(rest)`, `%(raw:textconv)` and `%(raw:filters)`
>
> Maybe: s/long/soon/
>
> > for `ref-filter` can be accepted by Git, We can start to let `cat-file`=
 use
>
> s/, We/, we/
>
> > `ref-filter` logic on a large scale! Exciting! But the performance of
> > `ref-filter`
> > is still not good. Perhaps I need to find a new breakthrough in the
> > performance bottleneck of `ref-filter`.
>
> Great, thanks!

Well, there are many typos in this blog... I will correct them in time.

Thanks.
--
ZheNing Hu
