Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839B53365
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964305; cv=none; b=aAabyiCPPHbj3FwnfvEtrKyr/znrjDoCcDMV8ws8jRVp5tyQA2FJannVWqmNDYibNpEB5epAR5PhPLzY2d/ZrsRp2Jht9NDUYJ+2Ck7awnTCz8zq5X67VealWHFtjpo00FiDQEKNtdlThhtzHI8oaQNIMRTHiBQMcAV12P1yTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964305; c=relaxed/simple;
	bh=WIusY/X/yy+0IK3sb8bpfYoFSAUFGSHWnLo0re8PimA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7JrbrPbMfTyaka4UVm0ePhpCe4Q42dVHu9qHnNarli7CoTvIS95+jsq8VvzB1NSuvZaSv7w9r4aXiPKH40oC74/qKrm4xKwVqQjbopFLyPHo2CzUCpCTExS8GaWLzr4+TRyHlVfztdKSZJ4aTE14Id+1xhFG6zCl+aksEg3jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=urYff0bR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaWGH20W; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="urYff0bR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaWGH20W"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E11711400E6;
	Tue,  3 Jun 2025 11:25:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 11:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748964302; x=1749050702; bh=pkoezC5V3z
	6tJXFOos98k2Zw582HEinGtHT6OWgy/H8=; b=urYff0bR5yMQ+SF3zda8H0Nugr
	EmjsHjxTbtA3KsFeBx23FqmpiMsRLjQ/IxWPjGLJ3OdecK4L4QrjoS0H4L2Kftuk
	SHNwCVEFZUnyok/TzQitVGIGo6HBvGnXHklKvUynCcaoNcXu5qbWGVgfsZAMteEg
	hpkP1uOM6IQvZZA9hpyQXzZa3P/vpcvFSivJbnZY4IIwG3VXMxHcK0B9bNiZJQQT
	WLnpvwMHgA75pq2QVHhH46SLDwGtVUX+2S/OnYafgmnWi7iTYI3z3MpVVRjvmmOF
	xSLizwrHmUbS1QOf1/L29Cltmkqyyo+6PBTkBqIrdjKMlNOis1deoDcUUSyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748964302; x=1749050702; bh=pkoezC5V3z6tJXFOos98k2Zw582HEinGtHT
	6OWgy/H8=; b=FaWGH20WtvUGRvXyqsNDCGoYoPYVN/YYOiL+3wyqPfW1pLBsAUA
	JVWCjREa8DjovuG3SFH7GDI1ws+JHHsBs1OaIQ2QSWBZHHVHOs+A0NoeHF/LvrsF
	XsG/g7kpny8x0EFkaS23fqLRydAdsK4tLzYLavvoCNveFrFFcdt++9a7QeSfJccF
	hlRZXKu4yhLFIFdTgiQTRzCtMzOG76cB0nMvqc1XPvJdRtYCOL+QJrjtzWWooQKw
	d2NHnJsw1elwyJY6gT6+FyZZvkn90AtkRCxGxjqbgTuKhxq6hYmSvKpxcqj6cRFB
	gDUti5ct3SyGhTAmFLlj71G4XsTltegpJfA==
X-ME-Sender: <xms:zRM_aO67176uUnzSOQQ0_MKKkQozea3IFSmfGpu-w6MrhEjnmq_ijQ>
    <xme:zRM_aH70EAADmIyHbwUo0vnhPWn_LTfnktsCTgNbKvspt2d7FKEnRnYAhmI92GZp-
    mliJwLYQGq_NDSZHQ>
X-ME-Received: <xmr:zRM_aNelaeJrsRowKfpGXqwNc57pMKLhDy4KlG0UDRvLkHxL3ZMkViJVP-yO1A1RORRbW-sXgen_557G0ZzC7raLuJocVxk9qCoe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeih
    rhhothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopegurg
    hsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvsh
    drphhluhhsrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zRM_aLIyEusgx7_QUfxhHIxF7KPfr4R92c1kHpxSm61ZViBS7Yt9xg>
    <xmx:zRM_aCJGp8RlAOOsZzrKi633nylkEs9wzsW3gvbbbK9K2dL5UPJXVQ>
    <xmx:zRM_aMwEeqicOTmKgstb1pJrv_uz3EMqil8q7iZXs1Y4VlL7f244jQ>
    <xmx:zRM_aGLk8CJwV4-vgsdnNMrM2s--Ko9FCjlDLu2LxORagbGK7S4huQ>
    <xmx:zhM_aCrDrrGzAzv1hUDcE_ezai9rd-XhY4nT3KH8V3IbZ6OSthQSDD7H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 11:25:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Yonatan Roth <yroth@paloaltonetworks.com>,  david
 asraf <dasraf9@gmail.com>,  Emily Shaffer <nasamuffin@google.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error
 message
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
	(Patrick Steinhardt's message of "Mon, 02 Jun 2025 09:17:36 +0200")
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
	<20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
Date: Tue, 03 Jun 2025 08:24:59 -0700
Message-ID: <xmqqmsaoq244.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Sometimes code wants to die in a situation where it already has written
> an error message. To use the same error code as `die()` we have to open
> code the code with a call to `exit(128)` in such cases, which is easy to
> get wrong and leaves magical numbers all over our codebase.
> ...
>  	if (!patch_format) {
>  		fprintf_ln(stderr, _("Patch format detection failed."));
> -		exit(128);
> +		die(NULL);

It is somewhat surprising that the compiler would not complain with
"Hey, a NULL string as printf format string???" given its decl.

NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));

As long as we are sure that compilers we care about are OK with
this, it is a very nice ergonomics enhancement.
