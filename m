Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFCC433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 07:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhLRHo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 02:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhLRHo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 02:44:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413DC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 23:44:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y12so16358377eda.12
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 23:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ea3yzO46l/eIhQN1mw95XBGGAzNgkMprhI+jFz1AICE=;
        b=MB2B0yF0IgYfNC73Po9boC1L7afG49/ehWlhj8+GVg5Nj5nndasqGJyv9+BluvQlfl
         KLDeB45hvg5au1FgYNf5m3bx+MeglW9ys0D96x0njbGeLg/sR7tr/jGpcqRA9+8ARQyy
         Ok8NFMtuRVUfR3AsddDfym3PeZfYbySycssiGLGD4VU8ExcC8MLnWrjUU/3jYw35Fztm
         UOmbnUG8qxEiT4VfpkNnsAu9K3HcTqUjYBUNR3oGDY7QtIpkNuCAIy/irNr2zwBWwpMe
         dWJqXQ9BTZxh7earSO6LXh7vw4V0/nycaY8abJ6tNdklOPiYvhkTkcWUpSj/Q68PidLh
         z7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ea3yzO46l/eIhQN1mw95XBGGAzNgkMprhI+jFz1AICE=;
        b=F4z+KRY3ZF5zeQKpqEnYd+Ufnq1RiUsIPl7p8FA/YbK2AWCpv1M2bMdeUxMF/zEsig
         Bd8+fyuT2UUkYUYYDUDxkQ94TKM/wtVCo+F9PbaS0bhLPqXmpCvvSvVrudIt/TjuW0J2
         uIgVH6b+EB/QhIyRceb7PPvrHL+5B/KkcVreTSRnZZtvOEfKlQcf1kea9qlMb459YTmy
         jgaGwwSWdGASbj7HdLPwYaqf4GFqt55zmvGDgd8QRMgUiepPWQ4e9PgCOvCM9x0B9aOi
         Hq6SGZwcKW6l1jkQE2jdnvzEZU0tUo5tUP49RpqC5yQHasV5OsSc8AUPOOvYDfIrwLZu
         kI/g==
X-Gm-Message-State: AOAM530DiudllOZ4XhOeTNyGDGa/aKdYRQlxzN7iLA0tCYAfr8j43B1Z
        pcXM1H0KW1k2EKdyAr94rLk=
X-Google-Smtp-Source: ABdhPJzc51NSEoDFDWSfT7tw2l7D/a/mhRnBxQuBCQSRvbvxgMcj+lNIojOcl9BJ1MTJNm0uQzqsTg==
X-Received: by 2002:a17:906:a1d0:: with SMTP id bx16mr5283812ejb.154.1639813497488;
        Fri, 17 Dec 2021 23:44:57 -0800 (PST)
Received: from smtpclient.apple (ip5b41ac66.dynamic.kabel-deutschland.de. [91.65.172.102])
        by smtp.gmail.com with ESMTPSA id sb10sm1147598ejc.121.2021.12.17.23.44.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 23:44:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 1/2] git-p4: print size values in appropriate units
From:   Joachim Kuebart <joachim.kuebart@gmail.com>
In-Reply-To: <20211217203856.2339161-2-jholdsworth@nvidia.com>
Date:   Sat, 18 Dec 2021 08:44:53 +0100
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39F3A9A9-AE61-4C2E-AA66-6B072634D91E@gmail.com>
References: <20211217203856.2339161-1-jholdsworth@nvidia.com>
 <20211217203856.2339161-2-jholdsworth@nvidia.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 17 Dec 2021, at 21:38, Joel Holdsworth <jholdsworth@nvidia.com> =
wrote:
>=20
> git-p4.py | 22 +++++++++++++++++-----
> 1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index 2b4500226a..4d8a249b85 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -56,6 +56,16 @@
>=20
> p4_access_checked =3D False
>=20
> +def format_size_human_readable(num):
> +    """ Returns a number of units (typically bytes) formatted as a =
human-readable
> +        string.
> +    """
> +    for unit in ["", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
> +        if abs(num) < 1024.0:
> +            return "{:3.1f} {}B".format(num, unit)
> +        num /=3D 1024.0
> +    return "{:.1f} Yi{}B".format(num)

This now has an extra pair of braces.

Cheers,
Joachim


