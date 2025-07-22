Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D849285C8E
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217680; cv=none; b=uhvFf9UlIQqSxJrIQkqVpl02gn54jmFJ26ttFeJr5vUSsGkTyKFCFkPVplFKeAM6u7LkwwMixDaMsjQmxKaylF4XRK6WHqyoysDOqZaXYekcu9hPsEF7DUuEuseYb8v/z4acnV3nw+Tw+TwPrXmRLLTlecPUCvVR1fCEw0YOa48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217680; c=relaxed/simple;
	bh=znlpE7I5szTV9cvJh8ilpjGSPUndMgSGzCYn41Ni1qQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TYWyR3wJAgaLaZlbBJEU11r6zFIawGhB6jrbE2MRFTrNZjLeZgl0HqHRM6GzEmVk0OWoYMZeoq0aMbsgX8/H/Y8zwLgBTd9V9BLZboUBOR69DtNO7daYpoox3to74xkVQfaJ+2Xn8zbrFHXkm1YtSALX4s4abC6AxUh0PvM42Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HyYtXlhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LjEHiF+9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HyYtXlhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjEHiF+9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 428DF1400590;
	Tue, 22 Jul 2025 16:54:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 16:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753217676; x=1753304076; bh=hQenRZjjyP
	r56Z01WHvoi4gKws1EKqIrO9jtGzXXfwI=; b=HyYtXlhUkSzmnSS8EOs+W7UzW7
	QDkamJej/Cjzuae5eKxh+SaMfMcKM16LiSOCR8p1tTXEZtR2lUCUACPkbklbCYLx
	ffKwT+QmlMa4h2jekC58nlGNP1UljthnScUd1Ho4e6Ll18I8wmn84s1y0ogHQT8T
	XDM0p99qxIjp9kD6DlO/lmuyBGwSLSCgzQzQeJbwtaNoigDh+t/s8FEqofI/poVI
	rHX7QxaG18TCnmD4pCU86SN2Dr1naLhYgV/zin+DII5lbVY94csK3P0xLFQgMxtM
	dzcyueLWj/xjf8kEKvDd5yxwK6XTPHFt6UwE/nh2mJxaxVYZhNKCFIEfnvsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753217676; x=1753304076; bh=hQenRZjjyPr56Z01WHvoi4gKws1EKqIrO9j
	tGzXXfwI=; b=LjEHiF+9Njl4u7Sjuon6O/Wh3bMG51SaS3BgQUtHvCevI6g5vpj
	j26z0pJQf7pO5tGq8V48PdIboZ6bzesZmeSkd5okcic7RDWbIfzR9lUTM5ytyMdg
	io7fKXKPCedKsXW6xj3MLotOzBYTVrS16Tgm7BRPALYENz4XuCiJVCPiaCabeH0R
	fN+EVj3B/WXmvJFz0e+DatH3dyNkoneJai50VKYm8e9VzfbQuPlOsZ+x+OO8PjPO
	B8hHQXmMGvKNZFum+N2fDAxys/ym97YtYZssmASvHqoW/KmUm1PFUomyTTbX8/DZ
	+CIQY1wb69PydZZtD56pv9xNpAZzSTneinQ==
X-ME-Sender: <xms:jPp_aI8GJHYHwDrALbTBY6X03guTdoBlBlYUoJL8KEU4hZzL3XnTtA>
    <xme:jPp_aLRS-SYXaGcauGRVVXsP0WKuuOii-rqrO3KFFKeo3VkpoP0XeF8HiPXpyvLOu
    2AIhwYmTN00Uvwntw>
X-ME-Received: <xmr:jPp_aKn8hcdoYF31_ALHZWPdJFVJJpEIZ4hDMqMrxFNlSnAWSHqrAFT6-m44j0zLcVWyPyRLZpbXp_LlvVnljIr4r6xooitv7HHigwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jPp_aLSfGXzK5qMrWYyOVHVNlof8M0cIL0swJMSABQaGfQ87v60a1Q>
    <xmx:jPp_aIMF63wu4oJqfCYluEkSRxLHHc8qp0mWvtEexEUIsIctFZNMkA>
    <xmx:jPp_aEUetI1rhCkhT2h3uyQP1zVBw2w2-a9T38tn-7e2M62Lr1jHLw>
    <xmx:jPp_aPfHqwENpnF4BUz5-01iMJVo0Q8C-jULeHQHGcmJmkh9U1VWbg>
    <xmx:jPp_aLM3JwYog78PKhYF2rC1ParVbkdK8vIGYoJP8U7qDcKehlmjFjJI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 16:54:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 1/2] builtin: remove merge short flag for switch and
 restore
In-Reply-To: <20250722180818.1043014-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 22 Jul 2025 13:08:17 -0500")
References: <20250722180818.1043014-1-jltobler@gmail.com>
	<20250722180818.1043014-2-jltobler@gmail.com>
Date: Tue, 22 Jul 2025 13:54:34 -0700
Message-ID: <xmqq1pq8rlo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Both git-switch(1) and git-restore(1) inherit some common options from
> git-checkout(1). One such option is the `--merge` flag and its
> accompanying short flag `-m`.
>
> In previous discussion[1] around removing the experimental marker for
> git-switch(1), it has been suggested that this short flag could instead
> be used for an option similar to `--move` from git-branch(1). Such a
> feature is not yet implemented for this command, but reserving a short
> flag for an uncommon option is unnecessary and hinders potential future
> extension.
>
> While these commands are still marked as experimental, remove the `-m`
> flag from both git-switch(1) and git-restore(1) and update the
> documentation accordingly.

Surely the whole point of marking the commands as experimental is to
allow us to make a change like this one.

I doubt that this particular one is a sensible change, though.

"git checkout -m <another-branch>" is one of the most frequently
used operation in my daily workflow, and having to type "git switch
--merge" (not having to learn to do so) would be a major annoyance.

> The `--conflict` flag is also now defined
> explicitly for each command as to remain alongside its related `--merge`
> companion.

I doubt this is a wise move.  Unless we are planning to make the
option diverge across these three commands, that is.

The main logic that implements the "move to a different branch,
while merging local changes into the new base" does use these two
things together in the same code path (in merge_working_tree()).
The same for "check out a single path out to the working tree",
which does use these two things together in the same code path (in
checkout_merged()).  I actually think keeping it in the common part
would help the readers of the code even more---by making it clear
that these three commands parse the option exactly the same way.

