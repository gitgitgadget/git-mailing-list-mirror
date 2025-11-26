Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCB3161AA
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184745; cv=none; b=cGa8g28w+hVqPORHqLZrMGV94YfNwV9pgYRyAPfzndX9WCS8aa2lPitOtWO+dEKVun7Z2p9HkWRTxaOeAh33gsOEYPuQws1RnKwHWIDox2yxDzJcKcOVPVt2SQo+nE9Ujj6SyrLvmWeE7G8NUCrmUAlh+NUngB/J121vzB6s8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184745; c=relaxed/simple;
	bh=4xd6/4hGYTU7lF9NWbhTQENmXvYaSFkPR/3h6EH5hfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auIBGXeV2gSB521gXgY0x8zLRP4T7CV/S/JggNpTUnNG2RmP/ZibkcPyZUbcaVZ53AW4nKfBoxDPNEFm7li5rlX3s4+w9XEaBm3X7OVjmCzPtCDDbjyaXF11Muf+y5e8/5sl4qD8MEbvJNNXHyZfJz6HMgZa4slKAbRfFwSchIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKKk+vIi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKKk+vIi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343f52d15efso70297a91.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764184741; x=1764789541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmM47NgHtMZ2rqRM/UnW4U2oOKTLyh90pzle0O4Nb6A=;
        b=kKKk+vIizfw0cfKnyG7y+99LwPKChvv8peHnYuNyA5pUJWVoQxQlO8tPya2bCoZgNV
         CYRZ3xZw/AgsYenlRS/6aAGhysQao4Dj9xFIXP/faJkngDDvSxvXk5efX7zd0A+6PcYA
         f0M0nslE3dHJ0w28WAw/b7lSDPmykxXkmJLgOAj0rM4wCy3OyfKBICYFqvLR9iVpuJnY
         qvkc2bxPDEYUeDq6F+Z1TvAG8+SIFtJsAiVwi1EwW/VCGZYBSjOkAfNKKJpZsrMAocgz
         IOgpeyaRwq5HmeAtL+bGkwmD8xMQ/KRBwUzarsjgPqEwPFKOXbmJHmmFfRacl/W2oTkb
         /tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764184741; x=1764789541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmM47NgHtMZ2rqRM/UnW4U2oOKTLyh90pzle0O4Nb6A=;
        b=L3FXua6fluTfkPzXme4Yy80VwlQkGxZQ4Gh6Z9ZkUpZgeGMFEb2Fhm2mwK+S5gBBmS
         1+vbMD438A29ZA9vh1YeU9Mdx/TTA2cg3fq58M/Doxumwl/xW6p7AucFsYd3PgiaPtGy
         jZUkq4JlF5RmMSHjbSoZcW59F9ofDKkfayBpvpxfDwGkS1W5Qr3JKuZaPQnrrfHQars1
         jzje2bR/k2Y3sahNEfUrZyvBujXtAawwVkQqemEBh8vROJFODxhN9RxJmGvWoxR6P1XX
         9OSPovHD/XpqCM6vShbOcNu8e39R1TzDG3iDS5U+7wcaJCwFMGoUAaweRP0rvdLZjudv
         33lw==
X-Gm-Message-State: AOJu0YyuawdQSg5KlAm1rRBEW0jiKrVc+kV7YkOFfbqBygXi/jpOCZMH
	CYomKz3HSo1qmq5sA8tezz/auQbGHauGfF2QhgvA1mTilPvYKniB9yph
X-Gm-Gg: ASbGncv7pItFGqPwpDjojICRc5TqBCfdHphHxBS/hGWh5BSRk2puLjQtMvu0g6CU/dW
	vHqZGoCY76l/BWWYzBcz9QHtky9LSnb8o9mr+dU2N7Hp1hNoKIGK/Pr5RHcoHCQ8DBTWbqjAMYV
	kWwS2X9uhj6bpFORcckbyrks87jFrCcqbKngH5Ac2hwXufkkarL7AAZkBMTHCPNo3rXuaIRlZ3J
	4i/aHZuXTrwqtfucYBx0gZvdFiFRLG242VunShUkcfOpSWQN35l7ok/+Q1aseKm8pfUJqYsNAD1
	o5b5mRTKYWtFpX0KWJQ7BEmhqUnxZTMfn8vzpsKcOMktXdLWN3pJhOERtJDsu3b4msC+hNYUBsA
	QpvHeeSNqb06Tke0RSs87yXciQ/6jI8ZNDsCpkiVo/IAY+vu5060bqiHE3TOkP9f//766US6iOI
	wbnRQF9ySorMEnSpUoS2sAGHWm38cI7EaVT540OdpRe9SY3ouIqAyeImSYL/9+pdZZm7EO6Xe1w
	BE1/jn1LxZ6/hE0bCGNK+g=
X-Google-Smtp-Source: AGHT+IFk09CfxAeWMwJnkMUK7QwMAYEID3td4YWXm5iwHAIGuR/cG3dGR3O61SudiJDCFvC7a8cegw==
X-Received: by 2002:a17:90b:1f82:b0:340:a19f:c25b with SMTP id 98e67ed59e1d1-3475ed50999mr8346846a91.24.1764184741436;
        Wed, 26 Nov 2025 11:19:01 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:bc94:4b73:d55a:67b2? ([2409:40e3:30a4:b776:bc94:4b73:d55a:67b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a5603bdsm3396346a91.8.2025.11.26.11.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:19:00 -0800 (PST)
Message-ID: <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
Date: Thu, 27 Nov 2025 00:48:53 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, gitster@pobox.com, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 25/11/25 22:55, Johannes Schindelin wrote:
> Hi Siddharth,
>
> On Tue, 25 Nov 2025, Siddharth Asthana wrote:
>
>> The `git replay` command currently supports cherry-picking commits for
>> server-side history rewriting, but lacks the ability to revert them.
>> This patch adds a `--revert` option to enable reversing commits directly
>> on bare repositories.
>>
>> At GitLab, we use replay in Gitaly for efficient server-side operations.
>> Adding revert functionality enables us to reverse problematic commits
>> without client-side roundtrips, reducing network overhead.
>>
>> The implementation leverages the insight that cherry-pick and revert are
>> essentially the same merge operation with swapped arguments. By swapping
>> the base and pickme trees when calling `merge_incore_nonrecursive()`, we
>> effectively reverse the diff direction. The existing conflict handling,
>> ref updates, and atomic transaction support work unchanged.


Hi Johannes,
Thanks for the review!


> Are you reverting rebased Merge Requests commit by commit? If not, I would
> suggest the shortcut to use `merge-tree` directly for the entire Merge
> Request.


That's a great point. At GitLab, we have use cases for both approaches:

1.  For quick undoing an entire MR, the `merge-tree` approach you 
suggest is indeed more efficient and avoids unnecessary intermediate 
conflicts.

2. For commit-by-commit reverts, we need individual revert commits with 
proper attribution (which commit is being reverted) for auditability and 
history clarity. This is particularly useful when only specific commits 
from a merged branch need to be reverted.


I will add a note in the documentation mentioning the `merge-tree` 
alternative for whole-MR reverts.


> That is, if `$BASE` corresponds to the base branch onto which the
> Merge Request was rebased, and `$TIP` corresponds to the Merge Request's
> rebased tip commit, then the following will revert that Merge Request:
>
> 	git merge-tree --merge-base $TIP HEAD $BASE
>
> The upside is that this can potentially avoid a lot of unnecessary merge
> conflicts. The downside is that it does not revert the rebased Merge
> Request commit by commit.
>
> The patch itself looks fine to me, if a bit too extensive on the side of
> adding tests


Agreed. Looking at the tests again, I can consolidate several of them:
- The bare repo test can be merged with the basic revert test
- The multiple commits test overlaps with the basic functionality

I will trim down to essential coverage in v2: basic revert, conflict 
handling, and Reapply behavior.

Thanks,
Siddharth


> : Remember, a nimble test suite that catches a bug once is
> better than a long-running test suite that would catch a bug several times
> _iff_ it didn't tax the developer's patience so much that it is
> interrupted and aborted. You probably agree that Git's CI runtimes are
> already counter-productively long.
>
> Ciao,
> Johannes
>
>> The revert message generation logic is extracted into a new shared
>> `sequencer_format_revert_header()` function in `sequencer.c`, allowing
>> code reuse between `sequencer.c` and `builtin/replay.c`. The commit
>> messages follow `git revert` conventions, including "Revert"/"Reapply"
>> prefixes and the original commit SHA.
>>
>> This patch includes comprehensive tests covering various scenarios:
>> bare repositories, --advance mode, conflicts, reapply behavior, and
>> multiple commits.
>>
>> Siddharth Asthana (1):
>>    replay: add --revert option to reverse commit changes
>>
>>   Documentation/git-replay.adoc |  35 +++++++-
>>   builtin/replay.c              |  86 ++++++++++++++----
>>   sequencer.c                   |  23 +++++
>>   sequencer.h                   |   8 ++
>>   t/t3650-replay-basics.sh      | 160 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 295 insertions(+), 17 deletions(-)
>>
>> -- 
>> 2.51.0
>>
>>
