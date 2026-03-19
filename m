Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238C34B683
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946691; cv=none; b=JqIPzIy/RRsWXzbGZ/9Deflvt3fcfEPBAz9WNMWBzIOTTbx4ALbkCnK79EP5JVOBdSDx9CyJtf2onnr7kX+J0jVqJv36Z6kbWtfZZvz+B1Rys+bOvbiBPAICsU+hgFVyeG0aJe21O8aN8PPVdgtnYC8kVG3Gbm2sU0Yk1W71l5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946691; c=relaxed/simple;
	bh=BVdeFsW5NYM7+yNj1B6Vu8Vgp+bFVg9DCyi7UbNYiek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Khqot8LN1um0vJRd255rGNWM9Ur+wCNjKQieQaexBgK7mI9A+8K91kEg2VrkhOfNhK9IuhRYFBlwNuJMsNfc+KwSHSPNRYm6kMpMEYj8wyIturzW09th0itoAKrPd6mZYyeqw+bVIgsb2rjGJaZp6UK1DNHYLGrCSOD4W7W89xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAu8aort; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vneupdYw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAu8aort";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vneupdYw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EBC8C1D00178;
	Thu, 19 Mar 2026 14:58:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 14:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773946688; x=1774033088; bh=WFEhJesysY
	awRFZv8Jaw8wIIqbzSejfvt+YZin5MvSY=; b=HAu8aort5krvbj8d5DvhaqJ5Ij
	RaGtwTxgZekqGXM5vzf+RbV/u8bodqe0OA8Vek5MzZr/xSiSL2jDBdH6tR2QCllW
	ukvA7i5km+AroTXkq/65pAusZaIwWehWjS41HSIUKsI9U7bSmCFXmOezvdlXYp2k
	CC4Cb1L+nuhdHeMeDB2NiRSpjhG53C0rlV6/NKJ9QVsM05HIhP6q0cTGNiRaM97/
	g69dxu0/pboPey5ZrbOZw8XSufrjP4rWKKwjgtBu7o4t12c/WRDooaBFP2q2D6fe
	8I6PbIlUrlrxgsddwfdnRq8D3p/YiKPvhzLoN+9ZbscUdscVxx+USMFhyIQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773946688; x=1774033088; bh=WFEhJesysYawRFZv8Jaw8wIIqbzSejfvt+Y
	Zin5MvSY=; b=vneupdYwThX7n2CB0S6TL5bzST3QhikGtrBV5Uu+Wf23Sp0tocZ
	HvAxBnrPmVoTNCmrxnJtM71w6sS7VyJqmABhKZ4c16WWZGMGSv5fHi3cDffwPX0Q
	v5xjbakHN3wiNbiT0V5fbYNKLiImpsVhtMW1QwAAy9/YCcTlbE/gJBLrtSu8gEKl
	mVss6RjwUBMp8kKGWxwaSFFdCS/8Ke+40LL7VS7xIac2i0qxUGCjddJWTxtssiDL
	Dig8cagil0mi8b5odH7xVWtIdehEjXVd4Zhm33rdISyDiBUKeqIzJszOb62TOFME
	hFBeBJUj9NPG3pLC8IxIQ8TLg4T7AE8EgSw==
X-ME-Sender: <xms:QEe8aU3ZK3-0NdraM0TGEFcGJ4KA_XQGBaosKXcwUSsNigh_95U_xQ>
    <xme:QEe8acBxbzcvw3SM7gNxVyOh3nezurcImGhv7rvhHZFpJJieybX8qQAjauFHh7Fj9
    csIPq_1rxQCCtrdNPGmNVcgkWdxF2LjpqqSRV6zR5eK_mlJgKqyKw>
X-ME-Received: <xmr:QEe8aYgMj4zGemy1hyD0V7Ek_Riy6WCGauDsuBCb2PomAYW9awiuu9cwtShT-v8tGo8dNkfbShNnTssoVoH4VU08U36rme5MLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvlhhkhhgr
    thgrsghisghilhgrlhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QEe8aWMUyQPdyuNlUK9zGLb5rFBjEKjWN_X2WbMGxgT38O-P1AE6rw>
    <xmx:QEe8aQ-e6sr8C4mRnBffvIB_2C3oGhPdTaLRnMeVVgwkkMP1cv8Bkg>
    <xmx:QEe8afcWfmpN7WnnHML7OL-QbsYdSV47xinU74bB4FnmkH2I4xcWDw>
    <xmx:QEe8aXyRuTDOe8xHbt3H2-mcqnxA5hmLcZ_OBkRVFn9Nuxy5FlmpRg>
    <xmx:QEe8aWHXApkJ59i_ukcjhOPCxJaYHEsuo4nKqhjaYzcwvvoQXvOcnPaZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 14:58:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bilal El Khatabi <elkhatabibilal@gmail.com>
Cc: git@vger.kernel.org,  pabloosabaterr@gmail.com,  karthik.188@gmail.com,
  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [GSOC PATCH v2] t5315: use test_path_is_file for loose-object
 check
In-Reply-To: <20260319180803.164335-1-elkhatabibilal@gmail.com> (Bilal El
	Khatabi's message of "Thu, 19 Mar 2026 18:06:52 +0000")
References: <20260319160301.98039-1-elkhatabibilal@gmail.com>
	<20260319180803.164335-1-elkhatabibilal@gmail.com>
Date: Thu, 19 Mar 2026 11:58:06 -0700
Message-ID: <xmqqv7erk5oh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bilal El Khatabi <elkhatabibilal@gmail.com> writes:

> Use test_path_is_file instead of test -f when checking that the
> loose object was written to the expected path.
>
> This uses Git's path-checking helper, which provides more specific
> failure output than a raw test -f check.

These two sentences repeat almost the same thing in different
phrasing, which starts to become a bit boring.

The gold standard way to write a proposed commit log message for
this project is to:

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.  The above jumps directly to the execution, bypassing
the observation and solution.  Fully followed, it would become
something like:

    When a test in t5315 tries to see if a loose object file is
    created at the expected path in the filesystem, "test -f" is
    used.  If a developer breaks "git" in such a way that the file
    is no longer created at this expected place, however, "test -f"
    will silently fail and exits with non-zero, causing the test
    fail, but it is not obvious which step in the &&- chained
    commands failed.

    Use test_path_is_file helper, which loudly reports the failure
    when the expectation is not met.  When running the test with the
    "-v" option, i.e., "sh t5315-*.sh -v", the failure would become
    more prominent, helping the developer.

Will queue.


> Signed-off-by: Bilal El Khatabi <elkhatabibilal@gmail.com>
> ---
>  t/t5315-pack-objects-compression.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
> index 8bacd96275..d0feab17b4 100755
> --- a/t/t5315-pack-objects-compression.sh
> +++ b/t/t5315-pack-objects-compression.sh
> @@ -10,7 +10,7 @@ test_expect_success setup '
>  	# make sure it resulted in a loose object
>  	ob=$(sed -e "s/\(..\).*/\1/" object-name) &&
>  	ject=$(sed -e "s/..\(.*\)/\1/" object-name) &&
> -	test -f .git/objects/$ob/$ject
> +	test_path_is_file .git/objects/$ob/$ject
>  '
>  
>  while read expect config
