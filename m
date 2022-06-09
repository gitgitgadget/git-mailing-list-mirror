Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD30C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 10:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbiFIKEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFIKEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 06:04:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6532FD0
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 03:04:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u8so27350564wrm.13
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VG5r+5OiaLuvlDQqXMKMRc16tg+U8faNFogIh/QMJEo=;
        b=M5cpQgXicE/+n0UKkgcWspM8juMxpuBAkzm3J7LgKkHseUhuJpbDarSzvuD9pkgcj2
         THxZZMXa9MMe0UEcf6+xmqK/Ay6TQ1GMlm1pQc3XDrrG6pbRO/VVLfnWEZhiB4dSLDHd
         jeuMIjaCL8pItTNHGKAur0aflWrIfrEzd5gHezM9MAG/jcmVZ17ex4fBnbGikdQ6XC4j
         FZiq1VsSeD/6LnI4Ds4N2RLMgt9fw/CPSLyaiYF4oI2UOL5s2FABaWVwfxEc4bYdgoTl
         GL3tNiCgR9amy7l3BamEdfaeSD0+MvKDsqK+1QXP/8BBHDehjuoNC1D27Z2h1wjluohz
         3Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VG5r+5OiaLuvlDQqXMKMRc16tg+U8faNFogIh/QMJEo=;
        b=l88S1lcEvzS08QwRVJHA7wHvgnXgeZrWQ0s0IIjSOfkM9g/q9MN5Z5rL6QAII6OYa/
         16R9CCQS5q1MsKrhwL1ouULATTQX1HDq1/1Nnq7yHL/n3kIET3N8T/63gi86sYz1q1Sv
         vy/TFj4rdYCsIoPliqmNbq2z2WnS+5uhBIXUtrUhjAJO8l72XsAE9WO6fsrdU4OkBcWV
         F24W0qTkJSXkfBVuisvzML5kTUysz0PItlVvkjd0yRb6cQiGsRToSEJ6fa/RrNFUabcA
         0bTId2Xe/yD8pgDkjUYex4kv/5SlLVGXW9qEzEuyuM1a3bnkZMsvqaL5DdQpKeTBJL1s
         QZ0w==
X-Gm-Message-State: AOAM53156jcz9gK/Wto1kS24KgnFBaSenOsjM1QxQWEITikb6AbnKztZ
        DAAm5+tzvrPOjbXKQ6YFN/g=
X-Google-Smtp-Source: ABdhPJwVnND6Ppoh8kzvURusx6Bb94Icr07gYr3bO/Szgv2PM3BgtQ/gRf9Q2MSkC5ZE5F0PQhalcw==
X-Received: by 2002:a5d:6d8b:0:b0:218:4de1:25a0 with SMTP id l11-20020a5d6d8b000000b002184de125a0mr14612706wrs.8.1654769050153;
        Thu, 09 Jun 2022 03:04:10 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4fc1000000b0020fc4cd81f6sm23700724wrw.60.2022.06.09.03.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 03:04:09 -0700 (PDT)
Message-ID: <2e6affba-f9ba-56da-20d6-009c5f2fbfd7@gmail.com>
Date:   Thu, 9 Jun 2022 11:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/7] rebase: update branches in multi-part topic
Content-Language: en-GB-large
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <ac135ece-a901-5868-f28c-2161d7a62e97@gmail.com>
 <34264915-8a37-62db-f954-0b5297639b34@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <34264915-8a37-62db-f954-0b5297639b34@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 08/06/2022 19:09, Derrick Stolee wrote:
> On 6/8/2022 10:32 AM, Phillip Wood wrote:
>> Hi Stolee
>>
>> On 07/06/2022 21:42, Derrick Stolee via GitGitGadget wrote:
>>> [...]
>>> As an example, here is my in-progress bundle URI RFC split into subtopics as
>>> they appear during the TODO list of a git rebase -i --update-refs:
>>>
>>> pick 2d966282ff3 docs: document bundle URI standard
>>> pick 31396e9171a remote-curl: add 'get' capability
>>> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
>>> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
>>> pick 6adaf842684 fetch: add --bundle-uri option
>>> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
>>> label for-update-refs/refs/heads/bundle-redo/fetch
>>> [...] update-refs
>>> [...]
>>> Based on some of the discussion, it seemed like one way to do this would be
>>> to have an 'update-ref ' command that would take the place of these 'label'
>>> commands. However, this would require two things that make it a bit awkward:
>>>
>>>    1. We would need to replicate the storage of those positions during the
>>>       rebase. 'label' already does this pretty well. I've added the
>>>       "for-update-refs/" label to help here.
>>
>> I'm afraid I don't think that using a label with a name constructed from
>> a magic prefix and the full refname is a good user interface.
>>
>> (i) Having labels behave differently based on their name is confusing.
> 
> The label commands do as advertised, but the 'update-refs' command does
> something with the set of refs based on their names, yes. We would need to
> store this information during the rebase _somewhere_, and refs/rewritten/
> seems natural.
>   
>> (ii) The length of the label string is cumbersome for users. Rebase already
>> has a reputation for being unfriendly and hard to use, this will not improve
>> that. "update-ref bundle-redo/fetch" is much simpler.
> 
> I agree that your proposed replacement for "label for-update-refs/..." would
> look cleaner. I don't think that that is enough to justify hiding information
> from the user.

In general I think it is better not to burden the user with unnecessary 
information - it makes the ui more complicated and exposes 
implementation details which makes it harder to change the implementation.

>> (iii) It means that we no longer store the oid of each branch when creating> the todo list and so cannot check if it is safe to update it at the end of the
>> rebase (just using the current value of the branch ref at the end of a long
>> running operation like rebase is not sufficient to be safe).
> 
> The operation we are doing necessarily requires a force-update, since we are
> modifying history. The safety you are caring about here is about the case where
> the user modifies one of these refs between the initial 'git rebase --update-refs'
> and the final 'git rebase --continue' that actually writes the refs. You want to
> prevent that final update from succeeding because another change to those refs
> could be lost.
> 
> I'm less concerned about this case, because the user is requesting that we
> update the refs pointing to this set of commits. But, I'm glad you brought it
> up.

At the end of the rebase we pass the oid of the branch that we store at 
the start of the rebase when updating the ref to avoid nasty surprises. 
I think it makes sense to do the same for the other branches being 
rewritten - it is easy to get stuck on a conflict resolution and go and 
do something else for a while and forget a branch is being rebased. If 
we cannot update the ref at the end of the rebase we should print the 
new oid with instructions to run "git reset --hard" or "git update-ref" 
if the user wants to update the branch.

> One way to prevent this situation would be to extend the idea of "what branch
> is being rebased?" (REBASE_HEAD) to "which branches are being rewritten?"
> (REBASE_HEADS?). 

Just to clarify REBASE_HEAD points to the commit we're currently trying 
to pick, the branch ref is stored it .git/rebase-merge/head-name and its 
oid in .git/rebase-merge/orig-head

> If the worktree kept the full list somewhere in the $GIT_DIR,
> then other Git commands could notice that those refs are currently being
> overwritten and those updates should fail (similarly to how we currently fail
> to update a branch being rebased).

That's a good point and one that I should have remembered as I 
implemented that check in my script. I agree that we should stop the 
user starting a rebase in a worktree whose branch is being updated 
elsewhere. If we write a list of the refs we want to update under 
.git/rebase-merge before walking the other worktrees to see what's being 
rebased elsewhere that avoids a race where two processes start that try 
to rebase the same branch in different worktrees at the same time. It 
would be easy to store the original oids with the ref names.

An added complexity is that we would have to check the todo list for any 
new update-ref commands and check those refs are not being rebased 
elsewhere each time the list is edited. In the future we should update 
"git status" to read that file but I don't think that needs to be part 
of the initial implementation.

> This ties into your later point:
> 
>>>    2. If we want to close out all of the refs as the rebase is finishing, then
>>>       that "step" becomes invisible to the user (and a bit more complicated to
>>>       insert). Thus, the 'update-refs' step performs this action. If the user
>>>       wants to do things after that step, then they can do so by editing the
>>>       TODO list.
>>
>> I'm not sure what the use case is for making the update-refs step visible to
>> the user - it seems to be added complexity for them to deal with. We don't do
>> that for the branch that is being rebased so why do we need to do it for the
>> other branches? As for the implementation we could just update the branches
>> at the end of the loop in pick_commits() where we update the branch and run the
>> post-rewrite hook etc. there is no need for an entry in the todo list.
> 
> I concede that allowing the user to move the 'update-refs' command around is
> not super important.
> 
> The biggest concern I originally had with this idea was that there was no
> connection between the "--update-refs" option in the first "git rebase"
> command and the final "git rebase --continue" command. That is, other than
> which refs are in refs/rewritten/*.
> 
> HOWEVER, using refs/rewritten/* is likely buggy: if we had two rebases
> happening at the same time (operating on a disjoint set of refs), then how
> do we differentiate which refs make sense for us to update as we complete
> this rebase?
 >> So, I'm coming to the conclusion that using refs/rewritten/* is 
problematic
> and I should use something closer to REBASE_HEAD as a way to describe which
> refs are being updated. In that context, your 'update-ref <ref>' command
> makes a lot more sense. The user can decide to move those around _or_ remove
> them; it won't change their protection under "REBASE_HEADS" but would
> prevent them from being rewritten.

Whenever one adds a new option to rebase it almost always involves 
writing more state to .git/rebase-merge, in this case I think we want to 
store the branches from the update-ref commands and their original oids 
there. I'm not sure that we want to expose the file to the user though 
so we can change the implementation in the future if we need to (e.g. we 
may decide it is better to store this information for all worktrees 
under a single file in $GIT_COMMON_DIR).

> While I think on this, I'll send my branch_checked_out() patches in a
> separate thread, since those have grown in complexity since this version.

If you want to discuss any ideas face-to-face drop me a email and we can 
arrange a time to chat if that would be useful.

Best Wishes

Phillip

> -Stolee
