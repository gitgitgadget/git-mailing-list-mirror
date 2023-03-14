Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF75C05027
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 20:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCNUoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCNUoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 16:44:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024314498
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 13:44:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so15629801edd.5
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678826644;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hRnCQ73qnqFK1Zmfi82I1LrfC3kojrmQDFczCq4ck3o=;
        b=YVDVB2aP4zbriSnPZQg2TVzXatUZNtBij0htPQc4pXA/YbmG4kpOnwG2J5QrZtafyg
         Fg1Lxx5eXTHZIEUb7yA8ognE6nrDRzjqx7arofTYKvr6fCHfJ5GMoJM15Co41EkJHW7I
         vTfWuTkiFARMajcDbKjw+pgwj2aWwXtkwX9o3hGu0c2gLlGJrfK00i7Jyu+YWvCShztr
         JUEl0UVcrdk1Z1gTlAY6xEMlabY63vfY4GLVZlc26sEPYXUXvMA2IQdYyTlNeq7zGYON
         /JUmS0qyYHB3KsZeOQGk+q5+pgRQlvy5zpvH9xeMgFQ5JLwu4b2nxnAHjwDjD+z4+64H
         VArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826644;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRnCQ73qnqFK1Zmfi82I1LrfC3kojrmQDFczCq4ck3o=;
        b=3UOjPc1B5Dn2RTUBY/KPmhOha3Yt2STSc56lfvi0pSb9N3t955UhTOuGUYuu0Vp79T
         CHO3BWqO0l84bc9q3jNDoaa7Sx9Ato9MvYirD1bKw2fBJncf+Y03V6+rQCfLMBC515Uy
         pjUFFWelmiJ+sfHQzTKWFrDpCXOe4IKgUCKib8St4QBvfKzYW4AbLMS8FabJvpLLzT/q
         cN1Le1RPNQGlGfGbNayebKvU/b9i20ssrK3voAjV7QtQy3vRxpFT4Hi+m56oD8HYGTzT
         7D7Ws2rCIbd4p9EPwVnPpGRIW8KHhQGHL6eyWf6Wcw/Tx4elTPF8x5Pxs3+2UOywNqie
         jKgA==
X-Gm-Message-State: AO0yUKWWVHt/0bIKgC0RdKKh/2MXSu7vW8E295JWeUsmJq00dX44odTY
        rT1ipLXI9jjeTJyg6W55k8s=
X-Google-Smtp-Source: AK7set+FNW2FJJe0W3k5vPXHJ1OTTHiqHjltKo7QzikwgewCNQyoQK7LuvWBC5YR5/11s6rWHd7wGA==
X-Received: by 2002:a17:906:1b09:b0:88e:e498:109b with SMTP id o9-20020a1709061b0900b0088ee498109bmr3765429ejg.5.1678826643746;
        Tue, 14 Mar 2023 13:44:03 -0700 (PDT)
Received: from [10.10.18.218] ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id qk19-20020a1709077f9300b0092c8da1e5ecsm1255004ejc.21.2023.03.14.13.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 13:44:03 -0700 (PDT)
Message-ID: <ed09dca5-0885-0ea7-7bbb-b4cc09f0eefa@gmail.com>
Date:   Tue, 14 Mar 2023 21:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v1 0/7] t: fix unused files, part 1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <xmqq7cvks28n.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7cvks28n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2023 23:41, Junio C Hamano wrote:
> 
> I think it is better not to insist that a failing 'mktree' is
> silent, and I think the filename "unchanged" is understandable and
> is unfair to call it "misleading" (but the patch itself to remove
> the line that creates the unused file makes perfect sense).  Other
> than these two small nits, I found everything else in the series
> good changes.
> 
> Thanks for a pleasant read.

Thank you for review.  I have limited bandwidth this week, but I'll
try to send a v2 incorporating this feedback on the weekend.
