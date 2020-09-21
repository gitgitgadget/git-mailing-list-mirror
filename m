Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA8C43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445482084C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtniZchn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgIUNn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUNnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:43:25 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D31FC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:43:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so16946851oif.13
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iNkWyms/ZM6i1UotGXB6Op31E6mlUmK1NOTUHpyG9to=;
        b=HtniZchnml5E+fKGD23vn0VSDF8y7XGozx7u/FRMD1y76Kg0ScguzAptLM7bpEYc07
         RRvctdYE1r8R/dJ+AheYckRz9DgMZ4XBN9mTi5j9BgCn3XLbJ0cJoXNBeEIFMTv0u+kv
         EmyGbF5zSwII68BbsQp9amVeNq8soiKVSCuOTUT5UONv6CQ9XNiiCrTMGA+mIMJC8NgG
         dwAwlUnPqHMJu0kNKfPJ0XlObr2rbZNIRHTwB3MguF0/Ce+6mtaaH6tFb9i22KrIcrkg
         o4qGspc51v/bVGLJMHAVNnbV9fwrg10RX3z0rvDbdAaBwIGy8IlG/e4utSQBP8FsObpP
         HhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iNkWyms/ZM6i1UotGXB6Op31E6mlUmK1NOTUHpyG9to=;
        b=fpoQLv6ajHOBtgbWkpDK7xDMZdO8eqDqB77mW3p80HbKCrzDV5D84yQ4w2xl2KCU0D
         8fB9K0XUz4o8+HzK0cfXJK8ELYj8sPnh78iCGdAZGzdi1p2aPDaks1qFaPRwyJmk0z3A
         N1kXtQVgRiMPYSQZ0aV//2EK6GPiC2Qw8VX5r9O6qx2qDuDY+P9KSXFcm/EKSI4iD33L
         uTjcGMesQ+Zy+hxLDjyJQNIzvT84By2aOCXUe2fXA/sIx8Ywsx55YGE+GIpXpX58Yei2
         WiG7qPl8pRzdDWFUxtuqjIjeJa1N2m4HzT7qnTFfBxMz0BDOSIfrUqfj7Ca87RU2KWUZ
         Wr6A==
X-Gm-Message-State: AOAM533FCF68ytTBMZdcG4xQ/rGbxqcNBZWFZKWswnccmMWgFcaI8gPM
        ldGiugJ28rUs5R25TbGi8A1tA+UiA2+uYQ==
X-Google-Smtp-Source: ABdhPJyuDtYGfBoK24seDy7oexQSFKD3ax64ue/CHlCquEDiQMgjofoQca/PFr6LQHPm86iVN3ny3A==
X-Received: by 2002:aca:413:: with SMTP id 19mr18295920oie.149.1600695804939;
        Mon, 21 Sep 2020 06:43:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id a6sm5940804otf.51.2020.09.21.06.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 06:43:24 -0700 (PDT)
Subject: Re: [PATCH v5 07/11] maintenance: take a lock on the objects
 directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
 <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
 <1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com>
 <87d02fi75p.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <368d7c1f-b8b2-8bed-ead4-047019125435@gmail.com>
Date:   Mon, 21 Sep 2020 09:43:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <87d02fi75p.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2020 9:36 AM, Ævar Arnfjörð Bjarmason wrote:
> There's now two different lock strategies in builtin/gc.c, the existing
> one introduced in 64a99eb476 ("gc: reject if another gc is running,
> unless --force is given", 2013-08-08) where we write the hostname to the
> gc.pid file, and then discard the lockfile depending on a heuristic of
> whether or not it's the same etc., and this one.
> 
> With this as an entry point we'll entirely do away with the old one
> since we don't use the "gc --auto" entry point.

Users could still erroneously launch two `git gc` commands concurrently
and that will not use the maintenance.lock file. The GC lock is worth
keeping around until we redirect the `gc` command to be an alias that
runs `git maintenance run --task=gc [options]`.

> All of that may or may not be desirable, but I think a description in
> the docs & tests for how these lock files should interact would be
> helpful. E.g. writing a different hostname in the gc lockfile and
> setting the time on it with with "test-tool chmtime" will cause it to
> plow ahead, but doing the same for "git maintenance" will stop it in its
> tracks no matter the time or content.

Thanks for the pointers to create this test. I'll try to get to it
soon. For now, here is a tracking issue [1].

[1] https://github.com/gitgitgadget/git/issues/737

Thanks,
-Stolee

