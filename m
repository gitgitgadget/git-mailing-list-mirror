Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2E36D4FB
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689622; cv=none; b=AP7rBCak155t/8Sgn7v4C9X+1Ut0Y+gZCA21BlxZsmJwUWplDO5frrbcs6k8c9Ycsjdg+07EhhMjTBOOcXI6jKY3NRDxXZuvQTgjv2hcd0hPfpCBErj5LQUKAJJrx+8jjIlf4UCTu3IKSgUUI6Yv0O30dPTKMw3vEyUVJbCzzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689622; c=relaxed/simple;
	bh=3+QVIEcbQ1aAleJYX9sOccYe6lFAALsKenZdzVRbDU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XlJbiaw8STQvUJiuAtatXgD7K6niQCi4gQwK464u7Bm6qw3pr/C6LzuKRL0JcfpEEj8vX3Ryv/3nnZW64impfS2A6uO0CM61wHzfsaUco9vxr8+3aQMWQpt4V2gm429DhKJ2ypvTsSwCVs897YgVxpnTjEcF171OgmmJM1xrd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+7UCog7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF6KWpwA; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+7UCog7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF6KWpwA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0774F7A0110;
	Thu, 20 Nov 2025 20:46:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 20 Nov 2025 20:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763689618; x=1763776018; bh=I97Ssid63W
	Syj5veQy0CeAIK72/ixcyLcT5mFSCuQ0s=; b=E+7UCog7R6gfSFWW6xb33qjDTy
	WoD3+sEeyVcdWMCWHK8oTW+KE/fdsJtY2xWnVrayt5ldbBusjgXl5j9/kgUUactK
	TymeHebkqsdQt7cFrfbhjNAj0GxYcBUtUX8sgBnm+9H0wCvMMo+SfDuPOL/mNMLQ
	krHKpgAVcpvXEtpFvMPNGVvIXcjwe2ws0+mbFA9diFvxwTvXg3hUSpXadQuaCH9C
	TNQH01k7lJEB0DlZ1iDIFVoCp31XMwO2ye14grasTCJbxsnBOLxUUUDVKxSGrYYP
	mqep8LUl1VOksCH4UU2sLlFfinweVTLuFXK6h/Iw7C6GFJXKDCuXZJzva6hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763689618; x=1763776018; bh=I97Ssid63WSyj5veQy0CeAIK72/ixcyLcT5
	mFSCuQ0s=; b=QF6KWpwAwuijB4OPXlrMMdpoH92L8CngBxUO2/CQYABC0hwaJG0
	NuLOwX+BtQJKGDDmV0Gkt2fLkdM6EFNz/yZfURgh4U4x2TiMqiSjXQ6PLpfSOpBn
	/Uaqr0QgnpVcD/dclUxluNaptSioiZmIsZNuP8NiJTCYHIwHqkQnolctxjPiVE3r
	4/ZSNeATEdR0Ghk5IX623Yt7AY8mWw35T+y+SYykc5ONt8MEc3wyJCzvGBGxsMeR
	9zzrE1z1ZwuQF7LKE6m5Xk0GIy4eMglFI7Yj+/xtVrWqyW8bwNDNY+7/D7yVicom
	L+9w+nqgUBMwO4VaStTmp1AdGfx4QZdm98Q==
X-ME-Sender: <xms:ksQfafPMYm5EXhFy3Z3fp34O74pq5eicl9TGwk6z7_xf8W955n_DKw>
    <xme:ksQfaQ9WZtFbvhhqnGfU_rX7KAqzlGBWtqRhnJHuF4asu5Jzw0DgZDAoKQwS673vF
    M-30JKX62URBQP5rHxlAkSN5srs8sLdhZFMvnlFCyDVu5UTy55mT78>
X-ME-Received: <xmr:ksQfaTQsot_I3gFQPXAQQpVwiHKzCukfyyI7BaWdTmVUIa4gcFV2KbJnf80Z2qjjs3rXr18QJc9ZhHgJ5zknHmU0m3rz6ockL8Tx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:ksQfaSmY05y5JZIHPUvxAajuXUpMelB7R-hTc6tQaCMBDwTyfbUpUw>
    <xmx:ksQfaTTV2WHa4Eyc6HaHBb31VfqmiNwvTnmVKMKa4cdsf1nhdavJJA>
    <xmx:ksQfaQPN0lF-fNXoxrbmLerYR2HOcdXdUrLQn1xUuQe-XAYhdFWyQw>
    <xmx:ksQfacUPoVtyvwUTonnkmirOx5Fm2obyz4_wGayEuCinie187bh66g>
    <xmx:ksQfaWwbb5XU_wSzOEwVMcRNe4zbKPAHe3sIxQtqc7x_8uApcOZpjojQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 20:46:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  AZero13 <gfunni234@gmail.com>
Subject: Re: [PATCH v3] win32: pthread_cond_init should return a value
In-Reply-To: <pull.2103.v3.git.git.1763675016637.gitgitgadget@gmail.com>
	(AZero's message of "Thu, 20 Nov 2025 21:43:36 +0000")
References: <pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
	<pull.2103.v3.git.git.1763675016637.gitgitgadget@gmail.com>
Date: Thu, 20 Nov 2025 17:46:57 -0800
Message-ID: <xmqqecps5f8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Greg Funni <gfunni234@gmail.com>
>
> This value is not checked, but it must return to match POSIX
>
> Signed-off-by: Greg Funni <gfunni234@gmail.com>
> ---
>     win32: pthread_cond_init should return a value
>     
>     This value is not checked, but it must return to match POSIX
> ...
> -#define pthread_cond_init(a,b) InitializeConditionVariable((a))
> +#define pthread_cond_init(a,b) return_0((InitializeConditionVariable((a)), 0))

This is tricky and I like it.

Because InitializeConditionVariable() returns void, and return_0()
is defined as such:

    static inline int return_0(int i) { return 0; }

you cannot directly pass InitializeConditionVariable() to it, so you
use a comma operator and pass 0 to return_0().  Because the type of
the comma operator with mixed operands is the type of the rightmost
operand, the type of "InitializeConditionVariable((a)), 0" is type
of "0", so return_0() would happily take it as an int, and returns
0.

This should work correctly, but it still is tricky and yucky.

You may not have to use return_0(), but OK.

Will queue.  Thanks.
