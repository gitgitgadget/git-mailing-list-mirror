Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB00223DFF
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753919; cv=none; b=gud9HlGrMo/Am+EDMe3labFUhY6H3yU5Kvt/W0Zk8Zy61x+EGqQUDOVfKrErlm8oG2/nzRWGhlnZThEE9tiCLO0rZEKYYBfnODuAhlTa0A32lkHO878IbZyJf5tMGKUn9A+ORaAjCfksSyTFkJC2QO0E91O0Mei256uzkoWhrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753919; c=relaxed/simple;
	bh=2K+g+3s0+cuEvX0FbDZUSPyIZa7pjvr2IDq2XiufnyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ciN3F8w8be3w+Sp5P2EUYhBfL7CmNAoPAzIAtR1J2dG3uw2/y4gAUNMKOz2fKtdi1r9fpT+zXDltYWwogia+ghojG+1xI6m+GrGcYBZl+xA+/JLhB1oyA2PdhDnnkMmD8ifkehVkgcSGB1ls7+xS+I5pps4gr59FaOuQ4dCjfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FgaSVKPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ez7c/nq2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FgaSVKPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ez7c/nq2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A661B7A0126;
	Wed, 26 Aug 2026 10:18:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 10:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787753916;
	 x=1787840316; bh=AGUVCNqWaisevMWhfVLySU7jOvORqP18j0ooYulS7dI=; b=
	FgaSVKPgFgut+LSKA/QQXpdyiajqowpCCtlO2sCsLTP34TKjFFraKcAsc409iLsf
	hJSByZqXnr/W3JlD5O7PBV20z/0lNHhTxrJ2YTpufjAS0oAzANO3kih9rjEi7aCA
	Zr6MR4ac5Lkp/pGbOsX+ufumyrO1o7C1ef4tp1hvR9UQyi3l6VWS3Y0+mwNVNYR8
	mjmMPNRGauKgg8RhQSJpf5Cq2v5hxnBHrqP/TmlqK3AE4wq1wTS6sFez+5DaGr0b
	YCn7vaI8/l6YpGoZu/vOMBqrQYrevpdL9DQkUrN0UYTMbNyD6gG+rORof2qMEQK4
	WB52NVxrjhLrf6jk3ucq+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787753916; x=
	1787840316; bh=AGUVCNqWaisevMWhfVLySU7jOvORqP18j0ooYulS7dI=; b=e
	z7c/nq2On3/xSIZ7ehJ670jQR3/B32QxQq3idwsRkk6I1z6RbrKvgPv2yiXfC5xF
	yilkQLIUlP5YfqbodCnPLtnPdrnVBYXTNFbniJ7K6Zk+Sb5EnO26QAeHfCfnaM0u
	/KXOSQsKmPf4VLB21SxNU8ehyodm329zFzetYkLJBltH9+tsTki8FLUSkVYharo0
	Y+lHa4uXUDuMH3Aiev9+TKdQ3NNIhZrQn2LXxWWnuJLh3Jqb15JAidAzB9MuWtAL
	UcQFvHf+wN/tAdkD95iVGU8dFigna2YUW6ArxYoZ1sKuzTJQYi4FO4HZETtVjafJ
	fpdHzYaDHbnN4kFVH3hVg==
X-ME-Sender: <xms:vPWOatu9kk9j5EIsO1ATrvr3tzjO3ilJdbVcOru_WJmf8iKDhqiOZA>
    <xme:vPWOaqLZYp_qUXpBc4uwLlaZXfndERXR9Y-7xpvK4nbeKMv7YwgGwzKilyrme5hWh
    NdUJEJ-bsC3aeFdAQ2sS00dDCSLZP7rPEwlSnbUl2vPQKsuWNfjpQ>
X-ME-Received: <xmr:vPWOaqmQuRIHzc4PwQZhhJNfz1hNUCbU_7VyHdUA0r1CqyhPDL5YTG25QJNOwfOdNq2snx93tCS_Va6eZW7230O8VmgVQ6UCUQ>
X-ME-Proxy-Cause: dmFkZTGplOjRXWArQ71hn0kwORDJHKfJcVtveTiAifkWljU5w1BjzI2VtTQqJS3VscEHSt
    0EfBTSkEqAtYOySDa11pXMAwrsECTuERmPnpim/PnJ1bcvffy6v0lYsMHBhZUwEbNacffk
    vBJ+KgKoc7ihlmDb9j5ozOhYu7p2dYK4YVIvewnQTtNGk+bUc2PFzgTG5sSk2waqBifC3B
    ppdsc+JO/Z4ch9tdxjscGTnRj4dT5Sn4YcD2xZWvOYHptPkdAhtPN2uD+lm6SdX15RB0O+
    Z+Q3W9H150hfp22G3fIwsFEfEvzL7d58m1q8W9pI/QU1Hm/MftRTPGNZyWMLmNS4XZ+MFc
    OEfwt2MVPk+hywYajU7U06hxDc+Mar9/GmZCXGVWGcvpi9aNF2UkA5cI9hwFx8qiq4hZI3
    vzyLEIUibVAHEz/qVio7O9+YBLaydjkM+9kN7dhkL2oKsTgGgerbcnoO/PIr+j30qTdrXs
    SyljK/p1Cy6Jxp68T6Kz+qqpnGdDtFPIGXLn7AyYxI8MejY+RQhsh/WeLycPYRHTpINunS
    GtakbJp8Obn/V0J9iMAUlruzgW6CLGEedKfSSE0i5LmtRyZvIlhJJyklBRq56OWT07xr7t
    fj9o1rs2NY9HQKTIinDDVuNGOM02Qky34BEwjRZFzfK/fDYudcW4YPNTq0Pw
X-ME-Proxy: <xmx:vPWOarLds34TeKzykcn3O4ftbde-cFeMDVNjQ1vAZwbLXd6xozEf3w>
    <xmx:vPWOav4fUa5y-BpDDwAXsDcxyvYVMshdUXNFo5ZT4Re_iJbHQqcg8Q>
    <xmx:vPWOav3xoGxEaTQEu1CigIWjzEiWVY3RkJ92r-LCj-4_R5gfx_qxGw>
    <xmx:vPWOalfNNGO3LPBgxLdgGooi7XVuXBqktzs41fcYM9VyWTeOnomF3Q>
    <xmx:vPWOaqRtBa09W41bSGD0Y-Q2krOBJMhboYz3MBe5rNayJCwaHu-WAlKU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 10:18:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v5 0/7] add more path keys to git repo info
In-Reply-To: <ao6UWnHfOK9VkD4n@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed,
	26 Aug 2026 09:23:06 +0200")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
	<ao6UWnHfOK9VkD4n@szeder.dev>
Date: Wed, 26 Aug 2026 07:18:34 -0700
Message-ID: <xmqqtsohj77p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> This patch series depends on "repo->prefix", but it's queued on top of
> 41365c2a9b (The 4th batch for Git 2.56, 2026-07-16), where this field
> doesn't exist yet, resulting in not buildable commits.

Thanks.  Will queue on top of more recent master.
