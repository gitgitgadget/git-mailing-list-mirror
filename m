Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6CC6FA82
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiI2JRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 05:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiI2JRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 05:17:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212B127CBA
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 02:17:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x15so674129wrv.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=HkdVM5absdUwDu3os/gBSMqpNx7yBYMOy+CHivf0l9Y=;
        b=D8O5VMbF8B4gbWZTBBNH++niWyOKA/sw4ZvhQCd1cywn7y1zHoQpExEkuzMuK2oklV
         cmjQdfxkKc3KhpmT103zEWyk22fEhSuM02hOdI2mC33B8Z7qFFGAmr6y8OsFnR2TJbEv
         ClGxXDzSgy7LWCsO/BxN9ebNdM11ePYoRr0gajBLz127UvzEKTQA/BSQ7+3/mgNOGw47
         2OD/N1x47Xd+EJs0F8/meUZSK6q0cD/c8jGMGeCFMYGv/whjA8WgO5XyxY5LG4px+P9Y
         c7fc4tyihlQObdaOnQwDE+hX/iN7AHB8Qiy8o3QuDeQyEREEfu2RUAgqnHValR5iPLVW
         cyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HkdVM5absdUwDu3os/gBSMqpNx7yBYMOy+CHivf0l9Y=;
        b=eNdWEW8cPgJeQnFj3rrYyKVMrhqCWS4C9OlLnbVPFJcflvvv48BkT3BBEHefyPzbK/
         20DWo8AYIHTc50tPtgElhzNE7xX8bOegJoM0mc4AblpGSKg4NV9fBYQk3Ipn2NEl51xM
         9dgV+8cv4+NSpS0KOEveL6GG6T43U+hLbbaNI6eZ0RhAdgZ6yB4+wRrSzFPGhYTFE4YO
         Bi7YOGw/Omc1DJ+559HNvLZxs2F/6AOpgMTRkF4TCWUdnNmKJGYGukhVFV7yawp6cSkg
         5ol3f2vD5s516C2WNKhK9HgnNshDw9g6ZqwGyriALnDSHxLGE5ZtiEmn2bZxvSWUxcma
         6p9w==
X-Gm-Message-State: ACrzQf0QEbd8aLZgVgH+SIsgjMw+8J5VJtFMKKkob3FpDk9dVJ9mxUSR
        1ApnzhKEwMOYCIU6q6nRge0=
X-Google-Smtp-Source: AMsMyM6N5uMtSh4eeOuZfiUIKn4N/Q6WFsbrXSmwKlZH2sI6STjdIUZc8fOqj11Mj0SflvBybncDow==
X-Received: by 2002:a05:6000:16c5:b0:22c:bdbd:e06b with SMTP id h5-20020a05600016c500b0022cbdbde06bmr1480276wrf.53.1664443022814;
        Thu, 29 Sep 2022 02:17:02 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id q3-20020adfcd83000000b0022cdb687bf9sm313503wrj.0.2022.09.29.02.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:17:02 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <87e7da54-b9cf-cf35-3742-640462e11ceb@dunelm.org.uk>
Date:   Thu, 29 Sep 2022 10:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/10] technical doc: add a design doc for the evolve
 command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <a0cf68f8ba2adefae4fceeab0d438d05e355e695.1663959324.git.gitgitgadget@gmail.com>
 <xmqqedvvqgxh.fsf@gitster.g>
In-Reply-To: <xmqqedvvqgxh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/2022 23:20, Junio C Hamano wrote:
> "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +Rebase
>> +------
>> +In general the rebase command is treated as a modify command. When a change is
>> +rebased, the new commit replaces the original.
>> +
>> +Rebase --abort is special. Its intent is to restore git to the state it had
>> +prior to running rebase. It should move back any changes to point to the refs
>> +they had prior to running rebase and delete any new changes that were created as
>> +part of the rebase. To achieve this, rebase will save the state of all changes
>> +in refs/metas prior to running rebase and will restore the entire namespace
>> +after rebase completes (deleting any newly-created changes).

That wont work now that we have multiple worktrees. If a user starts two 
rebases of two different branches in two different worktrees and aborts 
one of them we loose the new meta-commits of both. Each rebase will need 
to track which refs under refs/metas/ it has updated (that will also 
save the overhead of copying the entire refs/metas/ subtree).

> Newly-created
>> +metacommits are left in place, but will have no effect until garbage collected
>> +since metacommits are only used if they are reachable from refs/metas.
> 
> One thing that makes me nervous is how well your analysis capture
> "unusual" but still reasonable ways to use these commands, as the
> workflows of people are quite different.
> 
> For example, I almost never do "git checkout topic && git rebase
> origin"; instead I would do "git checkout topic && git rebase origin
> HEAD^0" to first make a detached HEAD out of the topic, in order to
> have two copies explicitly available to be compared after "rebase"
> finishes.  After doing so and get satisfied by the result of
> comparison between topic and HEAD, I may do "git checkout -B topic"
> to update.  Would that leave exactly the same set of metacommits as
> the case where I didn't do the "first rebase the detached HEAD and
> then update the bracnh for real" and instead "rebase the topic"
> directly?

As I understand it we have a ref under refs/metas/ for each commit. If 
that understanding is correct the two cases you describe should be 
recorded identically I think.

Best Wishes

Phillip
