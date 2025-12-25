Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF372E040E
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766649648; cv=none; b=Vg0J9i5RsSeEkilPySPYdJ60u2zM6PKAnNEUZMQvvppqvoUicaYFF/9IzsWd7IRg9CxbiAuk8vr7AZEzRXrP5ZWZqCmK42iy6h96l/l3e4ML5EhKPdfEMi3KX3HTloxjnAFnG5MAmbzwX1aM8wbZulPZySmryBTc3t5z9C2k8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766649648; c=relaxed/simple;
	bh=hQo3JWig3dKI9UpuHF+sDQTivRUuXCETs3NJAZOjORk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dsG2JsX0a26YwYEJt3KY8dPAt0SFn3KJ/opnl0ed/ymJIsuZhoG1psMZM3h4vg09yV9cmsjhkMxVZGH5LKaCCyK2YOr+T6kX7VdJw1w9p0YcJl57i3ERgIipbTI50o2l6WI0nr8Ud3THYj9TL90pJWe/N5o+zeLYeDhmvaORUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ebq2d4jY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8QeWyme; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebq2d4jY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8QeWyme"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D8177A0115;
	Thu, 25 Dec 2025 03:00:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 25 Dec 2025 03:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766649644; x=1766736044; bh=GkegSI0iUb
	FQmW2vl25LTTEfCacgCHI2GrkgzCKMxmw=; b=ebq2d4jYn+5eDBV4pKAlJMZhqL
	XZpR75oJ/HniBJxdrL64Bs7oHn6pw8G99kBiyUwQVOfgURf9PE8KdG5GCI3bSs9k
	FjWym7unu4it2/9fUpgvoSu311mccQj2Jdd6s3S88x4fQ2hSy9Fd/yhWEDMx8Zq8
	OiUqlfOkbAzMPRU1T3uH5bRNFGWDYIX8iLqud6XPeL+aB3mU44AoQ+7lCm4iUSqr
	zQ0yS2ruDrQp63FYCQ3kIxCJlrA/bwMuVsPXgfHVdIqmdGt0UYleKxCEfO5GGswU
	Si5GHQAA4e9nb3OCaUG63k+5DKwe/ahNzWgX4AoX5tcMl+V+LT7mCP/W7/4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766649644; x=1766736044; bh=GkegSI0iUbFQmW2vl25LTTEfCacgCHI2Grk
	gzCKMxmw=; b=P8QeWymelOL2MfJdvQp1qvhHVDl75O770zoIJ6u6lJNr5LEoFyK
	0KMtUNxRy6HDg3iWkgOCSzvi6fSQMt+jBpbMlxVxFca4zPO18X788bFJPNfWG0lt
	nsBc49DmKZNucf3UsjETbCVAAw+q/uOXRvautVoT0YiUuH/d+fnlFm903kTj3s9H
	bNTLNC0OmXKvxS+sewYCr6y61WrxkaqvjTLFGjfhtVLP/mXRYXyV61ABVoK7TOeF
	Sg23po27XcKLFbF/VB7PWFCgu0KUrUxoVpSXXl1vH5oHELP53+k3BIC+WMgVdRCv
	fMpOls3GB6q58wWFhQaA53CmnYtZOWl3neA==
X-ME-Sender: <xms:LO9MaTW2zUh4KM-SXTNT6dKIeSByZiykBSkYp6E0pi954rioZs-yoA>
    <xme:LO9MaSnzVCMiYXegQt9znwty4MoBXGQiIDnezMVwE6lztDTWqBMILj9UxcgEq5sO2
    IRBlpO-2I5tWe6Xi5UViU3QdotzrpGvVpbJN6Qr6zXh55GMyiR1ZQ>
X-ME-Received: <xmr:LO9MaUZsWINmOe7UbTYSkz0CkWTWnOdILrUAhNfr4IOI01L-D1QQceQpbQOvgD_1zHpl1erfPTlflJkbETWp2gou3CnA7GDFOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeihedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LO9MadMLlbvcU44qFawdcBGA_CL3TtUirLSyO3PYhdk6u9hq61dmfA>
    <xmx:LO9MaZbQ2lTQEnLVwvXzQywBx3i-xCm4eScJecuL-GaELg9LRqdHpQ>
    <xmx:LO9Mab3hb2WU8px4iortJUBxi07yO2Ba41yEjP6DdLdkDMLoCjIyAQ>
    <xmx:LO9Maff-mT2zMPWyAQES_A1z3zDLaY0eau7yblcSQFMx6zJGisUs8g>
    <xmx:LO9Maf5lHXTMZm6wBceRuv4hxTNYYASNGWqXaZQncG0eLf52Y8YP9wn0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 03:00:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 0/6] status: show default branch comparison when
 tracking non-default branch
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 24 Dec 2025 23:41:06
	+0000")
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
Date: Thu, 25 Dec 2025 17:00:42 +0900
Message-ID: <xmqqms37m1n9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
> ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
>
> Harald Nordgren (6):
>   status: show comparison with upstream default branch
>   Simplify default branch comparison logic
>   Use repo.settings.statusGoalBranch config for status comparison
>   Rename default_remote to goal_branch
>   Add warning for malformed statusGoalBranch config
>   Change config key to status.compareBranch

It seems that [v6 6/6] smells like an "oops, what I did in [v6 3/6]
was wrong, and this is an incremental fix on top of it".

Please don't.

When presenting your topic to the list, rather, after you finish a
series and the end result reaches a satisfactory state, please look
back and polish patches to hide such mistakes in the middle, pretend
as if you are a perfect developer who wrote a logical progression of
patches that goes straight to the goal without stumbling around,
taking detours, and making mistakes you need to correct in a later
step.  Detours may have been taken when you initially wrote the
series, and it may show the "true history" from your point of view,
but to others (and the most importantly, to those who read "git log
-p" later in order to extend your work to suit their needs better),
they are merely distracting.

The titles in [2-6/6] by the way do not seem to follow the
established convention, like [1/6] does, i.e. "status: show
comparison...", use an area prefix "<area>:", followed by a
short-summary that is not capitalized.

Thanks.
