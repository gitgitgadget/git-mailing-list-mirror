Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA25C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 05:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE720787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 05:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/79CwsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgDCFUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:20:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44651 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDCFUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 01:20:03 -0400
Received: by mail-vs1-f66.google.com with SMTP id e138so4152876vsc.11
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=loSimIxhmJjJXfr1h1iyghNOolZ1OlFDyyKgk2wV4tA=;
        b=h/79CwsCpL0n8Ommxdhn3Cbty0wrtnOY6XDiv+4lfQMOGHrUqzydqq6c++SkU8IADr
         hafHt0QH5qtbOycTJhe6R1Y+wUrrTKhdUBEY4riAvcN8x4eTXG0FStirCYPEmCuUPAnM
         b0LPYEA6HCr+Rze2tRWIXSMefoAQe93Uc/oLuJ7RrMHR9cevPFpi2Y1etE5RHgsRVsFW
         zP9kEJL2HOFS4oz8qiEADxPRU5cJAxEC68QfVcHt8p7bgeskZnJvipByu1L6jf7DX7L1
         hph/wJ7dEs9nQtHTNM/mhQTgA3fWK7JmT9yaVle1ptBX3Ipoy/XDlPr9aOpENXzoYd8L
         UTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=loSimIxhmJjJXfr1h1iyghNOolZ1OlFDyyKgk2wV4tA=;
        b=SjWP0u7ubV9WeQvz8u9Al6z0399PJ5MTCFBYyTQx87HewTqvTJ+FEMOP2cFFtdEmbi
         Th67PDVaUIZyjp00oldKjUvtDR8PSpLzcJhnQu1brxfbV+MMpY4bVq0D0CYX0r3xHYUf
         29wqKUiAQ6PQ9cYdb8cKkCCaLms5M1rGmuz+1vHq2VK2iy7dMYjZh18NXAtRKytJeLJY
         uFgrOO2Fyuff2OKWDNfi/MxG2P8p9+E2eKyLUv07xCUYVV7xB0JUA7YR688wYjT+3D/L
         QGfZLIWKyjcrZ/D7yn4U8vJ5LdJBaw9ofLMaTzofA0IEHqqfw7iLaQSPYEf1ypuwXxP3
         rASg==
X-Gm-Message-State: AGi0Pua4GM7HImK6U4iSr7+vgiqO6B/PaG+O0hVD9rviqprK2OiiQodY
        fM5NxvMBs4QYXy3P671x663O9TyCLyLnSt5zXdg=
X-Google-Smtp-Source: APiQypJBaM5ENkrQEsjMU7PwDmApH5TxIjxIlMhND8pfT6CuS2YaQcl5X8Y+XCRV9wmpVN0KhpdO2178uXumXS8yxw8=
X-Received: by 2002:a05:6102:116d:: with SMTP id k13mr4857650vsg.79.1585891196738;
 Thu, 02 Apr 2020 22:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200331064456.GA15850@danh.dev> <cover.1585821581.git.congdanhqx@gmail.com>
 <9975d4c61301f865dbd6aa3e1f70c6b5cc64daf0.1585821581.git.congdanhqx@gmail.com>
In-Reply-To: <9975d4c61301f865dbd6aa3e1f70c6b5cc64daf0.1585821581.git.congdanhqx@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 3 Apr 2020 07:21:58 +0200
Message-ID: <CAN0heSob_O4hNj8-9eLc3Qq-Cj-SzWyOkdQh8zG0bqSFTvpwoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rebase.c: honour --no-gpg-sign
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Thu, 2 Apr 2020 at 12:17, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <co=
ngdanhqx@gmail.com> wrote:
>
>  -S[<keyid>]::
>  --gpg-sign[=3D<keyid>]::
> +--no-gpg-sign::
>         GPG-sign commits. The `keyid` argument is optional and
>         defaults to the committer identity; if specified, it must be
> -       stuck to the option without a space.
> +       stuck to the option without a space. "--no-gpg-sign" is useful to
> +       countermand both `commit.gpgSign` configuration variable, and
> +       earlier "--gpg-sign".

Please use `backticks`: `--no-gpg-sign` and `--gpg-sign` just like you
do with `commit.gpgSign`. It will then end up typeset in monospace. This
comment applies to all five patches.

Thanks for working on this.

Martin
