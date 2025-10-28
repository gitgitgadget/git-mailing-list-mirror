Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C58225390
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658808; cv=none; b=pYHTypqcGDowaFJqlnYd9yTn3KBchADozrhiloHTkFHESVT7WWmq/80PKfiXt9GewA6M1Uyek3LLhojwjXx8sEiFM2wBS/3iY+ZN9C4yhcBST5Ki72HZ5gKAzupNAjoGu22omqpkKzD3ytJRfd0UbFFWMnydL9nCb3eGF6/fZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658808; c=relaxed/simple;
	bh=9d4SiEsO7LmBlWwhGt47qhy0Zxdd8axlJS+U6Z9m57U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJEVukXeqx+KTpaeYfpa5s9TahKjixYhMGqw0XWcUzzgSE0qmD2gWEpru3V2J6DxP6xY25b0HnqCUNirP9QUjfWpJzA+Fq3ickent6cUGbuSFW5QCfFHxfjRj7NqVyryJGv/RpVc6INUEDnbrPCnbQ98mJkm+qn44EbFxfnzckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c4qhg5oR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1smv9BT3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c4qhg5oR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1smv9BT3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 98943EC051D;
	Tue, 28 Oct 2025 09:40:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 28 Oct 2025 09:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761658804; x=1761745204; bh=+j/M8/wR3I
	eL/ie2pLffdZ//w54gAd+d/FRPX/ndHd0=; b=c4qhg5oR1ZPaKXrw4rjZkQ22S8
	9O9RyroeXNI0THb3vW0lTiIbUiPzioMvQhDAFffujI/zLE8ebfnZDKx4I83P59jX
	7NVUnL2qUiHgAzBCFWkfYpC6ySEcR9S7MtHfi5ooC2pRO/zL8AN+KkkaAZ1CRFwm
	Q7n/EdAgYKSK48IHwYTJgFdbafhZzuq3apy0iajZGFjl85d25qgQt+Y99YAdzlle
	SF3CU8TL6GfzsjLmCoxgORvGGvmPjyHKd9WFVDOamVI0t+ETeFTvgcYEU+VJ8oEI
	7X5iPz1E5B1OIe1KGMdqNGqS2W9p0zL5BNBMEdq+uwaJ5uqTyOahqQUpJksg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761658804; x=1761745204; bh=+j/M8/wR3IeL/ie2pLffdZ//w54gAd+d/FR
	PX/ndHd0=; b=1smv9BT3dlnSR9CUQ8/oN1sO5UIFDSs3ouqbNM6/Z24qY0/KpXd
	brMl1sFeDhWf7x97HOSMLSfHSK1Epf8iiH1wJFecL59Hfap+4gR+P6KfDXoPSiH2
	kvvIgZnhP3U+2BfQ+eNO4OiRU4wP0BcYSK1luOGVdK1DNU9hOri010qMS7zl6Pf8
	AzpZFsSuq8QyklFafH3ikf9Mw3ygUTaM4HAeLBrvXP47oUkkPoErvevhYWg4sgI8
	26RKHy07Gcb006Aoh2wPxUDUJP8X8xXICJsiQwb2hgumxnqhTt3VztpRUJvuFFXH
	B5rqCjk93PDT+tZdOBoEz5bpEw0U9Xx23zQ==
X-ME-Sender: <xms:tMcAaU1NLqwj5OHXN9EnpmrOmE4gcWMnx5AsF0CSBykjyBjfJyikJg>
    <xme:tMcAaWHYVFXSRSUIskHF-liqNexP7E5S0hqG2KX39TD9GXYvg-WKH2-vXOXYh3NKc
    d-iwJb_S1PrbQMsmyQnpCyd5QjSuGVRQeuxWGHVn6wIdXzST_oM>
X-ME-Received: <xmr:tMcAaR5V3ZTsn4KgbH07z4tRri2Fj0R5Lq9PALJw3CGtr8TyUhtUfSE5b6T7RVyMOIt3D4gRy6Fw_iDNL36-uJ5JNbWPuGkjDHnR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeeuffdukeejvefhgeeuhfeiueeggfekuefhffekuedugfettdekleeludff
    ueejnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtqd
    hprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tMcAacs_fpFGcfjDmfueVbtolAy3jv0BW1nCziGXl6IUYygS_T2_sA>
    <xmx:tMcAaS7BduYWTu8t1z7K2Djn6ZFY67oD42L-CU5pX8FwD1IURiRQ7g>
    <xmx:tMcAaXXiHRvgeKOsCSbTndmHij2YiN4gwu9BQnhRC3j1YGhSXQxkhg>
    <xmx:tMcAaU-d9SbIw7kkb70lf31CQKRZMYm0d-5byojS4anp9k8wZ6DWgA>
    <xmx:tMcAae9Jq8HiBR0Bk6KUGsGUJPziV7jRwmg8JYlVFJ9VWQj2_RTm_IMu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 09:40:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.51.2
In-Reply-To: <1MSt8Q-1vhzwk30xy-00Usrn@mail.gmx.net> (Johannes Schindelin's
	message of "Tue, 28 Oct 2025 14:03:34 +0100 (CET)")
References: <1MSt8Q-1vhzwk30xy-00Usrn@mail.gmx.net>
Date: Tue, 28 Oct 2025 06:40:03 -0700
Message-ID: <xmqqzf9bdu18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.51.2 is available from:
>
>     https://gitforwindows.org/
>
> Changes since Git for Windows v2.51.1 (October 17th 2025)
>
> New Features
>
>   * Comes with Git v2.51.2.
>
> Bug Fixes
>
>   * The default credential helper in the portable variant of Git for
>     Windows (credential-helper-selector) is now high DPI aware.

Thanks.

> Git-2.51.2-64-bit.exe | ebd318e1d3ee0cc1ac8ead026f1edf8678dcb42c7d74d757b8e2fa8a1be0b25f
> Git-2.51.2-arm64.exe | cfa59dc9ca121844a9346224e856ee11916ebd606b211d4291f8b97aa482dd94
> PortableGit-2.51.2-64-bit.7z.exe | f5764d546ff9a2511b50ec4e20424c5f4669de1695abc3fa4128e7f7d4a7b2cd
> PortableGit-2.51.2-arm64.7z.exe | 73375f4278c84611e788b2adb604fb98213bc8f0accecf3d5d5800748c6fa32e
> MinGit-2.51.2-64-bit.zip | 8f0a7bc389c0bccc9daf6107cff4efb176348e34b8d787f02a36679a5588e072
> MinGit-2.51.2-arm64.zip | a050e17fedb2e5e8025850194c1e43df1b5f96ec93b0f43c99f43d7fc4da7da7
> MinGit-2.51.2-32-bit.zip | 7ccaecf25ad5bcdacd50a162b8de798638dda1c0fc4f4893bbd90867a8a57279
> MinGit-2.51.2-busybox-64-bit.zip | 7c85f2cd62453ff24eb5c7c466152b3e5882255f744284518216a76876e02923
> MinGit-2.51.2-busybox-32-bit.zip | efd750af9855ad3ad32e268cd7590557a45fd1b0917367687e7c8181eec046b7
> Git-2.51.2-64-bit.tar.bz2 | 79b257dd677ed2c18bec0b5357fcd68cdd6cfa32bce4d379ad06e32a15a4b31f
> Git-2.51.2-arm64.tar.bz2 | cb119217e363cbcb6d8acc94d1c4b23b3ce8a603ec6a633675c853cfc16d2452
>
> Ciao,
> Johannes
