Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7F3A1E9A
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766921548; cv=none; b=IElxmmOLBiMIv2INSSZRQMVIzi6oTnsRNMDCm8Qj9yzSW2qVKwNioHgf/Kyu8nN3LnifVuBNn4Ia1jTNYtfJZl8wr7mb5uVKhAMspfN/Rz7MwnL4A/hO+HSPTs1ANHKGEAP5DI2i1GmOvrselQh5YsiCZ473EShwyooTAJAQaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766921548; c=relaxed/simple;
	bh=DdhzbIpfKa0aiIIhKnnrvkDPVHzbBiQy8cDBVUnELps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LmvROyikZAkas++BSoYzKTw788o99Ix2xrYSFshLojv8ePmooKL5vszghZG/g35QCjkRjkmPITYjze/q9flHDLMzhhKzYxOSM0nOI/P3XtUqGdKz7XcVC7Fr/kd+TqnhX5F0aOWLXwekfBtpg1K0mjGcegjUjbU8LxIi8JuXxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pC8/4nCZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6SXRWv8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pC8/4nCZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6SXRWv8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 551267A035D;
	Sun, 28 Dec 2025 06:32:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 28 Dec 2025 06:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766921544; x=1767007944; bh=Nfrk8KI0ur
	oEGo6+yG8XSHGbfvdAntxNx6/v8wIn7Vo=; b=pC8/4nCZSt3dQ3OgyeXvvP0DKY
	y1MgTsYsuGmKGT0yQFHuLx3TU2pCw/EYMWpsPaMAWqxncQfRUtSKN5HP/BnE/ZX5
	Y01ss6T90r1pOWOTJ9pHVAXQB453HMOP9EIX8piOl1t/F7RRdfiUN/Hxl8CYS9fl
	ycKUmzOwcdc9mcimPemnJvAHAECyQe7k0Cslnd0KOtSa2/+V8J0lpt9lVHwCEQqb
	axBEjOHAkyTGHk8rXBJPUMxGG9Ci0o+YtQRyoNGa+MS+PAZsT7XEsvSznuJhPdMZ
	XP2Cpabk5XnM6rkyBHAsH0ko48kPwNnKabvldqRgGIB3D9M6nxpJyHJHVE3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1766921544; x=1767007944; bh=Nfrk8KI0uroEGo6+yG8XSHGbfvdAntxNx6/
	v8wIn7Vo=; b=N6SXRWv8kawAnWcyw5CqRXBMzjwenYsYE+t/6n5CJXPxvULkdB/
	GZOr0LKo9w7XUj8+IKyHNLhh7MOS5Zh2PexCQYSV4SQsjKkJ6F3SeOm6aaiDfj7o
	Okil+kwEd7xlnxcxeRxZZzUdCtsGgGjdMNk9ftxtWxlTp/x3SJXYlyAXv/WX+2Cd
	2cV8h7u/de/jpk4r6xXC1+vlf90S6gtZqSGKqhwjn/9ONjJvuck35PfoYkNCInUf
	QwbFPjX5kdVtY6rKFN/VL4/Tys6rIIIotVqePqQhrdQWr7wEqTNL1GEILW2T7T95
	t1buLB/vcahlHPElvLOROwCoW8p89Ve+gzw==
X-ME-Sender: <xms:RxVRaQyMaK_WLYYEaI2LD5p-VdHODPLExZ9FWF6XkLsxaVeH1pthUw>
    <xme:RxVRaQ1QMpjXTUdl_6ow3CzLl1pFNxYTnF5UTyjh7TDAgMHn2isYlwJOQ2Kpdsagp
    dpYrzEKkLWxuihh9Ch82wu7vllX7qcubRDif1c602KQuaInMU05v94>
X-ME-Received: <xmr:RxVRaWz8-YYL-DvdJWw1z-6Usvk5lVKjZOhgtiQf5uxcP3mBTo6Hyvde--r2TSRTlLvIoZDP7qjThGEQ2ReaDShArd46kQdOZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RxVRaVWDPp0I7wrEFuUm9ctlOF6VaE_Q9ahB2LZQdr1gAsRP1p_aEQ>
    <xmx:RxVRaS8hFkKsm2K-LugYg45yi_xVECmqG4XEEIIa7in0lnqezB8TYg>
    <xmx:RxVRaYvSkjeWJfTGAissc5PajJOTvabN2ZFaMten7PA0p3sgk0n3cQ>
    <xmx:RxVRaS3wkMgewk8knniQgHeF8mcjTBcJuPTYaWow5BYGW2tVEXYSBg>
    <xmx:SBVRaY357jorjMd6nFKv9HHujwUoRMxu95uO9yWia92pqX590yl9LEV9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 06:32:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 00/11] Convert remaining hooks to hook.h
In-Reply-To: <20251226122334.16687-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Fri, 26 Dec 2025 14:23:23 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20251226122334.16687-1-adrian.ratiu@collabora.com>
Date: Sun, 28 Dec 2025 20:32:21 +0900
Message-ID: <xmqq344ulu4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> This series finishes the hook.[ch] conversion for the remaining hooks in
> preparation for adding config-based hooks and enabling parallel hook
> execution where possible (that will be a separate series from this one).
>
> v6 is minor refresh for some last nits. Details + range-diff below.

I didn't see anything iffy in the series.  Will replace.

Should we mark this for 'next'?
