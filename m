Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E81189916
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631396; cv=none; b=Np0ocDm0d4Sve2UU7YUcjD7L5PD2NPhbTyWwXVcHkDGCqIXZJNAwNkmopoXTqDQwnCPn6qfKSREMDCaM+jUBXkgS4spQLtV2nxm7t02rLWd8JblSTJrGI/HlLTayXvRMDK2INux+3xccGG3oAlB0ZyevwuRP1fmgwDMje5TIzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631396; c=relaxed/simple;
	bh=gd2xCyqgvdhgOtMlXApEuCpQsVkmfE+By/RGMt9WtfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXOdbJh8Kgn12PqiBswgcbCDVXKIIVzaTdzvJCYiqy/ecoDHsnKawvx8mD/dJXjt1KLZgU48wXainAGu9IBVvSPGuexcJlICa4mmCzoeSYovcmqjQ7+mHRWYwWQkvor/TgnOGIrnUE2DROwL3IhQshnt81goc6fPHJnSCEO8JKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rDei5w2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kr0VgtLY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rDei5w2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kr0VgtLY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 190491380D0D;
	Mon, 14 Apr 2025 07:49:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 14 Apr 2025 07:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744631393; x=1744717793; bh=gd2xCyqgvd
	hgOtMlXApEuCpQsVkmfE+By/RGMt9WtfE=; b=rDei5w2lTpg6ZOHcoGdas8WXAg
	YYJWQ7Ndmc8CuBANvp672a4jC+EcBDCLtkYBkWpSxfD9DyvN4CMNFolgPKM0Dfwu
	UxI5unHqWEseXUg5zpn/QjLLHYqu+hch728ibzRB6ImKAtx0tS3GkkDmXCXHfvIU
	hcR68ZGnroJGdUWHJps/Nr1AsByjfycvZB3+ykrdTppIZKzALDyI8q/mb4dRpcm3
	lORSl4xYZiLurZXX/QN5eH/91gy+p5jQFdRFK7sewJUELPjLyyS+euR7ewF+RgaO
	Pzvmc6H5M4fUrRHlpuEcu5W6HIYTZSXcttyHATejd7ef3pfFFs6Isc4FE3WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744631393; x=1744717793; bh=gd2xCyqgvdhgOtMlXApEuCpQsVkmfE+By/R
	GMt9WtfE=; b=Kr0VgtLYKxIal5ZIa3csdwTrC7uRQ4IOwcO2ZxCHEQSQ/5t97kR
	ftr5ohQfeWRnge8BWSnnWs5Qznetantux0ErVTRs+ukkSY483pdRLjP12jiYOuCl
	xB+UPGrObX1VCnpZgKljTz7hdqn4GytWeq4U/8yZf1gaYYbBNrvu7hgtDpy6RN2A
	gymO5ipcLqFMK9Cl9WQXxO0QpDgEyy1pjY2T98flKYNSRlJSvtObMaD42lzOlfjv
	d5IY3Qcz9pfhF3NRTF/bR0MRuaKDtkyG8dy2dOoAwrExj2BvGirJpVM4jwkaNmm7
	X1MIXfHK7zCNR2I53VCnP1nKKjYcogwZEDg==
X-ME-Sender: <xms:YPb8Z0Sin7SjeE_d0TxUHwIQGijpk7phnFcLIUiIgK6mR-tJ3bln6Q>
    <xme:YPb8ZxxLZypnbcaal1O_3Ak4Wc7wEdtvZVe5bDc8mS5MV88QMIlPhcV9PQFZbibMr
    jSOGDweDEeRCJObig>
X-ME-Received: <xmr:YPb8Zx17pljH8eaEOrat_Vw4DM_RKYADsd0U4OdUdy3WWuZ79fwLIQaq_yU2imxQJN5fkuvQERT-ah_r5HxEEnTyVptlrmIrd6Ct>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YPb8Z4DlHTuxWXgXONw5a4TG5otPWzq_121X_5TTpoj9j84ZNgldiQ>
    <xmx:YPb8Z9h7L9bbBjh680rEEkiX-l3ovfv23h_h8Wzj3JAfkGwgtRosiA>
    <xmx:YPb8Z0pngtcVq_UctYafVyoJMyF6Ip7MTpB3c-eAifGIZ2KZL6kklw>
    <xmx:YPb8ZwgIKMIML10zOVCxSjlp7JXI1o0_MDLasLjluTruUt2inhFXYA>
    <xmx:Yfb8Z_8Dyz0Ntz0PPfWh27thVG9G4vUxIO-LqtHhpDMqtrfK4V8ZE1vR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 07:49:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 6/9] object-file: split out functions relating to
 index subsystem
In-Reply-To: <20250412081724.GA109770@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 12 Apr 2025 04:17:24 -0400")
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
	<20250411-pks-split-object-file-v2-6-2bea0c9033ae@pks.im>
	<20250412081724.GA109770@coredump.intra.peff.net>
Date: Mon, 14 Apr 2025 04:49:50 -0700
Message-ID: <xmqqcydfm081.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So it seems to me that these really are more about creating objects than
> they are about the index. I don't mind splitting them out, but it seems
> like they're equally weird in read-cache.[ch].

Thanks for a good observation based on history of the code involved.
