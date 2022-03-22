Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F4C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 08:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiCVIwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiCVIwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 04:52:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFC79384
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 01:51:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u26so5220469eda.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3lEn+Vrsx+CVlUcZ0ruelLnPU8RKyW730Nk2ZfaNyeE=;
        b=Kl4SScw8oyuWdLUZAtSvhf5MgU4z0AY+w5Ll3ilz1of0xhHvwXf8hPmZPM5EDxCIvC
         eGZRLVD++MwuxY8IFJQS3UKmMR16Ri6bmJO56Mgww92MxaJ0FL7jf4sfxl5TYh9v7hzb
         SRVU8zHv36fkcRUswcsYiPKBIDxnaemK6EMthCZu0qPcn/So9ZFn6yjJTGWise4x1jWP
         +YChUq4Tr0hC//9WR/GV8o/f8gzzV8Yl3t2dewyzdozureh2vlyRnKd95s4R0AJ5AXNw
         otIMKGmQWoLjc1McOA6TicZ63b+rn2cdytjA1CDrsW21ex9HP86m4ccgQ/zrTBL89ILP
         7BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3lEn+Vrsx+CVlUcZ0ruelLnPU8RKyW730Nk2ZfaNyeE=;
        b=BbtOfvt5VrPzVfnq8VmcM6zftFTT2VCGJ9L4JIUBAUafRPI2KBrIt5IcE7SwWoKDU3
         9Q4w6xkhqg7YWwDri4NH6+CrnU5U1o/0sInOcsAyL58H0p+3LKkEWcCZA8EvSt/NBoHd
         BpXU8Q87AOh8RNr3WpBpuWBbOcev+5uCNJvSrC8qwKKEGUXxfMr84B29kHj1mfrokOyT
         Un82+WsKTQVCwiSAymNq4ympYRScAlYicpzIKppn9qSePcQRHKnNxmRBz5DbGoaVcDyJ
         rqdQqSKsVVEtFn8MeoX3zfPzQPaQoj4wkFxk2vQOwlzN/VzslbmpBm1H4zUieWH3yxMm
         qnAA==
X-Gm-Message-State: AOAM532MTQFw7tp2CEkVNsJrrwiqjD6jl9fkdb+mO2acxJjJLivgqif4
        ckN40HIh8hIOpuyK8bOYn9ZWEmCa+5KdrQ==
X-Google-Smtp-Source: ABdhPJyrKb0x1bGiBWbaGBJptgzxPJWaK+CGJrTgfJ+ElgnSHCarjgYJxQuZO4ifVCGeGo0lTK0OzA==
X-Received: by 2002:a05:6402:3712:b0:416:13bf:4fc5 with SMTP id ek18-20020a056402371200b0041613bf4fc5mr27306239edb.115.1647939069620;
        Tue, 22 Mar 2022 01:51:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z1-20020a05640235c100b004192c7266f5sm3645286edc.16.2022.03.22.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:51:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWaEO-000E0J-Gl;
        Tue, 22 Mar 2022 09:51:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
 status
Date:   Tue, 22 Mar 2022 09:26:39 +0100
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <20220321225523.724509-1-gitter.spiros@gmail.com>
Message-ID: <220322.86r16unzer.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Elia Pinto wrote:

> EXIT_SUCCESS or EXIT_FAILURE are already used in some functions in git but
> not everywhere. Also in branch.c there is a returns exit(-1), ie 255, when
> exit(1) might be more appropriate.

On existing use: That's quite the overstatement :)

We use EXIT_{SUCCESS,FAILURE} only in:

 * contrib/credential/ code.
 * sh-i18n--envsubst.c
 * EXIT_FAILURE in one stray test helper

So out of "real git" that users see only sh-i18n--envsubst.c will ever
run by default, and the reason it uses these is because it's as-is
imported GNU code.

I'd think if anything we'd be better off doing this the other way
around, and always hardcoding either 0 or 1.

I'm not aware of any platform where EXIT_SUCCESS is non-zero, although
that's probably left open by the C standard.

For EXIT_FAILURE there *are* platforms where it's non-1, but I don't
know if we're ported to any of those, e.g. on z/OS it's[1]:

    The argument status can have a value from 0 to 255 inclusive or be
    one of the macros EXIT_SUCCESS or EXIT_FAILURE. The value of
    EXIT_SUCCESS is defined in stdlib.h as 0; the value of EXIT_FAILURE
    is 8.

Now, I don't know z/OS at all, but e.g. if a shellscripts calls a C
program there would $? be 1 if we hardcode 1, but 8 on EXIT_FAILURE?

We also document for some of these programs that on failure we'll return
1 specifically, not whatever EXIT_FAILURE is.

These patches also miss cases where we'll set 0 or 1 in a variable, and
then exit(ret). See e.g. builtin/rm.c. You just changed the hardcoded
exit(1), but missed where we'll return a hardcoded 0 or 1 via a
variable.

And then there's changing exit(-1) to exit(1). That's existing
non-portable use that we really should fix. But I know that you missed a
lot there, since I instrumented git.c recently to intercept those for
testing (it came up in some thread). We have a lot more than you spotted
(and some will error if mapped to 1 IIRC). Most of those also want to
exit 128, not 1.

Anyway:

All in all I think we should just double down on the hardcoding instead,
but we should fix the exit(-1) cases, and that's best done with some new
GIT_TEST_ASSERT_NO_UNPORTABLE_EXIT testing or whatever.

A lot of these codepaths are also paths we should fix, but not because
we exit(N) with a hardcoded N, but because we invoke exit(N) there at
all. See 338abb0f045 (builtins + test helpers: use return instead of
exit() in cmd_*, 2021-06-08) for how some of those should be changed.

I think we'd be much better off with something like this in
git-compat-util.h:

    #ifndef BYPASS_EXIT_SANITY
    #ifdef EXIT_SUCCESS
    #if EXIT_SUCCESS != 0
    #error "git assumes EXIT_SUCCESS is 0, not whatever yours is, please report this. Build with -DBYPASS_EXIT_SANITY to continue building at your own risk"
    #endif
    #endif
    #ifdef EXIT_FAILURE
    #if EXIT_FAILURE != 0
    #error "git assumes EXIT_FAILRE is 1, not whatever yours is, please report this. Build with -DBYPASS_EXIT_SANITY to continue building at your own risk"
    #endif
    #endif
    #endif

Or *if* we're going to pursue this a twist on that (I really don't think
this is worthwhile, just saying) where we'd re-define EXIT_SUCCESS and
EXIT_FAILURE to some sentinel values like 123 and 124.

Then run our entire test suite and roundtrip-assert that at least we
ourselves handled that properly. I.e. whenever run_command() runs and we
check for success we check 123, not 0, and a "normal failure" is 124,
not 1.

I know we'll get a *lot of* failures if we do that, so I'm not arguing
that we *should*, just that it's rather easy for you to test that and
see the resulting test suite dumpster fire.

So I don't see how a *partial conversion* is really getting us anywhere,
even if we take the pedantic C portability view of things.

All we'd have accomplished is a false sense of portability on most OS's,
as these will be 0 and 1 anyway. And on any stray odd OS's like z/OS
we'll just need to deal with e.g. both 1 and 8 for EXIT_FAILURE, since
we *will* miss a lot of cases.

1. https://www.ibm.com/docs/en/zos/2.1.0?topic=functions-exit-end-program
