Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730DFC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2EB64E90
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhCQSLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCQSLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:11:16 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F53C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:11:16 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so767034ooa.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ffnQBFnItLOJD3sE0spHQ+J/4h9pqS43jzlOMR/AUpQ=;
        b=fSLGAuQeMA8D33khoSvHFzCeNbwuc9t5iw/B1cyb3aBSGgsaJ1A27HjrsVPZyylpr1
         I5zQUqLjHmRcTceXFR54yRRnLfvqxgoZyXSV9Wg93hM0ZHXTQ2NQS1kMx9xksweQYSyW
         bS54WUfO2T2c6It0ieVPKUe/MJxdC4FaYB9cNYbXDCt6iNqgvzYoJE/5y2zXhs40p/Ae
         llUUpFAirS2dSwJxGyGAKxt8EHrcBcmOufb/00vXKJBS/Nc1n7MVAYApr5upGhTzSKUq
         eH4zSlCBW5lT93OKf3jezwT1R+4t0Gm8fiIcsVtM8rOEJ3V2ste+vt1zqaV40rk147c1
         WD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ffnQBFnItLOJD3sE0spHQ+J/4h9pqS43jzlOMR/AUpQ=;
        b=FhYtldqzp9UPKAK6QYkaUCsMT4Au4XfM9cF1A9YKbm8sbrZbRrY3gdqrWuFAdeshYb
         six1HQMwsITsyOAVxhqQNJwR4TEyyArjUh5qLPDClbVr55k1PNJ8kWR+PZ1cKy1OBs71
         fvwqA7gnkam8vogEnWQDG0isgr9q4d3pB0qOGkTuRo7x+OJQVauqubDBBqKrtaQeVBpP
         MYaG4ZvwoOU7GkfWKvo/PK1ABuMAQnhDOazkGR7807s4KuuD4KGUI9LlqzWEhETPjCeH
         N8Q6b8h01Bzsk+z1uqrtlh8IhWHTUC25ijaOTpA971y89+BZqMvedJiTjsYJatU3A169
         WZUA==
X-Gm-Message-State: AOAM530ea3gdCpJlHiL95WnhXnP2yWzS/WDo82r0u4rddoBPLnWYxwbu
        gZms51yA4VkUqClVD96Zx8t/Ha8Pz47hhnIyiI8=
X-Google-Smtp-Source: ABdhPJzYjuCnOaqmbA3FY7t4mOrrD7Wrt5wBJZIeAvZyBgedW0o5cxsYBMi3mJLt7txg5cZqC2xG01jmZr3LST4vaJ0=
X-Received: by 2002:a4a:9101:: with SMTP id k1mr4225583oog.7.1616004675967;
 Wed, 17 Mar 2021 11:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-3-avarab@gmail.com>
In-Reply-To: <20210317132814.30175-3-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 11:11:04 -0700
Message-ID: <CABPp-BFA+6--PkJfVfERF-ak9NGd6J0=Jhzro1nqqJ+X-LH3xg@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/5] ls-files: make "mode" in show_ce() loop a variable
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> In a subsequent commit I'll optionally change the mode in a new sparse
> mode, let's do this first to make that change smaller.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/ls-files.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index eb72d16493..4db75351f2 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -242,9 +242,17 @@ static void show_ce(struct repository *repo, struct =
dir_struct *dir,
>                 if (!show_stage) {
>                         fputs(tag, stdout);
>                 } else {
> +                       unsigned int mode =3D ce->ce_mode;
> +                       if (show_sparse && S_ISSPARSEDIR(mode))
> +                               /*
> +                                * We could just do & 0177777 all the
> +                                * time, just make it clear this is
> +                                * for --stage-sparse.
> +                                */
> +                               mode &=3D 0177777;

I could kind of see referencing the magic constant 0177777 in a test-*
source file, but it really needs an explanation when showing up in
actual git source code.  At least reference something about how
cache.h mentions these are the mode bits, or better yet #define this
constant somewhere in cache.h with an explanation.

Also, what is --stage-sparse?

>                         printf("%s%06o %s %d\t",
>                                tag,
> -                              ce->ce_mode,
> +                              mode,
>                                find_unique_abbrev(&ce->oid, abbrev),
>                                ce_stage(ce));
>                 }
> --
> 2.31.0.260.g719c683c1d
