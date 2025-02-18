Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225B26BD8E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904027; cv=none; b=dr2JY829D+2ohWG5sDvkJVUb7ohkyvcEG3RvlidgdGJNIXnEgKWkc2khGjg0hsAjQSy2O83S0QPyeTkhmVTYsld+E0VVD4gjicN57bni87FYOy88JOBbLwKCdayRVYSDa8whd6R/J7eC9C2tzeweWcKtv6KbpP1QYCN12vlUsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904027; c=relaxed/simple;
	bh=98hOyGXKb5mrTa5GPq7q9k2LetVWg1pKfObEP5c+NmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KDTYSttAcfGwGmRg4Q2Hj6u3r8LZ9AbeTfywn6oX6rAoJIXtSpO4Hh4dypJNRIa/ATONeOmssAHIrT2zgJKRUDGpLK6UDgIQGyXDMQOls1TFBDdnZse2IZNAHT1ZZYMt8P37kJHJQjwFm1HP0FQFxUD1dYvlFE0PfzvMbOMQfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jndeW8oh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+lOTyl1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jndeW8oh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+lOTyl1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A5F711401DB;
	Tue, 18 Feb 2025 13:40:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 13:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739904024; x=1739990424; bh=tFbVyGk5Ik
	RdvZR1OIzREzhLWhVFLzbHGdeTiStgSfc=; b=jndeW8ohHMJncAPVh51fG6F9Eu
	ZdaYtFyQUJelcds2PFMiN5f7U+Yr2Z0/PPNonqMEqLvyoijdm9Dv8GfcRf7eMphZ
	t0h7VFQZmYeC+V0lGjLNknmvxduFAl3RJJJ6lGed5+o3YeJVaKWEpqLWaGNAW9Oe
	4J06aJckT/PAJYXJCGZqDl+wXpkzZiFy1dQxBU/FPn0qyNnVcpHEgjzslRzgHs8n
	rH3SfseWMZHNivSkduzVCyjvE91Qh9biqahpQ2cWbNNV2SOxzJ55Th2kki5PESkt
	sCQ4QU6JPjrD3GpsTxtLyZ+cGcQoBHn5LQsAy8rEQTeYkbmzBdp2Ytqmn/7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739904024; x=1739990424; bh=tFbVyGk5IkRdvZR1OIzREzhLWhVFLzbHGde
	TiStgSfc=; b=G+lOTyl1s2XCuXRc2FPBaF8VYfsXC1ii09bJTtUabwghm1m+Z4F
	S1lmTgCWSg8PTYJV7un/JDXM6LoEMoiWBnRjg28vVj1J8KycbFbPnKlPJN+E+dpa
	nSCbahIULxqdLNlxuHJ1k4KIn9zLwFutKeYqGK9BBKSVvxR9m0zwhKGakhR5ALT7
	ohyQMopjN8J0E+SMutSdxUpX7aLDyOUVqr08OLBHg3M6iTqc0BuDDxQKuene/LCk
	7MnS+See/dOmzIZSedRycgS4ETT1zPql4E5AL2fTJk/i871pjoHw5Wrcf59YcyYZ
	17qDhnEDfoWr45usVOTg4M7BV1vx/daPfbw==
X-ME-Sender: <xms:F9S0Z9p3uEsy-Xp7GK_ZeUEQZO9SlVVxM5KFvLpCrsV4KZ8R76kQuw>
    <xme:F9S0Z_r_JsoarU9BvQpIPvxjYSwzI9j_pz-0xJKhRWtJi6Ls35iou9I4q4VdMI-8z
    MIjLenkC-0HbGB0Jw>
X-ME-Received: <xmr:F9S0Z6PxbdqVnuc3s_rmwMy15mv9z1flFh-MxiwbLGrHWWyfuAvL9eoHqt5e8ll0DapBVW7hbH74Qahtt_Sek-8T356rwMaBA0qgs2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeejkeeujeegteevjeetgeeileeujeeijeef
    ueegieetiedtleffvdffheeihedufeenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghlvhhinhifrghnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F9S0Z47ADynVbTjTaXhrstFLJBfdAU28XPwrapyOIzql1Jt3XxvtiQ>
    <xmx:F9S0Z85U4IWqNNlWjiE9lre_9wZvqudu7mesye5rxiwpA0zyw-xfyw>
    <xmx:F9S0ZwjMg99z5TariSDYDU16Ukvn6Fs0yFN9wRYUJLZUNJdHylJnkQ>
    <xmx:F9S0Z-6gag5m6jVLJDsStKij6RM0MHBatcI5SkFHH__polv0pfF79w>
    <xmx:GNS0Z-uIWCdoJAmdg1VsKXzBlRfQsZWOgLl_F6xeuGqtjLnXSNlq8PAJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 13:40:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Calvin Wan
 <calvinwan@google.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
In-Reply-To: <20250217055049.9217-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Mon, 17 Feb 2025 11:20:49 +0530")
References: <20250217055049.9217-1-meetsoni3017@gmail.com>
Date: Tue, 18 Feb 2025 10:40:21 -0800
Message-ID: <xmqqseobksfe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Replace direct accesses to commit->object.flags with the commit-slab
> mechanism. Introduce `get_commit_flags()` and `set_commit_flags()` to
> retrieve and update flags, respectively, and include `revision.h` so that
> the canonical UNINTERESTING definition is used.
>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>

Ohhhh.  I thought people somehow have "refactored" the commit
traversal code here to share more with the machinery used by the
"log" family of commands, but the change in this patch being
contained within the single "show-branch" file indicates that it is
not the case, which is good ;-)

And the MAX_REVS limitation has been with us from the very beginning
of the "show-branch" command.  Lifting it is very good ;-) ;-).

> ---
> I'm not entirely sure what the TODO comment meant by storing a pointer to
> the "ref name" directly, so I've assumed that the intent was to store
> flags (of type int) directly in the commit-slab instead of commit->object.

It has been forever since I looked at the code around here the last
time, but I suspect that it meant the final mapping the code makes
at the output phase from the bit position in the flags bits to which
reference the bit (i.e. "I am reachable from that ref") could be
omitted if we make the slab entry a set of (interned) refnames.

But I think using a slab whose element is still a bag of bits that
is wider than object.flags word is is the most straight-forward way
to lift MAX_REVS limitation.  If we can leave everything else
unchanged, that would be great.

> I've tested these changes using:
>  - test suite -- they passed.
>  - github ci result -- https://github.com/inosmeet/git/actions/runs/13355488433

New tests that traverse from more than historical MAX_REVS would be
the most interesting.

It is not exactly surprising if the existing tests do not exercise
such a case (even though it probably should have been checking that
the command refused to accept more than MAX_REVS refs to prevent it
from producing garbage results).

If there were such a test to illustrate what happens when too many
refs are given, we can demonstrate how the behaviour changes, for
the better, with this change ;-)

However ...

> +static int get_commit_flags(struct commit *commit)
> +{
> +	int *result = commit_flags_peek(&commit_flags, commit);
> +	return result ? *result : 0;
> +}
> +
> +static void set_commit_flags(struct commit *commit, int flags)
> +{
> +	*commit_flags_at(&commit_flags, commit) = flags;
> +}

... it does not make much sense to use the slab mechanism if we are
still limited to bitsizeof(type(flags)).  If your "int" is 32 bit,
and the command line fed 100 revs, we'd want a flags parameter that
can house at least 100 bits passed into the "set" function, and
yields the result that can hold at least 100 bits from the "get"
function.  I'd expect that the interface would be more like

    static int get_commit_flags(struct commit *commit, unsigned flags[]);
    static int set_commit_flags(struct commit *commit, unsigned flags[]);

with a file-scope static variable signaling how many bits we are
dealing with (allowing these functions to infer how many words
flags[] array has), and the return values from these helpers to
indicate success (with 0) and failure (with a negative value).  On a
32-bit platform, you'd need at least 4 words in flags[] array to
deal with 100 revs.  On a 64-bit box, 2 words would be sufficient.

I would imagine that we would need two more helpers

    static int set_flag_bit(unsigned flags[], unsigned n);
    static int get_flag_bit(unsigned flags[], unsigned n);

to query the n-th bit in a set of bits stored in flags[] array.

Thanks.
