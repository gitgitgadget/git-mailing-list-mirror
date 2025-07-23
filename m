Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596684A1E
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285731; cv=none; b=hAqh4mVdqZuh24kpavTadqGEZuKwcTt1cVyBOUCPS+ZL29WKI4czo0Uv7zdZqXWOU5j/K6OHa7uo1XyJf3AtqxZ9/2Zu1d2HFu6kUsqqcrGOSQ3YmOQ9GxyyIERvPVuIsAFwJvpIBfgM2ll0lPN3ot1l2Mr73LciLMEXe3Pcl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285731; c=relaxed/simple;
	bh=1ydLjEU0lrRJ3tdUNN1EYw2ZMeJ/FxahOblnDkgPZ7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfUJkMb4Ns1pDiqOIp3BRmP8wpyiecjsb6NFMXqUE6vs/QDkZJsqUXhRefKz2ZMTu/p3PdZp2brYDFVpUH5h18ieygFRCsRfim76/eqzBVwyBUTFzwt4/kghk85Xi315GzoIC19Y5C58CBOD3JubsTB9TAtIWm/v+OqKwOfqOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b/jJsL6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6a5c17k; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b/jJsL6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6a5c17k"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 574E41401AAC;
	Wed, 23 Jul 2025 11:48:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 23 Jul 2025 11:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753285728; x=1753372128; bh=1ydLjEU0lr
	RJ3tdUNN1EYw2ZMeJ/FxahOblnDkgPZ7w=; b=b/jJsL6T11EsvLVH5ZB94XfSpe
	kmfPp2yi+g1EwXrRGJPVd4KyWF1VaTpIcOEVkqg4bziXrCfB57eznI9S7i7mRns+
	C6AgRvyURazH2uWT0Txrw7i0NcBHbWUamM6/xX/55j9/2PKZmF9IRo1eOR4Iakc/
	BiBOiAOoY//r/MPh954N3DHBX5YfHPKsVxj21VuW3Lsql8gOA10FcjnFCgXySF6U
	mPkuNt+stIdQLUKD/xR+M5Nd7Obi6xs5K4NrowdI15/3M7BwxNz0xNdwG4wV1Atc
	KdQK4NQbdQfdd9l2D5GLnfrhTJ0V8EkDzvhzP2GJPv1wMbYo3Ouu2Bhxq6lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753285728; x=1753372128; bh=1ydLjEU0lrRJ3tdUNN1EYw2ZMeJ/FxahObl
	nDkgPZ7w=; b=R6a5c17k2Nm0hHbnM9KRgnVznu2HWZHRuDdH7ZCQdhL4TTosAmD
	LMXIO3jxW9FPP+1g/wzHKVJ1kk88KGasIBcfEa1eI8mNOmntNdAO667qO0GUxw2h
	C3JGVYUgiUmkNSU8aDWav0WGsv7sCmBqH6UtfiyLmrMGffqXj9vI/U7mTx/gkefL
	QE0PALG3zoPRA/3k1BTpuHX+UKYb4KywInnQkW+cWJNlFuRRGZxLWuzLWvcE9/bC
	N1dOqFhlUEaCvVFL3Yfh5CCVknUrsY2/bhmvYiE1tr+ZtSk+7IlbtkpGvOv1KQQK
	27UKz6DsJ/M440IooBFm71nHtTdFAsXTvJQ==
X-ME-Sender: <xms:YASBaOTCl3U-YKaUo2PMnTnRUeULA7hMXzEVJPqKH0LB5jiXRLH61Q>
    <xme:YASBaHDbZAH7iPXzzJ2WoaCj_ptPTUZKHyCQ4ivw9IekTennadhfFc4HDFKZRdBv3
    MN4XEEUwP2qNwnDnw>
X-ME-Received: <xmr:YASBaFSSIomQs-ATiXgYkEnds4CFdT8Lm2whZSoSPS0WrsCbPSTZUF75H6ly_npaWkH_D1hdGoOd3Tm1MS7whU2bny1djIAnIPwLEH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:YASBaFpBAZvIMIGa-5tZotIyeW9K0IIsmR59cAit19qDmeXe0UYEuQ>
    <xmx:YASBaHwwyXVnpb8cqEV_EzvxlNZo6IAZLKTnaxYmFSI8dwG1kLM44w>
    <xmx:YASBaKIWXJD3pyxwFIeAxUHjVcrf4ciZiGlc2Q7y2MoI5COEEh5c9g>
    <xmx:YASBaJLvEfBdrFTvmIJ6G0pUjK9BjZbxbq6vqs_cdBpgPoPu2Lq2pg>
    <xmx:YASBaGkejBpwLBDfp__lN8azTrrEQl6E5u6YSv6eaYmjvnGzCet746Lo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 11:48:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #06; Tue, 22)
In-Reply-To: <aIB0lUS8OTq-oPw7@pks.im> (Patrick Steinhardt's message of "Wed,
	23 Jul 2025 07:35:17 +0200")
References: <xmqqwm7zpxzc.fsf@gitster.g> <aIB0lUS8OTq-oPw7@pks.im>
Date: Wed, 23 Jul 2025 08:48:46 -0700
Message-ID: <xmqqbjpaq55t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think the only commit that really needs review is the last one that
> fixes the sign comparison warnings. As long as people are fine with that
> commit I'm happy to have it merged.

Heh, it is very interesting that just 10 hours after you said "only
this step, I find it fishy", you'd actually have to send out a new
iteration ;-)

