Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274CDC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349858AbhLWSj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbhLWSj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:39:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C80C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:39:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v11so5977287pfu.2
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sAm8h+H3seJADdfv03O2ydgH7fTRACGJ8DNhTQssw5o=;
        b=b10E5GaL6fApHl9t2tTHFRYg/sAwYLBmSdmOZhWZRyFaYJNrmrowHGNHC4OkGBGyi+
         6WM/kMUWBiBBmvJIx/WJusWH2mQBjVEsTa4vokzYpd7uaCinRhKQQXmyGbfUTnRH1eb2
         QSZlZ7TMoVxuXfHUePqLNrhqZqSaq4xErAHmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sAm8h+H3seJADdfv03O2ydgH7fTRACGJ8DNhTQssw5o=;
        b=tkMze5OF3xnZnfyVT7lhpdvqkvUthZJn5NEIvwHCDnKbk6PH9pz8YoW4tLZw+rkYs9
         un49p2wTAWj3j7YMYiy80rDeGSXYM16Ba2BfMkxnpaWNVKTkExpwXD+/bEKDLRZDGmMd
         Ohz1tFsdj5EhqumoWQNOuqH/UyQfTnAzFSeX7x1QNIHL8YvcYbKqX5kumsfJoBhpOYtC
         hBQKA4QHI4AfFINJP0UCrMDCBuUu+nEBhry1EhiYW/aOhyJ95MF5j+kEg8roazQJbuY9
         g+Fyr0PLwRbr9hg7sA7pj6BoRtIb0WJm76Y63zKyLqolLyZhLD1rGz5k8GPf1lcAEbad
         WHlA==
X-Gm-Message-State: AOAM531xMBpR2y6W984Ywt9WZbUAIe197p6X87xeDqrb19Sv80WinGRL
        F0+tizG81GkwELP9Wy7nmJo9W9zuivBas1k+
X-Google-Smtp-Source: ABdhPJwC0g5sb85JzvPDzPc8XhnkE4bMCeCf91QbZdnPyVhzY9oM6aOOq8wRgsaDzrL8cUa//Ajb9Q==
X-Received: by 2002:a62:8443:0:b0:4ba:7251:f087 with SMTP id k64-20020a628443000000b004ba7251f087mr3699737pfd.16.1640284765471;
        Thu, 23 Dec 2021 10:39:25 -0800 (PST)
Received: from smtpclient.apple ([2601:642:4700:fe2:b8a6:9c03:e911:7f00])
        by smtp.gmail.com with ESMTPSA id y65sm5472001pgd.79.2021.12.23.10.39.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 10:39:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
From:   John Cai <jcai@gitlab.com>
In-Reply-To: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
Date:   Thu, 23 Dec 2021 10:39:23 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems like this bug can be generalized to =E2=80=9Cgit name-rev =
--stdin=E2=80=9D does not work with --no-undefined nor --name-only

The --name-only case seems clear to me that we should fix it. It=E2=80=99s=
 misleading to return the sha instead of =E2=80=9Cundefined=E2=80=9D for =
a rev without a symbolic name, as a sha could be a symbolic name.

I think we can also make the argument that --no-undefined should also =
die in --stdin mode when given a rev without any symbolic names.


> On Dec 22, 2021, at 2:05 AM, Erik Cervin Edin <erik@cervined.in> =
wrote:
>=20
> Hey all!
>=20
> I ran into a situation that I think may be a bug
> using git name-rev for detached heads.
>=20
> Steps to reproduce:
> Create a detached head
>  git checkout --detached
>  git commit --allow-empty -m foo
>=20
> Expected results:
> My understanding is that
>  git name-rev $(git rev-list -1 HEAD)
>  git rev-list -1 HEAD | git name-rev --stdin
> should yield the same result.
>=20
> As well as combining with other flags
> like --name-only / --no-undefined
>=20
> Actual results:
> Where this fails as expected
>  git name-rev --no-undefined $(git rev-list HEAD)
> this just prints the SHA wo failing
>  git rev-list -1 HEAD |  git name-rev --stdin --no-undefined
>=20
> "name-only" is also affected
>  git rev-list -1 HEAD |  git name-rev --stdin --name-only
> returns the SHA and not the name
>=20
> Tested on
> git version 2.34.1.windows.1
> --=20
> Erik Cervin-Edin

