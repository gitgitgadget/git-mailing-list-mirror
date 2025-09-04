Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF3136988
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010936; cv=none; b=QKmcOnxEq6qX1Ymcvf/ZEYYRcTRB+LC2SEA+ySwD9Bpg27bcQR9EFQ/rKcfz6LowLRwV81j4GwwTvsuaObcYc3an46rwpiyLLNiE/V0urOV1qlLI6QuETPY/dWory9aivRrgNjB48ew2p6OcZBpP3hCdKcmKdNfMrBd4GzgXgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010936; c=relaxed/simple;
	bh=Sfjh5/PhmR/yXxxk1EEeEFFF6AICgVzxV+clSa06jOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vi2ciNTg0AsBpLkE5WBHDBRqdBxIKir2NEg7/UhYwuGvzOtqlTWB4093Uq5OEaVZwKZ+hCGyZ7Rls7J2hsIp5pxCWd52Kn0TpmmMaWM4gS5MWFxQ/YKd6eB2Ek/Du+aSCR2dphbguKKe+Q1rklcYrG6A8ON/MUDmYbkOUoBHXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yi4JFuQV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di/69Xfj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yi4JFuQV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di/69Xfj"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61F7F7A0490;
	Thu,  4 Sep 2025 14:35:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 04 Sep 2025 14:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757010933; x=1757097333; bh=q062xROMsx
	LJnO3l8o3/nmgVQ39EoPZP7K+2nfx2TdE=; b=Yi4JFuQVq+O2Ug8TOTTyTkhvxp
	Xx0uoKqg/pn/NY9XfPcbqjLh9VB0hIWM3++2WBGOJekTTZjJzEOiHUssIlPvDE98
	XfIGfLSGuRP/EEbCu3RK9XWOpqQouHjfgx7RxOvo0dYglUdCgCveGXh5CyTy1E03
	31/pHK9htvg0azl7OMIsRc4aX/A+M8kyxXG3TG+lcB+9jrfp2X+LZlqiIdv59XAU
	uepjvLE8zSLmPzVLFL+9iIc7U6y1NYK3gzKzN+XDIuxu9DJ36l2z8kxT4fua/TcI
	k59lszkwiUy7wl4D+VsBxUsqLCYVKg4rPYzeYHb3IcyUVKK1ENiJmdV8anlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757010933; x=1757097333; bh=q062xROMsxLJnO3l8o3/nmgVQ39EoPZP7K+
	2nfx2TdE=; b=Di/69XfjCEbRZUEk+K0NYfGQirN4pfdY6S8LbJpOddWKJbDMz3M
	cmWyRyIytJ8iVFJWsVexxeEXmCxYwEuNUUhuRKRuYrc2cvnaoMeQrLbDkN48Mb8s
	jjCGGR1svlkEWSF34nCpzAa9OjDIPV0ldNLlQUZriiwcI93rmzwFGCDsBHvZE4WJ
	OjJ0OX3APIpwyrSggRq2XOvwzjrVhReLIpsDfTlD2Z4j9jZekBDm86V2JkD9gRU5
	lwj7JtQD9NTStrWsV2RED8f+eFzxxODR9ZWs1ClXy2XNzHaXDLkMJsO4+a5SjfeD
	erJmyjN5/EVUjCrpJtc/2DcVcPBQZKPxH+g==
X-ME-Sender: <xms:9Nu5aO3BMhYKU826UPrxp1WlsBSv7kRwn_fUAmYp53bC3gZQrRpmRw>
    <xme:9Nu5aJjaFqNPrzRwARIXMybtruJgWrYgz_Ee-WFgwDtunYcq61ltXkCz40TS6z0Hi
    EUbdXwqlWXAQmYLrQ>
X-ME-Received: <xmr:9Nu5aHUSLTGxB90JMguTs2vW3DuVmAO8fGH5DvF73OJCSSaWYQ7_A0aKrv4sgsWD0RSNQy7Mu8j7fss7Th_fa0kzWTNRGpH0B2wKv2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    ephhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9Nu5aAXJF0_125i-R4XUePPpVeOL3yX2iWmsNE3Pf-IlivPMJAsS6w>
    <xmx:9Nu5aPgzh0EuGNaEcedbKJN-0vGlPGsWtG7LCAtpYiHH2CLVEgvYgQ>
    <xmx:9Nu5aDZn6mUHEhvBSMwxCv9q2ELFBzGqQASlfUhKfpbmahPokgCNrw>
    <xmx:9Nu5aEp6HvZhynEkBjfKhHQNNurVglQapXsB4pCDkp5oBb3Mi2a_zA>
    <xmx:9du5aFU0kP7AWgPvEk_fOOjrh0iGKC4ISknRTXihJHmUqii5aTearx0B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 14:35:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] t0613: stop setting default initial branch
In-Reply-To: <c4d89c3761be77f1539668c8d543bb73fbf0dfee.1756992089.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 4 Sep 2025 14:21:32 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1756992089.git.phillip.wood@dunelm.org.uk>
	<c4d89c3761be77f1539668c8d543bb73fbf0dfee.1756992089.git.phillip.wood@dunelm.org.uk>
Date: Thu, 04 Sep 2025 11:35:31 -0700
Message-ID: <xmqqa53a83rg.fsf@gitster.g>
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
> As the tests are all run in separate repositories, set the branch name
> to "master" when creating the repository for the tests where the result
> depends on the branch name. This reduceds the number of tests that
> depend on the default branch name being "master" and removes the last
> instance of a test file using "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
> master".
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t0613-reftable-write-options.sh | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> index d77e601111f..6d00432219f 100755
> --- a/t/t0613-reftable-write-options.sh
> +++ b/t/t0613-reftable-write-options.sh
> @@ -11,16 +11,14 @@ export GIT_TEST_REFTABLE_AUTOCOMPACTION
>  # Block sizes depend on the hash function, so we force SHA1 here.
>  GIT_TEST_DEFAULT_HASH=sha1
>  export GIT_TEST_DEFAULT_HASH
> -# Block sizes also depend on the actual refs we write, so we force "master" to
> -# be the default initial branch name.
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
>  test_expect_success 'default write options' '
>  	test_when_finished "rm -rf repo" &&
> -	git init repo &&
> +	# Block sizes also depend on the actual refs we write, so we force
> +	# "master" to be the default initial branch name.

A new developer who would want to add a new test later may or may
not pay attention to this first test piece that would look an equal
among many others.  I suspect that keeping the comment before these
test sequences begin would have been better.  Or perhaps append "all
the following test use the --initial-branch option for the same
reason" after it?

> +	git init --initial-branch master repo &&
> +	git init --initial-branch master repo &&
> +	git init --initial-branch master repo &&
> +	git init --initial-branch master repo &&
> +	git init --initial-branch master repo &&
> +	git init --initial-branch master repo &&
> +	git init --initial-branch master repo &&

Having to change this many "git init" invocations feels awkward,
especially when we envision what needs to be done if somebody needs
to update this file later.  I wonder if a new helper function
upfront

        +init_repo () {
        +	git init --initial-branch master repo
        +}
        +

with many changes like this to the rest of file

	-	git init repo &&
	+	init_repo &&

may be easier to maintain over time?  I dunno.
