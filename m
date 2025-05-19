Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E5289E1B
	for <git@vger.kernel.org>; Mon, 19 May 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677279; cv=none; b=Iwt03DhlRJUAHHDCQxsJeFV6WEhOHVbtrEFQe5u2GIFFQNRv2d13nomeUUF4BwazEMi7wLBgX0Mo7cIgtPoNXBlhA37KcN67syQVDQZrVg5j3sp4e9awuSGfel5ulcKbr23siAR0sLTBtgbEhqmSIt33wIDURtzBB84IsJ0w5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677279; c=relaxed/simple;
	bh=EUVuibu6oMbctlgBrY6Gna56J2PE3r7JHAuG3w1EgDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XvSFG5GrRbkLZJKmJDtkbGtT60kbJWI7dsqMmFvTtOnx+iYP6iaqtKaQt0eCk5QoBjClm2Id5gJ3/QcBSV+UzknLBYKIiQavjOwAoXmp23cLMtCoVptCz2m6g+BQ8gC2oGzt3IA8HPY9T0pMekBudkGxV29C+SsgaAHpFDMQhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ApipyWjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1JUpmXa; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ApipyWjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1JUpmXa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A940D1140156;
	Mon, 19 May 2025 13:54:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 19 May 2025 13:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747677275; x=1747763675; bh=4GyJhlEsJq
	1tV3KDyCZbgACMpgrMIAMXoCTCzI0Ecfo=; b=ApipyWjXnMgtZx59C0ak85PQyC
	DBaaU+Z+FI2YsqmRmBLIl6OFs93XmcbBg+Zjh4UfcgvzXNTUKZFPVTzd2mLzfWlp
	nlTTNxrBCPxP8i7Unj5k7ke38kr1arZSXV9l1TdGAR2TC9JrJixEDGA53XYGB0i1
	wOW6W64nppXHHjMhlVpofHICNB3oCiJdMFEA0i8C+F8ymdsnYwab5l7zqHed+6bK
	tCSTTYGbLIKGoJhwmMFc50925xLQ973p3vkw3djW3tjbePk5/l0QTVKaMpfDv4JW
	9zF9kvxJQGxTGKdCvjzD313ZrkUh0P3GW5uNzChLOptppkOED+bsuADHrLbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747677275; x=1747763675; bh=4GyJhlEsJq1tV3KDyCZbgACMpgrMIAMXoCT
	CzI0Ecfo=; b=L1JUpmXaMNR3he7OqSCOlUfHRtIuZHqPQeO9Qh34+RE7F15nCg6
	N7Y7NcyNEmCwm1CIo5wCx9jPu9tWGrvGd148dmQO3jetyI5BHTvYrpENxlWSghri
	QdNs+fKML9TBQg2DR12+3r6MOoQEbS35wG05mvrO3uFHXgec8QiOvcqBKDbxqfvt
	AzypOBnYCg5ZZknFSqHtuyleuGm7dmjvu+lyKUGHG66IAIYwkj9F05tYtzsZ69WM
	qPq3Beygu0h2kejJtRUvDRtv7HDbpxSiXgQbclNXE/uyZhlxZzxyVRF1Cms8ve6X
	GhTj09muxZv1rk4uvVuqNtHowSlP9P6kXaw==
X-ME-Sender: <xms:W3AraIFOVdJB7Pigy0xudvTm7s3Zcbw5BhH0glIJ7ujwcJo4orFmSA>
    <xme:W3AraBVvvLc3aZShwYHPetXFoHNLvmpuNI4awFp_5oRfYNHKL-NI1Iak1lrhe2xLy
    mAI9nYsrFP-ctNJ0g>
X-ME-Received: <xmr:W3AraCKCxBucn5DLLhz786scgndxi5WPXvgywlk0sgu08kcQR5bAoBTvjoasXzJDrxQNftLdhFwtCcSJbGz-AQdwIbxzNExwfGEB_kY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrshgrmhhufhhfih
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:W3AraKFg0RdasaTpQYwp8fIEEnTMs8qa8fnp2v0hVBZHz-pdRJydfQ>
    <xmx:W3AraOWOpi8sReCQEb9rKb9Rf2_Nz8NdFPgZMBnC90RMb4ilxqLGWw>
    <xmx:W3AraNMxT8BQAk6qiU0eU0HA1r_-OS9nu7NBmqiDlHSThjjqHWhnoA>
    <xmx:W3AraF1anWM6VvgFr0F3bnJXEkJyHOndbmfABvNkeXMvsXv6comq_g>
    <xmx:W3AraOpLbGwqsr5o8Sd8vnViXy14ChEMO1mxF_Qfb7vbAS4p_69f5tXl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 13:54:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  nasamuffin@google.com
Subject: Re: [PATCH v4 0/3] Update MyFirstContribution.adoc to follow modern
 practices
In-Reply-To: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 18 May 2025 13:13:14 +0530")
References: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 19 May 2025 10:54:33 -0700
Message-ID: <xmqq8qmso59i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The following changes are made to MyFirstContribution.adoc 
> to make the tutorial follow modern git practices.
>
> The tutorial codes actually help newbies like myself to actually know what is going on 
> in the source code as the Git source code is vast.
>
> Therefore these patches.
>
> K Jayatheerth (3):
>   docs: remove unused mentoring mailing list reference
>   docs: clarify cmd_psuh signature and explain UNUSED macro
>   docs: replace git_config to repo_config
>
>  Documentation/MyFirstContribution.adoc | 55 +++++++++++++++-----------
>  1 file changed, 33 insertions(+), 22 deletions(-)

Looking much better.  Will queue.

Thanks.
