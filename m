Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E79FC43381
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5607464FF7
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 07:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhCJHnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 02:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhCJHmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 02:42:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E0C061761
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 23:42:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m22so31830205lfg.5
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 23:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSd3CgGsJ1KZVjZx3gNE3CQsgBHflbXONejq2ADFWnc=;
        b=k5wJNNLP+kbdqIMjpnrMigIAgcQyGHKoysqY6AD7RYQWo2LFKTzQqSGRAfunk05rdx
         bec5dDNNKvoWr0sPIn1i6kq7sdxD2+vZzOewX8Wms3/cBRB7liLU4zlFVCcpSd5FR4A1
         stixZp6FhH324bS3ZlfVmX+uYHqGHClA4ghvOOLu8T8OS4KWgAJe10SCSj4WYQzbQntE
         /QvtuHayljxPgIABiMzLIFR98z+nU2GTl45gr1AVz7WGgQGol7FTJ5QxwUcRh/oABI08
         EOXD/PL86Yo5CaolfFj3I22yque9HZiRNOCiwfTz2yKsYS2TDc9NUGIimeRRwZX2fEWA
         IvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSd3CgGsJ1KZVjZx3gNE3CQsgBHflbXONejq2ADFWnc=;
        b=YzP5KjcZ84hFSKx+TvLsvE2ipbA1kHeg7lzGbrTnYrRDBsLLJue9bZ43aB8Vtx6xab
         4vw8VA+wo5yBRypwfRwAyCJpNeKxl7KxRv+sAfrn0ncoRneErqi89K405jwsENN8gLV1
         ahQZ4aTzwLBsvqc601OyfOLVz10SHkIvNXbg6TDS/pFGmX1Bq1261cGxpj6w3d5wFnGK
         CRyZsFgS2DN9M/G9dCTKfTNduPrWRYnpN3yWuNAMyxqQWu8gErjrIzkn50QINelDzSaf
         +6HQaM5N92tHSZqRPsMSXx6H1FOGINes+KxD1VsCnTXOurPqr689agDPnDJ3kfYSnXaQ
         Vnpg==
X-Gm-Message-State: AOAM530RrzcPeOzriEz2tFyzFvtuAHH5xQF/iZS7krJ4zytV5XfVlnwV
        gICVmn3tjmwBXXQoBEqEm8mNw0JR8sc19c4kJgA=
X-Google-Smtp-Source: ABdhPJwkTnBa1weyxZkv9Gz3zU01+HuXYRyAl9kPqzt8srehNF9nw+4aCMSBK5GaC04e5jTDdVV1ReIIpCOtOyUaxp0=
X-Received: by 2002:a05:6512:39c3:: with SMTP id k3mr1275487lfu.501.1615362137099;
 Tue, 09 Mar 2021 23:42:17 -0800 (PST)
MIME-Version: 1.0
References: <87r1kzj7xi.fsf@evledraar.gmail.com> <20210309160219.13779-7-avarab@gmail.com>
In-Reply-To: <20210309160219.13779-7-avarab@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 9 Mar 2021 23:42:05 -0800
Message-ID: <CAPx1GvcDvCykfOJBBPq1vx19dx2zT4cvs=ZPGBtzzw87ZDagzQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a lot of historical stuff I can't really comment on
here, so I'll just point out this one tiny bit of shell oddity:

On Tue, Mar 9, 2021 at 8:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Make the --verbose output be valid TAP, making it machine-readable for
> TAP parsers again.
[snippage]

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index aa7068b06b6..0070d05234b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
[snippage]
> @@ -364,9 +366,22 @@ then
>         (
>                 GIT_TEST_TEE_STARTED=3Ddone ${TEST_SHELL_PATH} "$0" "$@" =
2>&1
>                 echo $? >"$TEST_RESULTS_BASE.exit"
> -       ) | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
> +       ) | "$GIT_BUILD_DIR"/t/helper/test-tool tee \
> +               --tap --prefix=3D"GIT_TEST_TEE_STARTED " \
> +               --escape-stdout ${HARNESS_ACTIVE+--escape-file} \
> +               "$GIT_TEST_TEE_OUTPUT_FILE"
>         test "$(cat "$TEST_RESULTS_BASE.exit")" =3D 0
>         exit
> +elif test -n "$verbose" -a -n "$HARNESS_ACTIVE"
> +then
> +       ret=3D
> +       (
> +               GIT_TEST_TEE_STARTED=3Ddone ${TEST_SHELL_PATH} "$0" "$@" =
2>&1
> +               ret=3D$?
> +       ) | "$GIT_BUILD_DIR"/t/helper/test-tool tee \
> +               --tap --prefix=3D"GIT_TEST_TEE_STARTED " \
> +               --escape-stdout
> +       exit $ret
>  fi
>
>  if test -n "$trace" && test -n "$test_untraceable"
[snippage]

In the block beginning with:

    ret=3D

we have a subshell:

    ( ... ) | "$GIT_BUILD_DIR"/t/helper/test-tool tee ...

In the subshell itself, we set `ret=3D$?`.  But this is inside a
subshell, which then exits, so the setting of `ret` will get lost.

Did you perhaps want `{ ...; }` instead here?  Unfortunately the
pipe means that the whole left side may run in a subshell
anyway, so even that doesn't fix the problem.  We need a
temp file, a la the code above that dumps $? into
"$TEST_RESULTS_BASE.exit".

Chris
