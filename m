Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91F276046
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412027; cv=none; b=qvBgYovvMOuiGoch2xI0vA4C+s9+0r3k8cXeAnUsp+MXlDO6tyLYrGV+5K+oFI4AA06r5sHXaDOQchCyVaRl2DvcGIpWn+UmkQxUSWmarVm4+Z+2NHfYhmQZRALtndTedPmuLjjEYwUYxLwNdVaUJ1Kq14MNuVZCNPS9vWb7Tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412027; c=relaxed/simple;
	bh=R7xCjiCF9W/XIxwEIC2RlcwHrWjBMU+CULy7yYqXNsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XD7R9YkDxD2OGSzGlivrOBagE7N2/9PAR8Dq4rvH0Up1VGbQ7bkRdYHg4Z6YNE4olphjycCIio9RFIvvkwIVAkToqUZ5GPySfWaXMgd+EjI+uOGM5BsANVJ9AGRmNPEfz+ZTOOyOtRXuY5e5P4YOcpnMOFD82QUZE0NgK50Tcvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oqUBAR3a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIrJAS1/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oqUBAR3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIrJAS1/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA9CA7A0076;
	Wed, 14 Jan 2026 12:33:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 14 Jan 2026 12:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768412020; x=1768498420; bh=ZK44AtAQdA
	DK3YAbbUJcxg8JTqgHO1o2OGrytRViibM=; b=oqUBAR3a8N0K7YWpFk5mVz5o2v
	H0phFNoAJP68LgG1K1wKiIFgRaP+C0qfszpMHD1N/3Xji08r5g90f/2HTR6qpI42
	21OSNm1NXvQVtZlNuZ9NgbCzQlOr8yiTXVqgg8lPf+9KLJfZyMB6FlBsXQhwSZfq
	lAmhzlWMjLVQXdVrkY80ZTo+uxDM6zUZ6tFVhiGbSkpLIgVveRl6Og1N1hUQNmK5
	aC1oTGnXHV0RIURCgXU9oglbYWmRfsQYPVmdZIagmgQKvVplZRJgP7QmtWUIRBIB
	34Fsu7KE2HPSqs44dWKvvOCosVCYySOVM4/8ScDV9BBqTySa2lHn7C4X4w5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768412020; x=1768498420; bh=ZK44AtAQdADK3YAbbUJcxg8JTqgHO1o2OGr
	ytRViibM=; b=LIrJAS1/W97JyBJDZRJhdFM9Chb2nPg6ujLE2nEyBseiTbivVrB
	D7+fDmKEo5gL+48bj2KtPzQsjF+pRZq/W8jXGKUz9kV8TmXoIK1CR4KL+YOz8zeR
	BjiMau9cTeoH4u4mowu8Rn6gd4a8b/J8+WfxlZUccUyJDEAoyh4jg160110Tu/bO
	5qoD3EhRalvYVxyX0JDZ4C7PrJBfUAiczkOd2mqC6xMRuG1iLQWl/csSw8Gwm8lq
	bZvcLurM8KWCV1k/XtAjzAX7CFtfpLpz1M2hq4ZXNsqzbhN9mwsGet0VdkR9oxiU
	E9OO/yyKE1VPUYWTtBKn43NeOYihuMl6wOQ==
X-ME-Sender: <xms:dNNnaQkLvloQLVYbEHgFOxkSegEaUKwhogI5pP6SYiaJBk4B14WKJw>
    <xme:dNNnaWuvTXa34-GeVtaZR2yHPlYSe6jyhWzi-F-ZAGiOCt3PlcmhCjXA2af73QIGs
    U_hMaL5eBrAegrc7FFa9sivpv1l7OV67nJfS3uhs5mTxTuOs14asQ>
X-ME-Received: <xmr:dNNnaW9lZE4luIdm_6Mbb0FQj-tc993qNg5LXsbZDZNMUOdMjlSWTeygiTwzJ8RBysf9S3cbAdARSSeW-80Y5_Ctc2d0RVlPrARKGbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dNNnaYMU1t3vrvDRMw0r1aOK1AragD8ftWbE8Vw_ZzmE39v-NBnORQ>
    <xmx:dNNnacEqboKjf-rg83q11VHkuAUoyjuhJmrwQVIInU1grDAQseb4ww>
    <xmx:dNNnaeTzOU_BOQh9hCIgEJoZdoSsn1Cszfv1lkSWdbnHTH0QH57uHQ>
    <xmx:dNNnaRv4NLF_qF9U_LXHWRLowBB_KhEHaR5FEKj7TtTDpoUs6Q-tgw>
    <xmx:dNNnaatVatK143J1Oux2wg_D-gz36r8YDiF5IJ2yyixPvZUWVJpsFgRK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 12:33:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com
Subject: Re: [PATCH 5/6] fetch: utilize rejected ref error details
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>
	(Karthik Nayak's message of "Wed, 14 Jan 2026 16:40:46 +0100")
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
	<20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>
Date: Wed, 14 Jan 2026 09:33:39 -0800
Message-ID: <xmqqldi0f6a4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> In 0e358de64a (fetch: use batched reference updates, 2025-05-19),
> git-fetch(1) switched to using batched reference updates. This also
> introduced a regression wherein instead of providing detailed error
> messages for failed referenced updates, the users were provided generic
> error messages based on the error type.
>
> Similar to the previous commit, switch to using detailed error messages
> if present for failed reference updates to fix this regression.

The same question applkies as the previous step.  That is ...

> @@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
>  			"branches"), data->remote_name);
>  		data->conflict_msg_shown = true;
>  	} else {
> -		const char *reason = ref_transaction_error_msg(err);
> -
> -		error(_("fetching ref %s failed: %s"), refname, reason);
> +		if (details)
> +			error("%s", details);
> +		else
> +			error(_("fetching ref %s failed: %s"),
> +			      refname, ref_transaction_error_msg(err));

... would "details" always carry enough information to cover
"refname" here, plus what the err code tells us?

I guess ...

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ce1c23684e..c69afb5a60 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1516,7 +1516,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
>  		git remote add origin ../base &&
>  		touch refs/heads/foo.lock &&
>  		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
> -		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
> +		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&

... the error only talks about our local name, and when the command
is "git fetch origin refs/heads/foo:refs/remotes/origin/bar", we
only complain about refs/remotes/origin/bar without ever mentioning
refs/heads/foo on the remote side, so I think "details" has enough
information to replace the existing message here in this case.

Thanks.
