Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE3202C26
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514685; cv=none; b=SpLdMwwBhmxYPSX3nhEyQ5JFWD4zWAaNscMAYBHpiutmdQw1VfAOT9JdLloIGI5lzMrkR9aTs7rkUTzmkkdwk+LqUKtplusbW4NCWgLAkyTjVu8jPnnuZ6XoqDa4e9A07eFS0r9aZT/VQFY10U1574BlCToJjWyqzk4roQ0Am5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514685; c=relaxed/simple;
	bh=o0fLVDnt5RHt5Iu/X80QqlgWRKwv535c6oD2n6477AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evsjv/9xM0iB5uSpzkGY6xoicIRYUgWxHTEhG3y7vbYlJes4iksxTXasOdo8c9FfeYs5lg6N4eWEMMFom0jQhagLZfCG3mm+TF3aaY80wD4vtaqIlleW0gLiOiYYeVYfVmLfld/DTCIVPM2m17sAlzA3CstHYeQEAmAClCNtuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky8zgLBw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky8zgLBw"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499c5d9691so5923016e87.2
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743514682; x=1744119482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NB7KvrRwjS6pp2c5b8r2U/Y+D9ibSWQKABj+/Y+zy5A=;
        b=ky8zgLBwOGgm6OBDj3votJ/6JP6wn9Ak9HkL3TP8JSOVBNYKsqQp6s9SqqsnouXPq3
         DHd+QINEn4W1UAv0/M7aOuwjclGT7R87WO52SsaGVlTnZ02n0Qt63HfsM8EVKfLpsz8z
         f+FM+e/pLmezu7pkcZq0rHSNd2haGZfUCPW9WW3SxTUOX+2gj65UEMe23aB3NIwz5RF+
         4/Emn46TV7MOwhdRdjtQP/Tx2EwcrGMaraWkpd8tEc1Km+pBVpF+s3PXKxDy60vtcEv8
         ZBbRd61B6YJrAs5Idyqp4qpKa0wh0TxtellkxLxqki57y9t6JufeQEc47zMNMB0nKgOQ
         1tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514682; x=1744119482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB7KvrRwjS6pp2c5b8r2U/Y+D9ibSWQKABj+/Y+zy5A=;
        b=OP/k3Zr7KmDeEUTFdw9CFDR6UJXdKkE7lQrhwQXgyb50EeJQ060i5orXq8wZKB9qA6
         vCsmOgyuD6N366LaTHeuTSUtY8ycDqIjTPcSWIsLYHuV7xMladV63lm2+TJ7r0vvvj0/
         UALLqkev63j7zD1jWo65w/P14VxQKzlXdNt0P2z1fEGdOIXV8kBV5uEkfivnyEWOuT4D
         0Kay2yM5fZHkcO4zcP67L/FvXQVyMY/iTKFZ8VyTwVOHieXXPidUPCBCL+mSlSORbDUs
         ZN+2x3Aa8fIQIFV/YNOn350zmHW2OqCXm2lu1m8wTmiibp46qZ7ii29F9bxAOV6i/GUb
         Ao8Q==
X-Gm-Message-State: AOJu0YzwCSWq8iK6Ij9Gu/D54FPZtwS3nkAACzWtZelWRyiFn+VSaLOx
	KSXT768C7Z11WuFt3tPEVwiInNSlS1ht32rgeSvq+eU8m5BbeIZ/Qw1bQXxQ/yiLmRN5557DRDo
	CxAIQb+gh3fSV06NoLg3M1uGGH/xJRVq2anWIGA==
X-Gm-Gg: ASbGncvkOF0R7KsTzJnbr9H0UdscVo/FaA+KDJxnqvGySNQCQBDjUQNh9CtTwFzqy4m
	4q3BZZaV9JVP3YTxrwP3+bn94f8Lg9Eh6DQzqOwFP4JjgdWb4uFNPxu8AtkoFqy95jcmjb2/g2/
	1R6IX+GNbNifjoMT3yIgYdr0b8skIVSDN/NRMqVM1vf86Jqszn5IDmKktlwWA9
X-Google-Smtp-Source: AGHT+IHuC819lppO2lBhFhfnHJ9HyPxRuInadFtqb3XlJqBNA8fnWas6OfX45Dadyi+7xm9ECVV4Hq/cpza15mabnZY=
X-Received: by 2002:a05:6512:1389:b0:549:5850:f275 with SMTP id
 2adb3069b0e04-54b111308abmr4257873e87.50.1743514681565; Tue, 01 Apr 2025
 06:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
 <20250329150248.2274482-1-05ZYT30@gmail.com> <Z-pjjQhtCjLvghGl@pks.im>
In-Reply-To: <Z-pjjQhtCjLvghGl@pks.im>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Tue, 1 Apr 2025 21:37:50 +0800
X-Gm-Features: AQ5f1Jrd6lSQqU376Kqw_YzccinXswDXKs8WHqcTPH9aBPJiWfxnqr-4dRTbhhY
Message-ID: <CAMvj1+qdBb-6nDVzw1y60-C5+wknJVr=JM+4ZiAftob3Ynbs5Q@mail.gmail.com>
Subject: Re: [GSoC] git-refs proposal draft
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

Thanks for your feedback! Here are some adjustments based on your
suggestions:

> In any case, I don't think the naming and how exactly each of these
> commands should look and work like needs to be hashed out in this
> document. It's nice to scope out _what_ we want to achieve and propose
> how this could look like, but ultimately I think that most of the design
> should happen during the project itself.

OK! I may have misunderstood it. I will remove it.

> This one is something that is up for debate. While I do expect that most
> of the commands should remain current semantics and options, we could
> also use this as an opportunity to think whether there are any issues
> with the current design and improve upon it.

So, discussing the specific implementation of the command should also
be included in the proposal, right?

>> - git-refs exists
>>   Replaces git-show-ref --exists, providing reference existence checks
>>   with positive (<ref>) and exclusion-based (--exclude-existing)
>>   verification.
>
> I'm not quite clear what exclusion-based existence checks is. How do you
> check whether something exists when you exclude it? I don't think that
> this option is relevant in the context of `git refs exists`.

Sorry, I made a mistake. I meant to convey that the `--exclude-existing`
option should be included in `git-refs list` (replacing
`git-show-ref --exclude-existing`), which then lists refs within a certain
scope.

>> - git-refs resolve
>>   Replaces git-symbolic-ref, resolving symbolic references with added
>>   recursion depth control (--max-depth), while retaining deletion (-d)
>>   and quiet mode (-q) options.
>
> Not quite. The difference to `git refs show` is that this command always
> resolves the ref to an object. So it's rather more similar to `git
> rev-parse --verify`, except that it only ever handles references.

Thanks for pointing that out. I will correct it afterward.

>> - git-refs pack
>>   Replaces git-pack-refs, packing loose references with support for
>>   filtering (--include, --exclude) and automatic cleanup (--prune).
>
> I would probably call this `git refs optimize` or something like that.
> git-pack-refs(1) is mostly called this way because it was introduced to
> pack refs into the "packed-refs" file. But nowadays with the reftable
> backend I think that the command name is somewhat inaccurate.

Agree with it.

>> - git-refs update
>>   Replaces git-update-ref, providing transactional reference updates
>>   with batch processing (--stdin) and atomic guarantees.
>> - git-refs delete
>>   Separates the delete functionality from git-update-ref, ensuring
>>   explicit handling of reference removals with safety checks and batch
>>   operations (--stdin).
>
> It's up for debate whether we should even have something like `git refs
> delete`. As you rightfully notice `git refs update` already handles the
> usecase, so it feels like needless duplication.
>

I think maybe separate `update` and `delete` can be more direct. Separating
these commands can enhance clarity in their usage, although I'm open to
further discussion if the community prefers a unified command.

>> 1. Option Parsing: Each subcommand will reuse the argument parsing
>>    logic from legacy commands (e.g., git-pack-refs --prune).
>
> We cannot and do not want to do this for every case. As mentioned above,
> we may want to iterate on some of the subcommands to address historic
> warts. But overall I agree, we should of course aim to reduce
> duplication as far as it is sensible to do.

>
>> 2. Shared Backend Logic: Calls to common functions in refs/ (e.g.,
>>    reference traversal, locking mechanisms).
>> 3. Error Consistency: Maintain the same error codes and message
>>    formats as legacy commands.
>
> Same reasoning here, we may want to adapt some of them. The old commands
> won't go away as they are used everywhere, and that makes it more
> reasonable for us to change behaviour in their newer equivalents.
>

Got it. I will list my thoughts below.

> You don't actually have to change "git.c" to introduce new subcommands.
> We don't want `git refs-pack`, but rather `git refs pack`, which is an
> important distinction.

Sorry for my oversight. I will be more careful from now on.

>> 3. Reuse refs/files-backend.c Logic:
>>    - Ensure cmd_refs_pack calls pack_refs correctly, adjusting as
>>      necessary for new options.
>
> We shouldn't have to touch any of the backends at all. You should rather
> make sure to integrate with "refs.c", which wraps the backends and
> provides a backend-agnostic interface to refs.

Got it.

> You probably underestimate the time to review and land a specific change
> quite significantly. Landing new features in ~2 weeks is thus not quite
> realistic and you should allocate a lot more time for each of the
> specific subcommands.
>
> That of course raises the question of how to squeeze all of the
> subcommands into a single GSoC. And the answer is that you don't: it's
> perfectly fine to implement only a subset of the new proposed
> subcommands. I'd rather you spend more time thinking about how to
> improve upon the status quo for each of the subcommands and thus spend
> more time on it than trying to do everything in a hurry.
>

Thanks for your reminder! I plan to focus on implementing `git-refs list` and
`git-refs update` first. These will form the foundation of the new design, and
once stable, I will consider addressing `git-refs resolve` and additional
commands if time permits.

So, I need to update my proposal to reduce the number of subcommands so
that I can complete this project with high quality. I also need to
further discuss
the implications of these commands. By reducing the number of subcommands,
I can dedicate more time to refining each one and ensuring they integrate well
with the existing system. I will also detail the implications of each command in
my updated proposal.

Thanks!
Zheng Yuting
