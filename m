Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B13BF68E
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094569; cv=none; b=XfAl7+tPgmFzx2N5TsWTyALz8NeI9fb1/bN6LDgcuRrci0i68skuW0mkly0yqSihB02YMosJxtpZeD1Tax8n0g1JxD3JCQOQQVU7TcoO2xznmM1MSBBpYzYiE4mRfazaOUK5+mbXptq5I4rupY/5WIWL2Xf9sSRQhfEEboauc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094569; c=relaxed/simple;
	bh=i9J9J/bfEyw/DTYF0CDN+3bIlD17HZ8tVep2sg6Qf4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfU6TPChRVMfKOXDmTZed8iAZE4zigPp8IUk9WySZ7vny2r/bSsnj8O0ag5nR0/AUyedRZELry66boE2qiutETyXRjFt3YkqDdzNIfbw9pfcKySFIFHdJ1cPa3v8awI2ayFSNzHQACLg4Q2wXlREW+NJa/Iyua/yiKw10+VxIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aQ6IkdIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlhRWDpO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aQ6IkdIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlhRWDpO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 132797A0227;
	Mon, 13 Apr 2026 11:36:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 11:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776094566; x=1776180966; bh=p64fizCB5F
	Vc3Rvufb7+DIzD3flBLOOfgSuJocON4bA=; b=aQ6IkdIa/pi17roxCKwPp6UaqQ
	vyFeVUisw+kS9XJ6wuwz+g3nG1dckujpBRBvNp/fR76zdExNL7M+bGtVIHPLmcFR
	oybXB7jTyyqp6A4njGQPSoJkgz5PCmivec8tY5o1SvhRV96fdAeJxuNjDs90T8Fe
	Stp5kE/4ARhgar03CcSsIvrbho2VpwGinhPAMUqk6yH8qZfR0b/txEbJH2NgrfmZ
	eNbPR7VqiGMGrkGh4ZMrsJX9TGlyHxVDm+2ALiwfJy0jX8i8q/pDHPlNK9nhdZLS
	Xk2/DkpPRv7Jv2X+Uh5NvAcsw3nW8PuBlM8lI7i7fwLntiKTXPaynzIFC+Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776094566; x=1776180966; bh=p64fizCB5FVc3Rvufb7+DIzD3flBLOOfgSu
	JocON4bA=; b=HlhRWDpORbcw+WeR6gFp1gl+ax0aU/0JeRHSymO6GqMS+lt3IH4
	ZwNy0CllPQBuk4PdU5YPEAbICp9/JQIdf58LTjri/Q44lozVSvv1kEPOxMZoshZf
	MdQ4nbZ0WoBnK0KwPjXQJfEvkREmuK6Q06vHvB12hvh+xNwvy85kbJD/k0EBJdtj
	AsvdKYwXV36Z0NXmejvSE8b1bhf9TQd+1GfzGPz3mJwftFMymRZdpup7zjvDur4M
	8Cd7S/GTcDxsOPvJIGUJuJiDgWBuMnAu2YK8/bLWHuPSAwuA2nKOMMt3gm30wPOB
	sIu8SnF8PacG1vrUscGlTmRXw+rkKCG5fmQ==
X-ME-Sender: <xms:Zg3daZAewZf7HKVajfwu7BQE0opA5fsKF72QflTgAlVQrpXc_ahCNw>
    <xme:Zg3daegjno5Bp6PqdBtlLgRt1gNWYEGNIt1Al5dN2dO5B2cJShxd5MYzd3jz8DTZD
    Li4UQJFmjBGpQDIYAw4j0HNap2ePnwkCgQcGGzzhDgRUDyCnD7VRw>
X-ME-Received: <xmr:Zg3daZnHYYXph8ZA9SlShadmzHo0XFMFsMo2saANHiVadr5EYCS1Tve-6hLtBdEMZrr77c1Oe_lXVml7RsHEGd3N20YMAobaBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Zg3daSqAISypk-_2dCRDI2oCQX00wV8MAAgf37SVX9JDDRwTWhZgYg>
    <xmx:Zg3daaGDYiOk86ovxhJMjdrayDPegFSnBjIXvZ6A1ywlpBZCoMO9zA>
    <xmx:Zg3daWz_NtghYKf1EKDZe7-PxXywsBY61IoSZWAqqBMYEPhNVjjeVg>
    <xmx:Zg3daXrcYCBO0zqZR1JY2Hk7woATQLfAz_Fix-u5HNupC7x0Uebn_g>
    <xmx:Zg3daREH-Ke7PEQD0j0a1MCdydePcOeyRgUcT7tZvrww6tw352FGk4HX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 11:36:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 03/18] setup: stop using `the_repository` in
 `is_inside_git_dir()`
In-Reply-To: <adyDiEW0-wRlgp6E@pks.im> (Patrick Steinhardt's message of "Mon,
	13 Apr 2026 07:47:52 +0200")
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
	<20260330-pks-setup-wo-the-repository-v1-3-0d2e822837aa@pks.im>
	<CAOLa=ZS-bHiG0wyjwfzSbX4TgC_Jfpk2NXHAf=dUm6CvVxx80Q@mail.gmail.com>
	<adyDiEW0-wRlgp6E@pks.im>
Date: Mon, 13 Apr 2026 08:36:04 -0700
Message-ID: <xmqqa4v6lvob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I agree that they don't really make a ton of sense in "setup.c". In
> general, I would love to split up that file into two pieces:
>
>   - The pieces required to detect a repository and discover its exact
>     configuration. So scanning the current working directory and its
>     parent directories, paying attention to environment variables, and
>     detecting the repository format.
>
>   - The pieces required to configure the repository based on the
>     findings.

This sounds like a good direction to go.  We the current structure,
if you are handed two local directories and told that they are
subdirectories of two repositories, it is hard to do the necessary
two discoveries independently.

