Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8611647
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735229155; cv=none; b=tN77ArMhn8p+yD7xPAXGNvllioTVbvXEEbkl44SNTUpLX/r8eEwcdoaZSbEhS2rSRqA5F5d5r/hqVxE2qcRMq4QeeDW/5niHC2IvsQorogvjyT9UnCgK3+9fTq49iJOEjoRHZlk43qadmf0qJc3ICvV8Z68xWvqQ6+DMp4Z+9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735229155; c=relaxed/simple;
	bh=S4Gbmj1rKVKJPSQixT2AvDZNwbvpO5bM4+6AXqibbHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6V0whn0iWrHEmnyMdqMEyNbRiH2UORdDxlGqN/kYQ1b7srsu0y/e3EYEfsUhTIDCsiMswQ89tZZug3c/a1+O9w74OiZ1FptuYOqau/y2QsGJHrkjUOucpDsdKuvxrMtid1Ne61F6b6AUGUHmfUe89WZd0h6+7KHsfwEPdyO6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hqzuu7ba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BrxSbLl8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hqzuu7ba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrxSbLl8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A550111400AD;
	Thu, 26 Dec 2024 11:05:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 11:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735229152; x=1735315552; bh=S4Gbmj1rKV
	KJPSQixT2AvDZNwbvpO5bM4+6AXqibbHs=; b=hqzuu7baxITD+xUDJYwF5s1PYS
	vwG6deMXUm+DLAgTty3VXlIoTGe610HAhI1q4JqEL3shlk2l1d4zreBylLHaWQs5
	inIcDbrR2x68Lm1XRn4ZxaBuOm2sMJGrLVkmBMWvCPOoX1hr+Z6GqaAsxowmqp1W
	eUTMIIzQJ7r8s8QpL+JjU/nfND7w0AYyyWbcWCBUe4v6UYtdmRBZSLLD591fZt32
	EAp3qWv+scIksBj07xrHkDEGnxtsmYUKJvmmLsk6CsFZULjfcyrogiYQYKpXSuOZ
	7kfhltNWArugxabo2hYXRsbY6ySW6oqUQBNNuBVitaMbohteWYGtptaVaoaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735229152; x=1735315552; bh=S4Gbmj1rKVKJPSQixT2AvDZNwbvpO5bM4+6
	AXqibbHs=; b=BrxSbLl8ibh/gnbCk2UsObxgqVspCOydMGVy+PyZix7MagXG8Td
	0OcIY1lmkhj1gjDedwQTLvUfCKJtu/984ljlkG4NaY8T0YSFnBtQmHfDFnwkJ1Tg
	ylzSLOHsSZFaerE9bNGTbqrXkV83eWGeI7OFCZMrIHQUFra3+lRiEIFUxU9zbaQB
	gHUNPi1/CRzSGuSpWetiHus+NWqWozYXLpulJz8k6xWrCkJ0eguz5zpKWSIGN8rQ
	WcwyatkT4rrC0rPOylKL8O6jFXEUIamSdxjzddD4XVZPIAU2wr/X6pJ+TdBW+Vck
	oVaku6631jIv+gVlF6sqhbgok6Ge3KhBYEg==
X-ME-Sender: <xms:4H5tZ83e0XyNjv1qT_Owr0V4SdkzNqyjjnyieseI7Pd6ZoTBWMjHPw>
    <xme:4H5tZ3EneiYmi6yIy3vzvREf5j5EhuYlfwhAmE5TKSOWDorubetmFvfLa250DhGij
    AlXf4HZbIrqUAP-Qg>
X-ME-Received: <xmr:4H5tZ06p_nJ4DvS5nBeq9rTyjVLUWP6KLbp_ALUIEHVT3mXdgY7hpzcOj43pWGw4AoRBRYa2LN1Pe2wKZ3M0GhAZ5JcZk4QZMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:4H5tZ12WVb8R8BdAQXIn6hmKWiobc9mSoI6U8tx0dGcGe6DJPWnHeg>
    <xmx:4H5tZ_FXiNzt-duLE07_vXkHdtvzhUU-xiLZlzqXbNQc8i4uDERUpg>
    <xmx:4H5tZ--TIvaCigVjXi13r1-kIF2evtkM8TDjasn9py5y41Q-YBCZ9Q>
    <xmx:4H5tZ0lIk_I1TVo_bg1cKk_5P6Jv0T15lvrafhGZWzwlZIybamB4Rw>
    <xmx:4H5tZ3DoiexZLLeCBqv4HpP94uRH5PU31V0Z-nhGuT-_G0-rVjt2Ilnv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 11:05:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #08; Mon, 23)
In-Reply-To: <edd2807e-4b2b-48d3-97e0-19b3a0dcab8f@kdbg.org> (Johannes Sixt's
	message of "Tue, 24 Dec 2024 12:55:56 +0100")
References: <xmqq8qs6yzbm.fsf@gitster.g>
	<edd2807e-4b2b-48d3-97e0-19b3a0dcab8f@kdbg.org>
Date: Thu, 26 Dec 2024 08:05:50 -0800
Message-ID: <xmqqv7v6xwdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 23.12.24 um 20:27 schrieb Junio C Hamano:
>> Let's wait for git-gui, gitk, and possibly po/ and delay the tagging
>> of the -rc1.
>
> I've just sent a pull request for Git GUI to make the current master
> better visible for translators. Gitk is already up-to-date.
>
> I'll wait a week or so for translations to trickle in and then send
> another round of pull requests. Is this a practical workflow?

Yeah, it is that really slow part of the year now, so it would not
make much sense to have rc releases without much changes in them.

Let's have -rc1 on Monday, -rc2 after a week, and the final later on
the same week.

Thanks.
