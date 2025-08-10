Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464F635
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754784395; cv=none; b=sbHpWXXmCzrMWxJLnjbHGB+1tqO6i6OiLSEgLx4X/LfkQnEZWHBYjGraxDDK1loPLoWiiraNAH4vi426mbTOKVxgua0fCSGknKUYfufXALFkwyyoipZTB1iKdjQppeYPRQVMkgRY5wG1xA/JmGQAJ/1sDJk5lkFmMkTMgsxIDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754784395; c=relaxed/simple;
	bh=50kkAUoM6A880UPGspaz2YM7AOKFrh8AzGykdh/QDDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VCUZsIo7Cr7PbM7K9TvUWEDmEyp3USW6PKLpWCJplMIVpgf68SH36uZ2Wm+Vf9IssSNAgOi/dEuk3bUnNRr2uxv7T+NVcFvvKLQIP/4/Bq5iWS4pwBjyCyfPzdtb0KOP6dbTq/EepHhCUg7K+zUfsO9tVScexY1schX5UQ3Gqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gy2gkwxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXl/j2Gd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gy2gkwxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXl/j2Gd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CE20140004B;
	Sat,  9 Aug 2025 20:06:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 09 Aug 2025 20:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754784393;
	 x=1754870793; bh=L5+d83yowe0mD+C6ByOWvbuqh7RBpgL0bL0xYrsqMKg=; b=
	gy2gkwxezMBQzduoQ1F2895ISxvE9q1O4UPHtfpeZpxAPRBOhrwxAFcaR9APKWYX
	niX6zM3i8MKP88wW0R38xy5LIGzs/UdH6hCWE1izdmqmkk33/HHV6/km++DEjMYN
	731B9KlbXFVC/WU1bLY6ur5RYA4IJjdYGhEF/Tnp2lns1Svb5wgnMkRALe/lptlC
	DGBmJRtQI4SkuJSWTczJKLuzhz6mb0lbOD641mXw2trXP4Kns7sZG/yINUJyFLf4
	K3qfXgZs5+/yTLJ1E9V8XtvizHDjkX5Uvl7Hhiibga/H+RGXVDf/NKPiGQ4gDboO
	PLc8JX+zDYyeAwCuhaWujQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754784393; x=
	1754870793; bh=L5+d83yowe0mD+C6ByOWvbuqh7RBpgL0bL0xYrsqMKg=; b=U
	Xl/j2GdYmqDQRbAvXJoEhwmt9NKXnVyV9Spm+hCb661nLGU5mAYnOX93EqLsXyBz
	r95t/0+sOEPH85q0Ajtdv+UCdXpc8sClYAlzFVjhLeDCm+AUQKWhzj6pGFPJXKx/
	TQVNr/6X2Aky7ChjNvtXW4vodyLTqFaVVEDY6Xld+aVoc25fmvaRpe3ghZXUn0R2
	78r9rxlNwgEIbYhxOsxpEws/kuX+67n4KhENqLotlCnhdrwI4PA8ML6hEjt0X78X
	yDEABBLjAufWwBHcmQ6zac3qedDUpLE7MozkkafK0/G2F5OxaCKT9dTzQCKJVqEL
	RKxwQI5DrOSFMG7rC3ZDQ==
X-ME-Sender: <xms:ieKXaECoI9vJYKzSc-Rerd6Q1QMahS2yGFfpVhK2cL9k3k3JmfkBfw>
    <xme:ieKXaBExQmBhGfnsfOMh8J_rBawGU5SAnMio-GbCItKEbjt9-y0uImN_IZ3l78Mij
    theAFTYnXWbuPtk3w>
X-ME-Received: <xmr:ieKXaEI4EEcDdEob1v5b4HDw4dbj62sRerAEIQU_qQ10ygsR64M19x1ABjW0NIXk-doO4UZdioYiYVzheUE1-FyBDnAEIF8SomOtV7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:ieKXaNl1jJpbNbk_gRud_K9oEehxG9oT9wtAkzeM450rhmvAFp9dAA>
    <xmx:ieKXaERxUSAajul9ZPivVebHArpe5SavuF6j8J1upTE1JMldQwMWRw>
    <xmx:ieKXaHJlC9ltKFfc6SqxD2m58U6H_bqH6xAuhstA-zW5gLRLeC7mow>
    <xmx:ieKXaCCEQyNSpzz7_8qHwbmf3wb-6uDNHHAkSK2jJdVcsYOPEtooEA>
    <xmx:ieKXaFTW1Ify8tg1YiRU6BwjWUNl1yvjYE9gaPT0sHANdKXArMmF1ibg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Aug 2025 20:06:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
In-Reply-To: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 9 Aug 2025 10:29:16 +0200")
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
Date: Sat, 09 Aug 2025 17:06:31 -0700
Message-ID: <xmqqectk59bs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> 2025-07-15) added the option --start-after and referred to its argument
> as "marker" in documentation and usage string, but not in the option's
> short help.  Use "marker" there as well for consistency and brevity.

Great.  Nobody seems to have noticed it (including me X-<) primarily
because the command is still listed in t/0450/adoc-help-mismatches
file.

Thanks.
