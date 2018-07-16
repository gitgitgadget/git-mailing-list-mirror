Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4BB1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPTQF (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:16:05 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41317 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeGPTQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:16:04 -0400
Received: by mail-qk0-f195.google.com with SMTP id d22-v6so21010355qkc.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RAVJal7XuLuqrdUEiIb7OICwB1uvlOxXC5Ybt9rbFKI=;
        b=ETExcOXwww02i3I2e3Den6ennx6P6exwKWKiB5pbRowaq9/WhJm65rN0B6s5sL/17r
         R5AyRKUxYiSKqUVOM5L80EVszDRC+PXYqkww7auR0ptnM4bjTw+EHWCajRYKbuFl4UPb
         LBZ37kBsvz2ALloBmt6YQaSIOrHUSlxYev9xHAZjUjstknIqLQfaZVoFIY8r77T54AaV
         5twT+9mX8YyBOQGG5Puh7pgWtjNiUHGCIpa6OJPRNNCVmncAuSLaX1C9sVV4Sj+tmyN5
         lcGFZSBYZp6/WqaP/bT8e3HHlEyyNBQ/l4JJY9YHFE5KZhLpIZD9k/TSiayy+9xqi3ZW
         cMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RAVJal7XuLuqrdUEiIb7OICwB1uvlOxXC5Ybt9rbFKI=;
        b=XlYKQiYQTAp1eLr7F2fW0lVG2PYCzHJ33FdQLNjeEBSCLc0niCEJC/B++kzBtBNvH4
         XDGlY2EYRUxW7IuV69xFCd3LDf7jqZkrvGsonUAlnCM9fLBZcLL18dfeIEoCY8D7GHe9
         TQX86YcE06Dn9PWzgkuBrFbWZ43Fkd7lHAHWe1xDTMF3/2Ax2Mx56XG0jrmjFqJQ8l9h
         4L6t4acOWl4B/N2EszI15udqGLAmo0OO2rfCUEglxAVR8MlVZUB7dlhcPbVoo0aPDpDI
         7MbQwc0afv0GroWPGRPaNR33Lrgay/8xt8cBG0Rehav0FHa8uNWF+rmkNLHsKjI+sgge
         +MWA==
X-Gm-Message-State: AOUpUlFsa2Fi8j5opYI+sOx5UL69r1Z0iw56p94taMv+I8kQNzRNXC1q
        1W+kIhasrpswyN5LQa5PZ6k=
X-Google-Smtp-Source: AAOMgpcBasLcVQlwfAIFZGvBH1fvV/SnFcKnt2pHDAopeBfwW//qC+qQrjsoohVD/wORBgsDmlM+DA==
X-Received: by 2002:a37:7346:: with SMTP id o67-v6mr14903573qkc.137.1531766842545;
        Mon, 16 Jul 2018 11:47:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:70b0:c563:a7e6:a86e? ([2001:4898:8010:0:59e6:c563:a7e6:a86e])
        by smtp.gmail.com with ESMTPSA id c9-v6sm27200733qtc.34.2018.07.16.11.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 11:47:21 -0700 (PDT)
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
 <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com>
Date:   Mon, 16 Jul 2018 14:47:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2018 2:44 PM, Eric Sunshine wrote:
> On Mon, Jul 16, 2018 at 1:27 PM Stefan Beller <sbeller@google.com> wrote:
>> Another pain point of the Gadget is that CC's in the cover letter
>> do not work as I would imagine. The line
>>
>> CC: sbeller@google.com
>>
>> did not put that email into the cc field.
> gitgitgadget recognizes case-sensitive "Cc:" only[1].
>
> [1]: https://github.com/gitgitgadget/gitgitgadget/blob/c4805370f59532aa438283431b8ea7d4484c530f/lib/patch-series.ts#L188

Thanks for everyone's patience while we improve gitgitgadget (and - in 
this case - I learn how to use it).

Thanks,

-Stolee

