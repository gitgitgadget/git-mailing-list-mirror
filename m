Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD761D8DFE
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155194; cv=none; b=VwjRW533xDtcSgrav1eda8f1fsLyX90auGB2oP0aPj5N0CK6gYWoCe2E0x7CxSFA+UyJbId2OgvxQcum4wSbjMuUv+fxwcCcM7TMtrP0T8ixOwwyj2Xa/JrNz1Okhb67gJLN2v25l1ZnbP/2vTuo2IWfqaOXH+hyvDiM6Zno75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155194; c=relaxed/simple;
	bh=qqEG0Svv81v2bR9cfXuii86mGgrF5CqGIqKJaIyBUJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bU7+svur+S0wxYINaoOGvfylFvzX2idnXYtXJtkQpl2rg/0qel/DCSmcwct4nxOvTMeXbsl3CCIHjJHbq0sl85x77LU+vGl49r1o/JQxQ5vP+zatNZHUNHYjb7s4LBJQLGu2rT3hCoDaQZZCu4DFe+OnXSKnWAna11PbsY2X4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U3n7TR6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zru/T4KB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U3n7TR6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zru/T4KB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21C4B114012E;
	Fri, 17 Jan 2025 18:06:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jan 2025 18:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737155191; x=1737241591; bh=qqEG0Svv81
	v2bR9cfXuii86mGgrF5CqGIqKJaIyBUJI=; b=U3n7TR6UL0PMSFhanKBJfPlpSx
	kSeBaomT+nUK2TbAXflIi2EPNCuHpb6PiuigiV9fKvc1X815RQ/WR3qH32qW8THQ
	YLjrF2djDEce75uR4nLQVo/EDs1TvMkilEfOGlMACPySgA6u11IrgpPtaKbBAusT
	5J2FDjoPO2pdE0IqEhrnuIO+zuSSnyVo2/OGJdYW5hbMYyZob1+ktipvrpXhrhY+
	XHDOjgDI1ebdvqvNAztKdVbHF0DT7IG5kaHTzsfnB5XXGXB8JwDvt1WZQHWPlzDm
	Erz69rOfzxzjs7AzrEwbqFuk1r5y7ABpzQ+d2NYCHigF1/91UG27EwSLFx7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737155191; x=1737241591; bh=qqEG0Svv81v2bR9cfXuii86mGgrF5CqGIqK
	JaIyBUJI=; b=Zru/T4KBJdmNvgohs7Zo8eX2oL/lu+c0GuHoGjsYVoze82W220Q
	5JbmMXFWH41JAGOQbEKbec37kSDN4umE47K7H8pmM5G23aLBdH+w9Lnd8+GQy1Ca
	CLySEO4y1tN/VmiEbPfYQomt15XSsGJoSzdUHqWW3CM8LTFKXlnHA14A2cQJzdwG
	cU+eC5xrhFTM9WBOqrbeqps+Ua1+3FS/9OYmfymjyKYfRu4iXOLMIy2jO7ZJvNuQ
	9xMXVQxu8jINIXjmauEVkoBjn2FH+y5gQE7yv4HXS9VjilCJqxD/p6ZjwTcfHnqM
	vKKPBsN9ZVLaBPp5/M3ZD3YAC7a2Ibn2e1A==
X-ME-Sender: <xms:duKKZ6b_na8ILU-iFwp9N2nV7PxLyb6xzr0qonSJgxmEKvEslNeljA>
    <xme:duKKZ9YZ86JW-WYVD3IzQ-wtxmJMDpcG12rDlnqVzLIuCmK3ZCdPNNRu7enpEDVLy
    GQWdq0JEmyM8GAy_g>
X-ME-Received: <xmr:duKKZ0-cYCezV0apQjHXr99stAfVvO3BYqeeQUUiD4vH7AIzPs1tSfOfEPd-ASo9Da9lmXN4D-bU63qNZkTiSDFgkkcKymGi5ZZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrh
    esnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhi
    vddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhnhgtrg
    hikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:duKKZ8rzSHC-qZA-4UZf3lGVojNAqiU9qwcyFRF3OEGUghGP97xWHw>
    <xmx:duKKZ1oNk4A-uRs1ioaOxc9Dzvo8ytVVWbdg_wd3slfMbFPw7Xx59w>
    <xmx:duKKZ6Qnerhm-pNUMaOmY2CznqLUGwM-ZTZJ72K3_FgayKt1bf3tlQ>
    <xmx:duKKZ1rKbYFSLzTAdfKrtj4ahVlJle3NeUn3pxSSjYwvqHXJpXzqHQ>
    <xmx:d-KKZzgV6c9qkkuNdauV05DKlh2XLCo5mT7OdSAiT74NPvsD4gU_untC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 18:06:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>,  <git@vger.kernel.org>,
  <christian.couder@gmail.com>,  <ps@pks.im>,  <johncai86@gmail.com>,
  <Johannes.Schindelin@gmx.de>,  <me@ttaylorr.com>,
  <phillip.wood@dunelm.org.uk>,  <sunshine@sunshineco.com>,  "'Christian
 Couder'" <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
In-Reply-To: <00bc01db6932$1eed21a0$5cc764e0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 17 Jan 2025 17:49:46
	-0500")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-7-usmanakinyemi202@gmail.com>
	<xmqqwmethxyq.fsf@gitster.g>
	<00bc01db6932$1eed21a0$5cc764e0$@nexbridge.com>
Date: Fri, 17 Jan 2025 15:06:29 -0800
Message-ID: <xmqqfrlhhwga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On my box, uname -srvm = "NONSTOP_KERNEL L24 08 NSV-D". Is this going to
> Break anything?

If you are happy with that string, then there is no need for
osversion.command configuration variable, is there?

