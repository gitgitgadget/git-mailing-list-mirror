Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AA283C93
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763236407; cv=none; b=WoZPy9jwpHrGX+lZz1O1p8vl/iI4wq/4kID84Py1NePwFJ3ytoE/157qqTKkkp1/RrF92jM0E4mEfktsEC5+m2iPXFPfMYeBJ8V0ucfLpKGuWGYvT1EJouC4JRElAkZ3pOaxyU72zHuqafdxtmZ1HuP+oEbmS0Vsp/7wx5MPims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763236407; c=relaxed/simple;
	bh=otSqakvm1s7QUce5i+iYatgR7Tecr8Zc+QbYzFNwYGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T61QrYwaUhOpbI1f+HclbPYiBNvJHAibdOq4iVJpvH56zx2Y0y6FLQHMKb2rfdnZmPu0ld1hyARexNAxjysadMIHIbyQpmkuo3/QwTXQL7lF6KYhuHfxlJQwHhPjEjKLld/tY/Qh6KSsWoKwf35fPX5hkWwE4S1LEPCKYLdC0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a8EYHSuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8/JSgMH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a8EYHSuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8/JSgMH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 827857A00F8;
	Sat, 15 Nov 2025 14:53:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 15 Nov 2025 14:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763236404; x=1763322804; bh=csdB+wD7e9
	wbJ0c36bDcPv6J/BDwl6ErXr1EiXA1cC8=; b=a8EYHSuEktgb2QAssofeMNTUdR
	1dV3LDvTGuxg/9yzBDDN5jdTWSKCIuU6kUZF+Sqjj6tiz4Kc04NSBqi04G+DoFAe
	yN9ZlS/kdTel8K93jC5WGPDgGy7zg7YicJTI1E3KBJQRf81pAh7mpypHixttQJf7
	QO5b2t7Cp4b3lzM7G/7u0PmDbdWqV6Vnk1BELV/CYbe3NDG/uH1DGPRE6L72Gglu
	LY96qTrfTIkHKsqm0znps4C+P4RLmc/f9HoXVVgQmSdgJr3hu5rkm+UnytvqX0CE
	HtN9e60c11kvX/T1zZJKxT1RSXC4i16b9T3ZGQ4SZaU/gPtvk49nrn8MhnBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763236404; x=1763322804; bh=csdB+wD7e9wbJ0c36bDcPv6J/BDwl6ErXr1
	EiXA1cC8=; b=e8/JSgMHb8PRGhXXRl/b3Gr0KNTbhNfvC8cAvgVCVT/+DbtBNJX
	uzBWaE/R8Wtk72f1h9/a5XSxVxTjkwz6rPuCeauiUs1n+h5ZG41lEuHB6qAwOUzY
	EE77SMlVkIeN+iN+vv1rPhvgSj1756PtrTMnVh+0hORuPocViOY++ydoHEr/mq9A
	IWrFNTFCqAUYA5GFbXBDxzmjpAFTbF5JeAVksIRMN+l8JfLCzMCKqSieozcUfinM
	w/VuzleofzuscQs0D1rzam84eM98vdpkKitauwBmKJqxz09VtuBoSYCps8G6soIq
	hw4BK7YvRZQkvM1Q6PnFzqKf16dAb2xa13Q==
X-ME-Sender: <xms:M9oYad5rJq8147SPyeHGpcelONJ_1-cnFL49IllEsjiyHsSHcso2Jw>
    <xme:M9oYaemiXgSuYdkFFOWZNlUrnvIvoQH_HYK6jpet3oZhxHERHU3YBGZOMVusorJ4_
    YjBSmBpprhn86uPH-tYzNmv8CL0Fe6cd1JdET0Lsu5gsNoxoi9p>
X-ME-Received: <xmr:M9oYaeQNOGjHe3Cuc7OKoxhxn8b2xqrMSjGDlEAFEkUvCPkwSOHNvDL7pJxA7g4AhefuJishILe1_K3DdNCmJOlL8DJN_cG99w-9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhifihhltghkse
    hsuhhsvgdrtghomhdprhgtphhtthhopegrughrihgrnhesshhushgvrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NNoYadExdiayBjhs_tB3NSzCHAhlIBzTyhxFE8ETZ_OF0-hCT_OrUA>
    <xmx:NNoYaTHLNiIGC2Baf0o3mw_7QdgqNeCJ2vL3Yd2jaBj2cxZOHOpyxw>
    <xmx:NNoYabSoPipdQATyk89b_qxWY-d0KXasAzjCsn0k4GPkjOKvKfX03Q>
    <xmx:NNoYaUIDOPTJl-5RTnKcujJZpJYxm5Z3LVYmw8hk3H4IgLe00sEJFA>
    <xmx:NNoYaSUMV-xdlsY1oyAatHIcO5YpWqXKxbhoXSEzhtKpIdQPMDW9dwrK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 14:53:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>,  Martin Wilck
 <mwilck@suse.com>,  Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH v2 1/2] object-file: disallow adding submodules of
 different hash algo
In-Reply-To: <20251115005818.2271557-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 15 Nov 2025 00:58:17 +0000")
References: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
	<20251115005818.2271557-1-sandals@crustytoothpaste.net>
Date: Sat, 15 Nov 2025 11:53:22 -0800
Message-ID: <xmqqy0o7dqdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  object-file.c              |  6 +++++-
>  t/t3700-add.sh             | 25 +++++++++++++++++++++++++
>  t/t7400-submodule-basic.sh | 25 +++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)

Updated test reads much nicer.  Thanks for updating them.
