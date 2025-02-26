Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770E22257B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585599; cv=none; b=emwNMJl2lHHJQfyy4eT0LOrWbkNf9e8Jt4n4fZ4bBWUwjN+PsJJ+661V0S+JXi5v1yBts4vuxO5um5dP6/jx473CcjaVtgBwRDyx+/LzesC02xAV/100V2WTWijUYDqi+acT3VyEsaVaQu+rPYpIZpkepf0x2RfSLwwoPETWzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585599; c=relaxed/simple;
	bh=lY5W1sBVz+eX5dWZs8XyGZ0D5j3FLyhOXIV7YLBf0bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fkM35i9SwaUzosRnSU8LVTE1Gg+upCuSNeQTLcZfPglf/vaqvzjeEY/tiVCr1K/0nP19NH+rkufVyVLDKTa1EqLWxEk+Gt1k0q2MsfuB9CSEtBivg06HF530lSNOVoqcDGpFR8khQdZ/95nAbQApDEYQfcDkfP96EAWYy6Iuox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G0DDiHWD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxymPoQv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G0DDiHWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxymPoQv"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29D0011400AA;
	Wed, 26 Feb 2025 10:59:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 10:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740585596; x=1740671996; bh=y+2Ku918Ey
	UksudcGkA/faPIaoPQmG5EY9bJII88EKc=; b=G0DDiHWDWJ3JWXyfz3QkqwjT75
	uQJkoRU/sVPGytAWO8ICQYNTEmT0gecrLPnkxzCy7jZ7KEG9uYLWb4XIqLNtt6yS
	0Qr4gWGPckajVz3rDH5FmiradyLtuRQebtqJDTudT8e/0FkZLnriHhXeJxMB4lT5
	FwJtCo54pWldhYjGVwtGVRrEeTqCrYYhFhYZUtUnuaenyQA35NzAXMrFoQHkj0FO
	xTxv3OFlYPGnLKUoa+P+YmyWY+p/hBkK703Cr+vBTr4z9/KCO4ddVh92eaYLBAvd
	hkv/Jh48vKHbvxhe3+WuQpn3bAxi5kS1d0YFhG3+IbUSYcdFrATjgVDhaZFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740585596; x=1740671996; bh=y+2Ku918EyUksudcGkA/faPIaoPQmG5EY9b
	JII88EKc=; b=TxymPoQvy1AgDDb3VAbHpEacuZPKPAhxf/FKTb5IH34oJ0/REI1
	jkKcKoj30Ihg+9x0YdIFSGWRtmGL+8/GtEK+kj/FgcLxOxdEG4mBBg9NOtFcHsdp
	/T1KJ+cT16ywDMtEz0beFVV2EHmL0mhEKXTep9j3gAc7tmEQlcAjCNSssPRTo+6j
	WXTnnBVEEEGqXZ6Lh5FA9+snF3p9X6DWh+8RDLyRYvQv2fDWaJgegGDC2P0D+8BZ
	7kj0fjAztfzwvv06zliTh09IKwc4Tgk+pLtnryaDm9Ko4JHwevAtKGdo1+2pEfSg
	8s+YoBTM+rxi4RgRYkZi08gZ9lbgzcz5IHg==
X-ME-Sender: <xms:ezq_Zy7ZPslA0_xcQJ9UndImlsBPChxQ0mkiQGo7ik1MGKWE97U4Vw>
    <xme:ezq_Z77oP4lbpC8qKcO-6z9b7QV7E7qNUXVPHNDZYSsH2cwqtl1oA_Oy58k8IPVys
    766btv1ynYVepZUYQ>
X-ME-Received: <xmr:ezq_Zxcl2SX1F5vVGYMl1ESfyijeSJcnHuOQT-E12UAWGJwL3scVMJt0z_ZQkXERYBuIu6cxanSmx1-IWdOQYe5Mqhmlb8v6Gwqu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohephigrrghkohhvrdhsmhhithhhseifihhsvghtvggthhhg
    lhhosggrlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ezq_Z_Lg3pxjc_eLyVedou3crSE55Ue1lY04OFFUP-xcFRnWJKO-xA>
    <xmx:ezq_Z2L3WoBIfMw3trbUaGwtlPWi6_6NzbKYWaYhzGbVhUT75SqCLg>
    <xmx:ezq_Zwz9O-xuEI2tH74SyHXK0FyXvGbidIah2fOBN5ghXcXMitV-Rg>
    <xmx:ezq_Z6IXkZxHMeLBFNz3BqS_NeXfkp7dh7Z7yNB_ir5Ma0apIEoFQA>
    <xmx:fDq_Z4gf9TuWbdeUBpbIR055DjK5u-Xz3KUiYpdKkBTc2Ou-3hWFdmnT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:59:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
In-Reply-To: <20250226073822.GA21138@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 26 Feb 2025 02:38:22 -0500")
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
	<20250226073822.GA21138@coredump.intra.peff.net>
Date: Wed, 26 Feb 2025 07:59:54 -0800
Message-ID: <xmqqcyf4g0hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I wonder if we should consider adding "U" to the default $LESS variable
> we set.

Thanks for analyzing the "less" issue.

We should be OK if we lost the overstrike from the pager we directly
spawn and write into.  I think it is a good thing to consider,
especially because "the default $LESS variable we set" should not
affect the pager indirectly triggered by us spawning "man".

Thanks.
