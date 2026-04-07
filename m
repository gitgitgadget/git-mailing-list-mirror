Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D162F1FF4
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573364; cv=none; b=sTMBa+eqdVy/AWU1XAAtvSfQpa5mAUDVt4CubPXb4T3Ak6SBMXz1hSGmXNQU/p/i5bPDrp0fVPxWjKD1Yo1P3DNIiVQ0arFT4j8bTt70fRWRmB3kEMmIa3hxbrb6xB7mKb65szbXC4lzX8tm/ARw+3y9fUYHJpqriKxq7Ho4BXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573364; c=relaxed/simple;
	bh=4G8uxlAdcpOO8PMwLw6eAJ5OvVovoxT9UGs+wHOJRao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAxbsYhQuBFZSuSYZr60goPk4x0liKziiRjzbVk0vGp5BBbUGc5nAeeKYgmquvjv4GaGtETEHtbPLFQBcWDC7t5ginRJavJxwHnKIhlHcVax6gSc14KE291RjhExgdH40tSwOXST6lZxsvVsSfhf0CnMi3VK6+eRuBX773dRHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ys4HxWf7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NGAaEunV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ys4HxWf7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NGAaEunV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AC37DEC03FD;
	Tue,  7 Apr 2026 10:49:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 10:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775573362; x=1775659762; bh=tZgJgVx7mp
	CyqGEb3MXAgIRvREe2nA5QsbxcNAizWbc=; b=ys4HxWf7uwI6lNQ76zhVaU0nRT
	pTVfBpvPlRa64BcflO/B//h3oW96f/rg3WYoATEzXvBAJowutfL1xfdiTbk89jsm
	BSUVKihygY8pnWg0YoNJRDE6YI6yxIwu770htZ4nkUb759ldkGFdVBWdBVNSHhva
	knNRdWXLAPD36eZln43fkpPrAK3c068V6Gd5OT5PLFgqA0Gp3mB5nwPzD4F8zNgq
	+3LPl5UzmsHSAC5gLS6wNInPjHccLLqxqM4lDOopInG8ccGC3Pk9FSKArEM+KARX
	TrDHDUdMzz4cs3PHPOJJ299WLSNruqma9MYa8qToK7snTj7KM+VfFFdL9cxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775573362; x=1775659762; bh=tZgJgVx7mpCyqGEb3MXAgIRvREe2nA5Qsbx
	cNAizWbc=; b=NGAaEunVYSkPADfpos7AVOil6k4IXMFId7UMNpBz2tpOW1KXxZe
	De8G1s0LSbQGDtyVaUaXDqRHqynra3E9qBMqlww3T8uusufri65VzJq4vy2CSCyi
	3ZOTCBYqGWt0sjNcmjk0KMCQnnAv44DVJ/cly9ieUWB5hlRDNVjXHjeC6lnvidhW
	2Ge41+i86xuBOVBWS5R4H52m/6MuWhQI26Fdp/54drTsYj7Dm0L7p4GelXPqpw7C
	FVnlIKrmBxme2j/grHQXpOg21oe7lmxAoUdiOtnytPx7gd/jFjoSwdTuXH25dl33
	u52WjHZSLeLMn6rjg9pUBIRIOxIbiWjFhTw==
X-ME-Sender: <xms:chnVaaRmL2EslXYD7LzY9Pg2T0qPnBkR0vP0w87BSqm4XtWgrUDlfg>
    <xme:chnVae0G_1xums5ZcDuZfK-9URqluFJb3Mzky33JPVtEBhT_zMlSG76Nq1y-zdj8j
    oO8WXlmkWlXly05D-9JRmlwa1vGVHqq_1H5gdah7_pl-25tD3IJLg>
X-ME-Received: <xmr:chnVaeCe1zSMUa82nhCsnJcAdz6wy4Uldi1xsaf6Exo-s9m5cRlgO7OBzKZNnNdwQ_XiUzOr4ZBvUDi585r_6SloPvutT1a0TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:chnVaSgD9WMeT5numUqTFMkimrMHMFPB1ApSBRqtSUZf9rv-XEkipA>
    <xmx:chnVaYPWRnEn5udCGQkhVX21E6tfTVMcGcLG8BI1CbbVv5mBIyDJjg>
    <xmx:chnVaa8FXxtNK2_ALZVntmPIMEsXvsRpMjGJWaBcAqKChVTMoqxkqQ>
    <xmx:chnVaRf2p4guMAMMF5hrR2QYhXGvzsIkuNOIXXe_kof9R62pT06vsw>
    <xmx:chnVadzlv0sLsG_vgOkC1fo7sMmfwNQyCNTnwABa2mpCdy5-6J_O_ehF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 10:49:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/10] promisor-remote: try accepted remotes before
 others in get_direct()
In-Reply-To: <CAP8UFD1iT12ap7_A7Hq1KVPia_mPwqXN7W8Q0atMo0hz3qn8FA@mail.gmail.com>
	(Christian Couder's message of "Tue, 7 Apr 2026 14:05:53 +0200")
References: <20260402070613.85934-1-christian.couder@gmail.com>
	<20260402070613.85934-2-christian.couder@gmail.com>
	<ac4evWK9k69LIV91@pks.im>
	<CAP8UFD1iT12ap7_A7Hq1KVPia_mPwqXN7W8Q0atMo0hz3qn8FA@mail.gmail.com>
Date: Tue, 07 Apr 2026 07:49:20 -0700
Message-ID: <xmqq8qay7rm7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It could be a microproject idea to clean things like this in all the
> test scripts.

Let's not deliberately add extra technical debt.  Preparatory
clean-up is very good.  Even without it, not adding known to be bad
invocation is better than "following the pattern".

Microproject materials are not free, as it still requires review and
application costs.

Thanks.
