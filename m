Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C665301480
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399800; cv=none; b=T2cpaSCTJvvqEmSwF/z08HCpjif6ni/4NNdb0GIgU8OkwV/Oe2wQP0ZA5TM0IvulJhPr2rH6MdCoVsSVhODQlK/Wc24d9oIOoGixItsJUyqA9PJ9K4XiLE08uHnw+Wex/2QSNxhyKicDadzOIpii5YEwN5rdaiT/Zchg9fHbvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399800; c=relaxed/simple;
	bh=SwKn/v1CrxF5B5/5wfhYJJJhUQGCBsltI3HrJTkha7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkOwmovU9OKf4FTwSs537Vl6jsOqx7JdC6gaoiuOqPky8UM2oDaHgHxA2I1fkgB/0DZ/0+lM81L/K0PRSq2J414kCVwZRdJyigVidcLgmMOUPSNcbQcG3vwG8ZSOujVt9XDpPTLTZp2GQKhYNQTYBfPcJTryhKwxGnvTrcgDUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5K0/FMJ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5K0/FMJ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4434649a12.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399798; x=1758004598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81VvdMZVJ0KDQiU/xjvsH4gE/yvgkOBX/j+MzUXyeNY=;
        b=E5K0/FMJ2xeyGrRF5XjsmR7ZutdVxkLFUSUshN3uWP70lyVagsjbYHSncUUMwvl/8O
         e5U0eo8UJB0rWfXbNd5xtwLH4tA6GfsELgSsHDoVa9b7E7K2ZFZrJ2Z2rsP9DrSn4wbO
         +mdbQvZWmORoRfNCj54x2GFrNiVHKdEfQgvWHd4k9gHTBAFIWcml/kItf1QmkxIVzgU+
         6mUG+SDMGl1YWi5Dsb/VvJD0JRpfYMY6GCHLFDLPC+w+1WhGBmJ8DDwT1NKTbeOhwuHX
         6yfkACltZXaxzU5AMwMofHvCyQzF5m+2yIlol9FFTL/vG60Y6WEIPPfs6ZNmJgD2qLTx
         vJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399798; x=1758004598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81VvdMZVJ0KDQiU/xjvsH4gE/yvgkOBX/j+MzUXyeNY=;
        b=s2WlK3VCqED75H9nQJ0RDt8ALlw4shuBzBLdMUGLodxYCQHCc2WIPAo9PkXPussPSe
         cYCJmEqDOmYXn3xzr+5IfNinQY2Xu4UnfJl9uKqq0wDm4Wf0pJVeRj3kIMFc5YAZaqQM
         QKgeYtjTbUWNryA7L8BpQPAHGJ5/ePG+uxf1gPnb3i2zHVRl60iQ4X425f5Q4UG5dk8g
         yq/S7PBcmRdAx6PtC7v4R2OSmCnoFqhthNMieSCL29RBtcN+WTHHBEUgW7/h5tvhj6Q1
         cfmNEzUpc5I6D44rwzHA1DVCe+jdpSZfP1kHLXdgW/qvYk/w7JuuTV3aXL+q3Jb8pWK1
         kLuQ==
X-Gm-Message-State: AOJu0YwHSc1KF97ncvKAFOYP4SUJAUH9JgGezXmHXKGn+ymu2GF4YAd2
	rOraqIoMspwiqoD+HTDcHA0ZXgTXwABoJjXH+BtvnWNcZBALqgtkIbCdhdEGIiyz
X-Gm-Gg: ASbGncvbZAovDcgW46mtXuKr+bYK4Frf+TYxjeL8bWBMTTv1ot3ZBRTo6ZGv/NiTWGn
	RHb0uqD9gyhbU5fczDR9NDOlGskPg035vFkmEiq7sgLHPoXx/vXp/lGGA3BDB1xhVTLbqnbTXry
	Clyvb9Qw89+qGVWnX5hXs8seZNDe4C+8YR4XG7IUccJlWJeGp1CI5Iky1DzrJpk5LHY1emh7bju
	AXQZabIgfcFC4jp/+XWQQOlEo50KOSaLkSLXyoLQGWHowfjStQ1KxnY+/eTw5zX9eBobDz0mPGf
	M+f8TS2NM2czQEajMGdSPFaW6Uk4P6UiTvVPPWEYmsJ7Luq3J4Y/qBr8XZWxG3E70ysd8dbXsIH
	nRrXqC/ojQxS7y+5bchQstWelKtbrHjjX1TGt94u80+sERetfgjiXrXLrOCSdrOLZOCTJQ3m8/M
	Bpm4xH0m6D+svrAXX6a14tXInd8K9vAAN+hhz6F1qMPImX
X-Google-Smtp-Source: AGHT+IGn27B+6diN6aX+K5sIRzXBzOK02mEE8Mzl7PW15/Hjg9v0I1cHiGZqdyA0uLRlqvmq1SZpeg==
X-Received: by 2002:a17:902:e804:b0:246:76ee:535b with SMTP id d9443c01a7336-2516f050947mr139146755ad.27.1757399797996;
        Mon, 08 Sep 2025 23:36:37 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:c01c:f128:b5c5:e0c? ([2406:7400:56:7e97:c01c:f128:b5c5:e0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9669a0e1sm160755765ad.56.2025.09.08.23.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 23:36:37 -0700 (PDT)
Message-ID: <7f90e1b6-acba-40f2-9e51-ad09c2bf6999@gmail.com>
Date: Tue, 9 Sep 2025 12:06:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com>
 <CAP8UFD3Db-n3CY=KBpn-2Nt=SYY=5ckF3J_4ho6C19SVcrfdsQ@mail.gmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD3Db-n3CY=KBpn-2Nt=SYY=5ckF3J_4ho6C19SVcrfdsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/09/25 11:30, Christian Couder wrote:
> On Mon, Sep 8, 2025 at 6:36 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> Add documentation for the new --update-refs option which performs
>> ref updates directly using Git's ref transaction API, eliminating
>> the need for users to pipe output to git update-ref --stdin.
Hi Christian,

Thanks for the detailed review.
> Most of the time, the documentation should be part of the patch that
> introduces the documented behavior, not in a separate patch.
You are right I will combine them in v2.
>
>> Also document the --batch option which can be used with --update-refs
>> to allow partial failures in ref updates.
> It looks like a --update option was also added by the previous patch.
> Is it documented here too?
>
> Why was this [--update | --update-refs [--batch]] set of options
> selected over other possibilities like for example
> [--update-iteratively | --update-atomically | --update-batch]?
I was trying to provide both simple and advanced modes. --update for 
users who just want "make it work like piping to git update-ref --stdin" 
and --update-refs for those who want control over transaction modes. But 
I see this creates confusion.

Would you prefer a single option like --update-refs with an optional 
mode parameter? Something like --update-refs[=batch] where default is 
atomic?
>
> Also how does this --update-refs option compare to the --update-refs
> option in git rebase? Is it working in the same way?
No, they are different. git rebase --update-refs updates refs that point 
to commits being rebased. --update-refs updates the target branches from 
the replay operation itself. The naming collision is unfortunate should 
I use a different name?
>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>   Documentation/git-replay.adoc | 62 +++++++++++++++++++++++++++++++----
>>   1 file changed, 56 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>> index 0b12bf8aa4..cc9f868c2f 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -9,16 +9,17 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
>> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--update | --update-refs [--batch]] <revision-range>...
> Here --update, --update-refs and --batch are all documented, nice.
>
>>   DESCRIPTION
>>   -----------
>>
>>   Takes ranges of commits and replays them onto a new location. Leaves
>> -the working tree and the index untouched, and updates no references.
>> -The output of this command is meant to be used as input to
>> +the working tree and the index untouched, and by default updates no
>> +references. The output of this command is meant to be used as input to
>>   `git update-ref --stdin`, which would update the relevant branches
>> -(see the OUTPUT section below).
>> +(see the OUTPUT section below). Alternatively, with `--update`, the
>> +refs can be updated directly.
> Here only --update is documented.
>
>>   THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>>
>> @@ -42,6 +43,24 @@ When `--advance` is specified, the update-ref command(s) in the output
>>   will update the branch passed as an argument to `--advance` to point at
>>   the new commits (in other words, this mimics a cherry-pick operation).
>>
>> +--update::
>> +       Update the relevant refs directly instead of outputting
>> +       update-ref commands. When this option is used, no output is
>> +       produced on successful completion,
> It seems a bit redundant to say both "instead of outputting update-ref
> commands" and then "no output is produced on successful completion".
> Maybe there is a way to reword this to be a bit more concise.
You are right that's redundant. I will reword it.
>
>> and the refs are updated
>> +       immediately. If any ref update fails, the command will exit
>> +       with a non-zero status.
> This doesn't say if the command immediately stops when it fails to
> update a ref, and if the ref updates are atomic or not.
You are right the docs need to be clearer about the behavior 
differences. I will clarify that --update stops immediately on failure 
(like git update-ref --stdin), while --update-refs defaults to atomic mode.
>
>> +--update-refs::
>> +       Update the relevant refs using ref transactions instead of outputting
>> +       update-ref commands. By default, uses atomic mode where all ref updates
>> +       succeed or all fail.
> This seems to imply that --update doesn't update the refs atomically.
That correct --update doesn't use transactions it updates refs one by 
one like `git update-ref --stdin` does. Should I make this clearer in 
the documentation?
>
>> Use with `--batch` to allow partial updates.
> What about --update, when should it be used?
Good point. My thinking was --update for simple cases where you want the 
exact same behavior as piping to `git update-ref --stdin` and 
--update-refs when you want transaction guarantees. But I am starting to 
think this distinction might be confusing users more than helping them.

Would it be cleaner to just have --update-refs with the batch mode 
option and drop --update entirely? The sequential behavior can be 
achieved with --update-refs --batch if someone really needs it.
>
>> +       When this option is used, no output is produced on successful completion.
> Here also it seems a bit redundant to say both "instead of outputting
> update-ref commands" and then "no output is produced on successful
> completion". And maybe there is a way to reword this to be a bit more
> concise.
Yes same redundancy issue. I will fix the wording throughout in v2.
>
>> +--batch::
>> +       Can only be used with `--update-refs`. Enables batch mode for ref
>> +       updates, allowing some refs to be updated successfully even if others
>> +       fail. Failed updates are reported as warnings rather than errors.
> What's the difference with --update? Is it that --update immediately
> stops when a ref update fails?
Yes exactly. --update mimics the behavior of piping to `git update-ref 
--stdin` and it stops immediately on the first failure and doesn't 
update any remaining refs.

--update-refs uses transactions, so in atomic mode all refs are updated 
together or none at all, and in batch mode it can continue processing 
remaining refs even after some fail.
>
>>   <revision-range>::
>>          Range of commits to replay. More than one <revision-range> can
>>          be passed, but in `--advance <branch>` mode, they should have
>> @@ -54,8 +73,9 @@ include::rev-list-options.adoc[]
>>   OUTPUT
>>   ------
>>
>> -When there are no conflicts, the output of this command is usable as
>> -input to `git update-ref --stdin`.  It is of the form:
>> +When there are no conflicts and neither `--update` nor `--update-refs`
>> +is used, the output of this command is usable as input to `git update-ref --stdin`.
>> +It is of the form:
>>
>>          update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
>>          update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
>> @@ -66,6 +86,15 @@ the shape of the history being replayed.  When using `--advance`, the
>>   number of refs updated is always one, but for `--onto`, it can be one
>>   or more (rebasing multiple branches simultaneously is supported).
>>
>> +When `--update` is used, no output is produced and the refs are updated
>> +directly using individual ref updates. This is equivalent to piping the normal output to
>> +`git update-ref --stdin`.
> Is it equivalent to `git update-ref --stdin` because both exit as soon
> as a ref update fails?
Yes that is the intention. Both --update and `git update-ref --stdin` 
process refs sequentially and exit on first failure leaving the 
repository in a partially updated state if failure occurs partway through.

The difference is --update does this internally without needing the pipe 
while --update-refs uses proper transactions for better atomicity 
guarantees.
>> +When `--update-refs` is used, no output is produced and the refs are updated
>> +using ref transactions. In atomic mode (default), all ref updates succeed
>> +or all fail. In batch mode (with `--batch`), some updates may succeed while
>> +others fail, with failed updates reported as warnings.
