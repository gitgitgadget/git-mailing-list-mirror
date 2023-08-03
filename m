Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46AC001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 12:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjHCM5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 08:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbjHCM5F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 08:57:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F783C3E
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 05:56:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317b31203c7so859246f8f.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067414; x=1691672214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5venqiygOUH2VGDxsYzL8PZWi0gXJMnwKYnPIaIaKUM=;
        b=EPa30R5z1rzqLMkuuuRn/SraorvgfYCMpBZU99A9zQFPVNzExYinR33lBvcDrc1tqK
         xaHNpNfIsq1p2/nn9kM4C697eQ2Lf3R4wVxxr482+VWDxjs/qErCgjhXjkMIddD3mrY+
         npcCTHNhiG7fQeR+zRy7pcFOR6PEKzDyCEpoyZ8elP6/d5l426uAQUOqPeQ9myqjwTZr
         xy9YZplkYvkgN1ZVRkGhpdTe9wZra2iIDYlBHA/6GP9w4SSKNeCSEDprZGPT9F7XhEvQ
         5dySSlomc2kligGk3oZKi9+vPMRjGPwXKNS4E3CGxGBU9pDwCm9cW5qvbfFsjD6fOxNk
         x+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067414; x=1691672214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5venqiygOUH2VGDxsYzL8PZWi0gXJMnwKYnPIaIaKUM=;
        b=XEBGRIuwpOoFmopi7pYFsTCjzYh18ClSqGBzcwUNaPvBGmYkDMXZ1zpUYrAwgVKESn
         FbEvAHCuxlBPytSvj6NTueyDStmkJ5Yf2hHFianwq9RnsrygmGcA3E1yygapkjchmK1v
         Sc4xlhqjH84N+QJ4rPoN643TsAv6B860mW51h7IwnJgtiQHOo7w6Bd4ASTWrZ2fLJvT5
         O0q6Ftv2vt3fIH8RvdWL6akfsouTB8vCtnNk3P6yQnH7AimBIqwRuX1afy0LOzxUfq+9
         t7vrzkbPeV0NEFXzG4k3qFWQiimvINhfOAPZsiT2U+cygwgiIH3g28m0q67nRlKk/nh0
         SAbg==
X-Gm-Message-State: ABy/qLbCJvb6Hl65DBKvM6DMxpD+Dip8AVxbxv0Jm/kA74vK0AhjRp9U
        rhclkyAGvbX5qeG80SIUHPk=
X-Google-Smtp-Source: APBJJlH06gWi6IFe2WICCq+xb0TvEfxVSh9tzYLu8biYRwmRweKYu6IKsKhm03/QVt8F9RqBe6EuTg==
X-Received: by 2002:adf:e105:0:b0:314:11f3:ca94 with SMTP id t5-20020adfe105000000b0031411f3ca94mr7123030wrz.41.1691067413828;
        Thu, 03 Aug 2023 05:56:53 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s6-20020a1cf206000000b003fbb1a9586esm4260344wmc.15.2023.08.03.05.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 05:56:53 -0700 (PDT)
Message-ID: <d20ffc1f-c3b5-0f64-d508-976098f418e0@gmail.com>
Date:   Thu, 3 Aug 2023 13:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

Sorry for not replying sooner.

On 27/03/2023 08:04, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Sun, 19 Mar 2023, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> As the sequencer executes todo commands it appends them to
>> .git/rebase-merge/done. This file is used by "git status" to show the
>> recently executed commands. Unfortunately when a command is rescheduled
>> the command preceding it is erroneously appended to the "done" file.
>> This means that when rebase stops after rescheduling "pick B" the "done"
>> file contains
>>
>> 	pick A
>> 	pick B
>> 	pick A
>>
>> instead of
>>
>> 	pick A
>> 	pick B
>>
>> Fix this by not updating the "done" file when adding a rescheduled
>> command back into the "todo" file. A couple of the existing tests are
>> modified to improve their coverage as none of them trigger this bug or
>> check the "done" file.
> 
> I am purposefully not yet focusing on the patch, as I have a concern about
> the reasoning above.
> 
> When a command fails that needs to be rescheduled, I actually _like_ that
> there is a record in `done` about said command. It is very much like a
> `pick` that failed (but was not rescheduled) and was then `--skip`ed: it
> still shows up on `done`.

We still do that after this patch. What changes is that when "pick B" 
fails we don't add "pick A" to the "done" file when "pick B" is added 
back into "git-rebase-todo"

> I do understand the concern that the rescheduled command now shows up in
> both `done` and `git-rebase-todo` (which is very different from the failed
> `pick` command that would show up _only_ in `git-rebase-todo`). So maybe
> we can find some compromise, e.g. adding a commented-out line to `done` à
> la:
> 
> 	# rescheduled: pick A
> 
> What do you think?

If a commit is rescheduled we still end up with multiple entries in the 
"done". In the example above if "pick B" fails the first time it is 
executed and then succeeds on the second attempt "done" will contain

	pick A
	pick B
	pick B

It might be nice to mark it as rescheduled as you suggest but this 
series focuses on removing the incorrect entry from the "done" file, not 
de-duplicating the "done" entities when a command fails.

Best Wishes

Phillip

> Ciao,
> Johannes

