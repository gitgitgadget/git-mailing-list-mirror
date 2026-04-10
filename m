Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C013261B92
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852629; cv=none; b=ObVf1+ylCmb2H3Cx+yXevVZ+0lhVvhtOG7Uv/b3dkKSNO7ytkOSrhAR3sqgYiVazIV6UjS9ZhERCJ14K3INcWe7GB4FaGuU53EawDFaPPOlWh5/IjAye0vqDIXlSuGsZVpAJra1SH4C6wV4HmKqd6CQt+KGzsZKtmSG8E75vk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852629; c=relaxed/simple;
	bh=8dBOBRLV90SSmmvv0ljHkIhX//KhjMxfUdKBhDBIUTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BohoBJvRiprn+Kt/j04sbtlBpSdVh3nxg/rZNKqYtDKViPSCb5p3IyNgJB63jP9pFXuXVm/ikM+zz51hZC2/dzAt49hGdXLk+mpV8ZU4e5gihJZR5ARF/Dz467PrzuMFZLUdJlTcE87w5twjmz/7Xyj9MdbWfj4RtMgcD0tuAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wIZqobqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i83yUnHj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wIZqobqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i83yUnHj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41CC57A011B;
	Fri, 10 Apr 2026 16:23:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Apr 2026 16:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775852626; x=1775939026; bh=F2sZXZLfAg
	fUj6TOybFpd9vsgei9HiJ99lJJIRYa09E=; b=wIZqobqt8aXx8IXP1JnLm5ruha
	v5S7gsjoyuO5HaEn1Zbp2X05rt9lWZ1K5g5UEBmOm8onE9chdWir0N7SvVAKU5gU
	hDPnCnDiK/fxB2EQwQA+KHmDu0Z/QhW8X383ev8G715Q/QIjgzIAXipb8IzA9ER5
	+m/hDDilsheu9CifmNq5z2qa2K/puXsPl5OB3lJorOtHZtaLeaXiAMzcBio2U8bV
	N1bV4OIz2XjEbnwXvKsGCGVp+1USaFBw3kD64AaV8Yi4SNcr+PXDku70fSbawMY5
	2e/Swg/wCwh17Io618139Zhz1JDnkn/OrxveEQUe8U88A5GQnP/DSwEpHGTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775852626; x=1775939026; bh=F2sZXZLfAgfUj6TOybFpd9vsgei9HiJ99lJ
	JIRYa09E=; b=i83yUnHjN0A4N6TILG0F4vZvWXIWUEqr6/1zyILK7DuN8ALRxak
	UdJDpmexdD71PeK+jvvGvIokjHjlwPF6YvtFwqnsK70FUQqXP5tpZkvVbTD6/EEy
	MNIyStlRpEh4CN19VAz/3WoIdiYzYMdgG3k7BBlERrh1PjbhvSWjvMxxkr7M5pvl
	YYmsm5DYp2DOHfkeU/sfSsVrvPkyqzV2afukKFOLY1US7to+gndB0MP9Kt8/8i+1
	mzrLuRUu5pj8xscAVok5vLwLH8CXOgd6Rau186ouq3Dcs6Z2v6BR+gjMSakG2gCy
	JLI9SDG1TZazt8V0ymLNF3KIWerC5EqjNkw==
X-ME-Sender: <xms:UVzZaeoPMJrVDq-orwKdI6hCVJqfmr2_MfO0_HlvH0lALq2gxYrXQg>
    <xme:UVzZaQVE7GMvfSsOEVLRJvhOJqOl8DGau3L8TNutwlO9-k9bz_6nGpwyO5IlZaPWu
    xsC0exOIVY2AcDzor04CzjhJ4f-sd3J197s73yTgQvW978UhdNHCQ>
X-ME-Received: <xmr:UVzZadDOFCSCLxM3lZ2gTniucUZjhWgz8DW-fCVFrNQaEi7vqQTf95b6a6BDEy_4PcL7wkUBm2D2O4mcCBfDIsehZIp3-Pzw_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UVzZaU1eWPrluEN-8uj4va6p8etE53Z4MRaaNCwx8Qv1iAh3STpJ4w>
    <xmx:UVzZaf0jyxcXHw2gV54JSpf-bw4yRlKEsiPl5vaSksaafCyHAkjnkA>
    <xmx:UVzZaZC_P8Y-CP62b97xECdfND43FQuFzuhDJbxphj-KzDJP7GC5Mw>
    <xmx:UVzZae5mCDbOtTEXY_ur3pi10BXu8xCBB9VuEKAP0Z9DhzRdhJeUHg>
    <xmx:UlzZaQ0f6o13Rsn_nJuGcN70JxJhKUNl6sxNxqG-vZ40eBNWuwJKG7qd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 16:23:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/4] Enable Rust by default
In-Reply-To: <adlXscAv57Xd7p01@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 10 Apr 2026 20:04:01 +0000")
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
	<4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
	<adlXscAv57Xd7p01@fruit.crustytoothpaste.net>
Date: Fri, 10 Apr 2026 13:23:43 -0700
Message-ID: <xmqqpl46o980.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-04-10 at 13:02:13, Derrick Stolee wrote:
>> I'm glad you're remembering to help us follow through on this promise.
>> 
>> However, I'm worried that we shouldn't do this change during the rc
>> window for 2.54.0. Perhaps we could get a small patch that updates the
>> docs to say "we really mean 2.55.0" that lands in the 2.54.0 release,
>> and then we merge the requirements for the build in the first batch
>> after the release.
>>
>> This would give us a full release cycle to simmer with the requirement
>> instead of slipping it in for the last rc.
>
> This was actually sent out just before rc0, but Patrick requested some
> changes in v1.  (I forgot to thread it to the previous version,
> unfortunately.)  I would like to have it in 2.54 if we can because I
> suspect 2.55 will be the last release before 3.0, so that doesn't give
> much time for people to update and adjust if there are problems.

Huh?  I actually was hoping that we would tag 2.95 when everybody
feels that 3.0 is on the horizon, and if we are lucky jump directly
to 3.0 (while leaving us room to issue 4 extra 2.XX releases if the
timeline turns out to be too aggressve after we got such an
agreement and 2.95 turns out to be premature).

You are saying that we'd skip 2.56 and jump directly to 3.0 at the
end of September?  I do not recall seeing any discussion, let alone
a concensus (rough or not) with such a short timeframe.

