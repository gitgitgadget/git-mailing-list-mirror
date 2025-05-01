Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB3212B18
	for <git@vger.kernel.org>; Thu,  1 May 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123665; cv=none; b=nX8hrWN1/ZSRp3SQRlk0oNSGRpiXST8uHoLdvJm4dscZnJic5y5whlq4mWmTiuxCeuR90tdrXetVBlERKVMyS82iVf86HRY5WV9d/K6k688VMwhvy3cAXnuOtOt06HEb0ROBEUermR0m661EwcO+iV48GTcukl01X2EMVAQ4Odg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123665; c=relaxed/simple;
	bh=YpMYyxVSj8df/0DyVefp+Ui0y5DxRcECBPvjS8U8yFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cT/adgzwlGsdZED9tid0Okgfg5HLe5PhyYr08e6VAWQzjNLCmBrQVRwa53J7+8+jBv3DmXvdPiTrtWkbtY34CDCEuWLabf6k99gJ0UJfOqv+7OYLdl9RmvoWFvZpwa08u/V+jWoyhtMybed3zAXyzCZYV2w51LzDJtRKSGTC2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qAPxMPlg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tTr0svH5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qAPxMPlg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tTr0svH5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EE1A81380F9F;
	Thu,  1 May 2025 14:21:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 01 May 2025 14:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746123660; x=1746210060; bh=hRRilYoMeB
	eSkdDugHjxRlrSGp02PAO+vyRhzuYCnlE=; b=qAPxMPlgFx28NZk62KEd+td551
	JRjqnvHwKgV4dQI4NYVCbvpyMdBM2cC5oAyv1xCYv+a8Cditt6cIkEnq4kQkf3Uq
	ftoFqkNrnilRAg/gj13BNoxaWZq9EmlNnbT9l1+Eld6qvMlj7FU1a5B2RIgPDm1s
	ee9CPk9fbzLYZKZFDYMXuHxxIgkcdBl2XTOEbtMcJWuNn4mhQPAnyWYgAbDrlvRF
	hMT2xz7rql4BGOUl3i7C5MSFaXROFFuC5Dq46MF6UJpPoCdHXqXZCRvX6C5aVsR2
	/q0KCVfBVYNvnPpBY2RO7y0lJ8N3OgQlvrOTVweoFijKGwhUOQlbCS9m3HjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746123660; x=1746210060; bh=hRRilYoMeBeSkdDugHjxRlrSGp02PAO+vyR
	hzuYCnlE=; b=tTr0svH53Wa4whAUF6hkm9l+7xdmyRHuaZN0rzk1GSR1Yqd24MO
	4VrRBWHgC+051UttwaDMLFOBJmtGyN+Lr59r5O2mnwtwyUlI4aNRJHwybSStmR1P
	w3A8jaWhA2hkSptN4SEDpgbPvDKMJm58BSfY3lpC8HHe6quhNAENzWmzmHQLQmGN
	QWNA16q2mWPGfE6WHcsjFJbhF8GY/9SAVMaR/abXbxZpHMvfySsrHiKH1FwuVKIz
	lStcMFlgK/QetY7rhV8Y19AaLxp9YlXVIk6fBPYEgjGWIqX3fHmMZpejP/0zCBYH
	Etd91yGfBml1/yMVKxLzpxCEYv5p8ug/bsA==
X-ME-Sender: <xms:jLsTaGfmHEltXwavO6yfsmr34uhWAuUpAJsX4psWGdot4Nvani-Hfg>
    <xme:jLsTaAPAOBlVW_WjrMlJD4x8ZN7JZvuMIB1H4NR4npluDWP5xa3Vd-epa596bosjq
    ElsLNiYEn3RiYFk8Q>
X-ME-Received: <xmr:jLsTaHjL0E384AKPYuFJuJhEIBJw-fnELj7unf1qeNKcwAsvj5bpCz4i7kTh8SknXCdVDmBRAiBKRc65weYgkd0286Scss8d0OGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jLsTaD_eN6A7B-a0JOJPOJq6U8861G9TLaCgcyz8aZ0zX5LNlamlLA>
    <xmx:jLsTaCv_zSk3v0E7tDGkPnEYajHCkFD0DgbLCAQWsj5l8eSGN6JPCg>
    <xmx:jLsTaKHjgOb6MeUMDbPqHiuS2Uh6sXhqJiVFDHp2gaustexBaqGS5Q>
    <xmx:jLsTaBMjbdrFCgvEr-lVNJ6oZTvMdNgcS3Ov719JdbCe8sdM1dtskw>
    <xmx:jLsTaHj3Gsum50c14YBkh8bRq_5XK-51HVDqgA1D0_QL7Onucl-GIcOH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 14:21:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/2] scalar: add --no-maintenance option
In-Reply-To: <xmqqh624xp4j.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	01 May 2025 09:38:36 -0700")
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<xmqq8qnh1jjg.fsf@gitster.g>
	<d3659baa-054e-4a31-a851-5471968aed07@gmail.com>
	<xmqqh624xp4j.fsf@gitster.g>
Date: Thu, 01 May 2025 11:20:58 -0700
Message-ID: <xmqq7c30xkdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> It is mostly philosophical, I think, ...

In other words, I think making each helper function do one thing and
one thing well is a good thing, and "register" should focus on
registering the new repository to the system.

By the way, it is excellent that the new option honors the positive
form (i.e. "clone --maintenance" and "clone --no-maintenance").  I
was re-reading the patches and was pleasantly surprised, as I would
have forgotten to do so while focusing too much on the shiny new
feature of being able to disable if I were doing these patches.
