Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A344C1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 14:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbeDWOJ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 10:09:26 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38177 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeDWOJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 10:09:21 -0400
Received: by mail-qt0-f177.google.com with SMTP id z23-v6so17779453qti.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ykekuDPy2Vw/zZ5PHoLMbFazgS3e3i9yFpF2toMf4/A=;
        b=TqnHhqT2hufGOGs/MpYps7ziKHGiM/X94nyJEWSgSguBUdok/LgQsItd4X9s0hOrW5
         lIbaud7TrtPMYOd07PjUGVXsjc37onohwDwjHht/r4u/USJeE8X/cjU4qlRaF1JJ8aKD
         fa5xHVLKKLpoxhDXVRj00ff8yRKFK6n0ZIOceUFCDAAS0Q92He3DTqh8DuUGy+FcmPLR
         DMJl03GP7ZOrBiWhQDdmKDNCNfoW1sQ9TLaMjYXw4XQVkVMwF/2DGpcIHK2aUX0Iucm+
         KXtO0IMpetkvefbfmh8gk9t1RQuvotvJPY5dlc/CjRoNNrp2CbG1WySSOOK/IdSnLnOQ
         8b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ykekuDPy2Vw/zZ5PHoLMbFazgS3e3i9yFpF2toMf4/A=;
        b=J5SN/hXbNA1Zvxy5x/S6j9xXz2fcmU/PZSpmjTRhuDcr5/TzWltlRN2sDqv0+DtHb5
         ZVrOxSsKlS2pAAKD4XNTorDoWGbe0g5aft0mgokZl8OuLL1gMfb4pnN6l5WSnaIa6IDl
         Dvy6R2uMhTlKMIqtg1kk56J11oID06yME0XDZyY2tWxRmtqD/uPXCpCxCv60JGLd2gR+
         Civ/a2ozsM45QNQ2sOn8ARiYC3iroZEc1Bjav3PyR5IQT0eSv7W70h1yMHcVYNsbZAQZ
         9NE533OWE1A27N6RwDO7if4dwZXtDvZyLUAbTSHK+RwkhRmIetH89KMLhxFakk3aWqiw
         48yA==
X-Gm-Message-State: ALQs6tCK3AprjdNzy0MTX1F4KLk71hgg8OJ9QZooUorkDFGV1Mgq8ZeQ
        QR5DeabgsIJBbc4qvaybgqo=
X-Google-Smtp-Source: AB8JxZp3v5H7cJ4a64stlkQiQ3aoOBDGt1tzJdMRXr7BLsiLRMMRhL9aMOB4r0s+GKWcccJP4Sf6Fg==
X-Received: by 2002:ac8:72c2:: with SMTP id o2-v6mr18822200qtp.253.1524492561020;
        Mon, 23 Apr 2018 07:09:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id k43-v6sm11193926qtc.5.2018.04.23.07.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 07:09:20 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Ben Peart <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <d2743302-43dd-da3e-f0ba-55dcb824c0f4@gmail.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <b11211ab-4133-84b4-d27b-5dabcd2a6612@gmail.com>
Date:   Mon, 23 Apr 2018 10:09:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d2743302-43dd-da3e-f0ba-55dcb824c0f4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/17/2018 02:39 PM, Ben Peart wrote:
>
>
> On 4/17/2018 12:34 PM, Jameson Miller wrote:
>
>> 100K
>>
>> Test                                       baseline [4] block_allocation
>> ------------------------------------------------------------------------------------
>> 0002.1: read_cache/discard_cache 1 times   0.03(0.01+0.01) 
>> 0.02(0.01+0.01) -33.3%
>>
>> 1M:
>>
>> Test                                       baseline block_allocation
>> ------------------------------------------------------------------------------------
>> 0002.1: read_cache/discard_cache 1 times   0.23(0.12+0.11) 
>> 0.17(0.07+0.09) -26.1%
>>
>> 2M:
>>
>> Test                                       baseline block_allocation
>> ------------------------------------------------------------------------------------
>> 0002.1: read_cache/discard_cache 1 times   0.45(0.26+0.19) 
>> 0.39(0.17+0.20) -13.3%
>>
>>
>> 100K is not a large enough sample size to show the perf impact of this
>> change, but we can see a perf improvement with 1M and 2M entries.
>
> I see a 33% change with 100K files which is a substantial improvement 
> even in the 100K case.  I do see that the actual wall clock savings 
> aren't nearly as much with a small repo as it is with the larger repos 
> which makes sense.

You are correct - I should have been more careful in my wording. What I 
meant is that the wall time savings with 100K is not large, because this 
operation is already very fast.

