Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A643347FC0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713078; cv=none; b=Y4tjkOgJIWEcDFplQzQm8saVIdzVdbH6DI2Hzr4niia7gYG2juYiVEnljSMU+YYkRdxunvLth/E7DIsiGzljrgjNz059dJemRJAbIfNWyzewDSDtYLe3itSyHfUdivyGedon0duivbraW3fuMETLkYqy351Y9z8FNY3ruLXpuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713078; c=relaxed/simple;
	bh=miEqk71DSn+vKBmNa63N8AlFAPsjy09f6U3mF6ufYHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BeBny6WNHnPSvae25JNbAseBpGMXB1JL1Rkd8x/zKRvE+GgXMfvXxrrf4l4duthHe+SiA3mdp2rLS8yEoQcRTrueXD6Rw2LtaCphyg/yG3nq53dpXGHIzW5ntT1RzTiUCbVcvWqQE9RAezAzZ6VHK/TOr0/SWk31HC7RYA1uPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vAfNepJA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eGiNGaVJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vAfNepJA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eGiNGaVJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 593931D00754;
	Tue, 29 Sep 2026 16:17:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 29 Sep 2026 16:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790713076; x=1790799476; bh=gW8Cr4Dmjt
	cIcwuziCsIje1DnAUentK6IxbM1D1ELFM=; b=vAfNepJAh+N2i3ltY9SMm9G4L4
	ZYjkA19SunJOgby9ADLLdVrOzbqWNs+Zo7Pg4pC/jeAnkwlhKDS4XhF3o8x2mgTW
	ltoYXB41HTwEapRIaThnXjT3dZ7gY/V7d+PUItos9eBGe16WaV0WBvA9yC8lsZAk
	RtCU2xo/JC9tVxwA9UB3rmIVALASdKOoCiboh/f0fEMUGqx8ZpvuqCmSUcy3bKI2
	XY1Yc4Tl7CO95r68ID2odRZbr4DpsXazmvqdcSH6RwBdK/5F6QaUwMla0rrty3PR
	Xy8Bf0JIre6voIM1pJzpIzK3Rj7vfZ847Y9VtBfciZUGFJNpXpcTIjR4PA9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790713076; x=1790799476; bh=gW8Cr4DmjtcIcwuziCsIje1DnAUentK6Ixb
	M1D1ELFM=; b=eGiNGaVJ3V3Xs7dRdwBDc+ClKXTGlW6SFf4lAHh2vJtSZ3v8Iy2
	EzbhsdEHLw1gAuya80YWqu05AynoNjB9eZG9Z6D/GaN7/IDInBf/87d6//8oknS1
	oG/EWLIQ2+J3NUwNksOo/au+2BV2HqYsI4bMWui2HKauc6ghH3VImy+yA31hjfad
	MzEKGgPeboN5VYRbn9Deoy5LfmTWKsYSmcpa74ZzZZdfDX5vJrKF/iBGrp3Er5Ch
	fFWVXCFPVBHta/0rGqZYxbLAlOD/vFmsg1CQ0z3LFZx5d8Xozmq84kRuPOsa596+
	TENRMdejlrKQfuFYu9t+FU36InrF51fUqGQ==
X-ME-Sender: <xms:9By8av4B6GzypQty5oojpnxDP_3GRHZWVDNtEtOazm-mfRsN7sXASQ>
    <xme:9By8aolOLOLoB1HbBMcwv2o0d8ulxGk0t4UHEY1ZqnrFPJ5XVxClO3WA3JAX9Yq8x
    zyJeB_MdP8BNH-M0Jw3iZRjrfUqFlSMXAPewmLVriZTfOUytETHnzuz>
X-ME-Received: <xmr:9By8agThe5htbdSL7UC53zO2bmjQNNQTv3DrHQ-lpueVjWYWzYs-HoJkhlgVZ0C2CNVBpAPwtCYBP2E0gxB8f-2fpdh4UjCBqvYZ>
X-ME-Proxy-Cause: dmFkZTFtVTecOFa+D2Lht1FUCPgY00oAzxhxYeOtOoNh6skJIJQCcL6do6c7qnIwAhvQDC
    tn3a9Qa6MfwvfPziD29X9DdWhPRrvQB+T958eeJyvhFUcumfr2caRNrgQXzE6he+OTm5X4
    SswIcsWjvuzspVhyWP5p/gn0Bo05asUGf8Cs6EQUi101dDBu95jsmIudbaaPd+E2OA3Nls
    URK/2n2VGPpKYDWdVj5/UsdxcSxw38hTs4rMlosRVFoDk4+QK6Wx8SAcxQx3bbdD6niFgY
    okeOb3AHJXngbfW3hgfbBmO7YDSucwJnoTMc6GSy/16s/nfrc82zjfh/5WIByoWJJd8koR
    ExgMBXiBdteULMq37tiHKXIv+0D2vBTLGJFBhNJ0IGbsxegjF6eRdBVpK7V2Uc+ZnRQS23
    p6Pp0Fjc+LSifBXQ4vKpCjHaAsRJu9TVhz9tmSSbBH8YD8W9AFTZCvwNzQHKvGqV1jgKSV
    Mft5FRqNH9NggSzpr6+RgD4s43YEQe0qK/VAs+DHm+67sVnCYCmxlKebhYu+hsd4xePeia
    AFUPiTj0XWhyT1uK+go7ryTxrUkcuqKDWid5g3a9DE7KUJTDt/h98Awv5ECNEUMrOqRLM+
    Ab2BFoMuZvd57FiQYDqDEl6pqvnvof04MySdSXGxRbegXUkCiPFmo/zwd4ow
X-ME-Proxy: <xmx:9By8anHWhQSEw3ang_SS1_vegnxYQuKiphoh6So9PUe5ymG9wQlclg>
    <xmx:9By8alGjR0CwUkZey-8sHqgVob7F4dAl57SxpUV2YBS2fHVLUYlZNA>
    <xmx:9By8alRuFxeOJo4F0DPk5Iz0OZrq6pjRWJr3GkfGbTO-hZBY9X39-A>
    <xmx:9By8amLokX1CRYdIdogJOoY_wsiFDJCvCJSK7bi889yxRTU7ILd-wQ>
    <xmx:9By8arc2z4V6paf4-zQpE5NAd-59LVFqsTNh_sfqRHuETYfY3w5ew9wC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 16:17:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/4] fetch: infer branches to fetch from a
 refmap-only remote
In-Reply-To: <45b26e2bb292f31eb36d88e2fcf8801eb8313374.1790673598.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 29 Sep 2026
	09:19:56 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
	<45b26e2bb292f31eb36d88e2fcf8801eb8313374.1790673598.git.gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 13:17:54 -0700
Message-ID: <xmqqzewzerrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/t5585-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++

Please renumber.  This number is taken by another topic already in
flight, I think.
