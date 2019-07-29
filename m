Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688371F462
	for <e@80x24.org>; Mon, 29 Jul 2019 00:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfG2Ad7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 20:33:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38893 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2Ad7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 20:33:59 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so41167514ioa.5
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sDxo7XDGZuedZucXlxkxbkAYvphjhsgLID6yc/qBkLE=;
        b=Y1ZXAZj1wthUILB98NJlU5V4QvAZs+1zzlQa5rwxD8o6K/KGmNWXMSm7usPMdwSPia
         EPQ516iHW2e1WrpJekpEsY/HHlBX649j2GpTDiN/22mjPUTsZef5EQXHX7Oq4aLDnWav
         I2pgjvVHT23Sun7OUOU3H+07FWQEkApQ84kBGSFtrT59Zr/W45vIZJCxj3lOq6GsRx9p
         J7fd7U+ZnM8P7pSbFaIWoX/Dp4NNTtPYG7YlgXF7YCok4aa4PZdQDv0obsss7PL7N2Ba
         34bV8oTOEQrqIZjvCmGkap5c3Ots1Kw47RAjyDaj/OpvtjZyOzb3a7dd0QUAy/Lq9NF8
         mDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sDxo7XDGZuedZucXlxkxbkAYvphjhsgLID6yc/qBkLE=;
        b=US2zHQd+K78r2wY6X4L9jglPeIIWFE8g3DSDvBIX8TITuIMCmTRPmy29Fqcx6QlmUI
         /qO++Rk/4g74rBoa9ULb6aQRifekclzLnFxEFhxF2+ckqsZY80jpjCdi/B8RRDJeQ7H+
         ECfQ43zMZtNFJakuSxDbrdXph1Hv+EWTvYf7kpGei4p5VvNKR8AUUcL51T+8Fnu8A9kg
         8y4r+rDoWKCIQ4edHrU8ccNsEwKxQX6kDC78rW02k2AettMOp5+iYDydKodag6FUUMCs
         RrUkPd+HttSrwetmL5yspCJoolf9E0qucCnegJp/1szOnCvUFIEyDx8sI2sa8Odq23Et
         as1Q==
X-Gm-Message-State: APjAAAWhVls08EDDNrO5B98why5gxuBYsmpiOHf+q6YlW9xux9oGI8CC
        9rnr7QEd1BpTOwGbzOcQ4Ent+yrJpI8olkOX3aY=
X-Google-Smtp-Source: APXvYqwO7wscEvrCMLkBLtd/15KFrhBKyQ/th8OvE3GvbbMUTP0ugg+ZrH5b1sC+mppPKyREVlYlAfZJqYfEC8aYoaY=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr34510023iof.162.1564360438223;
 Sun, 28 Jul 2019 17:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-3-avarab@gmail.com>
In-Reply-To: <20190726150818.6373-3-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 17:33:47 -0700
Message-ID: <CAPUEspgUiicBPKPZPyDFryj3OmtyOWVgrytqpzMq-PZNv1f1Mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] grep: stop "using" a custom JIT stack with PCRE v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 8:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> As noted in [3] there are known regexes that will fail with the lower
> stack limit, the way GNU grep fixed it is interesting, although I
> believe the implementation is overly verbose, they could make PCRE v2
> handle that gradual re-allocation, that's what min/max memory is
> for.

The part I liked about the grep implementation was how they went above
and beyond to make sure there was no abstraction leak and at the end
the end user doesn't even see a PCRE error message.

Presume thought that the end user we have is different, and might make
sense to expose them to the underlying mechanism, but in that case we
should also provide them with knobs to tweak (like the one I proposed
to disable jit, and that in this case might be to set a stacksize)

> So we might end up bringing this back, I'm more inclined to just kick
> such cases upstairs to PCRE maintainers as a bug, perhaps they'll add
> some overall "just allocate more then" flag to make this easier. In
> any case there's no functional change here, we didn't have a custom
> stack, so let's apply this first, we can always revert it later.

agree, LGTM other than by the comment below

> diff --git a/grep.c b/grep.c
> index 95af88cb74..4b1e917ac5 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -534,14 +534,6 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>                         p->pcre2_jit_on =3D 0;
>                         return;

this return and brackets no longer needed

Carlo
