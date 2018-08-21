Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551AD1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 13:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeHUROC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 13:14:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44113 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHUROB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 13:14:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id r13-v6so1472617qtr.11
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HA5yFBzqSleF1poy3zhAKrdVTHv2Qv3awy1thDSel3U=;
        b=OQyjOcM9x5+KlS4ys3Uyxqvf0YAg/ObplthhvEX4vo3L/z0Rc74/jHseKd8Cq4/QfL
         +PLlaXjvSCIj00v+mRrEJE3MGgWEjLlAZYdm/pVw1XPd4IgdZ4fjtf3qycUp6Mu/Kvog
         jgN/rbJ/cMKheGpmPFlpNr7o4iPyhE+WlvaHZVTj0Lz5bC+4JUHZXInVt7IKZ7vldVHe
         5ci7oG0TEQAqK6Usoa/MZvTqCFf1m9JYREJs4lkNnELCmt8bd0RcvIoOmQ6Grx9srHO8
         B/FKUqIzwDBeJmTykKIOK4dOQYZmRAi0cBMH01gJRYf+fgO6ueX6NOeZjvfTXG652xbp
         rvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HA5yFBzqSleF1poy3zhAKrdVTHv2Qv3awy1thDSel3U=;
        b=J0KqJaaMCeYTvogDrrkcpImEy9Jj8rQA4Hd3swypG6nwKiZQNACeEDN8Q/upAy1VBb
         gbBU+XQY+W4ECcQux5K+uNDoCktwB+uSMzDZ7PEWoeGo4v7yPLGBPS0pQZnToN4iaGID
         pw17YCucR3XVvwYMb7yjPhsvynwg8rvIA/IZopd0z7ACpMw9CEfCTwz/UDNeygkbt79X
         fah5uxWiEKsDe1njWNBjFJ3bg8sMcskJmg4lBjRiCTrWj/OiC6Z5GOxyfxUjOKBC3KXM
         KAafpk0myRBcORBzhDz2DTU9GQSM8sZcJTqAPTVWO9/hm/TLnyml77eqNuL0Xr413uic
         J/Zw==
X-Gm-Message-State: APzg51Ae39mfmB4itKSrlB6MFJjf2Vw0WQBSGgVw7V8RQTKR3HwGh6Vr
        3mtJEeKoyQGyOvMW0eHyYSNqeWDt
X-Google-Smtp-Source: ANB0VdanAlJkxRQd8Dc41F4zs3Vd6c+MRcwsMaqLMvuBrt56elYRTLD85oIrjfT/ZVA4r5OHx8TuXA==
X-Received: by 2002:a0c:d0b5:: with SMTP id z50-v6mr3563897qvg.230.1534859626110;
        Tue, 21 Aug 2018 06:53:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id f2-v6sm6689801qkm.51.2018.08.21.06.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:53:45 -0700 (PDT)
Subject: Re: [PATCH 3/9] midx: mark bad packed objects
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>
References: <20180820165124.152146-1-dstolee@microsoft.com>
 <20180820165124.152146-4-dstolee@microsoft.com>
 <CAGZ79kY8i3y6_r=bQAx7V5=ckSmb_RgyByjJwtS+7Qr2y8x8LQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <da0185cf-7d48-862b-eb25-5d5bd8f4e833@gmail.com>
Date:   Tue, 21 Aug 2018 09:53:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY8i3y6_r=bQAx7V5=ckSmb_RgyByjJwtS+7Qr2y8x8LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2018 5:23 PM, Stefan Beller wrote:
> On Mon, Aug 20, 2018 at 9:52 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>> When an object fails to decompress from a pack-file, we mark the object
>> as 'bad' so we can retry with a different copy of the object (if such a
>> copy exists).
>>
>> Before now, the multi-pack-index did not update the bad objects list for
>> the pack-files it contains, and we did not check the bad objects list
>> when reading an object. Now, do both.
> This sounds like a bug fix unlike patches 1 & 2 that sound like
> feature work(2) or making code more readable(1).
> (After studying the code, this doesn't sound like a bug fix any more,
> but a safety thing)

It is a safety thing. One codepath that needs this includes this comment:

             /*
              * We're probably in deep shit, but let's try to fetch
              * the required base anyway from another pack or loose.
              * This is costly but should happen only in the presence
              * of a corrupted pack, and is better than failing outright.
              */

This goes back to 8eca0b47: implement some resilience against pack 
corruptions. The logic is tested in t5303-pack-corruption-resilience.sh, 
with the test title '... and a redundant pack allows for full recovery too'.

> Is it worth having this on a separate track coming in
> faster than the rest of this series?

ds/multi-pack-index is cooking in 'next' until after 2.19.0, so I'm not 
sure it's worth splitting things up at this point.

>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   midx.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/midx.c b/midx.c
>> index 6824acf5f8..7fa75a37a3 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -280,6 +280,16 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
>>          if (!is_pack_valid(p))
>>                  return 0;
>>
>> +       if (p->num_bad_objects) {
>> +               uint32_t i;
> Is there a reason that i needs to be if 32 bits?
> Would size_t (for iterating) or 'int' (as a default
> like in many for loops) be ok, too?

i is bounded by p->num_bad_objects, which is also uint32_t.

Thanks,

-Stolee

