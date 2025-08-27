Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE48243964
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315283; cv=none; b=X8DPEd6E38mcQbX2DjdAoUm2vsM8Xel3KeY8mwMhRSxn9j3MJWi2DfCtjqyPbzkz0B4LLFHSxABpjGoGs6uL1GM0u9NzdqJauL19NmpMUwr/VLF79xsRNavk0rR7YttWQ5qO5GvBFtsvB+khrhHy50r/zL/QZuhqX8vvyNFD2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315283; c=relaxed/simple;
	bh=2Ma91XyLWOU+GzBaZxQqWyTn94+Ccagi7XUeheaeMEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iFIS6rYxO1dTAn4aKugG4+nJE88SbEpxu3hNZnroY9Lhl74I0hKIXapH32ahZweFLdrBBsm20WmUVACcFcEHvoWTE/kI/HINMzZRcN3HZFYKNqFKRhKpY+lwVWUdkeN6I71qav6J/f8pyII5XKNFd+5yy3Q5AK/n1YC35QZNxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z5G1c6hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZW4+Nc5R; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z5G1c6hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZW4+Nc5R"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B8C4AEC00A7;
	Wed, 27 Aug 2025 13:21:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 13:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756315279; x=1756401679; bh=ECcI6VISrg
	zsVhTgcMKzugX/syvbXlar2iEjwz2kUSE=; b=Z5G1c6hvVsD6Qjp2LPYZwdcbel
	JxpouyvPVkO1A1PY8mYlrh1yUR++InDFYWoUv/RXqjQWNbzmqFiM+l7yCNzQRch0
	2idSYyZASgVp6UbH/nB0ac5O4aBgUB2qnTmdgdLn25Lnt08LRcEVykfurTC6LWTd
	0ZOyG8V5RRXgpwvf2axlB3zJXJiUdonh5oQ2og4rAYeawVhcJeKLKJ0uTXySzAfE
	RaUHiVf+tpo2pHSzWLRymKSsMGn2LZpXe6pj4NAebZadsLY8tXAqHdrZMqIIAcvN
	+dTHSpGr8cKPQs1vBz5oPCWOso/+PocyJZejxNMlEMX5qSd0ZjfACC16bRUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756315279; x=1756401679; bh=ECcI6VISrgzsVhTgcMKzugX/syvbXlar2iE
	jwz2kUSE=; b=ZW4+Nc5RX4d8I0fSXnMnT2Y1eVkl37pCyUxuhKPVsYUogoK90Ty
	WnnZHI0oTXMgk9VYpdptKwj6yeyfXjvoJ8eTyFgjrPZk8oUIWEtTv5Nld76yUU2y
	xl0D6DzXGArr2xIaaoz+GtHfz6OrqcGNEoq2RyEdwZBnYQMdfGp25HWNM+QS3ct7
	4qQtZTzHXmpOjmDzRvckk9/rbNaUGH4b7QaEJAZWEe6rTMYpQcSq4hsvBituKvYA
	7Wt/188s7wwbTYSSRLsQalqRawEgzN2pc7WK0ON1A2VLHLxoPPMQPI8WpNci9LGS
	+Z4EX2MXYJB8BjXJMMEBI5+CXVf9r2I2IOQ==
X-ME-Sender: <xms:jz6vaKV6Wl5uDJsyZS6IBjxMgN8YDI3eeA3Rq0LtxGQGeTJrHr29uA>
    <xme:jz6vaCEJ5T_pNxkZS8EYusDFYvGvd8sW1-x7MeGea60oCFlVcTRBNHxIeibILt5Hr
    bjzVCfpuTroDVkP0Q>
X-ME-Received: <xmr:jz6vaE2zxYh5nqGyyIT2PDfLb5ZtcPu029rz1A2GcLEJ0ZwyNhrxj4Q2xXw5wxEoby6ANGwN_FECx1YQR6j6ZrClcQIa_d5te6eYGeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohephhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jz6vaMNCViHtXPRpm0Pqs5TuJ2_fLiuqBm9TiFDKbAkdCgVI5hDyUQ>
    <xmx:jz6vaL74dVtbwHSM9C93JAbDGKwtvcQXZKoFGg5eWoOQYDewhGY9Lg>
    <xmx:jz6vaO3kFlhrqLrw16M5nGPwK10E-uW0bo5BXhlVt9wOy70FBcuGcw>
    <xmx:jz6vaEyoWZu5IBVxDE6qFFr_u-FUzumupCIjglNRs0sNGBKNAA1AMA>
    <xmx:jz6vaLo5aN4ClO0vby-_rwcjXmN-Pnb_U44lctb3xn3KTRLOwuqYYGj4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 13:21:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 1/6] t0018: switch default branch name to main
In-Reply-To: <7c20f7693f4518ef79be0a2277515bb00d912213.1756308283.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 27 Aug 2025 16:24:45 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<7c20f7693f4518ef79be0a2277515bb00d912213.1756308283.git.phillip.wood@dunelm.org.uk>
Date: Wed, 27 Aug 2025 10:21:17 -0700
Message-ID: <xmqq5xe81y0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> These tests use "trunk" as the default branch name but the exact
> name of the branch is incidental to testing if the advice message
> includes it. ...

Would't we be better prepared for a future where advice messages may
start including the current branch name, though, if we made sure we
are on the branch whose name is known?

> ... Git 3.0 will change the default branch name to "main"
> and remove support for GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME so change

Will it?  I would have expected and hoped that this support won't be
ripped out.  The political atomosphere to decide if a name is
"correct" will change over time.  When somebody comes up with a
reason to burn 'main', just like everybody moved out of 'master' a
few years ago, wouldn't we be better off to keep this mechanism?

If we truly believe that we have chosen the forever-perfect name
that nobody would ever bring up renaming again, we can rip the
support out.  But I am not that optimistic.

> these test to use "main" instead of "topic".

You meant "trunk" here.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t0018-advice.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index f68e08d0b14..c695ade4be8 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -2,7 +2,7 @@
>  
>  test_description='Test advise_if_enabled functionality'
>  
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> @@ -33,7 +33,7 @@ test_expect_success 'advice should not be printed when config variable is set to
>  
>  test_expect_success 'advice should not be printed when --no-advice is used' '
>  	q_to_tab >expect <<-\EOF &&
> -	On branch trunk
> +	On branch main
>  
>  	No commits yet
>  
> @@ -55,7 +55,7 @@ test_expect_success 'advice should not be printed when --no-advice is used' '
>  
>  test_expect_success 'advice should not be printed when GIT_ADVICE is set to false' '
>  	q_to_tab >expect <<-\EOF &&
> -	On branch trunk
> +	On branch main
>  
>  	No commits yet
>  
> @@ -77,7 +77,7 @@ test_expect_success 'advice should not be printed when GIT_ADVICE is set to fals
>  
>  test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
>  	q_to_tab >expect <<-\EOF &&
> -	On branch trunk
> +	On branch main
>  
>  	No commits yet
