Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AEE29A2
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443395; cv=none; b=Oia0GVc0/1T2fAVHJZg8akEXFtv8S6IYsNNmVowoOopImeJ8NCpCX4l8PVbCJOY11P5PAToYAJO1rqjBNwVqaa5b1TgO3bH2YHxLacXH72MKQqW5dc5Nvm2aEEFACd4kXl23S3FBUBBfwd/9DuoX8Wu3BbhDS3mpF8y2OZK2gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443395; c=relaxed/simple;
	bh=P4x7Mu3uZDNvT+BGyQGqUqhUvuSaZ5By8jmyRF+CJ4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrGmX7zNbzzZJeVSIZdKY+yVO5XjXfReCo4YkAceDuYxdMI/F2/te+DtUC4vqje/grRiYfMzH5gSOBGOt26FAu1p/j2XVSK4ccH9pYg8TC2NrCdVCbmCj83fGr5QMhVQVnAc1FoAeTrU9Rwl9qNG6RLRYwEAlx+JoDEuvsrJa6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll5AKxFK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll5AKxFK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so1223216a91.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759443392; x=1760048192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW34rDXW6c29kK7vhYhwXY9ioEurFVU/pq7xLxbDI5A=;
        b=Ll5AKxFKKmfbg5IO8rQosYW6ELbVixliqZaf40rrTrT4n/5ClQ/GOPCo05iC/PDA06
         6wftzunLJQnPQU4gI3BfG3ON/8nlzXXMfMlJVlyEyTXD6Us8ct22nebtrwz/rDmo2lxc
         UJzE+mI5Pu5YCbFGMb+dnrzPobuw4sSGV3LcIumNVtRV7lQlME8Z/FN2rrJPhSjjP4Zj
         P4AYIZJ7J+KfWUzmvKSBhSTjbKQlfqAfz5rRTo6AxqtEDKGCLUCEU4cxoQsV8b4NwNka
         i99rPd4v1AF57pbkhyAZ9WNtKS2tArSz89FR4F+f/0DB7iKiTo4WusPY2vImlG2AGubY
         w2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443392; x=1760048192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW34rDXW6c29kK7vhYhwXY9ioEurFVU/pq7xLxbDI5A=;
        b=Oic1GpdehWaV2r3Qz88IRChFdnAHOFbA02IUfgYR8ZyjjIi4VFMn1VZtVvd0/T+eLi
         s8PYhPPTdrhBwttpJa2AC6QuLsH59hRjm12YTGFNcqMkK210298DS/5Ca5lviJq4Q3We
         u+aRF5U0wG2QoUP/xMTl1r2YNjke51EZGsWD5YTNxQ/lazBYSnRAkG67pv7rksGlh1jM
         IS+3l42AWiIcn9EQECifwt8+5bhVfiKTBkCqSnbedItyUwv0fQGEUipnqaCARxakCWvG
         Y94KJjgSIicihtaoI97OOhaqCQwy4Wo6tvKH3tzhBEF4HtmuPbbIYjVUdbzgv36Hv4BE
         4HkQ==
X-Gm-Message-State: AOJu0YyIlloVBK4coyZo6MGf5q587tWg8y5bwSdY40GsBwX1eWv1yejt
	v+nd2PZwfH0H0OFfGMdgH/5Mw4WsoAj1mg4cL9SMIkcdibuCe0Llx26n
X-Gm-Gg: ASbGncv66L8TpWowgrxuHWl3b/jQ/w56+zFZQlYauFVneRNlEFTh80kJv+FIiETwPEU
	DfEBH9jhFpdUeLV+Dj+IZkdRHGo8i1bRQyS5mWoX9N2pDs7sEGOSgvHDHautO8k59q8OZnm6r8M
	Vchda+pNWsHOB9nZ87xepPuAJMJZNGZDmEjxE55kqf1/UWsfUHmbQFIjss8L9pAhxiZ+VkdzO7k
	sBS6cG1da7YsjCNQ4GrRVrNlIteoDoSH+i8biGuvW321ZUwr7jeaWk2nZv4Qd62vJuWZTCd/awF
	M8Z5hTnb2hUD11xTshQAsTm2RVptum2lG7pLGIZTuVToutFCvbqiPK2a9kFw9oDHDuxPdZKqX/y
	6OUjDJ0wiEkKl3SqbHOq9qy2IGfO+qhzm5QJV7+FIcUkrT2cFvC1oJHOJv01Ry9tZWDuGRNBtij
	NwBEBiov7eLdVNmERKPXXxyRTNT5tkrGhe6PzA0wj++KF6+WW0bioID4lSRopuWnOqL6wR3CqKv
	q2bbrF/sbqgyGGWOwHniRy3XPtm+/bsSQ==
X-Google-Smtp-Source: AGHT+IHfvXtxlFLBjQMuSMFb7yULXTMojeeAJFhs10LrRiH9OLUcPcWy7BSRp8dw6ShfE4k5Y4RMDg==
X-Received: by 2002:a17:90b:1c8e:b0:330:b9e8:32e3 with SMTP id 98e67ed59e1d1-339c221543cmr1064554a91.12.1759443391809;
        Thu, 02 Oct 2025 15:16:31 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:b4ff:982c:6a19:d5f4:4acb? ([2406:7400:56:b4ff:982c:6a19:d5f4:4acb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a7039781sm5911188a91.26.2025.10.02.15.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 15:16:31 -0700 (PDT)
Message-ID: <4a5eaefb-79cd-4b7b-ab3a-cbab648280f6@gmail.com>
Date: Fri, 3 Oct 2025 03:46:25 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, newren@gmail.com,
 code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30/09/25 13:53, Christian Couder wrote:
> On Sat, Sep 27, 2025 at 1:09 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> The git replay command currently outputs update commands that must be
>> piped to git update-ref --stdin to actually update references:
>>
>>      git replay --onto main topic1..topic2 | git update-ref --stdin
>>
>> This design has significant limitations for server-side operations. The
>> two-command pipeline creates coordination complexity, provides no atomic
>> transaction guarantees by default, and complicates automation in bare
>> repository environments where git replay is primarily used.
> Yeah, right.
>
>> During extensive mailing list discussion, multiple maintainers identified
>> that the current approach
> When you say "current approach" we first think we are talking about
> the behavior you described above when you said "The git replay command
> currently ..."
>
>> forces users to opt-in to atomic behavior rather
>> than defaulting to the safer, more reliable option.
> But here you are actually talking about what the previous version of
> this patch did.
>
>> Elijah Newren noted
>> that the experimental status explicitly allows such behavior changes, while
>> Patrick Steinhardt highlighted performance concerns with individual ref
>> updates in the reftable backend.
> Also the commit message is not the right place to describe what
> happened during discussions of the previous version(s) of a patch.
> It's not the right place to talk about previous version(s) of a patch
> in general. Those things should go into the cover letter.
>
> If you want to talk about an option that was considered but rejected,
> you can say something like the following instead of the whole
> paragraph:
>
> "To address this limitation, adding an option named for example
> `--atomic-update` was considered. With such an option `git replay
> --atomic-update --onto main topic1..topic2` would atomically update
> all the refs without having to use a separate `git update-ref --stdin`
> command. The issue is that this would force users to opt-in to the
> atomic behavior rather than have it as the default safer, faster and
> more reliable option.
>
> Fortunately the experimental status of the `git replay` command
> explicitly allows behavior changes, so we are allowed to make the
> command atomically update all the refs by default.
> "


Hi Christian,

Thanks for the detailed commit message review. You are absolutely right - I
was mixing the patch rationale with v1→v2 changelog, which belongs in the
cover letter.

Your suggested framing about considering an --atomic-update option but
rejecting it in favor of making it default is much clearer than my
approach. I will use that structure.

For v3:
- Move all "since v1" discussion to cover letter
- Use imperative mood ("Let's change" not "This patch changes")
- Be explicit that --output-commands and --allow-partial are new options
- Add full stops to the implementation details list
- Will add Helped-by trailers for Elijah, Patrick and you ofcourse as 
suggested.

Quick question: for the C89 compliance mention, should I drop it entirely
or briefly note "uses 'int' instead of 'bool' for C89 compatibility"? I
want to acknowledge the bool→int change but not belabor it.

Thanks again!


>
>> The core issue is that git replay was designed around command output rather
>> than direct action. This made sense for a plumbing tool, but creates barriers
>> for the primary use case: server-side operations that need reliable, atomic
>> ref updates without pipeline complexity.
> I think this paragraph should go just before the "Fortunately the
> experimental status of the `git replay` command explicitly ..." that I
> suggest above.
>
>> This patch changes the default behavior to update refs directly using Git's
> s/This patch changes/Let's change/
>
> (See our SubmittingPatches documentation where it suggests using
> imperative mood to describe the changes we make.)
>
>> ref transaction API:
>>
>>      git replay --onto main topic1..topic2
>>      # No output; all refs updated atomically or none
>>
>> The implementation uses ref_store_transaction_begin() with atomic mode by
>> default, ensuring all ref updates succeed or all fail as a single operation.
>> This leverages git replay's existing server-side strengths (in-memory operation,
>> no work tree requirement) while adding the atomic guarantees that server
>> operations require.
>>
>> For users needing the traditional pipeline workflow, --output-commands
>> preserves the original behavior:
> I think something like:
>
> "For users needing the traditional pipeline workflow, let's add a new
> `--output-commands`option that preserves the original behavior:"
>
> is more explicit and makes it clear that it's a new option added by
> this patch and not an existing option.
>
>>      git replay --output-commands --onto main topic1..topic2 | git update-ref --stdin
>>
>> The --allow-partial option enables partial failure tolerance.
> In the same way, something like:
>
> "Let's also add a new `--allow-partial` option that enables partial
> failure tolerance."
>
>> However, following
>> maintainer feedback, it implements a "strict success" model: the command exits
> I think you can remove "following maintainer feedback" here. The cover
> letter or a trailer like "Helped-by: ..." at the end of the commit
> message (but Junio will add his "Signed-off-by: ..." anyway so adding
> an Helped-by: ... about him is redundant) are the right place to
> mention people who helped or suggested changes.
>
>> with code 0 only if ALL ref updates succeed, and exits with code 1 if ANY
>> updates fail. This ensures that --allow-partial changes error reporting style
>> (warnings vs hard errors) but not success criteria, handling edge cases like
>> "no updates needed" cleanly.
>>
>> Implementation details:
>> - Empty commit ranges now return success (exit code 0) rather than failure,
>>    as no commits to replay is a valid successful operation
> Nit: as all the sentences in this "Implementation details" list start
> with an uppercase, I think they should end with a full stop.
>
>> - Added comprehensive test coverage with 12 new tests covering atomic behavior,
>>    option validation, bare repository support, and edge cases
>> - Fixed test isolation issues to prevent branch state contamination between tests
>> - Maintains C89 compliance and follows Git's established coding conventions
> I am not sure this one is worth mentioning here, at least not like
> this. You may want to say in the cover letter that compared to the
> previous version this patch doesn't use 'bool' anymore and explain
> why. Or maybe you want to explain here that using the 'bool' type was
> considered but rejected for some reason. But in both cases, you should
> be explicit about the reason.
>
>> - Refactored option validation to use die_for_incompatible_opt2() for both
>>    --advance/--contained and --allow-partial/--output-commands conflicts,
>>    providing consistent error reporting
>> - Fixed --allow-partial exit code behavior to implement "strict success" model
>>    where any ref update failures result in exit code 1, even with partial tolerance
> This should probably go to the cover letter, as we should not talk in
> the commit message about changes since a previous version of the
> commit.
>
>> - Updated documentation with proper line wrapping, consistent terminology using
>>    "old default behavior", performance context, and reorganized examples for clarity
> This also sounds like a change compared to the previous version of the patch.
>
>> - Eliminates individual ref updates (refs_update_ref calls) that perform
>>    poorly with reftable backend
> This also sounds like a change compared to the previous version of the patch.
>
>> - Uses only batched ref transactions for optimal performance across all
>>    ref backends
> I think you can remove "only" in the sentence as in the
> --output-commands case no transaction is used.
>
>> - Avoids naming collision with git rebase --update-refs by using distinct
>>    option names
> This also sounds like a change compared to the previous version of the patch.
>
>> - Defaults to atomic behavior while preserving pipeline compatibility
> This has been discussed above. It doesn't look like an implementation
> detail to me.
>
>> The result is a command that works better for its primary use case (server-side
>> operations) while maintaining full backward compatibility for existing workflows.
>>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Adding "Helped-by: ..." trailers for at least Elijah and Patrick would be nice.
