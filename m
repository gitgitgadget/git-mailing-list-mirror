Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B62EB847
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738208; cv=none; b=eqSkdG3y+WTLVORgYpQIKmIsi95RlNyqW75e//Iqkumeg6DwitrafJykxOySyqsYVW//Ja1OsapqL7I/oys3xqx2Qu8cYQUvel+qV7vfIp1wNiyAy0NndTGI3wqNv2R0IpONPNPIwS61KXgSUOWhTvBNTwnYca4acs5e3cUUaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738208; c=relaxed/simple;
	bh=fMrYpCyUS3DwYMT7KKehv2OBu2gFVrM6Hr0AsS8OYj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Enxgg2iPGYitt4prTIpLtDKNXnsTgVpbLvjubgxqjqyGIPbeAgllAtOTmqAEBrocf4J/zFEs+GqNLy/IzKYT9kN6I8Bkrh95jMdHPFoUNaWU5NVi7MoB/RUGREjgC7KdeWhgcbqzhYiUUdTAaE6H74emk+al3jY8y8UIIv6YLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QNC5ylN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jcIhWzi/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNC5ylN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcIhWzi/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 452C2EC04F0;
	Tue, 10 Feb 2026 10:43:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 10:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770738206; x=1770824606; bh=tSM1CfuHSG
	1wWya5VbireULK+8ykVb8xEW+ei2BCFF8=; b=QNC5ylN8c/7XpSYf7+pcbkSPLM
	C4RE0fQHO7GlCXsMLJyPtGCAKV99wR8hgIRxrKT+Mg1s/BHRreDg9dfOGjYGdqJf
	cSQbOLqmaZu6A/y/BYxwpsdRffdH7y3gOey0q63AutjMmKt9p9XhOGj7YdoQ8PmN
	lVebcJGYxXB2rOUmNfgt04tX92H7wczTghjSbgnt52v1MSOmi14cWO+FRjOCQmkZ
	C4o4qgZ8kIGMDxDF+A6/QDuwaag2L6te9kzTFc9iVLAgUY03aoxDY3fBHrD2IGwZ
	qZiFCIJVjDUfgNGBwNvIOqBjuo1I/Q46jWb0eRNULcSGwMNr6hn1OEuKRUoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770738206; x=1770824606; bh=tSM1CfuHSG1wWya5VbireULK+8ykVb8xEW+
	ei2BCFF8=; b=jcIhWzi/dLfNPR7s1+elCbghbTkBYgi5GaZw9HrG10txMu80LzM
	F13eP4/RsPuMdopFKfbS3F7PDy31YFAZQ2vrhNHGUoLDS5+ea0U3atoLBFqvA1jB
	ZMKNvUCqbiGloWH/WRlXNGqtBCGHUGHecDNJ2jaHhtjDUtmUUU/eMLhsga578zkE
	grfR7QHqkjMTcP+OG0FK3umaa/NqiXxbHSGQZAxoIGCOjfo+S2WZxWJl01ChQnxw
	H/dEYCB8B7u0UVxNm03PRZ65dj6aLP+NInKIPV1P8T0lH7iixarHMyLVdcZi/IbS
	rA2mbd39w3+ji4Rp19ieS4LVSHY6/EXlM0w==
X-ME-Sender: <xms:HVKLaSM9I4T8_zvx7jZp90cbc5PTlJeLLVIVECKiV6Fa5hNrNyhbMQ>
    <xme:HVKLaX1gX73X6E1zXluAux3N2LiEfagREt3d1ZreuAYJSQy1B31HOO4OnQWGTLc9_
    M5M0EY362gzhyAsYVzKgPt76QOB2pp05T4gSkCb7QMZ-xq5w_enqA>
X-ME-Received: <xmr:HVKLaRn2mk5KNZHj0bBEnj5GTbAZdGHiInVu585fq1IAxAgcJMeZfssUhsxtzvU-H84TZtajMvu48Od_AcBaDWQGqKOhEJQEIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehtsghovg
    hgihesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HVKLaeVowsOso0_4Qp0MBB3ewCvMljYkJ9DP-GI_cCELyCm0rpQJxg>
    <xmx:HVKLaXskNoKBfeffeWlUeU1QA4CW3pm6jrtltzO_5JVPqMRW9GDe8g>
    <xmx:HVKLaRZkNGULTMfpwLv4stf0B38vW6jLeIduQ2ubg7vqUhbo8lIdJg>
    <xmx:HVKLaWWpu9d5k7hOAjBt5y4SlPowKtdSwQl_I0W5tvQxFE6QDttdUw>
    <xmx:HlKLaQe1_S3tG1Fsa54QArhbpJWY02fEm3gmXwU82lZ4Hof3nUwYB3Aw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 10:43:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] t4xxx: don't use iconv(1) without ICONV prereq
In-Reply-To: <aYs8zajWSixG8i3c@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Feb 2026 15:12:29 +0100")
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
	<20260209-b4-pks-ci-msvc-iconv-fixes-v1-1-1e3167cd8828@pks.im>
	<xmqq4inp6bup.fsf@gitster.g> <20260210111401.GA27953@tb-raspi4>
	<aYs8zajWSixG8i3c@pks.im>
Date: Tue, 10 Feb 2026 07:43:24 -0800
Message-ID: <xmqq7bsk1u5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> But even if the iconv binary were to come back I think it's somewhat
> sensible to assume that the iconv(1) binary may not exist when built
> with NO_ICONV. There might for example be platforms out there that have
> no iconv support at all, and the patches in this series would help
> those.

Makes sense.  Thanks.
