Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FEEC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB2522260
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUjqufNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgKMXrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgKMXrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 18:47:09 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B20C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 15:47:08 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d28so10888075qka.11
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 15:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kbKjgrQazXAjPBLhCDQeRrkIWaWCDOHQz1B4L6NcT0U=;
        b=VUjqufNqBb3U5B8wKI5XD0jVqAkX3MVL2AE5/VEzgIcJkpiWpwjUbEVKM5JFRiJ3bL
         eHEXqImw4c1V+uUEDY66i1ke8qpxRweEFnKpUiudiFVl/OwBce8IuHnKJkP2eF2NXdrs
         wnWenKC3igOcD8SjQkaNCIv7x2VmtyKPVaN+5GsKLRi1rszOI7uz/j3aoYVqnYLFyjCl
         LflqqpOuD9kpBSJR1xvX/FaWfaful3Sez1gdsq734unJeaoCum6yHjfJH82LvyglkxRT
         dJEhmtX2LOjW+pdac4BEMG1dSrtapcKA2pO+lCRj5+8/HOCePlTkGezsSGh3jBZ8q/eS
         L+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kbKjgrQazXAjPBLhCDQeRrkIWaWCDOHQz1B4L6NcT0U=;
        b=Fo8+f1O+NPsSM/Q1grXr3vbVO6111nNRkM7DpsuhVkdEKgjuUVpGZIpBKvku2denL5
         d6orvr6xf+bCMqLkoRdyq0bWydIzx2uVbxHYsmlALWSBxl/bWCTZ4LloHQRywlz/Znyx
         Ki1RZQmK1dP4BomRUqJ2/4cyekdQA0cikh24pOUxKw2gPmAJI1bnktk5XpHA2uKTdq5x
         aoSr0q+eARH9eCSoQUEa0BI/k02u6xQWRG9MWc5/R6523+NvT7mDS+3Hh5v84A6YL+y0
         zc1IiQGlfT5ZnJaEdbkvd9Jv6VSEbPm6FApJtuvpBECvTUW1MojJ9D0t6dFoT/v5A/cp
         858g==
X-Gm-Message-State: AOAM531dzrDeYIVQEZVxIBwfCOo2wWAXnW1FqD9ljgIumy8i5lELnXdf
        pv5504kOAvY2Fj/PB4aUZpQ=
X-Google-Smtp-Source: ABdhPJwTEy+2xtMmwrwlgUvyFukkdxgzBDjNNVj/iQ/S2q8X0gJbFVdH10S9W4zE9u4LoL2CDfpi3Q==
X-Received: by 2002:a37:9c83:: with SMTP id f125mr4584004qke.149.1605311227922;
        Fri, 13 Nov 2020 15:47:07 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i21sm7343844qtm.1.2020.11.13.15.47.06
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2020 15:47:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: fatal: cannot rebase with locally recorded submodule modifications
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <660c39af-d0f2-5e4c-66a0-5c78b646b023@free.fr>
Date:   Fri, 13 Nov 2020 18:47:03 -0500
Cc:     Git mailing list <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20D6104D-CA02-4CE4-A1C0-2F9386DEDA3B@gmail.com>
References: <660c39af-d0f2-5e4c-66a0-5c78b646b023@free.fr>
To:     Brice Goglin <bgoglin@free.fr>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brice,

> Le 7 f=C3=A9vr. 2020 =C3=A0 15:50, Brice Goglin <bgoglin@free.fr> a =
=C3=A9crit :
>=20
> Hello
>=20
> I don't understand why git pull --rebase --recurse-submodules fails =
after a git reset --hard
> to the previous commit. I didn't touch the submodule, it's supposed to =
be clean:
>=20
> $ git clone --recursive git@github.com:open-mpi/ompi.git
> [...]
> $ git reset --hard HEAD^
> HEAD is now at 395e2c9d8f Merge pull request #7364 from =
awlauria/fix_compile
> $ git pull --rebase --recurse-submodules
> Fetching submodule opal/mca/hwloc/hwloc2/hwloc
> fatal: cannot rebase with locally recorded submodule modifications
>=20
> Why is failing here?

It's failing because there is a bug in the code for 'git pull --rebase =
--recurse-submodules'
when the current branch and its remote-tracking counterpart have no =
fork-point,
which seem to be the situation happening here.

I've just finished a patch series that fixes this bug. You can take a =
look at it here:
https://github.com/gitgitgadget/git/pull/789. I will send it to the list =
shortly, and will
CC you when I do.

Cheers,

Philippe.=
