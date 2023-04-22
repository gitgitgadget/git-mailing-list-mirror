Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992AC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDVVZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDVVZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 17:25:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1722697
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 14:25:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f199696149so4350475e9.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682198755; x=1684790755;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SEdPnzKVCOWkYLvqviDXBhHf6cCjgbAXji+dXl/ofQ=;
        b=ceY6Vv9tw81o9OPmlWHeDbKiex87yNzGHCndrYSSUmKOTTEamKlj9woJtd1tmP2CUz
         nw0RdHp7WZTVob/Vj8MBtc1TBMKbVtguBEMjbbsSTevxpWhdfoFOfo0dIlk+rFze0mJz
         B7EusuKd86lRG3UHLOxYuiFLbLjjxibYOlDAq5bzifcVU6pHYBiJl9ZnYPxQf2xGgYXx
         7QH/E3jb0hVzPlgruQY74S6no3np/6Zs1SWJ/NkeiUKujXy/69L1QS7R3+EQGAQQ5mLE
         8H0wOY5PAEkbhLFKpSXz5pTGqNYELQXcXu13AKiybJ6OxSC6TLuxbpdEQSWFkQjamG0a
         48tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682198755; x=1684790755;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SEdPnzKVCOWkYLvqviDXBhHf6cCjgbAXji+dXl/ofQ=;
        b=OKZgTikXUuxGW7zYqwtVzNEBVBt3w3drqE7xtYph2UwSOin5Qa5tw6o6hsAZiRgXK9
         bzNMdBD6I/TP/eKnSVqe3SndjGhp6JGQTGxf3+gMk98T3jG4aH7SdrJQK6Yc8g4kFL1C
         Rtao+OQBv0koxrOZELQtsqLDpyLK9Psxos10dQrNTaIfq8TOOdCEE9E6pz9/uirv+66M
         NQaVPCCX6UaR1YJJ/lbSzoLEZ7E/aOjVJ1mOtHrSKGzRkIikrFTrx3x/bzXb50ghCVM/
         9YRalwI23X1eQ82/fulqw7gvE2RCcaJ7X/xT7hE1iDpKYA+ytQrc1i2I83kMd0SFa2Cq
         UPzw==
X-Gm-Message-State: AAQBX9e/CI1jeT1QQmhItnbD9/PZNINpwr/PuWb7p4dEkQRJyBqETwI9
        AcSN55Ok9UbEWLRmQKPYwlcXNlRyP+GNf9t9bcBbRTAM7ac=
X-Google-Smtp-Source: AKy350bod76QXb0yupWTL4w/5v8ukahJz6AiF/i6dUrJZrlxNb+Pv+WMC5sGvlthac+AvtE29bnNSvqobG0ftG05DP8=
X-Received: by 2002:a1c:ed01:0:b0:3f0:a9dc:a369 with SMTP id
 l1-20020a1ced01000000b003f0a9dca369mr4645153wmh.19.1682198755333; Sat, 22 Apr
 2023 14:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205241.105476-1-cheskaqiqi@gmail.com> <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-3-cheskaqiqi@gmail.com> <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
 <CAMO4yUF1P1Sv1aVJ1aw9US-QeNYD-GfaS7ndr=bwp-dgvOyexA@mail.gmail.com>
 <069a53ef-63b8-c1e3-7502-6728bda50665@github.com> <CAMO4yUESBZw2Jr8y4NW_2N7640o2o2mpq58+nnC+3qffG3Y8=Q@mail.gmail.com>
 <111153b4-dba0-b533-fe49-57a6d5d3ba22@github.com>
In-Reply-To: <111153b4-dba0-b533-fe49-57a6d5d3ba22@github.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Sat, 22 Apr 2023 17:25:44 -0400
Message-ID: <CAMO4yUEsB=Rnoh44V1dykCkymF6qQJTiQyn_3s=L1PedaUcN7g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] diff-files: integrate with sparse index
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Fri, Apr 21, 2023 at 5:26=E2=80=AFPM Victoria Dye <vdye@github.com> wrot=
e:
> Only the latter represents incorrect behavior. If we're aren't expanding =
the
> index for a case that was causing index expansion before *and* the
> user-facing behavior is as-expected, that's the best-case scenario for a
> sparse index integration!
>
> Taking a step back, it's important to remember that the overarching goal =
of
> the project is not just to switch 'command_requires_full_index' to '0'
> everywhere, but to find all of the places where Git is working with the
> index and make sure that work can be done on a sparse directory.
>
> In most cases, it's possible to adapt an index-related operation to work
> with sparse directories (albeit with varying levels of complexity). The u=
se
> of 'ensure_full_index()' is reserved for cases where it is _impossible_ t=
o
> make Git perform a given action on a sparse directory - expanding the ind=
ex
> completely eliminates the performance gains had by using a sparse index, =
so
> it should be avoided at all costs.
>
> I hope that helps!

Thanks for reminding me about the ultimate goal of sparse index
integration! I've learned a lot from it. After looking into the test
failure, it seems that the index didn't expand in cases where I expected
it to. I'll go ahead and update my patch.

Thanks,
Shuqi
