Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DB28F5
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856576; cv=none; b=eoEp+Ow2tlpXu7sY5N+NS4czhzBOoxrixrhgfRfmdcBy25BJFYuqsIwQ24DIiadqLl77vZlPMehNHbHZ++ODOEZXZdnp+shWAMaoucreHpxziQYzjvRUfNsve7+u2c0HYB2x60+rQWyE7Y1/W7WwAWgwI8sWCrMLWHqM4H3Z81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856576; c=relaxed/simple;
	bh=1oF2gVl298yShlgcBaK9iTceluzAqEEZspNqSewMTbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qmj5OoiWSIhnsStsFyMrvMObDXHUOUVGfSVrHFnqOwp1VEAeXQXGs5LViTa8BNXyXVZCmMlQRe77tK9Fpdy6HaGOGdC3lMJIKSmVzJq9IxNIFvCQI0Gz0Ti4ef/M0e0KfmURlyfli941lbyUzw1obJvKysNbmlBZxtM9nc+xzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EScB44sD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNwbGdrB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EScB44sD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNwbGdrB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 20A401D00192;
	Tue,  7 Oct 2025 13:02:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 13:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759856572; x=1759942972; bh=CfUweJX7Gc
	TaL5WqXXApUcIlnKyaVBzZ/R00/tHUXT4=; b=EScB44sDdY4xLC89GTOdfkiMY4
	CD0qr2+w1pJpJVrrWRwMWBHMFp+WqfUNEbZEQt/ka79iIoKXiTPYH1C97io626Aj
	dcSbE+wsVyg8blILh1U4LI+FktKnZOMhyga+61X3QOdJb662MIUbcy+6SIEwSzsm
	XMh9t2zuXN/dwaJ2V6EIytvmqoq45ZkbHxxXEwaBqYpTP4tKjbfgkS/R1/DqzjpP
	k5te4Dccayy4QK7pfdWDIIk7GL9JCr6d1qVL1Z24+PtB/U3ReEeL/cniAz7WTxYz
	XH1xwaH49nngW0PZRlK72GnOR0FjvXIu81Qy6e7oq90cjRS8GBrrQvvQis/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759856572; x=1759942972; bh=CfUweJX7GcTaL5WqXXApUcIlnKyaVBzZ/R0
	0/tHUXT4=; b=QNwbGdrBm3+8U8pF8apXzxsQQ9w0TgbHiJdxkQd/d3khJVz2dgx
	VDZMzPZbRQb+ckmG9hve0CM3T2SohauzmQbBHoth+dsKPXkdwT1VXOrXcm6XWKXu
	Bkql91PZQuNAXlL1g82oJtAO6xxQFh9qmNTJPQSG9Bcn9AB166IcJnbPStnk/sAr
	RChgZEpS1YTYuwAxdqT25QKX+GR76WkQjv6oin23g4/wNTdAJLE2cCzFoIdG9x0c
	b2XuPA2Wk7wBgliH139eVrvmCEzBlKa84MFzQO2DXbP0GT6O9fddIrNtpcmpvWOw
	ui1SbEOsutizWmM3kJiCPk2cQaLdR+i8tZg==
X-ME-Sender: <xms:vEflaHGfeLGwyIOzA2cG0J4-BjZHMfAOSj-8sCEhmTZTgU_lrMOsmQ>
    <xme:vEflaLNP9AR8TyMQFGLgykxiX37nvD9A9K7A8CyB3j6q8tag7Y_mR2-Pcy5PftXCg
    Keth3fZjIsN2xuVID5DF7E4EwnneV7i4UgX8iJlJx5fQjOxjKpB>
X-ME-Received: <xmr:vEflaBdUt_Hj8NOTb_1z5fY_sNZfxCVCQ2U0LbShshOmbD4W4lpi5BWWdi1FCom6GTwxuhXAIahgnEFLEA9YBxQnzOijy-6yQsRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfkgffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetleevffeggfelveeujeeiiefgiefhveelgeefudelkeettedvleffudeg
    ffdtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vEflaAuicJ04Z6LHuAQHeAFUj0natgAQLI38FheQxWCtTkIgCHiCow>
    <xmx:vEflaKmdxFuTnLvx-w1H3L9irmXaj2Fd94EdmA3eY4rW7QWdTVZj6A>
    <xmx:vEflaKxQJaLfsg5rbvEttW8Mc962oIhXcX0aGv6T0eFH9QPam2s-hw>
    <xmx:vEflaEMpJ21ZBG7js3jCRaov3dsniah9V-aR2_89Z_nlzj18F-u46g>
    <xmx:vEflaP_f_i9ZA8cZUB-e7to072-O8V95BuXkkxm7qWmDIeWJJzuADzVK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:02:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
In-Reply-To: <aOUkZa4_fq1hho7Q@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Oct 2025 16:32:05 +0200")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
	<aOUkZa4_fq1hho7Q@pks.im>
Importance: high
Date: Tue, 07 Oct 2025 10:02:51 -0700
Message-ID: <xmqq4isalk5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +Git's core operations use 4 kinds of data:
>> +
>> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
>> +2. <<references,References>>: branches, tags,
>> +   remote-tracking branches, etc
>> +3. <<index,The index>>, also known as the staging area
>> +4. <<reflogs,Reflogs>>
>
> This list makes sense to me. There's of course more data structures in
> Git, but all the other data structures shouldn't really matter to users
> at all as they are mostly caches or internal details of the on-disk
> format.
>
> There's potentially one exception though, namely the Git configuration.
> I'd claim that Git "uses" the Git configuration similarly to how it uses
> the others, but I get why it's not explicitly mentioned here.

The core operations do not use Git configuration any more than they
use what is specified by the command line arguments.

>> +[[objects]]
>> +OBJECTS
>> +-------
>> +
>> +Commits, trees, blobs, and tag objects are all stored in Git's object database.
>> +Every object has:
>> +
>> +1. an *ID*, which is the SHA-1 hash of its contents.
>
> I think this needs to be adapted to not single out SHA-1 as the only
> hashing algorithm. We already support SHA-256, so we should definitely
> say that the algorithm can be swapped. Maybe something like:

Good point.  Also officially they are called "object name".

>   An *object ID*, which is the cryptographic hash of its contents. By
>   default, Git uses SHA-1 as object hash, but alternative hashes like
>   SHA-256 are supported.

I'd avoid "object name is the result of hashing X" which historically
was a source of question: "why does 'sha1sum README.md' give different
hash from 'git add README.md && git ls-files -s README.md'?"

It is an irrelevant implementation detail (and you'd eventually end
up having to say "X is <type> SP <length> NUL <contents>").

    An object name, which is derived cryptographically from its
    type, size and contents.  All versions of Git can use SHA-1 hash
    function, but more recent versions of Git can also use SHA-256
    hash function.

>> +commits::
>> +    A commit contains:
>> ++
>> +1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
>> +  regular commits have 1 parent, merge commits have 2+ parents
>
> I'd say "at least two parents" instead of "2+ parents".

Yup, that reads much better.

>> +tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
>> +parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
>> +author Maya <maya@example.com> 1759173425 -0400
>> +committer Maya <maya@example.com> 1759173425 -0400
>> +
>> +Add README
>> +----
>
> In practice, commits can have other headers that are ignored by Git. But
> that's certainly not part of Git's core data model, so I don't think we
> should mention that here.

Third-party software can add truly garbage ones that do not have any
meaning, and Git tolerates by ignoring them.  But there are others
that Git does pay attention to, like encoding, gpgsig, etc., which
may worth mention (in the form that "these four are what you typically
see, but there may be others" without even naming any).


