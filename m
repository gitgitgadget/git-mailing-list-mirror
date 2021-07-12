Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95049C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 12:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804F860FF3
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhGLMjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhGLMjN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 08:39:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37562C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 05:36:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bu12so34351703ejb.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3mIcUBtQ4KtzOM49lkaLidvJbHWeTMhhQH6P/YWH/VQ=;
        b=eokg1MbLW2IwmLAMmFwY++qjBLvZBuLFwHX735Mdpa8h1SrrQhByZufq+i9Z8CzZOZ
         XWD/0gK2KUUkD8mjCkac7uOGMnQp1nseOer4UA8aaG8fEzYpviikDQQ79nYHMJw1bDxY
         BdqdjrzJ4hKzx9Ib5EjqJ7mF5mVnh7CtFLKohn9uCiWjrKqGA0P/H1N1WSOW12/mskhg
         /BXuTei7qYgtcycdkgb2Nhj07bgXMAhikPop0zpq+qLd+kwNPdQPXhzRN8jF8GIXgnvY
         FO7gTlariSAKqJwQuBBhHnFaucpK85CUkvNchH3nxIQWJ1/GJ3pqdDwJza26rp6qR6ye
         yDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3mIcUBtQ4KtzOM49lkaLidvJbHWeTMhhQH6P/YWH/VQ=;
        b=KKV9Z9Z7d0eTP88qB2eptkI6F+MHHajIEvJVGEngsihWl985ztpzqtlGRdVMHi36rA
         wAnb9mD7teYDsar2zPJilsy7L31uMoFnirBiCt/Ozup7BgW/TNG/2yFSbMp5bsvM0CYC
         wR7hRHF3jt5WplKzv3117FbsxYbcyIT3jWxjoRXjFymSIHkUek67fi8g+deV5E8CeEke
         YK2EaHrCRkVm5k02bF6sScyCAUnM8/YU6yZBykHtSAqjFsomXcg2WzoMMziRrMI5cRd3
         QCxQhlTTfxn7PTHTDQk5f3VAawVbwE81xND1LSnrhNJ3L4GOhkp7DhwbR4KHtCD4slB2
         7foA==
X-Gm-Message-State: AOAM531+98F6Q6lRqJ67kVOMt2Ca2So+fHRUZfhOSsDjdyTF3KbHgX/m
        QdsugBjUUE+G7Wooz5zH+D9wSDE6YNV59HUMdGM=
X-Google-Smtp-Source: ABdhPJxADIxBUpFJDtMBjUqs7oRPuNGDstQOevmKHDhN8IqL4THPl3nqeinl5Bvxp3ppORZiNJOFWCCtk9t3DGC68Ew=
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr52594145ejy.341.1626093383780;
 Mon, 12 Jul 2021 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Jul 2021 14:36:11 +0200
Message-ID: <CAP8UFD2gfwB-bEgj6pd__2zkSU20rxr3qN8HOYuLaQYmcuCynw@mail.gmail.com>
Subject: Re: [PATCH 00/19] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 1:47 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series make cat-file reuse ref-filter logic.

s/make/makes/

By the way if you have already sent some of the patches in this series
(and if they haven't changed much since when you sent them), it's a
good idea to use V2 or V3, V4, etc, so we can easily refer to each of
the versions you sent. (See the `-v` option of `git format-patch`.)

> Change from last version:
>
>  1. Declare buf_size in if (atom_type =3D=3D ATOM_RAW) block.
>  2. Modify the code style of the test.
>  3. Delete "use_textconv" and "use_filter" flag. Instead, add member

s/flag/flags/

>     cat_file_cmdmode to struct ref_array_item.
>  4. Add function reject_atom() to enhance the readability of the code.
>  5. Create p1006-cat-file.sh for performance regression testing.
>  6. Use a "fast path" to output object data to reduce the performance
>     degradation of cat-file --batch with the suggest of =C3=86var Arnfj=
=C3=B6r=C3=B0
>     Bjarmason.

Maybe:

s/with the suggest of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason/as suggested b=
y =C3=86var
Arnfj=C3=B6r=C3=B0 Bjarmason/

or:

s/with the suggest of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason/according to =
=C3=86var
Arnfj=C3=B6r=C3=B0 Bjarmason's suggestion/


> ZheNing Hu (19):
>   cat-file: handle trivial --batch format with --batch-all-objects
>   cat-file: merge two block into one

It's a bit strange that the above 2 don't have [GSOC] while the others
below have it.

>   [GSOC] ref-filter: add obj-type check in grab contents
>   [GSOC] ref-filter: add %(raw) atom
>   [GSOC] ref-filter: --format=3D%(raw) re-support --perl
>   [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
>   [GSOC] ref-filter: add %(rest) atom
>   [GSOC] ref-filter: pass get_object() return value to their callers
>   [GSOC] ref-filter: introduce free_ref_array_item_value() function
>   [GSOC] ref-filter: introduce reject_atom()
>   [GSOC] ref-filter: modify the error message and value in get_object
>   [GSOC] cat-file: add has_object_file() check
>   [GSOC] cat-file: change batch_objects parameter name
>   [GSOC] cat-file: reuse ref-filter logic
>   [GSOC] cat-file: reuse err buf in batch_object_write()
>   [GSOC] cat-file: re-implement --textconv, --filters options
>   [GSOC] ref-filter: remove grab_oid() function
>   [GSOC] cat-file: create p1006-cat-file.sh

Maybe you could add the new perf test earlier in the series so that we
could see how performance changes when ref-filter logic is reused in
cat-file earlier in the series.

>   [GSOC] cat-file: use fast path when using default_format
