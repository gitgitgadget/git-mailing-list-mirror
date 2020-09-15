Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A2C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F5521D43
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqRCYOkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgIOMRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIOMQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 08:16:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C8C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 05:16:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o16so3887610qkj.10
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y0zsrKlcmL2umDETqSfRkZsxtpN5j5lGnEGSlftH4ps=;
        b=MqRCYOkgnd/cbiraU7nRdnkz6duE8oKzvE8wOnbWcJcC1ru90VZ9XO0yYFvyXrgTtb
         cK6d8bjJR4ydgUpZ2efsLPFdPhHE+ABCIGWs8iFBJoBzuELG3U4qLERxPUfQs2IXJkt6
         JfDhVv2p3G3BMWWyS/lE5NfS8UogRWkREaGrE9Il4XseLtvnb67m27aM0tWtBrYxMb33
         WLge4ybPhL3Hoq5yBDZm2t4iv/wgb8mLEYCVKwsDe95lT5gXHvy3Is0A1YuDNG7Wj/HN
         HOT9ex00kd87JacxOFxZWtaMhFfgUMvi/9SrJrjpYg0JeFdtEIa+llEw0JBUgkHAQc3B
         Js9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y0zsrKlcmL2umDETqSfRkZsxtpN5j5lGnEGSlftH4ps=;
        b=PzGIvDXBQhXXQeYYghgmg3u9Oec3idbDEPKG1ZNzVsdt8o0spMKpeIA2DcynVyKRMX
         QHc7meia9MmIbyvf3vgB8SU3iGUZ4OBQW3ncVU7dMMyJ3AXaVR5k0vVOSSyAkpPqh5nS
         GorisIIQCF3zBLTAVJm3IUcaQVEB0NakvWrXxLZebc6yIDqPLZfLBiS6QM5e11pJnYGT
         1EiXt+2Dh0xa4vikcDQb1mHdoI1SaiH+CI1atQUf/HU+4oZtRzKZDNOgWYK7S6eo8ZCb
         XaGAw1p/QKjUyL4IGeBMfl/gH8W1AIcetNXDe4mYZ5OogoW9omegt+Q8TKAsfJgPc1hp
         O9nw==
X-Gm-Message-State: AOAM532jsXBPlgUaJy4SKKtBJBIJztSKGtSFm9tzUkkNYZdeiVsRUhmR
        DO7IW71ptITlflmqJ0xyH/6j9lzsJPwfhQ==
X-Google-Smtp-Source: ABdhPJyZwjzjdC1iwXBwvK80NCFriWz0DZ9dzN1buBX9C72POovzwgojZvNR0qQhmTkTKfy8IInzNw==
X-Received: by 2002:ae9:ebca:: with SMTP id b193mr16421569qkg.162.1600172191415;
        Tue, 15 Sep 2020 05:16:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bc0e:a2ea:ef62:1341? ([2600:1700:e72:80a0:bc0e:a2ea:ef62:1341])
        by smtp.gmail.com with ESMTPSA id s192sm16533799qke.50.2020.09.15.05.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 05:16:30 -0700 (PDT)
Subject: Re: [PATCH] commit-graph-format.txt: fix no-parent value
To:     Taylor Blau <me@ttaylorr.com>,
        Conor Davis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Conor Davis <git@conor.fastmail.fm>
References: <pull.733.git.1600142634326.gitgitgadget@gmail.com>
 <20200915042607.GA19144@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ff4e93a-7291-3093-2f79-9e98236c11f7@gmail.com>
Date:   Tue, 15 Sep 2020 08:16:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200915042607.GA19144@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2020 12:26 AM, Taylor Blau wrote:
> For what it's worth, I can hardly blame the author of a9aa3c0927,

I can!

Thanks for noticing the doc bug. May I ask why you were looking
at the format document so closely? Are you working on a new
implementation?

Thanks,
-Stolee
