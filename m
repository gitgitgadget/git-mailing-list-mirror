Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA334AB11
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242168; cv=none; b=F7AVQHu/5WnmLrvlKmDqHLvCeo85/ZAbKLVcwHpV0M4ZSEMTPdKDxUNb4kPTuZcAA0MW4xBAtIxSJK9rC83cxx5Hv6EYlfrGU4mLRpVuIh+3sPfSgTkY7MZLWMErG43iRMvfrnMDs0tq/e9BbflV/a+QKInHKemcYRUaSYiU+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242168; c=relaxed/simple;
	bh=1FLQkuBUpTGeE4xfrN4Z+1ie0nNdX7VfTRWpz2M8GzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Og7TSv6iiWPIAKnMuHq0//5I3Fdac+sRByUAD70jlvXvPGYPmfSEir+FA3wIRFut5pngQ+YK7vw6fqYPSRWW/I0oVY5lWz50mv50NTmc+prw1al9/BHDnnj3IBXU+6KyBexQ4SdP+n3eo2ppLO7Wh/pRlNpkmEC/q9BEGdQLCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vk2Fs3F0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YzPu5fGQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vk2Fs3F0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YzPu5fGQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 05B57EC01E1;
	Thu, 23 Oct 2025 13:56:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 13:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761242164; x=1761328564; bh=o9njyaT2qS
	ZhvQ4vhQIUZ7GL0Btke09gs/wT2PjL2Zw=; b=Vk2Fs3F0e/SY6UEyfm6qabQJXa
	ClZ0HTQOsJHJQOqM0OOMqDWjbxvCIkEJ0pD/PbQXhxzLKD7bv3LPIgPl1bUPLG2N
	1RE64Ah+Zm2JhHm+ktP9rClOQdShM+RtPDKNUecULe7c6A+yPLWSjh15KIgDEs7G
	QU8CcEbD+1b+QxAX/XwQ2hy0jgShFga0FVw1Xv2a9VvXB376GEUyvu86u07xKU+D
	AeqwnAtMRrJShlIx7ZI0UoTgMumZuw+b9JE60GADSsJo57FOkg2tKPYlkZUXLmhF
	T39OzCaRgcm4T2/oRhLKibH/pMsqIghVr1u9bu6ESOSCzk1GR1/Pt7oiP7GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761242164; x=1761328564; bh=o9njyaT2qSZhvQ4vhQIUZ7GL0Btke09gs/w
	T2PjL2Zw=; b=YzPu5fGQkGZsnnesK9biOqM/h1jPxG8OOHmvbKLChw9E0URtOpo
	hiaU8q2os2BUwC2xGa9Gz6XV97DQ/bdLKjbpYW2/LgUkTSfNmOhaQ0NnDRsMfauj
	/1DAP95bWxB+ZQ/fBsbQrHo7QxXpA5CDvPOlZRv5UTJlkr8hz6WX3AjvMJSb8DJV
	zSHiD3suPKJZxKTdDzbnCu9W1BpCEG4VbO5ZYYF82WnbVw9cCI8KGgwT1diglTlo
	kx5JWrh+0XF/zmQhAeZDfDsa2LA4LLe4owr4kSjaUr09+RejrIy0akIWcIqLX4Lr
	yGflP/Q3jtDIofAnMHktWGmCqO6gmeWbbPw==
X-ME-Sender: <xms:M2z6aPY0pdoGtpr3mFC2SrFXs7ajOXVvw7zhQBkJbCYKWsdWKH_byA>
    <xme:M2z6aFR34cdXLnkwZ6mUaOmgtdHzJsvOdGm8YzIi5UrfNrPHgwfQC2oZLNfalcA9y
    xd7kTbac4OhGkm-bDztcmdLA9n1Cydz5g_BKnoYxcwBDxNkSvZr>
X-ME-Received: <xmr:M2z6aKTZtygaZ8qRNIuFyuurD3KjV4hFlFB8wSnrXIBxEmwC4gdBI37PcmqMbJs4Trm_RaiYEMvxg1q9ezkOCkIvFBVkDDsG-Go2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:M2z6aBQtouT6Pm1wE9x8P7ZRE6cJ_FhthpQN1cRFaB-oelMuBkvT5g>
    <xmx:M2z6aH7mEilIo0oygNHr26qmCCQWUF7YnFeZ68D8CvlopRjwSGP-6Q>
    <xmx:M2z6aF2xRTyHR_4knCyd4v8gk-PzADVW7JojXOLTK7K9CPsRKoUpug>
    <xmx:M2z6aKBa-8QH17EeiHC7AAGQyipjFV9H1n3phGQOMiWr5zhGs363NA>
    <xmx:M2z6aAgl84GLCPxZ1v5JppMUQQtobZeGS5MK-zWSG5lM3i2lgupE4UkB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 13:56:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/3] ci: use Debian instead of deprecated i386/ubuntu
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-1-c19b61b03127@pks.im> (Patrick
	Steinhardt's message of "Thu, 23 Oct 2025 09:17:38 +0200")
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
	<20251023-b4-pks-rust-cbindgen-v1-1-c19b61b03127@pks.im>
Date: Thu, 23 Oct 2025 10:56:01 -0700
Message-ID: <xmqqbjlxv6xa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Ubuntu has ended support for 32 bit platforms and is not maintaining any
> release anymore that has 32 bit support. But we still use i386/ubuntu in
> our CI pipeline to test for compatibility with 32 bit systems, even
> though that specific image does not receive updates anymore.
>
> Besides being end-of-life, this image also doesn't have all packages
> available to it anymore. This creates problems with a subsequent patch,
> where we're about to pull in cbindgen for generating Rust to C bindings.
>
> Drop the Ubuntu image and use Debian instead, which continues to
> maintain its 32 bit port.

Thanks, this is long overdue.

Would this have nagative interactions with our recent tweak for
sudo-rust vs sudo-C, which I thought was only releavant for Ubuntu?

I guess as long as i386/debian does not have /etc/alternatives/sudo
we should be safe, and we also handle debian-* (presumably 64-bit)
in the same case arm, so this should not be a new problem.  Just
double checking.

> -        # Supported until 2025-04-02.
>          - jobname: linux32
> -          image: i386/ubuntu:focal
> +          image: i386/debian:latest

Will queue.  Thanks.
