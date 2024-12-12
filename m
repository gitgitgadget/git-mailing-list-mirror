Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61369443
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965235; cv=none; b=ra2wL5WX42ZDSi9+6CEi2P62zbZuEj94RufazTjkCWL6bd2rhLnAHkoG9D+EgHvGxyv2XtrRJERCCuX/liww9QxxXvkNvUP7Oi8XM0xg4bj2a1Vvai4gG2GKR4RKYL1yhicDR66IfssvQf9GpKaKaDas4Qiv3VZDWo08TXknMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965235; c=relaxed/simple;
	bh=3rioPu0UR2hXtLY9jCIMNnhza3XWOV3tDryvcLlwshE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqgeZLh7vJQLf+sZpl8FrFajENsNLey+/6EqAQPv8if3ITtIABIDkdYlqVHtW6CL3REqPeUQ6uLqlE8Z0Nqz08IqQq6/7MxDdXjya5ERaxYhGHPv0JsFwDsDgToKzM7eiSnn3G+aM0DOIb/edZLbyagaV6k0cD8OlwFHcs1lDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qY/eRLOq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIJv47XL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qY/eRLOq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIJv47XL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74DC0254016F;
	Wed, 11 Dec 2024 20:00:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 11 Dec 2024 20:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733965232; x=1734051632; bh=l+wKbEi4fL
	6KBqgg51lpA+pReo5OEWBlw2gU+TZ8XGw=; b=qY/eRLOqVToMpWSoswFBT8TtBH
	0082u0wJl8M/1Y7hcG8dOP80lbw+DcmuqYWCsa/r1OzpCt1SKGsL65u02PEaxDlU
	pgdiQkxjxaIsGf3KehZpAw+DZboKfYSryJVXRy2ovEso+jRXW8/R9rtnlzUoY4w4
	AMGDcuAaECOUAwjToFLOVo94ZedPrPiCT0+2wj4obAz4OQdtILSvAPSdLi9LIyxM
	B7ICNAX/KpvVPjZE83r3ySEzKvoU1oLJDNB7BaT0LGF5Eg8rd+UUafvEUm2o3Yvw
	DBE6c5cdJOTbYJolb2ssQa7booBGqCV1CYubJZNCMpoKDNnyMF2hPnqpHYwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733965232; x=1734051632; bh=l+wKbEi4fL6KBqgg51lpA+pReo5OEWBlw2g
	U+TZ8XGw=; b=NIJv47XL1kscJP7v438oheAYUlE0xjC7nzUrDHb4OmlztsImMq/
	02TD2dRxgSWRIDg5xpKQ7CWDtiNmFUJpX5QW+aghhU05LJLXK5su5n4XCcbLMX9y
	Plxc9n9zInh0ZFMAtdncjtWGGUtPr9FVlnB7kgg5Cr7BOa7LrmTtJWjVGTI1vXHm
	jtlwcVx6vBTFOKWG3cURS8tr4z4IkLOXASpyHSka6lIwxI2gMUk6zadSllUsve1Z
	Fg7njpDEng3/w6Yzynz7+jOPMyb6ly35qLliYiDZ8QTtQOWpKrzwHcQHMUVEfDEw
	ouHH1LLBHthb9RscKCRRMjHG7PlvP+hRydQ==
X-ME-Sender: <xms:sDVaZ97xbPgJDkpKlkHC-rtDh0VuknEOSc4nMe0h_TOYnYvC4yt0dg>
    <xme:sDVaZ66LTmyC8tQZ52tIYHTSp7O--GmvO05xb3J3Kr7R6xapiN8ase9I2arIWhxax
    WNMGGJdWxvrAJYMNQ>
X-ME-Received: <xmr:sDVaZ0cluE7aFIicW7iOaoju0e6Eo6YgEjlh5FRPkNt9lhw_VsroZfRy7WQVxowoOwo3OlUflfhzWhmVhrln2rmlY0UOn1aOqeXRJ6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedugddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeetieejgfeiudehfffhteeggeegtddvfeeiiedu
    vdduteekteegfeetjeejgffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sDVaZ2IVPSpsOkyRVHdRrayJ32ImpmjKqsAIJwutlFLe_kQLEDJSmQ>
    <xmx:sDVaZxLr08tmhRamOt8idMsGBZJqGifa0srObq-XVAZp9MOTyQoVMA>
    <xmx:sDVaZ_ze6__AP_QXl-9EGkAOJlE2yuwmJm1okj9Y_LMoPlmqp7NTuw>
    <xmx:sDVaZ9LqsWyLSPZBCRPaDweKWo6zT0qdULU4_97oCOYo75PfKVQKSg>
    <xmx:sDVaZx2o-iCYceoEWgx2t7cPwhorGf9ydMFOjlhnkhJyUAiZy3Chmav_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 20:00:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>
Subject: Re: branch description as a note?
In-Reply-To: <D697HA5ZDN2K.1I643FREX8WKC@ferdinandy.com> (Bence Ferdinandy's
	message of "Wed, 11 Dec 2024 22:57:22 +0100")
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
	<xmqq4j3ai4it.fsf@gitster.g>
	<D697HA5ZDN2K.1I643FREX8WKC@ferdinandy.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Dec 2024 10:00:30 +0900
Message-ID: <xmqqseqthg0h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Not to a commit, but to a branch. I mean I know a branch is just a reference to
> a specific commit, but in this case the mapping would be from the branch's
> _name_ to the note object.

I am not really sure if you know what you said you know above.

Notes are designed to map object names to blobs (technically you can
point at a random other objects but "notes edit" and other UI would
only work with blobs).  A branch does not have its "object name",
because it is *not* an object.

What you are saying sounds like "I know a screwdriver is not a
chisel, but a screwdriver has a flat blade-like head, so I want to
use it as a chisel".

