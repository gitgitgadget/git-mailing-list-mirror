Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C86C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 16:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjC1QVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjC1QVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 12:21:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E3E049
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 09:20:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u10so12189130plz.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680020459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/m2SC7R62GEYy3o9CW9gIbOHyji0qtCW/9j5GlSgwQ=;
        b=gGlzqlg6UKJ9eH0OjAq4Huob500Pmxo1vzp3kvva3V7N5/aWn538tfaLogAz3f6IFn
         BOZa0Qdn2m7y5D5ZcAm/Qy6Qhz/9siFo21mfbOT8EY5JULWIqU0r6+mZCDaHoUZXRuby
         q1Q13b2SLfUqxOSS1Bpmg0kBEnBQuXk/SCRB83zmQqzLRg4v3D2Tq0gCi2LnrJ3XU/VV
         ZRO/bRSbaUGjjRClgPoytKHgGQQrygazm63iYOB5Q1A1qWTOhKx5czEKFXiOrfuoypJk
         OwY6NXjeyGO4DSDVO+5jg8LA1/zF9torkPw4rzbY4Ni/pxecg/LQqLfrrHU7SAQCX8BU
         he1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680020459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/m2SC7R62GEYy3o9CW9gIbOHyji0qtCW/9j5GlSgwQ=;
        b=ey19A/2NfWhoyZPzeyowFsQAplYo1RElY4G4Q15YKZl+5joydPJKvVTzDHYJLj6FK7
         xWhv5TSfVTkxS/mH3Fb/9pOfZ/wmpIN7NAMg5837/DRmMenhqOSRMQnPtKV964WJD05m
         5LVYJ5SQo/Pvcsbq0FdgfF32n1t/q8d2IxxM/RXgcId9AYuU4cDzCEC5fH2MgI9DLmTI
         AHiS13WTkHs3N+hkqn3eho1jWK7pahh8ZBIG8cc2blcO/yn2a+c8iTGilgNqOwhFqcct
         hCBof6PFLROMIggYwP80QhvjtptjJn1iLacl6OYif0XaCmhVggt5O09ChcqvuSP8svV/
         63EQ==
X-Gm-Message-State: AO0yUKXvhct//WLRhM7MyDJ1Izm6eNNUF9FeWe3lG8XaKDp6HMCzHmrU
        Im02Cs8OH/M+yZITJnDhBUfv
X-Google-Smtp-Source: AK7set8tGZvcNJf7bcDKZQvpOeVZNlphAks9wTTaZm1k10vI1z4DCyI+NZbUB1klLKIpi7SRxoQG2g==
X-Received: by 2002:a05:6a20:c320:b0:da:f3cb:764e with SMTP id dk32-20020a056a20c32000b000daf3cb764emr12558950pzb.23.1680020459151;
        Tue, 28 Mar 2023 09:20:59 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id bs187-20020a6328c4000000b0050f74d435e6sm16092165pgb.18.2023.03.28.09.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:20:58 -0700 (PDT)
Message-ID: <bfd16069-e542-e8c2-e32e-b3e08fc27211@github.com>
Date:   Tue, 28 Mar 2023 09:20:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC][PATCH v3] GSoC 2023 proposal: more sparse index integration
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, hariom18599@gmail.com
References: <20230226083347.80519-1-gvivan6@gmail.com>
 <20230323063844.23222-1-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230323063844.23222-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg wrote:

Hi Vivan, 

Sorry for the delay in re-reviewing! You've largely addressed my original
comments, so I only had a few follow-up questions/notes to add.

> +# In GSoC
> +
> +## Plan
> +
> +Plan
> +
> +The proposed idea of increasing "sparse-index" integrations may appear straightforward 
> +initially. However, after reviewing previous implementations, I have found that this 
> +idea can present unforeseen difficulties for some functions. For example, to enable 
> +"sparse-index," we must ensure that "sparse-checkout" is compatible with the target 
> +Git command. Achieving this compatibility requires modifying the original command 
> +logic, which can lead to other unanticipated issues. Therefore, I have incorporated 
> +additional steps in the plan, to the steps proposed by the community and mentors, 
> +outlined below to proactively address potential complications.
> +
> +1.	Conduct an investigation to determine if a Git command functions properly with 
> +    sparse-checkout. This step is estimated to take approximately 7-14 days.
> +
> +2.	Modify the logic of the Git command, if necessary, to ensure it functions 
> +    properly with sparse-checkout. Develop corresponding tests to validate the 
> +    modifications. This step is estimated to take approximately 7-14 days.

I'm guessing these two steps will be much shorter if the command is already
compatible with sparse-checkout (<7 days for step 1, and you could skip step
2 entirely)?

> +
> +3.	Add tests to t1092-sparse-checkout-compatibility.sh for the built-in, focusing 
> +    on what happens for paths outside of the sparse-checkout cone.
> +
> +4.	Disable the command_requires_full_index setting in the built-in and ensure 
> +    the tests pass.
> +
> +5.	If the tests do not pass, then alter the logic to work with the sparse index.
> +
> +6.	Add tests to check that a sparse index stays sparse.
> +
> +7.	Add performance tests to demonstrate speedup.
> +
> +8.	If any changes are made that affect the behavior of the Git command, update 
> +    the documentation accordingly. Note that such changes should be rare.
> +
> +Points 3-8 combined should take approximately 15-30 days.

Does this also account for the time _after_ submission to the mailing list?
Responding to review comments, iterating on changes, etc?

> +
> +To summarize, each integration will follow a similar schedule to the one outlined 
> +above. Therefore, without extending the timeline, we can expect to complete 2-3 i
> +ntegrations during the GSoC program period.
> +
> +Timeline 
> +
> +Determining the exact time arrangement for each integration is difficult, as there 
> +may be unforeseen challenges that arise during the process. However, based on my 
> +estimation, I anticipate that each integration will take approximately 1.5 - 2 months 
> +to complete, starting from May 29th. Please refer to the detailed breakdown of each 
> +step in the plan section for a more accurate estimate.
> +The proposed integration schedule is as follows:
> +
> +•	git describe
> +•	git write-tree
> +•	git diff-files

At this point, initial integrations for both 'git describe' [1] and 'git
diff-files' [2] have been submitted to the mailing list. To make your plan
more flexible/resilient to concurrent contributions, I think it'd be
reasonable to give a list of 5-6 commands you'll choose from to complete
your 2-3 planned integrations.

[1] https://lore.kernel.org/git/pull.1480.git.git.1679926829475.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20230322161820.3609-1-cheskaqiqi@gmail.com/

> +
> +This schedule is based on the order of difficulty outlined in GSoC 2023 Ideas.
> +
> +It's worth noting that each integration may require different amounts of time 
> +and attention, and modifications to the schedule may be necessary as I delve 
> +deeper into each command. Nevertheless, I am committed to delivering quality 
> +results within the given timeframe.
> +
> +In summary, I anticipate that each integration will take an average of 1.5 months, 
> +but I remain flexible and open to adjusting the schedule as needed to ensure the 
> +success of the project.
> +	
> +Availability
> +
> +I commit to responding to all communication daily and being available throughout 
> +the duration of the program. While I will be taking some summer courses at my 
> +university, I will not be enrolled in a typical full course load. As part of GSOC, 
> +I plan to commit to a medium-sized project of 175 hours. I have experience managing 
> +my time effectively while taking courses and working full-time internships in the 
> +past.
> +
> +The program is officially 16 weeks long. To ensure timely completion of the project, 
> +I plan to spend 8 hours per week until August 15th, which is when my semester ends. 
> +From August 16th until September 1st, I plan to dedicate 8 hours per day to the project. 
> +There are only three weeks during which I would prefer to focus on other things: 
> +June 23rd-30th (midterm week) and August 1st-15th (finals season). However, as I will be 
> +committing 8 hours per day following Aug 15th, it should be ample enough to make up for it.

Thanks for adding these availability details!

> +
> +I am confident that I will have ample time to complete the project within the allocated 
> +time frame. Additionally, I am hoping to continue working on the project even after 
> +GSOC ends, as there are several functions that need to be implemented.
> +
