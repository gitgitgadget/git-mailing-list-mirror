Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBD81723
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669919; cv=none; b=TIGzv4gryjsVWvaCxBb+0as2Dw/IiYsADl/PTBUXDL6EL+gDyp2Ccg9l0aK2+WykGQEWZs3nKwlKM0XGR28gVVGG5RKNVXSrRmMEDnpkss81UU7+DSokZOQKIxRb2i+QClz2CMPIKEzG0fK9PHh/42/2QOQXXOaNfY299QddazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669919; c=relaxed/simple;
	bh=qLBSwGa6CkpOHyRtEJrvAnW4PsFkObC4wINmIOYr23Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k164aJbjNxTP1ea0nK3OLkzN+NvB2+CEFSEXhGB3LG0JjeSnzMfaakDZxYl+VM7KJAW65fflsYTscKwCIOCTNGOTaLBfepJJN8iuXbuptqc9+WVHxljUjR9Tg3j7M7CIF/kDuFqziqGqD0TpztFCAz9oLNfyM+AXPXQTDcALsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZGkdPCDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0a079p9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZGkdPCDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0a079p9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 80C1013800D4;
	Fri, 11 Oct 2024 14:05:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 14:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728669915; x=1728756315; bh=IvI5JDm2I8
	yXbxeCcWopJnKmhjwp1NnZwB72Goa/yqw=; b=ZGkdPCDemB9/yZFnIiMKhdu40s
	5kvBHvQYL8wknAXTJyU/hSFpSoFnn43/8JC+InWG4H+vGJN5GCSsPNS+gEpp1OP3
	M4ra2qh2nOA7e7jWIBcnBEu0GLxzXNUlfTTpg5p32zjM9IMomBR+0CN3DT3M58S7
	nH1TW/5NWHn6uJHC9j5SopcdJou4rCGiZCsG2+bjMqxXlLb6Y8cCnCLDPUGVYf23
	TJ718O9V9s28jVfNPt/8wYYFMdQkoTIS1ifqd+Jvdl+j42JRw6tewbH1R7z4xaxZ
	dBO/wV0hZzbEic0kQ7WsL5gI4HW8UM2RZdHO2xuurU1/i00ZjKgVAvfYzTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728669915; x=1728756315; bh=IvI5JDm2I8yXbxeCcWopJnKmhjwp
	1NnZwB72Goa/yqw=; b=h0a079p9mxFT1XMgpcLq6Fxd+J+0jtvPqghGzpErkY9q
	FPsSkkA+Mw1p/uGGK9grAw7KNHnvC1n4KxXJQ9at8muX+0JGFHy4JSnoE7gcwvyR
	ci05VV2dLliPRAtjEHNo0iby4SgZx2F3XfCW7opa8argHOWX4T4TmzDA2hWFFDoV
	x40UbBGN6GfgeLoEQ/hNNEcbzWuHUGa+yAS2zP01vf3+jbyYRqDQLbwjU07RrAkk
	2fuayDrvzvFjiZ5O03I4dUrMdCwVYVacmgmS0kJxIsSIzQbWx7R2V9fUqTC0O/2V
	FglvrY3ZDioBGN6RK4oS4cky1YRkfBkzs0BcBqa71Q==
X-ME-Sender: <xms:22gJZ-f2VX6vqF-QWZ27rrj4N1avgIbD_vmId59J1qDSsi7gHuy2cw>
    <xme:22gJZ4PGVz0Wk8zWOAhN1UBcWjZm00f6wVbTIIh14JROljJ2QqvVR1kl1YGHky2NB
    -DFBMkGN3pUzgAfng>
X-ME-Received: <xmr:22gJZ_iP3YzbJwAchfxesgQA2XBTd2pFwAhrXm4pSvXc_plchMUNcApwxjv-Eohbsl50YR7zqgYBgHBcrmNYnlT5lcvqKmtDZZZzpFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihgrghhnvdeffe
    esohhuthhlohhokhdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghk
    vghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:22gJZ7-IMhebTD_DW9_rYioBXuwgPL3mPaXBlVvaG5DUY4jX_zfAtw>
    <xmx:22gJZ6uXtzWO-PgB2jvPfjfcSGJKRhMez5ZxtwaQEBJgoREbbXWKMQ>
    <xmx:22gJZyHS-W2wGpIPpXwFL9UWAfX5V5ApIYeMfxOtLs9_3ec-omJIoA>
    <xmx:22gJZ5OvMQ0Hqt3NlMujbknT7prJHFahgRtJ4P8b1V2XMGAqjUS5eA>
    <xmx:22gJZ8J9pJHDHNNdEXjP4_v_wtNaPN7MMtWJhhWV6afIcqaE59XcP2iU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 14:05:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
In-Reply-To: <TYCPR01MB843751F88AF98DFDB606B0BE98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
	(Shengyu Qu's message of "Sat, 12 Oct 2024 01:48:18 +0800")
References: <20240225103413.9845-1-julian@swagemakers.org>
	<TYCPR01MB843751F88AF98DFDB606B0BE98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Fri, 11 Oct 2024 11:05:13 -0700
Message-ID: <xmqqed4mecrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shengyu Qu <wiagn233@outlook.com> writes:

> Sorry to bother but what had happened to this patch? It is more useful now
> since outlook also switched to oauth2 only mode.

You are the second person to mention that what the change wants to
do is sensible, but nobody gave any review that verified that the
change does what the change says it wants to do, so it was left in
the mailing list archive.

Thanks for pinging.  Perhaps it would remind and encourage others
(or even better, yourself) to review the patch to help it move
forward.
