Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00604C43217
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 23:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKYXuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 18:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKYXtx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 18:49:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1910642D
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 15:49:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f7so8215017edc.6
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vk3hOU6O0WyWiZWJafM03lw4BpmSXY5dzwO9WDnz2gc=;
        b=gGdot0VUtEeG+TdlI5T/g2KeZRWWm11RXT/Jh7xohHTE83VMRdybt6QvfLJHEWj40H
         yQRBaus+RxUGUSW3PhJ5xhkN9vD3llzGBFqPgI1DPbobT04YJPiAZlZcPAvI72nvfxW9
         c+CDeLKzL/188XZtnUBPk3e/GIuNq2fY9FvNaHzqdIj+fH9e2S6ddRPk5S+FX+ypxNp0
         JbYBi00L2lMQEwx2hCHrjYnHOVbUmZFdLEnorr/ho06NI3l40I1ALSw5ErRploJMObOU
         Pkqpx/Qq8OrQZfRpI/8TTbai1ZFq3KkdC7BPPAsdgMVQf+UWGAVg+ujmcLnTc4INKov+
         YzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk3hOU6O0WyWiZWJafM03lw4BpmSXY5dzwO9WDnz2gc=;
        b=pLKc9WA5o4ZJMG31qSPGa8weJj0uMMk9ez7yO6G3HZs2SIONmZRtfcRKbMRGbkXQyw
         3/ai1gd+8gtE3uPh9nI1XdiV8+yAiZN7uuZ96xv3kpD5ZKSM3r4NX4KJJKMqffw+u5iH
         mkEuwe2Aiq2pWZrQQxGw4FHzS4FTRZW3OqVsGJbfRBaPaSNsV3P4CwstYHTHKxUTBieK
         Joysobs/Gqf+69qLEOAX9ICOrlySGJQbAcNgUZghUS9LvJp2rV/0bLmb1PcxN/tZ5D+1
         akoopwa5JM6FJAdzoHhx0klRGh3ivTQQ1jK/U74Im2Puhl3/iap+XB653GrS9vfZP6+5
         lL2A==
X-Gm-Message-State: ANoB5plT4KcQuo1lGlc0UaxZ+JT7GifpIh5TDoBtcOTapIOQSL/XMRTB
        qdvc2zFFWMxYPw/9LXTCbC6JUS7oBP+Q2ho2
X-Google-Smtp-Source: AA0mqf4XV06lf7FVuMUL89hCKPs3PSE6ilr8ZKVRj2HTpwix+CAxo/O0gcuLwTuf1uRwNQ3LpYCNOw==
X-Received: by 2002:a05:6402:1772:b0:46a:7f4d:efe5 with SMTP id da18-20020a056402177200b0046a7f4defe5mr10704457edb.304.1669420139143;
        Fri, 25 Nov 2022 15:48:59 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7da11000000b0046aba24985esm1255723eds.91.2022.11.25.15.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 15:48:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyiRG-000dPb-0p;
        Sat, 26 Nov 2022 00:48:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util.h: Fix build without threads
Date:   Sat, 26 Nov 2022 00:47:27 +0100
References: <20221125092339.29433-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221125092339.29433-1-bagasdotme@gmail.com>
Message-ID: <221126.86lenymw7p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 25 2022, Bagas Sanjaya wrote:

> From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>
> Git build with toolchains without threads support is broken (as reported
> by Buildroot autobuilder [1]) since version 2.29.0, which traces back to

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1470,7 +1470,8 @@ int open_nofollow(const char *path, int flags);
>  # define SHELL_PATH "/bin/sh"
>  #endif
>  
> -#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
> +
> +#if !defined(_POSIX_THREAD_SAFE_FUNCTIONS) && defined(NO_FLOCKFILE)

Per f43cce23add (git-compat-util: add fallbacks for unlocked stdio,
2015-04-16) wouldn't it make more sense to do something like:

#ifdef NO_FLOCKFILE
#undef _POSIX_THREAD_SAFE_FUNCTIONS
#endif

Or the other way around here? I.e. have _POSIX_THREAD_SAFE_FUNCTIONS
define/undefine NO_FLOCKFILE?
