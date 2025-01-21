Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6A1F543F
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490245; cv=none; b=b2cC8G7uFysSsPO7xtkBk4C33RfmI691twN9sIHIuprfw70BkmQ3uhwsG79yyWq626Oz9TOR6MLaRjC86HFuH8n5sHhQ1pzduveQp8zJ6iqVAthkXFkaeqk/oUs3ppZ1ElG0g+HpzJFhiJAcRCTFPuhMaVqFTLErG1eefxt/5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490245; c=relaxed/simple;
	bh=I8IUQlUPKZlV5fVSwvuevNTIX9Vj5+GwPJZteXj87Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICXrWaIJluI2RFuCwC4XHivY7f+vmFn0KTW+jJe2zTJFT2bYaMOrJx9HXikkH5NZs2d0c2V4xVc6QUOe3A6+9ujCnGa0wH3Rz5T0Q7T8sQEhOdLPcm2NHihH7YYSQL5DT6muo+iTOJUOcTCCce95FW7KtWQGcY+ZYPQHu9zCzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rurM0klA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWowWMWt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rurM0klA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWowWMWt"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 521A525401D4;
	Tue, 21 Jan 2025 15:10:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 21 Jan 2025 15:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737490239; x=1737576639; bh=zWOhvCbT27
	nouQ+2811RJrylrhab7D7jfomsRD/PUe0=; b=rurM0klAnMJn1Q9ikDRfAAe5YG
	bd/DqSKeV2Sk7Y8RGRmXnl2WDV/dKJfIkdWMfjfUOHQH8BJ+rxnXWltMmrWjr4qr
	gVtUGnfseYxGN2p/rvBM921wapouqGVNFd1ox2/B7sMM/gH4G3HFHzZ16yD47r7A
	wPofJ1dlbVPazua4iMU3Rt+Sfc5U7vzxdN/2zIkkbcu7t747Kk2kwgFUiqKV16PC
	ZmkPWSuUpLsfs17SQnv41u7LEIoWPwFv6hg3Zm2yiniqgkRKrwBIWiyYibT6Lbob
	2qc7wClSMa1BPz1bDJlSPE4+PUGOm3juHLDNgRE+q/jZvott+WcRM5l4EM4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737490239; x=1737576639; bh=zWOhvCbT27nouQ+2811RJrylrhab7D7jfom
	sRD/PUe0=; b=uWowWMWtiLkOVCo+3c00Q9yi6NFgssCc61/aKgjFT5Oo/ex2dJw
	Q+/1sKSrK+qDhYFrj+N83JYd6yRuJVepyokSymNjef624KcmSZ8jnayS/cnRsSCP
	JHZ+ejVRclPRvyPDWMgTpsXN6YFYr7CslVCg+nbv+QwGZ71z5X8jBKFKz5AJJoFa
	712S+jEBNbYHDcKjGyOvktoZAKz58QltQj+cfaf3PnJq14OvJQ72YbpBad3INTyo
	6tsqzRRHBqUqDjuzmluTOcu4BiabFahm7KbRiNUe0I9WVqzBO4zcq34WubqTRuyU
	WC6gaagTZnOXIBrTY/0I4F0czsqM3Ko98pw==
X-ME-Sender: <xms:Pv-PZ9dNU-CGtGwe3duP3F39dUbTJou9WRA98Uur7pccerRkxFBNeg>
    <xme:Pv-PZ7NqkdcHdfWTINWvAW888LQZAPgvOg5GhCq6svMaHMaHaPX67HhY2v17t7RNq
    6FbwEcsvtizXVkLZg>
X-ME-Received: <xmr:Pv-PZ2iYK_2EqSFTIca26GHW5jfnhUXlA2Bf5jPl5ZCGOeXuGVmNf01Ggy0vok1i0nBBWzJaAypYyo7LfkTTNAdJLNKTBSEmtVV5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjphgrlhhushesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Pv-PZ2_AQOtXX4E4huPwqYwvLWj2glkdoG4P4YXOHF7nbw0qUvaCMA>
    <xmx:Pv-PZ5ttDTygG8tY_A7sBuYHeWDuAAbsGCGP91g730c66P-sc9hQnw>
    <xmx:Pv-PZ1GJ-5c5kF7W29JMrwC5mNRp3pIgdQX9X4JpHUiMq2qp7qo9iQ>
    <xmx:Pv-PZwPPwfoWaCGn89de-jj3bcygvqBKS3QJuOqIRQ-5D-niuzwCyg>
    <xmx:P_-PZzIb78_bytJn5lTUVy-bSF1Uw7YaZwphInVyL8_zJiYfofG89vB_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 15:10:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jan Palus <jpalus@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] t8002-blame: simplify padding generation in blank
 boundary tests
In-Reply-To: <bwo4w2qbbe6czt4n7vshwyn4lbl2ieihqmdugz4fmnhd4qbsd2@tevhcjwigxbi>
	(Jan Palus's message of "Mon, 20 Jan 2025 11:47:56 +0100")
References: <20250111231107.2190448-1-jpalus@fastmail.com>
	<Z4UIWId7ExLB2gWJ@pks.im> <xmqqr056bv8v.fsf@gitster.g>
	<xmqqikqd3p3m.fsf@gitster.g>
	<bwo4w2qbbe6czt4n7vshwyn4lbl2ieihqmdugz4fmnhd4qbsd2@tevhcjwigxbi>
Date: Tue, 21 Jan 2025 12:10:37 -0800
Message-ID: <xmqqzfjkylky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Palus <jpalus@fastmail.com> writes:

> Note that original version was "%0.s" in which there is some ambiguity
> whether "0" is a flag or field width and not "%.0s" in which "0" indeed
> would mean precision.

Ah, I missed that part.  Also thanks for filling in the "printf from
coreutils is the one that has issues with the code".

>> Anybody can help that "further polishing as suggested" step, and
>> when the patch is left in limbo for too long, I might step in to do
>> it myself (when I have no other better things to do), but it is
>> customary around here that the original patch submitter does so.
>
> I was about to follow-up but didn't find time. Sorry it took so long.
> I will post v2 shortly.

Thanks.
