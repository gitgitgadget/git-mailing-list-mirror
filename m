Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4331C2BD
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330089; cv=none; b=Q1JlyyHJWK+OCll9Tn6YnBwXsj0mNsrUy5boYR3zipcrj/27Ir8V3W2YIhA+/+npbEwMr5JPSMQ+i4XenNEELi/bz9FpYe0tGs7tQTrHLy2xVqZUdiHQYpKDrcQzoVzOslaMBapte/rOOluZod1InP9wxIuexQ02la1lQlm9Drc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330089; c=relaxed/simple;
	bh=+2/prvQMnPREr+vmIEKhU+D2nVCzn0xnwVIm/Pc9g7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdWiXiQV/m4h/6r6XN7WlH6ljqu7xegu9p74NHiZzXr7Ta48vtQ6+kCUM/xiHR5S9AOFXkylFB7K+OmpKpS1PrtHl8j3Pmfp7s4+tz7RAVnUfXPjMgzYbjV4gBEH2/PDw0m58Ywjzrarh2/CGpbfm4V7Pr9iRoakHU6IXmbkiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ur0+4Dr3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jG9T/vZS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ur0+4Dr3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jG9T/vZS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9391F114013B;
	Fri, 27 Dec 2024 15:08:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Dec 2024 15:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735330085; x=1735416485; bh=TY1g+kv33n
	9J79FBvZ78YNn1/51/e6nJE7aTU4OQqDk=; b=Ur0+4Dr37f0ulR/xGCAs8djQlx
	sSrkHzzvPTPDzJc7DgZ6QKy5fB8yQxOWAKCe1n0znA4SIP1Nsas19D+w6Mp5lCNP
	wDoigtywQyx4khbdgQ0mIIlexTvc3bZAmGdahZClPimVkM14a3+t6AhnM6VGK/cR
	kkN8+i3jD5W2hhnVJu54gZWxm0iL586zLTvbanpxzZj44jG1I7h1FLU/S8zFiMWP
	PAbIsbHFfw7qbHFNflshwbGZT1iuY5y2C1qIrwhofIeFOs5vjy2o0zlCg5G0N6IS
	eI7L8phLVzP16nw+jfS7UhzNcOsWIsx4cC4tLQWcyRGjrNVwG7Y6mgPu84xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735330085; x=1735416485; bh=TY1g+kv33n9J79FBvZ78YNn1/51/e6nJE7a
	TU4OQqDk=; b=jG9T/vZSQi3r20E0iNG6BXfrDi+XZiQv4ZI5o+9kgsutRX/L9PK
	6QAx9ykxm84jfTu1dR20qO2dtKOMZg5BWh8+z4dgMRNtrwwIhVykuzVsmYLnRTNa
	9swWfTidtegi9Q3G8AcfVBMnyn4Tu3Ou8/sKDW22qowWRLKrzaPlhDixwrS/anHu
	ICFNaViYioYAcPdmKJTLvj/vLwy/lJUXZpFYLIqrXvXOmsOLCBKrSzsMkhCn5f2G
	tqNTW4hk+/EPezG6EzyJt9R/CyGDZVyiIexw2Qq6zEgCcWiHdOk866Fuanp27Z0e
	oJ+F3HQYg3wQN2tW8Kfji/q1owDmAxzdkpw==
X-ME-Sender: <xms:JQlvZ3vn3Glq-z5U-jQfSsUAyYj05ghvrL35yud2fMM2MZVNw6scGw>
    <xme:JQlvZ4ctYeJCWaa_VLX4z1St4CwZOJM3icyuVe5mTQEadAOmThHIcEADmE_bW_GU5
    47LVCLhU-WpnTorBw>
X-ME-Received: <xmr:JQlvZ6wEHLRSNATHIMOJz4MvkU21WFKnJhktEIKwdjXnD5bq0dbm8bH7GiQEjxLq_qFvLDDT14m7isyMi3hb-63jDdScCM7LmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeuffehueeukeeifeejuedugfejffehudef
    tdejhfevleeuhfdvtdeljeegueehgfenucffohhmrghinhepshhhrghllhhofidrtgifne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JQlvZ2Pxk5c8rLMm9PuklADf3Mu4QP5qMFfY_Wr3RKH3CD77O8abPQ>
    <xmx:JQlvZ399ZBJ-PU3FcHuX9PrSGWh_S20Hvi0YZiSzajLsZEcbgey2iA>
    <xmx:JQlvZ2UlhHG3v-VJGpTlTJWm9G0f_Qf7WI_CIXBCrfVVSUKFBTdruA>
    <xmx:JQlvZ4c7lpC6tZmW9vf_wBforWe_3f-g5fBOIBC4PpYzw6OV634ehg>
    <xmx:JQlvZzYUy7oDNcODTJ1n50vPEo5TO7aNKM2M2tAr9FCu3zTsOE3JVWcH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 15:08:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
In-Reply-To: <xmqqbjwwucvy.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	27 Dec 2024 11:47:13 -0800")
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
	<xmqqbjwwucvy.fsf@gitster.g>
Date: Fri, 27 Dec 2024 12:08:03 -0800
Message-ID: <xmqq7c7kubx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Error: shallow.c:537:32: comparison of integer expressions of different signedness:
> 'unsigned int' and 'int' [-Werror=sign-compare]
>
>     537 |  if (!info->pool_count || size > info->end - info->free) {
>
> I didn't dig deeper than this.

What we want to express seems to be:

    If the region between "end" and "free" is smaller than the
    required "size" then we are in trouble.

which can be said more naturally with

    If the region of size "size" starting at "free" pointer overruns the
    "end" pointer, we are in trouble.

So perhaps something like this would help?  We are no longer making
a comparison between two integers with this rewrite.

 shallow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/shallow.c w/shallow.c
index b8fcfbef0f..b54244ffa9 100644
--- c/shallow.c
+++ w/shallow.c
@@ -534,7 +534,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	unsigned nr = DIV_ROUND_UP(info->nr_bits, 32);
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
-	if (!info->pool_count || size > info->end - info->free) {
+	if (!info->pool_count || info->end < info->free + size) {
 		if (size > POOL_SIZE)
 			BUG("pool size too small for %d in paint_alloc()",
 			    size);
