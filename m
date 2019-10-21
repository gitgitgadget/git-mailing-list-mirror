Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B621F1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 11:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfJULoi (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 07:44:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45529 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfJULoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 07:44:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so20452303qtj.12
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Xo+pFC/9xj139iPGOV2x6PHDpID59zBX6YcBtG0Scs=;
        b=jP386Mfgb4CdWfSczpJqllhFGRG6NUnsblKxC3YkSRBCbQVCAfnJJouTzeOZJt5D6d
         tsa7Vc5OrPXqnvaFg9D7SrscQizLMa6cS3bQ0PihFSLcKSwRekxiLvfLD3250qLNeC9G
         +XIOMmovUoZQv6ziNRO1rOvN5/THUt8K5C1v1m8ehHgZy9ERvFcgL6MYLmM/jWLNtpF8
         NpFoAAMxWr8BruU46ejJ9HWrSUJXZOmDIfn6egd+00hs2ii5NuiDlOOGs3zQoo/S4Gs2
         N0wUc6QgN384g5JqK5jX08MD7sTBVMz9DvFFlv7yyoBjBRkX1H0BbSJnRtWQH0h7aVKN
         oftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Xo+pFC/9xj139iPGOV2x6PHDpID59zBX6YcBtG0Scs=;
        b=EedV3HWqUg0/9NtiObksHMjL+PlCglRTM3PuMqlrk0x5mw6bZwVKij05Asf3m5NcSh
         A62FWNR/JNdeXfJmVWMn003PHN7gnhQfbkMCW2Qs1noPkXawLpAdec+7Nni5/VM9uIpJ
         MLxPl+0yhLstPRTeDD8vbt6vETUBHNfXKv4w+mOJIPVKHYEe/YwjzYlRk4pahYp6XOE8
         0EpyNjUC2gr1+u9OVNROaZuL7RQk4hWcCHF1ap6iNrq0FNvI+KopJFlDfn+uqbwkqoGv
         JAaHX5PBqD1478/dAR5xLQmyVpOL9ajp40Kyv0ZrIOXKaFL+Rd/qhS3IX1Tz+D2TE6JZ
         76Fw==
X-Gm-Message-State: APjAAAVVeC1wMB3Og8ZX0OwMz8547MngcVBPHZmfxjcOBO4A4dWnSC9q
        LGnmT2DEtMcrGQnuX9zp9JE=
X-Google-Smtp-Source: APXvYqzjfAPv8wHz3V+kRvUHInmX2JyhR273bU8se4Og2IROo4lecT5yCWRV3uIJWqzur2KvLsuI+w==
X-Received: by 2002:ac8:6bc5:: with SMTP id b5mr23919100qtt.144.1571658276569;
        Mon, 21 Oct 2019 04:44:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6d2d:aeab:9f95:a7f6? ([2001:4898:a800:1012:1e61:aeab:9f95:a7f6])
        by smtp.gmail.com with ESMTPSA id x9sm7072682qkl.75.2019.10.21.04.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 04:44:36 -0700 (PDT)
Subject: Re: [PATCH v4 09/17] sparse-checkout: use hashmaps for cone patterns
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <28606a152c79c4e399c5a9c77038888eda34341d.1571147765.git.gitgitgadget@gmail.com>
 <20191018153112.GF29845@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d063d58b-2e4b-5fbe-0aba-8086215fd9b9@gmail.com>
Date:   Mon, 21 Oct 2019 07:44:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191018153112.GF29845@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2019 11:31 AM, SZEDER Gábor wrote:
> On Tue, Oct 15, 2019 at 01:55:56PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Running 'git read-tree -mu HEAD' on this file had the following
>> performance:
>>
>> 	core.sparseCheckout=false: 0.21 s (0.00 s)
>> 	 core.sparseCheckout=true: 3.75 s (3.50 s)
>> 	 core.sparseCheckout=cone: 0.23 s (0.01 s)
> 
> The previous patch added 'core.sparseCheckoutCone', so this last line
> should be 'core.sparseCheckoutCone=true', shouldn't it?

Good catch! Thanks.

-Stolee


