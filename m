Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16723C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13D760F23
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhIPF5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhIPF5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:57:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965AC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:56:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v24so12406843eda.3
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wsoTso4WCgA6Oc/3dUeBpAF3N1OhJjVXkfiWN45IRLc=;
        b=SSl/v0ipgfevDxacpiIesVRWS1oC78Lrgma+Vx0NPc7JXhAS8ToEO+ygHycIQj8IHm
         VrhhzhH1gR5xtRCJ2BdUlqV4ByrsFu3Hh2tTVsYFPUaT4j2jEKEnNe5P7mqx6TsOGII/
         5fJams6+RvTi2IOFRO3A4HDMcVrGLy+NlLd6eL+q1N55lJsnBGVQin5tgxB7oA3nNTmb
         mQQD7VlfcY3+FxPnyfaSgykoqLZ77UJsdcQy7sqtBB+BeouW9266FXFO37FbobmDnJIM
         55ji7vc+64fuBYmVcDNw9PBEJFeUz6HvdTbAdvjKiZlW1g0xXrBjs+y3IYiLc4HV0M2Y
         gZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wsoTso4WCgA6Oc/3dUeBpAF3N1OhJjVXkfiWN45IRLc=;
        b=jz8qSBShqqDXc45jnfqCFjGR7U2aBFW7bIuLDKC+Sfobxvwuk2v3PN6FJeBb2kCGjX
         11BlLgGW9tM/a24RnhdAn+WYuVvV1PU/osz0hFG7k3Yt9XwhPNvmUmeNZUAo+drgxXVj
         FyvzmXBrxRPdTEGAzCkRBI7SXxAJKVTzSTbRGPTBSxG1KGaovsZ4iOi7bW7HRY9kB5nZ
         woD5Ib9FLKCuWsp1/uXJKYDaLrUj7wKlTi0psGvrvPCG75t1eF6BtE7N33GkKsiNO7bL
         d19isL5Zoiru/bk7jVbFfI4mBs7CqRepKp82BWXi36FS2/DjWfoAsHa2zGOI9rmG4m4x
         nJ7w==
X-Gm-Message-State: AOAM531YtsWLFPA0HJlgo7ZvQFLBStgbiWKykblfIEuIOREX8YVJovNg
        TnS1L959/jmqRwgY6pb8lB8=
X-Google-Smtp-Source: ABdhPJzt7jM80+bzmeOvHZO7CZ6VBg1CCDRT1TRCgsn90JHCYejaFeJ8QF1LYMBQJLrSDwARA7Or+A==
X-Received: by 2002:a17:906:6c87:: with SMTP id s7mr4404638ejr.186.1631771792712;
        Wed, 15 Sep 2021 22:56:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m17sm773905ejn.108.2021.09.15.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:56:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 7/7] t/helper/simple-ipc: convert test-simple-ipc to use
 start_bg_command
Date:   Thu, 16 Sep 2021 07:55:32 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
Message-ID: <87v931gj1s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:

[...]

> +	default:
> +	case SBGR_ERROR:
> +	case SBGR_CB_ERROR:
> +		return error("daemon failed to start");
>  
> -			/*
> -			 * We don't care about the WEXITSTATUS() nor
> -			 * any of the WIF*(status) values because
> -			 * `cmd__simple_ipc()` does the `!!result`
> -			 * trick on all function return values.
> -			 *
> -			 * So it is sufficient to just report the
> -			 * early shutdown as an error.
> -			 */
> -			return error(_("daemon failed to start"));
> -		}
> +	case SBGR_TIMEOUT:
> +		return error("daemon not online yet");
>  
> -		else
> -			return error(_("waitpid is confused"));
> +	case SBGR_DIED:
> +		return error("daemon terminated");
>  	}
>  }

It's not mentioned in the commit message, but the while-we're-at-it
dropping of _() makes sense here, it shouldn't have been used in a test
helper to begin with. I.e. translators don't need to be translating
stuff purely internal to the test suite.
