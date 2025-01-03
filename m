Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43E1F942C
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921505; cv=none; b=lrei4Y3VxsVKsD66TbK68ZzbXYpvt1WbYsfrSc0kpC11zvtReE8b7HNmsrDkGETepXKxYqBQ+gAycgs82DPst2piCL2RDi5cecZuMEv0lkDqyOSd+YYg96wZcBmPwvIqPltg3ANaHOZfXRGqq2+Btyu33sFKIKzMrc7cHzA1ysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921505; c=relaxed/simple;
	bh=Cyem0t8bgJ4kl2q31Rn5tui5vUQEcvL6uES7BapsJRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfPBLs9xsKoSmb0BtnUB+L40L2CEgmABnfPv9Xqw5vYHkjvCTpTUH3JUrIJrbV80ycVbeqH4uLfa19X8rbQyK+w3/swbLnjdR7cO956JCgAJasM0WoDgr4EBI218qPaZf2lSfBJMlo+NXsc4/OD06GZoPe4F4ZUVXbaJbLcwoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hYmnPXPQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t/VM6rvb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hYmnPXPQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t/VM6rvb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 29DBA11400D9;
	Fri,  3 Jan 2025 11:25:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 11:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735921502; x=1736007902; bh=yzXLAGk8jg
	qj+uFBEiC27mq7VWAjjKVtw8Ey96dTQnw=; b=hYmnPXPQKeW1qGna2xfFbEkPD3
	VsaC+IjhV5KAoEaDV1fkiX/wQ7fPirvC8yyqiQBmAqjmyQepN9q4dAFTJVTwOx3g
	A8EjiVBVkfnEzbH92R7uCFBZ6srO09GC5dT3dRfDEcbvf0Xr3+kAzMpCK8swq+ub
	3hb5dU/KG620zfDtTZ6L1ygfIwUdIWl2Ik4+aP1Li48NRZtGAYEYenMiFQGbuli+
	dICAI1ScqXjzXum/K/JTCkNqS2TUhl9khWuVL24JkorRHZOXa3adAeFEoBo9+Kua
	0Df+RXGFjKifNjwQHNZWmJZoA/zjt/uV1qumOnRvNDF8U4y4teheat/rN6cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735921502; x=1736007902; bh=yzXLAGk8jgqj+uFBEiC27mq7VWAjjKVtw8E
	y96dTQnw=; b=t/VM6rvbK9P1M45HDAepghMW8Bu7Wm4XBcl3NVv55MXmGT4peNl
	+8nnN3dbkDMOVAMzlmADX3dWy9V28WF10SmII+diYFyJVtdMbwDtz1UTIjYbaWqN
	nV+IRS0jxfKE11VW2rllGZl5lGlj0X1GY6GUkNGM7vgnmIwv4OyGZA4ddG0gwWkk
	FVWmGsZbBPTJeWCr9UqhjXHSphEQ6yJJmf4Tkp9ICrsous2CMLQ7BHGOq7R5gZR1
	lNp/6Z40tlwl/N7YL+3Ytu6S3JdcojYE5FRbsGG4lUcuTnPuXCA7Cht3ga6gUAtf
	LpPXGuqe3xpBycFs6LqcBjQEeU5zSEk7y6A==
X-ME-Sender: <xms:XQ94Z_dAJhFZ6cXagF7y5cKB8OztOtp-ULa4hzuk6wOBF9zpqy-T4g>
    <xme:XQ94Z1OvUQnyf1PLXZHp7yM54ZiK6oD9mf4t-lIevOVA7EhI8YSfR_AAUTbvhjbtv
    Veg_iYJMb5PpwjP5w>
X-ME-Received: <xmr:XQ94Z4iQMO37MaWBi3AwY2K9mEoUnfPiruZt6-r5UC-LC1vCiq95t9x1JhHqEkloJKmxx-XXNbaNy7uhqPaGORhiwzNb2RWh8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehmrghtthgvohgsrghgnhholhhinhhivddttdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XQ94Zw8myxFbgDBBf_RizCVQ6_mlfWhJskokPBtvRRgvfT1Pbu6GWA>
    <xmx:XQ94Z7tyyGvY-56HgISPb1z0pKD3ik-Rxhokn_7YC21cGWrPhC4ZWg>
    <xmx:XQ94Z_F3t2rhaLalY_wow6Ecr7NNKHbe73hFsShC0wBky5eVyAL4dg>
    <xmx:XQ94ZyMpqkjURf_rx4tSQxfdlmmKWAxAdyN6TkvQ8Y10yV0_s-FiTA>
    <xmx:Xg94ZxXqrQsUmohkRQmHfW0NHksIAODtl-MnT-7QN8gtpL35OBooAVkj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 11:25:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Matteo Bagnolini <matteobagnolini2003@gmail.com>,  git@vger.kernel.org,
  johncai86@gmail.com
Subject: Re: [PATCH v2] t7110: replace `test -f` with `test_path_is_*` helpers
In-Reply-To: <Z3fiREGwXdILl-M1@pks.im> (Patrick Steinhardt's message of "Fri,
	3 Jan 2025 14:12:36 +0100")
References: <Z3fM1bT2Z_0GoD4w@pks.im>
	<20250103130035.79376-1-matteobagnolini2003@gmail.com>
	<Z3fiREGwXdILl-M1@pks.im>
Date: Fri, 03 Jan 2025 08:25:00 -0800
Message-ID: <xmqqfrlzsw4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 03, 2025 at 02:00:35PM +0100, Matteo Bagnolini wrote:
>> From: matteobagnolini <matteobagnolini2003@gmail.com>

This must match the author ident on the Signed-off-by: line.

>> `test -f` and `! test -f` do not provide clear error messages when they fail.
>> To enhance debuggability, use `test_path_is_file` and `test_path_is_missing`,
>> which instead provide more informative error messages.
>> 
>> Note that `! test -f` checks if a path is not a file, while
>> `test_path_is_missing` verifies that a path does not exist. In this specific
>> case the tests are meant to check the absence of the path, making
>> `test_path_is_missing` a valid replacement.
>
> Thanks, this version looks good to me.
>
> Patrick

Thanks for writing, and thanks for reviewing.

