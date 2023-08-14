Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F751C001DB
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 22:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjHNW0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjHNW0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 18:26:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31766E52
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:26:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6b66b41232so1418425276.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692052003; x=1692656803;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aERsE1PPu2UW7AWpHurv7qGfiWqHaDwrOuRBq1YXUSI=;
        b=JeAUggB5Ld4uSYWwwLYFrbXN1Y0D470LGmX+q8ZPxD9CxHrfammaY5OXBbapyxSwR9
         wa9Wu9XP0VnvWjydPt/93+snKfRIar1fhEGVAO+jpmWB27cnxUzs7ehIOxfmca9669k0
         j+luaKvPoudEuqP2qY+QcLnrebiXcBn9l19xss428EM7JSwHrReK5KhS+9YKJe+TU5fl
         OEeK7xEaZ9ZtnkT7xFBszKP6o2yhC5y1zay5+W/qjrEiUOtAYiMeks4B0lgqfSf//e0L
         jpgkW29tXV9d+9fOakvv67HJKU0UCxzxA7oNzjhfyMLPpmDTh+Eu0h+9h3w2sQJbDSNR
         Waag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052003; x=1692656803;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aERsE1PPu2UW7AWpHurv7qGfiWqHaDwrOuRBq1YXUSI=;
        b=FsWGDC/nmELVJzRYI6HDx3wTP8LpSVu9bThlYWKmHY6NS4UUIseo5vrpQWTQSLlwoR
         qUHvSLq2auHtNNB3PT2sIqK8IGCfx65oRAwXExFy71MtVDsAVuQYxZYKCxeI1jveYsCw
         sGvjoT6Rb0Dve7ygHjPMXxAG0A7j6tXjQjKTiWaZBJ3ZIpnROdOpENUk7lc8f0IlsCgu
         60hOZPRlskyzpDmrvllt/ZOma1fyL0bGcyYbki/fCCulBq9RUe4fwuYfXa4F4HDVSz/Y
         6FbPHC5f6DT2ATYIJfJoDK2W2lYR9BMwh2XL638bMpUqLSVtKaM9MnBF9RmsSYRXHIA9
         sDQw==
X-Gm-Message-State: AOJu0Yy6jxzhDxlRjoqz5raVi+efQSv4RHWbAyUuYczcW3Ubj1D7jbXl
        aS2uXSwLbjR2Ak0A26OxnZgRL/WDndDr2HjMqmgO
X-Google-Smtp-Source: AGHT+IEld4i/2+S3KH9AAoNGPOdDDyp54gcq0j4LcrWmELcjnm4AHwt2AY+BoZQEN7D3DrHGQWyAK9qmuV38b/4mU6ag
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:51f6:bcfb:aa2f:af1f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b190:0:b0:d06:cbd:1f3e with SMTP
 id h16-20020a25b190000000b00d060cbd1f3emr135901ybj.3.1692052003512; Mon, 14
 Aug 2023 15:26:43 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:26:41 -0700
In-Reply-To: <20230810163654.275023-6-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230814222641.64695-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 6/7] git-std-lib: introduce git standard library
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, chooglen@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> +Rationale behind Git Standard Library
> +================

Would it be clearer to write "Rationale behind what's in and what's not
in the Git Standard Library"? Or maybe that is too much of a mouthful.

> +Files inside of Git Standard Library
> +================
> +
> +The initial set of files in git-std-lib.a are:
> +abspath.c
> +ctype.c
> +date.c
> +hex-ll.c
> +parse.c
> +strbuf.c
> +usage.c
> +utf8.c
> +wrapper.c
> +stubs/repository.c
> +stubs/trace2.c
> +relevant compat/ files

I noticed that an earlier version did not have the "stubs" lines and
this version does, but could not find a comment about why these were
added. For me, what would make sense is to remove the "stubs" lines,
and then say "When these files are compiled together with the following
files (or user-provided files that provide the same functions), they
form a complete library", and then list the stubs after.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 481dac22b0..75aa9b263e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -396,8 +396,8 @@ static inline int noop_core_config(const char *var UNUSED,
>  #define platform_core_config noop_core_config
>  #endif
>  
> +#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
>  int lstat_cache_aware_rmdir(const char *path);
> -#if !defined(__MINGW32__) && !defined(_MSC_VER)
>  #define rmdir lstat_cache_aware_rmdir
>  #endif

(and other changes that use defined(GIT_STD_LIB))

One alternative is to add stubs for lstat_cache_aware_rmdir that call
the "real" rmdir, but I guess that would be unnecessarily confusing.
Also, it would be strange if a user included a header file that
redefined a standard library function, so I guess we do need such a
"defined()" guard.
