Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BD1208E9
	for <e@80x24.org>; Tue, 31 Jul 2018 11:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeGaM7q (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:59:46 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:61290 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbeGaM7p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:59:45 -0400
Received: from [192.168.2.201] ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kSgyfkVCSbZX5kSgzf0f3j; Tue, 31 Jul 2018 12:19:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533035994;
        bh=OOXMe0typtwcxsjgmAQyz0RY9zkmdHz4hl0Jwxz+UBg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TyTw1WwkcJkXOR/5IPIvH60M2o4S5ExeyZhbvhmDrEByB0r589TyooCedb/Kqt4d4
         NIj8BVmvyDGv0vX6o+BqxAENJ0P1FYZqm/KYPzTgDWqOytyiQzyfHof82HrbxmBTSI
         PCz3ReJLi/XTHJrfnIEboh4kXmucnfjBhDDfs7/s=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=zsYAHonQiWfXfyVPKqQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <f9a7e77d-3c67-082e-ed8d-701f4d0d1759@talktalk.net>
 <CAPig+cRkdAoV7gsEeKMcvhckifRxU32+ec2zxY7MgNGmJp5Sug@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9c327584-f5da-bd40-e395-9273a4011a66@talktalk.net>
Date:   Tue, 31 Jul 2018 12:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cRkdAoV7gsEeKMcvhckifRxU32+ec2zxY7MgNGmJp5Sug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHZd+zwiqszNTBW7H84b2bn+F4pZ0DAKFzYLwg3avEy7M+7wjV1cryyjNQfX0Ucrs5/4MVyPK/xOnAVhe9FZyUVQmpnN87BYrCYd+znSJitvUW0F1ecb
 u9fCYa200RpSFChw5s+RMBNiUbQxTW/dDJRzSDE6ns4puspXDKZrZhnGxusSCk0HYu6djc6msGey4F0LLmspZjJqJL5q9SvOxFP4aDHC+omMpx7ggImq16Uk
 P+i5WCYdV/wmsXJXOhBQWDZ1HcT07qXMtc9c2L4xsc9Qehmmq1Df//HpZQWi1R5m1cYjXk4gHktuqHMB3OjlL3lP5tKON4v8Lt/3O1yTlgk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 31/07/18 11:46, Eric Sunshine wrote:
> On Tue, Jul 31, 2018 at 6:06 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> On 31/07/18 08:33, Eric Sunshine wrote:
>>> Patch 2/4 of this series conflicts with Akinori MUSHA's
>>> 'am/sequencer-author-script-fix' which takes a stab at fixing one of the
>>> four (or so) bugs fixed by this series (namely, adding a missing closing
>>> quote to GIT_AUTHOR_DATE in "rebase-merge/author-script"). That patch
>>> probably ought to be dropped (without prejudice) in favor of this series
>>> for the following reasons:
>>> [...]
>>> The test added by Akinori MUSHA's patch may still have value, and it may
>>> make sense to re-submit it, however, doing so need not hold up this
>>> (higher priority) series.
>>
>> Yes I think it does, also the patch that Johannes and I have on top of
>> it to fix the quoting of "'" in write_author_script() relies on fixing
>> the missing trailing quote and handling of "'" at the same time,
>> hopefully we can get that rebased on top of these asap.
> 
> I'm not sure if "Yes I think it does" means that Akinori's test has
> value or if it means that this series should be held back waiting for
> other changes built atop it.

It means we should use a test based on that with the quoting fixes on
top of this series and progress them together if possible. I think the
quoting patch I just sent is good now so hopefully there wont be any
issue with it holding up your fixes.

> Anyhow, thanks for reading over the series. I appreciate it even if
> our "sense of priority" doesn't always align (as evidenced by your
> review comments and my responses).

My "sense of priority" was informed by the hope that the quoting patch
wouldn't hold things up (let's hope I was right about that!).

Best Wishes

Phillip

