Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A33672A9
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222619; cv=none; b=bZWFmz8GcOIIorFJ0XAlc1YXGAp6uC0M5SMgkq7mr0GXN3z/sVNtxT/1+RSbkNbDh8on3qJ21Gkc13hris2ngulnZvTaHBoWk04hrJYinGpAu5+FjfN52oTglf0hjh7hYA9+a7MNG2WqeWMitZQQilPmpcg5yOn7kPHzO+QKZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222619; c=relaxed/simple;
	bh=klrl2hnvm6GFhQs+15FU8MdgwEHh7lQFjyLUYIfDVFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuGalsgvn1BZASz8G/WVg37tKiKJAm70Fk5CzjDAWwDVJCnn0z93uarVxW2AztB8eapTuaX3v0oyf6nFxdJXyk2TltUWNSOvMcDis86UK7dDRr+Yi8Ki8PizFuj9RhA53/fwrXYmwuyoqSoKDIEFomxPCliJqMZcoZ4ME+KkEtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSOHMd5H; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSOHMd5H"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so6210590e87.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782222616; x=1782827416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5i3Ex/hTla1Z9HjMBSGPIDdK+No4ZHRfGj6A7VXIX0M=;
        b=bSOHMd5HlPRcKLT57/Y36lOkYtKP7MurSrrA2r4N6uvDF6Wv+pJJ948aDsnsDadK5R
         EyL4kuUBNoxq9sNxUlbsPYxg5v6t4ik6xzPjLNni0zmlp0l2VWB2BPd/7PoCjFvxdQFD
         Gn6rWVAqzme2xpWNcVIWvFGV9+mDAHE2cWvj/gP+Uf3M6/ZROM0Q9KcPhzN2gE5XxQSQ
         x+eXStk0QUyYNiHhoDGXBQbK3OpZpZW6gusp/X8XFl6HNAPaep0oOqDbZ3w01qJdGnUM
         aZ7DWkARfeFHnoxNRFsl8MhY99kXQQJlh7IRk3/uDLwdQoxcPNacYdUNAy1c+Iu+StP+
         zl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222616; x=1782827416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i3Ex/hTla1Z9HjMBSGPIDdK+No4ZHRfGj6A7VXIX0M=;
        b=NhIAqFWQuDKsllEnEvy0CmH5pepYb/dgZ+wCW/b7reLZnJmQCgwkZbGRgOF+KZJJIx
         IpewITv7SLAi4554BJzwcwCf3IBgF0CZX8WqmntEziuESUq+qUIpquiMFF0NmdgN/5uL
         S8i0wi4k1+eVEethbY8upPprCZR0jZ+rMfQJihdxIj66+QmG2zABJjcoggakPF+fNONN
         orYPCDhgwHp05yLoh8Cdy3Umv2wYWz68XJ4NsoHbQFoyxdJw3gEp4dJwwjV2NRvRtLRN
         1+KFF2oShXdyC99Yc1AF6p2TLt6mS0F7sLAHdvH7ogwoaUIXEU+0prrsHr6U8OUcLFka
         ykZg==
X-Forwarded-Encrypted: i=1; AFNElJ8uWeKCevfqDV3ErUHh1QY5UDayCTz9J9UYfgj7YQ6l/54fn8ITMh8Vdi2CZ2hFvCTAYvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9HQO4lRZX0fn76k5fqhHVM810rwSW738e1A/Mq2LItvBkqxO
	CQKdb53SZIg//qLk+cB9U+ku4n5C3YtTAt/6CTXs/LHLImwAksr35hFW
X-Gm-Gg: AfdE7cmRI1oKDkUHdeOzzgaZjE0Eac9BwcaZxX3ivk7g3jmF7iQ6f20H/k4IXdRvjjy
	f1I9LqG2x3tjyh6IE75TdeRdXav+tnj6gpBfO5vKeJIAj2GW3aTQp+ALtKpZEQ+jdeiNvDSCYvN
	Hq34CMgxpenRbplAIK6JR2XwjUhwjKibJhyOMm0I9tTKKYyAo4G6PEZxis+PK60L+bNY8MdmokW
	+GoGf6/w6etYSJnOe8LD0EEq4xtmWm+Od/KYqiOhle4YEqYTJfLOwIFYSci/SiX0nocQKBY1RT5
	J4xR5R76QZ9i3chUHIewkWn4SdmZ5DTxwxCNYqXSMxV/wLNE8JPZdUtLe9s+n8EEPowUBpS+aYh
	52jINtLx2JjAlkAWsp/xEkjpJv8xUFwKcn7x3b+ZzMzgteVF6HuPa00P39ABZApjUExWt4j3y7g
	b41flYAFhkmzCYZnvLaoookpOvd0icnGzO63UZRkaSZPcYCJTIvIMnXtZrmw==
X-Received: by 2002:a05:6512:4288:b0:5ad:691c:b874 with SMTP id 2adb3069b0e04-5ae3e51ea9cmr819635e87.43.1782222616188;
        Tue, 23 Jun 2026 06:50:16 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69585b28sm829517e87.79.2026.06.23.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 06:50:15 -0700 (PDT)
Message-ID: <509fa950-fb9b-468d-b917-6c0eb7823d64@gmail.com>
Date: Tue, 23 Jun 2026 09:50:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com>
 <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
 <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com>
 <CAL71e4NFHz_zVCWPvmTO8UPNyaKkDFqNQdd3CJykoiGmEhfUTA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4NFHz_zVCWPvmTO8UPNyaKkDFqNQdd3CJykoiGmEhfUTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/2026 6:13 AM, Kristofer Karlsson wrote:
> On Mon, 22 Jun 2026 at 22:23, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/22/2026 3:14 PM, Kristofer Karlsson wrote:
>>>
>>> On Mon, 22 Jun 2026 at 20:10, Derrick Stolee <stolee@gmail.com> wrote:
>>>>
>>>> When possible, I like to try to make loops only have one terminating
>>>> condition. Should we have paint_queue_get() return NULL when it sees
>>>> this internal state condition?
>>>
>>> Possibly, but that would couple the paint_queue struct very tightly with
>>> the usage. Not a problem in practice since it only has one call site, and
>>> it's unlikely that we want to add more of them but it may feel more natural
>>> to let the paint_queue purely have the queue semantics and counters,
>>> and keep the halt condition within the function itself. I don't feel
>>> super-strongly about this and can change it if needed, I will just need to
>>> verify that nothing else gets complex as a result, I have not fully thought
>>> through the effects.
>>
>> Hm. Interesting. The coupling is perhaps expected, because the data
>> structure tracks counts that don't otherwise need to be tracked.
>> Maybe the terminating condition method could be descriptively named
>> to say why it would be completing.
>>
> 
> I have been working on v2 locally and most of the changes landed
> nicely and were clear improvements but there's one point I would
> want to discuss a bit more.
> 
> For the termination conditions, I moved them into paint_queue_get()
> as you suggested.  The all-zero check was straightforward since it
> only depends on the counters but the side-exhaustion check also
> needs to know whether we have entered the finite-generation region,
> so I pass last_gen (already a local in paint_down_to_common) as a
> parameter:
> 
>   static struct commit *paint_queue_get(struct paint_state *state,
>                                         timestamp_t last_gen)
> 
> Inside, the two conditions merge nicely under a shared guard:
> 
>   if (!state->pending_merge_bases) {
>       if (!state->p1_count && !state->p2_count)
>           return NULL;
>       if (last_gen < GENERATION_NUMBER_INFINITY &&
>           (!state->p1_count || !state->p2_count))
>           return NULL;
>   }

This looks good to me. I'm not even bothered by the last_gen
parameter. You do make a good point about it being a potentially
leaky abstraction.

> Both conditions require pending_merge_bases == 0, so the nesting
> felt natural. The first is "nothing non-stale left" (works in any
> region). The second is "one side exhausted" (only in the finite
> region where topological ordering holds).
> 
> I think passing in last_gen into paint_queue_get() feels _slightly_
> awkward but not too bad in practice.  However, we also have my
> older (first) patch with the fast-exit if the caller only needs one
> merge base -- that has a separate break that also could be folded
> into paint_queue_get(). The messy part here is that we would need
> to also pass the mb_flags parameter to paint_queue_get().

How much of this data that you are passing into the method could be
state in the paint_queue struct? Could we have the paint_queue manage
all of the state necessary to make decisions around the walk
termination?

Or, could we do a peek into the queue to see the "top" commit, and
check if it is a finite commit or not? I know that 'last_gen' is
supposed to be the commit walked in the previous cycle, but it seems
that we only care about "the remaining commits are finite" as our
condition. 
> Perhaps we should just let this remain as-is for now and follow up
> with _removing_ that optimization. I think the value of having it
> is much diminished (but not fully gone) by the side-exhaust approach.
> 
> Additionally there's a correctness argument to be made -- perhaps
> all callers _should_ care about multiple merge bases existing, and
> instead bail out if it finds more than one. The only use case
> where this matters today is "git merge-base A B" without --all.

> Right now I am leaning towards simply passing in last_gen and
> containing all of the halt conditions there
> (except the old !FIND_ALL).

This is a good start, but hopefully storing the data in the
struct would be a good way to handle that.

Thanks,
-Stolee

