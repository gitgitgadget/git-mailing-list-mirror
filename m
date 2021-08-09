Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFBC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA90F610A4
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 10:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhHIKvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhHIKu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 06:50:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142C2C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 03:50:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f3so5280976plg.3
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HEtwwIA9AlxsdApRGa3UTH8dNoZPprblQJWAEk5mrD0=;
        b=UOYsUsku/uYUtEvvwVN51cYHVjDX+jU1vUAMxLoqeXS4GxQGCUv5aVckMJDvOxcSEs
         1epXsuhgSJOmPDpibTdFHZtMLRub5wRH43TkG+PJuxTAp5uhqNfBkARkChE7ipHPx5h/
         f/bGX2HevPwnvoEsJlpFDJw72IOuXlLv9nZ5Y4TO1xVcyaR1N+kH7fGBc0Ej04YDj238
         +spZA9x7P7VaCLJ1AxCrtmQeXYEXEU5OxfzXMUxv095vSyJl1PbgTVwKEbb7sVy2FfKj
         4cRDZv+nW7FVPawezC34XE2/43IUuvI81drC5JNsQtY4YZZxRBWPFqEx+PHD2bcw2yMF
         JplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HEtwwIA9AlxsdApRGa3UTH8dNoZPprblQJWAEk5mrD0=;
        b=SL69yltyTTTKQzGC5yiuzfH6g/VdABpHpo4hRzp+SiiVNKJKDPikH9AAWVXA6zug04
         Nds1YkAghmm4f93fD+QYnjoR6XEwtci1nVaJpihKCgyv3Esh8R64rjdtVFCutXXJGtyA
         4jRqGfgsEnoDwpHtcUWp/vU3qDw/DwztuwsvXHxt0N7KQLZH2yxyVAUmqDchyI/q5EOC
         jXh0qWtcfxF8q+WuMvmP8tFSt/2FKItbNDitNIAdfYTGsR7B9lTuLONVIB1VvpjH2baj
         F3XTHSRvuamMJz+vGOqVjYbYS4OhMhx5Q9QdFx5m2BFnBjurgna3M8+9rGNx5atjiuvK
         QO9A==
X-Gm-Message-State: AOAM530orrC3Y+dkfVnOd2Bk+CDx6DfBLN3NeLqSYR3EjMa0U0fgxF30
        z/8gurQ7RKi7MiEp6NWnjRycP15Wh8s=
X-Google-Smtp-Source: ABdhPJxTHBguQOxvON7TYFKT9BlsGmLujvH/hGsdkXWsWM4cvV4UkZx0dKo+viquSEsEnGgbTqFUSg==
X-Received: by 2002:aa7:9117:0:b029:35c:4791:ff52 with SMTP id 23-20020aa791170000b029035c4791ff52mr23059674pfh.76.1628506238558;
        Mon, 09 Aug 2021 03:50:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id j187sm19552980pfb.132.2021.08.09.03.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 03:50:38 -0700 (PDT)
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     e@80x24.org
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c903b477-8438-7c9a-bbbc-ec87d1b05451@gmail.com>
Date:   Mon, 9 Aug 2021 17:50:35 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809013833.58110-4-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/21 08.38, Carlo Marcelo Arenas Belón wrote:
> similar to the recently added sparse task, it is nice to know as early
> as possible.
> 
> add a dockerized build using fedora (that usually has the latest gcc)
> to be ahead of the curve and avoid older ISO C issues at the same time.
> 

But from GCC manual [1], the default C dialect used is `-std=gnu17`, 
while `-pedantic` is only relevant for ISO C (such as `-std=c17`).

And why not using `-pedantic-errors`, so that non-ISO features are 
treated as errors?

Newcomers contributing to Git may think that based on what our CI do, 
they can submit patches with C17 features (perhaps with GNU extensions). 
Then at some time there is casual users that complain that Git doesn't 
compile with their default older compiler (maybe they run LTS 
distributions or pre-C17 compiler). Thus we want Git to be compiled 
successfully using wide variety of compilers (maybe as old as GCC 4.8).

[1]: https://gcc.gnu.org/onlinedocs/gcc-11.2.0/gcc/Standards.html#Standards

-- 
An old man doll... just what I always wanted! - Clara
