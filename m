Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D035CBC5
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763255174; cv=none; b=rt6zDuB/lGknnFCHsxwfBcORSxjeGoNDoSIQst2OlYxEJej1nFVVbAJVxi7G3LGELiEHgHOMwQoDrE0cI+JOZinjkNfkXHLCXu/AIQeLxRZ3AoQiLFySbjSFT5wsLqa4NlqMecJYcZfFOmwHTSbMZqrozJxBEr439YzLJEmSqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763255174; c=relaxed/simple;
	bh=XXHHAjBT406a/xOj1ZDCvnJqQP5D/zvdWLN08JV68ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/eGXx7y2xALZCxqpGi56hnmDmuVbfJzQ7dDECTpY8VXERugOVVM3rskfUglmjCdsTWmaHF2feIk6bLXsx/H1WolGsiYcVkO+E7/SOhOc/hzazSwC+phsvIMjdvVOtaN/EmcQaSamu87bpvylHcEyDx+fLfr3gFhk8+guMpvvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SD3npY69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcruwdRS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SD3npY69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcruwdRS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90D63140009B;
	Sat, 15 Nov 2025 20:06:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 15 Nov 2025 20:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763255169; x=1763341569; bh=X0BglM3wlN
	MNPmzr4imsXN/rp9n6vg8ia952rRNzKu0=; b=SD3npY69qVIO0SFKQjBnXcS60m
	DVifLsAlw5M+mP8bzidT+82dgu0ioi2P+LKwfwuT/lWm86HKFFnwoC20bbEfR4sg
	WS/lW+9UVRnsFiYWlOxs+IK8VwfQlEZD1YRhCNvwZc47AvgRLTXr6iM73Xp1gwAb
	sqyDcshexjUcZeX5mOpfFwoRcoAjTdrkJCxjH5XD05MiMzQsTe7/+KFJ6U4ezM7g
	zqB7Sl5d6+v9jUXmjOirFEfUsmgSL3PJpqMpv5SvB6qyE0IEwKAQFBLohTSb1b2K
	khkJrl75WkY2gTxPrPvZxpG4WZyZZI/3F2VYMiIV18rxO9BIMnakb1BppxPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763255169; x=1763341569; bh=X0BglM3wlNMNPmzr4imsXN/rp9n6vg8ia95
	2rRNzKu0=; b=CcruwdRSPKSJ90R+noL50OlyHnR+AU3WLgjXmRqeNz6eIgMNHcp
	6DcHo4yp7aCu07DFOgJQAjoDM888rgsb0+YLVb8q5U7z8SOHKo8Plsa+wucGg00Z
	ZG8O789g7kSMxtDLOjcG0GQBfrSa2ehE8t5WlH8KHq/TbIxNt6HnREKSbMs0ztzo
	gXUlxFDsoV8rH5SlA4eg/0JLRzUD4RLVMZY0XiPAMYJzC0dotvPGaVd4OaJXXLHr
	hzJ+xXs/NqwKStxFlx9Zp2om92UQ1XsdDJxyGMQEqY2z8diEULuEhW9wLh0szT+A
	P6fvmkh7iMGLDeRP3fQTR8jt9zdxf4iwF+g==
X-ME-Sender: <xms:gCMZac08M5x2Z2hhO6E_yEIfNHGsz0gRZ3q0pnI4yUIPl9PmZ7y2mQ>
    <xme:gCMZaQaBWkFVWicoGJmRUO8ls8jHvv2-yWDIjMAhJfQXLITZJRknmDHj27rekcEXV
    JvgVk8-2yIOj6l1DZc_J5XT8U_D9fozDz-p8Ld1d6uG1Mfn-BOOGA>
X-ME-Received: <xmr:gCMZacIicq-K9_z1xD6VCJJK4eOof_lfOvt1OkIkeym6oNu9IuBZ6pnZyJ2jcXjkQx66qWAih429lZ0XaDE4QOkLcvjkpp6MDZTq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gCMZaXE32xT7p_y6eGmntXfwwEcATKNPSkrT_P_JQvN4NbhnLi6Mmw>
    <xmx:gCMZabuXWv0_6w0DaPxDwUbfS-_xdrThS7z9TRyR0StCX3Nq2VpYhA>
    <xmx:gCMZaeugFk2OhGmMjecjVC3aQJaAm91DMD9-ltSHcSGBT_9N4NsvHQ>
    <xmx:gCMZaRCCHTUyfPXYrdbSylDMT3soe7NMQm4x0GrZQlWKv0uUe6ruJQ>
    <xmx:gSMZabjraKgXTgCG2KajR_jtfqLKju9T7iMY3tSNvlu2w66p765QiijW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 20:06:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: ZheNing Hu <adlternative@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  ZheNing Hu via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: add --committer option
In-Reply-To: <CAOLTT8RSN-72gVXDS-zrr=7wW4HU=CL6acyDx_UXnvo4c5MaRA@mail.gmail.com>
	(ZheNing Hu's message of "Sat, 15 Nov 2025 13:29:18 +0800")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
	<CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
	<7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
	<CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
	<xmqqqzu3qi43.fsf@gitster.g>
	<CAOLTT8RSN-72gVXDS-zrr=7wW4HU=CL6acyDx_UXnvo4c5MaRA@mail.gmail.com>
Date: Sat, 15 Nov 2025 17:06:07 -0800
Message-ID: <xmqqfraeeqgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ZheNing Hu <adlternative@gmail.com> writes:

>> Isn't it more like "You need to run with --author to correct the
>> authorship by amending the commit *anyway*, but while doing so, the
>> committer information will automatically be corrected"?  As I said
>> earlier in a separate message, the author and the committer are not
>> symmetric, so having "--author" does make sense in the above picture,
>> while "--committer", as Phillip points out, much less.
>>
>
> Well, I admit that perhaps the design philosophy of author/committer is
> inconsistent (which has caused too much trouble), but for users, a consistent
> parameter interface is easier to understand and use.

I do not think it is about design philosophy at all, though.

The distinction comes from the difference between what "author" and
"committer" fields record.  The committer records the identity of
the person who was at the keyboard when the commit object was
created.  The author records the identity of the person who wrote
the change that the committer is turning into a commit.  There is no
symmetry between them, hence there is no inconsistency here.

And it also comes from the actual human user behaviour.

Many authors can pass their patches to a smaller number of
committers who make them into part of the official project history,
so when a commit is made, there is much stronger need to tweak who
the author is for the commit than to tweak who the committer is.  On
the other hand, it is rare (if ever done) for multiple committers to
share a single shell terminal session and take turns to make commit,
where you would need to be able to say "this invocations of 'git
commit' command is done by person X, who is different from the one
who made the previous commit in this same shell session".

