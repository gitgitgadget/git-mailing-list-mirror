Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E62C32771
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 03:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiI2DFI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 28 Sep 2022 23:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiI2DFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 23:05:04 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777CDFA5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 20:05:00 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id u64so30855ybb.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 20:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=omuIpT2SB5en2XkgnVBOksu57vcg48uVUkAUrlvOfdg=;
        b=LFojlbk6FIIztfx3PjTVqX0a0LZ83IgsrPZMjoOGS+9sdGNUuIrk8CVOhQ2F5o4i1F
         BfYyPnGEVwV1syYgvNqdPqCge3A0n+3fXVoGca9PtnZp2eb1LZpbc2Z5k4p4EvEr3c4D
         EsXVSMl7vSx4linB3B5frsftjLy0EASuNKhAAisjBZclyv3ZbLsVxxULeuGFWBOcxTzh
         yd67JXxyrTT9lbPyJWM7UTTZGmu6aB3TXYqW36hRxk2KlnE7Dy46jlmzOWk/Jin7gMKe
         nzb6vzPtSwdw2BCKOpMw33mK/2x7/8ITcJcPPzQGfqGUjAX2KLUZKNwGeJx9pSYNmbtz
         ul3A==
X-Gm-Message-State: ACrzQf3slBWfQlX891wVwz+9TY728gWHN9XXlSjbFD7EWOtFWfAeJ498
        N4qGythTwLrcuw4N8a8qGiGIZnMGqXzaWhzghmpEDC2kldOIWQ==
X-Google-Smtp-Source: AMsMyM7ktyYT1BcUKPj3iYXu8EnBrTmBea1YozZG1C9YENHUw2Cg7z6ltT51KrnY82VyzpWTWpHSPbz9cq5q/J/PG5E=
X-Received: by 2002:a25:d457:0:b0:6bc:92dd:9462 with SMTP id
 m84-20020a25d457000000b006bc92dd9462mr1167295ybf.326.1664420699826; Wed, 28
 Sep 2022 20:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <patch-v2-20.35-1c2bc223c5d-20220928T082458Z-avarab@gmail.com>
In-Reply-To: <patch-v2-20.35-1c2bc223c5d-20220928T082458Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Sep 2022 23:04:49 -0400
Message-ID: <CAPig+cS01QEcAvr0yqhdhGc8MtvHMofKOHSeJZy2yFqq0Oqo8Q@mail.gmail.com>
Subject: Re: [PATCH v2 20/35] doc txt & -h consistency: add missing options
 and labels
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 4:43 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Fix various issues of SYNOPSIS and -h output syntax where:
>
>  * Options such as --force were missing entirely
>  * ...or the short option, such as -f
>
>  * We said "opts" or "options", but could instead enumerate
>    the (small) set of supported options
>
>  * argument labels were missing entirely (ls-remote)
>
>  * How we referred to an argument was inconsistent between the two,
>    e.g. <pack> v.s. <pack>.idx.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

A few minor comments (probably not worth a re-roll)...

> diff --git a/builtin/help.c b/builtin/help.c
> @@ -88,7 +88,7 @@ static struct option builtin_help_options[] = {
>  static const char * const builtin_help_usage[] = {
> -       "git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
> +       "git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",

This is merely removing an extra "]", thus should it instead be
bundled along with [12/35] (after generalizing the commit message of
[12/35] a bit)?

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> @@ -20,6 +20,7 @@ static const char * const send_pack_usage[] = {
>            "              [--verbose] [--thin] [--atomic]\n"
> +          "              [--[no-]signed|--signed=(true|false|if-asked)]\n"

Should there be spaces around the leftmost vertical bar per [14/35]?

    [--[no-]signed | --signed=(true|false|if-asked)]

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> @@ -20,7 +20,7 @@
>  static char const * const builtin_sparse_checkout_usage[] = {
> -       N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
> +       N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),

Does this change belong in [15/35] where you also add "[" and "]"
around "<options>" for the 'mv' command? Citing [15/35]:

    In the case of "mv" let's add the missing "[]" to indicate that these
    are optional.

> diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
> @@ -56,7 +56,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
>  static const char * const verify_pack_usage[] = {
> -       N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."),
> +       N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),

Part of this change makes sense in this patch, but doesn't the "[--]"
part belong in [18/35]?
