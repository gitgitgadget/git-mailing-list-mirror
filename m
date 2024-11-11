Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632771586CB
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369106; cv=none; b=C0xNWT61f0JedXIEf0s0ARORMpQTA+qCKx504uo1IKhctK8HreZ3r22BUs2HPeG7/pg3rbzhJ2v+sBNIvXjgvMZ7BLIMpnlz+t/SzQAPupyKCRUlkDuHa1NdEpq6uPPBTtsly+d+YnS2gv9xx1vfVFdF856MrifBz6vHZZp7Om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369106; c=relaxed/simple;
	bh=Wd857AmpwGzppKj28rcFUY5sehIZj059IPe6UOV1ERI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWczjaj/3T4O9XlC6cSuLVbX526QZwzYIvy67U8+HWN19yBZsuHq0jpNGUpq7vtsktnzvsgK8EO5F/iGtapDfJUYHK2M9z0luxMbHHc+xE+/hT8+T6dedp4uAF2ZR8s1jVEblW7syPtszkYCHc9WyIToAZRSWK6tIuRtPzBlFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k38JEmtw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+XB9gRi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k38JEmtw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+XB9gRi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 28A3D114017B;
	Mon, 11 Nov 2024 18:51:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 18:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731369103; x=1731455503; bh=Wd857AmpwG
	zppKj28rcFUY5sehIZj059IPe6UOV1ERI=; b=k38JEmtwwaJwFVFU9MPSsGRe5o
	dy8tMRiUogHHqekUJ+VZLoWymKoo7iFTKJorWMEjgq+ZnmSQS4HjDKVlwTj7M8uB
	b13rO9w0rqvDs6K/DQgQ+SjxeEkyWYqMzlHYgGyDOaOCb1brlTCMhvj3SjY+1/P+
	i8w9/UaCKavTuOLNdYQFd+m4IOSXPuV6I5PfawXgL/vOK+Q5FwStNxBP3VScuI5/
	58BiU01m0BJ+g34BNYzbSurYwq9cuizLeYSD5XGBxy7BVodfiPIFpCGKtj5D4dwm
	XRcamnM1S1IjJ/5cpRqTHFyx2TZAS12Jkno2da8VvDaXbYmi0O1oeKxUHNPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731369103; x=1731455503; bh=Wd857AmpwGzppKj28rcFUY5sehIZj059IPe
	6UOV1ERI=; b=P+XB9gRi8IHNHaac5Ull+JSitE+4yJJEJ06ifeEVPwqsA7RUpxH
	1tIPNLDhcXzevgQ1rz9jQp3WNiLaCr55BKWuNSRE2k/XU8+N2L7/4AJdo7x2aKYD
	+mpT69u/7dNXmR1rNmNE87QpLX04DKc/WN8zFutXMNRQQ8++ndWF7jpEP/ls2gY7
	Ug9Tg19dEzk1DI+iaH8dj7DXo7c/k1wbhOuwb+S/vAI54jetVjoHXoyO2lRvjkOT
	Nn0CeicRE0TeH072zhu75XlaayCPtulyTRYt/Hm3MrmMGPVMLTvY/tCi/SiHhddn
	2aKkgIPdjfE6CR+jAQwXAFcHJPGY+q4Lp0w==
X-ME-Sender: <xms:jpgyZ5jtIQIeBZ5XdXlvYUbCUopOBZy58I4ZUw_CV5--Vg8QZFXfRg>
    <xme:jpgyZ-DV_oO2E91xwPsOMc73TJwebIttaymYgamCI8AYNCyTf0gcXyWZkg9OkQsZU
    Yz4YEWxtCgdJXUnjQ>
X-ME-Received: <xmr:jpgyZ5GoiIkp03_HcbNditYZXQB_L99rHqbp3PffHBDvdbbPKJ91IxO4Q15PUYCMO4eRpAIDOCbExqd2aeKQ3-tJXxBKAnQ47YYl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepshhimhhonhdrmhgrrhgthhhisegvfhhfihgtihhoshdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:jpgyZ-R3Mb-9qwGznR1XbVtxM2v9xkjDhoEAKQddckFGNu2ZhhSN-Q>
    <xmx:jpgyZ2yoOlQFkTy35uPuGFqdlEdryfkKuJYlHlXad7X50QbpbcRAJQ>
    <xmx:jpgyZ05awfyWHfwo14WDkCwO5EwStVCTQitI-VfEeQmU5WWJADBSVg>
    <xmx:jpgyZ7wY-6tXQwzEpXwp70Y2s11r7likOMUHaO_kM-GJb6lhwdiqMA>
    <xmx:jpgyZxyYSV0bqr8r_4_WoN6Myp6HyfCSTctXrc_qGBj7_Y5IkbkAAIqq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 18:51:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Simon Marchi <simon.marchi@efficios.com>,  git@vger.kernel.org,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Taylor Blau <me@ttaylorr.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/difftool: intialize some hashmap variables
In-Reply-To: <20241111220959.GE5019@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Nov 2024 17:09:59 -0500")
References: <20241111162148.337375-1-simon.marchi@efficios.com>
	<20241111205453.GA5019@coredump.intra.peff.net>
	<09bf8815-320b-494a-87c4-34bb0df08595@efficios.com>
	<20241111220959.GE5019@coredump.intra.peff.net>
Date: Tue, 12 Nov 2024 08:51:40 +0900
Message-ID: <xmqqmsi59vn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Please let me know if you want a v2 or if you are just going to merge an
>> updated version of this patch.
>
> That's up to the maintainer. IMHO it's worth using HASHMAP_INIT, though,
> and perhaps adding a test.

Yup, please do.

Thanks.
