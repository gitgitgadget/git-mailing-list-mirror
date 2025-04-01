Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D72054FC
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519854; cv=none; b=nbdgWUwTGMB+TRcfti+x3Yp6hCU2WuTMSljG7cuJYy0qi9P7Ad97X4EEmU2A1Tm+N7JtIxAF0/3wx8cvUNq68BjWH7sjQjiIARGItKHW91GZJ5sJ6HReg2MQ6yQIKO46MQ+gnMHTnspCRw65eLHH5QQpLoRg3k/XJSxgisGAhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519854; c=relaxed/simple;
	bh=ArYP6iaqXnY+y8Tnqr7l/hlW9TjtrqZqHCkb6FkIrDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si7v8vksPL29IOlqGw6rK8fC/+0A0HpQS4hMYnJW4PlUXE7mPlb1UC+6W3Uy7W/q4T/lzc49OIE2v8IBWPA8q6eyYY5qtthwuM9UoIEkZTDp6CIjD9fFgryYdkMAAyKYNI6USFGq86PVqqZFE5S1YIX0XB9gfQLhFgkc0AQfAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PobGZhUJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcK4P0od; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PobGZhUJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcK4P0od"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7219213846E5;
	Tue,  1 Apr 2025 11:04:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743519852; x=1743606252; bh=ArYP6iaqXn
	Y+y8Tnqr7l/hlW9TjtrqZqHCkb6FkIrDw=; b=PobGZhUJG1zTiWtvlsD6Mzat8x
	08/XSZs9Ln/X9qYXKHDqRcv9fCR6lZOVWu5zXEPh+rijoE44561u7h3VcOgKYqvv
	cYWIJLrcN+V9zT86T0CZJLXy6BEob5TN43DifduRTjUMxkBvqG++Z6L1FA6qRd+2
	3z2aFQ8oy/jE3X6OuJhMQO7ZTNhqLHvlLaax8FJqADyVUL0BRJbVLNNtgjSCJjyi
	gT3jT1Zv7yW4YkiIzeqxqqRRmb9TU1+P0wcxsLp/Onuh15q7eTG7I6ssIEMeilUF
	Ecb5wVyfkN45ZiMU4IM1JZ8ikvI7uG89Wlm7HKxaQ3UrIO1v5BfsuC+Prvrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743519852; x=1743606252; bh=ArYP6iaqXnY+y8Tnqr7l/hlW9TjtrqZqHCk
	b6FkIrDw=; b=kcK4P0odFuz5xsMEP+38R4XZ1JSNBGlISF170ZORusL9a7vG3bw
	KxXmvqV0MhKWyVhAgbZCCd+ieVuuEbYBpcswXfn3An+3wTeGudCqs5SspXlP+F0T
	e+E9nT1SltAeuRnDfK3ZjE1lSLXX6TptOatnU2WtpioHL3I5eW94UzD6/KHZwWuv
	TnFC/OpzEVn56AOqF9X8O+TmD/cptS8sj4AwIIUbUA9/pGveSmj0m2CpxihXF2yx
	SlbZXjQDDAbfGOXDzNYn5+eHQVQQH8vcxTzBpGTrd0YyLMaF6UNi5UbGgelMe1CU
	wHCCr8kbeROKQPJlDi7qZw/7K+UHEH0GvSQ==
X-ME-Sender: <xms:ZQDsZ0kNgSiJ5Mq1vM0ldxa1UemmthdL_2gSvUHbEzr05KiIcAo1hg>
    <xme:ZQDsZz1aJAakFeO_T3d5h9kMjL5bIbLf5hAK4MueISOPQdi8s5MbIjRIFYOLLKZ2u
    xPLaU_VzGRVlUd3Dw>
X-ME-Received: <xmr:ZQDsZyqSKVQU-oFTyljr4lMAmIYYpmLoatSxEfz6jjViEi-EFqbqTDKLMipcowMZtRI8tepDgwWcphQUD9DHkmuzgtyk9PHrvL7wd-JCA3-TnCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepuggvrhhrihgtkhhsthholhgv
    vgesghhithhhuhgsrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtg
    hpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehglhgruhgsihhtiiesph
    hhhihsihhkrdhfuhdqsggvrhhlihhnrdguvg
X-ME-Proxy: <xmx:ZgDsZwlkoJ5XegY4h4t_PF6vpAWZTOyiXMB5hVsC08opfOi_1h85XQ>
    <xmx:ZgDsZy1yuuYWo05x63ZTsHygNCZIiqYBiV9OS7HJ3puA_qtPsADUFQ>
    <xmx:ZgDsZ3unWYjxnvfHxj1SYTE5pkp_t1jLJML7H1WI24ytg2gaufxUrg>
    <xmx:ZgDsZ-Viphzw-l3DwLd7ziK8KsdNegP2n-pPST-cgh4E83mLNJidyQ>
    <xmx:bADsZ7nt_I3PuMIRnDBhntQkYMbCjUb5Uyb8wlKrYgtOxGhPGfC_swZ3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 11:04:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bfc47f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 15:04:03 +0000 (UTC)
Date: Tue, 1 Apr 2025 17:04:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Todd Zullinger <tmz@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-wAYoYBv-ge10I7@pks.im>
References: <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
 <Z-qKGqpbdaW9WCrP@pks.im>
 <Z+rcVY7KqEuF1wFw@szeder.dev>
 <20250401023358.GA1087913@coredump.intra.peff.net>
 <20250401031030.GB1087913@coredump.intra.peff.net>
 <Z-vRQ-FNv7WD02hl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-vRQ-FNv7WD02hl@pks.im>

On Tue, Apr 01, 2025 at 01:43:37PM +0200, Patrick Steinhardt wrote:
> I'll send a patch series later this week.

Sent now via [1].

Patrick

[1]: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
