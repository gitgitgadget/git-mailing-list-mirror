Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3491C862F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455473; cv=none; b=tMGoI1CcrL29EYrMlRn144crQMzaImXt95f37SqGBZ8TFaUT8XhdvG7b3ENMsjzUTC/M+YvE6uHQJIcoaj6HhPM91oUQwMDtuPEgAwh7mMRvWOGL7P/cUmociAZAoBrxrBKJB5lvbzEmWEL+R7st/MKecg/37Y7shZ6afXCKhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455473; c=relaxed/simple;
	bh=HNpIr+IjwuI3rIDlcypeOCvGaUtZlHzYdwY/6Vqb2RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVlL76NS/o6x+Nv0JWPRaYZOBw7Iu5SsYtu5nx8wlVwvslBl0tbqff01Idq+yH9plTUgQAcYUomLOQwrfEWXupeHP3uzmklpaDAH9irs1MLvEzQRDAJx6vL2GcANfzZiK2jYjYr6g8pnovDXe28uerITQvaSlmwVz0967TvXMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2Jx/wDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSbH8C7u; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2Jx/wDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSbH8C7u"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F41FEC0139;
	Tue,  7 Jul 2026 16:17:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 16:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783455471; x=1783541871; bh=1OIXAKOV3o
	rhgJSSm1Xee7Gr5amGBhl1Dq71lg1i8rE=; b=J2Jx/wDbDY5FhfWpVRlzqp2opL
	1r+ogJ56krAFdYCoudTRAQk3iMsSuLOC8eCOWwszShTs9ju59cM4RhTocUYRGcno
	5w+3mRcuZ9uZ6LhlSSAP4NQHAwrtuhJbAm6Ro+v4/khZiNZBYs+Izs/bRdRaspFm
	m5SENrjyTTzd3fS339wyEkRlLa6A6wPUXn0uCQX8kMWzkHw//uNg+pb6NWJVXB4r
	ic3yFP4vyL2E653pKAUPJlySrYyXTFUauS8WPh+CHYl3OlKXgInb8/7EwkW+3hiq
	fxfjNadYh/+OP0UYBWIPoFsO2U7QkLoxBwX19n6Qi1Oz0Fo3R89bWTmtBRFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783455471; x=1783541871; bh=1OIXAKOV3orhgJSSm1Xee7Gr5amGBhl1Dq7
	1lg1i8rE=; b=dSbH8C7ugT27v4M1t/UKRdr2tzjb1Meh+jrjAvwYpGFJoDvqa0A
	Zn+DqP1HbQegZoASzcw922GgkrzSmUDxyIk/VNH8OGbSiv0LxfVAOTuGq+ezl5ML
	MeAHZLbDAzilcYaKSC604zpkaid7hoMq2dng6XswmwaL5pR+wYL7VRCnviB/YVj2
	x/8Kgoi9LUNcRR8osHAEGFiFoa+FoJo16O2iefo00E18QMmu0M5vQiZvXSAK+PnR
	ssGDDruv1Qot02bC9ExTzbaFY6owbKxcCnpSlIujMmVT2s1Nws+Ix4XF5VGognZB
	MsMSUUpjOhqwAl81Ct+l+YH96HAP5UGbRQQ==
X-ME-Sender: <xms:715NalyzH87GD9YBm9gP7DUPpeMI4MluGOw3DxDo3rLiTyP4lW1ntA>
    <xme:715NasLsoHqJ-NnItieY1GGilXSLcy9KC_2Sv00MarO3Wh5mc9sAUFmPeciyKsUH8
    UYMB942lUcEtazEJ-tm3Z4yiZ661NhTpqtVAGgg-pewNSy1L8kF0A>
X-ME-Received: <xmr:715NanqtJe0CvBesTPqEaCUfCIr2AG_T0m4fLG4MJDSr_BOYTlQcgZIylwuGojXhl47AmRayLJ6f5_de2Ceelh1_fJR3OFPvuNtQw_0>
X-ME-Proxy-Cause: dmFkZTE7KAjQpYpAawehCAupxj1X3NooCJeUWDK4Lg02XLDA3pJB0BKriD1qnQ23aT7Miz
    un/YVR3/FosJg8MFiRqUuk7jgNPEzCTlHJvXkGT3UfA4W5E2h2v2+82bggFgbKmdIwXDk/
    /jiQ7DDfoBYsjlvKbUeFN26m1dCz4L15745O0JwMOG3sV2EVBBM1dNLSG/cT9TnY6E9Qub
    8R0P3K5LPgP3XPaoQWQ1Q6RPwEnamfFS95EL9Cpjef7rPWlf1s/aKQjv27gQLRmvwOaFAw
    rAux53M6Dx4Ryldlp/3LkbKRGnRAM7l2MoaTzv/Pr55Z7IOB9MRQms6Ol/Vp4LJVnyKmmW
    3vtEHJhCoXgp9DyqnJbLOH0f5t58ZCKRwJm5Ta8Kw2bDJqVSSwMdcjgR7tJ6f0oJkZGSoP
    xSuj1JsqGbP5NIuKQSO0APudcZgedfUpzBhwXiLil3mYG0Jx44cQAHxlJwwAHw/V0Gb50H
    7qcx2hommgDwSNkF4v14MwOFh6wBO0+AvQiFsWME9Pnn+ApKvSkqanGO8/KNG+rjwd55Cu
    1zp0gFVP0jqRlnpM+CStC8PjDfW4YwqzeYPPnfptcwW2IuuPERCcZ9MQ3iOFPwgccnJbBl
    rZDAa63jVpafZaWacK9dVniEWungNgb9p7hkbH6GLHUY3qPmFJnZ0frxLqgg
X-ME-Proxy: <xmx:715NajKj_xDw11m6V_y47OD0m4aJwQ4U38_RiK8aBY9j6ZfxGXyz7A>
    <xmx:715NakQlpezEBq_hMoT_q69YTtKymZlcA5QTq2rZXCsS0uimGXDidw>
    <xmx:715NaqtPeHikXuoVUWF6S1_QUgMsfhOMKgo6owu2U41m2a36UPhNKA>
    <xmx:715NatbVqnQyCio3cqeZGcYzjYUFkDeFcyj2TGZwTwxk-IDza3pESw>
    <xmx:715Nak7g5IeEV3JMENKDhgp7qk8wxTSAbp5YWyCtN3TzH10Vpk2SEeIY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 16:17:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/7] hash: use git_hash_init() consistently
In-Reply-To: <20260707201315.GC11780@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 16:13:15 -0400")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050141.GA1288294@coredump.intra.peff.net>
	<xmqq5x2q984j.fsf@gitster.g>
	<20260707201315.GC11780@coredump.intra.peff.net>
Date: Tue, 07 Jul 2026 13:17:49 -0700
Message-ID: <xmqqfr1u1rma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Jul 07, 2026 at 07:39:24AM -0700, Junio C Hamano wrote:
>
>> > diff --git a/object-file.c b/object-file.c
>> > index e3c68cfb66..f292683c2d 100644
>> > --- a/object-file.c
>> > +++ b/object-file.c
>> > ...
>> > -	algo->init_fn(c);
>> > -	if (compat && compat_c)
>> > -		compat->init_fn(compat_c);
>> > +	git_hash_init(c, algo);
>> > +	if (compat && compat_c) {
>> > +		git_hash_init(compat_c, compat);
>> > +	}
>> 
>> For example, it is a mystery how Coccinelle decided to add a pair of
>> braces around this single statement.  It should be obvious that the
>> corresponding single statement in the original did not need one.
>
> Yeah, I noticed that coccinelle was eager to add braces in a few cases,
> but I'm not sure why.
>
> I had actually removed them, but either I missed these two, or more
> likely I ended up re-applying the semantic patch a final time before
> committing (I did a lot of "reset --hard; make hash.cocci.patch && git
> apply hash.cocci.patch" while testing various refactors of the patch
> itself).
>
> I'll drop them in v2. Thanks for reading carefully.

Thanks.

If we run cocci twice, the second time it should be idempotent,
right?  So running it once, fixing these braces and then running it
again would not make us see the extra braces in the result, I guess.

