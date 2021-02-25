Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B1C433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4683864F14
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 15:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBYPaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhBYPaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 10:30:17 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1FC061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 07:29:35 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 204so5921899qke.11
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 07:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3HVfnCS9MC9+Bq/vuTPjebsDIVKZeIZx7SwktyQPlo4=;
        b=N57r2Yej00oWLqifefeGL0dJi16aQCVmICXRBdAhhN6r8osPPHAbNK1V29ERFY1xgt
         IBNJK/9XGrQc4VeBEoGjUqI3cCibZcJOvOvcELyaihuO2POz4d3rHWF8tCWtbjmC4rZL
         YnFMMJFk0F0NLUAf7AHzjxl4/QTNjE/Prq8BMPcOg0AeKpiCFBb5vO3t1ByNyO56gU1x
         Cn8Ensj6WYplwrFEsL7saBL0U33X2usN6wEpISyQ+S04DJhBUqXAUxyDgN6GY2nitjTF
         fPfVpfLyuxIi3+5R5FbSMjcsm8yGonaMAbDochzLQocg4aRH8vaChGUy8UW1kl0ivfas
         K+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3HVfnCS9MC9+Bq/vuTPjebsDIVKZeIZx7SwktyQPlo4=;
        b=FepwjofhYv561RXRI0/kWJWHEzDDm3i/9I6KNAfHRrHl4WtZU6MlXBCxOtkDVdtEkq
         mgmRMGbO6AqeaODdZxMFawjpPqYNLQK0O1gZe1YcuqmGzt3x8UqWbUeKDmYY32yC71u9
         y503BIWT8dJleO2fr/C8k8fxaQNWnryByt7ggkK4aYozpXzP/23WvJU8GanCXkzxm9fw
         cT0zei5IJa/OcQb1fVmlMsMlTcVFYMRc8LlJXA9fTb9+2WRfBNDhiNHq5pwgwcp1qG3c
         EMPgojXNwOxVUX/+aFIEYlbOZkwkGvv7xLXbmQeGunxClnwxOivF8nAvGRHpnNRkGAQo
         XX5w==
X-Gm-Message-State: AOAM533jRYPdQrJaH0YJvPINOJidZO+/LlLiffQzMYtqcxVcSzZ/Rjnt
        MZaxPgFdw7YCF+RaH0bL6ew=
X-Google-Smtp-Source: ABdhPJyVtYxpvCzBaPdTj+ik9q+gu75zgBodAgNgmiS1oCFUekWoTSatsBkvgOzELnwaG/k8x8ubGQ==
X-Received: by 2002:a37:4c09:: with SMTP id z9mr3129996qka.9.1614266974216;
        Thu, 25 Feb 2021 07:29:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:89d4:92f7:793a:6399? ([2600:1700:e72:80a0:89d4:92f7:793a:6399])
        by smtp.gmail.com with UTF8SMTPSA id q186sm4127941qka.56.2021.02.25.07.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 07:29:33 -0800 (PST)
Message-ID: <36682d84-826a-a5f0-2309-c4a5fa4b9d73@gmail.com>
Date:   Thu, 25 Feb 2021 10:29:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 01/20] sparse-index: design doc and format update
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <daa9a6bcefbce977606484d502f5cfd7fca63ecc.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BHwRHhYE3BPxCG+fRFWf2dCZ60rnO=ykztquKoOp_x_QQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHwRHhYE3BPxCG+fRFWf2dCZ60rnO=ykztquKoOp_x_QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 8:13 PM, Elijah Newren wrote:
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:>> +This addition of sparse-directory entries violates expectations about the
> 
> Violates current expectations, yes.  Documentation tends to live a
> long time, and I suspect that 2-3 years from now reading this sentence
> might be jarring since we'll have modified the code to have an updated
> set of expectations.  Maybe a simple "As of time of writing, ..." at
> the beginning of the sentence here?  Or maybe I'm just being overly
> worried...

I was hoping that the phrase "this addition of" places this statement in
a moment of time where sparse-directory entries didn't exist, but now they
will. I'm open to alternatives and will give this some thought.

>> +To complete this phase, the commands `git status` and `git add` will be
>> +integrated with the sparse-index so that they operate with O(Populated)
>> +performance. They will be carefully tested for operations within and
>> +outside the sparse-checkout definition.
> 
> Good plan so far, but there's something else bugging me a little here.
> One thing we noticed with our usage of `sparse-checkout` is that
> although unimportant _tracked_ files go away, leftover build files and
> other untracked files stick around.  So, although 'git status'
> shouldn't have to check the tracked files anymore, it is still going
> to have to look at each of the *untracked* files and compare to
> .gitignore files in order to correctly classify each file as ignored
> or just plain untracked.  Our `sparsify` tool has for a long time
> tried to warn about such files when changing the sparsity
> patterns/modules and had an --remove-old-ignores option for clearing
> out ignored files that are found within directories that are sparse
> (Meaning the directories where all files under them are marked
> SKIP_WORKTREE.). I was never sure whether a warning was enough, or if
> pushing that option more made sense, but about a month ago my
> colleagues made the tool just auto-invoke that option from other
> sparsify invocations.  To my knowledge, there have been no complaints
> about that being automatically turned on; but there were
> complaints/confusion before about the directories being left around.
> (Of course, non-ignored files are still left around by that option.)
> 
> I'm worried that since sparse-checkout doesn't do anything to help
> with all these untracked/ignored files, we might not get all the
> performance improvements we want from a `git status` with sparse
> directories.  We'll be dropping from walking O(2*HEAD) files (1 source
> + 1 object file) down to O(HEAD) files (just the object files) rather
> than actually getting down to O(Populated).

This definitely seems like a valuable _enhancement_ to sparse-checkout
that could occur in parallel.

For a workaround in the moment: is "git clean -xdf" sufficient to help
these users?

>> +Phase III: Important command speedups
>> +-------------------------------------
>> +
>> +At this point, the patterns for testing and implementing sparse-directory
>> +logic should be relatively stable. This phase focuses on updating some of
>> +the most common builtins that use the index to operate as O(Populated).
>> +Here is a potential list of commands that could be valuable to integrate
>> +at this point:
>> +
>> +* `git commit`
>> +* `git checkout`
>> +* `git merge`
>> +* `git rebase`
>> +
>> +Along with `git status` and `git add`, these commands cover the majority
>> +of users' interactions with the working directory.
> 
> Sounds like a good plan as well.
> 
> I hope we get to make this specific to the merge-ort backend.  It
> localizes the index-related code to (a) a call to unpack_trees()
> called from checkout-like code (which would probably automatically be
> handled by your updates to git checkout), and (b) a single function
> named record_conflicted_index_entries().  I feel it should be pretty
> easy to update.
> 
> In contrast, the idea of attempting to update merge-recursive with
> this kind of change sounds overwhelming.

Yes, I'm hoping to eventually say "if you are in a sparse-checkout, then
you should use ORT by default." Then, if someone opts to do merge-recursive
instead, then they pay the index expansion cost.

While this is very clear in my head, it might be worth mentioning that
explicitly here.

>>  In addition, we can
>> +integrate with these commands:
>> +
>> +* `git grep`
>> +* `git rm`
>> +
>> +These have been proposed as some whose behavior could change when in a
>> +repo with a sparse-checkout definition. It would be good to include this
>> +behavior automatically when using a sparse-index. Some clarity is needed
>> +to make the behavior switch clear to the user.
> 
> Is this leftover from before recent events?  I think this portion of
> the document should just be stricken.
> 
> I argued about how these were buggy as-is due SKIP_WORKTREE always
> having been an incomplete implementation of an idea at [1], but didn't
> hear a further response from you.  I'm curious if you disagreed with
> my reasoning, or it just slipped through the cracks in a busy schedule
> and this portion of the document was leftover from before.  In my
> opinion, both commands are just buggy and should be fixed for general
> sparse-checkout usage cases, not just for sparse-index.

This is definitely a case of "I've been too busy to read those topics
in detail." I figured that there was something going on that was relevant
to the sparse-checkout and would affect the sparse-index, but I shelved
it in my mind until I had space to think about it directly.

> Anyway, that's a long way of saying I think this section of your
> document is already obsolete.  (Which is a good thing -- less work to
> do to get sparse-index working.  Thanks, Matheus!).

Thank you for your summary, which helps a lot. Thanks, Matheus, too!
If those fixes already include coverage for the behavior, then I'll see
if they also translate to sparse-index tests easily.

I feel like a lot of these later contributions will be more about adding
tests than actually writing a lot of code.

>> +This phase is the first where parallel work might be possible without too
>> +much conflicts between topics.
>> +
>> +Phase IV: The long tail
>> +-----------------------
>> +
>> +This last phase is less a "phase" and more "the new normal" after all of
>> +the previous work.
>> +
>> +To start, the `command_requires_full_index` option could be removed in
>> +favor of expanding only when hitting an API guard.
>> +
>> +There are many Git commands that could use special attention to operate as
>> +O(Populated), while some might be so rare that it is acceptable to leave
>> +them with additional overhead when a sparse-index is present.
>> +
>> +Here are some commands that might be useful to update:
>> +
>> +* `git sparse-checkout set`
>> +* `git am`
>> +* `git clean`
>> +* `git stash`
> 
> Oh, man, git stash is definitely in need of work.  It's still a
> minimalistic transliteration of shell to C, complete with lots of
> process forking and piping output between various low-level commands.
> It might be interesting to rewrite this in terms of the merge
> machinery, though its separate stashing of staged stuff, unstaged
> stuff, and possibly untracked stuff means that there is a sequence of
> two or three merges needed and interesting failure handling to do if
> those merges fail, especially if the user uses --index.  But I
> digress...

I would prefer to leave 'git stash' alone, but it's used by enough
people that I need to care about it eventually.

> Anyway, overall, very nicely written and planned out.  Thanks for
> taking the time to write this all up.

Thanks for your detailed comments!
-Stolee
 

