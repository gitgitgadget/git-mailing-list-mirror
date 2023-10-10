Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A14CD691F
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 10:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJJKGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 06:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJJKGD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 06:06:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3713D93
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 03:06:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50437c618b4so6855237e87.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696932359; x=1697537159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d5h4T0xg/LhKvDpi7qQbXU47bGwLvdcbK6AkPszbja0=;
        b=Ixxb7HVxzE7iA72LIFK3lVCH6seMWYt0Cv8TSAiKyK3RylDTK9hBpWR+vOZxPRIKY0
         3ME1Hiu7utnwEw42boHWu9pq7r2ujN1n8W3i5oaH6IAxAx1BzF6uoqyBr9LeiVN7Y6tn
         qPPcOakYSPSaYdXU0le1CIwp+6wDRDLgXSd1Uflz/xmK2yv0gmTuMYCXhQQE9wneIACl
         7xANxYS6rRTmjoU/CYR6h4yuopYE+I4kUqsVtTkN5qQKbV9HBXkO0whvEDcMnMBfyuDf
         YRkgWhsMnWKXmALLJ3VoHvoFLdC5Yug/vGb4Zb8gKF0mpvB25NxamMNg+khsO38H1Dau
         oeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696932359; x=1697537159;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5h4T0xg/LhKvDpi7qQbXU47bGwLvdcbK6AkPszbja0=;
        b=LlAvjr3bq2vR4htpQRqHcOPeT8cb/RgiFk8gwT1ZvCbOKEwq163P6V9NAprwf7NzUF
         VeQHl1UX6XDnrMRf26GYIK/8nIp/HxGuV/d33M3ZQedV02fh128FnoJpcKrzqOUWtJrd
         sDhfWQjIxTgGISkFTTvTuuq0UADQE2Quzw0q1DiAb5Ebu4Y8dPDk/DQC8lbFuVYbxK/c
         5U51qKip9IEuEASIjKx3TYeeJuriowlO7dN8mreHg7IkruoTEoPYlrhLdd4+j+R/Ara4
         fN+Mpq+CPX2cflE9+8XRoW0btNfhi685z5HY0azzLmPbqmo1xTsaa6gWdOQR1nLFGkgf
         0z7A==
X-Gm-Message-State: AOJu0Yx5/cbcIIAriDBdktiNP08UxssEcF9LEY9HlL1tHO8C/YHSOoDB
        TCHGz8wyOy3uULeax4V7yIRLTZ4ZJEw=
X-Google-Smtp-Source: AGHT+IGC4NI7QO2y4LWbA5KKAzYw7FPq4yuYE9TU1bTs6QU8y4zP95XHlizFFH3FxJFJIWAym0ayxA==
X-Received: by 2002:a05:6512:250c:b0:503:1b83:e352 with SMTP id be12-20020a056512250c00b005031b83e352mr18341473lfb.52.1696932359045;
        Tue, 10 Oct 2023 03:05:59 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id e26-20020adfa45a000000b003143c9beeaesm206198wra.44.2023.10.10.03.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 03:05:58 -0700 (PDT)
Message-ID: <4670774d-a899-492c-9b36-98ee243c8d4d@gmail.com>
Date:   Tue, 10 Oct 2023 11:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/4] Preliminary patches before git-std-lib
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230627195251.1973421-1-calvinwan@google.com>
 <cover.1696021277.git.jonathantanmy@google.com>
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

On 29/09/2023 22:20, Jonathan Tan wrote:
> Calvin will be away for a few weeks and I'll be handling the git-std-lib
> effort in the meantime. My goals will be:
> 
> - Get the preliminary patches in Calvin's patch set (patches 1-4) merged
> first.
> 
> - Updating patches 5-6 based on reviewer feedback (including my
> feedback). I have several aims including reducing or eliminating the
> need for the GIT_STD_LIB preprocessor variable, and making stubs a test-
> only concern (I think Phillip has some similar ideas [1] but I haven't
> looked at their repo on GitHub yet).

It sounds like we're thinking along similar lines, do feel free get in 
touch on or off the list if you want to ask anything about those patches 
I pushed to github.

> [1] https://lore.kernel.org/git/98f3edcf-7f37-45ff-abd2-c0038d4e0589@gmail.com/
> 
> This patch set is in service of the first goal. Because the libification
> patches are no longer included in this patch set, I have rewritten the
> commit messages to justify the patches in terms of code organization.
> There are no changes in the code itself. Also, I have retained Calvin's
> name as the author.

I agree it makes sense to get the preliminary patches merged on their 
own. I think the argument that they reduce the scope of includes is a 
reasonable justification on its own. I've left a couple of comments but 
they're looking pretty good.

Best Wishes

Phillip
