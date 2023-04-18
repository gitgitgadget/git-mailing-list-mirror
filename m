Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F07DC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDROYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDROYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:24:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D59C
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:24:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fe82d8bf5so146613597b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681827869; x=1684419869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5BXkkC/JioK+p/1h7MPybdAXM/CGE0ua4w5vQabVvo=;
        b=EUA7u5T1ugPhy+SyT/rBxxT7KsFjkI+BxwCvhOGP5otrIFoWcAL0Mo+hNC745fYyY4
         DAoTZJewIaG1ZJ9XuplFvDo3NjQgfsC9IPUOkkW3Am5JU3C9obcn2h3FXpeYpxnXvpW4
         //bxoHA+6a4WBkGRF4EjJJv+O/DeGHozElOaDvLRCPdyoqM09yxIz4oYcZOZ1Yie5N2V
         wx5FcvBgn6eCr9bzY6UOGvxDjybNUwy4B+tiMEq1Q9gsCASY6DGwhXkA8Fo3X4necqJV
         Ya7Y1qhu+yySIRAVodnRSoyRzhHa2G2P1aBVdMThmxkppKYIHJZycqDThN4aB9qr04ls
         L8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827869; x=1684419869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5BXkkC/JioK+p/1h7MPybdAXM/CGE0ua4w5vQabVvo=;
        b=CO2LAAJC0C5zKpUzriE338p2CJhHmC1k1wOOP0ZlERSUowrXPyS6ICSy1pobSYzUWP
         0fSAg31WkrrZo5ln8qzZRWe1wI8/4BQCyh8Hq5ZKjp37udEsU5cifuUqu9797R5fWI2G
         koHiiZX/JOfQcHRl0H0KcBTUH3YfK4/tQeYsJA208oyhUexagmW+WK3YRbkAiiUTAfOf
         t0755ehF/dviFQldFnUr1UVKjuPcbmeHfPGXHKXWwg0IM86A7c9Wn6LRApXaok7S02Af
         0PzmFqmHlW5D+ZQehkTnT/S50vccRyvGi2hLfRUSSo57B2gB2r5ZEsiLOBqoe74XRZgn
         mVyw==
X-Gm-Message-State: AAQBX9fQAg0YWGQF+m3qAm9ES/NivVu5VhMLBCuBnNhViPBSULBidjQU
        eD8sFR6vkVzlL48V04DEsTtR
X-Google-Smtp-Source: AKy350Zg90fTxxsbREeypAYvhHNXNdEaX/VxCKTrzrF6rAK7Yur6Xww4juhEmAt7NdDfQT+y5jS31w==
X-Received: by 2002:a0d:ed06:0:b0:541:7e07:ed65 with SMTP id w6-20020a0ded06000000b005417e07ed65mr53993ywe.5.1681827869461;
        Tue, 18 Apr 2023 07:24:29 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d63-20020a814f42000000b0054f8b7b8514sm3860053ywb.128.2023.04.18.07.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:24:29 -0700 (PDT)
Message-ID: <c787f354-1cd8-1f27-0559-b0603c259d22@github.com>
Date:   Tue, 18 Apr 2023 10:24:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
 <xmqqwn2ai291.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwn2ai291.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/2023 6:15 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +corrupt_rev_and_verify () {
>> +	(
>> +		pos="$1" &&
>> +...
>> +		grep "$error" err
>> +	)
>> +}
> 
> Curious.  Would it work equally well to write
> 
> 	corrupt_rev_and_verify () (
> 		pos="$1" &&
> 		...
> 		grep "$error" err
> 	)
> 
> without an extra level of indentation?

I've never seen that replacement (and it only exists in our tree
in t4018/bash-arithmetic-function and t4018/bash-subshell-function)
but it works and looks nicer.

Thanks,
-Stolee
