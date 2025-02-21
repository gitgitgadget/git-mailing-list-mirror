Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94E1F03F2
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162637; cv=none; b=eoDUXevwhF8/euOBe/w9jUOvmatCHicyk+TAWoF6Inw6TPQDSBKC9n3ADd3xMHwVJrBvKcinD2zfF7mAWVzhiDVVSgSifCK71+jf9Zcs5HxFBptse0pfo4VjAh+tBYlmHRhySFBDD4KJTb81s4vtX2vnTv4nWF8HzgemC4vKE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162637; c=relaxed/simple;
	bh=x15AnEd4f1mW2mbqO9Z2jErCaWXcJ4IVxVhoUX/dMiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhqomuqHdJg9plb1nVf6WZL0Yli3Y68aJGkRkHpOTgxb3Z6bgIj/2OjOksj/NFclUimbRT8tP+aj04jm1Wqs37MifYr0zAvNDSaKAGt/CsjlOzHImqnRopxnh3eK93KOi/eug0UaAUgDRehfQMGujc6nvzqGZPifMeedfO+mW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ubrKHisV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7/nOUpP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ubrKHisV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7/nOUpP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 1799B1140061;
	Fri, 21 Feb 2025 13:30:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 21 Feb 2025 13:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740162632; x=1740249032; bh=21oOU+slxN
	OhinDWtZF22vn1nvYtEypr+yjanfg870I=; b=ubrKHisVFHYr3NmHpxhiI2B2QB
	VDx9cGwLFwH3L/B29+jnsJF4frjSfx1Rz4AiP68tssYZCTZzMxW9fQOxi20guzTA
	/ParImp5NYcDyBdHCCzg+2qQ02HymI6EBNFSL2U4CKIFwejBj+VWFAcYbqSkSK47
	LN7ydQ3mC6R/kU8ypLxN2S5KnL+3Rq9G+ANG7GFFoOJ2j+qw9D7C+B0c/gTMLvH6
	SeQNSgiKj3hak3z51DqEe0TzUYvMM8gPWee3E6H2BbDsJpguJca/hfspmu27hZ++
	wU2kRMqKVGX3pPemVoK9kY8LO88seDqHA/d6DvB3z7v5sOmnj7BgNYf5+31g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740162632; x=1740249032; bh=21oOU+slxNOhinDWtZF22vn1nvYtEypr+yj
	anfg870I=; b=s7/nOUpPzPRLGRyQ6PZ7X7nKoWVJiDBFYuUmxi2QKfT3iBWdtQ/
	26NjzT9MTyG6UWwoDQ0YnWVYOMpJPNSkDsaQ/V59j30Y/V8srWs3yn14mhmQ4VwK
	Qlt7olbyAinWjhhfxt1QOQnzWWFWDOGcvM0d75EVisN4+uuyrPmgBeJr0rMHRULq
	fCn/Tt/XtgOIVEnpasGIvhiHV1MRWTaRDgCnMgmxao6zrCVz2BPv/dNLqC1XYy4r
	4WKkeZmmomjbzU2mAe2eGGJ7S7iSmyCy4FHuCQ59SDFC84qSrwM5UtsmqT9pEuv3
	I8qG8h4YyIWy47lVvZrgH2M6YDTpTi/Jo6g==
X-ME-Sender: <xms:SMa4ZzDXzbZxDEDvNg5-PNwtIVA5iwnuWAjxJnSaze1QuEBRAjUqBA>
    <xme:SMa4Z5jbLw2i7ghVPylUgWllf8MGfPGLCSAClqXVhfR20H7Yd_GS4AlmzVrDInGMi
    EjIE1CK7AizwMPDag>
X-ME-Received: <xmr:SMa4Z-lnK9QQ68MqL4jVGCPs0O209pKy5pLWVd-ODSQWvJjllwlKL9voSSw3mLuRyHXPaBVb4Yx2t-boNTGZpBVVg1IQH-lUW-ssimw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjfihilhhksehjfi
    hilhhkrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdgtohhupheskhhoohhrughi
    nhgrthgvshdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgu
    ghgvrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SMa4Z1wAhnN-uMiG1fvIWkprp_37CXHBN7X4R_e7sQiEnjQQGdB08A>
    <xmx:SMa4Z4STdO2D08D8uXVjRi6yBHQ0pnNPm0QDQZwL7hup4WTgETEx6Q>
    <xmx:SMa4Z4YDws2dIH35qhsNrSZX2NzH9PMe7ObNZyip8Zo8uy1nNCzwjg>
    <xmx:SMa4Z5R169B1OLyZ2qFOiMrfxMirYQ5ZncPZVZSHAwXVSQvIJ14vDg>
    <xmx:SMa4Z7EcGOOp5Q8pYIhGQ8tfPQ7RoM6N2_wUN7H8YwgPRqumRc5JUWAX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 13:30:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jakub Wilk <jwilk@jwilk.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Robert Coup <robert.coup@koordinates.com>,
  Christian Couder <chriscool@tuxfamily.org>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <20250221152644.o5ni6vn6rncvmaq6@jwilk.net> (Jakub Wilk's message
	of "Fri, 21 Feb 2025 16:26:44 +0100")
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
	<20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
	<20250221152644.o5ni6vn6rncvmaq6@jwilk.net>
Date: Fri, 21 Feb 2025 10:30:30 -0800
Message-ID: <xmqqmsef9mm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Wilk <jwilk@jwilk.net> writes:

> * Patrick Steinhardt <ps@pks.im>, 2025-01-22 12:31:
>>+As our documentation mentions, these directories are not to be found in modern
>>+repositories at all and most users aren't even aware of these mechanisms. They
>
> This isn't accurate. The "branches/" directory used to be part of the
> default template until very recently, so it's found all over the place
> (although most likely empty).
>
> I'd say: "... these directories are unlikely to be used in modern
> repositories and ..."

That's a very careful reading.  Thanks for pointing out the
distinction between being found and being used.
