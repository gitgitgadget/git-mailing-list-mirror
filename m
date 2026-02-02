Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291410F1
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035546; cv=none; b=mln0dZUBh1d9CiH+jIBnXNCeAhdWGxwyJJ4PGPAkmXBK9Sw1DWlGH2Vts/7uIbNJiTPSbvED3QpC+Atq6hsWwByK5z5+vgSh9WGUjqhdRzo6kjTWmPJ4xVSFyP5qag0i2aCcSdqb8s5EwtGRpdKUzOkvqi+e+pkmMDwztZ6wwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035546; c=relaxed/simple;
	bh=rbe0seF46fudAqwTkVNeWe61a9cHa+P+bkAUraRLC60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7jxXukpFSYl/loguQOR06DIVeRRwFEijmKNOgXBHpWHH1qET8amMORVJuVyNV4NtArU7cXFifv7H+vLyf93De4cHDy0mfMxEKzo+umaQIfAQP07HERP/OZN3+Qiu+6cvxvAwXhc+V8i4EK9NjhboFm0GaLai9wAcp1wG+lAfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lGL4lQDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjL2LVy3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGL4lQDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjL2LVy3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C9C3E1D000BF;
	Mon,  2 Feb 2026 07:32:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 07:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770035543; x=1770121943; bh=akwozPMLif
	INF+++/roi6UfRn+JJWSC2UUREXt9DVBI=; b=lGL4lQDbf6HYqhnAECJL+cSdZ6
	0PWPJn8j6gd0+ZvXdHqPq9HaasZLFd+erXHnS6oufgfkIfwBWF3+wSEBug3p5PX0
	rblAVRAKmyRvP968vQA2B5PhUyRBN4gGxdC1MlzDvGUHugwscT8Y5CK2gcom/qHY
	XdmD29f8mc2S+XZ8DMytVFoUcsq677pI0xsyNOYJBNkbXzjS4WgspAOAYfjvsaXA
	I7uDZxgndZBLVQp0BdUtktd9lDnuSg60BFXSPTX7kyPQgMbCi8RDc/tCBOLCtXG8
	gzRgULqF93O20e+OEZb2BuiJcSCbhkGRD4kRMiacoS49BMMs2np32myp3AfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770035543; x=1770121943; bh=akwozPMLifINF+++/roi6UfRn+JJWSC2UUR
	EXt9DVBI=; b=mjL2LVy3YfT2wqdAv3J5YRI5izsZhoDXXR+Nk0QU9kC+7uhtGGe
	HSinr2CWgv9XHCUIpva5yelLXwYucQcy0+VaJgTg/UmHoLsfODwkS/Pb9qhe6rie
	8J4j8h4cTm0q8VfdlHFKrj5KGHZFWnSlkVVp+U8ShNd+mdt7QDL4B1BYIt466aOk
	P+6DqUamr0Mu8t7QNgaSPMmoVvzEmQEbi06fYuViBP7Qya8iIhUJwxFNcKh3qhgb
	TQl+5k9WHodVBOeso6tLTkDHKm4D47vZOsvjzkKHuOo3UhwbhjVyCVqvE1kVVKss
	YHXF8BiXFzTA/qardQW8uvulIU8ctIYOsrw==
X-ME-Sender: <xms:V5mAaSa9-eWo-RAvU52rDWZjUyRsbjP0CRxU3TMQ6gVa6XMz7XYmkg>
    <xme:V5mAacZtfAHpyRyEvuBZGgeUII5GOzHr4mJcJRuSIgEKoosjXDjE6z66S1ay69gFI
    AaUqZ-ukKDAt5YSfldpZopyeclsZ0lzahpQq521OaMEpemSZpXr8A>
X-ME-Received: <xmr:V5mAaR-vDMERTVBVYvI_nuNfecEbzBZ-ra2nETV4JBGh6cR-zljh8rD127XcmzGuemkR3H_8xxn3JoABx4pFl-8FsbNFJxJg0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V5mAaTh4cMPCFtiaAF01PQXeN0e4P6y7V1_gVQFjKfCL4uz1k9nTFA>
    <xmx:V5mAaZe1xlPlFbylpyqmiCJyEJpL2yUOdDZkIN1mEqky7iaMtasigQ>
    <xmx:V5mAaSpJi9pETz3JVw3VA35MgXmCIqLIGC-AsVQs3egpd0kpVvz6DQ>
    <xmx:V5mAaWD2rJebQX9sL_NjwNql5hBbv_ImvHVHYtPKiR0G296cTktDvg>
    <xmx:V5mAaQIcu67HEE2c-cZEURcTYJXYkvdnecNtE5N1aZ3KiW2ZA8_RCmyw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 07:32:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <20260131205521.11876-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sat, 31 Jan 2026 21:55:21 +0100")
References: <20260131202232.9213-1-haraldnordgren@gmail.com>
	<20260131205521.11876-1-haraldnordgren@gmail.com>
Date: Mon, 02 Feb 2026 04:32:21 -0800
Message-ID: <xmqqjywv2une.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Doesn't repo_default_branch_name() do the right thing without being
>> noisy at all even in a repository without that configured, as the
>> function will fall back to the built-in default?  While I do not
>> think of a workflow in which a handy access to the value the
>> function gives would be so useful that it deserves a short-hand, it
>> would be a reasonable candidate of what to be called "@{default}",
>> if it proves useful, I would think.
>
> After looking a this, this is hard-coded. Not showing what is relevant for
> each repo that exists:

Yes.

Of course.  It was a suggestion to avoid getting failures in
repositories that do not override it with their own configuration
files.

So the @{default} we originally discussed was not something that is
"relevant for each repo", and where refs/remotes/origin/HEAD points
at has a better chance of closer to the relevant name?

