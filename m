Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF21F942
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788678204; cv=none; b=dlTcu2756segFPb0UU8YCDwdSmBk86nV3sEZpvMacpTUqOBRGNxBOykYHfXITEQfA/5updU8lw0wLAXaPHVuIObGwNNBpiOJ8mchGxL6WzJINq6nPNg04dZUKDlFyxm3pdAPAAtHNl4cbW3E4ZcIFtMoRP7FdLjflbiSIweOriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788678204; c=relaxed/simple;
	bh=IQQxkXH5bkoikOt8m69qHr6gy7ukBeZtqknypoEPczE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aXy34/bcZyH2+9O4aBEN7rSjDzbzgrTdAJPgRjhfJGJJJVfDSFay0hQZyOKPbjSyaVGLYoUspeBn8e5LGWzfhjPIj5AQ46TmapRFUoGozHAcMEqBN2mcLWT/v90VflTKak+N7h8/YEmQgkRCF2VmQcoYuC1CuzpCN1S0uCU0OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ja3a/Gx1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMnR/+1Y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ja3a/Gx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMnR/+1Y"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F13127A007C;
	Sun,  6 Sep 2026 03:03:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 06 Sep 2026 03:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1788678201; x=1788764601; bh=J0ry3hNBGvgoMUs1MSB//meRSKunxK+T
	r33iTZ4nwhw=; b=Ja3a/Gx1pNve848FbXDx9OkzzV5x2NBgUKtNiviDWf1+T2XQ
	OfHsdMGB+S67UliIBlhTJoCxJQu2jMsiMAIcaOxHOyTbu4gfG20d4ftM4VfBeHTM
	8PsopJSM+FC8Pr8RtVTth2ZJTrmkAozRw0QqciAMAz1qGaFGGJ9U+5ovWjJFVarc
	woI61bk6wBQrXJ6zg2vK9KwyK3pnaS5luztPM7Jbbh0Fdw/K0cof/EZkEpWOOFj5
	fV7pDZb1/GCvGf+5uQzE/qF4hNa0FQbuVDq/cP//GUhKFvOYm+iVx4RgvrmNOwQY
	gK7qLNRGPXX2+Ken2plZnEQBdR9gfxlZGkjyYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788678201; x=
	1788764601; bh=J0ry3hNBGvgoMUs1MSB//meRSKunxK+Tr33iTZ4nwhw=; b=F
	MnR/+1YBLMlfzv46ZOSEx5v9dLFMK1KR47iYOYUnW9htx50gS2YWrx4Kvqr7Ukpm
	7TYK3oEy+Bm34hGljigvdn5I5YJgvf0g9f9MaXsOKMdjaKlWGey0RtRlMMImNUHo
	Zc9kpuDQVczUV/gSyTwr4hajah8ZD07uIYtdHcv4a1Xkw0WiaH/hvb4PD1nQ4+jK
	fjWksgUthTj5ntY14d8pADmPmzxJUZs6qKLuFTGZvPwfJVzhT8BGDjX6095ggwpM
	XKUrlTSRqskkm0PD1YC6rv43nJySOYDuCIzv1AzycyX9q+YE7B8NbNU0BuXCFETF
	izKwnehiqvssGiSgh8vTg==
X-ME-Sender: <xms:ORCdatTzrfY2SgMntMWF7qmpQ8KYq1s_SMVV7EvBzJzxIcF_vHPXpA>
    <xme:ORCdaszoJMn7W-g5Ptdj2vKqcbbSsAzZe0V31x2AIIetxURVGb4qCFmcCBz4rzJ-Y
    C59CCzPAzSH345dyiE4jQ_sSjyJAMHXgmbzU3ZKsuTVx2qR2FY7XA>
X-ME-Received: <xmr:ORCdagddN4bD21fEHbLQAzbrqnUjbqRiSkJK67H2-pfucv2b4HX9kUA28gO6zULT_iv2dv7O4k7sc5NfTgHXT43zKgqpMBiCPg3x>
X-ME-Proxy-Cause: dmFkZTGRDEGF7QRibKI2h03cEd1IuyU9X8YDpNsSSbvsesfJn3G/1gg/iJ8TchGqtJM1uj
    ibLrF293CKEy2dMt4LWET82L8jQ71ia2LkMzTkmHDI0pvgcrqTWapFtWgkyq+twI/2GQbx
    cgrIV7VOrZWYQTQQjzwQqztjGO6m+3lAkyxzL1vpVqX8qmTZzI8U6PSHYdgOg1M7msp26P
    kykRVzbV6xk+kAtREkGN9z5mklihb8N7PUT/i6VC93us1a1ouW7WNQgh98a2P6m9/AVYTW
    5DGHibLvHgItPiDLXBp+kb9kTzJy8lSageK/doXDH2gxGKvwpMzm2Do/Fc7T6J/OmZR5dx
    CyunixOtBpQ6ufcTYbbN6kr02mAiH/J1GYnDavfjnqoz697OHbGdXacugG5lr10f/jDTNZ
    PyRmW1XAFeFekm2Bz8d8WiIEg2XLQXMsCTa5yR1x9JZG0JGyhvu1+M89JXryva2edAW5el
    kKysJmErHoBOMQenVSleCSPqWW8wHVzKamOigQYMozOEGY66Hlz7g1kBYKcA0piv5/43Cw
    mQKork8wNwRg6xxYGy3m2sC9qLsyZM1B1YeqFfZyFXX0EeUf/1g+wuo8Yt884+lpJ1lNpm
    rKTdUgtSM2CA7RA+sbe9bChW/jkSzksHsn+aoIcC0661BIEQ1uU+/Rjyfe2w
X-ME-Proxy: <xmx:ORCdagIvdd94LEL6D1hU0B2HfHaXuaIPOvoKKRsqFreOn-8dQG9F4A>
    <xmx:ORCdapFNv2jO7q38SmdpyFtf3T5Nb5NQv2nWvvZmrHFot12XJ_MuRA>
    <xmx:ORCdaio4aFZn2GjjiFqk7oxN_kYeeiL6uaWcruV6i9gVQeoPpNf5Tw>
    <xmx:ORCdaqRYInuCya7xkxFiwgoQFQQt45JdVqlz4RQlrL2UsW2II3y6uw>
    <xmx:ORCdagp8TY5gjvwmYb8e4kCMwyaiCI49Q3VCUvZ-d4HSh5aDQFpfRhSb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Sep 2026 03:03:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What will come after Git 2.56?
Date: Sun, 06 Sep 2026 00:03:20 -0700
Message-ID: <xmqqmrtu50av.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

http://tinyurl.com/gitcal tells us that the current development
cycle for Git 2.56 will conclude around the end of this month.  As
our typical development cycle lasts between 8 and 12 weeks, we will
have exactly one more cycle after that before the end of the year.

Now, the question is what that release should be called.  A few
thoughts.

 (1) Git 3.0: it is tempting to conclude the year with a big
     version bump.  Splash!

 (2) Git 2.99: by leaving no more room until 3.0, we will
     conclude the year with a version that is still in the 2.X
     series, but will hopefully force us to seriously prepare for
     a big version bump with the first release of the year 2027.

 (3) Git 2.98 (or 2.97): we admit that we are not ready for even
     (2) and chicken out, leaving us breathing room for a few
     more preparatory releases before the big one.

 (4) Git 2.57: doing business as usual.

Needless to say, this is not a popularity contest, nor is it even a
democracy.  Regardless, we should review what we have in the
'BreakingChanges' document and ask ourselves how ready we are.

