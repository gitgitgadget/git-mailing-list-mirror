Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956B2C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B57611EE
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhDCONG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDCONF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 10:13:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407DC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 07:13:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y3so975084pgi.0
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=n/pt/SPtPgp0uEAKMhqbFoAi7UHIeKrUbNBcewCPUio=;
        b=puRQp0ZFADAofIyxXDgC0tfwyiE7tRM8O45ctiVCnEMuQ5Y8DxOkLyENTeTr522APO
         vn0q9PcuheJW3ZbE9hwWgnGeErQlizR1eFebSxkoYJlRieY4uACcyoMF9Jkj+VgyHpGr
         GhN16j92qzYq2NvE3mX7FxA4tLoW+s+JrGe036brB6j5mZnneehdMuu4gLGqeJHZm18G
         vj/xpbDYfdlm8yfh7P1A56spBKBfSi/EjlwQBvT9jIiGFFdAaNWvW8mwc+0wrvH5AgwV
         9ov9mZp5GFeFvZ4YU5sV2xihXx4Qu2rO4VBf+Wb7zfyYDF6Z6WGTDMLadqegFyygEv2m
         /GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n/pt/SPtPgp0uEAKMhqbFoAi7UHIeKrUbNBcewCPUio=;
        b=UcljvICcuqIwgYEYW/mjp4IbfYye6PZXHLV+fe7g0OrhjjxpOa4IPVe3DvVOZT4+88
         1+HyalWAblZ+hnm537ynUvlwQBgf/IC6bwivz2pahPHEfCFgPVm6WpORmjoyLT5mhwDV
         iQsXFGKXcxaRBxZRU5f2l2/pZDcm5nwq7csxmOgN4Npv93cf7R3WG5tbXG+CA+d9WwDI
         QEVw/IAIAILeYCdeIX/aedVoPy2GlhHFUcJNC2Kzc3FWg15Xdi8HDkZtwLfFXwWfzBi4
         mUMvKXBax+Iz3O6Kw9ZNT1zb0Xnk8hWk6wxgPMvBcpJToE6aX894OTrHBXTwdOWkqZem
         JYLw==
X-Gm-Message-State: AOAM531thOvQIVs6WmGtvF8a6D9ZpWooId4yL2UPrYq1JDadsXkF4nGb
        nU52ZI35nKAXOxPBCmtoyqYVnOi4+XtItWngSnM=
X-Google-Smtp-Source: ABdhPJz3qLsgqRLPLrwCJOYS5wCOeGA5rA1/bJteozRBHCDFPNmPdwc6Y2l+oGqNpF7OYPGmjjbJUg==
X-Received: by 2002:aa7:99c6:0:b029:1f5:c49d:dce7 with SMTP id v6-20020aa799c60000b02901f5c49ddce7mr16189749pfi.78.1617459181904;
        Sat, 03 Apr 2021 07:13:01 -0700 (PDT)
Received: from [192.168.10.22] ([182.19.8.85])
        by smtp.gmail.com with ESMTPSA id j92sm10712506pja.29.2021.04.03.07.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 07:13:01 -0700 (PDT)
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
 <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
 <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <769c7c48-a518-2636-10be-1479997e8f15@gmail.com>
Date:   Sat, 3 Apr 2021 19:44:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a textual format of the draft proposal.


Convert submodule to builtin
March 2021

==================================================
##Personal Information##


Name - Chinmoy Chakraborty
E-mail - chinmoy12c@gmail.com
Github - https://github.com/chinmoy12c
Linkedin - https://www.linkedin.com/in/chinmoy12c/
Major - Information Technology
Time Zone - IST (UTC+05:30)
=================================================

##Work Environment##

I am fluent in C, Java, Python, and Shell script. I use Git as my VCS, 
Visual Studio Code
as my primary code editor, and Kali Linux as my primary OS.
=================================================

##Git Contributions##

[Microproject] Replace instances of `the_repository` with ‘r’. (Learning 
the ropes)
Pull request: https://github.com/gitgitgadget/git/pull/915
Mailing List: 
https://lore.kernel.org/git/pull.915.git.1616701733901.gitgitgadget@gmail.com/


[column, range-diff] downcase option description
Pull request: https://github.com/gitgitgadget/git/pull/920
Mailing List: 
https://lore.kernel.org/git/pull.920.git.1616913298624.gitgitgadget@gmail.com/


[Documentation] updated documentation for git commit --date
Pull request: https://github.com/gitgitgadget/git/pull/918
Mailing List: 
https://lore.kernel.org/git/pull.918.git.1616926790227.gitgitgadget@gmail.com/
=================================================

##Project Outline##

A few components of git, like `git-submodule.sh`
are in the form of shell scripts. This causes
problems in production code in multiple platforms
like windows. The goal of this project is to
convert the shell script version of `git-submodule.sh`
to portable c code. The end goal would be
to completely remove `git-submodule.sh` and rename
`builtin/submodule--helper.c` to `builtin/submodule.c`.
=================================================

##Why is the project required?##

"Issues with the portability of code"

The submodule shell script uses shell commands like
`echo`, `grep`, `test`, `printf` etc. When switching
to non-POSIX compliant systems, one will have
to re-implement these commands specifically for the
system. There are also POSIX-to-Windows path conversion
issues. To fix these issues, it was decided to convert
these scripts into portable C code.

"Large overhead in calling the command"

The commands implemented in shell scripts are not builtins, so
they call `fork()` and `exec()` multiple times, hence creating
additional shells. This adds to the overhead in using the
commands in terms of time and memory.

"No access to low-level API"

The shell commands don’t have access to low level commands
like `git hash-object`, `git cat-file` etc. As these commands
are internally required for submodule commands to work, the shell
script needs to spawn a separate shell to execute these commands.
=================================================

##How have I prepared?##

I have gone through all the previous works and read through their
code to make myself accustomed to the intricacies of the code.
I have also structured my workflow based on the observation of
the previous discussions on those patches, and taken into
consideration the issues faced previously.

=================================================

##Previous Work##

A large part of the `git submodule--helper.c` has already been
converted by Stefan Beller​, Prathamesh Chavan​ in his GSoC project
in 2017, and Shourya Shukla in his GSoC project in 2020. This is
the list of already ported commands.

set-branch
set-url
summary
status
init
deinit
update
foreach
sync
absorbgitdirs
=================================================

##Work to be done##

The only command that is left to be ported is `git submodule add`.
The previous work on this by Shourya Shukla in GSoC 2020, did
not reach a successful merge due to some issues in design and
was kicked out because it has been stale for so long. The first
and foremost aim of the project will be to finish porting this
command. Thereafter, the end goal would be to completely replace
the shell script (git-submodule.sh) with an efficient c code.

Before porting the `git submodule add` command the initial work
would be dedicated to the implementation of small helper functions
in the form of small patches, which would be directly used by the
`add` command. This workflow is based on the suggestion by
Junio C Hamano on the thread:
https://lore.kernel.org/git/xmqqd01sugrg.fsf@gitster.c.googlers.com/.

This workflow would help in the following ways:

- It would help in sending patches in a small digestible format.
- It would help the reviewers easily review those small units
   of patches in a single sitting.
- It would help keep small logical units of code in different clean commits.

An additional test tweak would also be required in 
`t7400-submodule-basic.sh`,
to prepend the keyword ‘fatal’ since the command dies out in case
of absence of commits.


The following helper functions would be required to be implemented -

- A function to guess the directory name from the repository string.
- A function for normalizing path, that is, removing multiple
   //; leading ./; /./; /../; trailing / .

- A function to check for tracked directories properly as pointed
   out by Kaartic Sivaraam on the thread:
https://lore.kernel.org/git/ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com/.

- A function to check if the path exists and is already a git
   repo, else clone it.

- A function to set the submodule config properly.

- After implementation of all these helper methods, the main
   `module_add()` function would be implemented using the helper
   functions listed above as well as those helper functions which
   are predefined.
=================================================

##Project Timeline##

"Present Day - May 17"
I’ll utilize this time in exploring the codebase more properly and
solving more issues, which would help me properly familiarize
myself with the codebase. I’ll also try to structure a more
solidified, detailed workflow and come up with a draft patch
based on the previous work and discussions.

"May 17 - June 7 (Community bonding period)"
- Get familiar with the community.
- Discuss proper workflow with mentors.
- Make changes in the timeline, if necessary.
- Discuss the structure of the series of patches.

"June 7 - June 25 (Initial coding phase)"
- Finish implementation of the helper functions.
- Work on a proper structure of the implementation of the
   `submodule add` command and implement additional helper
   functions if required.
- Update proper documentation of the helper functions.

"June 25 - June 5 (Binding the code)"
This time would be used to code the main `submodule add`
command using all the helper functions implemented in the
initial phase of coding. This includes binding all the code
together and then completing the command through incremental
reviews. Also, the necessary documentation would be updated
parallelly.

"July 5 - July 12 (Initiate porting of command)"
This time would be utilized in initiating the step-by-step
conversion of the `git submodule add` command.

"July 12 - July 16 (Phase 1 evaluation)"

"July 16 - July 26 (Semester exams)"
I will be taking my semester examinations during this
time. As such, I’ll try to be in touch with the mentors
and take out as much time as possible (around 20 hours a week).

"July 26 - August 10 (Porting the complete script)"
This period would be utilized in the complete conversion of
`git-submodule.sh` into c code and combine it with
`submodule--helper.c` to make a single `builtin/submodule.c`.
As I’ll be completely free from academics during this period,
I’ll try to compensate as much time as possible for the above
period of July 16 - July 26.

"August 10 - August 16 (Final review and evaluation)"
- Final review by the mentors.
- Apply necessary changes and touch-ups.
- Updating documentation, if any left.

"August 16 - August 23 (Submission of final report)"

Additionally: There are places in the original shell script
and c code tagged as `NEEDSWORK`. My aim would be to resolve
these issues within the GSoC period if time permits.
=================================================

##Post GSoC##

After the GSoC period, I plan to continue my contributions
for git and look for other issues to work on. I’d look into
the conversion of other commands which are pending conversion,
as well as work on the `NEEDSWORK` part of the code (If I’m
unable to finish it within the GSoC period itself). I plan on
mentoring new contributors to git and help the contributors
by doing code reviews and solving their doubts and helping
them out.

Regards,
Chinmoy Chakraborty.

=================================================



Thanks,

Chinmoy

