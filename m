Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C2C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 13:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjEaNbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjEaNb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 09:31:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734AA1BD6
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:30:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30ad99fa586so5582030f8f.2
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685539788; x=1688131788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kXtt0uc2Tq/7lwlrdpSX08co/9fFjKuGWloqSUC1zFI=;
        b=rsmDzRioINvZiQ0WhhLpisnag1lZZQrWROaB3M8+fZn3PQzetD6GqZjAw52s69hK/t
         tzuEzrl8oorXLoFOk6I5+wZ6l7BV3JGMBX8Vxmc7sGVf7A+jTE3mbrk3lruiPGj5azoR
         FiZ23c9VR8rIPY9yA7kLDiDeJ51QrF+Nc0mm+UVOi5cDmGwTmbFYsDG7OOs9i2LyjVeT
         nAELhEaC0F7j8q3iXAUPI4Gvz7+0R3h4fgDsdE3lwK4wJO7koyAnsYD52/Z5Z9AeOJfw
         F7/rHMqUQLiQqK0Pe0N+wPjxt95ugc8NWa6JXsm2bElfSQUft/YuO2UOLnRMivo1NymC
         zt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539788; x=1688131788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXtt0uc2Tq/7lwlrdpSX08co/9fFjKuGWloqSUC1zFI=;
        b=SZOY4H37Y7gya8gV/JzDE3ZC69hC23JpR8WgN2dqpiXanJ7G9/kQMm5rvxEABIXY3K
         KL9sqTQVCrOdWpTUqI0Wf1M1jayWZ44XJAI8kfQV7+NAypE6G7kbwPH1JntnmoHFIMtK
         NJklGbaVlOXBWGeDyLpB3CcMTDtEtp7VNTnbtBXf5KGTOHD8c0EhuK6zxRAN0XyBFV5W
         WjdnUUuHNAXyRbI+qKsj2pjmGr2Z9iGo9N1NNxZL3QLsVwzWxR3rjPIdJs2hqqqQ6mDb
         5K52VKz1r/en7lzFY10ifPRFHJAg3iardlbySqotyS4hoFgC5qLHaTqTEPfarvLiFCma
         tgOw==
X-Gm-Message-State: AC+VfDzazWV7BYZq2Ye3oOi4UAFarR+WXLsppcS1UV/X4riMzvfKIpn8
        BJ4WojN5KQ7X9fd5W6k/OG0=
X-Google-Smtp-Source: ACHHUZ49fuVdh4GnR7BwrdiFRzYkfqBkzoTFs1dTTy/irspGWhE5fc8/7SbyTYjmAIu4/L4MLNkNwQ==
X-Received: by 2002:a05:6000:104:b0:309:566f:3cd with SMTP id o4-20020a056000010400b00309566f03cdmr4060723wrx.6.1685539788159;
        Wed, 31 May 2023 06:29:48 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id 17-20020a05600c231100b003f31d44f0cbsm24642833wmo.29.2023.05.31.06.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:29:47 -0700 (PDT)
Message-ID: <c180ce59-459b-ee99-e4c0-c2fa6c765d77@gmail.com>
Date:   Wed, 31 May 2023 14:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: notes handling broken on rebase
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
References: <20230530092155.3zbb5uxa7eisdzxb@pengutronix.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230530092155.3zbb5uxa7eisdzxb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Uwe

On 30/05/2023 10:21, Uwe Kleine-König wrote:
> Hello,
> 
> I found a bug in git rebase and how notes are retained using
> 
> 	uwe@taurus:~/tmp/gittest$ git version
> 	git version 2.41.0.rc2.161.g9c6817b8e7dd
> 
> , it also happens with 2.39.2.
> 
> Here comes a reproducer:

Thanks for reporting this and taking the time to provide an easy 
reproducer. I think the problem is that when git drops the commit in 
do_pick_commit() it still gets recorded as rewritten and so the notes 
are copied. To fix it we need to improve do_pick_commit() to return a 
value indicating that the commit was dropped so that we don't call 
record_in_rewritten() in pick_commits().

Best Wishes

Phillip


>   - Create some initial git history, just three commits A, B and C:
> 
> 	uwe@taurus:~/tmp/gittest$ git init
> 	Initialized empty Git repository in /home/uwe/tmp/gittest/.git/
> 
> 	uwe@taurus:~/tmp/gittest$ for i in A B C; do echo content $i >> file ; git add file ; git commit -m "$i" ; git notes add -m "notes for $i" ; git tag $i ; done
> 	[main (root-commit) db2548de5a3c] A
> 	 1 file changed, 1 insertion(+)
> 	 create mode 100644 file
> 	[main 2b8fa82afb3c] B
> 	 1 file changed, 1 insertion(+)
> 	[main 3dd5e4a2037e] C
> 	 1 file changed, 1 insertion(+)
> 
>   - Pick C on top of A:
> 
> 	uwe@taurus:~/tmp/gittest$ git checkout A
> 	HEAD is now at db2548de5a3c A
> 	uwe@taurus:~/tmp/gittest$ git cherry-pick C
> 	Auto-merging file
> 	CONFLICT (content): Merge conflict in file
> 	error: could not apply 3dd5e4a2037e... C
> 	hint: After resolving the conflicts, mark them with
> 	hint: "git add/rm <pathspec>", then run
> 	hint: "git cherry-pick --continue".
> 	hint: You can instead skip this commit with "git cherry-pick --skip".
> 	hint: To abort and get back to the state before "git cherry-pick",
> 	hint: run "git cherry-pick --abort".
> 	Recorded preimage for 'file'
> 	uwe@taurus:~/tmp/gittest$ { echo content A; echo content C; } > file
> 	uwe@taurus:~/tmp/gittest$ git add file
> 	uwe@taurus:~/tmp/gittest$ git cherry-pick --continue
> 	Recorded resolution for 'file'.
> 	[detached HEAD 6cfc9b7bd437] C
> 	 Date: Tue May 30 11:02:13 2023 +0200
> 	 1 file changed, 1 insertion(+)
> 
>   - Rebase {B, C} on top of A + C' (which results in skipping C):
> 
> 	uwe@taurus:~/tmp/gittest$ git rebase HEAD C
> 	Auto-merging file
> 	CONFLICT (content): Merge conflict in file
> 	error: could not apply 2b8fa82afb3c... B
> 	hint: Resolve all conflicts manually, mark them as resolved with
> 	hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
> 	hint: You can instead skip this commit: run "git rebase --skip".
> 	hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
> 	Recorded preimage for 'file'
> 	Could not apply 2b8fa82afb3c... B
> 	uwe@taurus:~/tmp/gittest$ { echo content A; echo content B; echo content C; } > file
> 	uwe@taurus:~/tmp/gittest$ git add file
> 	uwe@taurus:~/tmp/gittest$ git rebase --continue
> 	Recorded resolution for 'file'.
> 	[detached HEAD e5b3e28216f2] B
> 	 1 file changed, 1 insertion(+)
> 	dropping 3dd5e4a2037ecd31f5470561638cb065434eabbc C -- patch contents already upstream
> 	Successfully rebased and updated detached HEAD.
> 
> Now I have:
> 
> 	uwe@taurus:~/tmp/gittest$ git log --pretty=oneline --abbrev-commit --notes
> 	e5b3e28216f2 (HEAD) B
> 	Notes:
> 	    notes for B
> 	
> 	    notes for C
> 
> 	6cfc9b7bd437 C
> 	db2548de5a3c (tag: A) A
> 	Notes:
> 	    notes for A
> 
> The surprising part here is that (the new) B also has C's note. I would
> have expected that it only has its own one. I quickly looked into the
> source code, but didn't find an easy fix because the code that notices
> that C should be dropped (in do_pick_commit()) isn't where the note is
> copied (which I didn't find).
> 
> Best regards
> Uwe
> 

