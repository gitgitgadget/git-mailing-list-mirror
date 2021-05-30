Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8FC47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A6D6023F
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE3ND7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhE3ND6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 09:03:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D9EC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:02:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so4993136wmq.0
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uH94hRo9Z1yfVLBpn4JUJAIAJImyaJTPPu2cdVZG/ks=;
        b=u3Fx8+6lYAjgQTfK1LrCrk1f4XhxeTG1e+iNKGqnRJRJIEg0Q2vyOyuyIYlv2DrGD3
         TgV5yz1fHNE915wUi1/3cLa58rKLuPMHXnry5RVSsvnbJCugZPBrYEiwHv6IuGXQeedJ
         qv3ZPV9fh5I7WF0koz4xVh4RTElTC78SC+GtrF8XpIHcig6ZC5s9QMo+NPeiJ5sXWYHb
         +66cFmgtu3U/0DAPAHLSo19N53UxqERv4/AOMMV+oMf65N3QMvAm4MoiP5iEZPie7kGb
         hoHAark8AHfUL7rtAJaezYz3CMWUmM8WKiyixjmK3nYgkLpsE7hilj0Gl5e3f8jd8Ubb
         xElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uH94hRo9Z1yfVLBpn4JUJAIAJImyaJTPPu2cdVZG/ks=;
        b=IW32s9WtcBtNT7yIdi4QRLx4AQcQh+OgnXPr7rZ5lHanQ3htY7HVxn039RPBQz3aRt
         R8BN+gP/Csopeflq84R5/QaO7uwK13gb4NTsOokjtK2puTQK5WqlSnEdwCN8BczkCjJo
         kdpR+XpV64sVDW00XD+Z9NengUM1bti+y8IQm3ahu4PefpJ3xieNyeCdlVr3yi4WEyEB
         U3z52VmWUVYE4/thKtM60P25vAuKNd2SwvVq2kPYqTHyiMAZ/W/SoXdM5oCVHIKZI2b5
         BwMgcldPXGHIqx8118ZUlznUpUFFJMPTsxZh03CODv0LfkQ9KrHdsvrxdeutXPqfiora
         Amdg==
X-Gm-Message-State: AOAM533CAFHEUymtnO/4tzWM7S1oJdX+qbKwCt0W8GglbEvx8c6mBo81
        9DlidVjTbr1F9xU61ORcm1E=
X-Google-Smtp-Source: ABdhPJwoVQay+asit6KTxMrSI5Jt2DFpdnbzfrY9+1q6fiqWjxB4LoLpt12U9aFFteZEkLxxYpGOOQ==
X-Received: by 2002:a1c:1dd5:: with SMTP id d204mr628406wmd.140.1622379739271;
        Sun, 30 May 2021 06:02:19 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id u17sm13662313wrt.61.2021.05.30.06.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 06:02:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
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
 <CAOLTT8QmByyue25YLTa2-=oQ00K5Cs_eoSD3_y6wRYYToa=oxQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c56734ba-c819-ccfe-f255-6cc890f6feef@gmail.com>
Date:   Sun, 30 May 2021 14:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOLTT8QmByyue25YLTa2-=oQ00K5Cs_eoSD3_y6wRYYToa=oxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing

On 30/05/2021 07:26, ZheNing Hu wrote:
> Phillip Wood <phillip.wood123@gmail.com> 于2021年5月29日周六 下午9:23写道：
>>
>> On 27/05/2021 17:36, Felipe Contreras wrote:
>>> ZheNing Hu via GitGitGadget wrote:
>>> [...]
>>> All we have to do is define the end point, and then we don't need i:
>>>
>>>        static int memcasecmp(const char *s1, const char *s2, size_t n)
>>>        {
>>>                const char *end = s1 + n;
>>>                for (; s1 < end; s1++, s2++) {
>>>                        int diff = tolower(*s1) - tolower(*s2);
>>>                        if (diff)
>>>                                return diff;
>>>                }
>>>                return 0;
>>>        }
>>>
>>> (and I personally prefer lower to upper)
>>
>> We should be using tolower() as that is what POSIX specifies for
>> strcasecmp() [1] which we are trying to emulate and there are cases[2] where
>>          (tolower(c1) == tolower(c2)) != (toupper(c1) == toupper(c2))
>>
> 
> I don’t know if we overlooked a fact: This static `memcasecmp()`
> is not a POSIX version. `tolower()` or `toupper()` are in git-compat-util.h,
> sane_istest('\0', GIT_ALPHA) == false . So in `sane_case()`, whatever
> `tolower()`, `toupper()`, they just return '\0' itself.

Well spotted, thanks for pointing that out. So memcasecmp() and 
strcasecmp() may give different results. I'm not sure if that matters - 
as I understand it the main use for the 'raw' atom is with `git cat-file 
--batch` which does not support sorting. Also although strcasecmp() uses 
the current locale it does a byte-by-byte comparison so it is 
effectively ASCII only for UTF-8 anyway.

Best Wishes

Phillip

>> Best Wishes
>>
>> Phillip
>>
>> [1] https://pubs.opengroup.org/onlinepubs/9699919799/
>> [2] https://en.wikipedia.org/wiki/Dotted_and_dotless_I#In_computing
>>
> 
> Thanks.
> --
> ZhenNing Hu
> 

