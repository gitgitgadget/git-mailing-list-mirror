Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779E1EE7B7
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260565; cv=none; b=aoKve1Zx38GDH3G/PbVS0NuOQ6RpYConvsmnLsl79Lm/l78PD6L2WjL20qbmGBIqLbAHQhDCKIMZb2zYRKqG+gODYQBeSMzqwTApYM3aDFixJ/PcV6cD7H+0z6Ks1r8bf3FXlvTgcWmXFpnA82SaHJq1YgCIEiTMR+yCuRVRmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260565; c=relaxed/simple;
	bh=NaaJ4LnwjdcjojJY3lLinXKDayV1+6jNG/uuYfF8epc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STHqvoMvvKw7ALRl/1gCTjRrD3CX/NeLbPnJyg2TgEkix9wnJk59rP/GEWxkyQw+3fqEnIm4OFRxaEu08DQDzQqFrrHfzQWHDdLXiBdRaIlRqgxhfQ80RJV7WH2g9gRkIcwkNpREvvj3y25XbLYn6yoxR0FxCg2iTDHLSpe73NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oZGn0/BQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwYRVYFt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oZGn0/BQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwYRVYFt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E4C1114018B;
	Tue, 11 Feb 2025 02:56:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 11 Feb 2025 02:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739260562; x=1739346962; bh=257J2dvC4W
	aywz/5hZ5bZalFlAORmcOgSF3UpEtHO94=; b=oZGn0/BQrNsxMlkXWoXm7b18BZ
	8hQnw3yGhKEr82A3lLLFK/GHAhhMPoxwLthaA9anvL1YphGEF+q6DCvbsf3gkqig
	USAiuGnezIKelQORyQRDHbtLZHXGirRP465ut+AO9oMHT0XjibgoToAud0Ugu+zz
	tBA9JpenE6UOx3ZZp13vGW9d3HzWczrw6z2xuB+/gYv3Jm+voiI0trjVgQSj2mu3
	b83Lh/fn02g+oJC2jZIDodJDhEzemNHy2P03aot7wDdeMyHmfxO6AU7ulejWennC
	DvnKwRWF/xwFIa4dKXRGWwanEgx28iH4bDtUk8OuCAun9fObFdUyPnU9uArg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739260562; x=1739346962; bh=257J2dvC4Waywz/5hZ5bZalFlAORmcOgSF3
	UpEtHO94=; b=OwYRVYFt6pESjIbyNa09fFNpfwIXsgbQqdxMdsPLrdIfacBOv78
	IERRRSaHGSn4/QzO+m4moZYmHrcKrOHuXopEkhkqfEGpXNTah9X7tBF20o8H4dAE
	Krt6s9B7f5xXaYGI/gx8W0O5Rhq8idvgSySd+EmPPQofdLg3qTNrPE/jPoPU+GgJ
	yWjfXwir1r/PcHfOeMogZ08pKikDaGFXkvb8gOgP4CKhfYdDy/X9Yi2ofaACYYY/
	K/pLb6urzBQ4r7q/98LN6fVJr/asB8qHgVJ8b/kYadanX2TwnXyYlPQ4xEszd8Y/
	sk7cfS3ER9MOoquctL+bHbTsx5HWxsenrWA==
X-ME-Sender: <xms:kQKrZ8TPJ1_flLIcFcA3bKgf5wiKvECrdkJBl7-eRkFc9YuMrstxhw>
    <xme:kQKrZ5yqQxFxjpuDpCxbgDgoP-no6B6RQC5w-_UrdKztgDWQ4RsV3Y3IkPpKZKGMk
    4QzZM9PE21iTuwqwg>
X-ME-Received: <xmr:kQKrZ50kSKznzGHDpst8Nf7Uq-Kznc_danJ6Krf_rVap7CbQ8kUb5bBO6Zexcweh6iM9Ck6UbOS-zG3otAsUngGSUtTj8MVx1V-7W96uYnv6CKw7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfohhrihhvrghllhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:kQKrZwARPFeHfl5ZECtTRAup5apFT75WJQ0A2d0XljkHC9VzXDytew>
    <xmx:kQKrZ1gBHQR2SGl6142UUHbohDFvdvM_5SYLqh12Ghu52mWIxssF_w>
    <xmx:kQKrZ8o-ld1Ut6b-DciksbG8oJXgAx_9deqVBekjE-uyhevwspRw3g>
    <xmx:kQKrZ4jJyu9zm1FVpeBtWIpT8MTZMzzC1LcrNuncXul18mxIDjUrTA>
    <xmx:kgKrZ4vhFSLzuEohKTbVxlMUw6j7OBhjAAX0eZyd5YX2OArUFScq6P_D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 02:56:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfb14913 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Feb 2025 07:55:59 +0000 (UTC)
Date: Tue, 11 Feb 2025 08:55:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Emily M Klassen <forivall@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
Message-ID: <Z6sCeYmljrqWRFnS@pks.im>
References: <20250208061702.88469-1-forivall@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208061702.88469-1-forivall@gmail.com>

On Fri, Feb 07, 2025 at 10:17:02PM -0800, Emily M Klassen wrote:
> "git log --graph --no-graph" missed cleaning up the output_prefix and
> output_prefix_data pointers. This resulted in a segfault when using "--patch",
> "--name-status" or "--name-only", as the output_prefix_data continued to be in
> use after free()
> 
> Signed-off-by: Emily M Klassen <forivall@gmail.com>
> ---
> I previously reported this a few hours ago, and ended up digging in and figuring
> it out. I'll make sure to bottom reply in the follow ups to this patch.

Do we know when this bug was introduced? Is it a recent regression or a
long-standing issue? Might be nice to point out in the commit message if
we do know.

Patrick
