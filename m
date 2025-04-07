Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9424BC07
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029069; cv=none; b=KtKbAEV6xwV85rvP0XowfkeBABPYnNKcqUyP8CMiKW92bK6OgYoeRyfuLsi3N4xCTRw+lqXa6EET77GBnEL8vSKKm+CBemPPrzoEfo3wZhpFOeleIpz+J9cO13BmwW2Evr5Gslnae0PaIWfSxB51ZpakMhc/YkII+8KoaK3ca2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029069; c=relaxed/simple;
	bh=0QbCNUKLJugjlqhUMcWs7zMR+ykDjwIJ75oCTNvKR0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl96pq7k1f3BW+d22SAXu09NZVDCWtaVwbq7pT0Qgdbg2mYoHqpvQ0L4Vj81RdX+mQ3Su/+MzRVv1XUrOkO7NRLT5flr3hMa1q8pYRFgt4cCVD02GcYaqEFkDm4dotJAH9hA2uuMdrVhVETsmlu9E5rjmArQyv8+wS6tc9sWF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I4AMDoeF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WpU0xjoo; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I4AMDoeF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WpU0xjoo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AF791140228;
	Mon,  7 Apr 2025 08:31:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 08:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029066; x=1744115466; bh=zR6YvkrnCE
	gMtkB7k/c4n70EhkZW/BMFWSPqf6fhfDU=; b=I4AMDoeFVF9wHYFyUMRvImeJ19
	dbhxHY9y9CrQQmPk7dab7wybjhHIjzgzL1rGop1O155kGWpBf8gmoctXqiWqnPUX
	8386+AHO1VM1Wa8KRzgsjgrlvFmKUdZoFw5u622Bt7xe/Jt7Vc9dcz78gOQQ1SG2
	o1YJh+Gm1/nQk7e2l0m6R6KbJhHEofXRx5Gu2uQIT9lKa+Y37PEoOEQxEYvcakdr
	R5N676vHi3RpSwYsTZkbC7GO1xvt4RyIK508Dz4h0/C1PPBVToBxleY1K4wC9Z5R
	LpPx5/axb8TCBtcr2D9FjXRghW8KlDVBuFFAzgmSo8aAhGtroJEV06wNgmyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029066; x=1744115466; bh=zR6YvkrnCEgMtkB7k/c4n70EhkZW/BMFWSP
	qf6fhfDU=; b=WpU0xjoowb0vU9IW6GtcJiuJeZqtwQtUmWm64oXTW5tCZch/9cF
	ffL8RP+JfBZDBliOMJTI5fALpCdQtLYtMvFkixop0BRwuJ95s6BCIqDIt0vr5AUT
	QxViFZ0L4c9KpiWJwRQCnK5ZnN544gCDy4LJJyVGlPakz3NGqoss35+XtnKaLob/
	Uc6lQWVm9+uDpsZPbeYFHuhbT9SUcRZ5PssMxWO20VL23dDYeDT+zlRgt77cWkpo
	xJR1PdNa2/Ycn1tKHfmpmcAlNvMw3RFFKrj+U9zp0MLX/vNKsOPzPGONfCFXWcUi
	wLb3FDMqCFaIOOiYnYdxo+x04Z8HbtRHMZg==
X-ME-Sender: <xms:isXzZ6jvZ3K6SxFhpzHJSOrO3FusbpLcaWMsBvX05soqj25x2ahEXg>
    <xme:isXzZ7AWaP7WlsjEINrV6jY2sLfdxESoPwyWlpwhC_Wtz3dMsuiUJUcLxCvXgmBRI
    xFjb6oIkMo5ftWCag>
X-ME-Received: <xmr:isXzZyEhVFgTN1U8Azt6TfCp3ywuXdgmPridIf6qFPCJDz0C1-umXnzR1kAIVKYwI03WFQOgCeaw3s2K3noLYhes5vQrHrwnXo8dFLeQUvVxWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:isXzZzQt5Z5N6roqsAjUkV8lJozqVk-ePDiPlJxOt6FvPHb3RK8F4Q>
    <xmx:isXzZ3y7ZI4Wh_Fsegcxarph2gX6KYFexgQU2_xiGBEXEKiY4-Oa-A>
    <xmx:isXzZx7YiwDq4jKm30qCTVq37PU--wFyBHLNmfuD4wR8EvQ_aS_WCg>
    <xmx:isXzZ0yK-5H33bOcSUEC5RRUfTF7bepgj8f6Mgmo5yc-EFORW22Aow>
    <xmx:isXzZ_N_qmPkDZ0xaGKsbt826p56bfE_CFpRVJntcTFWeHClJA33JsJk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:31:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6d8c044 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:31:05 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:31:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/16] reftable/block: store block pointer in the block
 iterator
Message-ID: <Z_PFiKs9s3R9pVW6@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-10-ebed5247434c@pks.im>
 <u4h53ukh5uxk4r4zy5iyniob4xf7qmtem7j2kp45sknfbljwuv@ntdojrh6aakb>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u4h53ukh5uxk4r4zy5iyniob4xf7qmtem7j2kp45sknfbljwuv@ntdojrh6aakb>

On Wed, Apr 02, 2025 at 03:56:30PM -0500, Justin Tobler wrote:
> On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> > The block iterator requires access to a bunch of data from the
> > underlying `reftable_block` that it is iterating over. This data is
> > stored by copying over relevant data into a separate set of variables.
> > This has multiple downsides:
> > 
> >   - We require more storage space than necessary. This is more of a
> >     theoretical issue as we shouldn't ever have many blocks.
> > 
> >   - We have to perform more bookkeeping, and the variable names are
> >     inconsistent across the two data structures. This can lead to some
> >     confusion.
> > 
> >   - The lifetime of the block iterator is tied to the block anyway, but
> >     we hide that a bit by only storing pointers into the block.
> 
> s/into/in/

I think "into" is right. What I want to say is that the pointers point
into the block itself, not that we're storing pointers in the block.
I'll add "pointing" to clarify.

Patrick
