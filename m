Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CE2D7DE6
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344850; cv=none; b=SKxFiFo3YLoLtFYGFZ+Rg++1Y69wf34FkDvymm4dXraG/15CD+G0FVTdK7UPsTxZnfmhRT8syuJ0NUQ5sxVXDFGNP4Y42XsJk7mvf9ag4q6x10dXc6ckqy7LFKRqqpDCb7p6yQG+prwQCg3e5BpIV+RQHzZevK0UcuMX5YDMfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344850; c=relaxed/simple;
	bh=eAwuNxJbJn5G5tQguO82JE0TrV2sdUQ1+2kCB8Z2UKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XyF/MF2Xx4dPIOfUpTKZ6y4lJphmCIcNHWmoxyb8VY31m9Ogu4We47TLnZmryLpRnWrOxopiUcJj2r4YZWX413Ns0i7gU1D/LIHqpmD+9Z5tTRV2tn/xJ/P6oE/QWBEu+gxrFgh6FNgrIi3kaKrDOMFuWO+r+LfIbrkwLal4W2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wk1QUAKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEP9G3Eu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wk1QUAKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEP9G3Eu"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 234EC7A010F;
	Wed,  1 Oct 2025 14:54:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 01 Oct 2025 14:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759344846; x=1759431246; bh=EPba66b44X
	Yfvz344hey5dIGCCF8Bb6bIooe5l5m4Po=; b=Wk1QUAKr55tGbrevAPYp4DnZAF
	na06VMnfAyEFtrvqyllotzcoricuSNsFKmTaMne+jh+p/X7+uH9TKrF9cMFGdNin
	rspnRkzWzmUifWdWFYV3Lsdv6u0xdFT9QpRte3RWz//OEy3D1W62JrJ8Y2i8ffiH
	rHzvydztOpLEi68EUbG04USeTYMmRsR9sSBpyNJw6eSJO4MmEdLpAR3WX7ab8kjt
	QMkZ0M0cYR9Rb5zSdM3BYT7fWiG9O7rq/Ekj65jfD8fQjsZEDFO7Ix34koNckVyq
	XzKF6vI+oFD3Lt4qyMkT4vexLU9kvEZ1neaua+6T/6gfIMCm5eTqDl2/hmWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759344846; x=1759431246; bh=EPba66b44XYfvz344hey5dIGCCF8Bb6bIoo
	e5l5m4Po=; b=IEP9G3EuxOQzsWEAaXbQhUugNeqsWCbZ1kRO+pQiAre1sICjCZz
	fuQSHi/K/WmRB8ZDzTUEy/tgJRH3N10T6zHa3mKoomN1PneB0tXzp8N7Eh/Qs9rX
	nh5Ihe1Wi4b9yIgGdFbq/T0k7dB6kiKIoy5nD5rXshSmt1EKKrv7UUQM33DJAYo8
	EHEpNQknIVyNj6yAMHZ2osTwUqPzXFsY8qA4jt5JbqPKp2/ZrnhO2bstmsGD2qCs
	/UZORiWF4xoOcE32mUWvI9I4n0wFs5nn7Q3f5djEfQTi25a+Yb1sZBWetuWE3i8X
	dYiSBYogtAv5QwdMonNZvWlFH0MJrU4qUAQ==
X-ME-Sender: <xms:zXjdaH9Qt7rLjzuBfF-icOJIvr4JhCvd5YMw8gH4sGL9CMsTlHfqkg>
    <xme:zXjdaHah5ICgrZFKKfKer9LvXtkfQWNk2t0zKJSujfCAixkJSQHEM2blGIVdwSckW
    PmZ9iTjFUL3bjbBetVXtUnPhfqz_97ZhIVMZKWQXY4phGU0mW-xUSA>
X-ME-Received: <xmr:zXjdaO0d9L8g2Rbxj4hGr0ngHbp1fYaa0aa31699lz-V5b1a3IFySBRr4XRHmNIJWpNRvCDUnDj3egdv6VdcLcygZYxYy7bbiZn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggvpdhrtghpthhtohepjhgrshho
    nhduudgthhhotggrsehprhhothhonhdrmhgvpdhrtghpthhtohepjhgtuhgsihgtsehjtg
    husghitgdrphhlpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zXjdaKYbPQ5By0rpd2cDg1OD7wQBGlJ7kpo4f-HGZjZgZLKwJdiBkg>
    <xmx:znjdaOK4Wc68ysirGsQJ8Smp4MHZVoo6iv8iXpXcf5QcDxbexRPPLg>
    <xmx:znjdaBHj1nNMSjxnX1dWCN37JXf8WmUrZvkTyoNFGTNbZ9FrafSsgQ>
    <xmx:znjdaNtqNIKexPkmD_JIAWNPxlywPIvnnoNrZNxfdk7dVaoQZ79VSw>
    <xmx:znjdaNiEnRpsaBJXM7SFBlRGITNv8nWYHgNeZvETpJAnLC1AyqOqL8jN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 14:54:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Jason Cho
 <jason11choca@proton.me>,  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>,
  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com> (Ben Knoble's
	message of "Wed, 1 Oct 2025 08:16:25 -0400")
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
Date: Wed, 01 Oct 2025 11:54:04 -0700
Message-ID: <xmqq3482312r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> The impact is that the list of worktrees would have to be read to get
>> status. As status is not particularly cheap operation in any case I
>> would expect the problem to be minor.
>
> I believe status information is used for the shell prompt info, so
> performance hits there have a cost.

Sure, but an embedded git-controlled working tree _should_ be
flagged as an untracked entity, _unless_ it is ignore'd, no?

That is how you would add a new submodule to your project after all.
So, if you want to ignore them, just add them to .git/info/exclude
or something, perhaps?

Why do people even want to have such a layout, unless they want to
make it a submodule (or deliberate subdirectory that is unrelated)?

 -+- README.md (your own branch, probably on main)
  |
  +-+ worktree-foo (worktree checkout of branch foo)
  | |
  | +-- README.md (a slight variant of the file in foo)
  |
  +-+ worktree-bar (worktree checkout of branch bar)
  | |
  | +-- README.md (a slight variant of the file in bar)
  |
  +-+ worktree-baz (worktree checkout of branch baz)
  | |
  | +-- README.md (a slight variant of the file in baz)

Wouldn't it be easier to manage if you had this instead?

 -+
  |
  +-+ my-project (the primary worktree, probably on main)
  | |
  | +-- README.md (the file from branch main)
  |
  +-+ worktree-foo (worktree checkout of branch foo)
  | |
  | +-- README.md (a slight variant of the file in foo)
  |
  +-+ worktree-bar (worktree checkout of branch bar)
  | |
  | +-- README.md (a slight variant of the file in bar)
  |
  +-+ worktree-baz (worktree checkout of branch baz)
  | |
  | +-- README.md (a slight variant of the file in baz)

That way, you can go up to the umbrella directory and ...

    $ cd ..
    $ ls
    my-project worktree-foo worktree-bar worktree-baz
    $ grep -e HowTo */README.md

... do things you would do collectively to these worktrees with the
primary worktree included as well.

