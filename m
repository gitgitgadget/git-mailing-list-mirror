Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F77C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiDRRpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiDRRpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:45:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83423054B
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:43:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t13so20107419pgn.8
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=IkKfOeBW6dAZ+e0eKT5px1JeucnObDk5gqRvlEZ3g1o=;
        b=QCdaRKbHQHf8k2LYT6lhnf15UMIZSaRd79hcLkdW2X85cZSXf/+6OT5Dj3lfavBLZ+
         /lvBsz0nuB0mkItYK0f++2p6pE6Oxuk//u3euiks+pejyjjxlwJrjEfqF1vdZWvq2mXW
         i5nCPWDndP1JOPfCj1OJJwYiheUsh5DuLfaHzx+QHzyo/juA9qvR327ywrtvEq56pZmM
         U4GiTmtzcVMe7mCIE2o6u4eOSqPyVKxroLezQafON+CnI6VLIJttQktoSzSzZeP05e5w
         hqwMmtK1ncPzMlDGPPyTiS/jGVUabAssSfu1jekC/W7/q8xJuY3aNhRngRvaNtKc0FPK
         aSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=IkKfOeBW6dAZ+e0eKT5px1JeucnObDk5gqRvlEZ3g1o=;
        b=2CrIYL5mLHPNxyNKuOezxZoGPW+T1uNhvnxEiWubspJXA565GiQ4E0hbve5e/J1kxI
         /NibZx+As9IwnC8YM9q5Kjzt2uXpp6jh2Lam6xAA8Eb0fdhSK6sZ0k2f+j6qfa8TxM6Y
         Z2f2SsUyI9WbhZqniPfqucZ7LzNZ58MjikPP8M6S/EFc1bk7/NT6NTx2zJoNpo66u8Fi
         cCuSp66ZKa4xOpAe2rnR8VUXIVn6ltQWBaM7wTA4h9HL42LQIvNbAutXdVPex179M6FG
         btD6ahYOWLdOMZMzWiCyrEFYXudbGqPLkajOT+HhEgQUXVQljkwX90faBWR3ahxEwADZ
         M/Mg==
X-Gm-Message-State: AOAM533zkWka1DIXwT8RA6PuecwxVl7a+5E/SzW47U49AEqD89oR8Bgk
        Q535Io7ku70+pfskpGqRBKs=
X-Google-Smtp-Source: ABdhPJxCtAbjyFHtzDxGPYbn97d5MOQZDiyiyWxvV32H2Uu6tkYPHUt2rHfuoL12qt+osqxlA7JAng==
X-Received: by 2002:a63:5d0a:0:b0:399:40fd:2012 with SMTP id r10-20020a635d0a000000b0039940fd2012mr11177515pgb.454.1650303794051;
        Mon, 18 Apr 2022 10:43:14 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.135.226])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm13747704pjf.40.2022.04.18.10.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 10:43:13 -0700 (PDT)
Message-ID: <bff6bdc8-83ef-7fa4-3554-edc0b7af1dfe@gmail.com>
Date:   Mon, 18 Apr 2022 23:13:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
Content-Language: en-US
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
References: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc: Christian, Hariom

On 17-04-2022 23:47, Jaydeep Das wrote:
> 
> Sorry for being late in submitting the proposal. My end semester
> examinations were over just yesterday so I somehow made this proposal
> during the exam time.
> 

Thanks for taking the time to send the proposal! I've Cc-ed the
corresponding mentors to bring their attention to this proposal.

I also noticed that you've submitted the proposal in the GSoC website
which was a nice move given the deadline is 19Apr2022 18:00 UTC.

> ===============
> View in Google Docs: 
> https://docs.google.com/document/d/1qq-Xze6dMGMSx3rPHD0VEc4f0a87KnHgbka1Dzpf8sc/edit?usp=sharing
> ===============
> Proposal
> ===============
> 
> Unify ref-filters with other pretty formats.
> 
> Name		:	Jaydeep Prapanch Das
> Email		:	jaydeepjd.8914@gmail.com
> Contact		:	+91 6026139802
> Github		:	JDeepD(https://github.com/JDeepD)
> Linkedin	:	https://www.linkedin.com/in/jdeepd
> Course		:	Computer Science and Engineering, 2025
> Time Zone	:	IST(+5:30)
> 
> ## About me:
> 
> I am a first year undergraduate at National Institute of Technology, 
> Silchar  pursuing B.Tech in Computer Science and Engineering. My 
> interests include FOSS development, Data Science and Robotics. I have 
> been writing Python, C and shell scripts for about 3 years now. Apart 
> from that I also blog[1] whenever I find an interesting topic to blog 
> about. During the GSoC period I also plan to blog about the new things 
> in git that I hope to learn.
> 
> [1]: https://jdeep.me/
> 
> ## Micro-Project:
> 
> I am still a newbie in git development and made my first (minor) 
> contribution in Feb 2022 [1]. This was a patch I made just to get 
> familiar with the patching and sending patches to the mailing list. For 
> my micro project, I worked on adding diff driver for the Kotlin language.[2]
> The main objective was to make an xfuncname regex which matches keywords 
> in Kotlin syntax so that they are considered as a single token
> whenever diffs are generated. Along with that, a word_regex regex pattern
> was also needed so that variable names, compound operators etc are not
> broken into individual tokens by git diff when there is a change in them.
> For ex,  if a == b is changed to  a != b , then the diff should show 
> that entire
> `==` token is replaced with the token `!=`. While working on this micro 
> project, I learned a lot about the contribution and review workflow of 
> git. It took 7 patches to incorporate all the reviews and suggestions so 
> yeah, It did require some patience :-).
> 
> 
> Minor patch(merged in master)
> [1]: 
> https://public-inbox.org/git/20220208092339.651761-2-jaydeepjd.8914@gmail.com/
> 
> Micro Project(merged in master)
> [2]: 
> https://public-inbox.org/git/20220312044832.718356-1-jaydeepjd.8914@gmail.com/
> 
> 
> ## Proposal:
> 
> Git has an old problem of duplicated implementations of some logic. For 
> example, Git has at least 4 implementations to format commands for 
> different commands. Previously, Olga Telezhnaya[1] and Hariom Verma[2] 
> worked on this and eliminated most of the duplicate logic. But still, 
> there are still some things left to do. Current task is to reuse 
> ref-filter logic in pretty.
> 
> [1]: https://github.com/telezhnaya/git/commits/format
> [2]: 
> https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail.com/
> 
> ## Previous Work:
> Previous GSoC mentee Hariom Verma worked on this[1]. He worked on 
> removing duplicate logic and reuse ref-filter’s logic in pretty. 
> However, as per his report, some tasks are still left to do.
> 
> -> Around 30% log related tests are failing
> -> Teach pretty-lib.{c,h} to handle incorrect formatting option
> -> Email/MBoxed commit format needs work
> 
> [1]: https://harry-hov.github.io/blogs/posts/the-final-report
> 
> ## GSoC Planning:
> The main objective would be to start from where Hariom left and make 
> further improvements in the related field if time permits.
> 
> Currently, because my end sems were just over yesterday, I am yet to do 
> a full reading/understanding of the pretty and ref-filter code. I plan 
> to first read the documentation of git-log and study the pretty formats 
> and their implementation. Next would be to read the code and understand 
> how it is working under the hood and try to find possible bugs and edge 
> cases where the tests fail. I have already gone through the various 
> must-read documentations suggested in the Hacking git[1] section of the 
> git-scm website:
> 
> My First Contribution Tutorial[2]
> My First Object Walk[3]
> 
> Apart from that, I also have a decent understanding of git internals, 
> objects and porcelain commands from the Git Internals[4] documentation.
> I want to start as early as possible since my main motivation for 
> contributing to git is to improve something that millions of people, 
> including me, use everyday in their day to day life.
> 
> 
> [1]: https://git.github.io/Hacking-Git/
> [2]: http://git-scm.com/docs/MyFirstContribution
> [3]: 
> https://github.com/git/git/blob/master/Documentation/MyFirstObjectWalk.txt
> [4]: https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
> 
> 
> 
> Estimated Timeline:
> 
> -> April 20 - May 14
> Read the docs and go through the codebase. Make small code contribution 
> if possible.
> 
> -> May 14 - May 21
> Inactive Period
> The covid lockdown is almost lifted and I would need to report back 
> offline to college. So I would probably be busy for a week to get 
> settled there.
> 
> -> May 22 - June 5
> Community Bonding Period
> Get in touch with the possible mentors(Christian Couder and Hariom 
> Verma) and discuss the possible solutions.
> 
> -> June 6 - June 11
> Inactive Period
> Will be inactive for the week due to mid semester examinations
> 
> -> June 11 - July 24
> Coding Phase 1
> Fix the test cases that are failing
> Eliminate more duplicate logic in pretty.{c,h}.
> Update the documentation
> 
> July 25 - August 20
> Coding Phase 2 (part 1)
> Teach pretty.{c,h} to handle incorrect formatting options.
> Make improvements in email/mboxed commit formats.
> Update documentation
> 
> 
> August 22 - August 27
> Inactive Period
> Will be inactive for the week due to end semester examinations.
> 
> August 27 - September 19
> Coding Phase 2 (part 2)
> Start where it left off in part 1 of coding phase 2.
> 
> During the coding phase 1, I would be able to dedicate 4 - 5 hours every 
> working day. On weekends, I could dedicate the entire day or take a 
> break depending upon the number of assignments I get. During the coding 
> phase 2 part 1, I will be able to dedicate 4 - 5 hours easily except the 
> hours may decrease some days before the end semester examinations.
> 
> ## Blogging during the contribution period:
> I plan to write bi monthly/monthly blogs during the contribution period 
> which I would post on my personal website[1]. I would write about my 
> progress and the new things that I will learn when I contribute to git.
> I also plan to make a complete video tutorial after the GSoC period 
> about the contribution workflow in the git codebase since I believe it 
> would have greatly helped newcomers (like me) to get started quickly.
> 
> [1]: https://jdeep.me/posts/
> 
> ## Post GSoC:
> I would love to explore the git codebase and I am particularly 
> interested in the sparse index feature of git. I would also love to 
> co-mentor someone someday when I get more experience in the codebase. I 
> have also noticed that there are some lesser known/underrated features 
> of git ( like partial clones, sparse checkout, worktrees) and I plan to 
> make video tutorials on these topics too.
> 
> ## Closing Remarks:
> As a whole, I feel it would be a great learning experience for me as 
> this would be the first “really” big open source project where I would 
> be contributing to. I am really excited about being a part of the git 
> community.
> 
> Eagerly waiting for review.
> 
> Thanks,
> Jaydeep
