Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2E7EED620
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjIOSlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjIOSlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:41:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90E2D6A
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:39:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81a47e12b5so2231324276.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694803169; x=1695407969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meyR8TNZJBlMbUvCkHnXC8VpG1RNhFD76+VBLOCacRI=;
        b=zkstPD/CD2l6v3wAqEqGNkgLvAXyCk7iBT/0bBnROPji3Xg3pmiEhWJMRY5Q9OFSLf
         DkC0OXHCjN9NpA651nRLe0D+hiijWhX8ffuXkx7UqMDBshjBkl6fGUzhK+GMdnRgXDyi
         HJeIk92FZo6XRnOSeaNbsL1totG+SlnRpylhzgvpLShY+puURqMuN4dmKJaI6Y8rmkAs
         mSG7bKgVpcPHzT4pT1yp8lMsEOIz+CTJJNDCHRFp1Y2m+d50wIIsglteySjXocV//UQX
         PAv69F6HiQoDjKKzze2LqrOaR44H+sl4OdMZDCqAJZ//bQCu9mE4foxo4XxJwtPcD4SQ
         JOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803169; x=1695407969;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meyR8TNZJBlMbUvCkHnXC8VpG1RNhFD76+VBLOCacRI=;
        b=AQeGuVL2ur3sONDKEmI48F35yPcub07EJ/ePii+lbSw6e0hPqkoK5J1lDEZ9WH409C
         rWG7/5HhId8NQAC55AOttdZ5OYOkef73cq5LMwIHjk5zzFYDy+gnsBScBqK6DzOQPjIc
         gga6wBVmbGnffGjnGiROPIrL5VwAb36hZO0ggFUhmj+f+Bbpuqo7RW08yqJOJilKiBY+
         wYexP7XVJmVxZnOpXkAmu1qbr5X2nQ5jFgj/DNzj35pj6KhH/5Q7uIP+1mQBjYBH0vT3
         PxqIoGH1RXsG5V+YikEifnrj0qxMa4Jf9s6U4gTa0I/DqvrNCobZhVx6PWSHIV09ggP2
         oqxQ==
X-Gm-Message-State: AOJu0YyRBZS4k/Vz9aLqtDiRwseIszI6/EhfyBiY1t09eoka+rhjCIzC
        xwAstBI5EaLPgj1ZBY7sCmOmRJb02dmgU0Fu/QoW
X-Google-Smtp-Source: AGHT+IG688OBA23zLLGKpApiofE9oC0BzpJ5AUMnHhFj0Ux0y2Nlws/yFGXL3hXLrE4OwZ9+r1KmCC7dQA+DJkQOLedF
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:841e:7bbe:cbee:5eda])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e045:0:b0:d7f:2cb6:7d88 with
 SMTP id x66-20020a25e045000000b00d7f2cb67d88mr58669ybg.13.1694803169747; Fri,
 15 Sep 2023 11:39:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:39:27 -0700
In-Reply-To: <20230908174443.1027716-5-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915183927.1597414-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 5/6] git-std-lib: introduce git standard library
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> diff --git a/Makefile b/Makefile
> index 9226c719a0..0a2d1ae3cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -669,6 +669,7 @@ FUZZ_PROGRAMS =
>  GIT_OBJS =
>  LIB_OBJS =
>  SCALAR_OBJS =
> +STUB_OBJS =
>  OBJECTS =
>  OTHER_PROGRAMS =
>  PROGRAM_OBJS =

I don't think stubs should be compiled into git-std-lib.a - I would
expect a consumer of this library to be able to specify their own
implementations if needed (e.g. their own trace2).

> @@ -956,6 +957,7 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
>  
>  LIB_H = $(FOUND_H_SOURCES)
>  
> +ifndef GIT_STD_LIB
>  LIB_OBJS += abspath.o
>  LIB_OBJS += add-interactive.o
>  LIB_OBJS += add-patch.o
> @@ -1196,6 +1198,27 @@ LIB_OBJS += write-or-die.o
>  LIB_OBJS += ws.o
>  LIB_OBJS += wt-status.o
>  LIB_OBJS += xdiff-interface.o
> +else ifdef GIT_STD_LIB
> +LIB_OBJS += abspath.o
> +LIB_OBJS += ctype.o
> +LIB_OBJS += date.o
> +LIB_OBJS += hex-ll.o
> +LIB_OBJS += parse.o
> +LIB_OBJS += strbuf.o
> +LIB_OBJS += usage.o
> +LIB_OBJS += utf8.o
> +LIB_OBJS += wrapper.o

This means that LIB_OBJS (in this patch, used both by git-std-lib and
as part of compiling the regular Git binary) can differ based on the
GIT_STD_LIB variable. It does seem that we cannot avoid GIT_STD_LIB
for now, because the git-std-lib can only be compiled without GETTEXT
(so we need a variable to make sure that none of these .o files are
compiled with GETTEXT), but we should still minimize the changes between
compiling with GIT_STD_LIB and without it, at least to minimize future
work. Could we have two separate lists? So, leave LIB_OBJS alone and
make a new STD_LIB_OBJS.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3e7a59b5ff..14bf71c530 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -455,8 +455,8 @@ static inline int noop_core_config(const char *var UNUSED,
>  #define platform_core_config noop_core_config
>  #endif
>  
> +#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
>  int lstat_cache_aware_rmdir(const char *path);
> -#if !defined(__MINGW32__) && !defined(_MSC_VER)
>  #define rmdir lstat_cache_aware_rmdir
>  #endif

I think we still want to keep the idea of "the code should still be good
even if we have no use for git-std-lib" as much as possible, so could we
stub lstat_cache_aware_rmdir() instead? We could have a new git-compat-
util-stub.c (or whatever we want to call it).

> @@ -966,9 +966,11 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
>  #endif
>  
>  #ifdef NO_PTHREADS
> +#ifdef GIT_STD_LIB
>  #define atexit git_atexit
>  int git_atexit(void (*handler)(void));
>  #endif
> +#endif
>  
>  static inline size_t st_add(size_t a, size_t b)
>  {

Same for git_atexit().

> @@ -1462,14 +1464,17 @@ static inline int is_missing_file_error(int errno_)
>  	return (errno_ == ENOENT || errno_ == ENOTDIR);
>  }
>  
> +#ifndef GIT_STD_LIB
>  int cmd_main(int, const char **);
>  
>  /*
>   * Intercept all calls to exit() and route them to trace2 to
>   * optionally emit a message before calling the real exit().
>   */
> +
>  int common_exit(const char *file, int line, int code);
>  #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
> +#endif
>  
>  /*
>   * You can mark a stack variable with UNLEAK(var) to avoid it being

And for common_exit().

As for cmd_main(), that seems to be a convenience so that we can link
common_main.o with various other files (e.g. http-backend.c). I think
the right thing to do is to define a new cmd-main.h that declares only
cmd_main(), and then have only the files that need it (common_main.c and
all the files that define cmd_main()) include it. This cleanup patch can
be done before this patch. I think this is a good change that we would
want even without libification.
 
