Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F5C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462BA20708
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCrfW6Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgIQPZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgIQPZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:25:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2270C06178B
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 08:25:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so2553705wrn.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jImqtrnvynD3R43fafjnTmHUL4dM+lNtpmkuWaLe2jQ=;
        b=NCrfW6VtTIhjsRuJz6xyGhlsTxkywGma99X116+Pd75sTyAC51zGGW2FF5KdnuFDqb
         PqPrCHkpjNGeyPD+wPLMH6ycEaJHnnVFXC6pSxnxxKPoXQ74Dd7ug2pXl3YECTAdY+JF
         ye0O04V5X52QRzwR/UvY8w9QvCh6H07ube4FB97B1C2HO2k70Kot34AWV1Utl2OiTv7z
         tiSR964Y4Wxa+euGCjFt6+lMDO7EII4txFd8BUVeGyulzXvrywbd40nGPff4TwWZQQEz
         KowIselzOYOCaxO2jp/AXmIxOZ4BaZmE9Kz6IZnrI08m6BCax9bMRzfO68ZP8fJ2qpoG
         d4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jImqtrnvynD3R43fafjnTmHUL4dM+lNtpmkuWaLe2jQ=;
        b=Um34bF7KDwkZH1St8uK+Ul+A80hdSq1WeF21Xtf6YwksVz7UfxGKyjHmFyZB6FtWFw
         BGHZe5UudVnDy2W4ZJCtmd+eVEYE0Yhm0rEgmzcLRPSg/gHsBZn5KEVJvxzq6LP68ik8
         NpjI6bRCNrkkaPaBPQ20zICbhDNTn6Tz7gGuzFuJK/r0ewcxUpvkMb2zxlYqGHgggJ7Y
         nZdxCSZz9DqZOwGQJpi2xi52ohr7vjkuwK3e4QWl5Gtt793RUY3JW5rAk5n6OzLVeE6e
         FNZSw/QpKbgmSAwRnlsKoZ8oa52qW/WZojcFFpMw6TOg/s+0TvRPMMz2QV1xT3IPJ3Fi
         DhSw==
X-Gm-Message-State: AOAM531lfbiDw38phLkaKCFgc6IZobS9G4yVw4X9r2vWJj6EID8zf4/l
        vz4v3mBN7z8VhaLKC8HeYkkHWlVj1N4m5A==
X-Google-Smtp-Source: ABdhPJxfnIFIS7lblVxugtUJHeKB7qkkJRQnoVDjlR2w9xxaVHzcq6ih4oL8Ml8Pc2BQQxTuAPSpAA==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr33194878wrs.107.1600356309475;
        Thu, 17 Sep 2020 08:25:09 -0700 (PDT)
Received: from [192.168.178.23] (aftr-62-216-206-159.dynamic.mnet-online.de. [62.216.206.159])
        by smtp.gmail.com with ESMTPSA id y2sm10864899wmg.23.2020.09.17.08.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 08:25:08 -0700 (PDT)
Subject: Re: [PATCH 4/4] clone: allow configurable default for `-o`/`--origin`
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <83b5a9a0-6982-2bf7-139e-5cf2823f223c@gmail.com>
Date:   Thu, 17 Sep 2020 17:25:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-11 20:25, Sean Barag via GitGitGadget wrote:
> From: Sean Barag <sean@barag.org>
>
> While the default remote name of "origin" can be changed at clone-time
> with `git clone`'s `--origin` option, it was previously not possible
> to specify a default value for the name of that remote.  This commit
> adds support for a new `clone.defaultRemoteName` config.
>
> It's resolved in the expected priority order:
>
> 1. (Highest priority) A remote name passed directly to `git clone -o`
> 2. A `clone.defaultRemoteName=new_name` in config `git clone -c`
> 3. A `clone.defaultRemoteName` value set in `/path/to/template/config`,
>    where `--template=/path/to/template` is provided
> 3. A `clone.defaultRemoteName` value set in a non-template config file

Number 3 is used twice in this list.

> 4. The default value of `origin`
>
> Signed-off-by: Sean Barag <sean@barag.org>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>

