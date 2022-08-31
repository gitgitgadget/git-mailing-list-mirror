Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DFCECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 09:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiHaJ0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiHaJ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 05:26:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C080F4E
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:26:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k17so7035491wmr.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=R4fhEXXWrp5f5DEtnTqpReFoAk9uWOCjfjnSqjJZR0k=;
        b=hoXbrNQYdenNoSsx8iJTFjISs6+5KhXpoy+wSN3X/YJNPwOJdVgN+Bv+VSGtGDLK64
         G+oLu2XJasrZjzkFHyT4xvKecgoDeWTldHGo+j2hkFIsnaD1OJii8hquOwdMHsCyvFRi
         EjX6bs9w+ibRPtd0OnGz9k3UoAWi24QWcOhCtPBkrjf7bXEalLOYSE/c5P63WOWGh45p
         wUvVxno1zkq7SncZekIbtAT14rQZn8VCWquPkMjVKZKhUGUZorcaOb8rz+Vmh3bDHpT5
         bWj2mZZz2Rb903bm1SsXIVnR3ohuRbjZnao5jKzFBty25MhTzrJ8H3fJYRO97zlI1VWB
         YdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=R4fhEXXWrp5f5DEtnTqpReFoAk9uWOCjfjnSqjJZR0k=;
        b=B9ZJiQDlzFU8sNpUcRb8V+cHAuYbTqn0pKbT4bYY46XxqdUO549ms9KpepHm/zZIAO
         fu8eYU4RTqXbDXN9jW7S4xWYk36Ipd2o2cJ4aNXSiTBO7ZJZ87/r0hP2HNtIC1qEvGnK
         ti6B1kncsoI5NQ4ldjMo5L92kw27wES5eIp5RK1lAIVkn0BINAvwK1gCEhhhPnsUpsHk
         8EV/xGRJBUg7yvgOfommzc2t6SSJSWMpCaf1FU9ZyF+o2t0jvn8PGyPl2rX6U8F1ACPK
         dtFoAgqCp8qju+0J+UH7zQcBfeWXa3semaq5YuwyHnZSmPL3a0afG6MjPqYSQu68Cyq5
         8x1g==
X-Gm-Message-State: ACgBeo2xqBu0B4NatKABVNMEgW38FWmPbQL4Rd+l3MBZQsI86+pRNk8G
        q7Q+UNSQBwqX5njr7d9PvRg=
X-Google-Smtp-Source: AA6agR4W4PRicp+QiM0E1L49M6J8B4yirK/+02maRHc30N2LextCyWocg3f8PxJ/KXf4qExmPngDrg==
X-Received: by 2002:a05:600c:19c6:b0:3a5:ffb3:d527 with SMTP id u6-20020a05600c19c600b003a5ffb3d527mr1370047wmq.106.1661937979588;
        Wed, 31 Aug 2022 02:26:19 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003a5ea1cc63csm1556382wmo.39.2022.08.31.02.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:26:19 -0700 (PDT)
Message-ID: <742b42af-a298-219d-a35f-1fa8ba985aed@gmail.com>
Date:   Wed, 31 Aug 2022 10:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/5] t3701: redefine what is "bogus" output of a diff
 filter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
 <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com>
 <9261de42-3287-6ccb-6cf5-21c0a8ee1f17@gmail.com> <xmqq7d2pifby.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq7d2pifby.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 30/08/2022 22:36, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> The existing test deletes the first line of the diff[1] - so it is
>> removing the "diff --git ..." header not the hunk header. This patch
>> changes the filter to delete everything except the diff header which
>> seems like a less realistic test.
> 
> Is it that all it cares about is that the output has the same number
> of lines as the input?  If so, I agree that it is much less realistic,
> but it may not matter in practice.  Even an "exit 0" might do ;-)

Yes I think it only cares that there are the same number of lines which 
begs the question "why are we changing this test in the first place?". 
The commit message talks about the being unable to parse the hunk header 
but that's only true because we would be looking in the wrong place for 
it - the output does in fact contain a valid hunk header. With this 
change there is no hunk header in the filtered output at all. In 
practice if the number of lines differs it is normally because the 
filter messed with the diff header and removed some lines from it which 
is what the existing test simulates.

I'm struggling to understand the need for this change from the 
explanation in the commit message as it seems to me  to assume the line 
being deleted is the hunk header when in fact it is deleting the diff 
header.

Best Wishes

Phillip

> I may be quite off the mark on this one, though.
> 
