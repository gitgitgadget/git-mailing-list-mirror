Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA4C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCSGRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSGRH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:17:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89324700
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:17:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so9306161pjz.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679206626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VlCrwq4xV92ZYKVZkymtxvrUiqVFa+Sn+PSN5NLWss=;
        b=SKmcBbluoV/JcoBa3NAejsxB82vqlFC7MRuybXywbE87prftKfnla8duqIbug/rO+B
         2hYz7k4crvQ9APP8KfGTuDnpqUavFHpx7gfGjQLeM4xRlS7SvX3pRiSJnDhJT/QS6pWc
         4OvKgxVOhm3r3zmF9+De0i59u7S5LpReK1DX8/yFag3oNElV4tcRHuXkfRYz41BS2Pjb
         evc5SeUOciuxj3iW0n85OYRGiX19xOuFnBXODQALSqy/+0cA/Er1Z0z1L6O1wy7JVKgV
         aUjSA/RbnMi8fguasAHzBqm+7mYGvp8bubGgE51RusuZ+oCxvMm7JZ4s8dz+I6Bunc3V
         cZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679206626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VlCrwq4xV92ZYKVZkymtxvrUiqVFa+Sn+PSN5NLWss=;
        b=FTpqGbRIfur57cT8IjGFdlB/zTkvnBVF75L7SZc0nlp3yqjCoSxMkh7hNRepN8/QE9
         rvseFtwcJtMDQeJdoo2/XLPasM7YWpzNbo2xRCLYavzy0h4ug/qu22L7WvwVjqKccLUo
         OI1flUhVy9uRB+gGQXDa1ih7Gv9yQEZmjiU4wigVfLzxNXpbsBNl1Im0t3u2uYgptfLu
         UlLeYus/vc0MK2mnpAFY2E4UQPHXTnH/Hlcy2yG6ybiBReXo1BnjZ0/jNFXCMNSNvxoi
         SX8JzpXb5cpUkQLQohJzispJlB7jIFm4/O7OL9PjB0L9Q0SWgUjhQWk1LqTSBKs1Nu8s
         OVWw==
X-Gm-Message-State: AO0yUKXC/p2krZnwyupsRjQLb6wKHIokL26LnJlEWTfGyko5ybSg0sfI
        6TP400f/5QPUnKMbB5/U8Ac=
X-Google-Smtp-Source: AK7set+o2Ho8K+0UqouXXH9Cspk+/gdZDfu7NGIaRiyIU9nudXjncz7nLCvMrJwqEMrLvZxlOxb1BQ==
X-Received: by 2002:a17:902:e88b:b0:1a1:595a:8e25 with SMTP id w11-20020a170902e88b00b001a1595a8e25mr17535750plg.20.1679206626021;
        Sat, 18 Mar 2023 23:17:06 -0700 (PDT)
Received: from [192.168.65.128] ([49.37.150.136])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0019b089bc8d7sm4216523pll.78.2023.03.18.23.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 23:17:05 -0700 (PDT)
Message-ID: <92c321c4-7968-e993-4157-f0d06edb9283@gmail.com>
Date:   Sun, 19 Mar 2023 11:47:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] index-pack: remove fetch_if_missing=0
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
References: <20230313181518.6322-1-five231003@gmail.com>
 <20230317175601.4250-1-five231003@gmail.com> <xmqqlejvf0j6.fsf@gitster.g>
From:   Kousik Sanagavarapu <five231003@gmail.com>
In-Reply-To: <xmqqlejvf0j6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/03/23 04:28, Junio C Hamano wrote:

> Kousik Sanagavarapu <five231003@gmail.com> writes:
>
>> A collision test is triggered in sha1_object(), whenever there is an
>> object file in our repo. If our repo is a partial clone, then checking
>> for this file existence does not lazy-fetch the object (if the object
>> is missing and if there are one or more promisor remotes) when
>> fetch_if_missing is set to 0.
>>
>> Though this global lets us control lazy-fetching in regions of code,
>> it prevents multi-threading [1].
> Sorry, but I really do not see the point.
>
> We already have read_lock/read_unlock to prevent multiple threads
> from stomping on the in-core object database structure either way.
>
> If somebody needs to dynamically change the value of fetch_if_missing
> after the program started and spawned multiple threads, yes, the update
> to the single variable would become a problem point in multi-threading.
>
> But that is not what we are doing, and you already discovered that
> this was done as "a temporary measure" to selectively let some
> programs use 0 and others use 1 for lazy-fetching, at a very early
> part of these programs.
>
> If we are to reduce this global, perhaps we should teach more
> codepaths not to lazy fetch by default.  Once everybody gets
> converted like so, then index-pack can lose the assignment of 0 to
> the variable, as the global variable would be initialized to 0 and
> nobody will flip it to 1 to "temporarily opt into lazy fetching by
> default until it gets fixed".  At that point, we can lose the global
> variable.
>
> So "we want to reduce the use of this global" is not a good reason
> to do this change at all, without a convincing argument that says
> why everybody should do automatic lazy fetching of objects.  If
> everybody should avoid doing automatic lazy fetching, a good first
> step to reduce the use of this global is not to touch index-pack
> that has already been fixed not to do so, no?

Thanks for the review.


Also, thanks for pointing out the direction of work in this area.

Really helpful.

