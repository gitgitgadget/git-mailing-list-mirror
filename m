Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF86AC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjC1RQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1RQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:16:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5458E
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:16:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z10so7650788pgr.8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680023803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnkgNDiz2rDvRXbRcgn7DPQRODfF1WYOu3j1gu8P/VU=;
        b=GeVlRWMmhvW4SkbwYKzth6l++Shd7LRc57RQAWFHisuzMikhMugVWsUJ7h3QdHXZLl
         hcaI4A2x9ZzDL68Gh54dKmDj2Pf/nniqsK6m67p/5meNM3tpoxiL9qndFPxuRtk5hDlP
         Ce6H3GmM/rvf8p8VVLdi6FOupLs/5Dqtub5UtPgHA6ZK3eD41k1FWwRKOVpd4ZOJyqEO
         kXG/rGvnw+8q4QA+bFXK14EOFS+rVISEylVhEPgT0Y2jARBK+q1E1yfaKSPoXzkQfmXp
         j2HySpuiH3zIe4urjnlicm1GXJS4mJLG3sYTezA97RhBojk3BAuzBRJXekqU2WGFdodo
         2Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnkgNDiz2rDvRXbRcgn7DPQRODfF1WYOu3j1gu8P/VU=;
        b=XYhcjIuli8GW2aL1htIhe4QMeS4l+A8PnG+GPueGQKIaAVDvfmlEQ5ShonqwBlBA2r
         TRsmAVwaHTQMI/qDx4sh/VZRT7g3kbeIxLMT6BoUdeVnFuU+VBXwq4ayJ87KcvrXo4ce
         0vNy0SY1Be/Kua0zMKXcHGxLCMU0NNtTSNjYFceSRI7BAAx9O55z+6y2ScENljM9S1M4
         p9pYMfer62NtZFiGfCGWHgxWRPBtrKXv/No8O54b3ZejIx1PYGlqsLP64dLI4thRcyo6
         kvP4gabCZng+d0ykVwTovPdDKfQvwysQH05k9qqWGhAzLT/EJY3HWOPK1qmMy2SARZLs
         G0TQ==
X-Gm-Message-State: AAQBX9fI1F5FQ4T8fj3WdSJMg8guJevY0kcp2Ni7/0pOmwNKgXsrs+sU
        yjUfQ4qCYSN4IkFxXOyqm/zF
X-Google-Smtp-Source: AKy350ag65CNKuFpC9rHw82TxM0ZwRuhnBEd/aumXY1w1XlMtHIA3BKEdVdOPgwILQww7E2QCadB0Q==
X-Received: by 2002:aa7:8bc2:0:b0:623:2bba:dd9 with SMTP id s2-20020aa78bc2000000b006232bba0dd9mr15173970pfd.14.1680023802847;
        Tue, 28 Mar 2023 10:16:42 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7904f000000b00589a7824703sm10756716pfo.194.2023.03.28.10.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 10:16:42 -0700 (PDT)
Message-ID: <4731228c-c467-56ab-029b-e479e15432f2@github.com>
Date:   Tue, 28 Mar 2023 10:16:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [GSoC][RFC][PROPOSAL] More Sparse Index Integrations
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230328014927.5617-1-cheskaqiqi@gmail.com>
 <20230328021243.6641-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230328021243.6641-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> 
> Hello everyone,
> 
> Sorry about the wrapping mistake in last patch.
> 
> Here is the initial version of my proposal on "More Sparse Index 
> Integrations". I would really love to have comments on it. If you find any 
> mistakes please notify me about that.
> 
> And website version is there: 
> https://docs.google.com/document/d/1WtoLgAJYVHY_NWNscqi358FeAY-6UBARCmpTU3BAQMs/edit#
> 
> ==================================================================

Hi Shuqi!

> 
> ###Project Timeline
> 
> 
> #Empty Period (Present - May 4)
> 
>     My end-semester exams begin on April 4 to  April 28. Hence I might be 
>     a bit busy in this period.
> 
>     After April 28, I will continue to work on 'git diff-files' and start 
>     to work on ' git describe '

An initial integration for 'describe' was recently submitted [1] so, if
you'd like to start working on another integration after 'diff-files', you
may want to pick a different command.

[1] https://lore.kernel.org/git/pull.1480.git.git.1679926829475.gitgitgadget@gmail.com/

> 
> #Community Bonding Period (May 4- May 28) 
> 
>     Get familiar with the community
> 
>     I have read the related documentation about 'Sparse Index Integrations'
>     and working on 'git diff-files' , one of the builtins that could be 
>     integrated with the sparse index. The feedback and the advice for 
>     improvement make me learn a lot. And I'm confident I can start the project 
>     at the start of this period.
> 
>     Keep working on "git diff-files' and  'git describe' on May 5, and the 
>     expected time of completion of these two is May 28.
> 
> 
> #Phase 1 (May 29 -July 9)
> 
>     week 1 to week 3  (May 29-June 18): integrate  'git write-tree' with 
>     sparse index. Use the steps above.
> 
>     week 4 to week 6(June 19 -July 9 ): integrate  'git diff-index' with 
>     sparse index,use steps above.
> 
> #Phase 2 (July 9 - August 28)
> 
>     week 1 to week 3  (July 9 - July 23): integrate  'git diff-tree' with 
>     sparse index. Use the steps above.
> 
>     week 4 to week 6 (July 23 - August 13 ): integrate 'git worktree' with 
>     sparse index. Use the steps above.
> 
>     week 7(August 13-August 28) :
>     A buffer of one week has been kept for any covert difficulties when 
>     integrated with the sparse index.

Even working 35-40 hours a week (as you mention later), this is a pretty
ambitious timeline for integrating sparse index with commands. Does this
take into account the time needed to respond to review comments and make
changes to your patches addressing those comments? 

> 
> ###Blogging about Git
> 
> When I was a freshman, I hated writing summaries or other learning materials.
> But then I started writing blogs for new knowledge to keep track of what 
> I've learned. I realized that When I  dive into a topic and want to write it 
> down, I  will think much deeper about it than just learning. I also learned a 
> lot and gained many skills from others' blogs. I would love to write about my 
> progress and experiences with the project. In this way, I could share the ideas 
> with those interested in researching this project and help them get up to speed more quickly.
> 

Where would you post your blogs?

> 
> ###Availability
> 
> My semester will complete in late April, leaving me enough time to prepare 
> for my GSoC project. Git is the only project for my summertime. If I am 
> selected, I shall be able to work five days per week, 7 - 8 hours per day, 
> around 35 -40 hrs a week on the project, though I am open to putting in more 
> effort if the work requires. If everything is going well with the plan, I may 
> want to Participate in a hackathon for a few days with my friends in July.

I don't see it mentioned anywhere in the proposal - which project size [2]
are you planning for? 35-40 hours/week for (nearly) the whole GSoC period
implies "large" project, but it would help to make your intention explicit.

Also, this helps me understand *when* you'd be available, but not *how*. I
try to keep an open line of communication with any GSoC participant I'm
mentoring to help with any issues or bugs encountered; it's also very
helpful for me to get regular (daily or every few days) updates from the
GSoC contributor on their progress.
 
To do that, what kind of communication medium would you want to use? An
instant messaging application (Slack, Discord, IRC)? Email? Something else?
In general, I'd be interested to see more on your plan for communication &
collaboration.

[2] https://developers.google.com/open-source/gsoc/faq#how_much_time_does_gsoc_participation_take

> Thanks & Regards,
> Shuqi

