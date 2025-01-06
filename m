Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D61DE8B4
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184565; cv=none; b=PIroWdp7+kPBdQXnDc+2rKQ4QXzQ0wxlM2K5sTeB6WvOvy8czJWTJfCFlvY4XvZoZK4sHrYVvbL1xEbvNTR3hrrLa/TS/FvsnVzgI1UrzbzPBpwvQRNtgvFAwhq6o2FSVjhQdN9SzrEcGS7aJaRZ5+/GQ3wQpUNAfMpAhzGCC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184565; c=relaxed/simple;
	bh=blyHKGldSL3GBKnWcT+ATDBcMNiSwG/GOxBZ1UNXvAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ul40VbbMu46HNI+MPx145oDomQ9CPsF+XXI+jvW7oqe7zSFaQ1Czm6ATTZG7yXcR3gLDoIkwim0dewVeNCzMwmFutCLgeCeFiRtP4V0LJurXKyIx9aQ07iOBSm5LIEf3vkIhJa2hVDsuexPyvZYPbPN93vWpi/eTNNiY8ddHm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rCnjbuiE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNHPUStx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rCnjbuiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNHPUStx"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B28C3114017D;
	Mon,  6 Jan 2025 12:29:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 12:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736184562; x=1736270962; bh=Np0wsbvmIE
	nsX5oMhbdb/cv/2y+SYslwZXY8xe1Cx2s=; b=rCnjbuiEeYIm6UoVV1CCTgPCzt
	90S7pLWuShCSeskynCDfa7fInLMJCxRvI41R79tsHiTNOUDftSYTWGJ3Ot7tRGrZ
	exlAL8P39PsTD58fVATP8NNj13G+/oETO28aCCbkiC30YPfx8BD5yfx70qa+e3yC
	yFAOUi8Qn6SKBqwDeOuKJ0fF8XGw5nErjsK0KAtRavvZojOKIAfOl7otMeH+hHnw
	hNk187YQXz+2gD6X+vkG1ssnps4i/sWHIWFOI8LL7DMzXAYnkTn8UGdZjsjsM/EC
	yecBnfLezGjdVVV1/EbV/FxW7JbUeOaQluFUs9rA2Gg/XrPaPU5ibKJGTPsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736184562; x=1736270962; bh=Np0wsbvmIEnsX5oMhbdb/cv/2y+SYslwZXY
	8xe1Cx2s=; b=lNHPUStxNJ2vHADM/v01PvSk8lAZ8adBTQIhjAB88JVnt5SYmne
	CP7V5U1Yl2RjPny2saq1WEDmnSB2kpcUTtqIfUsg3ZTVYks6HaVVLwxaeq7reVWe
	JveRBS2ZjBklU6EWBnY243d1Ql55FA290sr9GAeRkLQOf1e1+7JdYxFAkBUyhDQ4
	gK29Q2HBaELT0fNtij9ysraWSHDRf4vrQ7VkcqAWC6HQGczYMLWGzUBo36DgCjz2
	5/t6gOOlb4oFqo2gGLAzvp4Dh1GiUbp1xoiJyEBXiCydkaTiqR6nhLDl2H1CXW84
	W8Q7+I1eElAgvnN7ACKX8NW8jdy4Irh7eCA==
X-ME-Sender: <xms:8hJ8Z6OmfNy04fA_dHdh_4qH7-lsBvjJdjyG3zRBJgEplIFz5m2TCQ>
    <xme:8hJ8Z4-BAx8Chobpe2xFXtnfrde5n-4kGJLVrENW4o-tTP0P5gZZ_VGGtqw2v-X6O
    twFDO6UpDodh4Y40A>
X-ME-Received: <xmr:8hJ8ZxT8GMSdYUEC5CXhu3wL_4DXSeaC4yNKGq4Qd_0ZtD_EtLwc2zf3sf-Fj7Myy6zTygUDrXPbQPn5qRwXSXl_09rGIRAci5AW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:8hJ8Z6u4cPB4J8LywqmZ-JWuDaa92QYEz3SfsPS89b76-DVO4LWI4A>
    <xmx:8hJ8ZycH0Gmtb2Ht7hYaxUe2RjCMPAMR8pKd8jKOw3LMo4JBHD2OZA>
    <xmx:8hJ8Z-2x2t64rkp4y8pH_8LU-eiK-tYswcOAy9UX-_CuuKipdIoC3Q>
    <xmx:8hJ8Z29BEl7ond7UTIRDgr9CWG0R3Iq3_DTiZfeJ6uuKWyPVlGkZuQ>
    <xmx:8hJ8Z_G5nWLvpLig1abczCA7ejajV3QYFDRw4by2AgcWt80C7CCEi1pk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 12:29:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
In-Reply-To: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 04 Jan 2025 00:17:48
	+0000")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
Date: Mon, 06 Jan 2025 09:29:20 -0800
Message-ID: <xmqqbjwjzw9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Maintainer note: these bugs both date back to 2006; neither is a regression
> in this cycle.

While I was preparing today's -rc2 release, I noticed that this
change broke some of my release scripts with

    $ git rev-parse --verify v2.48.0-rc2-161-g6c2274cdbc^0
    fatal: Needed a single revision

which is the construct that has been there almost forever.  Its
expected output is

    $ git rev-parse --verify v2.48.0-rc2-161-g6c2274cdbc^0
    6c2274cdbca14b7eb70fb182ffac80bf6950e137

The series seems to need a bit more work.

Thanks.
