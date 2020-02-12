Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B95C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10F821734
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnlFEtUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgBLWIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:08:10 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:46959 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:08:09 -0500
Received: by mail-qt1-f170.google.com with SMTP id e21so2850677qtp.13
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:message-id:date
         :to;
        bh=S6kb/dHeB7ogL6ZOJVVo2ImkiWGnKKyA9RoD4uDknKo=;
        b=SnlFEtUj/35az3Jc9u9qCKZXN9eVu58n39ci50+mEGcD0xJY/E42e7wzNix9tXbBUM
         Kk0DzE3n+a51t+ctuxSV3sWYm90MznlYgGlDfU+LSQGYNKvsP/d0LnZ9rIh3EnFCGAFb
         a/bLClkiFzoUQIOsScFG9bvK0THeF0Rcm4R9hGESFw/39P+MAteTagm3whkobZECE9Vj
         QiwEFpabeee4ULLFP5OMjKK+st5+LhFrnTjdPTGdq+57JvhCKrBW2HnRdwr7ZTSG5zJY
         33QC80h3NNjHe2OX/wce69geiB0aanwqimd1AO7Ze1AGx4B+9v/mutHoBTBUmV2qbjNy
         LSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:message-id:date:to;
        bh=S6kb/dHeB7ogL6ZOJVVo2ImkiWGnKKyA9RoD4uDknKo=;
        b=VSVu7nq9kLYaZKjzKxRwKoxLs9BRGlEeQqxut8qosrtjD6s6ehyxYjO489QQopMU3F
         uAgs0SgV6pQusXXlfuHK7R/+KfGNetDI66jjkVAtrQAUQW0ScgnohI4v83FemYyifxoP
         LIIguC04O1QSpUnvD3H6wFKR5zDkcr9SVzocbtzNVhsoOzMz2NFprYbeEgU5YMKywyHZ
         psdS4V0n0RzYk2B3ZTErxTfHv6zjzbqfRKRIm7ZX0IVfSrbSDhg4pKiPpnH8cwksWEh0
         9he5GiU02z9euBvLwnyM3XF8UhoZg0fPYrIaOpfGXij9EAYINNtWnxqKsUF2g2koO1vk
         O1/Q==
X-Gm-Message-State: APjAAAXOxYGMOd1tFp1YUx6vaykgMt4c2Xn3ZfjsG72shGadjccoJmVU
        7bAlK6VIIr+WsZKWxiGaeewQBsiN
X-Google-Smtp-Source: APXvYqwx5PITwDQh00AHvLmkbC2KeyNymxh72kklXhwWQt7cge9Uq/7xTE7cif269eG8jSDw2pjYBw==
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr21665165qtp.34.1581545288574;
        Wed, 12 Feb 2020 14:08:08 -0800 (PST)
Received: from [100.90.195.68] ([204.48.95.68])
        by smtp.gmail.com with ESMTPSA id c8sm146334qkk.37.2020.02.12.14.08.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 14:08:07 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=us-ascii
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: How to force configure script to use curl ?
Message-Id: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
Date:   Wed, 12 Feb 2020 17:08:06 -0500
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16B92)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was trying to build Git yesterday on a Ubuntu 14 machine that was missing t=
he package "libcurl4-gnutls-dev" necessary to build the http(s) remote helpe=
r [1].=20

Doing just

    ./configure=20
    make

built Git without support for the http remote helper, as expected.=20

However, doing=20

    ./configure --with-curl
    make

did the same; it did not result in an error saying that the curl headers cou=
ld not be found (which I expected).=20

Is there a way to force the configure script to error out if it does not fin=
d curl (or any one of the optional dependencies that I happen to need for my=
 build?)

Thanks,

Philippe.=20

[1] this is one of the package suggested by the progit book :
https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

