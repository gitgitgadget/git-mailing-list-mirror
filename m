Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55619B5B8
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556354; cv=none; b=Q0eQYyuquIV0VCTX7USasefCUqhp7XhWxmS4+MaQUVTKUeUAKNwqKADyDhBvTZbvEITrRUOYv8mT1shFofhMEyPPiNiqEQAUMe8P1M+h0s9b6j7UvAd+0H5SRunhE17DBRPd0V6TdXfkD2vn4AQhf7a/bRRKS3/u+PKGJVBar9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556354; c=relaxed/simple;
	bh=NBWRDWXltWHR2Zwt4pzz2M+LS6apQBcTrTRmIhkwu5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uufRvTmutA7eIR7tVLutdz1dmkjBiJOZUZi8aLY++WOgo4xPQBWTJ5CeE5fFNpWLAD+I63SbZ0DAHhg4N7P08NrVVhL7TngLKgS0RzHpJG6ykSF5JPTlhbsGGcFZ0omMH/Y8a99RYWwZZiR8T8vGHlhndnETt4sDe0lxTT8yukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLJAuOKb; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLJAuOKb"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso5176264276.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723556352; x=1724161152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfkdPiFkLQUBkafxxxDAtICUaj+UwKOarRxEiYh24Kc=;
        b=cLJAuOKbtFZnvopgJLq18t4NtiZNPyNqnsvDqqPkBoBY1CTgDuOQ9X0ktLh0BrpU/I
         t/dkQhALD7lNYo3n+MYtX008wCkF4pv0Ry80MMiO/FiUvdt8WQeV+o76tAf2eLc4KUDu
         9EVNukuXVw5uhu5RHN5f0ZZMB3oB41pFBq/ko+fjFknKoSqrzWRSVE3mEMsnuWArQi8L
         +cLnp8yqlv4FTrV+4f4DQu7s1YNqAt889md8U6A4bL+U+Dp9hl7oZwsc6js31m7IMF8F
         Lv/YH9ZKp831/i/5iOMHM+gmeVhuMHstEaXp5Vz1vvFjYNEwr1LHvZQyGpH/nMLAbBa2
         Z3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556352; x=1724161152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfkdPiFkLQUBkafxxxDAtICUaj+UwKOarRxEiYh24Kc=;
        b=FdQ6Wtea2ApYRKrvbZ4nNUvQLM4CZ99Ziit6Y1UfcAPkNOFcxOSUHUkW0ESDDpPUBO
         8PtCzGjW3H2UJqo/g2kPZZi6R1NKDMkLsrzJuhtdp0min45G5ysS6A+QatV/E82y1keV
         DHHSQbx3PNQW6IOp2AYY6t/SYhCG2T135XevRzbYp56trU0jLaSJ2yz9cX6NMI0ysFis
         4BE+XVeiMvocicAhWMN9F9dWkDiKe99Mcq6w1ITuGNPSPj257SXPRSm3vATUnqiBy1w5
         iHmLs1s92mTFJB/gwYZYjHsfiB43auoezpCm4y4w2vAjq48QhK2Sq6aQzjCVPOX6+Uk3
         Cb2g==
X-Gm-Message-State: AOJu0Yz/6ePwYT72DargSjYng3AMfNdZ096h9/ZagB22ioAfsTL5iJO4
	0J3CoYYrnTzWoVH/axxfVAIQS450exZiZoRcz5WwsIknP38XHMgH
X-Google-Smtp-Source: AGHT+IHXsaNmE+cYWYKPbBa0u7ekS7ZzlBokpVlcgVqU17VlkTVzi0LVLmQph1BpKsSsU5J4rU5Onw==
X-Received: by 2002:a05:6902:1087:b0:e0e:9196:ee4 with SMTP id 3f1490d57ef6-e113d27bb54mr4045026276.39.1723556351991;
        Tue, 13 Aug 2024 06:39:11 -0700 (PDT)
Received: from ?IPV6:2603:6081:1c00:1341:80b4:b73d:2075:7041? ([2603:6081:1c00:1341:80b4:b73d:2075:7041])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8ca5d25sm1554136276.57.2024.08.13.06.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:39:11 -0700 (PDT)
Message-ID: <bc7fac52-a055-46e5-83de-218fbcbdd605@gmail.com>
Date: Tue, 13 Aug 2024 09:39:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] commit-reach: add get_branch_base_for_tip
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, vdye@github.com
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
 <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
 <580026f910daaae6dba599fcd2408721b4f86c59.1723397687.git.gitgitgadget@gmail.com>
 <xmqqv8051o22.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv8051o22.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 4:30 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> Repositories that use pull requests (or merge requests) to advance one or
>> more "protected" branches, the history of that reference can be recovered by
>> following the first-parent history in most cases.
> 
> I cannot quite parse it, but perhaps "Repositories that" -> "In
> repositories that"?

That is an improvement, thanks.

>> Most are completed using
>> no-fast-forward merges, though squash merges are quite common. Less common
>> is rebase-and-merge, which still validates this assumption. Finally, the
>> case that breaks this assumption is the fast-forward update (with potential
>> rebasing).  Even in this case, the previous commit commonly appears in the
>> first-parent history of the branch.
> 
>> Given current command-line interface options, this optimization criteria is
>> not easy to detect directly. Even using the command
>>
>>    git rev-list --count --first-parent <base>..<source>
>>
>> does not measure this count, as it uses full reachability from <base> to
>> determine which commits to remove from the range '<base>..<source>'.
> 
> Makes me wonder if "--ancestry-path" would help.

One difficulty here is that we don't know the "first-parent merge base"
to supply to the --ancestry-path argument. You could first find this by
running

   git rev-list --first-parent --boundary --reverse A...B

and pulling out the first boundary commit 'C'. Then, that could be used in

  git rev-list  --first-parent --count --ancestry-path=C B

I believe that this two-process-per-ref approach would provide an
existing way to compute these results.

>> The trickiest part of the integer slab is what happens when reaching a
>> collision among the histories of the bases and the history of the source.
>> This is noticed when viewing the first parent and seeing that it has a slab
>> value that differs in sign (negative or positive). In this case, the
>> collision commit is stored in the method variable 'branch_point' and its
>> slab value is set to -1. The index of the best base (so far) is stored in
>> the method variable 'best_index'. It is possible that there are multiple
>> commits that have the branch_point as its first parent, leading to multiple
>> updates of best_index.  The result is determined when 'branch_point' is
>> visited in the commit walk, giving the guarantee that all commits that could
>> reach 'branch_point' were visited.
> 
> OK.
> 
>> +/*
>> + * This slab initializes integers to zero, so use "-1" for "tip is best" and
>> + * "i + 1" for "bases[i] is best".
>> + */
>> +define_commit_slab(best_branch_base, int);
>> +static struct best_branch_base best_branch_base;
>> +#define get_best(c) (*best_branch_base_at(&best_branch_base, c))
>> +#define set_best(c,v) (*best_branch_base_at(&best_branch_base, c) = v)
> 
> Micronit.  Prepare for macro arguments to be expressions, even if
> current callers don't use anything more complex, i.e., something
> like
> 
> 	(*best_branch_base_at(&best_branch_base, (c)))
> 	(*best_branch_base_at(&best_branch_base, (c)) = (v))

Thanks. I should have caught this myself.

>> +
>> +	/* Initialize queue and slab now that generations are guaranteed. */
>> +	init_best_branch_base(&best_branch_base);
>> +	set_best(tip, -1);
>> +	prio_queue_put(&queue, tip);
>> +
>> +	for (size_t i = 0; i < bases_nr; i++) {
>> +		struct commit *c = bases[i];
>> +
>> +		/* Has this already been marked as best by another commit? */
>> +		if (get_best(c))
>> +			continue;
> 
> Oh, so this defines the tie-breaking behaviour, but simply removing
> it is a wrong solution if we wanted our tie-breaking to work as
> "last one wins", as we still do not want to put it in the queue, so
> this "if best is already found, skip the rest" is serving dual
> purposes.  Good.

When trying to make a test case for the for-each-ref behavior around
non-commits, I noticed a bug here. If get_best(c) is -1, then 'c' is
equal to the base and should be selected. I will update the logic here
and add an appropriate test in this patch.

Thanks,
-Stolee

