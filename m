Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC493C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 04:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A35610FC
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 04:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGErb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 00:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGEra (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 00:47:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DE3C061766
        for <git@vger.kernel.org>; Sun,  6 Jun 2021 21:45:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h24so24507702ejy.2
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4PEu/fJBaaomNl3tJAazVE2NTwy+DlTZAZjd8NKvC9o=;
        b=aRJD3kFURZC+gQD9eNIVLdv6UEPsUS0xitpxLJVmBfn8LCzT3BoYttigPJzF+iagtY
         4Wu9uTSPQAbExSeGYJNC1KBzQXWzRN8B/QkBEllE46t0fccZwiyqh3CiiTD583KOi5JR
         4ttWfOr2bv6n6xaMUqiL+hhVbgMoJOaZEI/OfwaNjIqjO9DSl+V6MPCs2tsal782ZXLu
         tCgYFhquoN1ikd+NZGadg4VHM8fpYtfg8YSLfBVo3vXDjSV0mu4HEYNkZ1sMtyb8BL0/
         /sgiKF1z8rjbEeNfHiMcIBtZf10K+c3QVZaMavucNFsGXrRk86f3ajGqDkpXcV0he9Vg
         p7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4PEu/fJBaaomNl3tJAazVE2NTwy+DlTZAZjd8NKvC9o=;
        b=YsvXZtozVetJShd6TjJN9puG0YbxLpl7zeV5Lm2dSBzhsYFLsKsbifmWSmDUoH8rdC
         irOUn0xBgK4QkOoOcGYPMdPxIvMmD8Zj+5+PnttvuEHg2dc2LsLo7NLypHHtx1jibSXc
         Ir3/IgYBnci0juoaLckTWaUI8oc1sxCaXqSeL7LEeHhUFl3CLQtrAGC5NN3lYbsMU80l
         Xe6+pGGnAh6n//3n2DQS68XvgEFHbFS/0M6bYGIL6bkoTEdPPAoQ7EYlDwZ51hNjVBJW
         q6kf+IJuwS61yKghTTjoZHlyk8aE/LVy+1xFB7bS32AfzO+SiG5W8w4zJU/iqCkkaWIW
         3UXg==
X-Gm-Message-State: AOAM530MRYr4I9y3WZCcEf6MtX2y4tTGWh2kocmnuN47Z08ioQpejxVp
        vftF1v4EYuxsNK8KQn9/ASg7i7ygkGM1rri+rz4=
X-Google-Smtp-Source: ABdhPJwT/BZyzqGeaQ95he0JgUPctFvyTKM2FHcy9O/L3AO1fTdliytjbB7qNMH/w941jEw5YvPotyc+/tv+WM1OHpY=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr16027152ejy.211.1623041127116;
 Sun, 06 Jun 2021 21:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SJkVeSQKB7eN5Lw+OepeRXiZXWf_t-E09KxT1pmYBMag@mail.gmail.com>
In-Reply-To: <CAOLTT8SJkVeSQKB7eN5Lw+OepeRXiZXWf_t-E09KxT1pmYBMag@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Jun 2021 06:45:16 +0200
Message-ID: <CAP8UFD0WpfvWpGiQE9yizyzKL+HTie4KJHwWAzijT8N5RL1A=Q@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 3
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 6, 2021 at 5:21 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My third week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-3/

Thanks!

> -----
>
> ## Week3: Meticulousness is very important
>
> ### What happened this week
> - I found a `git cat-file` bug this week, see:
>
> ```bash
> git cat-file --batch=3Dbatman --batch-all-objects
> batman
> fatal: object 00345b5fe0aa8f45e9d1289ceb299f0489ea3fe1 changed type!?
> ```
>
> It seems that Git died for a strange reason: the type of
> an object changed? Is my Git object damaged? (Just like
> a friend of mine, use `find . -type f -print0 | xargs -0 sed

Maybe: s/, use/ used/
or: s/, use/, who used/

> -i "s/\r//g"` remove all the '\r' of all files in a Git repository,

s/remove/to remove/

> this caused most of his Git commands to fail.) So I tested
> it under different linux platforms, they all have this same

s/linux/Linux/

> damage.

Maybe: s/damage/breakage/

>
> After a series of testing and debugging, I found that
> `oid_object_info_extended()` did not get the type of
> object.
>
> So I submitted the patch for fix this bug to the Git mailing list in
> [[PATCH] [GSOC] cat-file: fix --batch report changed-type
> bug](https://lore.kernel.org/git/pull.965.git.1622363366722.gitgitgadget@=
gmail.com/),
> Peff tell us the essential reason for this bug:

Maybe: s/tell/told/

>
> In `845de33a5b (cat-file: avoid noop calls to
> sha1_object_info_extended, 2016-05-18)`, this patches

s/patches/patch/

> skips the call to `oid_object_info_extended()` entirely when
> `--batch-all-objects` is in use, and the custom format does
> not include any placeholders that require calling it. The correct
> solution is to put checking if `object_info` is empty after

s/put checking/check/

> setting `object_info.typep`.
>
> Finally, thanks to the help of Jeff, I summit final patch in

s/summit/submitted a/

> [[PATCH v2 1/2] [GSOC] cat-file: handle trivial --batch format with
> --batch-all-objects](https://lore.kernel.org/git/4af3b958dd056e2162fdc5d7=
f6600bcedde210b8.1622737766.git.gitgitgadget@gmail.com/).
>
> Talk of experience as a story: Even experienced programmers
> make small mistakes, writing any code requires very careful thinking.
> - The checkpoints for rejecting `%(raw)` and `--<lang>` are incorrect.
> At Junio=E2=80=99s reminder, I changed the checkpoint from
> `parse_ref_filter_atom()` to `verify_ref_format()`. My mentor Christian
> pointed out some grammatical errors in the cover letter.
> - At the suggestion of Junio, I rebased `0efed94 ([GSOC]
> ref-filter: add %(raw) atom)` on `1197f1a (ref-filter: introduce
> enum atom_type)`, they have a clash, after resolving the conflict,

Maybe: s/have/had/ and s/clash, after/clash. After/

or: s/they have a clash, after/they clashed. After/

> it's better for me to consider the code I implemented before and
> the code I wrote now at the same time, I can find more problems
> and find better solutions.
> - I submitted the patch about `%(rest)`, `%(raw:textconv)` and
> `%(raw:filters)` for `ref-filter`, they are used to simulate some

s/, they/. They/

> functions of `git cat-file`, my mentor Hariom noticed one of the

s/, my/. My/

> formatting issues, I am waiting for more reviews for the time being.
>
> ### What's the next step
>
> As long as new atoms `%(rest)`, `%(raw:textconv)` and `%(raw:filters)`

Maybe: s/long/soon/

> for `ref-filter` can be accepted by Git, We can start to let `cat-file` u=
se

s/, We/, we/

> `ref-filter` logic on a large scale! Exciting! But the performance of
> `ref-filter`
> is still not good. Perhaps I need to find a new breakthrough in the
> performance bottleneck of `ref-filter`.

Great, thanks!
