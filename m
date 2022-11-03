Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B25C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 12:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKCMRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCMRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 08:17:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2960F3
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 05:17:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 21so2710266edv.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAS0wmamWXcOMxzxHJG+TRb4bwJI9Vds44rUYvwDqP8=;
        b=e9ui2oQ/FmTV9d5ibV+5ltC0A/fpWJY6rdM0xAjaWoAlE7NHhtwP/WPhT7eeityRp1
         5MUJxVLykLJj8NoFdN0lsRfF0BB1FVvNXhG60G8kRdcnZm4fDTo25c8CtJlaOuny2Irh
         vg0FUz67Tpz55TxGxLL38PyVcUKxdJWwrfH0xqOAwy6G0HudyiEPEZD/YeDJvrKdHxct
         c5TA8ETMzwEhI5r/gF1PpYR8m8gG3pPK/R1nvpozb+e/A8B/Zir7Xgw/NPXAhl8oPEGu
         KXrs6QOqmwDfMejDJulh35tUr2dLa2aBpW/BbmClH9IMRhrDnkFtFBDQTfQGvog75O9B
         lvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAS0wmamWXcOMxzxHJG+TRb4bwJI9Vds44rUYvwDqP8=;
        b=4xSSI7ros3zcjthEfFMy0Ii4Ntu80hV6Pyktw87klYfHHiUQE7JIIaw4RMnjOUhqLR
         2SppMVPn6l5wL0Qm2wqMzFNmmvvfitDjAF6rVr5B//jcwH0vdIOU6ooBuLdsB5Znskvb
         pUq54/oXZJB302a71gX5BO7mxj8NoIUI+y4FYzCQUM0gik6ax3wG/g8USoQbwcJ9P9KI
         D0BhCr9/QWe086A3DSKTIqhK3dX7CMMHEgN9Mq9oBOIAT+VU6diPJI7ft6lmPl6aC3LN
         lnYEs/lxP5VlUhvMd000T45+dTZEnUENOr+DzUh4i5z/kLrzf8/NICl0Z+9TJyy7ab6d
         WyKA==
X-Gm-Message-State: ACrzQf01+4Rf1XgjT6zPuY45rKpvbSUokos0/VrzBPQVBqXRj4ATAX3/
        4SyLQk8HDtR7GB+dCngV7CL6TvYriZ4=
X-Google-Smtp-Source: AMsMyM5Jftaev1yHL05P0r4ALSwAJWslPxQO3mRDoizuPrPzvxlTBN4KOXFpZQKLgOfLkqyYgbyHOw==
X-Received: by 2002:a05:6402:50cf:b0:462:352e:f4a7 with SMTP id h15-20020a05640250cf00b00462352ef4a7mr29117849edb.317.1667477824514;
        Thu, 03 Nov 2022 05:17:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b007a9a56e2a07sm431986ejr.49.2022.11.03.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:17:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqZ9b-00CQrt-1W;
        Thu, 03 Nov 2022 13:17:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     James via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James <jdm12989@gmail.com>
Subject: Re: [PATCH] documentation: update git-submodule documentation
Date:   Thu, 03 Nov 2022 13:14:38 +0100
References: <pull.1401.git.1667471194097.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1401.git.1667471194097.gitgitgadget@gmail.com>
Message-ID: <221103.86eduk1bcw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, James via GitGitGadget wrote:

> From: James <jdm12989@gmail.com>
>
> Removes reference to custom code execution which is called out by
> gitmodules as not allowed.
>
> Signed-off-by: James <jdm12989@gmail.com>
> ---
>     Update git-submodule.txt
>     
>     Remove info about custom commands being allowed in the submodule update
>     command to align with the gitmodules docs which states "For security
>     reasons, the !command form is not accepted here."
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1401%2FEnochPrime%2Fsubmodule-docs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1401/EnochPrime/submodule-docs-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1401
>
>  Documentation/git-submodule.txt | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 4d3ab6b9f92..b40ac72f753 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -163,12 +163,6 @@ checked out in the submodule.
>  The following 'update' procedures are only available via the
>  `submodule.<name>.update` configuration variable:
>  
> -	custom command;; arbitrary shell command that takes a single
> -	    argument (the sha1 of the commit recorded in the
> -	    superproject) is executed. When `submodule.<name>.update`
> -	    is set to '!command', the remainder after the exclamation mark
> -	    is the custom command.
> -
>  	none;; the submodule is not updated.
>  
>  If the submodule is not yet initialized, and you just want to use the

Hrm?
	
	diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
	index a7683d35299..80e897d5f29 100644
	--- a/builtin/submodule--helper.c
	+++ b/builtin/submodule--helper.c
	@@ -2247,6 +2247,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
	 	case SM_UPDATE_COMMAND:
	 		cp.use_shell = 1;
	 		strvec_push(&cp.args, ud->update_strategy.command);
	+		BUG("unused??");
	 		break;
	 	default:
	 		BUG("unexpected update strategy type: %d",
	
Will show you that this is used, i.e. this failure in
t7406-submodule-update.sh:
	
	[...]
	+ cd super
	+ git config submodule.submodule.update !git checkout
	+ cd super/submodule
	+ git reset --hard HEAD^
	HEAD is now at 0c90624 upstream
	+ cd super
	+ cd submodule
	+ compare_head
	+ git rev-list --max-count=1 main
	+ sha_main=0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f
	+ git rev-list --max-count=1 HEAD
	+ sha_head=0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f
	+ test 0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f = 0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f
	+ git submodule update submodule
	BUG: builtin/submodule--helper.c:2250: unused??
	Aborted

I think what you may be confused by is that this isn't allowed in the
in-tree .gitmodules file, and indeed you can see another BUG() in
determine_submodule_update_strategy() for a panic if we'd ever get as
far as reading "command" from there.

But that's not what this part of the docs dicsusses, as the paragraph
shown above the removed lines in the context notes.
