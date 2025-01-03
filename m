Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE601FAC23
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921308; cv=none; b=Ti/F82nueKiW6FmbqZv6ru8d1A73rlPJDbVtm3Bwl0N4jg1BhEh9wVKW9oLYBkr4AoTbN8N82c3CoACDH1NOJE4hVv9Q4mA4bPwTqwguXQ563UBJO9YPe0h7lz53jW5e/I8yj6vSi5dg1cuVzP5RgB3hOAwtqVDNrWQ1tzl0KkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921308; c=relaxed/simple;
	bh=wLBdhJOAxTeYImBi+XJ676lhIWB19w3U8F8lkW+rI0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRfluj04Fd8PDRCjqRFzV0VjI0oQsccrm28PVWcyPwAO2z4/KRSFb1W6mKdGx51ODwWK1uDT4SOPvgrrgqe7bDRAovxNj+4xG8hwoW/vKpycq+6PpqzlM3j+gdb18KxSv59hRP2FlodQpMArmdsprDLHxgb+xmMsMWwyaaQXU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dtB2xarC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/uSiJYL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dtB2xarC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/uSiJYL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B19F254013A;
	Fri,  3 Jan 2025 11:21:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jan 2025 11:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735921304;
	 x=1736007704; bh=wLBdhJOAxTeYImBi+XJ676lhIWB19w3U8F8lkW+rI0Q=; b=
	dtB2xarC/MrEo8M8yCMZ0OSkVCIe+KiN8Rl8zJtv50Ty0rq+5CZ8KzQJKf/zfcDi
	cR/iWcJ1vjXaj8o1COKdNVhXUFtDrO+nihuk6handTh1GeqBo4zg1WdFIWMJ9Hzq
	nmKHZpt2ML7kniRJ61l6R3GQv37deHUy7CR66DXLByQNUeASlNjTCxwugMuGO+nf
	ZNVIDdjKAKmXZMPSlj6CM0B7ZREcJNVBXNnya4GfnKVKu/uqRnWi0Ho0pwKyvdT1
	32j8Ajx7GwTpldQKBvpaM+iXnMjhDCg60qdc64Ds9j3IfziLRtMqnTh3r/3RXuXq
	p7ThU7xcSMrDn9vdapEphA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735921304; x=
	1736007704; bh=wLBdhJOAxTeYImBi+XJ676lhIWB19w3U8F8lkW+rI0Q=; b=X
	/uSiJYLqKMbz/2Bn8CS92+xejQrn1uI+yqu+CccDY7tE2ECaXCQaSLhvGRbGNHpk
	EJbTwbkZ9SqQTlu7CHDR1c0AKGFAcuccqlTiv8adxVy/Bq5qTVyO5utZYxn52bjL
	gsHqgr04mZNHZlQ4T3noTIsOssUO0y+n+ewQL2AMtyQnaPaE+u3izXOfbPUkZtfB
	poHODSo4HFJK+fVv0U/11ajm53+F2UTG6q8YsYYtWg0aUO03bpyLsjwFfJytFoUU
	harJu7apG76HXbdQc2xYJPrBfYprXUKAtI8nu1GU6EJU6ChxJ4Ow2xdo1RBHKw/6
	i0dKLBE5RkRgYkzrFq3aQ==
X-ME-Sender: <xms:mA54Z3DqTdl8cua1zMXUFwXPwqMQEsVwyRnGw7NQxjY7GTVqYWMLZA>
    <xme:mA54Z9iNAw6r5odTj3SQ2q7QxBfoFyqedpdXCKCBrf-5ltBbBzdbLFsNdMd9sNUsg
    3kWDUL5QNGaZtmC1Q>
X-ME-Received: <xmr:mA54ZynNczOwysBiAyNUetlyLPvX6-HCSAuYMvznAd51jK26Sg39Z5FHnxxFHNLGZJBNaxsxrGi-u-bIma_GguC0loqgKQxSrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhdrrg
    hgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvghjrghnughrohdrsggrrhhrvghtohesnhhird
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mA54Z5ycUOcopc8ZQ9fZr58mmjYFkp2tJYLxQHgdR1_krayjDQFMXQ>
    <xmx:mA54Z8SaGs76DaQ6H4jHYNtWxB9ttSaVAIxsMKpPpO0B-l6ctNRjhQ>
    <xmx:mA54Z8aZ9s1t2j_bOVD5QJSlZ5p7thPqTI3PViGuz8WD8QNUHpFCVA>
    <xmx:mA54Z9TuTCnw1syJLtaZOKakrhCv4rYDvVQuuEh3vUui1W-8JWcJ4A>
    <xmx:mA54ZyME1qAzgoLoRce5pCPmFEAZZ9wYNAHoX7XkyhT11AB_9XO5dUJb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 11:21:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org,  Alejandro Barreto <alejandro.barreto@ni.com>
Subject: Re: [PATCH 0/2] documentation fixes for 2.48.0
In-Reply-To: <cover.1735903029.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
	message of "Fri, 3 Jan 2025 12:33:29 +0100")
References: <cover.1735903029.git.martin.agren@gmail.com>
Date: Fri, 03 Jan 2025 08:21:43 -0800
Message-ID: <xmqqjzbbswa0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Ågren <martin.agren@gmail.com> writes:

> These two patches fix some misrenderings of the built documentation,
> introduced during the 2.48 cycle. As usual, the exact current behaviors
> (symptoms) differ a bit between AsciiDoc and Asciidoctor.

Thanks.
