Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89DC433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 09:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFAA22283
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 09:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSIzv6Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392542AbgJTJNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390971AbgJTJNH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 05:13:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E4C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 02:13:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y12so1199115wrp.6
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EwMTs0j0aYdUsAbRAA7eBSLnjNSQp6bahfR28oa2SCs=;
        b=rSIzv6CeCtpRdbxvWHn55pXHX/4LQ5cOftrxdK0MC96s5zX9/e9C0Jsphi7p8lagRM
         G+m75pvP5eWmtVz/PK3gZWCWz8ISOrISsPkGph0AB/TQu8pRTWPaOjlhKSxf5EUgagKj
         /+qBQPYWS6eTNkemxFOfqEGc2n7ww6AJli0BBtV9zJc3a8UQJC5NpzJiFGcLWyASDBzR
         EjwEAwcKNiWxbG4dqE4qfh7tsBHveNy1PXbLdF+PG7Ax1WZ8FR4X5SP0PpkmKIfRI288
         eJbR1e02MTxo8YO4jHzDbMApZwrcCNVUEJVZhCzgJ3U9mWF0e4/mm+i60lBF3ljURO8y
         rTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EwMTs0j0aYdUsAbRAA7eBSLnjNSQp6bahfR28oa2SCs=;
        b=ZzKEY3C+NnJLqdPaH21qGD/frJMJJivwJtrNu/lCAZgBMGeI2AKZ6jLFGLV/YwwvB/
         ULY5irYnJEoMbu2Bii7PWU3Zavkbw7HeRsTn1hIp8aQR4kgsLXsadmAmFYJXrLv4k6h1
         fPZ5JDzJs4EAw7Im4OaA9ZuY7VTPwmkGqQmxV36SatdT2ZJ9GbawOU8KG3d6vZvp4TPa
         heN6MwAe43Y3plDDfOKwaJpfB0lQjJ6j4lZ9jv1wiEtGVux+Xx+ws+SaNiars9uEXNkZ
         /3hnVdsBmSHRT1wt++mxl8Vjgcrw1fJctuSVWLDh/0NHlINJC86QhUgt3kqHbEKNYzJ9
         nXwA==
X-Gm-Message-State: AOAM531V1wEOUqs780iv3QgoH0r7Vywylgr9AbkuruXtqOK/iGN6FQ1u
        cvQZ4CHF1WIsG34Vf51mDFB+lgINE5o=
X-Google-Smtp-Source: ABdhPJwSAFSIHJbR7Ltt5Gy0tT0gWJvF23IXpa8jV7kJ+EEbDlTfpLoyGtvzdIgzL9wzyaeIqLFTrg==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr2279363wrs.240.1603185186144;
        Tue, 20 Oct 2020 02:13:06 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id n83sm1048363wma.39.2020.10.20.02.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 02:13:05 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of
 subshells
To:     Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com>
 <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
 <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com>
 <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
 <20201019202456.GC42778@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6825abcc-b8e7-e539-6e8b-f46086a982d3@gmail.com>
Date:   Tue, 20 Oct 2020 10:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201019202456.GC42778@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 19/10/2020 21:25, Taylor Blau wrote:
> Hi Charvi,
> 
> On Mon, Oct 19, 2020 at 10:54:57PM +0530, Charvi Mendiratta wrote:
>> Yes, thanks a lot Philip I understood the reason. I will do the corrections in
>> commit message and commit body as below :
>> t7201: using 'git -C' to avoid subshell
>>
>> Using 'git-C' instead of 'cd' inside of subshell, to avoid the extra process
>> of starting a new subshell
>>
>> [...]
> 
> That said, a couple of notes:
> 
>    - Your subject message is good. It is concise, to-the-point, and
>      accurately describes the change. Good.
> 
>    - The body is similarly short, but could be rewritten to use the
>      imperative mood. But, it is redundant with the subject. The subject
>      says "we are using 'git -C' to avoid creating a subshell", and the
>      patch says exactly the same.
> 
> ...So, you can do one of two things. Either you can abbreviate the
> subject, adding the additional detail in the patch message, or you could
> leave the subject as-is and delete the patch message entirely.
> 
> Either would be fine with me, but certainly Phillip or others could
> chime in, too.

I'm happy with either, but I would suggest changing the subject so the 
description starts with 'use' rather than 'using'

Best Wishes

Phillip

> Thanks,
> Taylor
> 
