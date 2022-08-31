Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21BECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiHaTir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiHaTip (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:38:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75F0E9261
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:38:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy31so30040290ejc.6
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=lmiN0rWQiusdoQBVWnTIWD342tLwzkvW9JIdh4zcN2I=;
        b=T3uwTEepeL40lzPTn+MXATbZfmB1NyZolyV0iejG8wV2s25JmJAHClJyZFksyg8DTJ
         Frrz0/zVOaev0yn/k/VG1I0v7NFzqubifZRvfzjNj7sxTUSa4Ve70exFwj7h3rgRWYSN
         BblJYFAcpQkzXLG2upJ8CwhVcoK+QXoRiZYVrKQdjJtvqw3KMyBrteTyceKc2BDiLKTK
         E81sp2e/hihM7O+4PnURRVPIdmdt4XaXUTW4yOVtszqSFeHzj4xlKhdqHNLP/pMQAwme
         h4FE+Z5/y1FW3Fkxkew5Gdp0ijywCgQZMAKYMdPXXBfW7YeOS1K5z7A/svS/nL9JjXLe
         cHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=lmiN0rWQiusdoQBVWnTIWD342tLwzkvW9JIdh4zcN2I=;
        b=mYa7a73VYwemQ46mG/FToAwvwEIBDCSlDvXXbZmZkLwZ8u/w130fMXDIUzOXIFoH4S
         ofwCCBSs5xmFWQ5Ayp+UGLfduuZx4IayJf+po1KWyke7GcMrD2AeM8XrrFeLE1UUW4r8
         op7szQzyK2N2pMx2cdBBX8UxviRYDeocdAhdmB+3OkxAOa4eslrFwBeCcEA+PByMRMke
         V3I2+L5snH1837pw/gOv7I809zwvU4I8Rb2aTwrOK11TK8SEwVNKU25KH0Z7PrsjvoDv
         70cAvwGWjnPBX2Pw1iDRbEo0tkPznLygOMiIUvIVYMPLNQK4gCSGImh0HuYTc48X5lUS
         LiEQ==
X-Gm-Message-State: ACgBeo0VPeQ+8ncno8ONdeBbqK9ed4wHkASO+qkfgVjrsFJkX1wDA8OZ
        eVu6r5K/Rgq6wPsQ8O3e6vU=
X-Google-Smtp-Source: AA6agR6VW/6eASTdGHX2AE6FP8oMG5XCeHhP0rzw6HDGvNMoR3sz2ny4buoD8M6oA+1ikKhyNdnmMw==
X-Received: by 2002:a17:907:6d11:b0:730:a382:d5ba with SMTP id sa17-20020a1709076d1100b00730a382d5bamr21104984ejc.371.1661974723168;
        Wed, 31 Aug 2022 12:38:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d13-20020a50fb0d000000b00445bda73fbesm76516edq.33.2022.08.31.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:38:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTTXt-000RiM-36;
        Wed, 31 Aug 2022 21:38:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
Date:   Wed, 31 Aug 2022 21:37:53 +0200
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
Message-ID: <220831.86ler48apq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Consider the following network working directory that is mounted under
> /System/Volumes/Data:
>
> /network/working/directory
>
> The git working directory path is:
>
> /System/Volumes/Data/network/working/directory
>
> The paths reported by FSEvents always start with /network. fsmonitor
> expects paths to be under the working directory; therefore it
> fails to match /network/... and ignores the change.
>
> Change things such that if fsmonitor.allowRemote is true that the
> paths reported via FSEevents are normalized to the real path.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  compat/fsmonitor/fsm-listen-darwin.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index 8e208e8289e..2ed828649ff 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -26,6 +26,7 @@
>  #include "fsmonitor.h"
>  #include "fsm-listen.h"
>  #include "fsmonitor--daemon.h"
> +#include "fsmonitor-settings.h"
>  
>  struct fsm_listen_data
>  {
> @@ -183,7 +184,6 @@ static void my_add_path(struct fsmonitor_batch *batch, const char *path)
>  	free(composed);
>  }
>  
> -

Stray whitespace change, any one isn't much, but they add up (I saw
another one earlier in this topic).

>  static void fsevent_callback(ConstFSEventStreamRef streamRef,
>  			     void *ctx,
>  			     size_t num_of_events,
> @@ -209,7 +209,12 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
>  		/*
>  		 * On Mac, we receive an array of absolute paths.
>  		 */
> -		path_k = paths[k];
> +		if (fsm_settings__get_allow_remote(the_repository) > 0) {
> +			strbuf_reset(&tmp);
> +			strbuf_realpath_forgiving(&tmp, paths[k], 0);
> +			path_k = tmp.buf;
> +		} else
> +			path_k = paths[k];

Style: This else should have braces if any if/else arm does, see
CodingGuidelines.

> [...]
> @@ -313,7 +319,6 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
>  
>  		case IS_WORKDIR_PATH:
>  			/* try to queue normal pathnames */
> -

More stray whitespace
