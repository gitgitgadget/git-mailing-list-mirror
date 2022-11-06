Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E8C4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 00:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKFA2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 20:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFA2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 20:28:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E8EE3A
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 17:28:39 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h206so6406637iof.10
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWFDRJ2gs3LCtPnLvttaqYdtD2BAWXNYBHUxpFVPv+s=;
        b=IZBkq4G/l0vC5c9myh+jRkNdfrxLCLeN2PQ7kY8EIt3Fy5S7zIG1mDZsMpUuf1o1v5
         /hnf9Z/eKNnXW88dHDVXeYGN3w0SiqmR0VR9apaTm4zdt0vfp2VqbPj2knv4BtY+3ffa
         wqUAHjmOHjPeIP/THdte+3NkdeynRCQnTVVwB0Iw3KbHDlyBeMQ45BxBkUtwlRJUBgIQ
         dJ2XjHqffO7DgV8kU0WNUkd9MsYAl2PFuw8xKXVXzvhfZeve6qfneGiCAsULjW4u8ZyQ
         6ioXvmZb4371f1UgotLlIYX4COK6EyV6kEpafGsvOX6gphiaX8SvhOut7D2CGsc5bxE9
         MOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWFDRJ2gs3LCtPnLvttaqYdtD2BAWXNYBHUxpFVPv+s=;
        b=jHY12rtmpCVxTyThB0RT97F5t0NcEv9bZQMywiVaScy8m4P+QbBrMjhAAh0RDrrqvv
         9IX/KhAifvS66Ol3reoDxc1BAXPk4GvPDw1qE3Rj3LRnLIk5JnCJx3pszz1yCK60IqjN
         8Y61UU59LntG1fPFKgJ3WGKRjde/ViwzEZZopQRXgLaKRrJA88AV3u/GpmvRwKeII4Vb
         9JJGynGoiXp5pI33syhRCmNb3zzXg1nqI7V/yuPJet1l42n+wx6m2nciYfkao64eC5sf
         LrWm+0sXWDdm9YhaRZS6F+Z4hhOR9MGl/mAhL7Tr6sy/LhNJtqc93LRIaiaCxZix0gsR
         uX/g==
X-Gm-Message-State: ACrzQf1Sy1HvvM5WQ+3KKE4wkpIJw0NcxV1BfKxi0Wwyjf6tJeIt9mPP
        Ncfy9kCVWMKWVpLvGml5qba5iA==
X-Google-Smtp-Source: AMsMyM7vrLhzNil6smJggHK+kcBwOL3XU4zC7EZuk+6V5LDr2b5llSb4F2vCGbjBWSiFfs2DSv59Sg==
X-Received: by 2002:a05:6638:bd0:b0:374:fbed:c3e9 with SMTP id g16-20020a0566380bd000b00374fbedc3e9mr25969136jad.38.1667694519166;
        Sat, 05 Nov 2022 17:28:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p16-20020a056e02105000b002f966e3900bsm1297535ilj.80.2022.11.05.17.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 17:28:38 -0700 (PDT)
Date:   Sat, 5 Nov 2022 20:28:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Clement Moyroud <clement.moyroud@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH 2/2] maintenance: add option to register in a specific
 config
Message-ID: <Y2b/tCUc3nGI+8M7@nand.local>
References: <20221105184532.457043-1-ronan@rjp.ie>
 <20221105184532.457043-3-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221105184532.457043-3-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 11:45:32AM -0700, Ronan Pigott wrote:
> @@ -1502,7 +1504,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>  		if (!user_config)
>  			die(_("$HOME not set"));
>  		rc = git_config_set_multivar_in_file_gently(
> -			user_config, "maintenance.repo", maintpath,
> +			config_file ?: user_config, "maintenance.repo", maintpath,
>  			CONFIG_REGEX_NONE, 0);
>  		free(user_config);
>  		free(xdg_config);

The "?:" construct is a GNU extension which we do not use.

Thanks,
Taylor
