Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B037C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCXOj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjCXOj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:39:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37DFDBC5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:39:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so1139099wmq.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679668753;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9pns4akQedYxYpdTVYkIl3vL1uYyt/ZOqbhoX62nME=;
        b=OV0bo7Mt5gLEnVr7s43b3lbNFda5Pl9GuaaQB632tzEf34nS9u8jRgNO16H171Fy6h
         iRa4etlBRflx6unJ4LacLzfxY1ZzJM+T6t9V3RKQi6Bk+Jus9TNRrLvSxxU6Zu5rN1Hq
         b9HB9zqlNfhNxoPRY1B9DlC3LXWHEL3XjjHuHiQ21Jq6Gg4BKB+/fFjt8dLLV7Tns4TC
         xoC1H9pZH9baow2LRELShMgGAdK0pioG0PePMJ1iSiw0owmRQAGd/gavDRLF5Qy/cJep
         bhNyivOIKliPgrO7w3+QRjVWNG6jILHdc6zC5DFaGjEPnSiUSKrB18vU5DuhwpnJHQDv
         JjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679668753;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9pns4akQedYxYpdTVYkIl3vL1uYyt/ZOqbhoX62nME=;
        b=tiImOvBZ+aDXpd+2tgbtDBdCvRuMFA6SpOBwJ4YUKWPJ6U2LbAKOoQjaUOxS051BC8
         JVm+7YMgr8gsoJ7NscJj6pI1CzO9IfHvmUKc0vHYxKIIO/vjMdN9yHlT2dzY0EtzPn/P
         256xWvKu2egrgPYC5xQglWK0jU+kUlEBr6Ox3XLTRaYTxalKSGwMZq1iDqudDUw/CTUY
         pdcqlOe6OIjfgm1fahepf9rs5pw8eeCwB14ywpNScM39KK3smrUGuPyYP5hRN26DFJgF
         UsQPoQOazbx8y17I/dvpee4/Tciy+sKBp7uDx+d7UCR1DLmoINtQf95IkXaa6i0284oY
         QKbQ==
X-Gm-Message-State: AO0yUKVTCTNXrl80KO3auiiP+Tt1r8SnqeN9boA/Rf0s0XdsEsShEmlS
        tAZpARSgvHYP0HFrPw4Bk68=
X-Google-Smtp-Source: AK7set+E9g/Uzc5FoflToKOxADiWprLtr7bieia3jHc7R7OOKhEkbbURcMWQIk1Ux8n4i8AIbdhH5A==
X-Received: by 2002:a05:600c:21d8:b0:3ed:2b49:eefc with SMTP id x24-20020a05600c21d800b003ed2b49eefcmr2872367wmj.3.1679668753169;
        Fri, 24 Mar 2023 07:39:13 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id s12-20020a1cf20c000000b003ed1f111fdesm4980079wmc.20.2023.03.24.07.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:39:12 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7a0c66a3-0bf9-5bc5-a44e-c948d0b339f4@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 14:39:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: clarify conditionals in todo_list_to_strbuf()
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
References: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
 <ZBy3aa+7RhnjJUaG@nand.local>
In-Reply-To: <ZBy3aa+7RhnjJUaG@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor & Oswald

On 23/03/2023 20:32, Taylor Blau wrote:
> On Thu, Mar 23, 2023 at 05:22:35PM +0100, Oswald Buddenhagen wrote:
>> Make it obvious that the two conditional branches are mutually
>> exclusive.
>>
>> As a drive-by, remove a pair of unnecessary braces.
>>
>> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>> ---
>>   sequencer.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 3be23d7ca2..9169876441 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5868,12 +5868,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
>>   			if (item->command == TODO_FIXUP) {
>>   				if (item->flags & TODO_EDIT_FIXUP_MSG)
>>   					strbuf_addstr(buf, " -c");
>> -				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
>> +				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
>>   					strbuf_addstr(buf, " -C");
>> -				}
>> -			}
>> -
>> -			if (item->command == TODO_MERGE) {
>> +			} else if (item->command == TODO_MERGE) {
> 
> I dunno. I think seeing adjacent
> 
>      if (item->command == TODO_ABC)
> 
> and
> 
>      if (item->command == TODO_XYZ)
> 
> makes it clear that these two are mutually exclusive, since TODO_ABC !=
> TODO_XYZ.

I agree, it is easy to see that they are testing different conditions 
and item->command is not mutated in between

> So I don't mind the unnecessary brace cleanup, but I don't think that
> this adds additional clarity around these two if-statements.
> 
> Specifically: why not combine these two with if-statement that proceeds
> it? That might look something like:

I think you're looking at parse_insn_line() here rather than 
todo_list_to_strbuf() but your analysis of this patch still stands.

Best Wishes

Phillip

> 
>      if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>          item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
>        ...
>      } else if (item->command == TODO_FIXUP) {
>        ...
>      } else if (item->command == TODO_MERGE) {
>        ...
>      }
> 
> but at that point, you might consider something like:
> 
>      switch (item->command) {
>      case TODO_EXEC:
>      case TODO_LABEL:
>      case TODO_RESET:
>      case TODO_UPDATE_REF:
>        ...
>        break;
>      case TODO_FIXUP:
>        ...
>        break;
>      case TODO_MERGE:
>        ...
>        break;
>      }
> 
> which is arguably clearer, but I have a hard time justifying as
> worthwhile. TBH, it feels like churn to me, but others may disagree and
> see it differently.
> 
> Thanks,
> Taylor
