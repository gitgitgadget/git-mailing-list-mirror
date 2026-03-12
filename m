Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E15375F7C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355227; cv=none; b=ijndHwHm4TODR5rwqVGv3O/ylmLWcG+hQy5yAKi5dU9SgnXnw0oIaMIgSyhwYv4NETLBQWymiqIMwqQ3n4rr2vgfKIBZ1vPJBVmqmcM9k3M8wYfWoLGySCo5Rg5lnYquhU6vB2ntyqrzaNSfPhabZiyu5sJl4zRVcsCI3a00d10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355227; c=relaxed/simple;
	bh=0hI2PkswR3zRfNSBfL47cxKwgGpQdXzLLRLEmsvuYa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kzU3b2XTEOOMUK/4L/ssLX6z6ws1o44615EO/asque+uDYGwaAC78a2MTSB1y+Mtj5eYpSMaAqgWLv2TdRRwdUhG1roLPvk0tfEXTZUke8w6orbaGwn7pN6nZJwaT4RMEPmZpXFmdjP5r0JRBiOu4EI46ESDag8O7BROJ9lOuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NGIo/DNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WyyEe4H6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NGIo/DNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WyyEe4H6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB1FC140027C;
	Thu, 12 Mar 2026 18:40:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 12 Mar 2026 18:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773355225; x=1773441625; bh=jIVE4QByPN
	1jKxomUZjm6Kaw3rtu1G7ZLkLcJggsMEs=; b=NGIo/DNuLJbADTlsQvccDswl8g
	I3NWHEqQLXqOJrhpMAdd+lckR5scsQjr4+SKjtHk3vrNPBmigGsr1Cg7p0X0GfM3
	x9QPff9vD3ei8yKweAXbQvXlYrWBO1cBiWIHvrYJq9aV+L0zQoGhj1fjCJE66jX9
	7Hx7el32FTaHzGQg9hBeQv/o/QefgZQyVZTgTt39BS93kyelZZtNFAI3QNdgpV6f
	2sh7528RP+IHvDtJmXd1cjvl0C3xkwso5YG3ewzJJ5Drgi9Fr6+SrPT3LeH+6LWQ
	8SAu47A+0Khmpjk6UYtcYnGhWNoc3QJSbxAdElPWi86q2grmfJ4DUjSBLxpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773355225; x=1773441625; bh=jIVE4QByPN1jKxomUZjm6Kaw3rtu1G7ZLkL
	cJggsMEs=; b=WyyEe4H6KH5diCeDfCSoqvskJZD7I1Xg7480158oJ6aCh43hqxG
	rwMpbKL5HlIKR7rWWvCih+Jzcbn+k0O5KIKf9xJ/clW4g98JKRLYipq3kLGFMu9O
	y8choZWxdhRWeFVpaydYnA0KPA0fZEBqT6m+qsFGIseopy9lyUPRPhcuARPO1PvL
	crUcEUq+gRweJHn5D+J3v7p/gG1pMNAoHkLF2WFJ8/oqfrhhhQy0vraB9P5JF+83
	5gTMSQYr2IgjrsQdHFvXR3NXi0CEpwQlwDPjhgrPJCdjdXQqvABPe+YqDzshZcct
	yw+GUyYH5CG0ZfSdwY78N45HGzaPXTqHBPA==
X-ME-Sender: <xms:2UCzaeVzk1hK6JxhpZkEV2J1BI6hjG4GmA3oTxONL1tDICBcvn9-9Q>
    <xme:2UCzaYLyR4mP_-pykvseMYtnP52k9H-CLywQ5vTbr7Wcz3fb3QlI0FRwqoeO4cygJ
    bLeTGASxaCBF9YKnMxTXB-C3TqlxtVGKlgf6cCtdNKgVeUUIeE0>
X-ME-Received: <xmr:2UCzaY17CvJvMGpCTWTRK3GxNu28OmF1w57u9l3Xc9rm6eegYyrGn4b2Oez_hO10bcOoxdBPC4Bi45Bn-Qtha8uCSV4nRzvhEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    hrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2UCzaW4dKO0SUGTxHf8iS3ECe7GVmfCYJ0u0db9kBofMyrD7-80P1w>
    <xmx:2UCzaZ-7OtxuXpE695tlGC_hSsga-TUhHvVBFfFT3z_3Yx7sxpP6xA>
    <xmx:2UCzaVUYAdaCL3h_mT1QwlKz6lyj60Xkzv5O8H81ti32q4p_6HCOWw>
    <xmx:2UCzaUq1GM1fZL5cf7Nkw9HpR1Ac4AyTWEoYeNk_60SrZIHDt7zoAw>
    <xmx:2UCzaf1TNldVRZJfPewMVsRcDLCcbac9fNj4F_uSJDLW7FIMaDR-lDpu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 18:40:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,
  Arsh Srivastava <arshsrivastava00@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when
 checkout fails
In-Reply-To: <pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com> (Arsh
	Srivastava via GitGitGadget's message of "Thu, 12 Mar 2026 20:05:01
	+0000")
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
	<pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 15:40:23 -0700
Message-ID: <xmqqldfwacyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When a branch switch fails due to local changes and
> new users who are not familiar with the error message often
> get confused about how to move ahead and resolve the issue as
> the previous error message only suggests to commit or stash the changes
> but doesn't explain how to do that or what the next steps are.

The first paragraph is a bit of a run-on and has a misplaced "and";
I cannot quite read and understand this overly long single sentence.

Perhaps the early part can become a bit easier to read with
punctuations, and cutting the sentence into two, e.g.,

  When a branch switch fails due to local changes, new users who
  are unfamiliar with the error message often get confused about how
  to move ahead and resolve the issue.

Also it is misleading to say "previous" error message.  We talk
about the current code in the present tense, to highlight what the
problem in the current code is.  The _current_ message stops at
hinting the commands to be used without giving wordy instructions
that are best left to manuals.  You may view it as a weakness (which
may motivate this patch to be written).  But I personally am not so
sure that adding words to the existing message would necessarily
make it more clear.

> This patch enhances the error message with more specific
> instructions in a concise manner to help users understand
> how to resolve the issue and move their local changes
> safely to the other branch using stash.

As Documentation/SubmittingPatches says, let's instruct the code to
"be like so" in imperative mood.  E.g., "Enhance the error
message..." instead of "This patch enhances...".

By the way, the updated message seems much less concise than the
original.

>  	msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
>  	      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> -		  "Please commit your changes or stash them before you switch branches.")
> -	      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
> +		  "To move you local changes safely to the other branch,\n"
> +		  "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
> +		  )
> +	      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> +		  "Please commit your changes or stash them before you switch branches.");

These were already overly long, but the updated one is way too long
to be read on end-user's terminal.  The source lines are overly
long, too.

The original was this:

 	msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 	      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
		  "Please commit your changes or stash them before you switch branches.")
	      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");

Note that when advice is *NOT* enabled, we only gave

_("Your local changes to the following files would be overwritten by checkout:\n%%s");

without any "advise" in the output.  That is what !advice_enabled() means.

The updated code does this:

	msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
	      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
		  "To move you local changes safely to the other branch,\n"
		  "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
		  )
	      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
		  "Please commit your changes or stash them before you switch branches.");

to those users who decline the advice, we now show "Please
commit...".  That is not what !advice_enabled() should trigger, is
it?

Also "To move you" -> "To move your".

Also the advice lost the other possiblity of first committing the
work in progress on the original branch before switching, yet the
new advice message is quite wordy.

Also, using "for safe merge" when the user is performing a
"checkout" might be slightly confusing, even if 'stash pop' involves
a merge under the hood.

A more concise version might say:

  Try 'git stash && git checkout <branch> && git stash pop' to carry
  your changes to the new branch, or commit your work before switching.

But as I already said, I think the current text may already strike
the right balance between being clear and being concise.

Thanks.

