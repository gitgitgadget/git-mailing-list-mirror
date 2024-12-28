Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061BB67F
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735400341; cv=none; b=kxUs/YW7aQlPANFacWrexjGEgG2Gz/zHq0T+mRFYS1qMBa/pQHq/HElAtaJh2czwtbcmRqJhODID51GQJLT7hBi3CA4VKhFJ4+iT1+ekhlq2UhzTSp5wtjcCEn1wUKwCXB9dXYe6wdqQ9Li0zhGG7kN2f/yQZQPnYLqT3MLILrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735400341; c=relaxed/simple;
	bh=/m6HaNmw9C2+Wmj5ssG8Ds2VIHTt3JOH6zT8B1EVX9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdqneg1k9vjMhQPUFTRX1lSEh588mIKaaNu/ydvf38EGVgssXin9u+oK7WdSPLefMa6nmepV955t39H27wKpFuoiTpBPtiZ9RRP4Mv7kw9lFWz+FtBKhTkpx0OXHUWLf5gHitcJQI1TW9skePzLN+QQbK/21VzEG406ZUJYZnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XrqJvh/B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNmw6CIG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XrqJvh/B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNmw6CIG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED30D1140108;
	Sat, 28 Dec 2024 10:38:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 28 Dec 2024 10:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735400337; x=1735486737; bh=CXuttmswko
	eQUAoKnj5XniI0pg+LU0xThfjXMPwWd/0=; b=XrqJvh/BpcWTRKUTavq+KrOAFr
	A/KHmTZTljhV/VYFc55yy58B0UjibIWRUxAgnhb0DXg7s3PITBAGEn8zWuSV2laS
	N7KDPC+Rxupnx+KQSjXKElMfKdUgCXJQ+RsRvw2z3udrjrn2t4SCp2s+W4C/7jtw
	CtVXqyZtyEuUKTFv7NLGsQC+piBS7Z609Xuh8a36t55fs32S6Wqk9MGprafpTJUf
	ZZ6tATZtarTXeTr8MmyCM0h6L5nCc1wbD4C/ov9w2sxnZI8AYzspPXHO5if4frpL
	f2p+qAyBRuffpGpEVJXzfZ4l36i/Pm97lY7/dAirnJjIVgRBSXAhBcvLgNDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735400337; x=1735486737; bh=CXuttmswkoeQUAoKnj5XniI0pg+LU0xThfj
	XMPwWd/0=; b=LNmw6CIGH1Qwb0BIM9BaJmIzXoD57RT30kik/YdEZHxqQy4z3s3
	UXHSAYT9mMyPNBg76x9FAzVie7E/o6JoanNOmF/utomO757vzdibgEuElOaK2Y4l
	YAwYcy5xuFsVNfPmItGsP/KqExGDMA3GEbebwGw/v98phHPSiCMU7t9qgHOUutJO
	/Ha1+8niXYVylitrY+HlC2O+Daa/aSXr8/+KlmkhmbNmAscgVoITHehCJOqLajfT
	reVFA0AhO5uqp65nwz9uWWjBRpk9VN6CGzdOUApX/xVmEQwsNUPYR1N1ZA+OMxZg
	08iFzix7uRsXHcFCkaXEiQDM+zQ92SP7XZQ==
X-ME-Sender: <xms:kRtwZ1x3jVvWVckHCni1RB_0qH8gAzhqrBprB6Kf2u96Vhw_dOVrrA>
    <xme:kRtwZ1SWPi3HNw3ekiN5Gv60c7nZRXQXzZxF5gdbnzP_AXz2X8FTbTa3MJjCNty93
    dlLj-vbstyHQAZqRw>
X-ME-Received: <xmr:kRtwZ_XRheO88qoVcJGhBmCScGPq_SKwLYCabRVKKoXEW4bbiGvYJcW5oNfCAxLYwifjU_aO2gwlurPOCeOw-S2uk1pcYWLTnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvvddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:kRtwZ3jvW2Nlp9IwI--PE9E1t7iFo_4y8In5XjHmqLdpAQXFZsXOGg>
    <xmx:kRtwZ3CKLvaaRDYULLXbiAXiTr9DKLv8PNV6MKgvXiLCqopCGy65WA>
    <xmx:kRtwZwIuWOK7VokzM11p7mYqhW6v4Lg90XVtgVLQrUVj9CXhXcpyzQ>
    <xmx:kRtwZ2D0VjF0cktldDG5SpW47sMImTguCNOyGWj6mDu7loPMDz1fsQ>
    <xmx:kRtwZy-vzqS5e_005HqVwqWNelcO2MiYCHsxazSfK9k9Lhn2rOtDtTJI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 10:38:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
In-Reply-To: <Z2-2dbYVuuLxpNmK@pks.im> (Patrick Steinhardt's message of "Sat,
	28 Dec 2024 09:27:41 +0100")
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
	<xmqqbjwwucvy.fsf@gitster.g> <xmqq7c7kubx8.fsf@gitster.g>
	<xmqqbjww65i1.fsf@gitster.g> <Z2-2dbYVuuLxpNmK@pks.im>
Date: Sat, 28 Dec 2024 07:38:56 -0800
Message-ID: <xmqq1pxr6cmn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Thanks for your fix. I'll have a look at whether I can include a 32 bit
> job into GitLab CI for improved test coverage here so that it does not
> fall on you to fix up things like this going forward.

I noticed it since it failed GitHub actions thing which already has 32-bit
job.

>   - t5616-partial-clone regularly fails on macOS. [1] This seems like a
>     race condition or to me:

I've seen it before as well at GitHub actions side.  Running
"t5616-*.sh --stress" locally on Debian (x86-64) did not help
isolate it very well.

>   - The leak-checking jobs fail quite regularly in t0003 with something
>     that feels like either a race caused by a leak or an issue with the
>     sanitizer itself [2]:

This one I am not aware of.

>   - Windows has been quite flaky since adding it to GitLab CI. No idea
>     whether it's the same for GitHub Actions.

Similar on GitHub CI front.  Not that I am playing favors between
GitHub and GitLab, but for historical reasons I've pushed to the
former myself but not to the latter, so I do not notice breakages on
the latter.


> The thing is, the less reliable it becomes the more likely it is that
> people are simply going to ignore its results.

Indeed.  Also, for macOS and Windows, I have no access to an
environment to let me debug, so it is really up to the platform
stakeholders to see what they can do to help.

Thanks.

