Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DBAC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D5220704
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpMPXOUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJ3JCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3JCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 05:02:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A5C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 02:02:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r10so4640125pgb.10
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z6/7Kcs21vvVyG7D7F2sdVJMuY5pY+utUqICnlhWhrM=;
        b=EpMPXOUJ1yxH8CW863SSDGc9G9AqZYPgk3JoMmaFch4UFqBrTgVZZICaozQ4WsD7Em
         jBFcDpOTaSGZdFpePhsqy4hfObCGIZEF/oZaPAZUBPQwsfZI5tELD45LgaxuupaB5vw5
         rify1IKRdubVoNprrONEO7pfzyHgNWiFHAO9LGcHrmmb3iIFkZGjnmsG8paFpMHlkpfr
         zk831q53MABf3pLID1Ybu47x/zlr5k9NyfHSZt5kcTJxHdEtfloXMEtYFs59WZ4IfgV4
         8SfGj8HQMk20xIQe2BSYYxCwJ8iRKjnGdDgjAIAVfkwNKYUzKhhEoh2YST2OII6RTjUm
         /qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z6/7Kcs21vvVyG7D7F2sdVJMuY5pY+utUqICnlhWhrM=;
        b=dHPsBeZv+MWeulpbqukzJZKYTY8prTVh9IuzCijtBFGiKbreGtowyXRxhFdRv4pp5z
         vs/t1ZMmBesux1A3amrPD5vImCFRxVDNPocphgcjftrDsqfn33TB9szHFCJMKGmZHI6P
         Llsk7CdJvXDm0mIoOCZc/UuD36FztrPD7XzffZyMqGXq23os+2ASj4dBUBMd09XZownU
         RQ6cR/SYdV5zFPU24TPJK00XkR2LF1eHTnloS7mQR7UBhHsybHhM6NSJpNT9KLoWffU9
         Ufb/PZ6QWSO9JgOdMvQeI0XCLTHrJ0qLZUfnLY3anxLkwdHhakUZl4I9rPW8gUuuL9uh
         mQ0Q==
X-Gm-Message-State: AOAM530uLW+y3+5L8Y1vZypu4bdRjVkKgsLW4ThXidUHi06nC3y70ilJ
        VC5smlgjsWmJyKtU7tQQHbEdUY2jN5M=
X-Google-Smtp-Source: ABdhPJzQT9c8E7lRKhcxY3V6lFXy0GyO9flEjGaBfMFVUfwdLCMs6slJ0GW9ZkbajdrOyzCjQoMLJQ==
X-Received: by 2002:a62:fcc3:0:b029:155:d55:7c13 with SMTP id e186-20020a62fcc30000b02901550d557c13mr8360623pfh.79.1604048534550;
        Fri, 30 Oct 2020 02:02:14 -0700 (PDT)
Received: from [192.168.208.42] ([49.205.81.28])
        by smtp.gmail.com with ESMTPSA id z5sm5155878pfn.20.2020.10.30.02.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 02:02:14 -0700 (PDT)
Subject: Re: [Outreachy][Proposal] Accelerate rename detection and the
 range-diff
To:     Elijah Newren <newren@gmail.com>
Cc:     Sangeeta NB <sangunb09@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAHjREB6Hh+urW3j2c9p45ZudSdDv0rUP28Lb4e4TZasqTzRmDA@mail.gmail.com>
 <CABPp-BF3MEAkJmmLv_0fWBJV_2AMqh_8P7Dqk62c2_Uz9Pa3Lw@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <6dfa865d-cb32-47fa-b9b4-fe3901a0cf63@gmail.com>
Date:   Fri, 30 Oct 2020 14:32:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF3MEAkJmmLv_0fWBJV_2AMqh_8P7Dqk62c2_Uz9Pa3Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 26/10/20 10:22 pm, Elijah Newren wrote:
> 
> On Mon, Oct 26, 2020 at 1:44 AM Sangeeta NB <sangunb09@gmail.com> wrote:
>>
>> I would love to participate in outreachy this year with Git in the
>> project "Accelerate rename detection and the range-diff command in
>> Git". I have contributed to the microproject "Unify the meaning of
>> dirty between diff and describe"[1] which is still under review, but
>> through the process, I have got myself familiar with the mailing list
>> and patch review system. I am also contributing to another issue[2]
>> which is still under discussion[3] about `git bisect` and `git
>> rebase`.
>>
>> [1] https://lore.kernel.org/git/pull.751.git.1602781723670.gitgitgadget@gmail.com
>> [2] https://github.com/gitgitgadget/git/issues/486
>> [3] https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gmail.com/
>>
>> Coming to the project, I have read more about it[4] and have created
>> the initial version for the timeline. I would really love to have
>> comments on it.
>>
>> [4] https://github.com/gitgitgadget/git/issues/519
> 
> I might be the bearer of some bad or concerning news.  This email is
> directed more to the mentors and others on the git mailing list, but
> obviously may affect you as well:
> 
> I apologize for not stating my concerns more forcefully earlier, but I
> didn't have as many details at the time or have an idea how fast
> merge-ort could be upstreamed.  Anyway, I'm still concerned that this
> might not be a good project for Outreachy due to two factors: unclear
> benefit, and conflicts:
> 
> 1) I've got merges down to the point where even if there is a massive
> rename of 26000 files (e.g. renaming "drivers/" to "pilots/" in the
> linux kernel), rename detection is NOT the long tent pole in a merge.
> So although this project is interesting, it's not clear that this
> project will help us much.  It might be better to get my changes
> merged down and see if there's enough need for additional
> optimizations first.
> 
> 2) Ignoring what I've already submitted, the remaining diffstat for
> merge-ort is about 5500 lines....
>    2a) If I break that ~5500 lines into patches with 50 lines each,
> that's 111 patches.  If I assume I can send 10-20 patches per week
> without overwhelming folks, that's 6-11 weeks, pulling us somewhere
> into mid-December or mid-January.  10-20 patches per week might be
> over-optimistic on reviewer fatigue, which would push it out even
> further.
>    2b) Work is going to soon rotate me onto other non-git projects,
> meaning even if the mailing list can review my changes aggressively,
> there's a chance I might not be able to keep up on feeding them to the
> list.
>    2c) diffcore-rename.c is only ~700 lines right now.  My 5500 lines
> of changes includes over 1000 new lines for diffcore-rename.c and
> about 150 line removals for it.  These changes are spread all over the
> file; only four small functions remain untouched.  In fact, I even
> made big changes to struct diff_rename_dst too, so any new uses of it
> would almost certainly have textual conflicts.
>    2d) My diffcore-rename.c changes probably do not make logical sense
> to submit first.  They should come after some groundwork is laid for
> merge-ort.
> 
> Even though at a high level this project is complementary to the
> optimizations I made in my 'merge-ort' work, I fear there will be LOTS
> of intermediate conflicts as we both make changes to the same areas
> during the same time and make a mess of things.
> 

Thanks for the detailed concerns. Some thoughts:

- Given that a major portion of the project would be to evaluate
   various algorithms and identifying the most suitable one, I believe
   implementation conflict shouldn't be a problem as it's expected to
   start only by late-January. Also, as Christian pointed out elsewhere
   it might be a good learning experience.

- I do have a concern about one thing, though. For evaluating the
   algorithm in the context of Git, we might need to do some experimental
   implementations to get some metrics which would serve as the data that
   we could use to identify the optimal algorithm. I'm  wondering whether
   your planned changes might affect that. In the sense that, is there a
   chance for the evaluation to become obsolete as a consequence of those
   changes? If yes, what could we do to overcome that? Any thoughts on
   this would be helpful.

> If you all think this is still a good project to have an intern work
> on, I'll defer to you, but I am concerned.
> 

-- 
Sivaraam
