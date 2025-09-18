Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6002D3EE1
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220939; cv=none; b=NL/ZwwhhG44rcT+yjOrXEpi7ku6CU1v5ceG4E4eFCXnThmaW5y7Pk9fDLSHLdzFhTazQQjvdjH/RkPJvosM7axcB4ziDlLtT73gzLZNIkp2GDSzFu66pvkD548Gq1z0L3w54sekeVgfjOqGBes+mhZ0EdGo5N7GE4L8pFyhVhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220939; c=relaxed/simple;
	bh=3jY3SAuUtea7oF6p5/RsZm6O6dP5+3EfpVyXFRJRGUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOl3FcfvetkQbI6AHKZ2uuyfq7XNKuOFEY9utsrmDn7P9Qqd0FQfcvhyix3NaOtRwCrBAnpJDg+eu/o5BLhnPtoCMb7+JJRstu8BHvStgf4aBMTjkxxQYhN1rvBlz/paGXPKTur2TPj+qxDutGLy2uR7e2yM//yQlpH/LVf3dTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rFMf2TeE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBV3/A4n; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rFMf2TeE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBV3/A4n"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 96C26EC0022;
	Thu, 18 Sep 2025 14:42:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 14:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758220935; x=1758307335; bh=gqBWQW/xXv
	LEzjd+MVpsbsuQvUOZrril0EvIV02oyeQ=; b=rFMf2TeE/QNZWD05YidHdpeXrc
	lShIq6ir/1hkMs5/nZKvBRDVQjFxIO/j4tUG8ElyxjYdk5U4Dpv6jWd5ADcuQpkL
	0+1S1yGU3kzI0iUK5q51BQhRz4HQUbTD1Mb7XapP63IPOWXxSgOEF9zPklaoq7km
	G7kpqNH0TPKzyRngxpIDh7bxykMt1CD/buDcLqox+8IO1VapwVNojAks6Rl8wpbl
	ms1hNvZ0/5YrjdqUNVTqa7P/dHagkkDDYY4HkT8s0mIFlvlFCxb9tcYBough0dFh
	7MNDApson8fl7pNUktlz2OF//q4agn3dD8Oz3VSSQJ371AQspcupJik5FaHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758220935; x=1758307335; bh=gqBWQW/xXvLEzjd+MVpsbsuQvUOZrril0Ev
	IV02oyeQ=; b=SBV3/A4nihkvflsfw6ecnMHYx90Stw2Vu0EQAvRDFCt1fcHgrJ1
	Y37D59AQTF373ko5RjNlZF/6+JhBYhSed57ql1o/wLZy9v4xw8kKf2t2jVzK8TXP
	gLARZDnnQoR+vqcY9w6sGwyIwwOe5kN++VnoDc81Ci4nxDq4dwEttmbgZ8Dfpcow
	CJo7i4yYcXIVm1JFdjub7wkDZm8k7cF9NrAPmaI1U1uH8qVMcMHLCTl9we79v/F6
	S5R1JAoRIgow2jMc57oGsMV6uc4qA+5UJOnIcUJBGqlUttJw2DTsDANc9p/KuXVO
	37tKNn1zFyDRWVWeXKkxJtkYefa10SU0Qvw==
X-ME-Sender: <xms:h1LMaFAYdUNVyuFLlUP2iE-Zftf9yYI9HFWZbdYK-ydQgeOsOzccJg>
    <xme:h1LMaL-UNv-DwvPq2FdpUkhC8lyZ3OmFY0f-vWqB3u3IgrPpAdUJ1YHHFnuXM0ssv
    ayUpulVJhamOXGq4g>
X-ME-Received: <xmr:h1LMaBBf4lkak3akl4uILv73JkKWfcStjimuF-31W-IX9kkNKUrp9f6Dk0A0yi23u5cqlB5faUaI2r5r7J44QPXCtLFT6YMCu-p6c3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehhuhgrnhhgshgvnhefieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h1LMaASpAJA25WOsyJuohaK6-MgBt_MtwloDshkE5VpxqNGlSa-nHw>
    <xmx:h1LMaIutAb-qcmuMrqAkyX4PLfAGx6VD5bxIFoJknOLZrHpb0ySYrA>
    <xmx:h1LMaM08zmnXZWCkI1s4a2QVEnqS9QWoNi2c3nt6rV9VQLMdyzOKuQ>
    <xmx:h1LMaJUVOikb4jHm4obbkh0K5MvsPmPPD0Zt9j4w5nx_oCIf_EZeBQ>
    <xmx:h1LMaGi-lqhuen9VePPKGBF3d4zcfj-umVmOoV4mEvBjLTdazwjsDK_e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 14:42:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/4] initial branch: give hints after switching the
 default name
In-Reply-To: <5629352c-2505-4254-8d47-d63f3430ceff@gmail.com> (Phillip Wood's
	message of "Thu, 18 Sep 2025 16:06:28 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
	<xmqqikhhdpd7.fsf_-_@gitster.g>
	<5629352c-2505-4254-8d47-d63f3430ceff@gmail.com>
X-Gnus-Delayed: Thu, 18 Sep 2025 12:23:32 -0700
Date: Thu, 18 Sep 2025 11:42:13 -0700
Message-ID: <xmqq1po38uwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   * With simplified tests, thanks to Phillip's help.
>
> This looks good. The only thing I wondered about was whether we should
> keep
>
> -test_expect_success !WITH_BREAKING_CHANGES 'advice on unconfigured init.defaultBranch' '
> +test_expect_success 'advice on unconfigured init.defaultBranch' '
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
>  		init unconfigured-default-branch-name 2>err &&
>
> in t0001-init.sh from the previous version as we're still printing some
> advice.

I was a bit over-eager to revert the changes to the tests.  I agree
that we should make sure that we have the hint message even after
3.0, so we should drop the prerequisite there.

Thanks for spotting.

