Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C424113C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945288; cv=none; b=kKXekbCofLf3aSs8qBcDF51rjAJRJdOTNJJLxfum7oRKgk4LcoEj/OFx9Ukmu3o1a0hdzb5dJjYxK8SSwijweLtEct75PXS8fjy54kSnl0yHEbjICMraMWMl7ggLwacBueemUZ3XzvBD5SSvFeYhDtwY5rs3Bow7YYnHdkEmzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945288; c=relaxed/simple;
	bh=9wGKkmXGKed2XILM3UH5RUoGQ2NGzgEL8N+dBxqc9iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S5f1H0ztE1gAHS4A06NJ178J3Hh2lGH4IfKyYUtdkBlM7fQmLW9VJXlsD+8ib4YfSIQ7xBFO5o4rbUT7/B7QPtZWon+NgG0sydOtx5Og3EQG/HJMgb1u7V2UJBUNHRwzW8Gwj1YXbr/8liNpqJXc8Kwk5/vOT0Luy1xYZOq0EzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FEN3HJAZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U32vXABw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FEN3HJAZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U32vXABw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 054C51140235;
	Tue, 29 Apr 2025 12:48:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745945284; x=1746031684; bh=f5c3QyWPl1
	U39ir4RtV5PM00zUttaMJCLVQIqYe28AY=; b=FEN3HJAZY0imOwsD/1ijRRvtCY
	B4d6H7Oo4OjP/S+rhKuoDWHkDVy+gLjir2WMCUjMHYL6WOPG4xnhTbWlG+98DRcy
	/pfiJTKuBpiqQEnw8+zy2N1FV5QbMc+7KfKm3YgDQvNDmd08DJu6jKDGphXStdcB
	fGkdfi+Tu8OoYv9zfkF+4K5to0iS8riyRy1H5rwYnJ57IZqbMQmghgefzVl9d+Qz
	/UrQ/0voip7pZxp4Hge8b230bOUo2kA/03dXIpVOuwHNTwx6GiMigckxm4inNMlW
	czEJFnUoWV9sozcEUD4c6cch0/7rd0H/ztkv4wF0j0TH0KjAbtx6Xc3TF3Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745945284; x=1746031684; bh=f5c3QyWPl1U39ir4RtV5PM00zUttaMJCLVQ
	IqYe28AY=; b=U32vXABwO1CzI+V128kEquoMEiaIGmgAPv/H3GqL7bh7EdVOMyO
	RqNTYdzI2LDiG6FwtRdugfua/xQwHXDciDXwSE7PGTFAGE56qa9wd6mixBFfb8ui
	MPRTwUseABqcKoEaX2dui4hJdMdb1vahmL5xnYNthn0ZLG7KC7mg7CBJFW78PO3+
	CMqYEFuaNsbNWOEmdwd36eHQT6hbPsoV/xobo2IgT5t4CqQXAEZ1hVz70bs1GsL5
	NWeap+HFpEb7BbrDBSfpwfUEPCZEH9IHkmS274ibyb/WVoeJdsRpjISDgBy0IXrx
	JuLrLAGCSnETxvflRNx6BNWhrshgZo4fruQ==
X-ME-Sender: <xms:wwIRaLXNKxFE1GeLx9zDrVcMmEpH7iXIxwxkIrAxqJJtScC7VRnqRg>
    <xme:wwIRaDlQSYtr4qKN7wxLR5QMIjSzkzy2qqyYaPRQTSbyVsOXuhXyUPD3-QrL8x0WA
    veamRUT2ba5heIwkw>
X-ME-Received: <xmr:wwIRaHa2NoYHCeuPZIyy3So8z9p2vPSlOzPxCV3zua6H-Mhl6CBEPY7WCmAZmJFv3vDgNPAfiSh1T3iMEnvDlL8ANgR8yuPVqe6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepgfeigfdvgfffieelkefffeejheehvddt
    keektdfhuddvhfeljeeujeevgffhtdfhnecuffhomhgrihhnpehsthgrtghkohhvvghrfh
    hlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnmhhitghhrghlrghkieesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wwIRaGUg5Rqo6xrnmUowrVd1ymAmIQK4RdhMMpVi2K3Hz2lIdC8ZUw>
    <xmx:wwIRaFlNCf7LY-W2r5tBwDBCRIJ092wTYvlky9IUOeMS8StnMkeFhQ>
    <xmx:wwIRaDeBZoLYM-uyFSUT1v2W1EPwBGDAe5892CvpojbJ3msMVlOLzg>
    <xmx:wwIRaPH_DeFrOhQLCmjHLBcFytYpF8UZwGtsHfsgRH3JCRZz7mLrOg>
    <xmx:wwIRaDTd7D0AhKLuzCItH-TiI2Bo1jhnXTVOizSBW6c0OGsGu2ln8Ojj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 12:48:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
In-Reply-To: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
	(Leon Michalak's message of "Tue, 29 Apr 2025 10:16:15 +0100")
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
Date: Tue, 29 Apr 2025 09:48:02 -0700
Message-ID: <xmqq34dq7w3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Michalak <leonmichalak6@gmail.com> writes:

> As I've grown to use and appreciate these features even more, I have
> noticed and been bothered that `git add --patch` doesn't have a (easy)
> way of configuring how many context lines you see. There is a
> stackoverflow post
> (https://stackoverflow.com/questions/6711670/git-show-more-context-when-using-git-add-i-or-git-add-e)
> which mentions you can do `GIT_DIFF_OPTS=-u<number> git add -p` which
> does work however isn't very user friendly or convenient.

If it is only to specify how many context lines to ask for the diff
machinery when preparing the initial patch that is presented in the
"add -p" UI, it should be fairly easy.

I would expect that development of such a feature would progress
roughly in the following order.

 - Define "struct add_p_opt {}" that has one "unsigned int" member,
   which is the unified context length, probably in add-interactive.h;

 - Teach add-interactive.c:run_add_p() to take an extra parameter of
   type "struct add_p_opt *opt";

 - Teach builtin/add.c to take -U<n> argument, make sure to make it
   an error when '-p' or '-i' is not given and -U<n> is.  Pass it in
   that new parameter when calling run_add_p() you modified above.

 - Do the same for builtin/{checkout,reset,stash}.c where they also
   call run_add_p().

 - Add a new command (sits next to "add untracked", "patch", "diff",
   etc.) to set -U<n> in add-interactive.c:run_add_i(), so that the
   default context length of 3 can be overridden before choosing
   "patch" or "diff" commands in "git add -i".

Because we generate diff once, and then let the end-user dice and
slice freely, without keeping track of the correspondence between
what the original diff looked like and the current diff that is a
result of end-user dicing and slicing, I think extending the context
length on demand (i.e. "I started an 'add -p' session, chose a few
hunks, edited a handful hunks, and then realized that this single
hunk I want to see a bit more context") is _significantly_ harder.
The current code structure is simply not designed for it.

It would take a significant rewrite to allow you to say "OK, let me
regenerate the diff with wider context (this is the easy part) and
find the hunk with larger context that corresponds with the hunk you
are talking about (harder)".
