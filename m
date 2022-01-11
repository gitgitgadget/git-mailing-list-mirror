Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2720C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 09:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349288AbiAKJfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 04:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiAKJfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 04:35:06 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BF8C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 01:35:06 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 78so9921615vkz.7
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 01:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gGVf7vj2URV0XeVbOa23P3npX3CLIHHf2cZV8YzKBRk=;
        b=iro1rW8SCppxbaeXqU8nTvotAuaWjCIZMUTOWCpow2xlCHeRF108+xC7SIsZ5emcZe
         jD1v/fetIJqrguu+4ZbPJuKgZ2weeZpM3UZrERUEZdjjZnUL6QU7exqMdFEqO1Yvao/6
         bvEPkwaliqpmkmZxOrE+zq6RsPKdtmMrhYx370LxgJU/6YoWjCxeLHh873gMSImim3dQ
         w3HX3icZK3SoYBqyVz80MkzF9GEUHoQvGrZSLtJE1KYBM3X/yv5uZ0UN++dC0mEpIJ+q
         PakYY0nlBO6FdWDQzvSn5/baR5uKZlF8nDUHVVRpzJo9rKHaeuTGxjhpBDU+TwSyW/O5
         4hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gGVf7vj2URV0XeVbOa23P3npX3CLIHHf2cZV8YzKBRk=;
        b=3E2Rmzh7uvw5TyvNmxu1QqCyP4MEEAtatPp0bbD72ebDDWrRzJgKpJrWuVFWtLGC06
         G7MS6dxU8AvrqjCe3A+kJJU6WRm9BE3q0TkwIjo1q7q+zVUILNtIa8pM+rfNAsGKQdZI
         lIMJC/teUuG7eCSpBtveAIcFkge+veMH4LUVf/NeMBpAxW2qfsPC7HpiSEb+tW9A7pnc
         PAdbSGgfIYDX9rcWoOaWFYbVCCBUUCTUxBiyV2tjc3nNjQ4duWWGqfaDVdJPsL1hUH1H
         ZxD+cwQuh4Zjq/iMzvEu+Cr4FhmYz31wx856aH31ztIw3QyVnEJHK/khJuR/zBDFimPK
         cYOg==
X-Gm-Message-State: AOAM530Q5xtGu9vjdlHS1zMWVFzLSdrl8CC9QtpkLrT0RJGACsyqYEPy
        ojxo190pXxKg/7djQ2bikXg0SB2VyvLiYq4Pzsguh4YtJWWhGgBMW+w=
X-Google-Smtp-Source: ABdhPJwKkBhIv1Kqkc5zBV5haTYx7o92Xiqw1lKW4hpG86pxVh9aS5fPvZ5cF7qYNP8Nsp83bXBWoJfTFwBySbpg50I=
X-Received: by 2002:a05:6122:181b:: with SMTP id ay27mr1647259vkb.36.1641893705190;
 Tue, 11 Jan 2022 01:35:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <7df58483a4f665f9f54b92a97a6b57704f1e7a0d.1641440700.git.dyroneteng@gmail.com>
 <CAN0heSoTRpymQh0w2pfJcy+16nTHa6MwY+BAqkvfAmQsnj2ihg@mail.gmail.com>
In-Reply-To: <CAN0heSoTRpymQh0w2pfJcy+16nTHa6MwY+BAqkvfAmQsnj2ihg@mail.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 11 Jan 2022 17:34:53 +0800
Message-ID: <CADMgQSSjSZALdbPhaOSSP15=FszKy4vLtnGBDLeOqPuzmHDgSA@mail.gmail.com>
Subject: Re: [PATCH v9 8/9] ls-tree.c: introduce "--format" option
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 3:41 AM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:

> Above, there is a missing space just before "are". That causes the
> manpage to render a little bit funny.
>
> > +       with hex code `xx`; for example `%00` interpolates to
> > +       `\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> > +       When specified, `--format` cannot be combined with other
> > +       format-altering options, including `--long`, `--name-only`
> > +       and `--object-only`.
> > +

Thanks for reviewing.  will be fixed in the next patch.

> > +Customized format:
> > +
> > +It's support to print customized format by `%(fieldname)` with `--form=
at` option.
>
> I had to re-read this to understand. How about the following?
>
>     It is possible to print in a custom format by using the `--format`
>     option, which is able to interpolate different fields using a
>     `%(fieldname)` notation.
>
> Just a suggestion. Feel free to tweak or ignore. :-)

Yours reads more smoothly than mine, it will be applied in next patch.

Thanks.
