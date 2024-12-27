Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3927721
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315333; cv=none; b=hTiL2ZDJgjH/mySmeMy7jAzwYScr7Wok1//XUr48nFqXgCjFUxugIWl1tRJHxphVIARp9mIPEljcYBeGRCuXdx2ND4EgQQbG+HNz9wBPi1ptFt2OY0l83KQG5HI+DWEZxx7pNbUv5bpI1htsT6S/vICW1308zVWEaeQ4aEmxvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315333; c=relaxed/simple;
	bh=68NuD1nQ3jjcV+H7cmv+ooFRTWB7LjHbkNphFpLOxQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jqPbY6vEBbwgYAINY7U9SjdJeNVnkyWWc111PNdBtPTdf3A6X/4M0fqsB1hEvYDGtboHGCgEdUInpGV+xrdhlvRGG2rmWq+eXSy9tTVDu6PRhIQ2lUY+nw+cqxIlm1A8zJSVV3Vwbszh5en4BSuuA4tgS+Jie9FT+eXemYf9B6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nM5xrpzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIS5tT47; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nM5xrpzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIS5tT47"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75A09114009D;
	Fri, 27 Dec 2024 11:02:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 27 Dec 2024 11:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735315329;
	 x=1735401729; bh=bvrZllZayZ+DsrcZXGdKxl2OeOIFr/yzxbc05b3Bbng=; b=
	nM5xrpzkba3Xq2Yq+ciz6RivoQRBVCpeW5fpwkKO9/j2FYCGayf7WnvtO1RoD//q
	lypQn4s3RiqAdY/GaBtxa0AB2yf68AGic/V3O/CxvfYVHtd2hHsNVKydOsyHIth2
	XGVaJt5ZxM9pQgDz9eSAoQGOtKgZdxlTTot65BPph47pu43SB9FUUgXMLrRBdf0b
	0jSnwelpf3FRftMv6D/0unfBo4uUSPqKNC9+VOrbQaZz9qxKsgDTq6anmklV+CXM
	aFKSYylDmrEsCe4scRgNPSOPHZ59EQHhrUwxzSLwDYbsbwspBde17qVJTzXDppEO
	4PEKOtq5Y3669VoIU1e+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735315329; x=
	1735401729; bh=bvrZllZayZ+DsrcZXGdKxl2OeOIFr/yzxbc05b3Bbng=; b=Z
	IS5tT47utA6jYaFyVHAcyUw6A1/49tQ/vVpPn1dpZqIx57If7imiJBurLUX3giml
	O8BEhhNXS7shzjfiT3FWugcTsWzajUir1qsP+ckQakjLajIZxEbbt323EFbWmtZw
	QMqDb1CugctLzt1tGkUVPJ1RVoiVlFAU+m57jDEzyLXqQIz+J40+TODqnVfnf2Dy
	Uy0WTbZU2n4EtIRgdO10kj/NDcN5F+xKRHvxL4p9JZgLIH1R4M1EY0jwYw4drvzu
	AWL+EVN/JHSqao2eSGNo59LDgLBChiAqweJATO1PMgs5CHnKO610Rg7lpyOyUCfI
	/oHo9l1krLKkbJachzOog==
X-ME-Sender: <xms:gc9uZxCvL3BB-X1KGjmcxpVSNIg0EbDLk5LhyJPMM6Ew0GTl2wXpLQ>
    <xme:gc9uZ_gFTCbKklr3Qf_e9JAWpMRYUxfb-m2saEClVYRBEkndktObrbgcw674uNgXE
    9K_TSaPF7GarPsOiA>
X-ME-Received: <xmr:gc9uZ8myuyNAF5bfw0vpYBaE8Qz0bJWUc_DYerwGp2nArwQ0PeBlJEdtUEer_YiU5zZ0p0eCxjp-Pso8dCodXI4LFNouBbtJgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:gc9uZ7whuz1JuQ2joMsW9LkzhGWep5bAjpmpLiMU5FtJMFfQrwBv8A>
    <xmx:gc9uZ2QJkMbRwITdkeuckFrjWXgrk8kp_cWyobbYPN7bPtA0b18KCg>
    <xmx:gc9uZ-Zz2tS7oSDlyzknG8wncK3uTUkcXXxTqNDuwbwEj6Moc1voTg>
    <xmx:gc9uZ3SOyaM3LTnwYEmcc3qXB7c9WCQ02qAlJypr29j_aLP5A96WVA>
    <xmx:gc9uZ8P3KkR3X8nGa_2Kp4BwNI6cH6ziu8Fwqk8FKuR3fAXi_ngSGcfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 11:02:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] reftable: fix realloc error handling
In-Reply-To: <Z26CnRsw0yqQblMO@pks.im> (Patrick Steinhardt's message of "Fri,
	27 Dec 2024 11:34:05 +0100")
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
	<Z26CnRsw0yqQblMO@pks.im>
Date: Fri, 27 Dec 2024 08:02:07 -0800
Message-ID: <xmqqr05tt8qo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Dec 25, 2024 at 07:33:07PM +0100, René Scharfe wrote:
>> The current handling of reallocation errors leaks the original
>> allocation in most cases and corrupts the capacity variable.  Fix
>> that in REFTABLE_ALLOC_GROW and by providing a new macro
>> REFTABLE_ALLOC_GROW_OR_NULL -- solve this somewhat tricky issue
>> centrally, with minimal impact to calling code.
>> 
>> And the last two patches add error handling to the remaining
>> places that still lack it.
>
> Thanks a lot for working on this!

And thank you for reviewing.
