Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14953C3AB
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077911; cv=none; b=W1JmsH2sdEvTu0We8CPB770WpZO6ib7ATDBZLotLWdUlKuVXNyktKoF3Vu51ezVlR2bKPIgla/sM4GCiaVIIdCOxc/3+H4pbt871/nSDnDV0pVyqOfh0mxXTghOW5T2y81Pko8jGGMMBgWVyo1DeqJfAth4SO5GsDbuaR+6AMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077911; c=relaxed/simple;
	bh=PT4Ye+r1hz2pav7CCVm5eBRzl+1vJrCIJwPskYQKvwg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J2p0jjV43PNyqFdKh8nRacdzs+lpmhXPuJbOy+jpI77wcrgjhRoVD/077w3GQK6EIlmC5kTf57jKtdbWRz+P29jUAp7n23GL26z1Bt3iF2G2rsI1ol1e8c2PtVUmEImtt4XJc+Vh3GYt4/CG7rOVIlwX2+bmd/gDJ+A4JDXP2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj60S5n9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj60S5n9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afe75f055so570225f8f.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077893; x=1792682693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0brlfXDmRkl3id9Jx6R7ythRb9rKfLFkZSJ3JIgHt6U=;
        b=Uj60S5n9UcALcNQP8gXPQ0ZjOvVKy7VemFjkj1vWpFuVrm0XCphfTrWFYtL9F5yjMp
         BkpUzU1Jxvxi7QxJZ8eZofebAYvf+6WA/YWOLFs1wE4+JiPZfS7XoHtwUxQnuHogG21d
         LG6oUM9dcNe9iLjZf5gd3SOMZ1FTJCTFZSF/FpcdQ2fR18KzZESQb1+3/Gfpi/iOt9iv
         TbzN7ImKiJwrRT4IsVMTmz6/WCiiv9mMaheXLdkeEmFNtmIxubm6zZCC3V3XR0Xk4s1o
         gGuTn8U9W0mzcZUdFLamnc5r8y7RyUfHwVMYc3W+IoFbUlZRxXuquL+h8LK5REpnSFmk
         9n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077893; x=1792682693;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0brlfXDmRkl3id9Jx6R7ythRb9rKfLFkZSJ3JIgHt6U=;
        b=D89pWyTVfHd1lWcwmwoYbbnQ6rPmjrWaQ9yu1Ie6QauV8gV+gDUVCEd1AQHlqDQ1Mz
         Mwan9OpwYOG94NEyAupjOv9auFvh1Tx3WyRRUllK/uR4F2P6Hz8p0/pOZq4SlGy5C8Ya
         BfjKPsWofz1a00vx25LQExEi+BWG0QF9oZT9q4ZY7LaLbT2z8geRac3ZM50QGyxgk4uU
         jGOtKCbAnJhKXXylFxOBBddlwh7CCbiAAW0LsMBqHDA/YM5P6HKatVucijjwkp3WCpon
         TNj2IJb2Py63fosmdXKdldgkyjA/oDFA+YeoS7jY8F5n7xWccGxWdqfFOUud8FAxQDoF
         GZpw==
X-Gm-Message-State: AFq9FYLVlaZfeTukjTSmSkuqxXPhIuZCDbpEz+j40ZADA1j3OzRnQen/
	pKWNnR3AOiiAjMwogXVlszvcoy8tzFYozJW5TwYD968o0YoqclUyc6ne+FOx4A==
X-Gm-Gg: AYBFou2fvscj5KIscaZOftGJWjQVQbsuzE4jz4Tunb7+BKibWgxXG8InBrz6xavu9GS
	fwbSoCUaq7G1Yv+bKWFTgU9za1NJFKxZnA8EhGb/6RP3sDncWw6/bx6fNqig5mLQEgFJ4GIJtMI
	o73yVzm/uEoffgb8xnuWDH1hqCi75Xyc6DZBrBsLyFnQ+D6jtU8vkaQTeyaTIXJDsMybE0jT6Rg
	dNEew7Uwe6K3hcKQIeMdGrM9k4C6XAPwdccTx/oxI41w+aE5mp6rDzgL+N7dn69W+O39S5tdinD
	mLWphWJDOaC9ENtSqjspQIDtOMFfFWIzuTJswuX9twiAOtjBF3SBpdmXQ7xDSHrTiN++OQv4WxE
	3uoRKORWAxevigrbY0eOocGXuRiErfrWl7JSRR9JSf1d0CFgXUyXbIPzM25zxVUDhYjUyO5gufA
	103M6c9kpFSypEynLySyR4q4Oi2wipovaLsVmTF6CT6OM63sC3Cf1EkQVaC4+5/0EtaJ+VQwi1M
	d0WstASWFUVSK1MDD164hDaUsueqBuYcqoAIyE7t2laGZNMxY2X
X-Received: by 2002:a5d:6312:0:b0:48b:b6:6a92 with SMTP id ffacd0b85a97d-48dbaae701amr28563021f8f.26.1792077893083;
        Thu, 15 Oct 2026 08:24:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm19962755f8f.51.2026.10.15.08.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:24:52 -0700 (PDT)
Message-ID: <837b7d72-a767-4c51-9693-8fd95d14a58d@gmail.com>
Date: Thu, 15 Oct 2026 16:24:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: don't clobber HEAD ref name in worktree lookup
To: Junio C Hamano <gitster@pobox.com>, Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20261014165824.2214234-1-andy.koppe@gmail.com>
 <xmqqik34qd6s.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqik34qd6s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2026 20:44, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>> add_decorations_to_list() skips the branch that HEAD points to, because
>> the rebase updates it anyway, as per aa37f3e1d89 (sequencer: ignore HEAD
>> ref under --update-refs, 2022-07-19).
>>
>> However, it keeps the name of that branch in the static buffer returned
>> by refs_resolve_ref_unsafe(). If another branch on the same commit is
>> checked out in a different worktree, branch_checked_out() overwrites
>> that buffer. If the current branch comes after the other branch in the
>> list of decorations, it gets a "checked out" comment in the todo list
>> instead of being skipped, and the branch whose name ended up in the
>> buffer is skipped in its place.
> 
> So obviously broken original, so cleanly corrected.  I very much
> like it.

Yes, this is nicely explained and I appreciate the new test

Thanks

Phillip

> Will queue.  thanks.
> 
>>
>> Decorations are processed in reverse alphabetical order, so this depends
>> on the branch names. The test added in 94304b9f48e (sequencer: comment
>> checked-out branch properly, 2024-11-25) happens to trigger the problem
>> and expects its result.
>>
>> Fix it by using refs_resolve_refdup(), correct that test's expectation,
>> and add a test with checked-out branches sorting both before and after
>> the current branch.
>>
>> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
>> ---
>>   sequencer.c       | 11 ++++++-----
>>   t/t3400-rebase.sh | 21 ++++++++++++++++++++-
>>   2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 6dae43e4db..c672b6e127 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -6577,11 +6577,11 @@ static int add_decorations_to_list(const struct commit *commit,
>>   				   struct todo_add_branch_context *ctx)
>>   {
>>   	const struct name_decoration *decoration = get_name_decoration(&commit->object);
>> -	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
>> -						       "HEAD",
>> -						       RESOLVE_REF_READING,
>> -						       NULL,
>> -						       NULL);
>> +	char *head_ref = refs_resolve_refdup(get_main_ref_store(the_repository),
>> +					     "HEAD",
>> +					     RESOLVE_REF_READING,
>> +					     NULL,
>> +					     NULL);
>>   
>>   	while (decoration) {
>>   		struct todo_item *item;
>> @@ -6633,6 +6633,7 @@ static int add_decorations_to_list(const struct commit *commit,
>>   		decoration = decoration->next;
>>   	}
>>   
>> +	free(head_ref);
>>   	return 0;
>>   }
>>   
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index accaaba4d4..0e7ef33eb1 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -483,7 +483,26 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
>>   	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
>>   		 rebase -i --update-refs base &&
>>   	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
>> -	test_grep "% Ref refs/heads/topic2 checked out at" actual
>> +	test_grep ! "Ref refs/heads/topic2" actual
>> +'
>> +
>> +test_expect_success 'git rebase --update-refs ignores current branch with branches on worktrees' '
>> +	test_when_finished git branch -D base current a-topic z-topic &&
>> +	test_when_finished git checkout main &&
>> +	test_when_finished git worktree remove z-topic &&
>> +	test_when_finished git worktree remove a-topic &&
>> +	git checkout -b base main &&
>> +	git checkout -b current &&
>> +	test_commit msg4 &&
>> +	git worktree add a-topic &&
>> +	git worktree add z-topic &&
>> +	git checkout base &&
>> +	test_commit msg5 &&
>> +	git checkout current &&
>> +	GIT_SEQUENCE_EDITOR="cat >actual" git rebase -i --update-refs base &&
>> +	test_grep "# Ref refs/heads/a-topic checked out at" actual &&
>> +	test_grep "# Ref refs/heads/z-topic checked out at" actual &&
>> +	test_grep ! "refs/heads/current" actual
>>   '
>>   
>>   test_done

