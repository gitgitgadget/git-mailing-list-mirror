Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3ECC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 14:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiEPONv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244421AbiEPONu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 10:13:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F132066
        for <git@vger.kernel.org>; Mon, 16 May 2022 07:13:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a10so16002832ioe.9
        for <git@vger.kernel.org>; Mon, 16 May 2022 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=adzpEOP+zhx0JQ1PsRDpDaIov4MVuU95oJEleLba3eI=;
        b=a5XA0zg5GGT7qKltY3bZG+OWVcg4N/mCzIcbKvuHvsmJJaNsbTyIWLVyAMiEddxotW
         deo7vRC/iU9Gi5xMo0YjbBEarLfSUyjvUTgUILuv6t3W8AsiDlaJOpqoJCMH0jAdJkZc
         2o25ckD0GOjN4q48YQxssWEaZtnJCqU30k4eHMq1wpo9jKNEsv88uwrAMYi4Z/OnmjpF
         3/jH2z4wTwtFj6Rtlo2J2zsCnYKnJs+pYp4LonyaxRYztHK+lv7Z4d1YnA5gcTdnBV3J
         BUup11R1hEJgU8EXqbrKKEdnu7WNFPHCxvm72/ZYkvE/saQk9RghEqyDif0Z7fkyINcN
         gT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=adzpEOP+zhx0JQ1PsRDpDaIov4MVuU95oJEleLba3eI=;
        b=GK96SuBSAgKhjCw9Vgq1wKqogik/dXLXwga+zpuPJknse4VCepanSR7RytJsZ7ekpm
         9DfFyDKcu+cmzI3Bq9uXHFCb7HCFMJUwHEDrf3ijLjpAZi/RnywIKyMQWYNuzD6Cjid3
         Qkzhu5+t/mVdQnXd/Nvv33S0awUNwE9VznUUt4DJyoxGhdRK75VcUGUnN0cgYVBVLACZ
         vlzBREuFvVU9N+VQcNgmLxNrMH66lLCZCYHXG1+1zyRySDQTSi0bWP7MW2XC9EZjH29X
         ex+NOzMBD4U3DfYMz34HCWVHi4tl5R+pU/54/6SwPW6Hhzj+U4XYLhGK/nOtaebUq3We
         vZzg==
X-Gm-Message-State: AOAM530dUN+IgBENnTr1AYSViS7YgvDT78NcavUTlYA9ocJwYZ0LkmvS
        iYzTfjWlarZ54b/tbfPpEfoaXgzt3V6SyjotMBpB/817UDn6El2Tc8VaN+t4uFlNa+E66lkaXd6
        7duVGn33CfPRMZyPLKeXdGeAsvoj0MdWrNjJDu9Tq92lkPF2I+AUCI7q0ZdCc7WURINFlYA==
X-Google-Smtp-Source: ABdhPJzd4Hu6N5dYENXAdLZGGbgmnKoBXOR3lWUCS2dn5x9X6yRgiMv02bynaKY5WrdGMEi0VTCKUQ==
X-Received: by 2002:a05:6602:2c0d:b0:60f:6ac8:ad05 with SMTP id w13-20020a0566022c0d00b0060f6ac8ad05mr7912310iov.175.1652710427360;
        Mon, 16 May 2022 07:13:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a875:ee72:945f:af93? ([2600:1700:e72:80a0:a875:ee72:945f:af93])
        by smtp.gmail.com with ESMTPSA id g22-20020a02cd16000000b0032bdc27fbd0sm2566987jaq.150.2022.05.16.07.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 07:13:47 -0700 (PDT)
Message-ID: <daadac3e-d4c2-431f-a0bd-d8734d4424d8@github.com>
Date:   Mon, 16 May 2022 10:13:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Discussion] What is Git's Security Boundary?
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
In-Reply-To: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2022 1:00 PM, Derrick Stolee wrote:
> I've been having a few discussions internally and externally with folks
> about the 2.35.2 release and the safe.directory config value. After
> stumbling a little with a too-technical proposal, I (along with Taylor)
> figured out that I was jumping into "solutions" mode without first talking
> about the problem and agreeing on common language there.

> I'm hoping to start a conversation in this thread about "What is Git's
> security boundary?" so we can have an established base to work from for
> future security incidents or protections.

I'm back from a vacation, and haven't seen any response to this message.

I thought this would be an interesting topic that would create a lot of
valuable discussion, but that has not happened. I have a few ideas of why
that could be:

1. It's long, so readers put if off until it fell off the end of their
   inboxes.

2. The fixes for 2.36.1 have been taking priority.

3. There are no patches, so I should submit code if I want concrete
   feedback.

4. I'm so off base that it's not even worth replying.

Of course, it could be a combination of these or any number of other
things.

I'm sending this email as a hopeful ping that this topic could use some
feedback. I'm looking forward to your ideas.

Thanks,
-Stolee
