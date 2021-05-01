Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC115C43460
	for <git@archiver.kernel.org>; Sat,  1 May 2021 08:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE46C61420
	for <git@archiver.kernel.org>; Sat,  1 May 2021 08:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhEAIwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAIwt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 04:52:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB968C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 01:51:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b25so657639eju.5
        for <git@vger.kernel.org>; Sat, 01 May 2021 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Gh/L502WNCCSM7IdVLEy4fXtw9NL7NNKZFuVkICmiNg=;
        b=qevzAgeIJwCzOAAX0VOns8LywQfTmiX83k5bKLs9UaEUnS6zevPf7+bxrqHaOzbdTF
         o97651OKJv9kYAJPXYz/NA232Oh3kfVPtY6uI2TdEdZ5FwUSpNPPbWm8NJLqSwvbmPzh
         zq93mk9Phly9aQeVRNGP0yVmWEZdXIhNyTlyw5V2WhOsv78mtn6njYAPxDQOKbDJL9GD
         EuVBnASb4U7PPqcvFeyAqwSoOn+L3Y8R6MnMac+0TSGQeTmyXAXf/VoIisgxcdaNo9F3
         qEa15leRAu95X7oQxDu1FDPI2UbFEtvQRt7VcLE1GH/5lGWp90dvbPJiGoH8A74N71cZ
         mjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Gh/L502WNCCSM7IdVLEy4fXtw9NL7NNKZFuVkICmiNg=;
        b=XVfFOXl/VYIDoFpxMU04PRHMgi6+cfDEHXNSjLZTJD2jAPH6GfVhcAUT5ZYi4dJfO8
         KfVsj635RkTDGc9gobzS0l5hXIIzJ/NDj0GbS1Oao98P2zDvZg82xXDWpI/Z29QyiSXB
         EQvQUEFvU8t8or8o2z3rua94Wy7qQ2E61WJeCatkFWuHHOpBQDCGomOU8PZQldXpB4Hh
         KKLH5d0PszwJL4M4a86UOK4qRYlqfTXJzecaUInkeFDBGRTT7ZsXED7VerHxeuUp5hsa
         dnESVQ6kdriElbKMrzipx00T7e8vbAktgq0gFVY2qkAKJ47nRD0VrmfWkRJilGYN8ZHA
         Lg+A==
X-Gm-Message-State: AOAM531C7Ihij9OPIcxKpr3jh7cA96td5s9bFBPAXjKJpuV+fppTLSoW
        ffjJfEKLFIjJvybhO1QRhPeipncVI8A=
X-Google-Smtp-Source: ABdhPJzWz64/r4WEnw1VhV3npQQCVrKVAtpUVeOvzMBsqcqCYS2pVsPAcmxm8v0h2yj62xephEJlsA==
X-Received: by 2002:a17:907:2663:: with SMTP id ci3mr8178914ejc.540.1619859117120;
        Sat, 01 May 2021 01:51:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i19sm4620560ejd.114.2021.05.01.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:51:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
Date:   Sat, 01 May 2021 10:44:12 +0200
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
Message-ID: <87fsz6ygyc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 30 2021, Derrick Stolee via GitGitGadget wrote:

Just nits on the patch, will reply to the idea in another message:

> [...]
> +test_expect_success 'enable username:password urls' '
> +	git config --global core.allowUsernamePasswordUrls true
> +'

Hrm, --global? In any case isn't it also better here to tweak this for
specific tests?

>  test_expect_success 'push status output scrubs password' '
>  	cd "$ROOT_PATH/test_repo_clone" &&
> +	git config core.allowUsernamePasswordUrls true &&
>  	git push --porcelain \
>  		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
>  		+HEAD:scrub >status &&
> @@ -469,9 +470,11 @@ test_expect_success 'push status output scrubs password' '

Use test_config instead, unless this is really "setup for the rest of
the tests" in disguise, but IMO even more of a reason to use test_config
for each one.

>  test_expect_success 'clone/fetch scrubs password from reflogs' '
>  	cd "$ROOT_PATH" &&
> -	git clone "$HTTPD_URL_USER_PASS/smart/test_repo.git" \
> +	git -c core.allowUsernamePasswordUrls=true clone \
> +		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
>  		reflog-test &&
>  	cd reflog-test &&
> +	git config core.allowUsernamePasswordUrls true &&

Ditto. Although redundant in your patch, no, since we've set it to true
above?

> +test_expect_success 'clone fails when using username:password' '
> +	test_must_fail git clone https://username:password@bogus.url 2>err &&
> +	test_i18ngrep "attempted to parse a URL with a plain-text username and password" err
> +'
> +

Just use grep, not test_i18ngrep. GETTEXT_POISON is gone.

>  test_expect_success 'clone from hooks' '
>  
>  	test_create_repo r0 &&
> diff --git a/urlmatch.c b/urlmatch.c
> index 33a2ccd306b6..e81ec9e1fc0b 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "urlmatch.h"
> +#include "config.h"
>  
>  #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>  #define URL_DIGIT "0123456789"
> @@ -106,6 +107,18 @@ static int match_host(const struct url_info *url_info,
>  	return (!url_len && !pat_len);
>  }
>  
> +static void die_if_username_password_not_allowed(void)
> +{
> +	int opt_in = 0;
> +	if (!git_config_get_bool("core.allowusernamepasswordurls", &opt_in) &&
> +	    opt_in)
> +		return;

API use nit: You need to either initialize "opt_in = 0" or check the
git_config_get_bool() return value. Doing both isn't strictly
needed. I.e. either of these would work:

    int opt_in = 0;
    git_config_get_bool(..., &opt_in);
    if (opt_in) ...;

Or:

    int opt_in;
    if (!git_config_get_bool(..., &opt_in) && opt_in)

No?
