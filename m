Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A3282F1D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886927; cv=none; b=ENBxp9Vv69yD7Uwinx8a8crT1zeznk8minOeM4dw3yE9Bfn/blvqAgxpsUWAK6lP+oqx7LErClJmnMQP0qt3MMYjxnCtKNVV0gZfX9kS/6bS2lYjGv2NoXk5vm5eFNLC2GhgtSAaNdYyUpH3gIVrEDhQKcKZpgJ3/toWk7CSZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886927; c=relaxed/simple;
	bh=8eameE2vf1SZvsms4tTC5lUw/p9raLQjmpuLKG5cfdY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ej2gSjiUlrdCSe3UQy2o7zKZHEaRZGqPq3LxgbN2oGLLetFiDDDpMQH15qil1WR8s/1lqkaQJiCrhBkT4pfk6WRyN7gpGPBs8GTdjuIIyc2DP+6B7uBI/K7vNh4SbUvogNKCTujMK2YPxzg7O7glSCZJK2zwdeq/RYZfurT4z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArfAMbTD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArfAMbTD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso1947345e9.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784886924; x=1785491724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ls7pxPb8mvcJzL/hbH+lpkU3+4fKZI/VHYf/A5OizlA=;
        b=ArfAMbTDbxJVOABFf/JH9GPrEp1T9s7vYSfvlYNESo43Elrb+kEgfN0y0CnyOu6zK/
         njYYn2l1LqpcxEFjYD7lOglOJNgmxpagBkSvZOiRBnqtz+wNXTFwg6c4a4BD4ceLq872
         9pR2LQuSAywexQeGOvjnv3YmwajT6zu/2YWDdVKOBkoUViBdygLjQej/+R/UTHcD3IRb
         U2Y3cKRzl8w1aUJnEjR0+Mp4EDHPRu9oLMs073JKvveFOLALuAGug50XtzgJnhzpkFjL
         xz0llqgFwCycGTqXWvO/4GwbgTFv6kROIjb23zmCHMBT8qpT+rbha+3ReXBPm1MmqOEv
         ldkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886924; x=1785491724;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ls7pxPb8mvcJzL/hbH+lpkU3+4fKZI/VHYf/A5OizlA=;
        b=bbx6tat9vcbnH8X2svbdBTEFMB11sEbLInthcKjvClQ2H73qZ1nTIA1cAOpmxXVxzT
         u17MWURkHvPxHWzqeHgrA7CR50KQcY7InPsKYw6mkYEx/W6Uk5+drVgW8NTAtxo4Fdkg
         hwhApI/Qe37uG5x8lfvF+Li4Q/VXyG06VVdrcl/fhdIwrZszTbkWuFa+0IaMw0KIGiOV
         x2Y9ZKWAGr4NmYepkwLP2z0nTnuvM+k6BtWnE1bVoy01z8olD7lIXDySBc8eP7tAEwyF
         ia9mDEQIaLSqMy2yXMjYqtkIJ7+VJDEM8bojVao2M5aq2ZSzBTFItGjoZAwUDXzQ+rKH
         DkXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpk0lsDcXIZUJEeknvUwx2yehPorVAzQPaEGqHOWbUIdh9kxtm2H9K9zMknNvteKFohl/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutGcMG6NmXevJ2teejkDOqFMJ2AUO1WwBLMHoK1ALCX+MI52E
	LyAnfa6E65EhOGBGE5STk8+FF0dhcsOq6R81saPo+YesgJD2viPTOTm0+aoZEA==
X-Gm-Gg: AR+sD13KyEQfbdYSBL9bfKcD5ebfkDohXvqMBdvwxi63cL4jJmYXEAyExPBU96c2Xkg
	wCbYrDO6rCLhqcdhypZbLZGv6emANaK6EHaufeWc0t+doU9FoeaEQrOjY9bzdA8hWlUvfFLFZIg
	jp4J0jCFBzp28QixIjqRe5cJlNENtWA4yiY2uERanoFxLkD5lPL9ndieNx28BYhzBXkaQCqrW6n
	bbw/6Ot1xsrGoCmRCbJ8t7DYu7LMJSyr0htqdXMT9/eF1YcWQqBLQcSFzSkSS2o+4ONcfac2TYM
	FvDjm/0VjJHY5N/zpbkRuYfw7MMsEOf6AGcaihxu8FpEDcrlsD5cMVpk+qXJUF6nUEzH9VdkTUS
	GH+215JJLGUMs3ke/4daGUytxuP213cOv9wCWDNwMe6ybXxlIpLQJq5VP2cUQF4PfQXK8deDhcI
	pDCbjjbhPuY6PPAu18B4tAgkLuFNAaNecHFceGFhlyx1hNivCi7wazzAvW
X-Received: by 2002:a05:600c:35d5:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-49573c8c8c4mr69735765e9.5.1784886923519;
        Fri, 24 Jul 2026 02:55:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957e334f63sm24623255e9.1.2026.07.24.02.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:55:22 -0700 (PDT)
Message-ID: <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>
Date: Fri, 24 Jul 2026 10:55:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
From: Phillip Wood <phillip.wood123@gmail.com>
To: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
 <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
Content-Language: en-US
In-Reply-To: <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/2026 19:58, Phillip Wood wrote:
> On 22/07/2026 09:15, Son Luong Ngoc via GitGitGadget wrote:
>> From: Son Luong Ngoc <sluongng@gmail.com>
>>
>> git rebase --update-refs can finish rewriting the current branch and
>> then fail while updating a local branch that is a symbolic ref. This can
>> happen during a default-branch rename where refs/heads/main points at
>> refs/heads/master while users migrate.
>>
>> The problem is a partially applied ref update: the main rebase has
>> already succeeded when the later ref update fails.
>>
>> The sequencer queues updates from local branch decorations. Commit
>> 106b6885c7 (rebase: ignore non-branch update-refs) filters out
>> decorations such as HEAD and tags. A branch symref is still a local
>> branch decoration, but refs_update_ref() dereferences it, so an alias to
>> another branch duplicates the concrete branch update.
>>
>> Resolve local branch decorations before queuing them. Skip symrefs whose
>> targets are under refs/heads/ so that only the concrete branch update is
>> queued. Keep an owned copy of the resolved HEAD and skip the current
>> branch before checked-out handling so later ref resolution cannot change
>> the comparison.
>>
>> This prevents a successful rebase from being followed by a failed,
>> partially applied ref update while preserving each alias as a symref.
> 
> Thanks for re-rolling I'm pretty sure the logic is sound now but I'm a 
> bit confused by a couple of things - see my comments below.
> 
>> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
>> ---
>>   sequencer.c                   | 44 +++++++++++++++++++++++++----------
>>   t/t3400-rebase.sh             |  2 +-
>>   t/t3404-rebase-interactive.sh | 16 +++++++++++++
>>   3 files changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 1355a99a09..63aba60a08 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -6465,32 +6465,50 @@ static int add_decorations_to_list(const 
>> struct commit *commit,
>>                      struct todo_add_branch_context *ctx)
>>   {
>>       const struct name_decoration *decoration = 
>> get_name_decoration(&commit->object);
>> -    const char *head_ref = 
>> refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
>> -                               "HEAD",
>> -                               RESOLVE_REF_READING,
>> -                               NULL,
>> -                               NULL);
>> +    struct ref_store *refs = get_main_ref_store(the_repository);
>> +    char *head_ref = refs_resolve_refdup(refs, "HEAD",
>> +                         RESOLVE_REF_READING,
>> +                         NULL, NULL);
>>       while (decoration) {
>>           struct todo_item *item;
>>           const char *path;
>> +        char *resolved_ref;
>> +        int flags = 0;
>>           size_t base_offset = ctx->buf->len;
>>           /*
>> -         * If the branch is the current HEAD, then it will be
>> -         * updated by the default rebase behavior.
>> -         * Exclude it from the list of refs to update,
>> -         * as well as any non-branch decorations.
>>            * Non-branch decorations may be present if the pretty format
>>            * includes "%d", which would have loaded all refs
>>            * into the global decoration table.
>>            */
>> -        if ((head_ref && !strcmp(head_ref, decoration->name)) ||
>> -            (decoration->type != DECORATION_REF_LOCAL)) {
>> +        if (decoration->type != DECORATION_REF_LOCAL) {
>> +            decoration = decoration->next;
>> +            continue;
>> +        }
> 
> It would be nice to have a comment here explaining what we're doing. 
> Also I don't think we need to copy the refname so it would be more 
> efficient to use refs_resolve_ref_unsafe().

Looking at this again we cannot use refs_resolve_ref_unsafe() because 
the result would be overwritten by the call to refs_resolve_refdup() in 
branch_checked_out().

>> +        resolved_ref = refs_resolve_refdup(refs, decoration->name,
>> +                              RESOLVE_REF_READING,
>> +                              NULL, &flags);
>> +        if (resolved_ref && (flags & REF_ISSYMREF) &&
>> +            starts_with(resolved_ref, "refs/heads/")) {
>> +            free(resolved_ref);
>> +            decoration = decoration->next;
>> +            continue;
>> +        }
> 
> We skip any symbolic refs that point to another branch which is good.
> 
>> +        /*
>> +         * If the branch is the current HEAD, then it will be
>> +         * updated by the default rebase behavior.
>> +         */
>> +        if (head_ref && !strcmp(head_ref, decoration->name)) {
>> +            free(resolved_ref);
>>               decoration = decoration->next;
>>               continue;
>>           }
> 
> Then we check to see if the decoration matches HEAD which we used to do 
> above - I'm not clear why we have moved this check.

Should we be using "resolved_ref" instead of "decoration->name"? That 
would explain why this was moved and would makes sense as we resolve 
symrefs when reading HEAD. When HEAD points outside "refs/heads/" we'd 
then skip updating any symrefs under "refs/heads/" that pointed to the 
same ref as HEAD.

Thanks

Phillip
> 
>> +        path = branch_checked_out(decoration->name);
>> +
> 
> This belongs in the next patch I think.
> 
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index e62e07b894..1a02f6546b 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -471,7 +471,7 @@ test_expect_success 'git rebase --update-ref with 
>> core.commentChar and branch on
> 
> Adding an extra context line shows
> 
>      git checkout topic2>       GIT_SEQUENCE_EDITOR="cat >actual" git -c 
> core.commentChar=% \
>>            rebase -i --update-refs base &&
>>       test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
>> -    test_grep "% Ref refs/heads/topic2 checked out at" actual
>> +    test_grep ! "% Ref refs/heads/topic2 checked out at" actual
> 
> As topic2 is checked out in the worktree where the rebase is running why 
> did this line appear before?
> 
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase- 
>> interactive.sh
>> index e64816770a..11afa8be56 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1975,15 +1975,23 @@ test_expect_success '--update-refs ignores 
>> non-branch decorations' '
>>       ) &&
>>       grep ^update-ref todo >actual &&
>>       test_write_lines "update-ref refs/heads/no-conflict-branch" 
>> >expect &&
>> +    test_grep ! "^# Ref refs/heads/update-refs checked out" todo &&
> 
> Lets move this line below test_cmp so we keep that line next to the ones 
> that create the files that are being compared. Is this another case 
> where we used to add this comment and no longer do so?
> 
>>       test_cmp expect actual
>>   '
>>   test_expect_success '--update-refs updates refs correctly' '
>> +    test_when_finished "
>> +        test_might_fail git symbolic-ref -d refs/heads/no-conflict- 
>> branch-alias &&
>> +        test_might_fail git symbolic-ref -d refs/heads/second-alias
>> +    " &&
>>       git checkout -B update-refs no-conflict-branch &&
>>       git branch -f base HEAD~4 &&
>>       git branch -f first HEAD~3 &&
>>       git branch -f second HEAD~3 &&
>>       git branch -f third HEAD~1 &&
>> +    git symbolic-ref refs/heads/no-conflict-branch-alias \
>> +        refs/heads/no-conflict-branch &&
>> +    git symbolic-ref refs/heads/second-alias refs/heads/second &&
>>       test_commit extra2 fileX &&
>>       git commit --amend --fixup=L &&
>> @@ -1991,8 +1999,16 @@ test_expect_success '--update-refs updates refs 
>> correctly' '
>>       test_cmp_rev HEAD~3 refs/heads/first &&
>>       test_cmp_rev HEAD~3 refs/heads/second &&
>> +    test_cmp_rev HEAD~3 refs/heads/second-alias &&
>>       test_cmp_rev HEAD~1 refs/heads/third &&
>>       test_cmp_rev HEAD refs/heads/no-conflict-branch &&
>> +    test_cmp_rev HEAD refs/heads/no-conflict-branch-alias &&
>> +    test_write_lines refs/heads/no-conflict-branch >expect &&
>> +    git symbolic-ref refs/heads/no-conflict-branch-alias >actual &&
>> +    test_cmp expect actual &&
>> +    test_write_lines refs/heads/second >expect &&
>> +    git symbolic-ref refs/heads/second-alias >actual &&
>> +    test_cmp expect actual &&
> 
> This looks good - we check that "rebase --update-refs" succeeds withh 
> branches that are symrefs and also that those refs are untouched by the 
> rebase.
> 
> Thanks
> 
> Phillip
> 
>>       q_to_tab >expect <<-\EOF &&
>>       Successfully rebased and updated refs/heads/update-refs.
> 

