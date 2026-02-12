Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B1248176
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932227; cv=none; b=I3+NC5G4nkryn5kD09U7K2xQFdZrsIDYTg5U84brSmH8qF6uIMy8nM0RTKqzrB7p3J+s/jh7yKDN9J0mCtafRpdo/maIRbmSMRO+AEGDothIM975Yr8ChNIadrPDW4qnLCQKNbItXHt0xbgoBXK/xzmV8k4jq4X3/4WOYjiCVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932227; c=relaxed/simple;
	bh=ywrkdUNo8qcm1eqzVhROAk7OMwDUomZ1ZR9EDR/iHrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOvgx8f7vs7wC57zgL/amvDpFwJx8wM9WOyq6gD76WlkeqUhn8yQZSaEiwv1vkUTh/L1/tBIPilTMusJMjdzE55/Hk1hmLvyzamh30C30usv0qy5Z5cUnOG7aqeKdCO6T0jbdd0LyiFuJ9sGgGUmOgcj59p2i9AupoMlciBKBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ygI8kmU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIQXSN1p; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ygI8kmU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIQXSN1p"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 867E21D00185;
	Thu, 12 Feb 2026 16:37:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 16:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770932225; x=1771018625; bh=Il99bKylXh
	+/rJ+krgo8h5QqwQILPspNP0JoSzhtT94=; b=ygI8kmU1UkS2TEdlKY405qq/ZU
	yaHd6Q4rYO5ksu0XLGm7cykjJ6XaGeTiobkOY2knrc5HM22jNc1Ngo/M+DnlbJL8
	k0+irUuTUqWbjsvXPOFUQA4UZN9cvPKNeeSk5DNBE/75PfY24gqoXuee2mfiG/Oi
	etrl+XnrMw5eImfOefNnAhzaMqei2ZFs9RgZ29yRBgckFfXOYRXk69bc7LYnTP7i
	7NS788w6n3RWRR9wAwlGiNsdktr7rSybQ4jZZ2tcMT75JVC29pIXd+4ToPhAeqPX
	LqwnoxMt5RP1mS7tzve3dFN78nHCRFembN7/xIZJGRdTJHmgDRlFF9d/ITXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770932225; x=1771018625; bh=Il99bKylXh+/rJ+krgo8h5QqwQILPspNP0J
	oSzhtT94=; b=WIQXSN1pAD1PFt8flsYZCnJJRc5tKsia1jvfE3Xr3pxYX8ZLTgH
	wq6obvAhqnJ8OaIGkdm0b9feKq50/f4l7/g1j5eUq15XWreycETtf+v4kldjLphX
	+/S6OD1LwXBB8GlZu3D2pzVwc888SVQqVhVA+YMw1HVBvmwYC+Tzl+i6lCpd3WPO
	8L+eVTpItj2Q9jMpH4MCzXnqqKZ6kqUvqOO7jpy2DgQVVwiCiilCmxoEgZEPYwiP
	FeVMtm26DH/afOWy8ORgzdUQc8u60iBGvJPagm5aWmMYeVINQRsqq00bh9Zvh48v
	aVWJ3XZANbHrdPchOtJ+eyAhlBWPT1AyusA==
X-ME-Sender: <xms:AUiOaf8jCrh3rk5p6YqEZeJ0VwebduoYahuVz8fxakmwEWMz6kOd-A>
    <xme:AUiOaSlU6eSuu4ynoGfxEuxUYE9iT6GuQapb0dyIjLl9MOCT579_iVNwZF7G-X3T0
    jj45xBobN_0p5xJvsZfv2AoNUh2xRMZrBqhd71cWLzFjDpINCjnBg>
X-ME-Received: <xmr:AUiOaVU-1N-c62OFyqfanQ0t0QSDyyYOjlSw1aXsYKaPBr5BOGePZEx3lPVfRqAleHXLKuP8ZVMbtecwL_wmq7JFBT09AYsCEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AUiOaXESXK9K5_makzIDYydaHoFNTm1wIrgbvIDyVSfQ864lQr5F6g>
    <xmx:AUiOaRcdB5YOmsaQ-Vev1cT1KARKRji7Gw5lAeCRNNs2FIup9MLxnQ>
    <xmx:AUiOaYJmWgxpI_NbCmElPd8wJoC8PA6xzylSNXlrpwbx5LnJoPjHuA>
    <xmx:AUiOaWG5pwya-1BD_7Cetvjt1Jp64VTNmmFRuR4ofNDMBDi9JJTpIQ>
    <xmx:AUiOadmI9zv0pBtPPiBhrgwn6Wgxjxj2jP0KEfeOrF-5hUlhaeqUBKj3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 16:37:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  peff@peff.net
Subject: Re: [PATCH 2/2] help: ensure &keys_uniq follows sort -u
In-Reply-To: <CAPvEtrenMBMFaMxcCR4VwoyMFU-_Z+bqq5nJaWv5eyn3HRutEA@mail.gmail.com>
	(Amisha Chhajed's message of "Fri, 13 Feb 2026 02:59:43 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260212041017.91370-3-amishhhaaaa@gmail.com>
	<xmqqh5rlohsm.fsf@gitster.g>
	<CAPvEtrenMBMFaMxcCR4VwoyMFU-_Z+bqq5nJaWv5eyn3HRutEA@mail.gmail.com>
Date: Thu, 12 Feb 2026 13:37:03 -0800
Message-ID: <xmqqcy29myo0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> No, there is a case where it would not be sorted(keys_uniq won't be sorted
> even though keys is), more details on the case[0] and steps to reproduce[1].
> [0] https://lore.kernel.org/git/CAPvEtrfEZXHxcDf=z60ODfUA8cS81rhF1y7KEZApEBby7aCa1A@mail.gmail.com/
> [1] https://lore.kernel.org/git/20260212041017.91370-1-amishhhaaaa@gmail.com/T/#m64880c5cd0d36e35bc78692757cf206b13496aea
> only reason it is not causing a problem now is because we do not have
> this edge case appearing git documentation(from where the keys are built)
> but if someday a case like this appears there then it would cause problems.

Ah, if you already have a reproduction case , it would have been
very good to add it as a new test.  That way, we can (1) apply the
patch, (2) tentatively revert only the code change, (3) build and
run test to see that the test breaks, demonstrating an existing
breakage, (4) restore the code change we tentatively reverted, (5)
build and run test again to see that the existing breakage is now
gone.

>> This is not a performance critical part of the system, so it is OK
>> as a future-proof measure to sort keys_uniq immediately before we
>> start doing something that we _care_ about its sortedness (e.g.,
>> presenting the final output to the user), even if keys_uniq is known
>> to be already sorted with the current code.  Using sort_u here would
>> allow us not to worry about how keys_uniq is constructed in that
>> ugly loop.
>
> Agreed, we do not need to sort it twice if we decouple CONFIG_HUMAN
> from the rest of the switch case, that is a great way to go about it,
> thank you!.
> I will work on it.

Thanks.
