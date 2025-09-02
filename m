Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646A2FF64C
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830071; cv=none; b=deGSwrJp5smEsIgsl8GJe0zyPf2tNhMJbMB9U+nBS7+mMa0FOFcIdlGvbhBS1RqIlBet7GrTeYTJnraNkUkweJ8uSAC2zxnVBzEysXK7NAquJjjGlCFdv52FbO951fYyrN/0/mL/y8KgCsS1CNUXdD21tYJ9IuLbNkLMee9VWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830071; c=relaxed/simple;
	bh=LeR9EJDvvOWLd5DmZy9YWB8jfD8/TUff/sZFg5OHa2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jYtgDzV3Nenx8Z1toXpqJ8hZOE9JQiU1q0F6F1Zv37qa+yW8rsXuTKMl40N1QTJyWoSmglLcPGMp5HCrj23Ky2cIYEaTUveqS4+tTe9DtKd8kMrsF9cPMbH07FakeyahYlqylv2AKYvcgo9PTHR9H/q8+7Gguq3DtL0DT4xtcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LYXIyVFb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U7lx9xAu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYXIyVFb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U7lx9xAu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 077AC14001C2;
	Tue,  2 Sep 2025 12:21:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 02 Sep 2025 12:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756830069; x=1756916469; bh=+RyBD1H84A
	MhPonkqmVHQZGawBLiRC+LPvgNucajz7I=; b=LYXIyVFb+VGXRcyPaviSViI+CI
	XY1T3stuhbTxJsvcWD8XDj3OU2Ogu/EHZ7R0/Tx2ChUX75PhAh3tw4roDpHN7x48
	4HByNdHYsGnYvdQB81MxRibeDvyjH1K07+n4hT+DrasaZYvhNj2gMJja3gIfZ5l5
	ZbocfZP6Zzhx5IRh+bHFvPNEeBFrm8Jl9rZqHT68taznU4M2TmDXfRt0Ti7WsPyD
	JB/CuZopsJ/0D9+Lqmj5pEE6WaM5m1wKOjoUrHnhO7eQQfJgE3zHSXY7GMUp12jR
	mRt0tRBMQYYKR4CRUHBg/+PFzsN8MHjcvMIj+xnDOCer9LI6ATYrG1LkODQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756830069; x=1756916469; bh=+RyBD1H84AMhPonkqmVHQZGawBLiRC+LPvg
	Nucajz7I=; b=U7lx9xAuvyJo8Vvo9dC6kMBxCWFBeFRYEAfhCUKQctiI1RQ30bZ
	DCvyYCDw0gfJqoU8FNXVOELPXBYtNeOrzONhlpsyw/4tMH1ZtFxQBYeSMKRdTbcG
	g2y15w9aQEVU+OTPb3fPPELfmlD77SknFxx0lUxWCjs/Nz6tMgqe3Ot6pN+kYszc
	7V8nVMiGI8wHSvuc6ja0mjjt3/qSyrZGOUSkFJlM6YlerTubMZoNGSw77FcVuj7S
	LZxjWhjsWYllsRxVrJ6CNtoj6ULyUgWBq2KP+TUhImGLx8HDrvxtPoEAKntvpULJ
	8YOC253GVBINh5/fZKUzTSOk1HQJzn4LAqQ==
X-ME-Sender: <xms:dBm3aIg5XGfkuUH5DAZlsvmkvYF9Q0bx0jOUlIC8HqpBRoTblfliJw>
    <xme:dBm3aMhBZ3osjT_-m3rYSkfe5KnLklcqb7zK313T0PXvrgCQ2tUV8yZVmzs9-5sLT
    3GASy82hYK_Kdsflw>
X-ME-Received: <xmr:dBm3aGjcEX0ULw2ytYRxZ6YHQFXpODgOH8pVLghcN9gSNrSOrw_XPyihO359MGk7P5_jkjZTkq-_4yaEqO8L3Y9GAoVue4i22mP_JIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dBm3aEIFluGymgumyOY1wOT9xAmU6HqjtYZiZhmnF3sM4uId2DYO0w>
    <xmx:dBm3aNHibe5IArzfGSUKBP7AtpwXwc4LOKLQYYk0N8aHuJamXJSvKg>
    <xmx:dBm3aAShdutsoltExKIm8Hpu_rB-2WyWE3qpTJEp3ytAxmheC4tq8w>
    <xmx:dBm3aBdoTbUJZuQXNAWBIchC_tyZ5XqHgvFt6J3BvceqJmp61oCFig>
    <xmx:dBm3aDitJNSjgTcgruCnsMoK_XaAT-Srpr-dIbUenR34e4g3s9gZswUT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:21:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH v3 1/2] repo: add the flag -z as an alias for
 --format=nul
In-Reply-To: <20250901172732.98845-2-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 1 Sep 2025 14:27:31 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250901172732.98845-1-lucasseikioshiro@gmail.com>
	<20250901172732.98845-2-lucasseikioshiro@gmail.com>
Date: Tue, 02 Sep 2025 09:21:07 -0700
Message-ID: <xmqqms7cltak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Other Git commands that have nul-terminated output (e.g. git-config,
> git-status, git-ls-files) have a flag `-z` for using the null character
> as the record separator.
>
> Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
> making it consistent with the behavior of the other commands.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  6 ++++--
>  builtin/repo.c              | 37 +++++++++++++++++++++++++------------
>  t/t1900-repo.sh             | 12 ++++++++++++
>  3 files changed, 41 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 2870828d93..6f5ee88215 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
>  SYNOPSIS
>  --------
>  [synopsis]
> -git repo info [--format=(keyvalue|nul)] [<key>...]
> +git repo info [--format=(keyvalue|nul)] [-z] [<key>...]

This is OK and I do not want you to reroll only to revert this, but
FWIW what you had in the previous iteration

    git repo info [--format=(keyvalue|nul) | -z] [<key>...]

would also work perfectly well here.  It is not like you are
forbidding the command line to mention "--format=nul" twice, or
"--format=keyvalue --format=nul" to allow the later one to override
the former ones.

The updated option parsing looks much nicer.  Thanks.
