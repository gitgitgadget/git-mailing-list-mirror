Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A44EEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 21:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjF1VV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjF1VVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 17:21:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832647280
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:15:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40079620a83so111901cf.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687986951; x=1690578951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy/uRTp3Qu+1mV03PZtyqFpexndnHoWfirOvyXuCm2c=;
        b=UXheGtxS9rqn+Pp8M0/Prpa3j3FIlGrqFp7uRWYnzjpB+UeRubv6V6QarWxd5P8zkO
         D3v+6wDpV7t1BiS5NGie98dUVL+qpiy4pMf5xFREXZ2SKcVZ5CRGK6+Q/xKiW/rPwobP
         oOjyTs4ryTljsXJV46x/fCrOPUkVldKeMpnASv4LvXjAKvXU+kDlSdB8qTrA1t83CtVd
         aoYwq/wJSsO8ozp5cGOjrp7bmJk7R3LEBNsc2j3cDje9WokwsShERsS6N3KBgLQJVbNn
         ysj88/qB9hRfW9xXEubwmn0lPEmBzk8gjutPVLgtMJ2HxEk/87JFVW+vo2NuU5pVVAPX
         pvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687986951; x=1690578951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy/uRTp3Qu+1mV03PZtyqFpexndnHoWfirOvyXuCm2c=;
        b=XQ+wco7UTgV1QFgqGzp3njrRtq6047FfEbee+AlvKJ4yhEIjogSKNrDNDTPkwBrmVR
         arOVtDoV07mRtx1mFxKQD27HsuRjWV/MHiWIUyVUrYZFDFW1WLSnEK5Eh9QYm8wgDlVL
         uuYlDvLvQ7n5iQugjx/4eJgV0FsHTVh9Vf19kNMhGwXIDefGXvzES/wVbbqv5AIOEZXj
         R29z/EybSy5ffW6ddUKlXHTIzy0Gl16sRxbKpxWV6QLJrZSR/iIp4tJhfjXb4LDMgsu8
         LgNE3TZ7gGthTil3TuQw0BJiH1AA1WTL4THYydRtIstN6une+c8Ioz85c/tSEr+wwm71
         g8cg==
X-Gm-Message-State: AC+VfDwxBex/5w0WvEzgsIkly3DryWDhE2ZNIlIebuIL6ZZPueFmJ/Yo
        Sy05CFwbOl6OnPPfzPV7s5qk1bUme4Xczt9IXEOw0g==
X-Google-Smtp-Source: ACHHUZ6y3xZn81XffoJIR8z/NNBIEX1NTgxl2xTdpWavCfzFemykTORzNF81c81zAymWlGVsnasu8uh603Jby0mRe7I=
X-Received: by 2002:ac8:7f4e:0:b0:3f8:1f30:a1f2 with SMTP id
 g14-20020ac87f4e000000b003f81f30a1f2mr396204qtk.26.1687986950895; Wed, 28 Jun
 2023 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-8-calvinwan@google.com> <d77f99df-f50a-39fa-a7c5-1bb958f196fb@gmail.com>
In-Reply-To: <d77f99df-f50a-39fa-a7c5-1bb958f196fb@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 28 Jun 2023 14:15:38 -0700
Message-ID: <CAFySSZBMng9nEdCkuT5+fc6rfFgaFfU2E0NP3=jUQC1yRcUE6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] git-std-lib: introduce git standard library
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 27/06/2023 20:52, Calvin Wan wrote:
> > The Git Standard Library intends to serve as the foundational library
> > and root dependency that other libraries in Git will be built off of.
> > That is to say, suppose we have libraries X and Y; a user that wants to
> > use X and Y would need to include X, Y, and this Git Standard Library.
>
> I think having a library of commonly used functions and structures is a
> good idea. While I appreciate that we don't want to include everything
> I'm surprised to see it does not include things like "hashmap.c" and
> "string-list.c" that will be required by the config library as well as
> other code in "libgit.a". I don't think we want "libgitconfig.a" and
> "libgit.a" to both contain a copy of "hashmap.o" and "string-list.o"

I chose not to include hashmap and string-list in git-std-lib.a in the
first pass since they can exist as libraries built on top of
git-std-lib.a. There is no harm starting off with more libraries than
fewer besides having something like the config library be dependent on
lib-hashmap.a, lib-string-list.a, and git-std-lib.a rather than only
git-std-lib.a. They can always be added into git-std-lib.a in the
future. That being said, I do find it extremely unlikely that someone
would want to swap out the implementation for hashmap or string-list
so it is also very reasonable to include them into git-std-lib.a

>
> > diff --git a/Makefile b/Makefile
> > index e9ad9f9ef1..255bd10b82 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2162,6 +2162,11 @@ ifdef FSMONITOR_OS_SETTINGS
> >       COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
> >   endif
> >
> > +ifdef GIT_STD_LIB
> > +     BASIC_CFLAGS += -DGIT_STD_LIB
> > +     BASIC_CFLAGS += -DNO_GETTEXT
>
> I can see other projects may want to build git-std-lib without gettext
> support but if we're going to use git-std-lib within git it needs to be
> able to be built with that support. The same goes for the trace
> functions that you are redefining in usage.h

Taking a closer look at gettext.[ch], I believe I can also include it
into git-std-lib.a with a couple of minor changes. I'm currently
thinking about how the trace functions should interact with
git-std-lib.a since Victoria had similar comments on patch 1. I'll
reply to that thread when I come up with an answer.

>
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 481dac22b0..75aa9b263e 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -396,8 +396,8 @@ static inline int noop_core_config(const char *var UNUSED,
> >   #define platform_core_config noop_core_config
> >   #endif
> >
> > +#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
> >   int lstat_cache_aware_rmdir(const char *path);
> > -#if !defined(__MINGW32__) && !defined(_MSC_VER)
> >   #define rmdir lstat_cache_aware_rmdir
> >   #endif
>
> I'm not sure why the existing condition is being moved here

Ah I see that this changes behavior for callers of
lstat_cache_aware_rmdir if those conditions aren't satisfied. I
should've added an extra #if for GIT_STD_LIB instead of adding it to
the end of the current check and moving it. Thanks for spotting this.
