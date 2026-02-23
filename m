Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F11C84B8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883147; cv=none; b=S9yKrX8GsYIO/sBJEbYsQ22/g+tuYyhskU/OerlYd9PG74roH5PBdJdaL8bRC1R4q3Zzp3K31Ai3+7Fl0662HA/KeMIt5SaXCCTJItAw/c9tLKXj1FMobwSa6dJCEa9iNjmryKxOec664EhtCP7389zJ5rwzNKqa+9zIjNCiPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883147; c=relaxed/simple;
	bh=vNfVIQ0/DGIe4sJT8FXgPL9g3hFKOFO5PBEOurEapC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUbaeHeGyQaF1Ic7K3QNGDKk9Ox9ITXAJFJDBgxsjMJfj3btqYYfYuH5uW+d/gSn+qNxa04Hh8lswKN3XK5ZxD0+ZiiWpEmmOPZkabtwliYsI+sHdur/72inlKRPWthstHKhMuyAJmAFVconhymVp8lYv9E1XB7I/AwinsNVa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vObq0ByL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9VGhL/b; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vObq0ByL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9VGhL/b"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF86514001B4;
	Mon, 23 Feb 2026 16:45:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 16:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771883144;
	 x=1771969544; bh=ZAREOBF6T/pxsAcCkforKs2xAoXAlfV3puMpaIivsQA=; b=
	vObq0ByLSP8L2Op6kim/OZugPs6agXsiZUl+TA24amp/n7oChemwaGfK7oD3Jy4Z
	5eppRMHpVeOCai11G2Ku9G4lIQHdFt0ddxJXmYJ7AbJU7VZKDiyZtNWhIjlZpFX2
	OIZX25/iztTuP4hPkf5wkQwl/Aux+XYUnU/NDyKDIBoeBVvC2GKyx7RUyOcKG2FS
	nWbBdKzImLbxrnpBuOBXVtIOuyhrp7SqmZ7HjHNWyYoVx72if41Tbg+Sz0nmli9d
	I6IbwFMivqHvGT3wTuHiVIgLohGDBps3Srtldu/DhW6gE/Ein6HhPaePSb8njUjI
	p4m07TQ1QkJYx0E+8/GDTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771883144; x=
	1771969544; bh=ZAREOBF6T/pxsAcCkforKs2xAoXAlfV3puMpaIivsQA=; b=Y
	9VGhL/bxef0e2EFWBP9bUpDQHTzUf1f4XYzhfyKClHqeu0RN8uCrn6nb0OiUnCk2
	zA1645N2+LjZKLA/tYespsR93rqqoV53DgUFlCC2UaWl4fBClPt07i5RZWNz7qC1
	iktveE9phxjLTwUUeSf+kN5ztHV2fVHbnY5Zi/GQHaiMdqLZv26VtuF/4Uembg/j
	fHzVccAz3eEZk9DanlEAxgz8Bolj9YWkv92GHpzH8xckWkQUOCTYgkwXoPzGA+/Y
	giHOqpokJzDnjVEVFRmK/hypHOb/jcgW9Neg9PiC0dqwMZhKAW2EfP+etTHIjlTh
	AvA6g5tT5VnyhaGPsLvTA==
X-ME-Sender: <xms:iMqcacmq16xqZY6rQt2wkMW7MKUAuWym7WbMwbdHXBa6n6cDgFG6_g>
    <xme:iMqcaS0Ov31lXq0mPAWdrWg70gIAx18JyyeT6RHKPZbJhYxn4MBpvShCTl8vTZJEF
    grbSkGnkQZq5wytOzFXaxtyGVg9SPTFPqCKVi9RXG0HKEKEozocGBo>
X-ME-Received: <xmr:iMqcafqEe7ZoZCRnmetdgjUjMTnVlaAJFk6uKhqHCprcxg2Ro37e1QNk0lCFm5UzlZf8QlW4r-gtF2xlu_cJkT7xmOrcwhxD2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iMqcaXdIqOcuTCoZhLsEtWBwnVwXGi4MJqDyxXzMrw5q8_pHUTlS8w>
    <xmx:iMqcaWr6toC7L7Or6D4pbaKuCtKTbhmSJ0YpRQirBTe4GAp9HLaONQ>
    <xmx:iMqcaQEpMkd0L4VF8A2q1vRt5Wp1fOW4071dRy8EF8va_HBgXfFGfQ>
    <xmx:iMqcaetuCZREhJOkeCg28z3SMkiiewvKKLJmmWW5g5u7tv3ptthKCQ>
    <xmx:iMqcaYnxM8c6GwzJUNw7C6V2MrP5p8glt73oU3BLJKecJ1N6q58m4y30>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 16:45:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Jeff King" <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2026, #08)
In-Reply-To: <aeb2f6ac-0a1a-428e-97b4-4329452d464b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 23 Feb 2026 16:37:09 +0100")
References: <xmqqbjhfpk6c.fsf@gitster.g>
	<aeb2f6ac-0a1a-428e-97b4-4329452d464b@app.fastmail.com>
Date: Mon, 23 Feb 2026 13:45:43 -0800
Message-ID: <xmqqo6lfkubc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Feb 23, 2026, at 16:13, Junio C Hamano wrote:
>> * kh/format-patch-noprefix-is-boolean (2026-02-18) 2 commits
>>  - doc: diff-options.adoc: show format.noprefix for format-patch
>>  - format-patch: make format.noprefix a boolean
>>
>>  The configuration variable format.noprefix did not behave as a
>>  proper boolean variable, which has now been fixed and documented.
>>
>>  Will merge to 'next'?
>>  cf. <xmqqy0ko626g.fsf@gitster.g>
>>  source: <CV_format.noprefix_boolean.39c@msgid.xyz>
>
> I’ll make a new version.

Noted. Thanks.
