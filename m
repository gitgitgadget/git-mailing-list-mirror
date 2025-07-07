Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58E286D7F
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908188; cv=none; b=lLHogiCOvUGeduwI4Dn2qWk8xU3W1hr1x+RDhMZc5y1umj94Qz4UDo2MPtHlmxHUG+XcIUYRSqIXucEWM9Yllj9lvAv8mhQymynr26NYiCjV+d9CKP2BPhc5MBYdVG3LH2OZ6wIARs/9DilBVQ0wmb0Lksv1cJ8sBvscplvFuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908188; c=relaxed/simple;
	bh=9V6BXfNMMunppb1RHIOYFvmChdS718CsZ1tUIQngPS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9lrH2v9i5fU6FOqOIm4xz5fn1IfuVQ3j2mgjlEHrpj6KoZkD178K7CqPvRVlVjtTfQtvV+JSf25ajvuHd8ySZ/aOei5rzKTRYFeCkkz4u43GOrCxDwDgE04ctdoPOdczPIGSs5BuEC4T9L3PLLsfPzdEmJ2+K3cjxnNx962W0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J5vFUxaz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Th1aIeNY; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5vFUxaz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Th1aIeNY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F00D7A0070;
	Mon,  7 Jul 2025 13:09:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 07 Jul 2025 13:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751908185;
	 x=1751994585; bh=Z7p3bdD4T+iY93/6rf6Iy6dsajGrvgc6auwLiucv9vQ=; b=
	J5vFUxazS4N2nML0UdZWSKynfkMetUCE6VEs9TJwxxrAVWfhYH07QN8wejV8IAUd
	0ShdlAhhH7DIhSuPVH15MZNpI7jPOYRdq1epqg8vosQZgA9VVDwkKd4tjo3NSQcU
	kdxqvjmLILxbAGGHNMLrX3+n0J9JrwjDLdH0wYRL+EORpBFHBau5BbKW6G7HPFib
	SlCN3DmDEDcw3sCyn+FroQdJ8XOMKUYSMK43E8f+5J4DXP+tZtWFq+j9canl9vTC
	X2TOX4GOzz5sCJaFOq5R/wC0ldkddwk7XULLS58gevJKgDYUamuCiWP0R/u9V65C
	sdIeVFcU8pYZHe7h+AsfIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751908185; x=
	1751994585; bh=Z7p3bdD4T+iY93/6rf6Iy6dsajGrvgc6auwLiucv9vQ=; b=T
	h1aIeNYdaP0Twt8387Njp9zGWwV/SGaOvUhiLRkejLy/DeA9STUsGgckJ8t28AsI
	pwMJxR7BCpzFmtRegQRm0MHwyaRMw1T7fDiRTFgBxMbeL4lJqeHjrItU5lvCtR9w
	bCk9E5/uwQhO+oSfwiPSeZtu0MP4krwOTVpkP1n7ogn8A0E4Qz5TWLJKfR7ont+/
	2owyUYeJ5OOHLYhPWqBVMd2QDGSCeI7HEBTXXP/HfQlNHRvMWxndYDMyawyj5u3S
	DflLMwG9J4z0vGOh3AvN1PN9HUTx5R5e2rEA4esyzfm2/A6aja+dqcS/JowDPqW6
	yGFe5RQag6xex+kN3/VNA==
X-ME-Sender: <xms:WP9raG7mN4l1LDI5X-64-HQP8ZDw4Kgylg0UKMxAysMZkpTVSoPgZg>
    <xme:WP9raNfMf2ILtWQ8RYHO0Iw_JlZf1lszuFALSiM3C5AKoICUCCLWRxQLV4hoCcuqt
    gDMMdumQjvwpfPGoA>
X-ME-Received: <xmr:WP9raL7PVpm3HuVdWR4I0Hae_HW6sTXnO1LjRC1xl7xBWbrQ9zliPzR_eJ1gtvpggSqAYjdTQECuV5AfRTbxpZCgu8tWOPAE2w7zQjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrggu
    segtohhmshhthihlvgdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehptghlohhuughssehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:WP9raEv8d9cJ22lm31GWP_GwQuFW3CqWWVqZUxYcweinuF0lax3ICw>
    <xmx:WP9raLgtM3yTWyEXVOpCZ01PhVe3flZXy72aWFxloHKtq89hadxcqQ>
    <xmx:WP9raPoiWAatU__Vuke0j3X6zgZyQ7LYCa6UvpEk_bPssNRVl02v8Q>
    <xmx:WP9raIt71HtKI947LRKh1CaweDRoHPKujrmJ5_qbLoZbm7e5A5MsGQ>
    <xmx:Wf9raDW4hsz27B9HvFz-OU9fZ5UdMOt3Ay9qBdsGikq0tW1RIDL1j3Ms>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 13:09:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  brad@comstyle.com,  collin.funk1@gmail.com,
  pclouds@gmail.com,  ps@pks.im
Subject: Re: [PATCH v5] builtin/gc: correct total_ram calculation with
 HAVE_BSD_SYSCTL
In-Reply-To: <20250707164518.6600-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 7 Jul 2025 09:45:18 -0700")
References: <20250703080111.64276-1-carenas@gmail.com>
	<20250707164518.6600-1-carenas@gmail.com>
Date: Mon, 07 Jul 2025 10:09:43 -0700
Message-ID: <xmqqldp03p2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> The calls to sysctl() assume a 64-bit memory size for the variable
> holding the value, but the actual size depends on the key name and
> platform, at least for HW_PHYSMEM.
>
> Detect any mismatched reads, and retry with a shorter variable
> when needed.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  builtin/gc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Thanks.  Let's declare victory and merge this to 'next'.

