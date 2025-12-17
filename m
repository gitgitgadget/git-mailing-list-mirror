Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D12D7DD7
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013590; cv=none; b=sQ4qRCixrVZOfv5BiD2jWkwS31MP+wYO6X8huaWIbOMVSwpTXEjeD799nKldLY+4zs+y8uvjOQaWyHQLuxm7YT2OyOZFRXZT7r+km+lYaa/dfNweAx+HPu6fJOTPkcIFA4Anrx8LUHgtIsKNlxAF4Rw37ejhimz6oawMiXJsrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013590; c=relaxed/simple;
	bh=NbaxZTMSzQ+/XXlrQCvgL5neC9jx0BkOkqx7rCq8Bgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgH95bYjNQYYGzhwwZY924kGtG3xehBFlMncbw1rtpgOp8Ypemuoagxn+YwJQIca4ub1uAaznskN/Y5mxot7MjWUgEkvf1CPLODxEOX0+8bE+5aVmJpTmIkLErZWDHPquGRw5C3+3dmK5TYuuqsP7r1krMIYlujG5Zvya6HJHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OpMirvw7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQVNOr4e; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OpMirvw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQVNOr4e"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B29F514001BA;
	Wed, 17 Dec 2025 18:19:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 17 Dec 2025 18:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766013586; x=1766099986; bh=ZvyJo3Fyb9
	fOM2j5Mjns1SNOuiVgM71GuQ3FU25MpA0=; b=OpMirvw7D0wJA6djb79psjj5SW
	m/kH/r0qjZmTl7NhfDa0vsQF3dAeJ0iMMPwR3q/Tizn39cOmA6CuiHqCIPxWh7C3
	sO0vp3HeG/3612i8xMo/zaFYvWxj+i5UXOIf3shyQ1om5QR6G1q9orLGrCtlwYOE
	8ZHNofcMo+xZ1h9RkUEyAKdGgQHexmlisBTMDu0guJr4GkcwntoSC/Q7zl4U4Fo5
	IfZ2fSOgrYxgDTxcAVqkSMYrDtFgRwBVKzj5C4AERnHtkeCvutjl74KIkDU39eSR
	+GsMDupkVz9uvX7PYpMcB0wpUIpwgQD6hF1iSbEBmtDa16viziZnok0vhLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766013586; x=1766099986; bh=ZvyJo3Fyb9fOM2j5Mjns1SNOuiVgM71GuQ3
	FU25MpA0=; b=BQVNOr4exe+Mj6Jbe2b3S1INcQlIpEGMEQOhZiz8SVF7wB9dWj7
	NdBQ8AKGCrSvIoqJPDmxwl9IygmWBq4Yt5iS6eBYY9y+7t1NtsfAM3039KykmldF
	csKnn+RHorJMuU5vBR60xlTndhkDSy6tb4HsZOds01dcrLvjEFYpswnZBJJROTc3
	54Ivf5zYK/QyVZoPlFDaygd7g2pf0mEsk3JOLEXHT8ijpzODhvxW1II5BMcjWH+h
	ZsoZ4RJG1jCI5lG1hZsxhgH34HMKydZ2U1Delq2i7yGlq9Qd2FT2WY+ugIvBNXYD
	G3S3Y1rUKH17EDby9v3fILpDW9QOXd37Z7w==
X-ME-Sender: <xms:kjpDaTdqpe5dBc3YzYRBniGZovfUOTpI8FV7QPJshw7YzXR-enIX4g>
    <xme:kjpDac7kAM4hcgoOPK3EKPefkC5HjzOEvhF285CgNTo3am_SNHtn5F8JuaYTwNDkS
    -Fh6DJiwCqNEkRZRW7JHzO3GRIjMqEpqRnmoJrRIDYcV4jhZTcX>
X-ME-Received: <xmr:kjpDaWXanV4TTywGA2rkb7RuAaYNBK_TKhewH5Ueqg5fJ24-XuVJoLSmyQOYq9_CWsZ_LbJ5YSA3orEbUmwMIV6YMGXeNPLiNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kjpDab4qduqWxamPTOKssBzSxAD2rwg2Jr0oS4NkV1YV52JXB6BtdQ>
    <xmx:kjpDaRq2VJD2e_SasRgPxiFoF4ZEMOFyp5vDavc6cAfXb3UKMZRfRw>
    <xmx:kjpDaekD1Yqq4grdw1xuGea3gq__KK78NxtLVKJKaXwWwRSRbbX6vw>
    <xmx:kjpDadN2CjXmvhtfFcKJ7_Edbz-BwO2h9-evj8vya2-7OOoJ5pUfGA>
    <xmx:kjpDaYwr0wYmwMuBo_DkCijZqlG2uGiTPU4xVbnhLeB6VrW9f2FxcsUl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 18:19:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/10] Prepare Git's test suite for symbolic link
 support on Windows
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 17 Dec 2025 14:18:36
	+0000")
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 08:19:45 +0900
Message-ID: <xmqq34581ysu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v3:
>
>  * Re-added the credits to Patrick's research that was accidentally dropped
>    from the commit message of "t0600: fix incomplete prerequisite for a test
>    case"

This matched what I expected to see.  Will replace with this
iteration to keep the Message-Ids of the commits straight.

Thanks.
