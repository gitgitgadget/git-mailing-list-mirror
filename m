Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266923182F
	for <git@vger.kernel.org>; Fri, 16 May 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400984; cv=none; b=m382061lgkCnalwCGe+E0vVQPVxnvyIz2T1GdzgfAFCfOuCLkAnQ+a+qJN9nKtDPekkUnbB6nOkvP50uXAj9zSjmAkBFvA8whXj4aP0L9cVWzOilvm5qSgC90sjodGiu86dlncFHMYXUS6GVi+gVZgz6bJ0VypCqsHcD3yBPLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400984; c=relaxed/simple;
	bh=22whLj5ixfl/UEWaQig+oYQbU2p1WejfQMakA3j+R/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B20JkBaJOZ4g2jUWZ6L5xIsxYmm6KoTUPv3xOzUA8/PNB9l/RUrWruGXpwG/vNatr+NZ9pbyIWSlsdLikOf6t26BAqTELu2FGkYSMzaFjW1rDCuMLuxevvKJnzSSRZ9uDh/g/oxXeW5Nfudmj7CsJROd7U7mIm0kNuCmj7sDFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5XrtOcq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AhYDVcrQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5XrtOcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhYDVcrQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E09C71140146;
	Fri, 16 May 2025 09:09:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 16 May 2025 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747400980; x=1747487380; bh=3iiCl+2o/k
	75LyRegQXjQ5zR4c351rnE0wygSkdyaEE=; b=e5XrtOcqLE/jDjgAbF94dzHgyv
	jpEsKTAptHe1yFG8nzmqEOrCIopifdWkOc0gFamSudIFesy5emTSFAp+TiOPHJk8
	L6S3yHk77UuMsnTtWKZv4YLVZy+zXDulp6BAzhzBBzypGbgEjF9fxFIRms+/qTwr
	TeIP+7hHOPrKUYNzvEw+Bak30+6WUtTXCQ/gzBlI9UY1dYt6iH4syMC1XGcmdaaN
	Gbczfk7d1RgBkSYUvR/LsdzaCsbaOrWD3T3psoar0Fmv8uraC/NXpsRqv5Q7HRxP
	zxBfrXWnxHps1ASAg3IAaN3euVfsLEcZ6ZfZ/1IE9c9qd5soWjv6Dn+qTFcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747400980; x=1747487380; bh=3iiCl+2o/k75LyRegQXjQ5zR4c351rnE0wy
	gSkdyaEE=; b=AhYDVcrQL16KK79ef/b5lSjrpziKOQZ8zaSdqtWaRoGmCnGmqop
	t2W59hF785mFO6OHmOB4ySND/dt9G1fxIrz/2e0I4MmHhfx73g+XGvbSuK4xYcrZ
	UgDDXmUKOQIWQg7nl6tm3a44yo++z55Zv0v5E6Vb2O/N73rtqLwXYe/M03Lr39rH
	KnB/kB3gdMptdxPxxufRtYX74DfPwnyMZEgy7xrj1TFQst0riKKYXT8BFjxUFNaF
	tNprcKp4rY8RNT2cm+rngyqlgbiBwLF8PYxKA8ZGcSMTMy4GV3pGeAPmMYDwmjUx
	ftqXQkaalMEQyrrAPrFCURIqNu3jEluTRhA==
X-ME-Sender: <xms:FDknaDqy2is68VT6E3vJ1ZQqRZPLFJO_F1EPrxKdLdsDSMabtVNWkQ>
    <xme:FDknaNoarAm284vcZyqu3bROmbJFGk3IQjllt4XvoYoxJgaQtxLJrLGsvrlL4VvjC
    S4tkjZf8FwV4IGA5g>
X-ME-Received: <xmr:FDknaAOjv4L-N5qJqccubs0malbABT51CkUrjEHH6s48NwUohRyMjXGfZeErRwZhgxnQm-v3Mk0S-EiJ95KyHaPy735Wi2E2elqFqC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishestg
    hhrhhishguohifnhdrnhgrmhgvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FDknaG6GtP3HYqSK-ndsGj_ZtFEnnjm9y5onwCbzu5tIc4wMwgoT0A>
    <xmx:FDknaC7VT8Sxs00Puo2QDAIOrNc6p7n6t7prmfkcLbY2qhsv8PYuqg>
    <xmx:FDknaOi00zpt0EI0zc7dMwh82r6eKpOXkSvdot5CVLaS49jwesKuZg>
    <xmx:FDknaE4IKqmIjTCjkUYJPKFp16TJtONgxiKLOSi7kYJAONliBZyElA>
    <xmx:FDknaAW1I4nTfWlFXQ5zOHz3gLWU3sNqLVw68d--IFeQeMe4ai9xKNpx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 09:09:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Down <chris@chrisdown.name>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,
  kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
In-Reply-To: <aCXqqj6gKc7-fjoF@chrisdown.name> (Chris Down's message of "Thu,
	15 May 2025 14:22:50 +0100")
References: <aCM5JY25NVPgyYRP@chrisdown.name>
	<CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
	<aCTI7VjK5QMht3ws@chrisdown.name> <xmqqy0uy4thk.fsf@gitster.g>
	<aCXqqj6gKc7-fjoF@chrisdown.name>
Date: Fri, 16 May 2025 06:09:38 -0700
Message-ID: <xmqqldqwya5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Down <chris@chrisdown.name> writes:

> Junio C Hamano writes:
>>But an old mistake is never an excuse that we can pile more mistakes
>>of the same kind on top.  Otherwise we wouldn't have learned anything.
>
> I'm curious about what specific issues format.signoff has caused that
> make you consider it a mistake. Has there been evidence over the past
> 16 years of it undermining the significance of signoffs or creating
> other problems?

Regarding other problems, the fact that we are having this
discussion is indication enough, isn't it?  If it didn't exist, we
wouldn't have had folks who used it as an excuse to promote
commit.signoff in the first place.
