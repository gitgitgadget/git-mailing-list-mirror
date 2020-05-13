Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B954C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC050206E5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/lT6YQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbgEMTcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733166AbgEMTcu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:32:50 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225DCC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:32:50 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id b14so139596vkk.10
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYnqn0hAXTbyIW5jQ0PrJ1uwypV7mmBzaCG6MkzCGnc=;
        b=O/lT6YQb975ioeYy2agUdaymTMWtVDW2WfLmyPlbTJk/Dell0Bww4KN9zmDvroWWEu
         YH9rrskLneqZeOrKNekU8y5nqJ9ReB+nbw3ho1fFQYRFkKBSI9qodAMZH7lGxv/HAO6U
         QN4mWopCVaWlZwE05m4ZWy79evWP+fkdruRTyuwefOQAEUuimmBwumgAGhDdFo0BzBod
         SD3FCsaSqsdmCUIcqn7nM3h+RS4hyrRlr3+rfAvTkIRbOt5zaz7gWBaK1wXxqy20cnAN
         ubbR6K8wISm0vC/icBli58HhBn3xELtNANPDNKDXreRLk27R6oWklbeoiIWgmcmwSMi1
         utmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYnqn0hAXTbyIW5jQ0PrJ1uwypV7mmBzaCG6MkzCGnc=;
        b=PN6xhcbh7m7ujqR2/l06oibxPtEYK1/9KVf979EZpCQFgqx46LL6hvsOfJV4FfvOfB
         1QXkeqMj10MACMhFioH5q9XUaqTQyPVfEwXrKVD+FWibOSYR+du1+mwkEbTYWW8julVu
         v4BC1vLMjJhEVRBWNoCIFQyuZ3LgsGxNEJAaDdCrQtAlRW+4rlpbdbRxubH3rjFlOjwH
         2wqQebOudjosNd2rt9jqf617lBm/0kSn1uf60EfNTAJPxdTOx8kvArcbWByaLFfKtVDt
         Hru3gQf0/8U1KTSDZspXohfYex3f+t3Jssc/OtthdF9N5lhHLz+c7B6i0KZATtIeR/Y2
         rkNA==
X-Gm-Message-State: AOAM531LzMnQIYdW431nQXDDnPywqjEBvjCASYSQJsW9JD4fF1//khc4
        0dHRdI74V9nd0U1pCscxEDMRaaeJ6XFCJKaB+kc=
X-Google-Smtp-Source: ABdhPJyc8uTgHQzDgRyZBn2TCS+RngPJhgxvLZ0m6g+u+/Ys5+sbMnrTk3VCWFvEi09Tj1cPawxr/QbHJOYwSOpqCj8=
X-Received: by 2002:a1f:2142:: with SMTP id h63mr715813vkh.85.1589398369317;
 Wed, 13 May 2020 12:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-5-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-5-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:32:38 +0200
Message-ID: <CAN0heSqBeW86yyH6vUATX+Az=4qG0gW_QhgsbWnTKXX=Q9hiig@mail.gmail.com>
Subject: Re: [PATCH 04/44] wrapper: add function to compare strings with
 different NUL termination
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8ba576e81e..6503deb171 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -868,6 +868,8 @@ char *xgetcwd(void);
>  FILE *fopen_for_writing(const char *path);
>  FILE *fopen_or_warn(const char *path, const char *mode);
>
> +int xstrncmpz(const char *s, const char *t, size_t len);
> +
>  /*
>   * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
>   * that ptr is used twice, so don't pass e.g. ptr++.
> diff --git a/wrapper.c b/wrapper.c
> index 3a1c0e0526..15a09740e7 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -430,6 +430,18 @@ int xmkstemp(char *filename_template)
>         return fd;
>  }
>
> +/*
> + * Like strncmp, but only return zero if s is NUL-terminated and exactly len
> + * characters long.  If it is not, consider it greater than t.
> + */

I think this comment would be easier to find in the .h file.

And since I'm already commenting...

> +int xstrncmpz(const char *s, const char *t, size_t len)
> +{
> +       int res = strncmp(s, t, len);
> +       if (res)
> +               return res;
> +       return s[len] == '\0' ? 0 : 1;
> +}
> +
>  /* Adapted from libiberty's mkstemp.c. */
>
>  #undef TMP_MAX

It's not entirely obvious from the context, but this function is
inserted between some "tmp" stuff and some other "tmp" stuff. I don't
think we need to bikeshed its exact home, but maybe "close to other
string stuff", or at least not in the middle of the "tmp" section.


Martin
