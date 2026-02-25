Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81B1F5437
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040332; cv=none; b=BQjxLeFk3a2HxwMK9jmoPRfwi32O+QzOHdc8UfLOoGFQoeNZq6pHxFAyiDtfiOo0dAjsPDDXvyDsDSKQY8/HNqKHFHmaB4YfcRyKTbCC5TW4o0gb2GrPgGWCyMss6pkICqSYy3rh0yOxPAx1IARTWTXtDHqc7uQgHXOfsx+vLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040332; c=relaxed/simple;
	bh=+hztWcQjhfzDkN/8uq1fYI16dPttslFvsUfSaNRxQqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DUkKPomeuwcD6LiQ3wHq0IeHU5Zyml2ezUouna9fHK7kPqPVjB8wE7spxJbjJeA42mQyqyOs53ZovZOR/PyELGNZKeCzGkTdaOpvTjMdn5TND5IU9Ndx7jXHYx4qr0P/bY0gH8T2dwSQQSHnvmSUYztjS1H9y5Y2/5pNp5GWpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CSm6ptHF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PtZmG4f1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSm6ptHF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PtZmG4f1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3AFF1400143;
	Wed, 25 Feb 2026 12:25:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 12:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772040330; x=1772126730; bh=SGrNJRZ27i
	0v88LmxJLqT+GCu0UGo/n5dYSR54NIw/E=; b=CSm6ptHF5noSdwnt0RBs8fe3h8
	0lJ7Vc9ej3sFigVQ4vpP6Tz0XiGLqfcrB6UkxeSUBo+MuYlFa8ByWhfEXntDsLvg
	OmRquw6+zfbySCjOQFkuga1GwXeAYX/vtUSgznCFA3Wgv1IU93D6sR2ZuAXCRHSM
	0KyRQo00wn/gsLSDEy4qZyXfoSo6IxCsMjVCCxb26CBHl6c3Trfo4a04dW19o+Jc
	nj7/SviT2EQ88JlcnMxJPYjQtCBR4TRNrLB61hOfLaMJKOQUzKPUjOBK8yg1MJBN
	qV2olA/oCNpLo6nk3t/dLhi6ZFl1mbMIbT8JsJ5EDonmEzHJA9WyY77qKodA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772040330; x=1772126730; bh=SGrNJRZ27i0v88LmxJLqT+GCu0UGo/n5dYS
	R54NIw/E=; b=PtZmG4f1vdHWMjAc9MlLw7ifxyD9FoHjfHPJnOs+ZOJwHIJE/JA
	oGm8Drm2nX1/t2CmRCNKkInQLuRDqFfg76hIbBgg5r5kmZGHbo2bLmaJmId6Z7Ir
	dSpy4k4aUQ2cPTw3rgNqbat+gya/+QfkpEkMkFVx5WN0OWCHt2S6N4nVYYPL829I
	NHhUaeNfGT6acF8JRYFa/tsOb+pyPUeJLw/cL4GKLzGu/DidVMaG4wuWPsn/tfCU
	eu4Lj8W9Ho4BiP+HrsE1KTq6iQl7hcXGarE7x9MbKzMlXbxMhFq0C4eo0IU7ayRv
	w5dq1DvmHgtazuVLNHbVtSoUWbYejweKb0g==
X-ME-Sender: <xms:ijCfaYdF_3IHtbpn1Qnpq3q6uIHsDlri8g3rHj9JMiOuWQBjBLtlZg>
    <xme:ijCfaROlytxM1_419pBFwmSHIvRUUkyj3AdKcWgv0FmSNujE-__WVFm04uOpkTKJs
    9j9dDLrMFXnFFscRwOYVPKZvksWQ5TkOXS7bGHoo8vIoBfdGfaDxA>
X-ME-Received: <xmr:ijCfaehoBSgA-F8rPTvJQOauQ5CiD0wDy5WRprhgSQPPXocLVMea-hvil8SzU-G-SbdjytGvgsKQKULs2zzIfaJjUeSNQWtrmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ijCfac0ojqWIaX5twUSBGawBPrg7RjmxHeTV_OmknFrN9Q0zkB_r8w>
    <xmx:ijCfaQjDbEYcNjkGwSjt4QJN2K_wUzFM6Mg3V7aer8R_QZdaU_uEig>
    <xmx:ijCfaUeIfr3gUob6EjFELa31ad8zN61y1jmlxjppYLxCkDrrvS_gTA>
    <xmx:ijCfabnjrhgXUKDeXoH5CWmU_urRjMaXdplXIuLrWHWgdCbUGXyAFA>
    <xmx:ijCfaRheCmfkoCpct5EnIMju0gGhtwdlOokA9NTM4T3DOtGT9o7G9_fl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 12:25:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] format-patch: add commitListFormat config
In-Reply-To: <aZ46xqCusF1av-va@exploit> (Mirko Faina's message of "Wed, 25 Feb
	2026 01:14:13 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
	<xmqqqzqaggln.fsf@gitster.g> <aZ46xqCusF1av-va@exploit>
Date: Wed, 25 Feb 2026 09:25:28 -0800
Message-ID: <xmqqfr6oburb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>> > +	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {
>> 
>> Overly long line.
>
> Will fix.

A minor thing, but using starts_with(cover_letter_fmt, "log:") would
let us without having to count the number of bytes in the "log:"
prefix (and we do not have to keep recounting every time we decide
to change the prefix used---which is not likely to happen in this
particular case).

Thanks.
