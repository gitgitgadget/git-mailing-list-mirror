Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BAAC47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3994260231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhEaRkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhEaRkP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F563C068ED0
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:54:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jt22so17587387ejb.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sPxwqA5Hp9djStI2E0N3xDr2U+7ADTVY7598pY/QXUc=;
        b=eWeXWCOMCln73T4EHI5dIBvVpDOxhA6VCTR/zRtHOWyA3zbttM+OsFIpuYVF2Vcv2U
         OQmWivRus0ulnO3KWlThHEwMOHYSthuz9Q2+nnjOwOH5K9bhd+D8fcetSyaMuLgUkokL
         fZzgOQZNGYhaWDzHqu228KpH2lBvq9TAmHs+dxow4Q4WbwoiA8X1guzCHDEg5FPWtPq6
         ct+buadW4t3Jzt/gpjcFzLvTzyZ1b3nkXm2rYpeG+JcSy8SldzYuzY9RR4+v68VpcNJT
         1wf3KCtzIxqVZErBrq7MThpspddbXXNg/z/N1+ZhoRtQhN9p7L+V+1fpHCa3xx/D7EQq
         wjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sPxwqA5Hp9djStI2E0N3xDr2U+7ADTVY7598pY/QXUc=;
        b=H5eL4bzkiArZvqNJNem+fXpvfTylmUqw3WLsZYw4bncOK8U/xES+DJBSyhweymuDnq
         HFIuSNvBGBn1NnV+ui6p/I7f2QbfK05vU6jxVOo3NQME2yT+upPcis0RLCs334o5eII9
         jcQgV7XfxdMw06DJoVCAH4mMlSHjuhbpb0y3Os1yLUdxkRrTzcU6GV8aNQ7KgTwtIO1s
         f4/zl5kKRmgsKGe2euPSoAFcISO+xAG1KDN0qF6nSvADx4ogV4hzPvGZzAZgyWPCK5GX
         3mz8AD1BCsjdXCgbJ9wD05TPUDB5UtqLfXyxI1gx95LnsrQZU+WUwoIcvDw75UQv2K9o
         vxvg==
X-Gm-Message-State: AOAM5331Y66zaMvoGUXWsi8BMj63p8dmA42hWYf2LK/MYzb6Rh4FyVKm
        hM2d3a5GPdPFON2w8rls0YVHV13Ft07ZOg==
X-Google-Smtp-Source: ABdhPJx1uGiHl37Kws5DgO6vWn1F+pq/VJp+/FnGxXKQVoyxRHMueqM/KKAJiKD4TCg5YaRhWkqX8g==
X-Received: by 2002:a17:906:9512:: with SMTP id u18mr2263538ejx.61.1622480093834;
        Mon, 31 May 2021 09:54:53 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:c4c7:70b3:fe71:c06d? (2a02-8388-e002-8cf0-c4c7-70b3-fe71-c06d.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:c4c7:70b3:fe71:c06d])
        by smtp.googlemail.com with ESMTPSA id oz25sm4335078ejb.48.2021.05.31.09.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 09:54:53 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
 <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
 <60b4fd4db5dee_24d282088c@natae.notmuch>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <5fa7e3f4-60a0-c3b1-83f2-054ed38e5683@gmail.com>
Date:   Mon, 31 May 2021 18:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <60b4fd4db5dee_24d282088c@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.05.21 um 17:14 schrieb Felipe Contreras:
>> In your above example, I'm in centralized workflow, but I can still push
>> the fix-1 branch to origin without having to configure an upstream
>> branch for it.
> 
> No, you can't:
> 
>    % git push
>    fatal: The current branch fix-1 has no upstream branch.
>    To push the current branch and set the remote as upstream, use
> 
>        git push --set-upstream origin fix-1
> 
> Isn't that problem the one you originally described [1]?

It is.

> Maybe you are thinking this patch series implements the fix I proposed:
> it doesn't.

Yes, I thought so. Sorry for the confusion. When I asked "will your 
provided patch fix these failing push commands" you answered "It's not 
really a patch (yet), but yeah: it will". So that's why I thought so.

My point simply is: For the sake of easiness of use, I think the 
following should work with the default settings of git:

    git clone $url
    git checkout -b fix-1
    # do commits
    git push           # should push to origin/fix-1
    # others push to origin/fix-1 (but no local changes)
    git pull           # should pull from origin/fix-1

Will this be implemented?
