Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9921FF2A
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857223; cv=none; b=iPOULC9r+044kQUW8fwUDqiJ/ZS5y1S15Kl0bpSIsJogBUAsaMV4gzKW/7VJZbvTMKtMRvR7aF4LP22Oungs2w/k52g5jZVy9mPZdxRDLb/TJ/NcJKL7Hjpim9xhWzU7tqX/ID/fC+6JcV+ZvrVvXtsildasDAeccuWdddmmLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857223; c=relaxed/simple;
	bh=wbNrooi+GzjL9ZK/3o6QRQFsIrh/Pek0bT1d1XIDu6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idTqfcXM2eLpYurb8xP4Fy+1kDWlQB3OpxoCMZtmwgu29n0vOohKo92S1skIv9MOs5H/Rr3vOjwycAgLH1QmanSgkZuy6hlmsHv0sv2F7P628ImuqPMam7LWNNz6mcSy08wOIFpuLnGUVnYNMpCAx5cLwxW2KipCSoKbN/mz8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X91Ms3tZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X91Ms3tZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso639002f8f.2
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764857220; x=1765462020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C6W8uWMjipQSPvQG6wWh6eHrOtlcmVxm9dSWcJnTXl4=;
        b=X91Ms3tZtagASNg4t4DXwP2LLXwi6mmqbCjtlAoUWvDwHhvTc0lC+2l1LB8k1R7zvX
         D537c/UuT4AzezGpmsOO441Y0IR/OHRQWz/ONBBbhIwYO83Hio89m1vKFiVRUuMNqp7B
         fwOO4vt7+nzQ6/mZBDbgYLOxMJ7ERWCO7c/zoDcGS5tliyQRorVqKMN2uTarIU7wnNi6
         h9DYsE9CtF+dGBqS+MaEp+RA0d8VAcHsfV1qA5zGfkwx8eVNRjblNC/D/pOcwde5Lp/o
         JdAhZ60fq9DT2CTFJIpD09C7N57InguO+1ncG6yvI9lv+mS4EwFvo44LDgUKJ73yJ3g5
         Eh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764857220; x=1765462020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6W8uWMjipQSPvQG6wWh6eHrOtlcmVxm9dSWcJnTXl4=;
        b=VQezpZXf+YJsaoOSnGowA1gKPyS6V4pG4ZZDTWgxdvqhkR2Njy2ORY0IFzPo0lbJQn
         hZ81zbJ76tPJXRU3qf7oXY5SZhbDVYzJPc0velK9Y2wy/K8mB2BD/k5VRMGP72G6uNdZ
         aHjmLdeeOaIIme8rD9ms7ADgX9cUFKK2vPOMWCVOV//GUH84nyLipcR8kwLOXe8oG1JX
         I35yaNxLBZckJQHl3lQbh8YgusfCYXRQYPG65MmlUyOeYzN5XExqaHkFjNpCUvurNr03
         NaBTQOh7YemUQmC3NoQakOlZiLgrHjmkbn3GUYC7JFt1LsuxPkED20T19h88s5YzYVf7
         iCtA==
X-Gm-Message-State: AOJu0YxBOYm301cC007lKuJIUWHpLAlDfvMWf2V4qkZXrN94B4SNOwTR
	+y6u6lUQaUqWNWUT1NpcQ4fqFyMDE9kzxIWg11Vj/2tV/w7VFr2XNu6hgytCHA==
X-Gm-Gg: ASbGncuAxRS0/7F2zkT/UsYXDjlM77cM3q5JBzS9jjc30lnoziZ741Zwbso+iGoxw2d
	QA8mh59ymASEQ0YpZk9FQz59Os11aCQihgo0QuWDz0wplekXoutH87G3ViChRWLTpZJ/AmRQERV
	TYO5uNF7/PVnCJsBh6x6engdKVb950vjoRuTl1j946jaZFfZKWhqu8bErtyxazUonLsjQxklHeq
	mtySYW0g0trN2nP63obeqny5OROZn3YJlpCqYDTzKKU73Ga83czgjGyXjNlNcbP24V3+Ct/BsHd
	tTh/qiKTnByjVrWtOKzkmYoLv0Y9piJByJFrQTJc50UJjpl8WRxRQfuJ83Sub/1iMA9z5Qvf2aP
	/pi/zY88AKuoTj6wEI8CJId5GXxp+rw2nysL62Qk4sRuk06NQJSA3btloGytcpSY0TWOzjSogq5
	mvWE28R8I2DFnTotx/KDjUdMuQvXH/5Cn91xDVhb4za4sCtvn/2k+rcqYhmhPEu4E=
X-Google-Smtp-Source: AGHT+IFHSQ2H1Uu6dAX+RuFTtEhnaQMD7gnCW+YsN3Vas1Yz/5+vFsINtby66HV4/Q8cxuDlQ76d0g==
X-Received: by 2002:a05:6000:1a8a:b0:42b:5628:f4a3 with SMTP id ffacd0b85a97d-42f731678e9mr6706565f8f.1.1764857219756;
        Thu, 04 Dec 2025 06:06:59 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222478sm3374940f8f.20.2025.12.04.06.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:06:59 -0800 (PST)
Message-ID: <10f9afd8-6ac2-4e17-979f-2222bd0a2fda@gmail.com>
Date: Thu, 4 Dec 2025 14:06:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] replay: drop commits that become empty
To: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <CABPp-BEZFPmLnEtnD0WaNbkZ5uE7q5T6uKJQRUvtq+L=C1o9wg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BEZFPmLnEtnD0WaNbkZ5uE7q5T6uKJQRUvtq+L=C1o9wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2025 08:06, Elijah Newren wrote:
> On Thu, Nov 27, 2025 at 8:16 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the changes in a commit being replayed are already in the branch
>> that the commits are being replayed onto then "git replay" creates an
>> empty commit. This is confusing because the commit message no longer
>> matches the contents of the commit. Drop the commit instead. Commits
>> that start off empty are not dropped.
> 
> Yeah, I've got a commit in my local branch that does the same thing.
> 
> It feels like there should be a paragraph break in here somewhere, but
> maybe that's just me?  Pretty minor either way.

Yes it could do with a paragraph break, I'll add one

>> This matches the behavior of
>> "git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
>> --empty-drop". If a branch points to a commit that is dropped it will
>> be updated to point to the last commit that was not dropped. This can
>> been seen in the new test where "topic1" is updated to point to the
>> rebased "C" as "F" is dropped because it is already upstream. While
>> this is a breaking change "git replay" is marked as experimental to
>> allow improvements like this that change the behavior.
> 
> Yep.
> 
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> Elijah - I'm not really clear why we were setting result->tree before
>> calling merge_incore_nonrecursive(), was it just for convenience to
>> avoid declaring a local variable or have I missed something?
> 
> I don't know the reason.  That traces back to a commit with
> Christian's Co-authored-by, so it may have been either him or me that
> introduced it.  My original work on replay was on a branch that I long
> ago rebased on top of the version Christian submitted, and the old
> history is no longer reachable from my local reflog, so I don't have a
> way to narrow down who of us did it.  If it was him, he may be able to
> answer.  If it was me, I've long since forgotten.  I think using a
> temporary, as you've done, is better.

Thanks, I was worried I might have missed some subtlety and 
inadvertently broken a corner case.

>> +       # Write the new value of refs/heads/empty to "new-empty" and
>> +       # generate a sed script that annotates the output of
>> +       # `git log --format="%H %s"` with the updated branches
>> +       SCRIPT="$(sed -e "
>> +               /empty/{
>> +                       h
>> +                       s|^.*empty \([^ ]*\) .*|\1|wnew-empty
>> +                       g
>> +               }
>> +               s|^.*/\([^/ ]*\) \([^ ]*\).*|/^\2/s/\\\$/ (\1)/|
>> +               \$s|\$|;s/^[^ ]* //|" result)" &&
>> +       git log --format="%H %s" --stdin <new-empty >actual.raw &&
>> +       sed -e "$SCRIPT" actual.raw >actual &&
>> +       test_write_lines >expect \
>> +               "empty (empty)" "H (topic3)" G "C (topic1)" F M L B A &&
>> +       test_cmp expect actual
> 
> After digging around for a while (my sed-fu is far weaker than yours),
> this feels like you are going out of your way to avoid changing any
> branches, but then trying to figure out what the branch changes would
> have been.  Would it be simpler to remove the --ref-action=print
> flags, check directly what changes were made, and use a
> test_when_finished to reset the branches back to their starting point
> at the end?  That'd change this test to something like:

I used --ref-action=print to match the existing tests, but it would be 
much simpler to drop it. Your suggestion below looks good.

Thanks

Phillip


> test_expect_success 'commits that become empty are dropped' '
>      # Save original branches
>      git for-each-ref --format="update %(refname) %(objectname)"
> refs/heads/ >original-branches &&
>      test_when_finished "git update-ref --stdin <original-branches &&
> rm original-branches" &&
> 
>      # Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
>      git replay --advance main topic1^! &&
> 
>      # Replay all of A..empty onto main (which includes topic1 & thus F
> in the middle)
>      git replay --onto main --contained A..empty &&
> 
>      # Check that "F" was applied first, then "C", and that "F" wasn't
> applied twice.  Also, that topic1 now points to "C".
>      git log --format="%s%d" L..empty >actual &&
>      test_write_lines >expect \
>          "empty (empty)" "H (topic3)" G "C (topic1)" F "M (main)" &&
>      test_cmp expect actual
> '
> 

