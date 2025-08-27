Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999E2114
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313129; cv=none; b=qei60h482btKNCxbr6xZllfyGbpjbKcqlKHrDXho+gE5+NUbTczcKTHAlQeEunMk4NRiCKQ6c2iW0oMk+m+Kc125x7SEAwRlpyAbWmZQkBeCZW2guZ+pNPHA7A8s7XhYIyfTvMopmnu+RNTQk2uHkg/K7iHevgDNtNqm/n8l48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313129; c=relaxed/simple;
	bh=tDeOlP5dkgCga5TQvcC9pO17dDZjtfdZnXXdV0Ya1dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFKccwDo4uPoNasUYNZNu2hxEHirQOsNIYHv8WwkRtpXQ2DHPl28xHP/8mGFD7XVbHWz9fJ4XP06Ng1f73MaUtq91sz/A0VBBQLD8+PjYe3RYIEmmDjGLm19AIsWXESEnZVQSxv2EKVOnhb30+QbTv+3GCHmkTW8y7YWs3CcDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=plKogZwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckA0cwsK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="plKogZwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckA0cwsK"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D0DA14000BE;
	Wed, 27 Aug 2025 12:45:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 27 Aug 2025 12:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756313127; x=1756399527; bh=AVsQt0eMoX
	mfn6dpNctJRTo/v6H8c1/MQh96SBB0dCk=; b=plKogZwA98I+WV5UBx8KrpinCd
	xSccjhK7EzQlyIYfxOdHAL4Jp962F3EV9uclthDaQWknXwRSCexfPgcSk2tf3Igl
	xYEKv8oPSgULMjtLEx7JFcdF2230BlrqKsA8L+eP1ZAVgKfZgAijv/X3O6i/PsKT
	YKG29CF88ss5z8yV+CS3uGsOb9/HvQd9nwEFVPV1HhWLqKY5j6RxrcWJ6JTkT5F2
	935dieRLxTG9/k8DuZ4Y7fuVHoAexgiwlqMdDjaA92NcXpCOSZQJxUQj5I6nh1AM
	HE8MwAhuKJxIYiU+qTq2hwK3VfQ9sxiq0LaQtGf9CNKtaR/Om0FcpRQ9KfDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756313127; x=1756399527; bh=AVsQt0eMoXmfn6dpNctJRTo/v6H8c1/MQh9
	6SBB0dCk=; b=ckA0cwsKsnw4HQVBg3U2zWade0WgLJTbdo9JB4lDtEg8o8MCL8e
	aK85J07qvy6ZNf7Hf3Lv3yRkr21KZplsOX23zHmAfAwBAhHcLIADhU0SH+bjNZQs
	epDhVb1yF1qnvHLSjViYSK2VCHiAHYa0Nf6ZRzVKW4Nd/UoUd0iXu7QEOxDeO7ma
	85B5l28m0LlX5gJPsN/uFKIKtTdGT3vNvNLeCiLhiM2qY/m1ReybSW7n24iepjdV
	Q3vFU6DW11NjQ27lsPG8mk9kuXMESMfzoaPxjAknQ4plR3y0ph23+y3fU7JgIqgR
	lVD27VEdK0ddz8VOMtiW9rave6ndjncEjAw==
X-ME-Sender: <xms:JjavaJMLxbgY2hybEz612ZkGsuSo3rMTP-UzYV9bAuqQor_TWVBY7Q>
    <xme:JjavaGgNukfN3HYbhy1qsGX4Ripfkgle0-C-LqfHkR26IB6r9vNITKzj39SMw6Nxj
    KkIdCKRzdPFiKCldA>
X-ME-Received: <xmr:JjavaE0zQxecNKZ3Cju7yChYqPYvlxxp5cy39Z2aKm5oAQNreT1ZcviRZctYNNEzBRPcXDyWrKX5ajtwxB8kJ3sp342bHYnIPDNbFvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:JjavaIg78QVAV9HnCnFGgrhDo5zV_f6v0yfoEuxb-xbOt-DN4X1-7w>
    <xmx:JjavaMfWKGM5q296p5X3opZyOYzj-oAZIpCnMjWhuT6X3o0VvVWwsQ>
    <xmx:JjavaDlQuQJ_It9clB9tA2yubq0d5-5xUI1usQdKxm1cvyWEzYBv6Q>
    <xmx:JjavaNtEsySjWCM-RgVcHauOgNvEB0-4PpD2lWEdv_NvrY9FMq9Ihg>
    <xmx:JzavaJnsgt98SWu180BFhpIPPF0p72Tf4tpJGQLbPk7jlkc2nC_XaHgQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:45:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/4] whatchanged: tell users the git-log(1) equivalent
In-Reply-To: <5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 27 Aug 2025
	18:29:47 +0200")
References: <cover.1756311355.git.code@khaugsbakk.name>
	<5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
Date: Wed, 27 Aug 2025 09:45:25 -0700
Message-ID: <xmqq5xe83e8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> -	if (!cfg.i_still_use_this)
> -		you_still_use_that("git whatchanged");
> +        if (!cfg.i_still_use_this)
> +		you_still_use_that("git whatchanged",

I spot a whitespace breakage here.  I didn't check if there are
other instances.  Please check your editor settings (or run "git
diff --check --cached" before committing yoru changes, or both).

Thanks.
