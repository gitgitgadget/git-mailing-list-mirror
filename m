Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB78C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BCE610A6
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhE3NHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3NHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 09:07:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE47C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:05:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n4so8031680wrw.3
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ABNt1Kw+BhABY1ISQv2d0BwO0y1bdJp2jDb8Wp+2K4=;
        b=YWd85JI3aMhDvXeL9F30gIwqsw2rivEKdB2ilioT+t42RhSWyLMmjWnDEUx/Dtl9yv
         eW7riWhsxvEfD9mwvPOoE4qy8x5VOXPNDYxPkpg3AIadd720XbU9gQXHvp6rKZi+P91E
         Kzv256PmGZfmjabZj7O08lRoum73P186YHiMt5OoKcXZEkjJMugCmJbrlAnLScncwfia
         gNj1BRL7dmn6Xeq3fxlD9mdalK3Nhn1f+E0ef5sCYFBmBFe68Sf8JiZaoEukeS4be2kL
         LDDjAXB1hbVLg2We9M8gxcsetzhfN+QgqVfA6qsdf2OSCJjoTdvIBonzvjqA9vefUUkG
         VRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ABNt1Kw+BhABY1ISQv2d0BwO0y1bdJp2jDb8Wp+2K4=;
        b=oTUps6QaT5DaCgqM96yOWwYWdOOKQniz2P/IImVomL8dN+DM5v8pPpcSTZkOlyL5HJ
         JqEu60Q0vCfLtHCpmNsu0dbcAZfQWqwk9F2HW4G2oNvtxkh7Z4N0LlKfPii9nAr+Ilnj
         cukOn7y/naJ333TU/4vHV9OGTP6k1lS72OF4mRCtEZOnu4iDRdmGtNOjhXAYnumLypMz
         htthOc/kIx9VG3aLChcr0SF+8GLo/SuRiJzSRJ19nkYthU/6EWKTGljJYRTLTffJ8Jfr
         6SBPHJVDvZ/3TZ/ZIsKEScv63ZYzpovGBOsuAXjIh8n4kv4MwKVJHjrL7Ls8pXsvx1h9
         brJA==
X-Gm-Message-State: AOAM531+p3yNuJWR5Kco/w+dyVIXaRYD0UZFB/Nn1z8Ge/XtqCkgV+Ss
        nUAieBgGHxXJzNMkOwtAhJmybXRERks12Q==
X-Google-Smtp-Source: ABdhPJyQRW8zrip1mxmyGbpSe0WVsRVkF0xHu2Ct2qipeLf2fE32nsIsruavzNm9Xn/hehFrAlC7hg==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr116570wru.242.1622379956808;
        Sun, 30 May 2021 06:05:56 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id z6sm12212141wml.29.2021.05.30.06.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 06:05:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu <adlternative@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
 <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
 <60b25ca7a01c2_265088208af@natae.notmuch>
 <CAOLTT8TEkrxAgHvkCVXZDQpn0xSQAe_y7uMF89Q4QWwVd7MDcA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2c28515c-89b1-79dd-35a2-492eac6b7347@gmail.com>
Date:   Sun, 30 May 2021 14:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOLTT8TEkrxAgHvkCVXZDQpn0xSQAe_y7uMF89Q4QWwVd7MDcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing

On 30/05/2021 07:29, ZheNing Hu wrote:
> Felipe Contreras <felipe.contreras@gmail.com> 于2021年5月29日周六 下午11:24写道：
>>
>> Phillip Wood wrote:
>>> On 27/05/2021 17:36, Felipe Contreras wrote:
>>>> ZheNing Hu via GitGitGadget wrote:
>>>> [...]
>>>>> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
>>>>
>>>> Why void *? We can delcare as char *.
>>>
>>> If you look at how this function is used you'll see
>>>        int (*cmp_fn)(const void *, const void *, size_t);
>>>        cmp_fn = s->sort_flags & REF_SORTING_ICASE
>>>                        ? memcasecmp : memcmp;
>>
>> Yeah, but why?
>>
>> We know we are comparing two char *. Presumably the reason is that
>> memcmp and memcasecmp use void *, but that could be remedied with:
>>
>>          cmp_fn = (int (*)(const char *, const char *, size_t))memcmp;
>>
>> That way the same cmp_fn could be used for the two cases.
>>
>> Either way I don't care particularly much. It also could be possible to
>> use void * and do the casting in tolower().
>>
> 
> I agree with Phillip's point of view here:
> It would be better for memcasecmp and memcmp to be consistent.
> 
>>>> (and I personally prefer lower to upper)
>>>
>>> We should be using tolower() as that is what POSIX specifies for
>>> strcasecmp() [1] which we are trying to emulate and there are cases[2] where
>>>        (tolower(c1) == tolower(c2)) != (toupper(c1) == toupper(c2))
>>
>> That's true.
>>
> 
> How about something like this:
> 
>   static int memcasecmp(const void *vs1, const void *vs2, size_t n)
>   {
> -       size_t i;
> -       const char *s1 = (const char *)vs1;
> -       const char *s2 = (const char *)vs2;
> -
> -       for (i = 0; i < n; i++) {
> -               unsigned char u1 = s1[i];
> -               unsigned char u2 = s2[i];
> -               int U1 = toupper (u1);
> -               int U2 = toupper (u2);
> -               int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
> -                       : U1 < U2 ? -1 : U2 < U1);
> +       const char *s1 = (const void *)vs1;
> +       const char *s2 = (const void *)vs2;

I think the new version looks fine apart from these casts. vs1 declared 
as 'const void *' in the function signature so this cast does not do 
anything. You could cast using (const char *) instead if you wanted but 
that is not required as you can assign a 'const void *' to 'const 
whatever *' without a cast.

Best Wishes

Phillip

> +       const char *end = s1 + n;
> +
> +       for (; s1 < end; s1++, s2++) {
> +               int diff = tolower(*s1) - tolower(*s2);
>                  if (diff)
>                          return diff;
>          }
> }
> 
>> --
>> Felipe Contreras
> 
> Thanks.
> --
> ZheNing Hu
> 

