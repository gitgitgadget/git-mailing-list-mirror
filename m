Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B63148D3
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585482; cv=none; b=VsLyiYNVc/i/S+LQhJ2a9TDfs6ZSaAmKFGORBXpm1sMsnKbAG0riMTFyZqzOV4WGyZKYC2WXQPAhdcORAyrWAANozuyATtrsCV4yQJSmrLrRFzaln4mVVRNDDp7naPfmYTXAM15X1RWQbgUBNvVVdp7O75UnJv8SuiVp3r/DOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585482; c=relaxed/simple;
	bh=/GMSBWHdXQLw2yOehE46tTErsiq1LxXzIGK+Hcpwpug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=auwytHFqzsT+FjxBumsLkoquFrQHwYXbTz/GBshZJdDIXsXYVPIOTu8Z0GdT4lWHMj9oExnSaMGA/m2M0gslPfBV1/zf7Dl/Fk4rGsILKIG1YIm+KSFNdLRI1UO+11kgxR7WoUAEHdG4YtrgQWImtWObDsaWBJVixaYQC4RejYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ghm7GGsY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1L0Bfl8S; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ghm7GGsY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1L0Bfl8S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1373C1400067;
	Wed, 19 Nov 2025 15:51:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 15:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763585479; x=1763671879; bh=CBhyTZb1MG
	n53b3ay5bp6Q0ClzZMKdxqUriS9PAkjk4=; b=ghm7GGsYesYR+Xwtt12AaSggUO
	0yAYC64CNV63uf3YKUx0ZT3KDjqWEJFueuPa3Z8YjPpGAKTu5eQWj8Zo3UTBers5
	/RyOonbGz+jCu8Sa5mtkjvz55NMGSEkRentKHQJ3BNEAteICdHgmbeyzlDaB016W
	Qhs+LugBLM+sgPD4SI3rjonfwLgwlRqXPqakf4s14e/ST23PEec66Bg6OGMtfU5G
	QGNMYYnhhnasqkUfugE0wIcEucHOWftUz1UTzLYF/xyVTh9iO1As8WmAuWtQ0sit
	NCwArBxuAkRpHo6x8/cPgC59Gd0YJ9awnRzZuq5YK/xxCpTWSMQNM8Ud78Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763585479; x=1763671879; bh=CBhyTZb1MGn53b3ay5bp6Q0ClzZMKdxqUri
	S9PAkjk4=; b=1L0Bfl8SCuYpuntV+LdZKAN0wRp3ctDoe6EE9dvB/MSMrQtqEuP
	S3XFmwaX+npY1wquQTWki89lTdWZCzxe9dYC82h/JuuglFuDgm2+1zD/3q63aAes
	a98OxylD9BZRb/H4SZob7xDtDUfD7yAm75Y2isDPrFzeQF03pjwUx94o9sBS7Db+
	KUwuSR1GlMOkWLYE1n7LPy/kG8xom88AGcv2uXUG9GxDxtHpQZu1fCUo9qgYfMt+
	4lFxI5Xeu65pOWuroBrqzZFUr+GOTmf9mjfi83K9Z67XlVgu/AUfKeJRbXQkLeYy
	E8qyYemLFi171hS2+OzPLbGin7RIomnypNw==
X-ME-Sender: <xms:xi0eaSbyeo_rd_hLqT7cCMudP1tw7QNYcYDcDfSxqCE3rh-KxUMWuQ>
    <xme:xi0eac01wW3UDz0fxJRBHo_aeZ5YQR_3waQhXq-pyoF9QSTQ3zMG9NXl1KUbaKZiq
    UPNrwpjMJ_yQRpx-AflDQLUETzGjrV6AQGF4Oqg8F3__ZiOwwKNFew>
X-ME-Received: <xmr:xi0eaaUeFOWUlyB6geh2gS3o2pvbGXIuK7cjE9SRmgVWXt446923jaQfAaTlaCUDHhsC5Cz0u42YwbbYY22tQ4dW_Xue5mV-1ntq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:xi0eaeXN_9tK7z6cR6MWNjHS4E9B3qTwo3TX3mKtEsQxd3di_B127A>
    <xmx:xi0eaRfkY05VMoTSitfDCzajecyFnFSHynMwWTgP1iZ1q_gQ8cJvMg>
    <xmx:xi0eafVIOmEER--4kOXzOl7p930kYjanzn9aJqmHyV6JTVUOI-rgbg>
    <xmx:xi0eaSc4DOm7G-WArgoJEuaTROYrdH6zb1gkIsHDFron9Lxp8Pqcfw>
    <xmx:xy0eaU-OlJuKrqgw8ypSMe5FgAc2cLae0H1hRnTwbMpaNNrz0uuA0-nN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 15:51:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] odb: move logic to disable ref updates into repo
In-Reply-To: <20251119-b4-pks-odb-creation-v1-5-2b2ed2612cb6@pks.im> (Patrick
	Steinhardt's message of "Wed, 19 Nov 2025 08:50:53 +0100")
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
	<20251119-b4-pks-odb-creation-v1-5-2b2ed2612cb6@pks.im>
Date: Wed, 19 Nov 2025 12:51:17 -0800
Message-ID: <xmqqcy5dbvay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ...
> somewhat misdesigned:
>
>   - We can have multiple ODB sources, but only the currently active
>     source inhibits reference updates.
>
>   - We're mixing concerns of the refbd with the ODB.

"refbd" -> "refdb"?

