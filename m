Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4C21F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 13:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfJNN0s (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 09:26:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51325 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfJNN0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 09:26:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so17304977wme.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p/rgbFNAmIC3Tuz3cd0Jgb6q774nBNkJMTIDOtXpi74=;
        b=Dt+YM1N8jnjxC+//TPOmpiQBE7AXaD5/He8onsHRsrFnZ+wxhzWxxyYOuJW2MEcLLq
         H6c93M5/lFI20pAyHehNi4uoPwTtl7dPpFCotu1goLLQ7iY9zMFEemVl22RKDc6YSdN/
         AeLSTAfsEMcj/LvHxKXvoG63W64fdEShiGpnBrAwW6m4OVQpi+sOPCUpYd7eH1aiMc0I
         Ihc1ITlWUCLAgJpc+hN7JzO/brGqDKmGeWqtfARW3UtLDHISLoyI+BhstqeF3fALFqXd
         Y42Zbap9Wh3moguRKlnboyJyLf/bKQWroeyDhhDMaMTWtHZjFUkKRSMiv0Thymo5kasl
         mTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p/rgbFNAmIC3Tuz3cd0Jgb6q774nBNkJMTIDOtXpi74=;
        b=JTlF7c4LxB+JrTH4RvVk2/WzpLru8RW3jeDjOyLR6p+tUQOdl+jcBx5gkEcobh6ea+
         V6T3Xywrrr2hTmt4Px0PgAQz3HQ+zjdhSx7BfpAmFnkblU4vrGFgJWa9zmtzoJ0eOu2y
         T+a4SZgnWRm42D4Y3OeuOuisJuO5D4CnAHxnvl+Ai1/Y+KfYgMfOPnRHQsNml4LZtDu7
         DQDjOkGxiIhd2/zz6Yr3gL7nYO+dy51JIbHyUA6i1+iexY4Roy0qw73K4OO6oIsZntu7
         7t8xuRCUm/MeZ3OFyq7ThJhP+4sifg9ISMrdUb44tQPZGRaryKMci5wHTHOBsIb9M+eW
         1FRA==
X-Gm-Message-State: APjAAAWnFGZ7107yk5ya4ODo71GgmartPvf0pZSamYQPg8OPey0mV3pj
        WcU++ZGqf/O4S24d/Ai1RQw=
X-Google-Smtp-Source: APXvYqxLa5ZZZfRx5PvIZdZNb7Lm1x9fcgBEzGOVr49bKwHZFouzxNLakZ/XXzxoXeXOm2V+K7ExoA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr15237930wms.166.1571059605537;
        Mon, 14 Oct 2019 06:26:45 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.googlemail.com with ESMTPSA id z125sm21044562wme.37.2019.10.14.06.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 06:26:45 -0700 (PDT)
Subject: Re: [PATCH 2/3] sequencer: use run_commit_hook()
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.388.git.gitgitgadget@gmail.com>
 <420ecf442c729878da5219f3c718dd136e4fa2b4.1570732608.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102314390.46@tvgsbejvaqbjf.bet>
 <xmqqk19bj4dk.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7a56faf1-a0e3-98ad-bdfe-e9ba0b97b5c2@gmail.com>
Date:   Mon, 14 Oct 2019 14:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqk19bj4dk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho & Junio

On 11/10/2019 05:24, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>>  builtin/commit.c | 22 ----------------------
>>>  commit.h         |  3 ---
>>>  sequencer.c      | 45 ++++++++++++++++++++++++++++++++++-----------
>>>  sequencer.h      |  2 ++
>>>  4 files changed, 36 insertions(+), 36 deletions(-)
>>
>> Hmm. I would have thought that `commit.c` would be a more logical home
>> for that function (and that the declaration could remain in `commit.h`)?
> 
> Good correction.

There are some other public commit related functions in sequencer.c -
print_commit_summary(), commit_post_rewrite(), rest_is_empty(),
cleanup_message(), message_is_empty(), template_untouched(),
update_head_with_reflog() . Would you like to see them moved to commit.c
(probably as a separate series)?

Best Wishes

Phillip

> 
> Thanks.
> 

