Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF5C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 11:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiHKLUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiHKLUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 07:20:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE392C71
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:20:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so22557172edc.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=DINnke3cN6iG2g5aXAh3m0fwLnEi9UJxLHSJwRl/mX0=;
        b=A4ee21jXgkCq9AVCP8EfMQIWLy3DGycfSNKAx5ZBS4yhNF9t3l23J/Gn8vshyXGc56
         yjFT44wXeOjeGtjD8X0E7gjsFuK2LstVMsipgsyct/5qwz4A7VIGTM9WKmy/npawVcA/
         j/3Opm17rK8wxp7d7UCVui2WMVg9+5+AhawXKn2UgTP6PGp+oqY0E670ei9Em9vKnQmX
         /BWvJllE6XA0ju38NQhXi87rrWGKfitwMeh3NFV8zC2smpa3cKGhwX8WBMdFCUx1g4lJ
         DyfBZDuAH7a1NA4mabz/bpOvCIMsIt8rGN1a2KMA5ECBeIjZrW4HqSu/DS1W5GG/44J+
         JYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DINnke3cN6iG2g5aXAh3m0fwLnEi9UJxLHSJwRl/mX0=;
        b=Lw7ro2JKbj9X/gT7fd6brU/2yX8BkqX8x1wrD/WUFIp3plxSn6KbXRDYO+h+FQsiOS
         u7yVuonj5/XUy1RjgJBRiANF/n2/iRvtJBG6anyL06qWFGH39i75lEwdyGM74TRXiUyS
         EwpheNVDu6eLqQULs5H56E+hagH2BvDmB/jtkEfw+EH9+CfTv8C6Jq3asVCtv+FiMXgm
         Ruqpe0df3tJRp6/X8NwWeTbueISlFhmT+L//2sAr3oJknE6MxClj6fcUke7A49r801P7
         I6f/2MpwHepdGCcnljX44G9JW+6MuKXU+/ZGh3J2iSP9QnbC/2yfu2zVmDRtiiUH+Tf/
         09wg==
X-Gm-Message-State: ACgBeo3mPVeKrSKYOusPXdiDNAT58fvRJfaCX4eL+TG7iOPn1ZHGjE3N
        IndJgWqR69g63MPurHdWx64=
X-Google-Smtp-Source: AA6agR4bVkXmZtku7MZFaC5zO1SD+vibyuRhcLNrYvOBPENB4u+Dj/q+zgKxcxl54hnYxEF7lH9OlQ==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id p8-20020a056402500800b00440941a93c3mr18772665eda.47.1660216835410;
        Thu, 11 Aug 2022 04:20:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s25-20020a1709066c9900b00734bfab4d59sm119867ejr.170.2022.08.11.04.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:20:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM6Es-001BX9-0L;
        Thu, 11 Aug 2022 13:20:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] cmake: align CTest definition with Git's CI runs
Date:   Thu, 11 Aug 2022 13:18:58 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com>
Message-ID: <220811.861qtnqb5p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 10 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In Git's CI runs, the Windows tests are run with `--no-bin-wrappers` and
> `--no-chain-lint`, mainly to win back some time caused by the serious
> performance penalty paid for the tests relying so heavily on POSIX shell
> scripting, which only works by using a POSIX emulation layer.
>
> Let's do the same when running the tests, say, in Visual Studio.
>
> While at it, enable the command trace via `-x` and verbose output via
> `-v`, otherwise it would be near impossible to diagnose any problems.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 1b23f2440d8..4aee1e24342 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>  #test
>  foreach(tsh ${test_scipts})
>  	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh}
> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>  endforeach()

Is this authored before a561962479c (cmake: fix CMakeLists.txt on Linux,
2022-05-24) was merged?

The "say, in Visual Studio" seems to elide that we'll now run these
tests differently when you run with cmake everywhere.

It seems much better to pass some "test arguments" to cmake itself,
which we'd then call from the ci specifically. Then e.g. a Linux user of
cmake wouldn't wonder why the "make test" spots e.g. a chain-lint issue
that the cmake testing would hide.
