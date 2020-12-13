Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD99C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 10:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD2F22B2C
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 10:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgLMKL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 05:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgLMKL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 05:11:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA3C0613CF
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 02:10:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n26so18450276eju.6
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M9XQGi/ZNQ79EO16lzbMzSnbsJFoINMbqAgZ48v2w5I=;
        b=OmNIUlrVWR3VwovcSN0hTqcuLf1Ts0W9fpAUBubtxEI6CWZDuyQB6ng9owCiX7boxD
         t96yrDvJCPaJ+5/SK80p9sLv+/LxZ92UduINmr+hQ2Pb1T+cqA/Zp89eDLzD+6igd53j
         2CDH5Sh2NiV8DfbbY5q5ENHuC/CKRvpOr+7Zizvde0zwlOCaVOfGbkUsf/DNOmd2T/sJ
         rSABZyX/Fc+BBvHhVR7qbCEZVi9jcsPgGvD4rksEXeBqJU5XXSwmP5dRnA2DOQwpCTUk
         TOYjHzv+kjiFuRnMInKmBO81AWPW7YozDZbOMDyaNQy3aFxzF8HwZLA2V0EtmolI4RUp
         PVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M9XQGi/ZNQ79EO16lzbMzSnbsJFoINMbqAgZ48v2w5I=;
        b=LdyuEUMgFigYcXymNd49JpDQUJvkorHbwPwzt8H0k8rWh5ZGUiLKGnTQ/PJyNgPUbp
         PsdYPbrShKXGOQckn50D1+6A/BtE3t3D0SUxi8YiDUJ1/QQXv7G9YqaaBAPInvjlYAUC
         HeOcclSNCjbBVvhDaO7DWlNF2P1KJArLganUVanWYjEIEnS3Myd04JvRO7iKypZlzXXy
         viWGsJT2MPk+sGWkZCPWbiEFfY4R3tXqMr//TytbEg+6MAY8zUWvtk9vBExRxyvfZl3q
         4qghYQ+S3kUz0foEN06ZJoymFr90m02Q6v9rIk0Sk7IA7j5RDfjyxUNQxXNRMxKJsi7u
         bsZg==
X-Gm-Message-State: AOAM531QLzHozI2XCE+XFNoTLA7jTSDCK5fTCDbhpvQI5cWwBbO3C+3d
        tlRS4kEXur8UgI8ikFqlhtqqJ7zhUR1WKn/6sK2pWndFgUtQ9A==
X-Google-Smtp-Source: ABdhPJyC2mpZsb1p6LHzIEF9W1TgwQN6rmvwwvda20ssYd0UgSwdm70f022oV9Rx/0/aB8rWVzw93A7ZW6YbrIoRJJI=
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr2035949ejc.197.1607854243007;
 Sun, 13 Dec 2020 02:10:43 -0800 (PST)
MIME-Version: 1.0
References: <6446f471-87ed-9fc4-fd54-61c5cf95a218@gmail.com>
In-Reply-To: <6446f471-87ed-9fc4-fd54-61c5cf95a218@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 13 Dec 2020 11:10:31 +0100
Message-ID: <CAP8UFD2ibGdznacrC=Sf6pZtzEiGJ7v+2L8PbM3m2PDdSBoYYg@mail.gmail.com>
Subject: Re: Cleanup tool for old blobs in partial clone
To:     =?UTF-8?Q?Mi=C5=82osz_Kosobucki?= <mikom3@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Dec 11, 2020 at 3:07 PM Mi=C5=82osz Kosobucki <mikom3@gmail.com> wr=
ote:
>
> Hello,
>
> I recently looked into the partial clone functionality and how it could
> be used to replace Git LFS.
>
> Let's say that I use partial clone where one directory is filtered out
> through --filter=3Dsparse:oid=3DXXX. Let's also say it's a directory with
> big assets for a computer game.
>
> Now, as the project progresses and new versions of assets are checked
> in, I'll accumulate many version of these assets as I get new versions.
> I won't need them though, because most of the time I'm interested only
> in the latest version.
>
> So my question is: is there some tool (probably similar to git lfs
> prune) that will let me get rid of the blobs that I don't need anymore?

I have been playing a bit with partial clone (see
https://lore.kernel.org/git/CAP8UFD35kk10FpUnPpiAUzTHJbm=3DSJ-76OTmkTwBstGF=
e3Zgdw@mail.gmail.com/),
and I started working on `git repack` and the underlying `git
pack-objects`, so that `git repack -a -d --filter=3D...` could work. I
cannot promise anything about when it will be submitted, merged,
released, etc.

Also I have been working on it on the server side though, where it's
ok to get rid of everything that is stored elsewhere. It might not be
your case, but on the client side one might want to keep the (large)
blobs that can be reached directly from the tip of some branches,
which might require further work.

> I couldn't find information about it anywhere in the docs. I vaguely
> remember a mention of something like that possibly being done in the
> future in partial clone (or maybe promisor remote?) patch mails but I
> couldn't find it again.

Best,
Christian.
