Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C2C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 08:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E2F21973
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 08:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL3ICY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 03:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3ICX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 03:02:23 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C962C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 00:01:43 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id v3so3482535vkb.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DYwhAxedQ8kwcZaaVxCUmpMn/KdFGukLak5/SslysZ8=;
        b=KftjOWgf3D8T9RcZCTYum4wuGO/HQ4/LyfwxOSAUQbVYcnsUFKMnhnFagYD+2tLoDI
         FSxCJHO+jbGQ4ElpjNU2cl19e1VQVMnlvweevVQ4auVnO/ClmTe65mFBvJU5HURNL87J
         q/gzlbawedAjH9XNXKDyWQ/bGs74VJ+MjR/D1QMk03TbGOGSV6PSbYvfsyrY0bEvHoQ2
         hG6pTCBDU5pF0fAuZkTZc+/Gf2baLjWFOzmfHRBbUuiA7TyXzDEgS8F2k6TUCl/uyaQY
         sagM3t1vQYC9cJgJ1Dr9HqnjYkdt3XckNVHkJ2//CD5NWOKnG25C1JB6coW9sw2bk9mC
         E+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DYwhAxedQ8kwcZaaVxCUmpMn/KdFGukLak5/SslysZ8=;
        b=ZFcl68O8EfyPm6lU/Zx3a5rij8R/+Ep71jTHfnz+8csIWwAUyB4w9/4W4M/I5g17S/
         d9/qfGQB1DAmYyPJc7TLnXcF79FQbd+vMbxjgSe9ajsh9g+UZ+Lbv0f6Hz8MphGFfnZw
         Wj3eOnHc4PnTcFa5h8jh+BhJ7VgvFHviWQ5Epp1Xp1clSIknmx4fy+nYYzRhEClDOHY/
         5jCRfbRQY7I6H0W1YR2290Q+mvnlD7s8RYprZ0ZPJ7ppirS5BE/t1twt7aL5djt4EDB6
         /tYRT/WaP1OVbuyNQwIwsQzgXMGKt2s3ehpf5GJtGulhTgbZu0YLDYat/rwwup+9HxAy
         FUNQ==
X-Gm-Message-State: AOAM530CmcVA+ro80fpz+9LXnMSYys3U+GrKA/ZhR/0u6HNX2QspBDKB
        mZ2w013ja/fXM14cQKsgDPktn7agkHisPtTg0ms=
X-Google-Smtp-Source: ABdhPJzPwiFsD3MyOZWWD3+7sKVw7ErWD+W7I3Bwvk2qZvDp+obBAgV2fmrox7epHxllVcIeeoFqXfPyP8/5UA3WEdQ=
X-Received: by 2002:a1f:3246:: with SMTP id y67mr27016721vky.9.1609315302130;
 Wed, 30 Dec 2020 00:01:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609282997.git.martin.agren@gmail.com> <4d1f5c59-db2c-3c88-f3ca-1edcdfb2f99e@gmail.com>
In-Reply-To: <4d1f5c59-db2c-3c88-f3ca-1edcdfb2f99e@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 Dec 2020 09:01:29 +0100
Message-ID: <CAN0heSq2ttahii+tUJo92L0ERcbYuS-Z51OhMsQsd-a51SWPKQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] rename "sha1-foo" files
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 30 Dec 2020 at 02:29, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/29/2020 6:52 PM, Martin =C3=85gren wrote:
> > We have some source files with filenames such as sha1-lookup.c and
> > sha1-name.c containing a few variable names, comments and the like
> > referencing "sha1". But they are able to handle SHA-256 as well. Here's
> > my attempt at removing "sha1" from the contents and names of these
> > files.
>
> I think this is a good effort. Timing is good after the v2.30.0
> release. As long as this doesn't conflict drastically with things in
> flight, I think this change should "jump the line" and merge with
> priority to avoid future conflicts.

I built this on v2.30.0 and FWIW, it merges cleanly to seen. It could of
course be that there are topics on the mailing list that Junio didn't
pick up during the rc period so that there are conflicts just waiting to
happen.

> Oh, and I remembered the one semi-legitimate case to try for exact
> renames whenever possible: "git log --follow" will download fewer
> blobs in a blobless partial clone (--filter=3Dblob:none). Of course,
> this only works if the rule is always followed and is not really a
> justification for doubling the number of your patches.

Ok, I see. Well, if you and/or others feel we should aim for a 100%
rename, I don't mind splitting the patches. My gut reaction is along
your "only works if the rule is always followed", plus I wonder if there
are actually Git developers using a blobless partial clone of git.git
[other than for testing blobless partial clones].


Martin
