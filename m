Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D47C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7975D21973
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 08:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgL3IFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 03:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3IFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 03:05:06 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B456C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 00:04:26 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id h6so8223639vsr.6
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jqrex0UUxXNXWrCNYkBcYvwRohMcm+RFoG32DyrEl54=;
        b=WlrTkVCw2pPjrpBsp5a7kw9qUm2QTg05ufVH63JuONrUSjYD0ECvEcD74ij/HQyId4
         zEQtroZqv+WsLFyWdSIkWP6k6DcOLUP1ig5XP0PB8lV8IMyC9/uBWO6maGFIZ6+tTwpP
         pR+aGIhayetCO7YIwSQ314s1foAVTkZS4DF3uNouyt3fT8x6qQLWAuKHu4HIp9Ydh6aA
         V79UurMRe16FEilEKc7RxnmFMqtK1oMfIOpfBNykkljDBmxea2Lnq8zDLnZbQEe5Tv6U
         fUiV4v8L8563GB/5PgmeQfuj/nJ4Y85IAeVZY9SwlDRiN+w6e0ZsGBBEdWwuAxMIP58w
         6upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jqrex0UUxXNXWrCNYkBcYvwRohMcm+RFoG32DyrEl54=;
        b=nRslp+xu8gfjnjG716Q/S0thH2eRQeZHN13eK0qh53AB7AjkgKJhAeW7pVtrnaZYXr
         n8jIKEDwjeqFyNP8leCPEfXK8rH1gCtIvacIIl514xE33UP87OCrCe2UOzzdpL0n82Gq
         SMhD9yAqDNRp+tEMDfBrQAJN6OfjDSG9U76SqZpHAcssgDho+MJ60Ga0s3SYslTYz2Lm
         eDiHoozYQJVfg9C8l6AIGeDM5qSfDsS2rpMzRuapgZnb53qyS/FWgT1MrCSDq8YwBvOC
         QnBB63my4xY7oQxEL594iMZcIG8MhOSU5cO8yr87skFzsrCo2plOXCW34eCHuxDB9AId
         Kddw==
X-Gm-Message-State: AOAM532K/jUYfMc1PMiGKGJ6jGxeyyM92UzcHlt+5hWV22tQYF4T65nN
        CkKaAW4bogZpQG29si2PpWZqQo8LaxEEGF6v284AaOPe
X-Google-Smtp-Source: ABdhPJz/7mDGgoC6g1/GDtpCGQ2WLPiKGuzVvSNeUoBm4+v+oOfrjbPMREHFect1zd3HyDRrVvkPkFHoqjhE6KKl0GQ=
X-Received: by 2002:a67:2d84:: with SMTP id t126mr31219520vst.49.1609315465254;
 Wed, 30 Dec 2020 00:04:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609282997.git.martin.agren@gmail.com> <X+wAahx00v9VqzV5@camp.crustytoothpaste.net>
In-Reply-To: <X+wAahx00v9VqzV5@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 Dec 2020 09:04:13 +0100
Message-ID: <CAN0heSo88-o0fgBM-_Sx6JXN4RxVX-fW84Kt-VgttytM=Qad-A@mail.gmail.com>
Subject: Re: [PATCH 0/4] rename "sha1-foo" files
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 30 Dec 2020 at 05:22, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-12-29 at 23:52:56, Martin =C3=85gren wrote:
> > We have some source files with filenames such as sha1-lookup.c and
> > sha1-name.c containing a few variable names, comments and the like
> > referencing "sha1". But they are able to handle SHA-256 as well. Here's
> > my attempt at removing "sha1" from the contents and names of these
> > files.
>
> I agree that this series looks pretty good, and thanks for sending it.
> This series ended up being a lot smaller than I expected given the work
> on the transition, which is a nice surprise and also means it's less
> likely to conflict with other topics in flight.

It's a lot smaller than I expected, too -- I looked into one file and
figured it would be littered with "sha" instances, but was pleasantly
surprised so I continued. Certainly, the only reason this series is
smaller than expected is because of all the work that has already been
put into the transition. Thank you!


Martin
