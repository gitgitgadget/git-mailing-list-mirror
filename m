Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B2C432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 11:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0569B20880
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msbEDS5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1LGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:06:20 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40837 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK1LGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 06:06:19 -0500
Received: by mail-wm1-f52.google.com with SMTP id y5so11183950wmi.5
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 03:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yGrjynqdDrme41Uu4D+NKJGqpAMb/rYNWFt7SaHZfGw=;
        b=msbEDS5ltqBW02WQCd50po57lMkL0UQU8PsN8+hPdQ3KJWDwyXC+YIdpYs68t38xx7
         YZyasnHL3coR/KF6EURhyUqsZ0pyRcS13ryilB/p9kuIR8ET105862TohBIF/oBIjYT8
         ZGE5t5gBT07b/nXk9vWqRjljpDd8nyakdAZbW8GNtCIYKw9lsu8wuApX3v2rNH1JtRGA
         fFhCAc8sd+6Kw2AiU4nqXWQUpBbG3Pvs258kMkkVpi1BDcnsHIpCbm2Ea0k7xmDVomev
         rZD67HoB1cmksNcXQ5l89U1oQX3jysntk/S7mc8vMWssf4Up1ZugQj2qE+oGlv5Rf+16
         tugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yGrjynqdDrme41Uu4D+NKJGqpAMb/rYNWFt7SaHZfGw=;
        b=W4VvLeVn9P52oyjDj8F6R1NaVkddkhYcX+UOWbrl1qjgsO/hNpAEv+TceUOGSNqrCB
         rKL5O9Fvz4hplHabvSy7az612jjMZ34FC25gikbVOW96mAiroK952UwTs+SjVxYw7mjM
         O0K2av7yON2YWOfQjx0hMaRyOFeqYu3R5FtCIGfaZVScRTcYF6nvsCW1LP6AWDheDyn7
         S9/CrzztFdqDypoFydZBxX3wblrJXn5hM6kq+nrMq8uz8V+b94ew8Tkam6aK/NJJu7uB
         z1e3EzZoDqGsmKraxIMYOuRh/B/04ozJ0/kZTbeJUV6XxwmyE8a2E2B6ddAL3dy1LxlY
         1flg==
X-Gm-Message-State: APjAAAUI5sXFjfxdq3IUski4bS/eL+uSEelsk/GG17+Y/BynxoLw4qHZ
        5ZIpjEwbseg/ebAADq35UeFSvDx6
X-Google-Smtp-Source: APXvYqwkpTOU+gbs4focUTIV5WW3kT7+eUBDhfODtYnL6NW4c2ghXuLMYsP0pK5rGGVFimFP6+WB8w==
X-Received: by 2002:a7b:c629:: with SMTP id p9mr1673386wmk.46.1574939177316;
        Thu, 28 Nov 2019 03:06:17 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id 76sm10342327wma.0.2019.11.28.03.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 03:06:16 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git Test Coverage Report (Nov 25)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com>
 <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <014924b0-f203-d3a3-f974-b1164511dbc6@gmail.com>
Date:   Thu, 28 Nov 2019 11:06:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/11/2019 20:46, Johannes Schindelin wrote:
> Hi Stolee,
> 
> thank you for keeping doing these reports.
>

Yes thanks Stolee, these reports are really useful

> On Mon, 25 Nov 2019, Derrick Stolee wrote:
> 
>> Here is today's test coverage report.
>>
>> Sorry for the delay, but I had some issues working out the new
>> "ignored lines" logic. Now there are a few phrases that are
>> ignored automatically, including "BUG(" or "die(".
>>
>> [...]
>> Johannes Schindelin	116a408b commit: give correct advice for empty commit during a rebase
>> builtin/commit.c
>> 116a408b 478) else if (whence == FROM_CHERRY_PICK) {
>> 116a408b 479) if (rebase_in_progress && !sequencer_in_use)
>> 116a408b 1186) else if (whence == FROM_CHERRY_PICK) {
>> 116a408b 1187) if (rebase_in_progress && !sequencer_in_use)
> 
> My understanding is that Phillip is working on a replacement for this
> patch, so I'll leave this as-is for now.

I am, I'll add some tests to address this

Best Wishes

Phillip
