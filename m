Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7B21CC64
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764485369; cv=none; b=IjBFWP8+zfORhJA+AIaxvpM+okDQbz3GckxpSqrnFFiwuLUp/f8l6pQvHpNNV7aSTQQEAWyQ6hVBTRIf7qStvkVg5eGhbp0LL7FeV6gRvF9NkGg6UdbHVlt2GNp5sFHE0uEOq6Qbn1lHFZtV95aFFon/TL7QA4FmroU/CBzVgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764485369; c=relaxed/simple;
	bh=BKrG8gPqDrb7HiPUnwTECD8qH2Daxi1kUJY44XKXZwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AAyZeZwVsl5YAc7d1pYcO7OXRjwmbFBv8kuuED2U5I7jfPOnfYShH247/pZ9L/GWFxHdJbrFwdg37kgVi1abRD4zWWtDbP+oRX33OSBFOmCKsM4PpY9Cufr6YbiCVgj3RfdeIvZT/ZIj1Nq4UnH122wvYQFuUzXGkjQ1TEiceGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JtU84DWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5549d50; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JtU84DWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5549d50"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 80AECEC05A4;
	Sun, 30 Nov 2025 01:49:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 30 Nov 2025 01:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764485366; x=1764571766; bh=s+331gNDg2
	trvAXU2og5BBckhVl30TSZ8c68zPMsor0=; b=JtU84DWP8PyP3+Z5IooN3l4rqw
	IGPtWd6YwCIJ5Rlfb+mQ5I9FrpSn+SN59UPzMsyBHJ428V2h+NnTx6FMbdhuC2RQ
	bfFP22Hwdz6Rz1hxoXaffMsHAmFr+5NU/vd4b2m5S/i+mrXbjO9rlcne9VSN32DN
	1whEWHa+ixbVDJjH7yt+j+xMPJxbKRp257jhy3/emxT7HRDVEA5rSpBAsDZum4BI
	fIRpE/DsewPAOb5yGfHNEjzHpc34QGygsa+YUV4xMBA82uxbpf7ahEZkOTk9lryZ
	0NYTNhfqGvyi7s5mlG4sXm8sN0OEFNfxegfl6SWj3nizG5RwT8CFfs7Jnpdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764485366; x=1764571766; bh=s+331gNDg2trvAXU2og5BBckhVl30TSZ8c6
	8zPMsor0=; b=p5549d50dy40bIifNU4RLg/enK96L42c2wrOb/X7ZfKnC8meAYD
	/QocbKjU63KmmiM+yLE7aNBk3eXSuDhFpesoHD6X4hELJqlW40KkwjksFxDrB3+5
	y3I8P0Rm6hJx//2TrOy2R0LXJl+NhHLknvBYFt/pyYKnhdY9e/mqyZSbGjv7aFTm
	4PsZRDl9CeQx+9Px3Q/IrkD4DBbKZl5le2E/Z0cMi2ky1ee07eWN2+E+esGXn1HS
	0sXsNS9pinhAbIaVI5euZPFeSTthMDy7SVwwSgv4Dzs2TAVBmLxALMjyz/yR/O4E
	iozabwnSvCzwreOKC0+Fy8b8I9CoqIfsIPA==
X-ME-Sender: <xms:9ugraQ2kd8uCtFbr14PJobk6_UJ8rYc27pAXD6ECHH94o1Enmd8n1w>
    <xme:9ugraVqVOg-kyIkEWvHE1AxJXCBq8ikl3tpsImDTRKyqbaR78Y2mXbrkqRj-VSQQd
    GkzbBZ9i5MJG47V_T1vJ1sNz0iXMP5pAW-N9tHghKsW8NX6CM-p3AI>
X-ME-Received: <xmr:9ugraVeBOLIwaQEFIVr41EXbybyKAnXGWziJMgvWSXHeGNsIuz4PUr5YSZSXK_anZEY1062ZHXSbvDywI-uVnSxHLsASITNl4qFx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9ugracpxuAFk36iY7UAwSArTDDeSyJLZLcZLqYAfrx7VOM6qB7zIpA>
    <xmx:9ugraeE8ktIq_6Tvj-z6ugP0O8qW06cVr8Egfv-r5YNaYK9J7kVuwA>
    <xmx:9ugraUslTdA4qaSl_VqufNeco9XF7lyUSIV4XEDgc0hW3ZsEWQXQyw>
    <xmx:9ugraYUpq4Zjywv7lY2ymvZyAXpjaEzlCrqO_2R4WRtFeo0D0v9xNQ>
    <xmx:9ugraYzjcOfZz_t8ivVjX3AT66Dfb3whVHmm1so5WzznvNn6Z3e2pyCY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 01:49:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/10] t7800: work around the MSYS path conversion on
 Windows
In-Reply-To: <f7f1e91cef81068f3572b745aebc33d1d2a26c06.1764440906.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 29 Nov 2025
	18:28:26 +0000")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<f7f1e91cef81068f3572b745aebc33d1d2a26c06.1764440906.git.gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 22:49:25 -0800
Message-ID: <xmqqa504c8wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Git's test suite's relies on Unix shell scripting, which is
> understandable, of course, given Git's firm roots (and indeed, ongoing
> focus) on Linux.
>
> This fact, combined with Unix shell scripting's natural
> habitat -- which is, naturally... *drumroll*... Unix --
> often has unintended side effects, where developers expect the test
> suite to run in a Unix environment, which is an incorrect assumption.

Surely, those who are primarily on Linux, or those whose background
is from other kinds of UNIX, cannot be expected to be intimately
familiar with how the POSIX shell script environment ported to
Windows platform behaves, and it is understandable if they expect,
as a port, it would behave more or less the same way as they are
accustomed to on UNIX.  Even though POSIX shell script environment
used to run our end-to-end tests are ported to Windows, however, the
scripts still need to be aware of certain things that have to be
done differently in Windows environment from how they are done in
UNIX environment.  Here what you fixed, the absolute pathname may
begin with <drive> <colon> instead of <slash>, may be one of them.

And these differences are not necessarily well known and/or
advertised to many of the developers who have written our tests on
Linux or macOS over time.  I wonder if we can do something about
that, instead of reacting to breakage retroactively while
complaining with disgust about the platform differences, which is
what we often have to see on this list.

> Let's instead rely on the much more reliable fact that
> `ls` will output the path in a line that ends in a colon, and simply
> filter out those lines by matching said colon instead.

That is clever and clean, a very well crafted solution.

Will queue.  The entire series looked quite sensibly reasoned.

Thanks.
