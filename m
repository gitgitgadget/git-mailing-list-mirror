Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CCFC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiBQLCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:02:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiBQLB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:01:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7D2B0B09
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:59:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so8372199wra.0
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CnDZTe+auw/r+NNzl4bwAVodfPlcni2fVDjCRVfpb2k=;
        b=TSkvJBAb0wmXMVwQ/LvB5o7e9nQ+6G4bIp2rZSlYC22ygseSFaq4skT5G9KJjTNAG8
         2vZSvxkuhyc4TKtUR0U2iYuasV5W6gIrFWRl4O2mSpWFKvFeu1QTlSj7mrlqOr2440f6
         2ESsp8JqFl+cvGVCDnBqvOmadGb4V6U7nyeM+9sfeYGi39OGDaoJ7QY93NQVIEEkLMER
         dSx/kwcbh7jXz1EJo93zMtSfVUKla0hBY45YpR65r7vKzCJAP5rKonaFgzTPqVKzlLo0
         xshd32/Xc4QFk4OpGBdCR5yeITVJ8Ui/P7xOaMvD2Gpv8TMUx61bk9IKDQt2CXjTPZMa
         yTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CnDZTe+auw/r+NNzl4bwAVodfPlcni2fVDjCRVfpb2k=;
        b=TFAKDvTDBukbxl8hFsxuf+HJwDcCKH2np52bQuTrGlTKSEUIhkDpINpd7e5gP/3P8R
         umcgcF/18ufJDVPblJvEjWAjrwEs9QnGHXn9Qu/lcY2o2z0YuYCcml8MRn0GnWKHd7Ou
         DCuHhNTkQU7AVf7UrsQr3V8csjSz4sGG+LnlrMBC6Y2IqXWQUdixljKzC/01Tmp6ES6h
         WKY89jH1dQNerJqK/51rkAQcOfChjB5Aoy27h+kn9cRhOXbtibSzYH1VASWSAqpHQIRZ
         Asp5z3dd0TZu0ULRA1ZBAkCa/4vs966nxy7foGvNRLFFRnkrkWjYa6xLqqHVun073xTa
         cFjg==
X-Gm-Message-State: AOAM532W9FtiQ7ZjnmRiIrAZRnvwSqziAtJgO9TpqPrJ+GwfL+tNoYWz
        dD3NMZ6jlZj+sE2q/ntSAac=
X-Google-Smtp-Source: ABdhPJySDyaRpt43rQBUCe04ENecw/o39gVOKeb5Zcv5LwGDikRWqRUQQ22kTS7k3+3vZ3rXiQFmOQ==
X-Received: by 2002:a5d:64ac:0:b0:1e7:1415:2548 with SMTP id m12-20020a5d64ac000000b001e714152548mr1892311wrp.267.1645095553811;
        Thu, 17 Feb 2022 02:59:13 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id f14sm1049358wmq.3.2022.02.17.02.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:59:13 -0800 (PST)
Message-ID: <f6c31ac8-b675-99c8-1577-07c26619e277@gmail.com>
Date:   Thu, 17 Feb 2022 10:59:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] terminal: set VMIN and VTIME in non-canonical mode
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
 <02009172e081ab5c4de8e2476c1142f97b41698e.1645008873.git.gitgitgadget@gmail.com>
 <xmqqpmnmcwwu.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpmnmcwwu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/02/2022 21:40, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If VMIN and VTIME are both set to zero then the terminal performs
>> non-blocking reads which means that read_key_without_echo() returns
>> EOF if there is no key press pending. This results in the user being
>> unable to select anything when running "git add -p".  Fix this by
>> explicitly setting VMIN and VTIME when enabling non-canonical mode.
> 
> Makes sense.
> 
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   compat/terminal.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/compat/terminal.c b/compat/terminal.c
>> index 20803badd03..d882dfa06e3 100644
>> --- a/compat/terminal.c
>> +++ b/compat/terminal.c
>> @@ -57,6 +57,10 @@ static int disable_bits(tcflag_t bits)
>>   	t = old_term;
>>   
>>   	t.c_lflag &= ~bits;
>> +	if (bits & ICANON) {
>> +		t.c_cc[VMIN] = 1;
>> +		t.c_cc[VTIME] = 0;
>> +	}
> 
> Quite sensible.  I wonder if we can simplify the "are we looking at
> an ESC that is the first byte of a multi-byte control sequence?"
> logic in the caller by using inter-character delay, but it is
> probably better to go one step at a time like this patch does.

I wondered about that too, but we'd need to keep the poll() for windows 
I think (at least in the case where it is using the windows console 
rather that mintty) so I'm not sure that it ends up any simpler than 
special casing poll on macos.

>>   	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
>>   		return 0;
>>   
>> @@ -159,7 +163,11 @@ static int disable_bits(DWORD bits)
>>   
>>   		if (bits & ENABLE_LINE_INPUT) {
>>   			string_list_append(&stty_restore, "icanon");
>> -			strvec_push(&cp.args, "-icanon");
>> +			/*
>> +			 * POSIX allows VMIN and VTIME to overlap with VEOF and
>> +			 * VEOL - let's hope that is not the case on windows.
>> +			 */
>> +			strvec_pushl(&cp.args, "-icanon", "min", "1", "time", "0", NULL);
> 
> Interesting.  So each call to read_key_without_echo() ends up being
> a run_command("stty -icanon min 1 time 0") followed by a read
> followed by another "stty".
> 
> At least while in -icanon mode, VEOF and VEOL do not take effect,
> and the potential overlap would not matter.  It really depends on
> what happens upon restore.

Indeed, we could run another stty process so we can remember the 
original VEOF and VEOL but that's more complexity and forking.

> Do we have similar "let's hope" on the tcsetattr() side, too?

We're OK there because we modify a copy of the original attributes when 
changing the settings and use the unmodified originals when restoring them.

Best Wishes

Phillip

>>   		}
>>   
>>   		if (bits & ENABLE_ECHO_INPUT) {
> 
> Thanks.

