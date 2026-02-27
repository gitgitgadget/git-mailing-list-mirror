Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19A450908
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220700; cv=none; b=GLRhLgND9o9Pa/cd4GROs6k5qq5/zpN+HrPFZl3CcB+MZX4Q0BVnl8Ab0VRQmozPnuahW4PF3BpfbHBPpUprPdENLZvXYHTBOM1Uim+nlOSycK+Ra4KaZCJAFFzCVPFI460e6S+ZeyaLePZ/RNtUpCSyoRdQ0GqaMlUgUjcuXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220700; c=relaxed/simple;
	bh=jsmB0TTIApFmvcPT71f6aB7PbZEjvlFh+u1vfYzqK2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oVSiyxqy8AqmMshsxp5Vl4uMWctXjD8mldnQwOZXNA0mwnU4PUwUWKWQoaTlwy8du8Nv0BxJvGbDTCnm57QUH5y5LVR/gNXEAFDNZE8Ha/bsIyN9PNZiwAdr4VQNvNqaoWUu8m5IsZJLo+6SRDb2aEa6gjtWufj64XhL9JcSlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gRrKhqr2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WijBi6jn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gRrKhqr2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WijBi6jn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A1857A0253;
	Fri, 27 Feb 2026 14:31:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 14:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772220697; x=1772307097; bh=Zty+7Yo0MZ
	eJFtDVZwW5jA7jGArSLkGFnVU8HmhnTTE=; b=gRrKhqr2K6DTeTOU53jG/RgjuE
	AWeSOcMLg+TJ/b9v8Vy7gNkzk+tKVmdqKsMULC3NcFIADYP1xXV4KGQM2Thd+f4B
	FP6Jz8N/JbWH3Kj3CLRpt6Q1zD5BBsEgvGX2X5ehRLOzu/z48sFe2gTpVW75LpOt
	SKWWDrCLZ03NsGwwDxR2m9JzUWj4qSXWQquzmpKZztrZ1jJOGJ5rI3LO+SiJ9Tjr
	7XW+vLemmRArLyvPuNtfuUu3cErvQ/kRPRsCUP+NwAhm5BMrJkleheGvpGr8qzC2
	jCZyW072t3+G4I9OViVAU8LScptzrtAU98Hm7OCjajwIG3t1YLlbWOr1zanA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772220697; x=1772307097; bh=Zty+7Yo0MZeJFtDVZwW5jA7jGArSLkGFnVU
	8HmhnTTE=; b=WijBi6jnAFUnvTuWJsIkenhQv7J/XD7FddP1WSmLCoFDTxJzInY
	FpTuB6zbUptsTjj2ICp2+Xx/dRJTayViJMULwAmpLb15/osaGqaxeqUHxsTBAiE3
	/A0ixxWUMNJ5a/AA9diPx/GUEwnuJz33dsv8UYJgP81ucu/2CvpO7UKWWJGVh8Bf
	S6sMtTXIICwsQH9/hOF7eDGTLjoomumF/uGNNbLdDV5ndmwjzQvViBpaLEoZ2Wqy
	mk3ElHwJ3bdS2wlDok/hm5TasCPwYIYwZwjogLBYL3dnMAkc9FFHjI5VbrZ0DHac
	I6uEPAwglkZqjPLMQc2ItvaKsC2Y3oeVJ6w==
X-ME-Sender: <xms:GfGhabeSO2KYMCnES72fbEzk_oF3oriv_VfMKRB8iK8riYf6YLbRLw>
    <xme:GfGhaeKfbt8q2LZy9iMoymFu5NhNH8JsIL1thrJh9ZDzZmoaCOiKFkuJ8rqB4Lhdr
    s9FPtMCwLawG0QoNYX5Ae6VFuE9PL8me61Gyajoh5TKeDJSnnrRiq0>
X-ME-Received: <xmr:GfGhaQI9AFtVmyxDq8_FDdaanRbCyp7qtLsSL2hNMSh_ZNc66X5oJcuWUJR3Q4VfZLMazlpXd9yyJmua-FViXQ7fqFZ1TrAn0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhhrrghntggvshgtohhprghprghrrghtthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnug
    gvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhh
    rghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:GfGhaVVUABhyTWhzcKbuJ-sKNWjGh-O02dGX7LWH4aKU__IYW1syeA>
    <xmx:GfGhaRlE_NhEO_nAtE8_uL3cToFZ0UQC4g3bRJN1xr4RhAeTlr7XAg>
    <xmx:GfGhaTnFZgCnVmX64hj3kKoQndHSsGrjqzXjWYVx3qP4GEY_UU1yng>
    <xmx:GfGhaZYPM_KTM0dnHK4AnB5bbwaIIN-fozEkx-e5hxEbnMe-ism-cw>
    <xmx:GfGhafs5ox8UlU_bHU8PK5J9KhYUHMFH5QAEiL-rdnAgLR-ylN-QnVtk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 14:31:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Francesco Paparatto <francescopaparatto@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [GSoC PATCH] t3310: replace test -f/-d with
 test_path_is_file/test_path_is_dir
In-Reply-To: <20260227184538.4718-1-francescopaparatto@gmail.com> (Francesco
	Paparatto's message of "Fri, 27 Feb 2026 19:45:38 +0100")
References: <20260227184538.4718-1-francescopaparatto@gmail.com>
Date: Fri, 27 Feb 2026 11:31:35 -0800
Message-ID: <xmqqv7fioueg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Paparatto <francescopaparatto@gmail.com> writes:

> Replace old-style path assertions with modern helpers that provide
> clearer diagnostic messages on failure. That's because when test -f fails, the
> output gives no indication of what went wrong.
>
> These instances were found using: git grep "test -[efd]" t/ as suggested in the microproject ideas.

An overly long line.  Keep the display columns for a line in a patch
e-mail below ~70 columns, so that after getting quoted "> " for a
few times, the result will still fit in 80-column terminals.

>  test_expect_success 'cannot do merge w/conflicts when previous merge is unfinished' '
> -	test -d .git/NOTES_MERGE_WORKTREE &&
> +	test_path_is_dir .git/NOTES_MERGE_WORKTREE &&

OK.

> @@ -320,7 +320,7 @@ w notes on 1st commit
>  EOF
>  
>  test_expect_success 'can do merge without conflicts even if previous merge is unfinished (x => w)' '
> -	test -d .git/NOTES_MERGE_WORKTREE &&
> +	test_path_is_dir .git/NOTES_MERGE_WORKTREE &&

OK.

> @@ -564,10 +564,10 @@ EOF
>  	# NOTES_MERGE_* refs and .git/NOTES_MERGE_* state files must remain
>  	git rev-parse --verify NOTES_MERGE_PARTIAL &&
>  	git rev-parse --verify NOTES_MERGE_REF &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
> +	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
> +	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
> +	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
> +	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&

OK.

>  	# Refs are unchanged
>  	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
>  	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&

Here is a pair of opportunities for others that want more
microproject exercises to make sure we do not ignore failing "git"
invocations.

You do not want to address them, of course.  You've had your share
already ;-)

Thanks.


