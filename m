Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835CCC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbhLBU7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 15:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhLBU7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 15:59:53 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8E5C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 12:56:29 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso1328010ota.5
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eLKL3f2LCfogr2FQ7mjuZOEDe/Byl5gyBKgCyj8Jy8I=;
        b=IjBpMghhEjFvdrsrjKv5xyRQ2LAxA1yW7x2/XTu5EyF8aH0rhB4MTEg1Kpmym3nDtj
         0FDsYQn05jqdEAuA88ybvnRSRiZnZVG9wMJulbXZF2fWIdtJ8KFR5/B/H3nGFaeUQuca
         34ud+TCgDSfQuVcfARy32odCEC0U5N/2KFUL+ZcgNib6BnArdmliJ5/UrfjZWDECq7G1
         1edQHYhBQ9R6CQO1l40qbjDzJQ2p0x21kIulCY71p6MZOF5b4gXln1B0HJl0Sds6tqPj
         jwnR8da+ZfOxuTFpILDKd4a6TMX6jqlrX+If4mo7u9j5C3tryUKC9BoyMHCHfBd2Tfv8
         26vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eLKL3f2LCfogr2FQ7mjuZOEDe/Byl5gyBKgCyj8Jy8I=;
        b=2DtXNVW+7xZGg2DQaGCPfecQRy6Bxl6QVHyNonS8OUd60xnULoNevjEW8auMX7JnuG
         13LUav0DflwArSYSJqLP+wipkeKVgXl/XeKBdEZZJVOJlX99NDXHbJdKvbE1GecRBUFG
         b3t1BwO+twmLKa0OhRMxOW5mmXRy6kNYy5iWflaP+j/x4gUrZ/3AAO43ljcSnPwO3QC7
         D3DHKnNQVXyi2b4lFu9B4k2+M3USMF/111lB0U8ZB5+LfmPiQKZw4F7nf0QvRVSYzuFO
         bnBXAWh9Zac4WmigHwwUUTK2Giuql0Iot36lYnVaKge3BrxKukYxx65LEFre48CWA+Xx
         99+w==
X-Gm-Message-State: AOAM532atCwCwZ1BPfQwzJAf+PIuV7M186PtPB+aMLGMwbyUeXmhPQl+
        3OO1YM9wFtWspt1tEeHy+Lg=
X-Google-Smtp-Source: ABdhPJxCVovI2EW9hgNzwBETgV8XDOJT7HFdjlmRQ2PuXFsoRzVZF72m1x0UxTrKAylOZN8vVxgZhA==
X-Received: by 2002:a05:6830:118a:: with SMTP id u10mr12909761otq.194.1638478589111;
        Thu, 02 Dec 2021 12:56:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a483:be4f:55c1:3cc8? ([2600:1700:e72:80a0:a483:be4f:55c1:3cc8])
        by smtp.gmail.com with ESMTPSA id h26sm203068oor.17.2021.12.02.12.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 12:56:28 -0800 (PST)
Message-ID: <cbcdcad7-16c5-b14d-5edc-5c91909b13e2@gmail.com>
Date:   Thu, 2 Dec 2021 15:56:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/3] Fix LLP64 `(size_t)1` compatibility VS C4334
 warnings
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <20211201002902.1042-1-philipoakley@iee.email>
 <xmqq5ys8ym8s.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5ys8ym8s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2021 5:49 PM, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
> 
>> Since V1 (gitster/po/size-t-for-vs)
>> https://lore.kernel.org/git/20211126113614.709-1-philipoakley@iee.email/
>>
>> Former patch 1/4 was dropped as it was already in Junio's tree.
>>
>> Patch 1/3 corrects my spelling mistake.
>>
>> Patch 2/3 has added extra spacing around the << operator as suggested by
>> Stollee[1].
>>
>> Patch 3/3 removes the superceded commit message comment regarding
>> backporting the patch onto maint.
>>
>> The Visual Studio MSVC compilation reports a number of C4334 "was 64-bit
>> shift intended" size mismatch warnings. In most of these cases a size_t
>> is ANDed (masked) with a bit shift of 1, or 1U. On LLP64 systems the unity
>> value is 32 bits, while size_t is 64 bits. 
>>
>> The fix is to upcast the unity value to size_t.   
>>
>> The first [dropped] patch had been reported [2] by René Scharfe as an extra patch
>> to the rs/mergesort series.
>>
>> These fixes clear all the current C4334 warnings.
> 
> Thanks.  Will queue; let's have it in 'next'.

I agree. This version is excellent.

-Stolee
 
