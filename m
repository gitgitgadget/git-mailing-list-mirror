Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C210C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E6261041
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbhIHFyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhIHFyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:54:07 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 22:52:59 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id s15so1001054vst.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 22:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyKqXpgMfBZApTqU54TcC5dNh4ntnNRVN4FitwFesF8=;
        b=qNHYtyQ2FvaPavqvs55ynBLK8HlwnK/4WkTV5I//FmaKVbE7K7BJKtne1e5CivVQnJ
         XKdSC9H38601Mk7VEKt+ZDxlgXYyfCJL29bgHWODo5u4xENZc3Fr9xZt1k6mQ3Qq/OUL
         PkLS49RtnX+Rqo+C1ciW3ROq/ozdPjLI1bzNoLnLQ8scf4pdp2jqiscsw2PEhs7AawM4
         RMNPt8of0TntFlaxL3rZOltzFZUc8kkBs5x15qWGexWEu/8Rs6Jl/ywi2rH92Y1LSHmL
         Pip41ZT+Z68/u/yZ3GyW4oThTvAukPfKceu0APxMgUyU5mxBiYpuOaqiUyyzEX4ASE7V
         33EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyKqXpgMfBZApTqU54TcC5dNh4ntnNRVN4FitwFesF8=;
        b=J3xGRsXGioXGG4bE1QbEbwcQ+g6MAyhCjFW/78qEFPBKKDWNkrxwjL7cgKnQn5vapa
         NztwLenx28SGZd44zeRN7jzrkIfpeWzN2EUpO8IlMgqsW2y5bD/sq51+slcj5HNJ9RGW
         bbs9w/v7vlzDshrQB9SFseHGjSbBJj0nRL+RaMeW4bSUX5Lb6DdlueaGBBO2ijftaflN
         zpL7ovDA2YL6XFHyuQGy+P2K4uQkTuTXjpiQlS3RSVyjBV2PnoSk0XBd4pwt7sTqXP2c
         rFkCbwFJozuoX10u+Iqq/3t5mW3X6hnAgiodnXh571z8YeVM1kGH2hlTRsSkCxUzZ6pO
         N0oQ==
X-Gm-Message-State: AOAM531EhL3Sc6Cw2qsW1RuKnTZihBGZdZHoEQu91mbbOEr8X8rmKCFl
        JVYEFqyoIvyJrVyOpRms72w+zlkO1mXpxR+XNAiniL+mKJs=
X-Google-Smtp-Source: ABdhPJzyJyRpNFh9O82rzHnqbZX4S62kOy7l5GGDnaibqcF7ux/85aYAK4mGNlzL9qRn18rEOapuekfu1DrKg/nIWy0=
X-Received: by 2002:a67:ef48:: with SMTP id k8mr1066014vsr.57.1631080378576;
 Tue, 07 Sep 2021 22:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210908051340.13332-1-colinpcurtis826@ucla.edu> <20210908051340.13332-3-colinpcurtis826@ucla.edu>
In-Reply-To: <20210908051340.13332-3-colinpcurtis826@ucla.edu>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 7 Sep 2021 22:52:47 -0700
Message-ID: <CAPUEspiT=9F_O+9XcUDWLY-8u97eCKonvVZ8L0KYaHxDBFFSSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] add liconv link for makefile
To:     Colin Curtis <colinpcurtis@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 10:18 PM Colin Curtis <colinpcurtis@gmail.com> wrote:
>
> diff --git a/Makefile b/Makefile
> index 379cd91a97..e1679cca47 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,6 @@
>  # The default target of this Makefile is...
>  all::
> -
> +OS := $(shell uname)

There is no need for this, the section of code you modify below is
already macOS (indeed, even to the point that it won't trigger in a
Linux user using brew, or even a macOS user that has macports)
specific

>  # Define V=1 to have a more verbose compile.
>  #
>  # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
> @@ -1514,7 +1514,11 @@ ifndef NO_ICONV
>                 ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
>                         ICONV_LINK += -lintl
>                 endif
> -               EXTLIBS += $(ICONV_LINK) /usr/local/Cellar/libiconv/1.16/lib/libiconv.dylib # -liconv
> +               ifeq ($(OS),Darwin)
> +                       EXTLIBS += $(ICONV_LINK) /usr/local/Cellar/libiconv/1.16/lib/libiconv.dylib
> +               else
> +                       EXTLIBS += $(ICONV_LINK) -liconv
> +               endif

Why is it not built with the libiconv library that is provided by the system?

$ otool -L git
git:
        /System/Library/Frameworks/CoreServices.framework/Versions/A/CoreServices
(compatibility version 1.0.0, current version 1122.33.0)
        /usr/lib/libz.1.dylib (compatibility version 1.0.0, current
version 1.2.11)
        /usr/lib/libiconv.2.dylib (compatibility version 7.0.0,
current version 7.0.0)
        /usr/local/opt/gettext/lib/libintl.8.dylib (compatibility
version 11.0.0, current version 11.0.0)
        /usr/lib/libSystem.B.dylib (compatibility version 1.0.0,
current version 1292.100.5)
        /System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
(compatibility version 150.0.0, current version 1775.118.101)

AFAIK there is a good reason why brew doesn't link that automatically,
and using the headers of one with the binary of the other is likely to
cause serious problems.

Carlo
