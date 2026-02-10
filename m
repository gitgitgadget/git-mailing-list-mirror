Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EC319610
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730141; cv=none; b=pso9j5+RypuVFisDQGVt695WuR7FlNk2+9lxY25NPDleLqtxm+f6g/fR1eptD6oWDlenaoHjOVoHtzDdsbxh1tNc/svA6bCxdVIg2ipWymrroCHuSUgEf/C5DfsbLBMU/jxqjBa/QCTBMtNOxMQtSL22cskHLx/trsQqmUYzPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730141; c=relaxed/simple;
	bh=UvYc1TsJnppB54ITsQD5uhzs8pR1td/tcAqHpwkPrEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXoRpfI8Q0uKu8ezsJtXVxAHNaIWHIQLCbkBL3pEotSWrJQdAwhSE5mjgf2NWe89rme6J/UqJCVYoG7BSkTOP0xflJkYUsbUpsSn5hFvg/VgU6Zxm+xIchZK0o9MORYbZZsUGhF2SZZpTDE/XZovLu7MgxjO0iTBSo1+E4WCVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lmimPV8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eS1/+Muh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lmimPV8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eS1/+Muh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D986F14000CE;
	Tue, 10 Feb 2026 08:28:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Feb 2026 08:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770730139;
	 x=1770816539; bh=wFoqXtX3y0yq33daDWg1li2XCn4OduDJ915vpGC3NSs=; b=
	lmimPV8F9O8tOAqa+NGZA6axeAFqrMNYJZZY64QdzuvsKr+VCwmXOEK2nAsRvmXf
	4CkjZRtuSNCK151qesOy8Bk8MbTBtM8OkDkI3FPZNescFMr1O3B6KT1ZfUEW09JT
	4CjD91Gv6dna/IuGKbpX4gejVwvxBwZzqk6wXPp7Iw5rO4cTCItTdgDxwTLfJhpB
	JqL4zPkriDiT1tVXKa4VDFgznwYUpuyAy/e6ZkGvJdNNITOlOBrC0Y1BgyrfNYtG
	bHA11S8Nlwcmqx/mbAGKPkWIRcJaWjmkq2hPVO2vhpHInN/oFOItQjFs47IlY7he
	HODpzCULhcwIyWxNqA7oXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770730139; x=
	1770816539; bh=wFoqXtX3y0yq33daDWg1li2XCn4OduDJ915vpGC3NSs=; b=e
	S1/+Muhyf1iuYCBHo+qAhtCFVZwGobXOBhtefSocLzf8Jj9Umnp2X4lKytvrd48G
	VC256PS8eCW9VHS5h/Bq7iTtlqRg0nSbZVLa2WRN4o250IGDxJqwCOeRdJ6McyEr
	zSLwjOR03Twhw/QVyDkS48T6Nujo4/Pm3P0HOk3Ce7+UL7RVGPeApWuPUuNxeqC9
	BrZ630zeYao+UhqlYVJzaJKerD+olMOtPIf3bV1VQzdQWgXQaF+ekPnImeWfeiB4
	Xmw4CUeI26kI4L3hPIVQqSkWwn+i/sFoOSc5JfLm0lGHiAcQrpNK1dE6BZAoTMRN
	u8dmDqHpKm23wDkgh/Lrg==
X-ME-Sender: <xms:mzKLaVY3qf_xRPxN0RkzAiNHX5uDgq-MSOiYVDOY9oZofT5unMMJiA>
    <xme:mzKLaT3L3Stidz_w1zlrXUFguVOGmbiqOKjKRfDWkJA5G4U4O8jAcAAWsM5AUVtEH
    I_GT8kEl9uMczuLvbDIsIKVJRUmrmp0R7y4xyk1esEKmjpkoGkZIw>
X-ME-Received: <xmr:mzKLaVVfwmjYMmHRV3ivGqhmZisG2WHL3IhWGwWooiDF4X-ogAO_mE0gxgFNwRZNDG_f1rElVhTpJsWeCWlVyWWFK6a5B_vgBAvyb00vJBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekro
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepudetheffgeeutdefvefgteehhfegveffff
    dtveeiffejleeuteekteeujeegkeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:mzKLadV4j71IBJSdCqlXzl3-AZNQFY6XCS3gxRxDrhov856cAYTU0Q>
    <xmx:mzKLaUdMYyFWZ52AlkcjfU21YVP-Z1QY7FeQmEnf1Wl5EbBD_NTFPQ>
    <xmx:mzKLaWXF1Fv4MrRkf2aM66-FV-ivdidMeo8MWFqFjdg8gga5DjeRZg>
    <xmx:mzKLadfT3z96Th_XY7ZhEGp3XOwBCnGvfSb7ZoIYA4I7KBfgxBITcA>
    <xmx:mzKLaQe3JCkqFUeN6suOMubkFHBKtbKCmabx2cc17fyXlPUg3VpdoccY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 08:28:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6df1572c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 13:28:58 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:28:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] xdiff-interface: stop using the_repository
Message-ID: <aYsylzWZXkKIYzOz@pks.im>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
 <59fe4ac7-605d-4eae-b13c-46996dd8814e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59fe4ac7-605d-4eae-b13c-46996dd8814e@web.de>

On Mon, Feb 09, 2026 at 08:24:52PM +0100, René Scharfe wrote:
> Use the algorithm-agnostic is_null_oid() and push the dependency of
> read_mmblob() on the_repository->objects to its callers.  This allows it
> to be used with arbitrary object databases.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Change since v1: don't add unnecessary #include

Looks good to me, thanks!

Patrick
