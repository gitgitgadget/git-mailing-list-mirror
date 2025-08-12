Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030532C85
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011883; cv=none; b=dJsPuNCwZFFCp6RR/IVAV1vfeVq4FMC0xmbwjmDnSIda6ogxnUyogDl9YKNd2c0SKNZA/0nKerKqqwYJraEG/ibVJM/cKEjatKmlPgwGVlP+oy7BKzlDmVG2UL0pKCxDHQkY4pKoe+Kr++rRvquScPMKRg7M/J5znkhqVXNlqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011883; c=relaxed/simple;
	bh=sTbWJOJkxg1VQSJI5gUHcIG/ssX8aHI2qphZO081TBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHbRTeslABCuIfHtiYwiOJbdzWe+ERZrLV6bKEAMNbpNxClzKIhuljawED0oROUM/juh9Z9XRLfWI4q0pmhvCe8JZ6eQwN13vSXng4/RPO9UoTfUA4wlG9Z5EzA72FjpWBwERONi9MskUVB1tX0ReU2d/sGwd4TPdfoyrsN6GXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZKixPcSL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXQ7bNbH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZKixPcSL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXQ7bNbH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22B1F140011B;
	Tue, 12 Aug 2025 11:18:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 12 Aug 2025 11:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755011880;
	 x=1755098280; bh=uDPxCti/IHvselVfpoMbae4lXq4YT6AIYhVPh+epe6s=; b=
	ZKixPcSL6+oHVWAAMLAXt9u3DmwqlIqNtuN7L8WniSjVOm6IXqJU0qji54zg3BNK
	RcbqUW3ki66m0NoVwKE7DPhqG2DlsTjKis5eX3aG3F1uqhiqtefM0ROhAnBsGvtp
	IbU+9IqRqUG9IZbB2pzYpL3NV08Q6qx77w8WTUIS8tIJRI5rKW3tqa49VYFblW3B
	Md93ZgZJ/VfrcZBqiXAg+vQCmRP5l4ucugznYjVsXn+2XcaV8FoQIbBYBGDwQ8io
	CkG1DGQyL0OKu/6hDXparQIlDJ5FrtYGWU0Um0/6g7Z/BA29w2E5NOGs0iCyUo9G
	9zp+Q8URdquImE0Hrwmb5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755011880; x=
	1755098280; bh=uDPxCti/IHvselVfpoMbae4lXq4YT6AIYhVPh+epe6s=; b=S
	XQ7bNbHPWU1mo2vPBN4gaulTJTvX4+E2zv7yzcbBnWto1k07F9NgIwLHCX3R7ugu
	4W2wtpbM0rl5sC2ILdLVM271s7SmtDCd1/tABokTxt6GK0NAQ098wdrbDQIZnBiZ
	YmNz/2/fW2CEe2eyBW8B5ROx0ZxnvGrNgr0hUfPbPM3gIAUoD7sbggHpXckEbUmq
	j0Ngbh5FQSlpHIPcBSY7CHAVgUgFbBacTrQiCAZsC2+y7gE/rW1gFR2GCk2PDefr
	YHI9zlQEjrSpIvMIWBbz4b3CLsmibV0cEyg0yHEWD2GmGTdfXAl0t6nkmTzDQ4KC
	QOxbnTyJA75Uc72+KqM7g==
X-ME-Sender: <xms:J1ubaAop6HBFH-ZK6RUnu9uddXtb5KT-4AtQDqA7Tr5wpbPOtR0WKg>
    <xme:J1ubaCIIA8xbPZ5FZiZV_TWWRRlvexMqZbE8H365-QDuw0yPagKRTH15LQzKGpXin
    G0P-48V2_Yfd3IIuw>
X-ME-Received: <xmr:J1ubaLoskhfPwDc3KjB6uvdUPtK3VuK0joL5i7Liwm9C1undOO14J3tEfCVqCKawCdAtlZUMN5wFWeeGb5Hg_XBEkwagsBO9cLAgrp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefgteehudejvdeufedttdekhedvvefgkeelveetvdeuveevfeduuedvuddu
    ueffveenucffohhmrghinhepohgsjhgvtghtqdhnrghmvgdrtgifnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J1ubaCzk-RlMRl25unBPnuKmGnx7zi_yOUb5-akRfFy_p7Bk-mqAQg>
    <xmx:J1ubaHMI8hYQrO3flPCvZFCk2YT9znUjBuyKhALHqdcm7m2dc8thcQ>
    <xmx:J1ubaP4y4hKm85XBOG66oVa2VO-2h1CkrHyRNxBYpeceM0eVUIxt1Q>
    <xmx:J1ubaIkruYFuWe1pQGuFhWnDpxgKomuq70kNY-sXQZCT0fcbc044fA>
    <xmx:KFubaMGlvgqEoJxhByV83AgV_PknmMQd7KqYx6vKvQjh5aS7X4WCuQvB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 11:17:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,  Jon Forrest <nobozo@gmail.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2] abbrev: allow extending beyond 20 chars to disambiguate
In-Reply-To: <9ae4a718-b00d-4435-8739-cf87b2c9df7d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 12 Aug 2025 16:58:14 +0200")
References: <xmqqfrdx517b.fsf@gitster.g> <xmqqzfc51xvk.fsf@gitster.g>
	<9ae4a718-b00d-4435-8739-cf87b2c9df7d@web.de>
Date: Tue, 12 Aug 2025 08:17:58 -0700
Message-ID: <xmqqwm78vaah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>>  	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
>>  		i++;
>>  
>> -	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
>> +	if (mad->cur_len <= i && i < mad->max_len)
>>  		mad->cur_len = i + 1;
>
> This combines two checks: Whether we can increment and whether the new
> length is greater than the old one.  Only if both are true we take the
> new length.  Shouldn't they be separate, though?  Why reject a new
> length that happens to be the maximum?  And max_len is not explicitly
> needed for the first check:
>
> 	/* One more to disambiguate, if possible. */
> 	if (mad->hex[i])
> 		i++;
>
> 	/* New record? */
> 	if (i > mad->cur_len)
> 		mad->cur_len = i;
>
> René

Great.

Your observation resolves my puzzlement about the first while() loop
that has been bugging me ever since I started looking at this code.
The mad->hex[] array is NUL terminated, and the loop can terminate
correctly without being told about hexsz at all, and we ought to be
able to use the same information to make sure we stop incrementing
the .cur_len member without running beyond the end of the string.

In other words, wouldn't this be what we want, without any of the
max_len crap?

diff --git c/object-name.c w/object-name.c
index 11aa0e6afc..4cd1d38778 100644
--- c/object-name.c
+++ w/object-name.c
@@ -704,7 +704,7 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
-	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+	if (mad->hex[i] && i >= mad->cur_len)
 		mad->cur_len = i + 1;
 
 	return 0;
