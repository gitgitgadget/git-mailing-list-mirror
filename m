Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0253F510
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759696391; cv=none; b=KIChLvAUG4E34pThkuaCYDWKSQOdi131gPRvONbWLxncpX4pFb+1hAJf6tFz2eiusS6oFa/KmichwFS0xk1dEgqvuG2hmgka/wqw1N5sdiyLPUIDEbUhOR4s5cHaTqcE2xPleJy0lxoVACXVPVHj17/KlHFo5RvSjjZuLqGpMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759696391; c=relaxed/simple;
	bh=P47YQgNpLBxRXYn0/Al4lbYp4x022XRkMeUXzjFogeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlOBOAdUI6QRGRl177qKngzdE1JR/tUwPpEE9oV7ufVXUNbGgpSMoth7ji9iJ2a6h/IuCRbCzKhBosidrOcjPPinHd6Du9d9gdJpViAJQNDu0MXNVH037OmqvgjtlRUhW4OyGPzSrI/Tha8sTfgyFLp/YIqYJ1i2uF/D+R0zK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eGTq1K1Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lg9dNiUc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eGTq1K1Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lg9dNiUc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D1F6C1D0002A;
	Sun,  5 Oct 2025 16:33:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 05 Oct 2025 16:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759696387; x=1759782787; bh=w5FPz3kc6W
	rTayzKQ8PYDz4OiKWI27UrPNgR+/k8AZ8=; b=eGTq1K1QtstNPBhPAHP1FInw59
	4k5Jp0I51KQw4OveFZ9r+m58xCJOR/pqm8B8W+KcfEtrSlkvVYXECH5+46ECuQEU
	LmczoQrsrbIazEmTcrUXEF3ZOiiCiYuWnm8tVwTTy3p0YoitpL1BULzFMonO3w6v
	Mz4jTFrTjTPyPy30fd3OEy6RuP+mx6kVSqsCmm1DCgqutuAxR3l9bCFagFoxam3m
	3sqUqCTOAJvn7hvkowLGqySpECwrpMB33umsHVHwsuIg5m9JzL7DZnvizS/KID15
	6UbKXn0dL3GkjjhCO/5YAFBAoDB1lKPtPrbXgp9bi5jRFD7YkOpoeXyMkeeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759696387; x=1759782787; bh=w5FPz3kc6WrTayzKQ8PYDz4OiKWI27UrPNg
	R+/k8AZ8=; b=lg9dNiUcgzJ9EvvQPTYSo0DFRVc7jUvPodnpy8UK2aD3haZQmpk
	ga/uLoUEOndSGB3ELQCdfj59w2V8Wyra6np3Bk1I8Fbo8rlET7UIfnPPIsApF3kN
	jU8EN/jB9btpVk0/bCGPwrdg8s5E8YSQN9hXkeYl4u/5sEHo3loeozg3nFFz3joc
	DPxU39RCuk8Y9KeM0Ezu52E36z/K+q6k/X3nVHP/W7HNQED/1zuMVJ8eWYYZFbM5
	HHDGNXC5dhtOfqnQOY4bGFDQHxioWDSVIYrGsGnS8Ja4O2Vhta8uhyGVwBEbuzi+
	UaWOldLO26Qdn+torq4Y72QLQmYeQZkY/Iw==
X-ME-Sender: <xms:A9biaMtJ1PrzvhRiyul0TLjdyEvhtf_JvdZkWyr-Rzi7bomslgcHnQ>
    <xme:A9biaA7FpUnJLaDOIKbW-hQneBk3iKhjP3egOpQJMZyv5svBMJdWi9m6SCJ5iu6dJ
    9W36ejvyCzlJwIrnCthmQolX7uX5jCnqVPXBzSYUf-6CubXUQOC>
X-ME-Received: <xmr:A9biaFKDBUxM1sjAXEea9UMkS9a7fQxeSLWxyh6ukrLf8trRWzIBRh4Xv3jtWLBm4xc-ARbvJK9_ke2yE92F2BTzUj-BNUnp-wQe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeije
    egfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:A9biaI4Zt2a8T0ecIqoVM6k6U0hXrxGWQ5shiF2AV0iTg4Jr14XKiQ>
    <xmx:A9biaAzxNFoVkSTYsUeyuNOPiIQ3TXgAeFWaWR7VPTTnZuofJ_Ua2A>
    <xmx:A9biaEbrvKIoBP5gvGDhc3JktlsRrEadGvWbYMg9B9X01XScAejYiA>
    <xmx:A9biaKQaLAyiH0hxqQWXvjwHi9y685u3uyAvSpAANyMTMqkeNohUOg>
    <xmx:A9biaFnDI36O62bhPfj49eCLWcaRYxUPU8idvMvUWigHRwkAniZW13hW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 16:33:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: UI themes, osascript fix on macOS, fix absent
 remote tracking branches
In-Reply-To: <91ef957d-2acf-4d74-9427-e2eac5316067@kdbg.org> (Johannes Sixt's
	message of "Sun, 5 Oct 2025 13:31:46 +0200")
References: <91ef957d-2acf-4d74-9427-e2eac5316067@kdbg.org>
Date: Sun, 05 Oct 2025 13:33:05 -0700
Message-ID: <xmqqo6qlrsvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit ac8fec7d8de265e56441713faaf4e08f11c31469:
>
>   gitk: add README with usage, build, and contribution details (2025-08-28 19:51:31 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to c435c515dad872532705d45d9ff81d3f4af22d6d:
>
>   Merge branch 'ml/themes' (2025-10-05 13:09:49 +0200)

Thanks.
