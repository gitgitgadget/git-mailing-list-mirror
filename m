Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC36EB64D8
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 22:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFMWRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFMWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 18:17:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7FB3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:17:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so5082474b3a.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686694650; x=1689286650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNsxumgI6Pw8dyJN+AM2i8wAFY5U5UcJr6q1ytCQvhQ=;
        b=X1vT3/9Gjo5n0hYiCPzTNBW04DQNkK673f9ebdi2/2R6LxYtb45M8cmEPrVN2cMgGl
         5Ac6YYJy3aacRUSANEpdCpEiV90TNRx3xpImvMCtH9XXtN5jQimxdGZ5CFwh/1b5HYkp
         i5gw9A8pFv2UGMMT73J+yOWOHsisCIA9pxKNIy5BzED1TWCtM/slu80WR6guyv+x9xqF
         De9nov+ilKIrHriyblY06iYXCe7cUuMX/xIsjb5FCoqJrYsTo7S5DdXdhbsKm87tD0Jc
         y2jejuj7t2cj7ZblxlxfYE2E4c5lXdzn9IJxTUnEHMGfZeu3hROHgwlvEWaVGpUmmPsk
         KvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686694650; x=1689286650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNsxumgI6Pw8dyJN+AM2i8wAFY5U5UcJr6q1ytCQvhQ=;
        b=fZZte/bRoEa50n3zbMB3QES0yCwpB1xsV2D7YXdK4tQSGbThHUw/uYWJoYMAbKkvfy
         fupnU9LGdeF35NshvABXtMdUt+pwJFGETB/1V49ALN3sMui0ZrzwKvrwCAbyydEV5Lm7
         q29ZmJ3CoIZCnl15UgAKcCoF8gPzNhdd7ph9Da2/uViFriH0p+2RpMHh73Fs4A0AhfPc
         HR+vIqblMtsRiBfcmP2n/MfwxtWR225jhSi0l5zXX+DtZhQ0uCGXnhF1uE57s9UXyTw3
         UqxtrP0wlADehqEdvg+cBjKuPdY8ueNB9aZ75Clwa1QhBKLRTCQKWNjHCX+g4wrsi+lU
         iVjw==
X-Gm-Message-State: AC+VfDwQwSlIyjunwYwsEYymPPLRWrCexH3w/82THsSG5q/TAd/zZcIG
        fSVokWJN4NtVByg3++mC54XcMN7h8GbAUZuf1g==
X-Google-Smtp-Source: ACHHUZ5KgUbkhuHFQu3Dfxtav1aQx90M/LUW2bit3DKDwQl2fTjBO7wLpQE2g1xm7wnLZbuqi/nKaA==
X-Received: by 2002:a05:6a00:1a0e:b0:644:8172:3ea9 with SMTP id g14-20020a056a001a0e00b0064481723ea9mr128497pfv.15.1686694650305;
        Tue, 13 Jun 2023 15:17:30 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id e23-20020a62ee17000000b0064550f76efesm9048942pfi.29.2023.06.13.15.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 15:17:29 -0700 (PDT)
Message-ID: <49b82157-0ecb-ad7b-be40-6ea10deec2fe@github.com>
Date:   Tue, 13 Jun 2023 15:17:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/3] Fix behavior of worktree config in submodules
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
 <kl6lfs6v815k.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <kl6lfs6v815k.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  * Added a commit to move 'struct repository' out of 'git_config_source',
>>    rather than creating a dummy 'config_source' just to hold a repository
>>    instance.
>>  * Changed the config setting in the new tests from 'feature.experimental'
>>    to 'index.sparse' to tie these changes to their intended use case.
>>  * "super project" -> "superproject"
> 
> Thanks! Discounting the discussions on the side thread (which we've
> decided are mostly out of scope) I think this version is good enough to
> merge as-is.
> 
> In
> 
>   https://lore.kernel.org/git/kl6llegnfccw.fsf@chooglen-macbookpro.roam.corp.google.com
> 
> I said that this series is better if we squash in a patch to drop the
> setup code from discover_git_directory(), but on hindsight, I think it
> also makes perfect sense for me to send that as a standalone patch. Let
> me know if you plan to squash it in or not so I'll know whether to send
> it :)

Thanks for the re-review! This series was just merged to 'next', so I think
sending the new patch separately would be the least disruptive option.
