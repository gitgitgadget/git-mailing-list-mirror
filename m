Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D67C4332F
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbiAJTlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiAJTlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:41:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79963C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:41:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso314890pjm.4
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5igQ0Zs+VUFFzO/Kzf5FTMRZZIWb1GV1bohCFyqlyQ=;
        b=CbjigvQWk+dXqF0xtzRAQZd3Th8ln2PUSHyb2KpSwkC/LEHfiG5agUgTdQBKEPHbFg
         D/JGGEHl7509GSl9vKfnrZRqL6oO6e9AY1wZ0o2KIWJ30RhqDhL+Is1oZk9MeZn6eTa8
         ++TVLMlc0dQafbxZDXEqwjU+qYVD1MbTjPQ9PjnMPGieQ9owAU24fpVpDYEX6UHA/INQ
         DXEjtTMOTG8WvkvrXzu5gxnUivpOnuFjQIxqBQ869O4S3/spXnJMl1WzC14D4rYLRiEa
         p5qYstdJ0DeJg2MJPUEnzwz3moiAcM6DPPauyxy6cK2RM9z+QxVKh3pCiF0fZoWC5gm0
         tv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5igQ0Zs+VUFFzO/Kzf5FTMRZZIWb1GV1bohCFyqlyQ=;
        b=ZpfsxuTcGQXGOSprmMUkgHSBs3nWaVWtvzTkC7GEoPQ/sM0lYhXU9yRZqxOwoKGq57
         NgYKUAK2OvFMQOFu9ZNPwkM/XpxZOm0rtl55Z59seS5tvR7Ne672177tofb5Vhviy8ss
         jzMeN1MfmI4z3Il7ZvvooXxLQoQ33kX8/qOdf6mlf/EVnEKQWSSC7ZXYIMXmdG2Mdz3h
         f27Su4LhwVvmpenZqn2Kq37jo2VfKdw9obYH6RlHTuVZjyCGoLX1L59lsqWDMdST7ciR
         aGEFRRqYBZLgGuLiKADr3SV2oM1LgpDlAFKvyxPuSIVDYAJGsG++8R1Y3wVWWESs2DM7
         hzxQ==
X-Gm-Message-State: AOAM531aJRyxt4Puy+pe5nuhEAQGj5Qx8DAWx19PkaZAnPNEMNlkWaoO
        4Xti1K1HPCFUViq8qlYNQsmYx5UPEuZ20uarTS0=
X-Google-Smtp-Source: ABdhPJx3GcXBHf+Ero0UvaM7uzAB0hG+rCMxFsD/koz+MMHdN9HFcZyEGSIiC2QoVcEA2hCsg2UaK44FiceczNQpTgc=
X-Received: by 2002:a17:90a:348c:: with SMTP id p12mr11269371pjb.90.1641843700016;
 Mon, 10 Jan 2022 11:41:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <7df58483a4f665f9f54b92a97a6b57704f1e7a0d.1641440700.git.dyroneteng@gmail.com>
In-Reply-To: <7df58483a4f665f9f54b92a97a6b57704f1e7a0d.1641440700.git.dyroneteng@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 10 Jan 2022 20:41:28 +0100
Message-ID: <CAN0heSoTRpymQh0w2pfJcy+16nTHa6MwY+BAqkvfAmQsnj2ihg@mail.gmail.com>
Subject: Re: [PATCH v9 8/9] ls-tree.c: introduce "--format" option
To:     Teng Long <dyroneteng@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng,

On Fri, 7 Jan 2022 at 06:34, Teng Long <dyroneteng@gmail.com> wrote:

> +--format=<format>::
> +       A string that interpolates `%(fieldname)` from the result
> +       being shown. It also interpolates `%%` to `%`, and
> +       `%xx` where `xx`are hex digits interpolates to character

Above, there is a missing space just before "are". That causes the
manpage to render a little bit funny.

> +       with hex code `xx`; for example `%00` interpolates to
> +       `\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> +       When specified, `--format` cannot be combined with other
> +       format-altering options, including `--long`, `--name-only`
> +       and `--object-only`.
> +

> +Customized format:
> +
> +It's support to print customized format by `%(fieldname)` with `--format` option.

I had to re-read this to understand. How about the following?

    It is possible to print in a custom format by using the `--format`
    option, which is able to interpolate different fields using a
    `%(fieldname)` notation.

Just a suggestion. Feel free to tweak or ignore. :-)

> +For example, if you want to only print the <object> and <file> fields with a
> +JSON style, executing with a specific "--format" like
> +
> +        git ls-tree --format='{"object":"%(object)", "file":"%(file)"}' <tree-ish>
> +
> +The output format changes to:
> +
> +        {"object":"<object>", "file":"<file>"}
> +

Nice!

Martin
