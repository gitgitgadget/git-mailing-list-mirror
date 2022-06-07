Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5458C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbiFGKMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbiFGKME (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 06:12:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B442BEBA89
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 03:12:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p10so23432678wrg.12
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2uWIoUwyOAhs9Ejr7WdQAAaz8v7kn0CskGWoz5as764=;
        b=MmGVa/yH1LS5DZzkTJeHg64nl3rZ6cMjoGGzfN7TlgBj0QfxGc7yxoDzteyy1qcjUd
         qoCW1VUmgZsAlsZMj1iNcZiBl4VwwrIM4hFHk2bP/Oqbww4JHdaNPLubqyHyzQTdVHHr
         zuQU+pUvj/gSl5gAN9utoBKViX1NPMw3Qn+iOAtefiIDmEFfad/SwHMcU2bgalNzN6C3
         ECGWVttADRX6oOCFYjj7V9ZBRlckX9FDEy3ZG54rQnmpEljPC1AHiKk2LcjjdJSBPJ7f
         0ynfDTIfnj7stxoAnRl6liugTWcUu+VjGJcTc/A4tax3pLj8NZN3G6ESqBjHDu/Ip2ot
         iwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2uWIoUwyOAhs9Ejr7WdQAAaz8v7kn0CskGWoz5as764=;
        b=t8/3Yjt79xfMNEfeMcMH7I+ZtxcE7KBrilsS+vVcjBVZIfAMoLVf4ePEfNqAKhNDkL
         v86egKuYceFSlX5EnyKmXiovCqPxmuYT8pA71uGPu0kl6jCo46dY4koeuGH256KSkzE8
         wV2WTy2SDfE9pAPR9zZMY5CAktdhR2aFCrwDv4i7oZZVd0N5Qmbzep69jK2M8zJe/Uaz
         mDi8+g5Hb7bGdZiUyGslKqktHUU9mRjqaUwoemnhtN4X43lk/7JjUhbdtq7Yn4WqRuoS
         gCl4QWdz9ZFEeI2oIjd+r4OpeZkfm3xgqOX77EMU9Nv503yN2VqQ1VTuFXPGsA0r1Aaz
         gcSA==
X-Gm-Message-State: AOAM5332xK8iFrCDErS26cytTBmN2KOSZjBhQRcHmMVvRUbKVobkreFO
        r7Bn7nDn4At79SrDBg9X9cA=
X-Google-Smtp-Source: ABdhPJzOY1Cdjeess/e4wD0ls6YtYGEpc84Uc6vcfDHln/guo42BhrSxBSptXGKoSn1TWHkUJNIHZg==
X-Received: by 2002:a5d:4d8f:0:b0:210:3e14:ff27 with SMTP id b15-20020a5d4d8f000000b002103e14ff27mr27125819wru.81.1654596719162;
        Tue, 07 Jun 2022 03:11:59 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000184a00b0021033caa332sm19840301wri.42.2022.06.07.03.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 03:11:58 -0700 (PDT)
Message-ID: <90ccd923-3552-fe88-5d6d-869def7f1aeb@gmail.com>
Date:   Tue, 7 Jun 2022 11:11:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
Content-Language: en-GB-large
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <YppSl4rOvVciLuXE@nand.local>
 <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
 <3bb8baa2-e3e0-5cf1-aace-b0ba3ec6eb77@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3bb8baa2-e3e0-5cf1-aace-b0ba3ec6eb77@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06/2022 16:12, Derrick Stolee wrote:
> On 6/4/2022 11:28 AM, Phillip Wood wrote:
>> On 03/06/2022 19:27, Taylor Blau wrote:
>>> On Fri, Jun 03, 2022 at 01:37:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>> This is a feature I've wanted for quite a while. When working on the sparse
>>>> index topic, I created a long RFC that actually broke into three topics for
>>>> full review upstream. These topics were sequential, so any feedback on an
>>>> earlier one required updates to the later ones. I would work on the full
>>>> feature and use interactive rebase to update the full list of commits.
>>>> However, I would need to update the branches pointing to those sub-topics.
>>>
>>> This is really exciting. I'm glad that you're working on it, because I
>>> have also wanted this feature a handful of times over the years.
>>
>> Yes, thank you Stolee. I agree this will be useful, but I wonder if users
>> will be confused that --update-refs only updates the branch heads that happen
>> to be in the todo list, rather than updating all the branches that contain a
>> rewritten commit. I think the latter is something we should try to add in the
>> future and so we should take care to design this topic so that is possible.
> 
> At the moment, the design adds a comment to the TODO list, showing which
> branches are not possible to move because they are checked out at another
> worktree (or is currently checked out and will be updated by the rebase
> itself). That seems like a good place to insert alternative logic in the
> future if we see a need for better behavior here.

I think the question of whether to update branches that are checked out 
in another worktree is a question of whether it is less inconvenient to 
the user to skip the ref update and leave the user to manually update 
the branch or to update the ref and leave the worktree in a potentially 
awkward state if the user was half way through building a commit. The 
answer probably depends on the preferences of the user.

I've been using a script that updates the refs for all the branches 
being rewritten for a while and have found it preferable to always 
update the ref rather than have to do it manually. My script also 
updates the worktree checkout to the new HEAD if there are no 
uncommitted changes which I have found very convenient. My preference is 
probably because I tend not to have uncommitted changes lying around in 
the worktrees whose branches get updated.

> Unless: am I misunderstanding something about your concern here? Are you
> worried about refs outside of refs/heads/*? Are you concerned about it
> being _all_ refs/heads/* that we find?

My concerns are primarily about being able to extend the --update-ref 
option in a backwards compatible way.

I'd like to be able to add functionality to rebase all refs/heads/* that 
are descended from the commits that a simple rebase would rewrite. Say I 
want to edit $commit then I want the rebase to rewrite all the commits 
and update all the branches in in

     git rev-list $(git for-each-ref --contains $commit refs/heads/) 
^$commit^@

Ideally we'd avoid adding a new commandline option when adding that. I 
think we could use an optional argument as you suggest below (though it 
would not be a refspec).

> One potential way to extend this (in the future) is to make --update-refs
> take an optional string argument containing a refspec. This would replace
> the default refspec of refs/heads/*.
> [...]  
>> Instead of using 'label' and 'exec' I'd prefer a new todo list command
>> ('update-ref' or 'update-branch'?) used in place of 'label' that takes a
>> branch name and updates the branch ref at the end of the rebase. That
>> would make it easy to do all the updates in a single transaction as you
>> suggested. Adding exec lines to do this makes the todo list messy and we
>> have been trying to stop rebase forking all the time.
> 
> Thanks. Yes, a new 'update-refs' step at the end would be good to make
> it clear we want to rewrite the refs in one go without a possible
> interruption from the user.

That's great, it is a bit more work for you but I think it gives a much 
nicer UI.

Best Wishes

Phillip

> Thanks,
> -Stolee
