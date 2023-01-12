Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613FDC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjALQ3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjALQ2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:28:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A5B7D7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:26:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id az7so18620141wrb.5
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48iWqy31WYW9jWn7PNv54345Lio9cFqwFm1jQTrL4XY=;
        b=kPumCSax7GY3YHV+ltsAas3pKM1GTK08UUs7aAe4E4530efIDbxY7nDgX9e+f6JRor
         t10vWR5f3uy1ZUhnLFLJ4RXKcFE+15bLlhlzTcxMraIrzCZlt8NlnHcH5bXCnU/MbWhV
         qOHjrPL+DZRmTvGPD6t/HJVL0PpEvi5dTT2SkW9ZcPneuNw3D9CHjHl8a0XMDOzyEbXR
         Y1ILo1k1LIATzWJpjPL/nL3eY+dHiCIAjv4v0z6VUtqq4v0sNt7KmAk6VT6pNutqTzM+
         2QdmG6d9/iu1yQ4z/fE4gNe+0LryDSFVa61R+LPHB81scypXSGU7M90zGwJY72wJHFZd
         P7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48iWqy31WYW9jWn7PNv54345Lio9cFqwFm1jQTrL4XY=;
        b=kRi25upWA0fclbv/+g1S5fGVaKtp4HIwL0Tkue54V3r7MqwcoR3Qw0m8a90kcR/uR+
         WKxj7m7nrHvYYE2ANURsc0Al54LNfo3pqobK/1+ORbeX/aFBBIvXq+l2NVDfRUPwj0aN
         ffWeqXAAef/SQCnsi2ev/hizUt0975tj3RwR5qGILUfRdlFHoKeadHD87jhsroQJDb9m
         AEbU3qXxO6q9fbQ3mUADzELTUSqWwYbovxLD/3psZFGjtC0KaElIcuDmqMU98HMYvSPQ
         ueSQROgUk2jhN5G4xmTAYftquv0/rWgfvx287rL1gIfVfCErCVLOfvQWEN6TamXrZzaV
         gw6w==
X-Gm-Message-State: AFqh2koeEaOR/6V2BXSR+y2gDmMgptQNrqLob77KInmWyL/Nc7UivwZa
        hZrfOVNtWtIDtRNphcIwzXE=
X-Google-Smtp-Source: AMrXdXubm6NJY+hGAFbqCyRHbhON9ulyesv4dmMhb+szoibxPi0mWvmfexQpBt4fg5ZDkWfPA3pUVA==
X-Received: by 2002:a05:6000:4004:b0:242:bef:80a1 with SMTP id cy4-20020a056000400400b002420bef80a1mr53550941wrb.2.1673540770591;
        Thu, 12 Jan 2023 08:26:10 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm20954737wmc.34.2023.01.12.08.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:26:10 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <569052f5-1573-f500-25d8-ac893b27dbd0@dunelm.org.uk>
Date:   Thu, 12 Jan 2023 16:26:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Content-Language: en-US
To:     Andrei Rybak <rybak.a.v@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <eaa80cb6-231b-10f2-74f4-b55d1a8cb1f5@gmail.com>
In-Reply-To: <eaa80cb6-231b-10f2-74f4-b55d1a8cb1f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei

Thanks for taking a look at this

On 12/01/2023 11:14, Andrei Rybak wrote:
> On 12/01/2023 11:36, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When adding a "break" command to a rebase todo list it can be helpful to
>> add a comment as a reminder as to what the user was planning to do when
>> the rebase stopped. Anything following the command is interpreted as an
>> argument to the command and results in an error. Change this so that a
>> "break command may be followed by "# <comment>" in the same way as
>> a "merge" command. Requiring the comment to begin with "# " allows the
>> break command to start taking an argument in the future if that turns
>> out to be useful.
>>
>> Reported-by: Olliver Schinagl <oliver@schinagl.nl>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>      rebase -i: allow a comment after a "break" command
>>      I'm open to suggestions for other ways to handle comments but 
>> copying
>>      what we do to separate merge parents from the merge commit subject
>>      seemed simplest.
>>      Should this print the comment when stopping for a break command?
> 
> Technically, the user can look up the command via `git status`, but it
> would make sense to just give the user this information directly,
> similar to how exec command prints "Executing: ..." in addition to the
> existing break command's message "Stopped at ...".

Yes I think that is probable a good idea.

>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index f9675bd24e6..511ace43db0 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the 
>> commit, and continue
>>   rebasing.
>>   To interrupt the rebase (just like an "edit" command would do, but 
>> without
>> -cherry-picking any commit first), use the "break" command.
>> +cherry-picking any commit first), use the "break" command. A "break"
>> +command may be followed by a comment beginning with `#` followed by a
>> +space.
> 
> A corresponding update to append_todo_help in rebase-interactive.c
> would be helpful.

Thanks that's a good suggestion.

>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index 130e2f9b553..18d82869b38 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -266,6 +266,22 @@ test_expect_success 'the todo command "break" 
>> works' '
>>       test_path_is_file execed
>>   '
>> +test_expect_success 'the todo command "break" accepts a comment' '
>> +    rm -f execed &&
>> +    test_write_lines "break # comment" "break #" "exec >execed" 
>> >expect &&
>> +    write_script cat-todo.sh <<-\EOS &&
>> +    GIT_SEQUENCE_EDITOR="grep ^\[^#\]" git rebase --edit-todo >actual
>> +    EOS
>> +    FAKE_LINES="exec_./cat-todo.sh break_#_comment b_# exec_>execed" \
> 
> It seems that helper set_cat_todo_editor could be used here, except that
> tests in t3418-rebase-continue.sh use a global set_fake_editor at the
> very top of the file, unlike tests in t3404-rebase-interactive.sh which
> call set_fake_editor individually.  See also related commits 6a619ca03c
> (t3404: remove uneeded calls to set_fake_editor, 2019-10-15) and
> b2dbacbddf (t3404: set $EDITOR in subshell, 2019-10-15).

I did look at using set_cat_todo_editor but it isn't that simple. It 
cannot be used with set_fake_editor so I'd need to find another way to 
supply the todo list and it always exits with a failure.

As well as checking that "break" accepts a comment this test also checks 
that the comment is still present when the user re-edits the todo list 
which is tricky to do with set_cat_todo_editor.

Best Wishes

Phillip
