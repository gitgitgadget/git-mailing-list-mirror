Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C053A1E8F
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894758; cv=none; b=rR4pcBU4BNqI+krMt+1AnnLWsppaoIPVfTFjEhNW+8rSSyLloE+RQVvqphawXqBUoxx6b2yRUMkv/1qQjHA9761miHpHhx2r7eu65dlQFBrR+4q1rxG+rYK3hTaz/xScTkp276QmfPqwiptYEAH+zno8b/8EYzG3ZsoUdqDEuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894758; c=relaxed/simple;
	bh=ZQHd1fV/rp1gqJS67f7VdjUulS1yFuDt+/6RUerrKnc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QLu4Tjo99PXhn0f/FGwuU7OH+9k0M3PPskgeQyvrn3C2UTJKFcVvZCMNC09QGJKMdjvXEdzb/1cpfpSicGtHSywxy+QE3hAevR+JWCTjUNhedl6EB7aD02SWPrKsv4eNLPJtuv8RRsy4UvNFbKVp+1d0U8s9yOP2Z9avHihmSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehNS4RmO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehNS4RmO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so35232305e9.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894754; x=1766499554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0k8ygzW7rTZrEOdEKoByN+gKpE4kMLNDBygQG0zFpM=;
        b=ehNS4RmOeD2vWhx904xnXZa6LexWYayJBCKBP7/M4OPHoHi5nF+jSUvA9Y7UweWC5R
         ucABFh6KUIhg1k2zBZ/z0uOgQpOsT0tntJwVUKjqcU1/fOqUf0YjUiRJOD+K2uiPctVM
         nEhB4VU/OLv3p06XMSnZRC6UXM2Q6xUFRjLQis5HblkjCg1A33FKq5KfhtOVdgjcLT9F
         3q0Bg0DWOTH5gPMKGTwKeSQVcAeNoEnZhAhmRUQdpM3V6pcovPxZJQp+gDnkYdHtAPRu
         MjyrH0IYU10aZKgtHCPYy73PLfOWHpKQuYfWjKUgo0TXMIYjYvzLsoqQQJ4KqVJNu2EN
         3J8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894754; x=1766499554;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0k8ygzW7rTZrEOdEKoByN+gKpE4kMLNDBygQG0zFpM=;
        b=RhusWFJqrFM+kJ5LJE0G+IGKVSkhagOb3SD5qXzMEjKdwL7AJ+fOezS+m+U5S8u93P
         WpYhts7p6Y1US/8UJfQ2kJdXoxV+CZ9QW5JeSPVnU97gEIu3E+HRIzJ5a+2DNPGBKA2Q
         I8T3GPVYavI77PdUCMCxeIx8NeBaKRzvZvt18rwooM8ONtRYl3b4ZqKQNlusgui4y39a
         LxO2Y2paVGX8pQMlcqsSIkcQmhtMzsDPtnmA3xjLwz5szGMAKr4oRTp6tngQQdLZpS25
         Xrwh5xFHJc4Pe8ZC1hxmW0umCXybcgkyeO6Aw4YTX8eoQkPdIncnTNv/mMwUYmJA0t9L
         0mBw==
X-Gm-Message-State: AOJu0YwIUVWAaG4p+E+IzFsmJzybbtkp0RKndwIJMi142QMrOd4VLtkk
	NvPtFXFU/oEFzbPPh89pYgELQsV3KW5zWRD86o0I+G0nvJ45J5EWcTV9
X-Gm-Gg: AY/fxX623h9p6D7I7HO6Tvc+KKAFsAgVQUwamZOod7j6YUYand3sAwth+aD7Mz+WkB6
	MCuO2jlRvznPTF1HScChH/Ulbp2ZIE8XMIxzM6+NUjj4s5FmVgplE8OVNCXRV9ohchmVYNISyKC
	rHlvABa19tHDTnDzDRbJtLJH1J0CnNOjE0NmSoMVYWi5euPnjrPnsI7oPbx4ET3HlC0fOHaE1ky
	FBMlZ+KshUnzR93Mh/gDWgY8pZy6cysric6pgIk5n4Y8GS+tw2WcVo13rVDNP5so2jyBQQQB+BV
	KF+HUSrrYyjGpo9EitEdqK0kDVmnEvBx0cV2CJAsEC6q8OxO9Av3dXIwkcrHt8IjeioF2oSJ3wi
	tMRg8d9t0bFaF8BFnLKyPbZ5mhZLxlOJbSnisoq4YuyUdp/gal+swGK2HN/4WmXVcXAVrNCF8nZ
	0bTEqZcUyIIIF4LGZr/bOOV0eJyQaiinnbdeSJFgMUuT14BCALzm4JrmREaaoqLhfZnw==
X-Google-Smtp-Source: AGHT+IFX6xbKNzlWsBTRMCpQ8IIsw6ilFDI61GmFsOVsTwUjxKi7i0iiC9GnY5NXapVVHm0rpVsrKg==
X-Received: by 2002:a05:600c:c0d5:b0:47a:9560:ec28 with SMTP id 5b1f17b1804b1-47a9560ef40mr83188715e9.13.1765894753673;
        Tue, 16 Dec 2025 06:19:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6e58c1sm241208985e9.12.2025.12.16.06.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:19:12 -0800 (PST)
Message-ID: <80477d23-eed3-4a99-be97-f692bc36095e@gmail.com>
Date: Tue, 16 Dec 2025 14:19:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] replay: drop commits that become empty
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
 <xmqqpl8f719x.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpl8f719x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2025 23:50, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the changes in a commit being replayed are already in the branch
>> that the commits are being replayed onto then "git replay" creates an
>> empty commit. This is confusing because the commit message no longer
>> matches the contents of the commit. Drop the commit instead. Commits
>> that start off empty are not dropped. This matches the behavior of
>> "git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
>> --empty-drop".
> 
> OK.  Maybe it is just me but "onto then" -> "onto," would flow the
> sentence better?

I agree it reads better with a comma here and in the second paragraph, 
I'll re-roll

Thanks

Phillip

>> If a branch points to a commit that is dropped it will be updated to
>> point to the last commit that was not dropped. This can been seen
> 
> If one thinks about it, it is the only natural behaviour to use the
> last surviving commit to point the branch at.  Thanks for spelling
> it out so clearly.
> 
> BTW, "can been seen" -> "can be seen" (will amend locally).
> 
>> in the new test where "topic1" is updated to point to the rebased
>> "C" as "F" is dropped because it is already upstream. While this is
>> a breaking change "git replay" is marked as experimental to allow
>> improvements like this that change the behavior.
> 
> Again maybe it is just me, but I'd prefer to see a comma after "a
> breaking change" to flow the sentence better.
> 
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> ...
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>> index dcb26e8a8e8..96a3a557bf3 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -59,7 +59,9 @@ The default mode can be configured via the `replay.refAction` configuration vari
>>   	be passed, but in `--advance <branch>` mode, they should have
>>   	a single tip, so that it's clear where <branch> should point
>>   	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
>> -	"Commit Limiting" options below.
>> +	"Commit Limiting" options below. Any commits in the range whose
>> +	changes are already present in the branch the commits are being
>> +	replayed onto will be dropped.
> 
> OK.
> 
>> diff --git a/replay.c b/replay.c
>> index 13983dbc566..2864c213993 100644
>> --- a/replay.c
>> +++ b/replay.c
>> @@ -88,12 +88,12 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
>>   					  struct merge_result *result)
>>   {
>>   	struct commit *base, *replayed_base;
>> -	struct tree *pickme_tree, *base_tree;
>> +	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>>   
>>   	base = pickme->parents->item;
>>   	replayed_base = mapped_commit(replayed_commits, base, onto);
>>   
>> -	result->tree = repo_get_commit_tree(repo, replayed_base);
>> +	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
>>   	pickme_tree = repo_get_commit_tree(repo, pickme);
>>   	base_tree = repo_get_commit_tree(repo, base);
>>   
>> @@ -103,13 +103,17 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
>>   
>>   	merge_incore_nonrecursive(merge_opt,
>>   				  base_tree,
>> -				  result->tree,
>> +				  replayed_base_tree,
>>   				  pickme_tree,
>>   				  result);
>>   
>>   	free((char*)merge_opt->ancestor);
>>   	merge_opt->ancestor = NULL;
>>   	if (!result->clean)
>>   		return NULL;
>> +	/* Drop commits that become empty */
>> +	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
>> +	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
>> +		return replayed_base;
>>   	return replay_create_commit(repo, result->tree, pickme, replayed_base);
>>   }
> 
> OK, that is straight-forward.  Instead of overriding the
> result->tree upfront, we try the same using a temporary
> replayed_base_tree, and that allows us to see if the resulting tree
> computed by merge_incore matches.  Only when it made a non-empty
> change, we proceed to create a new commit.
> 
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index cf3aacf3551..9d4b0dd1a77 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -25,6 +25,8 @@ test_expect_success 'setup' '
>>   	git switch -c topic3 &&
>>   	test_commit G &&
>>   	test_commit H &&
>> +	git switch -c empty &&
>> +	git commit --allow-empty --only -m empty &&
> 
> The use of "--only" here is a bit curious.  As there is no change
> between the index and the commit our "empty" branch points at,
> wouldn't it be unnecessary?  The option, together with --allow-empty,
> would only matter if you did
> 
> 	git switch -c empty &&
> 	modify blah &&
> 	git add blah &&
> 	git commit --allow-empty --only -m empty
> 
> because without --only, the changes to blah will be taken.

