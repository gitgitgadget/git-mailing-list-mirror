Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9DCC6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiI0Qmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiI0Qmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:42:36 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C111E05F0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:42:35 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l4so5396816ilq.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ljlnMZcD8DEkKkwrMvTo7dQFUndpImVptAOHJJ8TgIA=;
        b=jQzMolFHzb3p3q5NPvROI8PMoSAHG5sSdl41e5j9nbnpu3x/JsdFGz0jS9e9qGJZ8R
         cfRFPsY6DEDbixGZr9F6PlEg7LTWxbOYLxs9bWSlpY+Qh+NaLlB2w7mUd8SijreW4nYV
         BjL4ILzTQJ0TCBWQQAlggrM6Q44pYwcCI1vaiCd4Z761X74Pt0dSSi9yOJdeJxyLjLUA
         NL4E7rShkJbfgLJjRzQ03aalK315LsQZ/C0ByBbJ5IkETd8X/SaIsCQafjjCsILSlyCp
         wa5t0ZBsWjsbQhTlKRfGJsH8un1jtr2KYkB/iMuiOm9++A2AG4/Bx7jCR8i6uDutrztf
         6p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ljlnMZcD8DEkKkwrMvTo7dQFUndpImVptAOHJJ8TgIA=;
        b=7xhP0U5EB1tR4PcNMRIVbCwzPHwEW+MB+NCtVEs4ipKq35Q/DjlEEjjgpDrh5JC1NW
         J0D7cD31Svw5VSP3QHDFRgWRrUGVPo7zSmSM1+whEYmCYSNL32yPfINtkDj104oU563U
         v78ZG3pIboudFdj/Q3354nKExXSk+Oxf3NkjrO6Vy8/QN7Xq0tYM/LJXscaVt6ScMocA
         VsmE9lgV8FH/euSmpFLB1w5M4U5dYdSpWhx3+iKT1xpmekvOZXlR0SFKBPUA72Cx1gUA
         e+aLzy9U0TrYciH86jTwV4AUGtvluiBskYMseOdY6lu3+F6l/IuEyWDIeeKiIG55xMaa
         KtRQ==
X-Gm-Message-State: ACrzQf2jg+6dh82q7WzD4yIkfeYIDTw6weREZnsLPhqSX/pC4S8/pOMP
        cgtrwDcwcawbtCaNvdm6faJB
X-Google-Smtp-Source: AMsMyM7+1KNFBaMS0VsCyt/HGGIDJPYFYw6RisvUsWdzANCTCH9Gv4GV6lNIRXviGi4yr9ISjcmOhQ==
X-Received: by 2002:a92:8704:0:b0:2e0:ddf6:6390 with SMTP id m4-20020a928704000000b002e0ddf66390mr12912497ild.16.1664296955245;
        Tue, 27 Sep 2022 09:42:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663810e600b00349fb9b1abesm791356jae.106.2022.09.27.09.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:42:34 -0700 (PDT)
Message-ID: <ea32aef1-2899-abae-0192-75d672b69302@github.com>
Date:   Tue, 27 Sep 2022 12:42:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <a89413b5-464b-2d54-5b8c-4502392afde8@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a89413b5-464b-2d54-5b8c-4502392afde8@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2022 4:08 PM, Victoria Dye wrote:
> Elijah Newren via GitGitGadget wrote:
>> +=== Purpose of sparse-checkouts ===
>> +
>> +sparse-checkouts exist to allow users to work with a subset of their
>> +files.
>> +
>> +The idea is simple enough, but there are two different high-level
>> +usecases which affect how some Git subcommands should behave.  Further,
>> +even if we only considered one of those usecases, sparse-checkouts
>> +modify different subcommands in over a half dozen different ways.  Let's
>> +start by considering the high level usecases in this section:
>> +
>> +  A) Users are _only_ interested in the sparse portion of the repo
>> +
>> +  B) Users want a sparse working tree, but are working in a larger whole
> 
> Both of these use cases make sense to me! Two thoughts/comments:
> 
> 1. This could be a "me" problem, but I regularly struggle with "sparse"
>    having different meanings in similar contexts. For example, a "sparse
>    directory" is one *with* 'SKIP_WORKTREE' applied vs. "the sparse portion
>    of the repo"  here refers to the files *without* 'SKIP_WORKTREE' applied.
>    A quick note/section outlining some standard terminology would be
>    immensely helpful.

This difference is absolutely my fault, and maybe we should consider
fixing this problem by renaming sparse directories something else.
Perhaps "skipped directory" would be a better name?

Thanks,
-Stolee
