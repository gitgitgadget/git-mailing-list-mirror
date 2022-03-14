Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE5C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 10:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiCNKuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCNKuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 06:50:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C31EAD7
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:49:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so840500wrh.11
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yZTdkAsjyjpF1sT6YS0iHyWRqhbdKTYW5EtdS/UpUAM=;
        b=AX3GwCqX692H9Nokc3F6AhIUuxgBfgAm6G9V0CBBnllbiQy5A17A4XikA4dhzP14FJ
         xl6wln+5sLBDc9dY8vroUgMYMIa7y+w41q9OaHp9xMhrGwx6PEUTIuAt6TBGp8eyTuPR
         xIRTFzojxpdXKgX+MBX7MhxMmdnejtd2mkM1MriXYDv6EUNGWDwUJv8kB3ls7+yZe3xD
         2/xaiHyoQC6Irk3iZ7nzVGflUEpFkKbDrDTMGXFZ+6wKSm+3oe/UZS+GfHS32INeENls
         DTU75k4TvPgYnVsAnbYhOQ6Njg3pCBbVpmwiMlfOi5WYQIc2nH3PaeYG8DpVVW31s6dT
         HKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yZTdkAsjyjpF1sT6YS0iHyWRqhbdKTYW5EtdS/UpUAM=;
        b=ry0JeWFW+fnMFeo8PIwsWrYlIuaW2sW5DGF68fegml4qqRi4jyXFCFS/TcPLlrQe1D
         L4sdlyqD7vCwmB9SCvKLhzZfYTHeblkuEFJOpcJ9YQja0R5+reQT2aNjReVAo5o+dEc+
         lcfb9vZqjIBuy48Eoj1hESktqzilhi9AWJsQdafwnypmPAnNlIbhdum1WYbwkqXjthms
         JaTSFNV1/IlMiP3F/VWALiH/3zK6Qx6Uia381PMw6d1i3BHu9g94TGhA9eXwaNR2HhD9
         vFZX0meHYqlkBOOwuBuDVI5r4GDYarrkMnc+76AMHG9XUYCZ0aD8pWlt7rP2h/PAKeP9
         tilw==
X-Gm-Message-State: AOAM531OejDqA3CckNgJmDANbev0VkBc82s+MbcQPHf0onHjocYuuzR5
        3wp58xbeBxy2nVhfexFawe8=
X-Google-Smtp-Source: ABdhPJyJRFsDKaHrdNQmVLXstKV161s5XXTtj9Jo0bcxIWlCs+Dkg7ZBt4teU8FajR8SsnxqCfhLtg==
X-Received: by 2002:adf:ff8e:0:b0:1f1:dac0:c588 with SMTP id j14-20020adfff8e000000b001f1dac0c588mr15771044wrr.400.1647254949349;
        Mon, 14 Mar 2022 03:49:09 -0700 (PDT)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id l7-20020adfe9c7000000b001f06f8ec92dsm12891333wrn.30.2022.03.14.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 03:49:08 -0700 (PDT)
Message-ID: <92a80462-c00e-acf7-7cce-095891f42226@gmail.com>
Date:   Mon, 14 Mar 2022 10:49:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] terminal: use flags for save_term()
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
 <20220309110325.36917-2-phillip.wood123@gmail.com>
 <CAPUEsph4Gzd4S_YNeCF+uHntGWXdcA2wY9XL=-+MZtJ0YZb-Sg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEsph4Gzd4S_YNeCF+uHntGWXdcA2wY9XL=-+MZtJ0YZb-Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03/2022 16:52, Carlo Arenas wrote:
> On Wed, Mar 9, 2022 at 3:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> diff --git a/compat/terminal.h b/compat/terminal.h
>> index 0fb9fa147c..24c4df4c0e 100644
>> --- a/compat/terminal.h
>> +++ b/compat/terminal.h
>> @@ -1,14 +1,19 @@
>>   #ifndef COMPAT_TERMINAL_H
>>   #define COMPAT_TERMINAL_H
>>
>> +enum save_term_flags {
>> +       /* Save input and output settings */
>> +       SAVE_TERM_DUPLEX = 1 << 0,
>> +};
>> +
>>   /*
>>    * Save the terminal attributes so they can be restored later by a
>>    * call to restore_term(). Note that every successful call to
>>    * save_term() must be matched by a call to restore_term() even if the
>>    * attributes have not been changed. Returns 0 on success, -1 on
>>    * failure.
>>    */
>> -int save_term(int full_duplex);
>> +int save_term(unsigned flags);
> 
> s/unsigned/enum save_term_flags/

Well spotted!

Thanks

Phillip

> Carlo

