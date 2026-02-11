Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2E36164E
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843945; cv=none; b=hLGo6F0Njknouc/dFWWgLgTaZk50dYaSWYP3l8zydNYHi4ep+ttqvlZfdEfv7Gkkst67yTstTDXN/Y/a/blJKfNQSo9e6IKHTMhIgPZvwYXnlcrwg3gqFOAePpZKZfSl3s6TWGeSGCS3UqAPwK9QFni3ZP/kvm35m2BGOuAoDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843945; c=relaxed/simple;
	bh=ANC8JVRgDrAyoS1lrr/OPQmvdWdRgGJjdR+5AL8hW90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jiu4sUK2hM59g4NDfLAo2sxlZpD7XUDRjFO6CXel0HCd6x2CUnSrkf7GST1Gr5S1wk0+ou5FozGl15EMz2b7d9W9E0HkbakKie2tQZAg/d3jdP8djJMFxoVyll3b8kZhjVNSoQMBWMyKo9CJohdsCVUrrp+6/i/5mSkfTu50MW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SshlJgiZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGBlVXg6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SshlJgiZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGBlVXg6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63AC17A0105;
	Wed, 11 Feb 2026 16:05:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 16:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770843943; x=1770930343; bh=wKP0gQKjAz
	i/0m/ppjoaQL1P9caEoU1Qh9FNyGLVf4A=; b=SshlJgiZECqoa1vNalu7PzlvbD
	cMZY9oGHBzgRA/hcVKZk38lWfU0vscSlEtu9Yv80zjB6uboyjL0sSB/sSA6BSxKe
	a1KlMHO/OCWAGgIvZaOHFTyYld+4By4GO5xWdGgVvqJoEIDdW024ToSVeMBkky/M
	W3KZ0Dt56oxZbL324V/1FbaYk9vF6QYn9uBq2tN6FueShARdhnIFmPqY7uvpKWfn
	NtcdH2C4kzscHkj6qNCN8X5M9jDKTEyNpMWyytsojijXi5NU7OObeBu27EtVClU9
	GWMnOh+oDP5JxdkspI6WFQw/oi06pmE4bGow66UZkByg9CT0sahp5UGSquJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770843943; x=1770930343; bh=wKP0gQKjAzi/0m/ppjoaQL1P9caEoU1Qh9F
	NyGLVf4A=; b=hGBlVXg6ShL4D3yrp8RpvwRPwhh5W+a4SP5wQwOEjFJUbqmPWZW
	HbjBpe4e5Kr/bYHgyuaEzXKUmstFLJWdKB8CKu+0mADh6VQoFrFZCwM80wzoK/7H
	nredfyDjIIxypVIt5C+a2UUsyMRw32Ss0CNSIkfFicafjbhih3bCv8m+7/85H8jg
	InoCEIjkMGz0bPqSBcXXunr8kcWFm4m7nwe1LH0WiYipa8uD0SeGmyWWWA5aUu4A
	p4a1Rfa631t77NDO9e6kTjVpeDgEzaJtTmCV33VT18vUg4UyefxeLSJxp4oDta/m
	OaOh5pl9IZlqCyXUomZsvLdnqKrdxmpKXOA==
X-ME-Sender: <xms:Ju-MaUrzMs-CAmIP0-bIryH7rufCTJufJRaso3tLrdLnRYJVp3IhyA>
    <xme:Ju-MaRj5qo7ejKWh90eN6rdw7L5-0TWx83SqOS7aIF1QBL3P-H5zi-NGZ7XW7N-hV
    4Jy-wxGm_AwucEiq0RUg1JDUr4o-BomLaW-OMQbfamBIoZoSezF>
X-ME-Received: <xmr:Ju-MaRgyym_Hsf6LxSGzSROYeeqVxmSpCFNdoenQJbaU5JRwNVsEi3AAJILaYFrPOZMBzkeMVaoSkXwnvaf0lWDQ6EBDJENHyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ju-MaXgO2sUcptQItqyhlC3tKCZpzS12H2ZbiMU3BDaR7OD6NkaTHw>
    <xmx:Ju-MaRK2jcJLRnXzXEcPoVDSWVOpa9BEK7fmA7bOfhjndBFVMmekFQ>
    <xmx:Ju-MaWELf6CVSLYiSN-UhZq9bFg1veLahdq0hmBzE9LwkUhYdlPr7A>
    <xmx:Ju-MaVRG9mtVLIevdN46wzdCgfdtKEuw_u5VaPryKUB6KSSub-rqlg>
    <xmx:J--MaSRRnBcbQpc24Afqd_HKAa3puZnfGBdKxvkV6yQwJ50kCcwnrYyo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 16:05:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
In-Reply-To: <aYYLLI2Gb7YlBtKt@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 16:39:24 +0100")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
	<20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
	<20260205093748.GA2177239@coredump.intra.peff.net>
	<aYSFGG7lCg6Sw8vy@pks.im> <aYYLLI2Gb7YlBtKt@pks.im>
Date: Wed, 11 Feb 2026 13:05:41 -0800
Message-ID: <xmqqjywjrnx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 05, 2026 at 12:55:04PM +0100, Patrick Steinhardt wrote:
>
>> I've created https://github.com/j6t/gitk/pull/37 to fix the issue,
>> thanks!
>
> The fix has been merged upstream. I've created [1] to verify that the CI
> now succeeds.

Hannes, I see that in your tree

  https://github.com/j6t/gitk/commit/ddae547e3775638c238c11f30120f1e7e763fba8 

has Patrick's fix.  Is it a good time for me to pull from you, or do
you want/need to finish any housekeeping tasks like tagging before I
do?

This will hopefully help us unblock one of in-flight topics.

Thanks.
