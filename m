Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA514657E8
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135807; cv=none; b=PMToEOPHpaqErOUGWbBDSZAOFy6m36PLcNcR0qtyXmoPAtB2oVIPRpaO0B2jMJNuimOsZpXoL/s0LPIsIFu6U18fbXyCa+ObzkGplLhi0h0EZkEwA3uXq6DKOjgARrr75U/g5735lsZBN8yWmvG3RnCoNLDTJWNgfFKyIE6U4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135807; c=relaxed/simple;
	bh=8Wo4BA8XD5xUEX7i8ZdrNUM8iavOzEuyUkEKb1y4u4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hYBnPggHV2Jc4MhYN/tC42JqHFGJW6evYs348yoNtC9SX20OWnNC3R55t3wP2AlQL1JoLQuHHPqPw/ShaukhJPUOQjXh/TGWAuuMpEn+28e8ZCG3gnVHQGjZQi3llTLC57FcY0YbpqHokmA+8Z9PYE7F5dNKBnOcOSsm0rZWWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D5Yhdc48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wEe8Z32d; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D5Yhdc48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wEe8Z32d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BE0D1D00026;
	Thu, 26 Feb 2026 14:56:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 14:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772135803; x=1772222203; bh=t7TFzJo+al
	jPLjWeiSEtqdBvfj3GCVfQVsJPv6bQ0eY=; b=D5Yhdc48EkKsrKaOjxOqsBcu3A
	dsTfDJf3qAnPXFdpyf8Wq9c7PXhbwNv6fRYqSliKvdHW7rocdAhegHB0yqWjmelZ
	cHBt9N8WU2QjCUcvW3b9lY0x8pEmQgVHmeDu7RZMq13PLzgtW0WmsWfgO2FEpyk/
	LbnkzIivsJ/3s23mO2VCodc8DAdD4g3J/lS2iCc3DgVIX+3tFyRb08fdp4F1e3yq
	IE6ATNj8lg4TQbqrij94mv14pKDrKBCqybahOmWh5IgS5TyQcSmrXeWKRhmy456c
	ryB6t2mExnjtiFYhh0vryrsHTQwxhdnrtmZo8lSFSPmMqAycInd9ghC7UoeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772135803; x=1772222203; bh=t7TFzJo+aljPLjWeiSEtqdBvfj3GCVfQVsJ
	Pv6bQ0eY=; b=wEe8Z32dSmXWigd+maZ1mxPlnHAiIZO4qlJM320mzhR1SKIz7+3
	VdeBzttSSjKQIpJlb8y19xD6fKcyY7KiVCq+OeldNqbzHmELnWrJ8jOyodFM26+V
	YIF31XnppX36rUnPrEqEmQ3ozz6+2TZr8ibvd0hvVPdQ50xYvM2/SHtILzAAXGhz
	NMnUsz5HFYkGuJkLc1eSTkGlzg/SiE4Gdf8ArFFbXNkQtL2BX5yU2P60vKCW7FhE
	N3cxExGBcIYyb/DifaZge6Go0iTVOCiTzRAGLWy7pCMaMN2/aiv9IV1G0ryaKy4K
	SzrZ+wMXTa5MPfWvV4yZBCHK4SEbbOzWWBg==
X-ME-Sender: <xms:e6WgaUo86qIt-hg7WnexT7CkBrdXEUoaDt11BNAjn0pJlNMrPnFo8g>
    <xme:e6WgaeVoj4dI9uJJnQpz-m112d_PU3QqWrWa1A66GfDg04TA_bvGc4dZjdf31nn_B
    gC2UGbWCfGVme5xJDCDdZKyesC4bBQBY47fXg7EdmOtuHTp_4hBvg>
X-ME-Received: <xmr:e6WgaTDCLCJ7NiUz7_UrMUdHnK5h377zaEjXuJjKlxx3ERg1F1o3gHt7OJGlsgy6exXJXNwARwdaW1kDdywHjkR2Vg1LN9sPWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepvghslhgrmhdrrhgvuggrrdguihhvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e6WgaS0-s0uh9eIJQ6WK36mdPQ9afPalyXYYjMGjihbn5Pv2cqfDSQ>
    <xmx:e6WgaV22HwPNbzfxALbwmUelGaXDA95KR2V1H4SlyMr5-rYiAWgwZQ>
    <xmx:e6WgaXBSRCUt8g1jsN6G3t6w2mx_FD-mR2Ndfgv0F2uy6Mc1nQSG5g>
    <xmx:e6WgaU4wcG2HFXreOoTzRwxNn_lnnG1ynrjMNuc2kAGgIrzMrmZtpA>
    <xmx:e6WgacMQza1-cTJeuEAKgqua97vLpqGAfwLd2n2gXoKtRbUx11zHnXMD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 14:56:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  kristofferhaugsbakk@fastmail.com,
  eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 3/5] builtin/repo: add OID annotations to table output
In-Reply-To: <20260223174120.2356504-4-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 23 Feb 2026 11:41:18 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260223174120.2356504-1-jltobler@gmail.com>
	<20260223174120.2356504-4-jltobler@gmail.com>
Date: Thu, 26 Feb 2026 11:56:41 -0800
Message-ID: <xmqqpl5r1dom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +	if (table->annotations.nr)
> +		printf("\n");
> +	for_each_string_list_item(item, &table->annotations)
> +		printf("%s\n", item->string);
> +

It is minor, but I suspect

	if (table->annotations.nr) {
		printf("\n");
		for_each_string_list_item(...)
			printf("%s\n", item->string);
	}

would be easier to reason about.

