Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC884A0C
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774917; cv=none; b=f1sp/P56Ky5bpA/PsOx5bx80LBLN+0W+ngCN1qP4+zVtkR9HtwI45FBJBRVvZXhVji5XApjjTa7K92CuOfebXKhnFAzmS6EtULY70K6WfUfmNK1T4q9kwiWaQiTWQNI0xwYrvu8zyrJyxTWMKX1P2w0Zzu9Nki56Gmc6ep3woGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774917; c=relaxed/simple;
	bh=kFEzt9NSqM/y+aKwtcr5OTAUwN7ZIHIpMQ5Ku8xGZ7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCTNA+xccMNpv8kbRtF5GZT7oiGfUTaSSbmyWsbEyavcA7puwLPejyBIlMcC2pv2mQYZlyZE/z4dse9DRGB1RyPozZkpj4yyKgn2AILnEArhqju6PWkYoROS5mgHAFd48Jk2ca5S5mx4zJ0MSmRebX5QVfqL1qBeBDRQdzx5DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejPNjrt5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejPNjrt5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35982fd8910so2463764a91.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 21:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772774916; x=1773379716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSPI1qBT7+D5mrXn9gAVm0CM8J6TSUcpVwg/abZyQwA=;
        b=ejPNjrt5fE0A8hOHkRc8qmYX4nkLqt4EG9z3BmsS1YbswfS/aUi9JouOb+sK5/7g3c
         +ipFDzOM7ZwnoolMVb8/2YRfUchtvX8FlexLAjQcAI8IV3Qfz0ze6X1QGxL/uj96sH+l
         FMRB+wtC0uprKB0II0KUD/1ILgSx7zvEiiA+YegkxWo7W+rWVOJOZX0IbYnjS7EwJSQZ
         ddhEu6KnLTZJFUQtg2amOssY/5X0PYsEC6F3Qfdizif0re9wPk1OG5MzYKpThmdOe1Lm
         +GbRb4s9MjQxufWjQGxF+9PBm7HtPZbfJ8jnWQtDgbjr/azHftB4cv3H0y+6478qm8eC
         4NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772774916; x=1773379716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSPI1qBT7+D5mrXn9gAVm0CM8J6TSUcpVwg/abZyQwA=;
        b=DRv4KnLY2BpxUYfCW8hqhoeuU7i2QDWfkZyTzgUq5x8f8IKFwr2wvmKbHt8PIaiQYQ
         EQjpaNpc0SdnBboNfe1DcSDYdRfKl5IRw+0ZsuWKpF86K1Gx5wlxZk0P30eI69eqXjpI
         GriWFOCgCGw2dDp3i9V4rLzuGqkN/HSZg3fzm7G4RJUJb72upT/qwHuf68AlDQ3n3IuJ
         dPR97BxfwSIxN3FhHJVhei9zaq+y+57qD0m+VGu4WLXOF8yJ6FlWjTIsAIHPsopHYOGd
         9UghMH20BHYLI6T8rHp7NCg5M4LZpLcLDI/FjPROnPtDG42kU5uvLXoloJ7HwvFU9J9R
         9WUw==
X-Forwarded-Encrypted: i=1; AJvYcCUHsh8Gd0IHJ+ylCOfMoU5rI6a6VCWAIdcT7v/VjGXx5/Dbi7hmXpR7/3dTDQzh64EQOfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bXHN/mJi8guxUMLbGgPxt2X9S1e7z7Uru7VGGm5S/gLrx0zE
	IUXDdbBKJkFgWqFgLAVEqpeer5X/OGt0Nw17Tn+TPyA70Dc7nW3MtXye
X-Gm-Gg: ATEYQzyv4O6t+KLM5/iL9QEaZYv4YU4kVqqIvePV5ZPTBcwsnwBvrGU4RJOMv46RvkE
	eNXcGpMHJs0OOyMYNfmOgaLhYRsap+Uvwkx8BAjBF+FzuSE4eXKDqBFoZGMUqO+2S6OQbXV2LDy
	4Wev/aWuSSXtDHeDeqfJDNBKJxmZMqT+NK9xMTPbrGVqw4Pc1ntzN3PyVSJQzzUFs3BiOkCH6TR
	Cg3x2p9iQGvXASbPbhZnVL3ibR6fdXLAT83PZZ//HkMdDC1PZMtcFQSD7/Ycfwo/IebsENdXnCt
	bPyuEMfXZKWtNyohSlHFVPQO6cXEnRdrPSOZp78YhA7wqqJp9s4GXP+0AGn6I90cuS7t3nOfZMX
	ragw7Cyy8qHp8/AIYpjs+yEaNSaKiluGs/s9Y+uZ7KABGQ/TT1eXawVuBCIVWaQdEb5k0vNS9yf
	BLy6548KxJ3oCA9QljBnzE/TBUt9X1viwQQpiT1JwnUdvTTDUyjXHQ6OM7SaRfsQQY7Nbv5D/uQ
	kpENnpNjRKu+n//wReYdIW9tJN2jpJaaWXz
X-Received: by 2002:a17:90b:4b87:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-359be2eea9emr728982a91.20.1772774915758;
        Thu, 05 Mar 2026 21:28:35 -0800 (PST)
Received: from ?IPV6:2401:4900:862d:bb67:1c20:bec7:1904:ead0? ([2401:4900:862d:bb67:1c20:bec7:1904:ead0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de7b8dsm5070774a91.12.2026.03.05.21.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 21:28:35 -0800 (PST)
Message-ID: <77fa95d9-3ea3-4a32-b8fa-22c05c048160@gmail.com>
Date: Fri, 6 Mar 2026 10:58:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit
 changes
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
 <405b0d34-c2ad-498d-93a1-2e7925ae11f1@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <405b0d34-c2ad-498d-93a1-2e7925ae11f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/02/26 20:15, Phillip Wood wrote:
> Hi Siddharth
> 
> On 18/02/2026 23:42, Siddharth Asthana wrote:
>> @@ -42,6 +42,25 @@ The history is replayed on top of the <branch> and 
>> <branch> is updated to
>>   point at the tip of the resulting history. This is different from 
>> `--onto`,
>>   which uses the target only as a starting point without updating it.
>> +--revert <branch>::
>> +    Starting point at which to create the reverted commits; must be a
>> +    branch name.
>> ++
>> +When `--revert` is specified, the commits in the revision range are 
>> reverted
>> +(their changes are undone) and the reverted commits are created on 
>> top of
>> +<branch>. The <branch> is then updated to point at the new commits. 
>> This is
>> +the same as running `git revert <revision-range>` but does not update 
>> the
>> +working tree.
>> ++
>> +The commit messages follow `git revert` conventions: they are 
>> prefixed with
>> +"Revert" and include "This reverts commit <hash>." When reverting a 
>> commit
>> +whose message starts with "Revert", the new message uses "Reapply" 
>> instead.
>> +Unlike cherry-pick which preserves the original author, revert 
>> commits use
>> +the current user as the author, matching the behavior of `git revert`.
>> ++
>> +This option is mutually exclusive with `--onto` and `--advance`. It 
>> is also
>> +incompatible with `--contained` (which is a modifier for `--onto` only).
> 
> We seem to have lost
> 
>      NOTE: For reverting an entire merge request as a single commit
>      (rather than commit-by-commit), consider using `git merge-tree
>      --merge-base $TIP HEAD $BASE` which can avoid unnecessary merge
>      conflicts.
> 
> from V2 which is a shame.


Yeah, I dropped it during the v3 cleanup when I was trimming the example 
text. will  add it back.

> 
> I do think we should seriously consider reverting commits in the reverse 
> order that they were created (i.e. do not set '--reverse' when setting 
> up the rev-list options) to reduce the likely-hood of conflicts when 
> reverting a sequence of commits.


Good catch. sequencer.c does exactly this in prepare_revs() -- it only 
sets reverse for REPLAY_PICK, not REPLAY_REVERT, so git revert processes 
newest-first.

The complication in replay is that pick_regular_commit() chains commits 
through mapped_commit(base, onto). With oldest-first, the parent is 
always already in replayed_commits so the chain works. With 
newest-first, the parent hasn't been processed yet and mapped_commit() 
falls back to onto -- so each revert be independently based on the 
original branch tip instead of chaining.

The fix is straightforward: for revert mode, pass last_commit instead of 
onto as the fallback in the main loop:

	pick_regular_commit(repo, commit, replayed_commits,
                         mode == REPLAY_MODE_REVERT ? last_commit : onto,
                         &merge_opt, &result, mode);

That way each revert builds on the previous one regardless of walk 
order. I will do this in v4 together with skipping the reverse=1 
override for revert mode.

> 
>> @@ -152,6 +172,15 @@ all commits they have since `base`, playing them 
>> on top of
>>   `origin/main`. These three branches may have commits on top of `base`
>>   that they have in common, but that does not need to be the case.
>> +To revert commits on a branch:
>> +
>> +------------
>> +$ git replay --revert main main~2..main
> 
> It might be more realistic to revert some commits from a different 
> branch, for example
> 
>    git replay --revert main topic~2..topic


Makes sense. v2 had `git replay --revert main feature~2..feature` for 
this reason but I simplified it in v3. I will go back to something like 
your example:

	git replay --revert main topic2..topic


> 
>> +static void set_up_branch_mode(struct repository *repo,
>> +                   char **branch_name,
>> +                   const char *option_name,
>> +                   struct ref_info *rinfo,
>> +                   struct commit **onto)
>> [...]
>> +    if (rinfo->positive_refexprs > 1)
>> +        die(_("cannot %s target with multiple sources because 
>> ordering would be ill-defined"),
>> +            option_name + 2); /* skip "--" prefix */
> 
> This is a bit of a nasty hack as it stuffs an English word into the 
> middle of a translated sentence. Using the option name as below might be 
> nicer


Agreed, will use your suggested form:

	die(_("'%s' cannot be used with multiple revision ranges "
           "because the ordering would be ill-defined"), option_name);


> 
>      die(_("'%s' cannot be used with multiple revision ranges because 
> the ordering would be ill defined", option_name);
>> @@ -226,25 +269,46 @@ static struct commit *pick_regular_commit(struct 
>> repository *repo,
>>  [...]
>> -    /* Drop commits that become empty */
>> -    if (oideq(&replayed_base_tree->object.oid, &result->tree- 
>> >object.oid) &&
>> +    /* Drop commits that become empty (only for picks) */
> 
> Why? What's the advantage in creating empty revert commits?


Consistency with git revert, which doesn't silently drop empty reverts 
either -- it stops and asks the user to deal with it. Since replay is 
non-interactive and can't prompt, I kept them rather than silently 
dropping, to avoid hiding that something unexpected happened.

That being said, I don't feel strong about it. If you think dropping is 
the better default for replay, I am  happy to change it. Or we could 
error out (exit code 1) like we do for conflicts?


Thanks,
Siddharth


> 
>> +    if (mode == REPLAY_MODE_PICK &&
>> +        oideq(&replayed_base_tree->object.oid, &result->tree- 
>> >object.oid) &&
> 
> Thanks
> 
> Phillip

