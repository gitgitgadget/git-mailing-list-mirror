Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3015C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD24E61990
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 15:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCVP5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCVP4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 11:56:45 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6BC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 08:56:44 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id j4so5699454uan.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DW2Nw3vkaJhhWwshewn8q7El5JKdWat5Pb0+/11zKUc=;
        b=u/KKWXTguyfhhpnCzqbLAHwHdgM+HOCywcAC4b39x0lA5jjV9fQWxyWaucxPAnPelb
         RyEkR+zarOU2mxRz8i6RTJtTTOLfda+Es8ScUPiFUKuckbWs1qo0WKjahwwTRNDXMgiz
         FRI+G8b8v1/SnqVE9BwiPIs8OsJqiRqY9L4z8HowX3KC8r++IXw3vrIrVmHrl8cBrklu
         RjFZKdVKUG3AcVIe9xT5+OVJtGdY0bQdYsNHuMeDOYBZwOYKsLSsoR+Jp8HFMkjv9F3m
         zUAY7cP8vZONu9fKrUWHQVav+X1UsIIU/si0ZuJXIWXLcEZVUnRsLGXogknkF7QsqaEW
         YZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DW2Nw3vkaJhhWwshewn8q7El5JKdWat5Pb0+/11zKUc=;
        b=ql6K5Ksd9SjtYHR/hCOjbitC1qJUqDVFie9fr76+X+w6ZPuW+mPyGFsirMt/ZOA9Rk
         tmpDW+Rw/zx1q3mL4B1CC+8wZILlHz0EiXfpQKmLDtKkHhW/yi2q8sQreGwiUqslioeI
         DWiEBHsWTtCGV/ioMawCSekQhyqwqyZGdmD2ZpG0/XzbPK2UUDtnahnfS9wD8WbPwWVN
         npKjIg6R9vqJxD8w3mVyAqDU2r/dMDd5NSA2m3ddUmCtFlsg4wreWcW08LfWXPH/g0OG
         x0l19O8arfb9TPJDvU/95UvUFfE80R4YDAQ7HFUTGoGEyzlLGqEl7lFTEJrkN0tcexiz
         GnhA==
X-Gm-Message-State: AOAM531PDWwgIVNPvaawY+kOTDm9kszAwzFUqTGbJD7zXLixXP7ppeid
        /pc/iDENNLDECCzRBuseNHkK76DIQTHDw8y/9z4qdSxImsNy/w==
X-Google-Smtp-Source: ABdhPJz9CVJb+jWnbT7uS6wwtCdCLyjK06USpyfa/XxA40aUozG8kDbCLV9nqGBRc/80Cc8gFqLLt5FQdQHZ9cTGkPo=
X-Received: by 2002:ab0:461:: with SMTP id 88mr542493uav.80.1616428603633;
 Mon, 22 Mar 2021 08:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <87eeg7qpyr.fsf@evledraar.gmail.com> <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
 <87blbbqju3.fsf@evledraar.gmail.com>
In-Reply-To: <87blbbqju3.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Mar 2021 16:56:32 +0100
Message-ID: <CAFQ2z_ML8s0Gk4Zmg+2mxzkfP1AbL=zkeUG0yKEtoege7it-vA@mail.gmail.com>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 4:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> We can know with !strcmp(rows[0][1], rows[1][0]) whether the latest
> update is a ff or non-ff (it is). As opposed to:
>
>     $ cut -d ' ' -f1-2 .git/logs/refs/remotes/origin/seen | head -n 2
>     8b26a41f4bf7e7c0f097cb91012d08fe8ae30e7f 0f3a981cbd5be5f97e9504ab770c=
d88f988fe820
>     0f3a981cbd5be5f97e9504ab770cd88f988fe820 fdd019edfe6bc60d0100d5751c41=
e4f6ad28a2ef
>
> Where the rows[0][1] value is not the same as rows[1][0].

I'm confused.

rows[0][1] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
rows[1][0] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"

they are the same. I don't understand your argument.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
