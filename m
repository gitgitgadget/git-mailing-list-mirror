Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC2C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3684060FDA
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhHQRWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhHQRWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:22:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95BCC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:22:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t3so23879544qkg.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HaLmb5jZMES+dcSR2ZRzsTaUXuQ1ktqSKtnzpI/4yUY=;
        b=tvA16/oST3ZmSi2z/03QlFlh6blGi8AzHXlkcZd4BjN+zMBZEdsdSk+Uy90heTQ+Hm
         q7LTNuecdwkBF9UJJP+4nJRTBwqUSjk16WFhuO3/HsmxTzPLVqij1H/JHHy50spF25Nd
         JLQoUWjHFJ1SFH9S29PqfUIVfxmg5Zs2zl8Do3wNTsiFN1r2wap4K4IMKG/nMw+56ahH
         Dw6LB+mUgt/SGBlLxSlQljNk25eiHLgkdHVnJ1+RPJChozJINO8zZlz6ggXhTjkVRB2P
         0LLQA9fewT51VZjaud5GgJaIhMhjPmWAl6s0GRHAq/pLWUD1DwU8ME6oyfLMIU9WHH/C
         NAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HaLmb5jZMES+dcSR2ZRzsTaUXuQ1ktqSKtnzpI/4yUY=;
        b=gGEoT3PlVtOR+cBxnBYKGKocXewoA7TMjUVa6LkkQETbEAeAFJ9oCuOT0571U0/Obm
         snrE+TXbGQS8gML5Oc+PbDHBWE2an+elFaddIzC/S7SJ/fMCknepd9nJ7N1KI5imR08C
         9/BpFAzVB0BNCwTJcErnaT27P2aR2lrrwwNpaAyyuBX5YcNQQxDRolVQO5tLXtPvu2fU
         0VAAv3Bw/PRlpJXmjLwlIXZLJBFzChIhnAOqj1BZWOJobkPIw2lWM9TXCOrnbNMYhl9Y
         duPwIejra7ISoWWewz6Tqj76Hr4GzTFXDk4BKDrFHvmGZpkNpYcDZsWuPND0FllHMWhn
         EjbQ==
X-Gm-Message-State: AOAM533lDGSvqEbrOakBcfgnF/sfeIUXlgDR49n5A6PDamegmjxW3dNh
        OXC71bmyHo8bECaX1Fer2Sw=
X-Google-Smtp-Source: ABdhPJwVFQGWSSakRGhuNRMPO7Osv4MTNU+F3lCbIDRv2ZTZ10aPx9FoF0G5Y/GXP7aVMfABr3FKIA==
X-Received: by 2002:a05:620a:1419:: with SMTP id d25mr3184420qkj.133.1629220926392;
        Tue, 17 Aug 2021 10:22:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id 207sm1871649qkh.45.2021.08.17.10.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 10:22:05 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
Date:   Tue, 17 Aug 2021 13:22:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210608134000.663398-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2021 9:39 AM, Lénaïc Huard wrote:
> Hello,
> 
> I’ve reworked this submission based on the valuable feedback I’ve received.
> Thanks again for it!

Hi Lénaïc!

I'm replying to your series because it appears you did not see our discussion
of this topic in the What's Cooking thread a couple weeks ago [1] and might
miss the discussion that began today [2].

[1] https://lore.kernel.org/git/4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com/
[2] https://lore.kernel.org/git/7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.com/

The proposal I give in [2] is that I can forward-fix the remaining comments
OR re-submit the patches with a new patch and some edits to your current patches.
(You would remain author of the patches you wrote.)

None of that is important if you plan to submit a v6 that responds to the
remaining feedback (summarized in [1]).

I'll hold off for a couple days to give you a chance to read and respond.

Thanks,
-Stolee
