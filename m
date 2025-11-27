Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D15223336
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764274676; cv=none; b=B22iBZ670ituRQSLhenO5osLvjnZxtBT43NgvfDVO5hBJLFXc3fHKXze16kAarUEgx7I3PjWOaQqCk8c8SvNzIGZ2IypFJoqD0yhe12pHULe/mUXg4NxDSNefky1BY9k6ZraMbh797NuYdXzjrAp378lRKK8fUDCCswcmCzRWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764274676; c=relaxed/simple;
	bh=SgIpawRl7cjYWA2+ItHWAR4G6mSwqEuhWU8GaLU29tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DC6WRgFp2Y54pq3fXNyIXBcWRJl6q8cpWvpNCjUhszpXf1vOV61YfS6Gzjqoq93Fc44G5dVNPQyffWLJIxCKA/sYnGqpiEY1chQlQij4UyYVa8EcO6OY6UzRCTEeFrNeWmxaFgeK0Qy9O4xWYo+uw1QBEPtRxPN8GrBYEFE/Pq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MqVAv2QC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w/Jw2h4I; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MqVAv2QC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/Jw2h4I"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C18611D005B6;
	Thu, 27 Nov 2025 15:17:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 27 Nov 2025 15:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764274673;
	 x=1764361073; bh=zWtFyXLakdVxdBQSGjo65O6RC4NabvnnTc6ry5RFuPg=; b=
	MqVAv2QCKzB6T3/2DZBs1+49WsxmfO0fPLhXYNl3Q407yP+7TddWqrcZvzfwiiv9
	ETAdRqT14uIP5KXlFXUuu7JTDjFfX4FN/tf6Nz98fdZe2AwQOJzjisWEkh8JQ5vS
	Tfz2vzW/USsqO+otipNnk3moHyVoqDeihEewT2lfxuhQ6iatuyMHSFutIbSxPmqL
	v5Jk3r6RtQSzs1wDifuQN2SJtWbacNpeVC8cS16WRVEUSqY/xrjjDXp+iKudUL9T
	Z4EJVCT3nioU3i0kjeotT0nZ2UtEjwZw5M4KiMUm8IRDjamc0tHsG00pEsBMevPA
	9BdwWMI69DsOetIIKu61KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764274673; x=
	1764361073; bh=zWtFyXLakdVxdBQSGjo65O6RC4NabvnnTc6ry5RFuPg=; b=w
	/Jw2h4Ilwh29vMzLRPioMf33ihJvW8LT4dMaYRqkgm3GMy0XOt9ceEeqPjrFZS/n
	hx6o8Edi6jDMNVa8+f9yOixeSjHIz6RN9ph5rG6oEW4qUKqHxueoRZkkErzPP4iH
	2ZZ6V/6lHB28tuMEj7isknjAcnHDAH73KK1+e2GKwNO5dBEg7GL6DmSGSfQZpJ9E
	rxp0oztQ4lK+WODXMi5pwvN1ZKMbErNYfhr9Qcp66nt3IUKke9kqFvlpfkUw53hQ
	osCbJPtUTo6uZvD+ZDSHhXoCwpjQqgybA8qjlywjrDlkF5wQF+Ol/RjhsBizJJPm
	XfoN9txR52VWg3MMgy2fw==
X-ME-Sender: <xms:8LEoaeJEMvEb0yra-MFNrQV90hs_rqcQuPhBP8KgVncwsVcexcbqOA>
    <xme:8LEoaQh119-PGCmrnUcLDXdyXQfim6_Kj8fWkV9v04i1hrYnRmSQdaWmS6C3-aobV
    L6X6Cdktotm9A8yyM0iWdPY7tUw5whAFMcxriYiNWwb0Gbv55un>
X-ME-Received: <xmr:8LEoaU2kCGLiwL4gb33z_ruPmz1zbSVOv-D89G_6MShzIM0lpMwobwqQzuf1xO9mF8m-cNKh30eIt6bmvTFrvfe8_9ZlqHpKPJAG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfeduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8bEoaehGrtklZPC8HsRyOYfqkxcDuOT0Uqv80WStOUl1hHzwlPwZkg>
    <xmx:8bEoad-l82SyCjDsYJ2xmrmDfqInAUMdWN_BZVLaGPfx5hhZ7xTynw>
    <xmx:8bEoaSJtAmLp0MtD-fQdMZShNkb1CGHkeKRH2KZHnk-QjCtJIjVGZQ>
    <xmx:8bEoaaxzUGGZQ9O3HVXj9pB82ylONfeW3RYpDYpRFhOT9OHj14Qptw>
    <xmx:8bEoaTmScTIk-smYd6M_eZKz5U-CHHOC4c5MgMXVpMOfFOneRJD7EYFz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 15:17:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  newren@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  karthik.188@gmail.com,  code@khaugsbakk.name,  rybak.a.v@gmail.com,
  jltobler@gmail.com,  toon@iotcl.com,  johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
In-Reply-To: <fa403239-cae3-463b-8c62-8761116ec652@gmail.com> (Siddharth
	Asthana's message of "Fri, 28 Nov 2025 00:51:41 +0530")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
	<27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
	<xmqqcy54mro6.fsf@gitster.g>
	<fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
Date: Thu, 27 Nov 2025 12:17:51 -0800
Message-ID: <xmqqsedzjkls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

>> These are both good workflows with appropriate uses.  To make the
>> tool useful for #2, it needs to be able to allow "I have merged a
>> topic with 7 commits, but the first commit and the fourth commit are
>> faulty and I need to revert them", i.e., not just a range
>
>
> Since replay uses the same rev-list machinery as `git log`, users can 
> already specify disconnected commits:
>
>      git replay --revert <target> <commit1> <commit4>

Ah, OK.

Yes, you can use setup_revisions() command line parsing, intercept
the result of parsing before prepare_revilimit_list() reduces that
to a contiguous set of commits that are reachable from some of the
positive refs and are not reachable from any of the negative ones,
so it certainly is doable.

