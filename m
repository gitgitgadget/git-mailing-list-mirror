Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A100362061
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431680; cv=none; b=oY5HFIp7nXYMYWcATFjNWG/cezoEWSkFHsj1ROZeGKHzKBvfQLJ6ZPsM5qGonBEMNS/OQnivf+ebsDShfrbJee/rxhXGaNMAPW01j+v3S7DBJMHr+6XlbLtJxsp/A4RRabNNsLgKy4b1RRaENs4ELZfgh+8OdCjcaT2CQPczgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431680; c=relaxed/simple;
	bh=mYd2qqXMtiu6Gc9v423tmTT1R+ZeOWFIPuJcSfLrCz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z76dXlxxYsGsACf1+iG8FaoFlNNJV63Uy8/EdrRJNxrotxPYG7ITJ0goJf6y/xx8yAa/T47XaaBBMuYo6FuxkhVTc/akTo3hnzVQkN9eYMiyeDtejzGiCXdDr/KNpDfK7W5u+Cyh0rXa4PiMh8OJw//fYZDG0dLk7iI383oGReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZDOPkcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPc+6OTg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZDOPkcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPc+6OTg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED64C7A0103;
	Tue,  9 Sep 2025 11:27:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 09 Sep 2025 11:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757431676;
	 x=1757518076; bh=rvjijdykBoxbHQAmAlXQ3HXBFiaPfIVQNjXupvpTbcU=; b=
	WZDOPkcvJSYRa4nfamOL7iSdZ0s3joHWQ3SYLMPAfxZcdTC+TC1jxzhfEaN9BpXg
	naInq1g2zw1twQFavhnuNPDeRAi8z1ZWSCQ/RcwYlNcjZJVgNSPhm6+TfgBmBgrP
	icum2baeNyotN8X5oW9aTmgXbtzqh8AevEpjtWIuZVS3dApCWake2yoE+QH4OpL9
	eubksSPT1AYYeSvZAtmmfhQvPR+2OlDmil9c4AjYBuBmL7Jqr3FblTFMIOVl3h2c
	OVxKJUqTCBriEUACpdKhWrPoXjBzXn0U/7JPPM7gf/fmxFb6y1OkKbjWPyIoS3B3
	FpWR2NmEi4F2ulaYfPtClw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757431676; x=
	1757518076; bh=rvjijdykBoxbHQAmAlXQ3HXBFiaPfIVQNjXupvpTbcU=; b=l
	Pc+6OTgZ8kdwptD5DdMmyjg3EUnsz+Y4NwB65p7vHjjqCF4DLjoJaePzGAxJkYaK
	CMqhxLY60wHUyvtqseA+DLAadATiTGtU6r8hy0jK100b5BBVdZgIfw+PGjKOpxlG
	s6GnAhZxgQXG+/MeycjulkeEaisNSVXvS6G4K6+ZfU47dNNOnYnEOr09C9ZHg130
	6/t0b9AkVoYLh9Jjlor1XwT5KrvAwZuzK38iKnJ2aVns+MTDtuOKge/R4Bpa7ZLw
	hhT3iBLVUEAFVqG5/0EZcP+Cr55OEEq8vdtGSPhgsX8FXsax65LTbt6slhDaQSQm
	hCnzs+TxBZqMrghvWz1xw==
X-ME-Sender: <xms:e0fAaH7f1NU5afIY1XQLwlGvEQqyzjElkujdAzqtKtiMkTl3O0pCXw>
    <xme:e0fAaNjMefl1y8WIiI7IiBvaa5GySXFzuyXVUq2NLhkVQ2fOP6apyaPmFSGA2qs3z
    QHCD5vqy9r3ZTN1QA>
X-ME-Received: <xmr:e0fAaJkXmCSDlt5iog6WevGH9pH6ph6q_RCfglM84javHQm8LXwufLVeqGJToJb5FvLtJIS02HKwIwkdPocH9HHkPj6U1krkP1FdV3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrd
    hmvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholh
    hlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:e0fAaMuMrMN9s9HwYBPnU44-K4F-s4tIZwU3gjYQUSuVnOssCrla-g>
    <xmx:e0fAaPCzzd-a7b7k8X4bVDzQi_A4LXmDaU77QdZFP0C0mHJ3ZYnQHQ>
    <xmx:e0fAaBXF0C9AqYYLXf7_N6qKpnA0OIdhJjpcas3xPgI4wZbxtOpXMw>
    <xmx:e0fAaAEG17FSX6wXNK6DRFXOEkeI6Did1IKC9Ma_McwsgwTtd3NfOA>
    <xmx:fEfAaDoc5nuntRuhMTD-uH9sctpYYe-GUMhCbR09bXdx57EKaAXb686F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 11:27:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Christian Brabandt <cb@256bit.org>,
  Collin Funk <collin.funk1@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  Sam James
 <sam@gentoo.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
In-Reply-To: <EF337F13-64D2-4A17-BF7D-FE77E3064E35@gmail.com> (Ben Knoble's
	message of "Mon, 8 Sep 2025 20:49:45 -0400")
References: <xmqq8qipzhg3.fsf@gitster.g>
	<EF337F13-64D2-4A17-BF7D-FE77E3064E35@gmail.com>
Date: Tue, 09 Sep 2025 08:27:53 -0700
Message-ID: <xmqqfrcvve6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 8 sept. 2025 à 00:39, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿Ben Knoble <ben.knoble@gmail.com> writes:
>> 
>>>> +#[no_mangle]
>>>> +pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
>>>> +    let mut buf = *bufp;
>>>> +    let mut c = *buf;
>>>> +    let mut val = usize::from(c & 127);
>>>> +
>>>> +    buf = buf.add(1);
>>>> +
>>>> +    while (c & 128) != 0 {
>>>> +        val += 1;
>>>> +        if val == 0 || val.leading_zeros() < 7 {
>>>> +            return 0; // overflow
>>> 
>>> Hm. I thought overflows panic in debug builds, in which case
>>> checking afterwards is too late? Does unsafe change that?
>> 
>> This code is a very faithful conversion from C so if somebody does
>> not read Rust well, they can safely refer to the original in C.
>> 
>> In either variant, the leading zero's check asks "can we shift val
>> by 7 bits to the left?" _before_ it actually shifts val (and or'es
>> in the lower bits of c), so the "overflow" check is "if we processed
>> any more data we _would_ overflow, so we stop before overflowing".
>> 
>> IOW, the code _is_ avoiding the "too late" condition.
>
> Maybe I wasn’t clear, sorry: don’t we already have overflow if
> after val+=1 we also have val==0? In C with unsigned types AFAIK
> that’s the normal modular arithmetic, but I thought I recalled
> that such (unsigned) overflow panics in Rust in debug builds (not
> in release).
>
> So that’s my « checking afterwards » above.
>
> I’ll see if I can double-check my memory though. 

Ahh, you meant "can we safely add 1 to val here without
overflowing?"

You probably are correct.  If val in the last round had top 7 bits
all 0 and we shifted the lower 7 bits of 'c' in, and if that made
val all 1 bit, then in the modular arithmetic, we may get val==0
after adding 1 to it, but that may indeed be "overflow"ing.

Thanks.
