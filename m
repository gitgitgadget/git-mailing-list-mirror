Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBC21B9F5
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548941; cv=none; b=G8WZBpiSXepRXFwVNAH8/NsTWttOXYNEB62R2ZL5QggX+HD501VDHBXjmyCvrw6v6vPQ+HnVPxjsjuhmLO3WCM5S1TSBxNm8aP3zqxVHL4DkUsIpbQN2IPRjEs+o1ChN319cSsw/4+LmIZeRSFDnooN01/UrRjGLZQEg7d7Ei0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548941; c=relaxed/simple;
	bh=bIvYaLso7sYEpjuEv7ZY5raGvjOiCZEMQI11L6iQ+Rw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hcl6kalpSuoRAOkOn5b4h5Sm2B6E/hhBnOdmQdIiC/TH9YndTCIx1pd1iGKS+qppyB8M1SNDVGcbVux+4iVsvOL09UBqS4DZ91U+GNanYA5cvD2DDFf3ijalUpmIQsoB7QLo2uZOdVT7mwvmzuvUVNFVjWEGXBKO6TcaRDxDOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=RGEG2GJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBeu7vq2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="RGEG2GJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBeu7vq2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C5DCDEC0174;
	Wed, 15 Oct 2025 13:22:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760548937;
	 x=1760635337; bh=bCg8mJv7yh9XIlK9ZkrL6uxcjf0z1+dCaChLXHReHTI=; b=
	RGEG2GJ7wWi0wT1kvxxjM0GUwsXArYz7ql6FQ54Ob+WAO18HDOpiiAF3HaFSfUYU
	t1UHgXUfsJOPWsprXrmgMLv/5PKYuylgxjkOy5nyLomAmYmXm3otBG5bcRjyZvXh
	BvUNhLV6Ogz5OgtO2F+W3q9DdOdACnxmz6vTgAUB4Uuo6SlQHI401ndjOF4HX0Vf
	w+KmOFTfpA04ePqfdR3lvSjgVng73CngsT4Vx+77uVkvIfiyPq8YZ6vhmHYSg3D0
	Da+JX5qbn6kO4gCxTIYnGg1ANe2dVm6ZySDWLhqypFlegRFj9lkjwckectn5GQ6m
	Egp3mQWdYWGWYejItuHBaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760548937; x=
	1760635337; bh=bCg8mJv7yh9XIlK9ZkrL6uxcjf0z1+dCaChLXHReHTI=; b=j
	Beu7vq2DfNf2wZuDWOqb+a31vkttOO5KQidiqeOPQEgOLZdVJ388FLWsXd4BTmLj
	r2TZp0HGnVFC2cCjcBC9MHWlloGsdWDZZZWsf3zd4+YiD1JPrPRpt0vCnkhMJS5Q
	wmLCDUIQzCaOnyZddlZ5mWDsfpO6XQwUQNpL2THqXXmvkLDqtMTZNVdFyQZZsEm3
	fC59Cr9rY3vonpvSc8n6lVfNvCJJqjWchMa8ZMasJ/FvAJKF192DTTaW3hv8yRIl
	2nmfSS4KAcKRGXNCX9NrYdbkCv1BH+3ryWsCthobGRr7wqzJXnKkwgHfiUZfX8FW
	Cm1MEXXi+FGquxPydiIxA==
X-ME-Sender: <xms:SdjvaACywpFg6OjK0u1qgAmPKG4gELCAsQbVMBic-I8qHHBerNpm0w>
    <xme:SdjvaNWdYO8810aKzlMcGZ2QWOrf13ZsS2MEZoHlaiSli9cA4XoWMcsJdLNxZfGFY
    rUwRRBkJ89YCH4YSGCLECq2bK3roxtZPZPLymKYsd1PC4VlEPrGBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SdjvaLuWIwnttHXavPEKpm3v_EokShNjcGBXRq0aOvJqlF04xK90jg>
    <xmx:SdjvaFyf5N_kaZ1mPTeZMPpXxyEAi24NtM_F2QEmAZ5IFJc386O25Q>
    <xmx:SdjvaGBRytK6FMxv_TBZGI35P-_hBMgPado9Y9SgSnvaLYXM9J-8dQ>
    <xmx:SdjvaLcE8Vi4o2L1Xf0mg89tcpyxeN3-6Xx7S9wU7v6RuZPADohJDQ>
    <xmx:SdjvaKmeSoYbEtsvpfTEtGL722sMKgnyNlc9pPgYTlGcaaYLLgTt8aoC>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67DB07800DA; Wed, 15 Oct 2025 13:22:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Wed, 15 Oct 2025 13:20:30 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <353916d3-c977-40e5-9251-1535b226cc9e@app.fastmail.com>
In-Reply-To: <xmqqsefkuqkv.fsf@gitster.g>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
 <aO8-NtJPNBAM2tVn@pks.im> <xmqqsefkuqkv.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 15, 2025, at 11:34 AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +Like all other objects, commits can never be changed after they're created.
>>> +For example, "amending" a commit with `git commit --amend` creates a new
>>> +commit with the same parent.
>>
>> Let's say "parents" instead of "parent" here so that it also works for
>> root and merge commits.
>
> I just found it amusing that parents can be 0 ;-)

Will change to parent(s).

>>> +NOTE: By default, Git references are stored as files in the `.git` directory.
>>> +For example, the branch `main` is stored in `.git/refs/heads/main`.
>>> +This means that you can't have branches named both `maya` and `maya/some-task`,
>>> +because there can't be a file and a directory with the same name.
>>
>> Hm. I think mentioning this can help, but it may also creates questions
>> when someone has a "main" branch but is unable find it in
>> ".git/refs/heads/main" because it has either been packed, or because the
>> repository uses reftables.
>
> I had the same thought.  The only thing we want to stress here is
> that the names of refs _behave_ like filesystem entities.  So how
> about saying just
>
>     Note: when you have a branch with <name>, you cannot have any
>     branch whose name begins with "<name>/".
>
> and stop at it?  It may look like an arbitrary limitation, and once
> in a distant future ref-files gets retired, it will become one (as
> there is no inherent reason why reftable backend must retain it; it
> only enforces the same limitation to ensure that the names it stores
> interoperate with another clone that uses ref-files backend).  At
> the data-model level (which is the theme of this document), it is
> just as immaterial as refnames may be case insensitive on some
> systems.
>
> Mentioning the limitation may be good, but the data model document
> is not the right place to explain where this limitation comes from
> (i.e. to be compatible with and expressible in ref-files backend).

I'm still not clear on why you think we shouldn't mention that how
references behave depends on which filesystem you're using.

Is it because the fact that how references behave depends on which FS
you're using is considered a "bug", Git is working on eventually fixing
that bug via the reftable backend, and we don't want to document
"bugs" as an expected part of the data model?

I do think it's important to tell users where the data model has "weak points"
where the abstraction leaks through to the implementation, pretending that
abstractions are stronger than they are leads to unnecessary confusion.

> We do not say "you may not be able to have 'maya' branch and 'mAYa'
> branch at the same time on some systems", either ;-).

Speaking of case-insensitive filesystems, I wonder if we should add a
short note about the rules for filenames in Git. I ran into an issue
recently where I had a filename with a colon in it, and my
collaborator (who was using Windows) could not check out the branch
because of that, and I saw another similar issue recently where one
collaborator was using a case-insensitive filesystem and the other wasn't.

My guess is that Git does not enforce any rules about filenames (?),
and it's up to the user to make sure that the filenames in the repository
will work well for everyone collaborating on the repository.

>>> +Git stores a history called a "reflog" for every branch, remote-tracking
>>
>> I think it's a bit unclear what "history" means here. Maybe:
>
> "records of updates", perhaps?

Agreed. Perhaps this instead:

Every time a branch, remote-tracking branch, or HEAD is updated, Git
updates a log called a "reflog" for that <<reference,reference>>.
