Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03198FC0A
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275707; cv=none; b=QXJI8xF1756N41NKQvGf9BcrLuEIhadFLpbhX0K6WVGeyZq8wtgy5uehuOxAuoQmF+EPGbmxJA8bljmy8lSfs/V1wEhWfWfzDAbumw3vxrQzeYTXA1+hNahm5vnsFYBxv/A62LOOEDTltSbsZRYhKxQkMibZEnbghG9GZrR2IaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275707; c=relaxed/simple;
	bh=m4ab1HLnhIumibH1Zr549gSJkl6PVf1XABDDqAROQyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5ZhTftEjVVz8hu0m5MY6s00fN11TnWIVdv21DWuWL54iYZ1qxWbidh35PhrVwzwmYQuQfusfj76zVd0g5ibPz9X7ad46NlyYXCO+C3U/OW5KECLRniZFJMyRb2VuCl4u4xkuc+8npvw6MqHoOPska3mLd9O1vDK6GDlz1jNvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cf5qCdsk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwTgqkPC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cf5qCdsk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwTgqkPC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EDFCC1D00257;
	Wed, 15 Apr 2026 13:55:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 13:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776275704; x=1776362104; bh=8dT5UHmx3g
	VqFZXhLOQJyJNhQsiP5lUrSLTfUd8e1Lk=; b=Cf5qCdskPP7GTxsApLXNZXEbJL
	2UgGDZvwI9TOFeD5Ick9EcRNSqQcUH94WZMEreWkVmYMfsaP+0viIN+DROTJkU/W
	/JNAs1+NPgi34vEadmp6n/41divGGDGTBYDfSdorajJ7oFegtyo+OGuLrTtIgh/Q
	DAG1OWmQO6SJD7oa2CAKXZr5BaEQzS+rbH4PonnXHozwDi2T6DKA8FP/rRZDq93n
	RSVBwMi8kkfRvuVAsUH8DkWixVGijJPshwExy23MvAVKaCoCnUCltnnUx+jM+vdC
	/oNeix87VBl01AAuXiRDZ8Q4NIYJ0ziL5zOJo6DvdH9r6NUrb1a/ZoqE3IgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776275704; x=1776362104; bh=8dT5UHmx3gVqFZXhLOQJyJNhQsiP5lUrSLT
	fUd8e1Lk=; b=MwTgqkPCM2garxokI81/UhJ131akQdvT+eKkm8OVqTWDroWXjKR
	VpJ6bZG5dgwauHq2G4CZikJIelVZ1/70602mRjZJ0BkZZibdNHsPFiU2yE5m7Ejx
	F9ycwfGAXBRsNjVUh2YSAKEwwH9O4u0AmjnYPh1TyvneXEX1fX9YFTAxrjlbfml6
	uWEBthCY+KmSMuwYfsepo/WwcvsPnvMM1aMblYbPzpdfQvk1/KNRZAWn9azrIKt/
	gu2eydkXhVymu3fCntZQ2j6Pa4LwW48MIqKu0NkUFVaE/c5ES7FzuOaoO6BxpeWc
	NfQYHnbUMItx9FNWbVWuZ20OxD6lTjGtkRA==
X-ME-Sender: <xms:-NDfafOAKUegNfzjMGAU4K85XUWKjS1Jp8Hk2S4W1fit7HJkQBjV6w>
    <xme:-NDfaQ0gt0t109MuFAoUTBtrJDOGrCk9JekCwxlcV3A2jcH7VU2TgDCLYMicwHWVZ
    1cApOW_YMeUdHtdd0a7TpsP42Nkmzo1IM4-3TaYhuiqdT-vdDhlAQ>
X-ME-Received: <xmr:-NDfaWnm0jjNjAODnLqXg8oUdHqONL8F2D5AssOicM0rS1Tsm1AvQGHEj4zZE5Bjlt_ZHHl2DRtANUQCevCjxDq_hTFCwt9bZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeefleessggrrhhrohhithdrshhhpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphhlrghtthhnvghr
    sehnvhhiughirgdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-NDfafWaO6nFVKJb2FRjZ4FTHgILABTxHMC5iCkINVri2vNaTj1FFg>
    <xmx:-NDfaUvViiDgFVMXJdfxlvYKtyu5UiPBwle_1YyrJmfKBQwJ274tGA>
    <xmx:-NDfaaaM3kV9QjSI1b6j1adsPI3l9yjegNp9g-jfBiVAz5RQUm5-Dw>
    <xmx:-NDfabVOYKU8fDKI3tvtL2izDxfgjW0VrtgoMtP1HxxG4jF0kVsRhg>
    <xmx:-NDfac4EXecR7rECcYiG5ToYav1DpzwujRP4ZG5yC7_Tew9gxS3pVBta>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 13:55:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 07/10] parseopt: autocorrect mistyped subcommands
In-Reply-To: <ME0P300MB08117F31CDFE8D038C3E0557CE41A@ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Tue, 17 Mar 2026 12:21:42 +0900")
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801E3F75349DFDF98C221F6CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<xmqqse9zo93p.fsf@gitster.g>
	<ME0P300MB08117F31CDFE8D038C3E0557CE41A@ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM>
Date: Wed, 15 Apr 2026 10:55:00 -0700
Message-ID: <xmqqse8w6rd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

>> I would have expected that we would just emulate what we already do
>> to the main commands, and later with experience with the subcommand
>> typo detection/fixes, would tweak the parameters either only to the
>> subcommand part or to the both with justifications.
> ...
> Because of this, I was confused about whether I should copy this
> behavior. I chose not to.
>
> However, if we want the main commands and subcommands to act the same, I
> can do that and try to move the logic to autocorrect.c so both places
> share the exact same typo detection.
>
> Do you want me to do this?

Either do that (which is probably conceptually simpler), or explain
in the proposed log message why they have to be different.  My gut
feeling is that you should start from identical settings that has
been used for years, and then in a separate topic propose to improve
the parameters to improve the behaviour for both main commands and
sub commands at the same time, but that is largely because there
weren't any explanation why subcommands correction should behave
differently from main commands ("Correction for main commands
behaves strangely and I do not want to inherit it" is not a good
explanation as it invites a natural question "if you have a better
behaviour you can use for subcommand correction, can't it be used
also for main commands?  If not, why not?").

