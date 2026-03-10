Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F140DFD5
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162695; cv=none; b=jUOquAIpDR3eVRnVP19iXhq5zz2FUGn/idIeV+aRfCWS5hxlcVpOCdrVuxFO/tv40ytlMM9RYVVZZVVMB4c4Y0MLAVh4TrKrXm9gRM/LnoC9LboML4vHf7pFZmM2W/W1U8AFwry2lTdOo6Vh2NGlzJ5xrILw+6B1w4Aukjariis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162695; c=relaxed/simple;
	bh=16J+RftFUxO1QfsaK48/dftyUdYzaBJmPqgycUe0o08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smrdfgJ/kxtpfFhqOMjB9GpiGsp2yM5uyZ/5jClcvzRWrhjZ6MxQx+Pd+X9hHRWDOLjmTAddeHgOgpjz+q58VNqRsv/PS5fTkMb5K5s8nrIypT+EVy2kohtX6QLf71bGnqez3Tt4f89kp8K54L+ggYkODV3JJI8klwisqwVD56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bmdv5+SY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCuZ309L; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bmdv5+SY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCuZ309L"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 01302EC05A6;
	Tue, 10 Mar 2026 13:11:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 10 Mar 2026 13:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773162693; x=1773249093; bh=3hCFqk4aDe
	egqfKMmeuPTTP1dEBfJChHR4VYFpBMnK0=; b=bmdv5+SYKamD0S71C6ub4YSqaq
	Uq+Y2dkB+5ePPIKUD5rjbj2pU6EcHLO4OZo6LT29SSxBxFRLU/JS+gaEo0ImC6MN
	XsjMAqcKG8mpKoDd21/RMZN+Zvi1vmARhoTf8gGNSd5wPwi/cpQJt29TE/RfLosg
	nraslIIurmVILTMjoKDtdZIvJrHz1FcoSz75td3d04GhU+YQlnHZEmvD9hGZ+qkn
	knUhm621RbfJxZrKLPJu4V8p5gs1HiQIIVvGgqPa9ShXS0ObWJHEvUMI0aXM/tIQ
	4TcXO1+DRbmrdSY2rcXEBzL7JV7OYkr3wjXHHFwz1fy7mj7DF7U38qCPPW4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773162693; x=1773249093; bh=3hCFqk4aDeegqfKMmeuPTTP1dEBfJChHR4V
	YFpBMnK0=; b=eCuZ309Lbff5VA6YDmd7JD2EALirvfpN/UtTw8MiC1FlmjLhkBi
	BxHSx1wLQ+P1z4xt5cBozVIceWob+iDOHqKUQcqor2ootWqDJP9Z1DmApoG6fZA+
	F4JZnP0Baziv/TePmVRYZBsK7/1kmhASWQmOI9ojGPRhSqFhnZfSnBPINa6ni+uQ
	cL4dcqHHWzn28ozezWqqRwBZt9gXurHP2gA2jblJUqvdPrJv9WFreKbqiTAxix4p
	wsxcqfJnboVLUA+Q1pd9SMKhjk6GX8hAMtJpPZKTG03bs4xiwqJRti6QWaZxxSEc
	KRm8ouZH5c86sJalmBg++tJH3MstYLls2WA==
X-ME-Sender: <xms:xVCwabbocIhrCtTtRFNozRSCF6hq1EvBhj_EpHhkCmThWi0mPm5xWQ>
    <xme:xVCwacqdvONGG1nIzYr9iDKrWjLSsRGhFdCrRqbAvDsDgSdulnFPGvfPLqnEjfPz1
    sPZDezkdkriqRQ0CXC4ujJalxTt8l6XbvgZ1sHxnrgNMsiaOQ3beI8>
X-ME-Received: <xmr:xVCwaQOHjvpuykatfmW2MX9qOLNrr-804nJz3pe_JrVb9RR6e8-UkCmsLB8ECepmeBbkod5uzs0p6q46kI32gyf6d1uwTcVCpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xVCwaXqcb1v_nKu5039Ji0p9U3ZkM5v2MXReHTwGmzarU7rh6aCGCg>
    <xmx:xVCwaVcQSInBxiVeXtt8m-6lhKFFpku08TDff8OpT6G-Kzv-k5Q-sQ>
    <xmx:xVCwadR-3gb0SbuVzkcLRliSjMc54kHARGx9vDl_lWp-NEcmxj5qeg>
    <xmx:xVCwaebT-An192DIXzfIpo64sQ8TzOnXb55onMO5Gb83HDN1wrgcgA>
    <xmx:xVCwaZ9-kUQCjrLVCOtlqBMp9n1VgohIsvP5YU_2KU93X4HI3WlP5KIF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:11:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,
  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 00/10] upload-pack: reduce lock contention when
 writing packfile data
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 14:24:56 +0100")
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
	<20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
Date: Tue, 10 Mar 2026 10:11:32 -0700
Message-ID: <xmqq1phrwqwr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v3:
>   - Fix handling of `iov_len` overflows in writev(3p) wrapper.
>   - Add another patch that causes us to flush out data instead of
>     sending a 0005 keepalive packet.
>   - Link to v2: https://lore.kernel.org/r/20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im

Except for the tail part of the proposed log message of [PATCH 03/10]
that I couldn't understand, all the differences since v2 looked
sensible to me.

Thanks.  Will replace.
