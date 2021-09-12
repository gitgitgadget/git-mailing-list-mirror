Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4790C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2A360295
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhILAhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhILAhq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:37:46 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8CCC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:36:33 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id f18so1845816vka.12
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=glGdPi8oRA+YV1Xp6moIWcg3Wpw9KPrMATDVt+CtfBs=;
        b=hDRzvIUhhvM1plkWKdYCxLGToCGAPbidajmimlSqbnfbUtpMO2oG/7lPU2HKGNtMwn
         hmOtEa4hQoWiYgrjDo+aobVP+iI7aliZFBC+zEADIKXere+FXL+bX8IzRaNspZUkprqj
         h2mrycJKq+Ti5u+9qJ8iWgCGyMzhWTTG5Nv7UtE52tA0TZiNYSEu1WmtCd+X7zRbpatR
         uOyqqATnolsxTLZxa7GpDJDzuv79JJuHoJECEgk/K/YavLk645rhl6jZJpBjYHoNNSZJ
         FCYAgmoIPGZb51e3QbZmJCdInjcLHC4/KJ6R2Gws3rvOSN3z/Sj75QIten19JyvI6os4
         i8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=glGdPi8oRA+YV1Xp6moIWcg3Wpw9KPrMATDVt+CtfBs=;
        b=Z4iIrSTTdPNKJYB6fDWIaF6CwOf+RcPEENOO/zpcO2FwGxKAqLxLvG/RtNvYIcywds
         7bWZVLYjQBZFIUSnRryIjSH24v2q19JBcfD8i/3hrP86AShuVq8sSR9LOVQd+bLzs0oy
         62RDovcJl9cPrEwu/cbZCThYGjY8E96rmQWDBH6AHGsu4+BjnaUUuOh7H+qUHYoZQWsH
         IEBAGTS6oG3U8dOkwVzg+PcotjnX7DX5wk5e35tSRpa1NafnbBPo9quInLpoDqOP2LRZ
         iUOSBHHc2qgr9gIM/5LmESNji/Xdz9OeXTB/hZBXuCR4TFv6h79KTSvgcj6BcOB8Y+B0
         8mSg==
X-Gm-Message-State: AOAM531Zqj4ojHzF9r1e+gs1YZHChEp7ho8wQ5TGB+b9g8oTU7NMrWnx
        TcrS822/dBcUcmHmJGozZRKdGJKRgHc/olFTEJCVMSsO
X-Google-Smtp-Source: ABdhPJy0NFjldDbfaXLlO+fQFlRNCT65IXhBNCr9TiVpl2wAyUGaDVLBqB5o0xDtyK80R2OJU4E0EIV7m95pd9Ji2zU=
X-Received: by 2002:a05:6122:8d4:: with SMTP id 20mr1762526vkg.19.1631406992086;
 Sat, 11 Sep 2021 17:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com> <patch-v2-1.7-2ef48d734e8-20210912T001420Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.7-2ef48d734e8-20210912T001420Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 11 Sep 2021 17:36:19 -0700
Message-ID: <CAPUEspizWWigu4yb_fK1kmzJDx7G0JUOFmRsAfaKeuvTPrk4bA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] remote-curl: pass "struct strvec *" instead of
 int/char ** pair
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 5:16 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> We'll be changing the "int nr" in the "struct strvec" to "int size_t"

Did you mean "size_t nr"?

> -static int push_git(struct discovery *heads, int nr_spec, const char **s=
pecs)
> +static int push_git(struct discovery *heads, struct strvec *specs)
>  {
>         struct rpc_state rpc;
> -       int i, err;
> +       int i;

you are already splitting them, why not then change 'i' also to be a size_t=
?

Carlo
