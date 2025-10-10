Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932B189BB0
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110178; cv=none; b=JlhXWP48i6jPb8mfNT5hjKuyZL8dNfQ6GCQUj2jkgW4pi0KE1PW1x9n/94Fhw/65T0O/xxW1Thfu7w4qDy3ZMM3uYt9AKa+/GojHmQIX03P0iCEtchyjkr6L1HO7sf0iprvDAsEJNDHR9ZA0wC7OQWsQYpFyxK1Kq13htdw/LQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110178; c=relaxed/simple;
	bh=H9MGhyXagZUxf/1Cya7Xg1TwxFtKSoAKr7EE1hAitTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CIjSdkdMUT7sC2Z9z9nFyvJTDsC8ZX/QTCglMsmKoM4kd124ZrRdz4I7trEq0IxQ3BTMe2cJrPbplkM+DwK3s0PpcSWZdqhGp88YXTnpqZeNTtmzntyIVF4h3YdUXTRN86NH3zTLCZmLR4US4aNsYfYnfq/fLMPwrONf0Cktdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dnEfa951; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrIIQvLE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dnEfa951";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrIIQvLE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D56711400111;
	Fri, 10 Oct 2025 11:29:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Oct 2025 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760110174; x=1760196574; bh=hLLAvIhtCF
	4GxBr8rc4I060tyWmRKOy1Pw3n4y6sDxg=; b=dnEfa951rUOaAVt5GJUJphkJXp
	qgg3IRiSss34liRvRlO04P+CCTumjBOJpM3LMNG2hszRCWxfRi3DqGV4t7jTvXWa
	p/sqUkbPtYFmpO6koqvQisTJKDGWYjqmZbaOsBiJRn/v17Ej8ptOMO2nJwvOGC0o
	SBuufufPwOV5xlum6ilY2Fi39hGDLv0vN8cDVo0cQawGXZ3Th02b1nMkRFuFPh/Q
	mSfcdt81gwtlF17fHgHJx+4QP6JfNp2PhXT9HOBTpfkhOqirBin9xK0a1pj6elFt
	V4lopKq9nq0HZj8Kg4kr4dbUkrMRISlSuxXCnSqIVG/qW72qPCkXVot6d/uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760110174; x=1760196574; bh=hLLAvIhtCF4GxBr8rc4I060tyWmRKOy1Pw3
	n4y6sDxg=; b=VrIIQvLEfOZHIPkygc1Mr/bySDP7bu/6bBIYloEWiFomwzn04d/
	H1a88HsDkBhpCMHifU6BY/l304AnQNpGXzuVJ89zFJZCu98kR2FyNYxBbCZ5t8I8
	oPA2EBJ+J2r0opEywFt3UBJKME+tP5AkZYq/ZTiE9Tibk4Z5NBdIdg3ijNHkMzZT
	u7sdJ7/qhK8jpkgcs735/u8Y24KIkcaagyWNB5LNzp/Y6ytlhrdut3+lOL82BjTg
	AXyTYO35Rbql0RtBCe2HrY/H+6TexQoEtvnxdHIRusoTenY3CSXE7oj2lYQHgF4S
	o+EU1BRsY+hJ45SwkVumsE5b3KFTg1UFo5A==
X-ME-Sender: <xms:XibpaAU8m5ypZ2184y47K_2eSNYO5qStThF3sM1ZvpyYDNPuyI3BWw>
    <xme:XibpaDoHCl810aFJrKspByulN96K9BoK_3KGOlDFhCPY9RhK9eNG9oQ2lSt6uhy8P
    CoN96_9493WAO4uxMXfhHxWzh5mXYukw9aTVLikKSFHSWf1-Tfdcg>
X-ME-Received: <xmr:XibpaKntxwKFcJaJUBrUZv-B4Tuu4jOGXKLCW3X1ORAXNbuU4A5pxfgfM_gUP80-WNEDLIrPYKr1HIGamwCU94dnmfLSQ7Hd7DzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:XibpaL0kW-lAvIee2AxWJbEsnZErRn4m6B9o_dLGMkA9CCGLq2TUVQ>
    <xmx:XibpaPQASysT6RkfPjoYsHp7Xl5JSx6b5OZPTAbM6iOcwzU54_9gXQ>
    <xmx:XibpaMydciuK79jM_OoCMufxAcdCerE8oU6wWruRorL-M2amOzvYQA>
    <xmx:XibpaHDIZVyOnYDkPxlB4_rsLkm9WV4I8iKAXH1-XeVBnrTKoMhkXw>
    <xmx:XibpaK5I362IwZ4HX8hLIQdbzuJzL5LpbYTFmDfwHHzXyuO7ZzQIRgV8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 11:29:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
In-Reply-To: <aOiYFPTNLL1Fgz5V@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Oct 2025 07:22:28 +0200")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	<20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
	<20251009053825.GB1614343@coredump.intra.peff.net>
	<aOdRsR-k77uTWJRb@pks.im>
	<20251009063956.GA1622884@coredump.intra.peff.net>
	<aOdjM8F6WvTEBIo_@pks.im>
	<20251010051242.GC1897715@coredump.intra.peff.net>
	<aOiYFPTNLL1Fgz5V@pks.im>
Date: Fri, 10 Oct 2025 08:29:32 -0700
Message-ID: <xmqq8qhibwrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So to move forward, how about we land this as-is and I promise to follow
> up with another series that:
>
>   - Renames `struct ref` as proposed.
>
>   - Introduces `struct reference` into more of our APIs?

Sorry, but I am not quite sure why we would want to do so.

Does "struct reference" sufficiently cover the things we want to do
with references and "struct ref" is not sufficient for that?

Comparing what 'struct ref' caters to its users and what 'struct
reference' offers to its users and declaring that one set of needs
is more generic to the 'reference API' than the other set risks
getting blinded by the area we happened to have been focusing on
recently.

Apparently, the above proposal is not claiming that what one wants
to do is a subset of what the other wants to do (if so, you'd rather
not be introducing a new "struct reference" but extending "struct
ref" to be usable for more things).

Or would we add more to it than what we see in this series, such
that it would no longer be "a subset" of needs various code paths
would have around the reference API?  If so, is the longer-term plan
to have callers that use "struct ref" to eventually use "struct
reference"?

If not, they are serving different subset of the problem space, and
they will continue to do so.  In that case, why wouldn't we rename
"struct reference" to something that is more focused on what it is
for?  In the context of this topic, would that be "reference found
during iteration" or something?
