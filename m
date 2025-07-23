Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0F1FC3
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289169; cv=none; b=LbB9xtf5nTGeZdU8MoxwFHMqLzf//nBdbsiTmDlr3Cp05IiTcgbyjgXWaTmrSaHnoxiLLkIVFYaUQ/7zFDre4QYZyc4249vnjF6n5ZP+AXnDDrxV8vEPrVZasvc5JiDKcIMyzsvxmblkAK2NSTpGHetLKbpg+YZh5LW7dUwh/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289169; c=relaxed/simple;
	bh=ILUsgElOjJzRrkk+8NGFFXjylBRlh1FTy+ADCB+HDvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1LQlsmhq0xZo1V2cDXhVhTb7ZYRycQyeOHLPtlQ0hZbB4BfyKXxq/SIc3zU/gNMIcpxaaW6TxTeJiL7j4uvgXgeuDpW2Nc2usV1lzgyW4P7Ahb+5b07NnsAfvn/csM6qIc1XGPZM76tYyoH9MGfW7OvnGVfJz4/pALer4B9zVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WmnImO3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iDYirKkZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WmnImO3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iDYirKkZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93D2C14004A7;
	Wed, 23 Jul 2025 12:46:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 12:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753289166;
	 x=1753375566; bh=+Txv0AtLQsXYeunuZxsYYNENmY/xT6tF1Q+JOHnMQfU=; b=
	WmnImO3ddytPJdH/WcxEHzXIG/LbX/8PcA3NXiWO0F8AtfTPDdn8gyoIBCCHIM6h
	PlUJ7ecrtvHVtW5GfUA4ANM29cAZkqb3Dpol+v8RQ9LGSygDkG7t7zCAp68Vizr4
	3SllPl+BplHVNLnXnNwpVUmmu7c1FzVeov7pa0ANEVvqTiaZBgNHD+WV4jjLt497
	o9LUPObC2Ts3TiqIR9ID8mrjiuV+2NUHIUh6C/6uo3Xc7SYpL4BPws6Kwrt1FFIa
	uICOJ8T599zxzDEHqJOoAtp4euhdHWErTf5xcSZhuBowM8mAs64bovZGn0UE99Zk
	s+POGhaiMcJw6VAJM6NiuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753289166; x=
	1753375566; bh=+Txv0AtLQsXYeunuZxsYYNENmY/xT6tF1Q+JOHnMQfU=; b=i
	DYirKkZBMhHnCOsuZ82hxURDmCVYGP0Zlo1TRFTu381hzgDlg7dPkFmLxPCFf8wq
	QtLzv7+hCZjRmxvtQcGrBEPZQkBewow6MsGO8kD/S2GoftsDqMcVKxyR2XBKzMw1
	hSciBDXv779hgnb0LnDeaDSHK/iGnhXLPKpaEEaKAdT3t7pS7Jv0i/Z5Gj3WIrnw
	2qWbBUzHkzgszJt79scndPN/mLWL3aEGbIbBQHCvzK2rB/kW+LDbtbCjBMmT9e/9
	UNY/x/SeFzFxO4aq7gs24XB4cFddvJMAdfYviuGFrhYTAeTIUfR2bOHRy9Huf2VE
	HPKauvepiqYdwd3Wbkwiw==
X-ME-Sender: <xms:zhGBaJLU991QOrnZOXRbZYLu2aSUCJVk0mz9ShFI0fbSxaqCELe0Xg>
    <xme:zhGBaIa2lvKHB_tSgjyPKgN9ifuFQWLCQUQcLY3rLAq0RCUbEUnGwZ4y9GbahfNMH
    qrjhHkrBBejllDe1A>
X-ME-Received: <xmr:zhGBaLKeehKx3dwcgcHwww-3d7TXba9HSvULDpD3TC8k5FrCu_Op9BW9dWizdwIevNTqlfxJpGPo10cA3nnJVfhBIxP7aUg1rtY0NrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:zhGBaGD5QhvgylsehbLH5M9qpYyCwgzX_LuO4TtdSC9oBaq1sIMXMg>
    <xmx:zhGBaArvofZ0xIVVxiHP9PXgijvI9_Yvqe9ej074BSJga-RTIFwL6w>
    <xmx:zhGBaBjNwPYq30BOZpIQI5lt5kHSNypCWDjq04v1mdnuTNilYAyR_A>
    <xmx:zhGBaNCjqY1PIwid5bp9azqLTPiHEAUR5G9csFJOu0hR5tBdt-MUIA>
    <xmx:zhGBaNpU7XRipacBnggXtpizpExVbQ3L7yjzMLd6NY1D8UuUmQMxOc-R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 12:46:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #06; Tue, 22)
In-Reply-To: <CAPig+cS_h8sC_hEp3zfsUOdP6aFOBucpOsa5TDGwoArHL85Wpg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 23 Jul 2025 03:40:37 -0400")
References: <xmqqwm7zpxzc.fsf@gitster.g>
	<CAPig+cS_h8sC_hEp3zfsUOdP6aFOBucpOsa5TDGwoArHL85Wpg@mail.gmail.com>
Date: Wed, 23 Jul 2025 09:46:05 -0700
Message-ID: <xmqq1pq6q2ia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 22, 2025 at 8:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * hl/test-helper-fd-close (2025-07-22) 2 commits
>>  - t/helper/test-delta: fix possible resource leak and ensure safe cleanup
>>  - t/helper/test-truncate: close file descriptor after truncation
>>
>>  A few file descriptors left unclosed upon program completion in a
>>  few test helper programs are now closed.
>>
>>  Comments?
>>  source: <20250722174102.1876197-1-lhywkd22@gmail.com>
>
> I left comments[*] on patch [2/2]. Although the intention of the
> change seems reasonable (patching holes in the existing "cleanup" of
> `fd`), I have concerns that the commit message is misleading, and
> (more importantly) that the patch itself is flawed. As such, I think a
> reroll is warranted.
>
> [*]: https://lore.kernel.org/git/CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com/

Thanks.
