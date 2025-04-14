Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EEF2580F4
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617318; cv=none; b=J2YE4Z5oM8ZFTZDijNtGX+G3Em2r/inkoyauMsrujHzCurg+euYtZyLWBJOAlXyIZbrZPcJXJiLW8s0VicT5yEHnmPV9s/bhx9YKYFGhfkiAs5AG0NT3qP1A025A2ZPIQTKl1WNpzZH67MakciphLnrefFYlxgH3GPpo3/5WFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617318; c=relaxed/simple;
	bh=Bl9oRtnXplL14vJRUUDuiCg1b7Pu5v+sHbODQUqCdTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzSBU0On3VvpVSpBJZsGNu5UjX+sxNc/G82fmZKuXVaYlqia6u+7DWqlqRO+UbyL9FQlxe49mIZx266bIrHAEX9qcAYfiEPr2GxaQXZc3DmnMOfERsgD8o0l285nOj3aQRwLH3JYvWzicsNqwEZ8JsbHq+WKaBQNipJdun+jEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GJRPN8h/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lvsrygb5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GJRPN8h/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lvsrygb5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DBB225401F1;
	Mon, 14 Apr 2025 03:55:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 03:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617314; x=1744703714; bh=2LJwgf96V7
	bmUG7fy45nP5cNs2kop5XggYTionCp5II=; b=GJRPN8h/N17DNdI35AGk85yqsI
	JmjlRuJup50uxiGDTZqKlDWLWTigr0dcJRzV8gJ0Si8wRtIuOH8AL60baN5YhxpL
	Brs0RqLTKCqNcyyvKRfWOeF/As/GCpSGiZN6IByfJipzOG/rOeYqs0CpZpf3+6AD
	oxDWv3xINE3EZd61DMZG5O/J7pccPCeHxZcfjJBaf7hJ8DrL+eBCkPha4GLS3NnY
	gOkJKXddq1oi7KgrPu+AxbZog3isBm4WCc2S6ZLJH9AHUD6GNQygVYf3NtezpUES
	diTBf4xQNllfKfGaWulwgLmRkWCnBMtBxirDbn75YS4YdvOSh6K6fxl+pdUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617314; x=1744703714; bh=2LJwgf96V7bmUG7fy45nP5cNs2kop5XggYT
	ionCp5II=; b=Lvsrygb5KBHeqfvkKMMQmRi3g+gM7W4cFmVB8VxPXCX19qbfjRD
	rxuPNZ1+9fu0rFe7WoQ1asB+/XaYdrvMNh16jYXEfLfuum/oAOWiuCQi6ipifYkv
	C2CaFDXdyfQfsqckOmXJNDO9V2+M2GMySv8AUmDGePWAEHVF85CaZEbfojU807mg
	gt9md71ZYGgh2r8IYEMYKMQHxx7tldpiOjXQTBx2owubZl/Wh96xoK7p7QSdYJnB
	YPq5pfePXE7o3Xq1YQo/2uzHCdVhKd2FppwPWgjN4vqlPQRaz9mn0QNsELjwF5TU
	e5mKd5nlTMC9v/gR1wpGIvslduesc/yLSNg==
X-ME-Sender: <xms:Yr_8Z6mUpv_o7UZPZ6vCkb8I-_yBTn2d7WxXG8h69-AE-pD71Y5Ghg>
    <xme:Yr_8Zx0-P2WHjfW6iUua5GzHl9VNljE6jAwfYH2oQaTNjE5nlLUywgq_i0UskJdqN
    Mq7ejaVg-WLT0P-kg>
X-ME-Received: <xmr:Yr_8Z4rY100gIzV9knaVY4_vfEbLrgfqHj9DIxwQu_xVACtXHf49Et39M8LrEN4WQny1hesO604kRd-DP7fhYyVa46JfQJoyzsdAzRzPcBrh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
    pdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Yr_8Z-majqGcSV_ZdMBYfiqr2KnluQzKV7flyJg62b3aW2Yb22ra_A>
    <xmx:Yr_8Z40P9QHCT0iyXAFd4oULWw4mJBEkRLJG59A4EnL_61AbKwqtTQ>
    <xmx:Yr_8Z1vpMh54kiHZOl4npSt_MnEybAnypnXe41JH79O9cxJkjS3E6Q>
    <xmx:Yr_8Z0Wv1hXUEgTwjLEm2tGjOw8iFtNpLkdBMHIRPnGlNEVfTrTPFQ>
    <xmx:Yr_8Z1PiWHQJ3zwJyV1bNXoxnjQBmokEF9cVeiFYut54kG7-vwpTfJts>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:55:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36cc6098 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:55:12 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:55:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 11/13] config.mak.uname: add sysinfo() configuration
 for cygwin
Message-ID: <Z_y_X8BlW_SojO11@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <e45b9df3a43d0f862f1703a3af84c2a796e708f4.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45b9df3a43d0f862f1703a3af84c2a796e708f4.1743859985.git.ramsay@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 08:38:37PM +0100, Ramsay Jones wrote:
> Although sysinfo() is a 'Linux only' function, cygwin provides an
> implementation which appears to be functional. The assumption that
> this function is Linux only is reflected in the way the HAVE_SYSINFO
> build variable is handled by the Makefile and config.mak.uname.
> 
> Rework the setting of HAVE_SYSINFO in the Linux section of the system
> specific config file, along with the corresponding setting of the
> BASIC_CFLAGS in the Makefile. Add the setting of HAVE_SYSINFO to the
> cygwin section of 'config.mak.uname'. While here, add a test for the
> sysinfo() function to the autoconf build system.

Makes sense. Meson already does this, so it doesn't need to be adjusted.

Patrick
