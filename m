Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39765C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiIZRzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIZRzG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:55:06 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53B2A42E
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:31:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l4so3903537ilq.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DtQiROiZyq6ZKEPJhNT9JWW//bfgNdvSM5ok1FNrZFk=;
        b=jawi/7DkAonVogASBBhbvUubmVnfHUzGqs8wCn0MgQIyT5wx+Zp0dNbykX6o5yaZbf
         V+uZElWH20U1dphfguTMmZvp1ILcsNaKjIMoqJtLTkVQB//1bWvzRw2dX+ZrjbXvK+vp
         yFBgFSbsY6ueueTlxxEWB6Kesmh5wi+nIbFwbytWcM0HNIjhQupS0yWxC75KhqLPwF5r
         s6XqXlcLvqBzq+iV02A5PvCk6F2wO5MNIdtqVoYekNh8TB+znrcsuedY39cOdT/KPOq0
         huwgrvRVPOYRD7JAgOID8WsUooNXqsaPexDYGzB19EiE+095ihhnxyUSifua9ewK4VTr
         DesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DtQiROiZyq6ZKEPJhNT9JWW//bfgNdvSM5ok1FNrZFk=;
        b=DZWZSn0AGkRtYVBXdcqjF0Vx9YC+wC20Z7PcszEg79+dR1I2rEX6a1KFVGQ4hbM3h6
         rtS4FnqF3cPS3PKu18pnv5uZTu/MsVkU6rGRhpESQBU1Fr2Wm5zxRZ+Qp5R7wwn75hm7
         2vSq2imwxXMhWI38BO+7AI9UMfT3X9QCM3dwF7AWEByCaQaC3aMIAWixzpTYiNMJgwbQ
         T5b+YwF3bPpBlzWxJxxtr3OA138qv1Dte2Vb7xDLBSUfkUHAxF2+elZE+sfNlh5t8t8K
         oI6G6eBO46BFjb/ZM3rlbjuaS7n1zF+Hr3x85f7a68QuRjXurtiADCu/RCuC3G05PSUk
         OwMQ==
X-Gm-Message-State: ACrzQf0iUxfY/cGdPXU/2qzIKIIt4hWbRT4bqhuWJ5lvuZMwfz+lXqPj
        tstTyK3FBpJNdtvYJaQid3e4
X-Google-Smtp-Source: AMsMyM4+8Oe56vUOfCKp1LbRMl8Ejq9b369CKfz0bjlqLwBkv8wa6XYV64FjCUG0U42bPOwjgcSdHQ==
X-Received: by 2002:a92:cd12:0:b0:2f5:6748:d549 with SMTP id z18-20020a92cd12000000b002f56748d549mr9693406iln.222.1664213509992;
        Mon, 26 Sep 2022 10:31:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4177:874e:9632:3b2a? ([2600:1700:e72:80a0:4177:874e:9632:3b2a])
        by smtp.gmail.com with ESMTPSA id k20-20020a023354000000b0034c12270863sm7301240jak.80.2022.09.26.10.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:31:49 -0700 (PDT)
Message-ID: <e1aab606-fdde-e10f-ed00-2af67bbfec27@github.com>
Date:   Mon, 26 Sep 2022 13:31:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] pack-bitmap: remove trace2 region from hot path
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        me@ttaylorr.com, chakrabortyabhradeep79@gmail.com
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
 <pull.1365.v2.git.1664198277250.gitgitgadget@gmail.com>
 <220926.868rm618ds.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220926.868rm618ds.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2022 11:01 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 26 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> This is a critical path, and it would be valuable to measure that the
>> time spent in bitmap_for_commit() does not increase when using the
>> commit lookup table. The best way to do that would be to use a mechanism
>> that sums the time spent in a region and reports a single value at the
>> end of the process. This technique was introduced but not merged by [1]
>> so maybe this example presents some justification to revisit that
>> approach.
> 
> Just getting rid of this seems like a good thing for now.
> 
> But aside: Yes, one way to mitigate this rather than removing the
> tracing would be to make it really fast.
> 
> But just skimming pack-bitmap.c do we really need trace2 at the
> granularity of a single commit? Looking at who calls bitmap_for_commit()
> wouldn't something like this sketch-out be much more useful?:

The point of it being where it was to check that we hit the path
custom to the commit lookup extension, hence the test that is removed.

You are proposing a different region entirely, meant to measure the
cost of the entire walk. Maybe that's valuable, but not critical to
this topic.

If you're proposing the high-level traces as an alternative to my
prototype using the trace2 timers, then I'll point out that the timer
approach allows us to determine how much time is being spent checking
for bitmaps versus walking commits, which the regions you provided don't.

Thanks,
-Stolee
