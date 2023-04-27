Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F4C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbjD0Lzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjD0Lza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:55:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EFB2698
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:55:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so7565603f8f.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682596528; x=1685188528;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hz4WWFfSch1o2c+95YQrw9krtdofKx6uSDezy1HVUdg=;
        b=qQM/paWdfLMhvnRUOmYMZcJsa3cjINQUVDZArn6HLaLs1iWYV0z8UtsEpNLhbk2rf/
         O1vW+AkbUXzV1tpN2p/Rqc7eiZ87bo6d0qweI/3hBY+qgauWzmE1Pt63f9+3pL9KDPIY
         csy/Mi+FMvC5j3sgiyJyMT7JBd+t4cF+46u69NptmQ2/3tAXPsV9zXHWUw9weD+sNnmz
         lhgpELVmqhB26qqZToonQzqdw6+pOztINBAtfw0TYAhlmN4/EomOcaZHOABPZjfLvPZu
         sUb5ntZJXW7HbthmXuogzeP9/akaM23Uyw2ZHB99Df6J2CyFEpYMHWCPWedEk9gvig49
         8yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682596528; x=1685188528;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz4WWFfSch1o2c+95YQrw9krtdofKx6uSDezy1HVUdg=;
        b=LCQZ0APt9FqHi8J3cAbowZ832YgFZgrSxxAOqr980AkfoFHmgdzFB1cYR7QNy6Jku5
         lARZ80RZOzdk/qv4u3vkBTii+mawSrXnzolHEadn5HIMogkqrzmE2vc7w7u1Z+Nd0nmy
         nf9IU1JM3+1y5OaiCpyyTvebWzUVK9X6tB4K7HF6Ah8ItXbQWZfiEYM4g9cH1gp63JGb
         BGonHGsCbyClEV+dRmRKxTTJnh03AOtXjgyhiwRKyyOOwedMd8TdFkw2xzBKxXJnxVsT
         NcDC5IVMaCDrtFFsTs/afheEFNwkz+1JCOWS+xqfnFbZRJ9CQy6hA9AJfWgWMmusMlht
         Iesw==
X-Gm-Message-State: AC+VfDzhbDiNJR53m+LTxJ6SchMCvGHcOQaDofByvfIKs2w/wxIVSuW6
        Y2w/SqKvyVhI1yXZBp/LAeQ=
X-Google-Smtp-Source: ACHHUZ5oRTKyE2CGzyvc66RsRmjSReaKNU/WLxUTYBMCQrWOWLbCaLrbGvDj8z050qGr4+2KyZNnkw==
X-Received: by 2002:adf:e6d0:0:b0:2f8:ba03:6dec with SMTP id y16-20020adfe6d0000000b002f8ba036decmr1320027wrm.20.1682596528175;
        Thu, 27 Apr 2023 04:55:28 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm24769677wmq.38.2023.04.27.04.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 04:55:27 -0700 (PDT)
Message-ID: <ad4f927f-607a-5391-ce50-a342d09934d6@gmail.com>
Date:   Thu, 27 Apr 2023 12:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
 <20230427081715.GA1478467@coredump.intra.peff.net>
 <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com>
In-Reply-To: <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2023 11:11, Phillip Wood wrote:

>> +    test_commit 1234567890 &&
>> +    git cat-file commit HEAD >commit.orig &&
>> +    sed "s/>.*/>    /" <commit.orig >commit.munge &&
>> +    ws_commit=$(git hash-object --literally -w -t commit 
>> commit.munge) &&
>> +    sed "s/>.*/>   $(printf "\013")/" <commit.orig >commit.munge &&
> 
> Does the shell eat the '\v' when it trims trailing whitespace from the 
> command substitution (I can't remember the rules off the top of my head)?

Having looked it up, the shell trims newlines but not other whitespace 
so this should be fine.

Best Wishes

Phillip

> 
> Best Wishes
> 
> Phillip
> 
>> +    vt_commit=$(git hash-object --literally -w -t commit commit.munge)
>> +'
>> +
>> +test_expect_success '--until treats whitespace date as sentinel' '
>> +    echo $ws_commit >expect &&
>> +    git rev-list --until=1980-01-01 $ws_commit >actual &&
>> +    test_cmp expect actual &&
>> +
>> +    echo $vt_commit >expect &&
>> +    git rev-list --until=1980-01-01 $vt_commit >actual &&
>> +    test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'pretty-printer handles whitespace date' '
>> +    # as with the %ad test above, we will show these as the empty 
>> string,
>> +    # not the 1970 epoch date. This is intentional; see 7d9a281941 
>> (t4212:
>> +    # test bogus timestamps with git-log, 2014-02-24) for more 
>> discussion.
>> +    echo : >expect &&
>> +    git log -1 --format="%at:%ct" $ws_commit >actual &&
>> +    test_cmp expect actual &&
>> +    git log -1 --format="%at:%ct" $vt_commit >actual &&
>> +    test_cmp expect actual
>> +'
>> +
>>   test_done
> 

