Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B126A0D1
	for <git@vger.kernel.org>; Mon,  5 May 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462744; cv=none; b=Ml+4e6n46RwXKsX+np7DiqI3R+UtIf1Wqk6nwZ27+wtOHevs8WjCgkWJFKTqBsCUTDvW7Sk77hKcg1m83PHQaTxRJQCmXMe/94hKFxlKifV3SI70HVQjjqcjFNrIS6J6BrxyWACXir/XVOYB9ccNo/hQNzSXEyA2REzJUcQbuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462744; c=relaxed/simple;
	bh=HX5T4mi9IBdtziRXhmAsKDCivNtYjypiFDJUwOltzro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UbaWUG8tp2/TklYzVISNITIm2k5DZClBIgoGCL/AnCSdj1dDtudEqviDMPD9H2fNrFRdnMmk1k74XQW7NO9/cDpAGcXmhxXHSsbV3xK7TAbfzJwhyfH0rjhG/e4lOl9LPvebYrr0RFJlhDV8nsmBPDVxJ6xTwTpzxWa0kE7fk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aqWYl+ip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aoqwg3H7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aqWYl+ip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aoqwg3H7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B5A3254019A;
	Mon,  5 May 2025 12:32:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 12:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746462741; x=1746549141; bh=g//IafHaYm
	WDHS0jwHw1fG9dXlcsrI2R7uPq1GJWIv8=; b=aqWYl+ipIyeZLaQNYnczyNtK8+
	8f7EL7bgJCieXLhQn+R1vDmxrbM6pr0pfUZcMtnEElIX9cm18vwFfF8Hh6Ab8XS1
	TnxoGLVOcppe6Vca+/CQFD+meX5339pNLZOj5ZWM2kAmZS7K99+LBrp8Og7jBWwu
	Sk1jyjJrHPfWl/LnMIhSUBW49mH293wTzLKdW7V2E8Yt/AnfAkjAC/xpC+xkdVqY
	IgH0J7POhVq1lbPpWZdLTrz9t8LbvnbfmlGgzzRgmRtdbS4hOiLzfkPK/5fE7EgS
	le+WfmRtBuBOn+fvsaJ9+YBjhvteA1XVBbwQorBKIyTa7nWAiK5P4ZXFE27g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746462741; x=1746549141; bh=g//IafHaYmWDHS0jwHw1fG9dXlcsrI2R7uP
	q1GJWIv8=; b=aoqwg3H7wMVKAcHcisjeCx0mJCwKxHeTOGvsFyaNWtDz65nJwHA
	z5/ybtoQvLlI0jnbjRXyQLemJAPR2iZqMo+bPC33UVuxg98nYFwbXsR8dwMOkXIU
	VNM7N1KMom4tL5Cp0N/4A1WgWIB9nG38Vw7mDI4efBeMJwfDv6SynlwCqKH02WQT
	KqBMYIs0Hu00zgesyE37FGbfv/vShckymXzBVAS7QrZaRvWTOn9IEb7XxBa7DJJW
	UzQdl0Zm5gy4e+1KgPmiZC4fdOp3QEMpq1x22OtZOAfZNixPDdRv8IQEO+382+6G
	UfxhZGEw6N82EvcQipc3ud+xbnnkV4yjAVA==
X-ME-Sender: <xms:FOgYaG39A2VThtlohRE_3Wac7S9istQ9ZWZn11ms4UQ3Vs2M1x-P3g>
    <xme:FOgYaJHx1AZ3M_W1qqHKPhTaO-UdupM8nBR8TcvuS5VhqWLQ62bfW-HS5ua4qAU74
    EvquN5kTz3N0dfaEg>
X-ME-Received: <xmr:FOgYaO54v6Dm4n9w6p3Al-vUhPXQBOjytvShaxJJTJp_bQ_MVTJwdQ2Iefsf4xZak2bRQ9r7wVoEQm0qfcuZT6q9OdNEusUCVKT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhumhgrrheslh
    griigrrhdrtghordhniidprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsghughiiihhllhgrsehlrgiirghrrdgtohdrnhiipdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FOgYaH29d5xIKMJbvoroPxy8YveoVEbYgY4eyJ5uwV9xFrUlf20p7g>
    <xmx:FOgYaJHAuYSmjctKK7vVlfo7-5YkZA7ApYVpMIyUn6GY9PYzdo-kGw>
    <xmx:FOgYaA_gqypDNLCqe4le8KZXarph07e20GIdNs91Ro38lX1ZC39PrA>
    <xmx:FOgYaOlx7ZghBltNrc2ZpA5O82Pi4ok19Evk29n2rEuFoC0imMS9Ww>
    <xmx:FegYaAgiazW5siZ6dXF-n0bBQNaIi7_07pP9XNsY2Mdzi03BDX6PAoTx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 12:32:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lazar Sumar <sumar@lazar.co.nz>
Cc: git@vger.kernel.org,  Lazar Sumar <bugzilla@lazar.co.nz>
Subject: Re: [PATCH 0/1] New remote groups subcommand
In-Reply-To: <20250503160953.196329-1-bugzilla@lazar.co.nz> (Lazar Sumar's
	message of "Sat, 3 May 2025 17:09:51 +0100")
References: <20250503160953.196329-1-bugzilla@lazar.co.nz>
Date: Mon, 05 May 2025 09:32:09 -0700
Message-ID: <xmqqecx3ow6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lazar Sumar <sumar@lazar.co.nz> writes:

> Lastly, I wanted to at least add a test for the expected behavior of
> remote grups when a remote is renamed but found the current behavior
> surprising, i.e.
>
>     $ git config --get-regexp 'remotes\.'
>     file:.git/config        remotes.group1 upstream origin
>     $ git remote rename origin fork
>     Renaming remote references: 100% (8/8), done.
>     $ git config --get-regexp 'remotes\.'
>     file:.git/config        remotes.group1 upstream origin
>
> The remote group is defined in the local config file and I would expect
> the rename to rename the group member here.

Even for a single same person, depending on the reason why the
renaming of the underlying individual remote nickname is done, I
think the expectation is different.  Perhaps they have a set of
remotes that they use for CI use (i.e., they push there to trigger
multiple CI platforms), that are named ci-alfa ci-beta etc. to make
it easier for them to identify these remotes, and grouped under "ci"
group, and they have another group they use for publishing (i.e.,
they push there and the latest history becomes available to their
developers), as "publish" group.  Suppose they decide to retire the
CI infrastructure from the ci-alfa remote and use the repository
only for publishing.  Then the config setting that may have looked
like this

	[remotes]
		ci = ci-alfa ci-beta ...
		publish = north-america europe ...

would want to become

	[remotes]
		ci = ci-beta ...
		publish = asia north-america europe ...

when they rename "ci-alfa" to "asia" because they no longer have
CI infrastructure attached to the repository to trigger, and instead
they want to use the repository to serve asian customers.

If "git remote rename ci-alfa asia" automatically rewrote the first
one to

	[remotes]
		ci = asia ci-beta ...
		publish = north-america europe ...

it would not help anybody.

Of course, if the renaming is done to fix typo in the name of a
remote, e.g., "git remote rename ci-alfa ci-alpha", it would be
useful if the rename also rewrote the config into

	[remotes]
		ci = ci-alpha ci-beta ...
		publish = north-america europe ...

but we cannot guess the intentions.  So I am not sure if always
automatically rewriting is a good idea.

Before thinking about "rename" doing random things that the user may
or may not want to see perform automatically, I think it is better
to give users a way to exactly do what they want first.  Perhaps a
session with those tools would look like this?

    $ git remote group --list
    ci
    publish
    $ git remote group --list --verbose
    ci		ci-alfa ci-beta
    publish	north-america europe
    $ git remote group --get ci
    ci-alfa
    ci-beta
    $ git remote group --set ci ci-alfa ci-beta
    $ git remote group --get ci
    ci-alpha
    ci-beta
    $ git remote group --list
    ci
    publish
    $ git remote group --rename publish pub
    $ git remote group --list
    ci
    pub

