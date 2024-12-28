Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73E1448F2
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735401928; cv=none; b=IJnu3p/cLxXKH6MTVgCeFDC3XqF2TgfkZs54Y/PsdLnB5itIG3RHAz+iFa0NNbiS1/xWvfpqRE/W8dH3GYVuxybm5NtOSKLtpxpdvX4Nk+mKV4v2cmH1u5UTgODtTZQc2dYigReDQ8CTTTxRA9aIbzyRadANZ8Pp2AuyBkJrOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735401928; c=relaxed/simple;
	bh=p7CRNfhRXJYKGkRm1vnym2AKD5DlpVLmuxvWa6E9Z3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVKp/+N7d1yh9hEblkWIjQwCkQ2LISh+5NOpTUonO9hRz8d8AN9jhSw2BX02N4/QRxj5ya9Rn1xMwDbKgFsjOmXMwzXG8W/RonUImepZHQhkfXHgR6ZGhLTjUL6jFQ3wEQEMd+gys00W/o69Uzz6TQP9oZ0LO3STn1M8F/L0Irk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eD1KBQtx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCFnfCXh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eD1KBQtx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCFnfCXh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 154B71380199;
	Sat, 28 Dec 2024 11:05:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 28 Dec 2024 11:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735401925; x=1735488325; bh=lhwJ3k5nyt
	6J4ZptTFkK14ut9/4a+PWLkUJSvLrNv2g=; b=eD1KBQtx6/91eKJv6QIThJIN/P
	Qkjf5sKkbXwC68PyrGBwbP57OJXEGzneoRbTbU4m5Xmw0uOhGSCOD119Zp5nluzv
	iA0SmqR7Lp0pdWoqKxk1HJTtvrxhUWSeWvTcppdLEu7cYrTw2w/AJa+CvKoMb+lo
	Q66JROc/iKaUcGZDkdzIV9VbtSB2iSu3ylR9vW5ES/1IGl5uJswAJEdF7NvbHIYc
	ZlKbSyvTtSKVGNE4u2KrHTaBMWQkH7qxVRstcWc3rtUX6MZwjTHhQFTegCptiVES
	Tu9cJehiPNdoHuEnWd6gwH5PIZwgjGevOc2PTEJU2o+svKsANLAScaaiFMew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735401925; x=1735488325; bh=lhwJ3k5nyt6J4ZptTFkK14ut9/4a+PWLkUJ
	SvLrNv2g=; b=NCFnfCXhyrkzHWzHXs9Rvs7WD74Gpl+3D9sRIJ58m5olyU1xCRO
	qkToVvM4mVc4bm0iroGJs4HFg91CqEQegol13sOdBTQosA63TZpjzc8Cnr1UJMf4
	ta7enAC48ue6/1SJqsnbrWr7vbV9ZbYGVazBxZC7ufxYNRTsKzfUJNvQm7a6e/4v
	fO3f9RY+dZkiOj5ZOQaiWbB93KMDolYBGZX5I+f+bbfp0OQGBSNfflD8cneWTyVb
	oNKfs6qnmIuQrQIib5uQdG335qNDNEX+UqE2KuPExDnVp+n2zYIqsWYWl9rIiXiJ
	9KhZclJRqXuUpW52RSQYh/eEEp6Vge+rp+A==
X-ME-Sender: <xms:xCFwZ7qZX2F_536O0uBvMTy_SrbP94Rvs8CYCwu4BvU-pvzFTBr3DA>
    <xme:xCFwZ1qsP6Ws3vp1RTCL7DHyaL-ed6mImgBSgCgiBuJwg-bEqSudEdbC0d9UlZHTr
    T_VGUH2ROsWWNk1uQ>
X-ME-Received: <xmr:xCFwZ4OWTXfqpEPYJsrXUeHVsy45DBL9BVdowTMhD4YJHejyhjThLWgCrip-IPuWZwnd9HXFSBp2ngOgd2p8dm7Y6epxg_DVow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgshhgrmhdrkh
    grnhhoughirgdutdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xCFwZ-4z6iB70puVMXUgQyQVSocvuZ010-nccLdR_1JSqYNSjHwDMg>
    <xmx:xCFwZ660C-7i3SMQlwlaUXG2Tp3BSxy9pWICMo4Rvo-mWNxqszPM1A>
    <xmx:xCFwZ2jentQu8VbFhnAFlvxfjH7gHQedngoIaaQ9yjSkKLPqDc9fOg>
    <xmx:xCFwZ86z8-0Fzm1CGwyv6HlBdcrauzojYv9i9wTK8jY35tpC5I1xgA>
    <xmx:xSFwZ8TBrPy-72AWITaNxsf-Ar8h8GE2jc2CU2-0JD73PfWVjOnOUonS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 11:05:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] maintenance: add prune-remote-refs task
In-Reply-To: <CAG=Um+0a+ugf+gWUDS3htj3u2tewzOrH+xGbF+2A+w4ofjQfKg@mail.gmail.com>
	(Shubham Kanodia's message of "Sat, 28 Dec 2024 15:28:39 +0530")
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
	<xmqqed1tv6hu.fsf@gitster.g>
	<CAG=Um+0a+ugf+gWUDS3htj3u2tewzOrH+xGbF+2A+w4ofjQfKg@mail.gmail.com>
Date: Sat, 28 Dec 2024 08:05:22 -0800
Message-ID: <xmqqr05r4wu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

>> Hmph, is there a reason why you need two loops, instead of
>> for-each-remote calling a function that does the run_command()
>> thing?
>
> It can be collapsed into one.

Sorry, but that is not an answer, as my question was not a
suggestion to change anything.

It was a question asking you if there was a specific reason why the
code was structured the way it was written.  If there is another way
to write it, you need to answer why the alternative wasn't picked.

>> This loop does not stop at the first error, but returns a non-zero
>> error after noticing even a single remote fail to run prune, which
>> sounds like a seneible design.  Would an error percolate up the same
>> way when two different tasks run and one of them fails in the
>> control folow in "git maintenance"?  Just want to see if we are
>> being consistent with the surrounding code.
>
> Fair point. I'll make the process flow identical to the prefetch refs
> task that works similarly across remotes.
> It returns as soon as the first remote fails (without necessarily
> affecting other tasks).

... and the first failure signals the caller a failure?  That would
match what you did in your new feature, which is perfect.

Thanks.
