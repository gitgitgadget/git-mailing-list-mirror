Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B643915C3
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101673; cv=none; b=sgbjznPjbwleFAxP3YnMPbbwtcsPuOvxHsX94DSXrwEkV5RBcV/DctaN6u0KITLZ1e/nbidSuNJauXeSWZPXuJzLurLFbgJkp6XAJdDIwq5msQMTZF2b8/30MCwmJ5HDbKlNDtj3wvM/HgyCxldAKvSLtFL6kzN6fyS9P0puBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101673; c=relaxed/simple;
	bh=rc12O7Ey1F9fQxr7ejnvWw3NLqmv/YBzPk0ULOuviHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJrrV7nGgp31T4ktaDOdo1uvtoFzYZLPUySXsFUV+ZPTbqR4SC9KzstBcD8tIrZSeIGOEUjfnNUkx+cDZTV6T9qYUpRyINRgJpFmuVxKf5XMtVxsYhsa4oDjgVYnfb/hHNC849ldP0BrJ8YPEpx0Tdh40j9IOE3vqiY6i0nqsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fqisGS1Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+idT+za; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqisGS1Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+idT+za"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 10A811400102;
	Thu, 22 Jan 2026 12:07:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 22 Jan 2026 12:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769101662; x=1769188062; bh=POGHdV8iRh
	zcpyWpdNohjb0QSMmujEwsBMBSSnonlQE=; b=fqisGS1Zl8rzNGs0cYwK27hvK8
	sXaKmSuPkvf/d23e/A4psmNtoQFBLwRIpTgtzJD1Z4U4onbJkG5GBFKOQI42PzVq
	hfb3RcQlFSfafMDv3hrTZlQR+1gm9b+fs7LLYRUWGU9gNGYM28tVRGsRqkdnFNbG
	QiKzrhc9zEta8UWIDN6hy/5ixGUYj7xMzpeVPD6MHGca/1x8/NQ9plmasdWCdRxJ
	o8YdyVNP4J0fuiUWS4s/4qy7BIbz6dnvhXetemCEmoQcVAFG/nJ31YKdcXIYdSTi
	H2bfOKiSmfNJCJfAA37Yz86ldFsC7eWfdaLOEQpL52RToCeQKNDdOvSAP7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769101662; x=1769188062; bh=POGHdV8iRhzcpyWpdNohjb0QSMmujEwsBMB
	SSnonlQE=; b=E+idT+zaSdY/Cjm2EJAFXD8A3ybXjF6h1BBJ6XR+h1dkyD9Rvqp
	xouZjbRgv1vuMoYt/zSqYmbT9oDIIhlysISdWrks+6IOwhSMIluEBwE5/CFBxKSe
	d0imVkFKyn3hAwVWR/QPIdIb3X9mTJ3IAsK0tZYQ42lRk7hqUOKwISls39hfZ7+F
	3OpzLGMyvyGy5TnTZG26MByeoil7P7j81X+fnV4UPGOTnjZ86gEEEmJQH/VamPwS
	9dJvwRKPG2Oqo8tk+OgJqXoOmdcG+J12VFZKDJP8GdEN9MF/bXp2TPuxfFLw1I6e
	yUAhQohAAsqKvUI/39okaXfOXd5e1y2hM5A==
X-ME-Sender: <xms:XVlyaVl2WnoZfcIByy8bacBtOK5b13E4ZLOzJO8jIOnyhEBm7Qc-Ug>
    <xme:XVlyaTFesqUWtsaKMg5KjAT4WDaoIFcaZBjSBsKqFCg8FpAEiYYsh9S010_2-0ocv
    GMJaum0DHG34hvR_wRo7xgdIXgtT0OSqycK6B2AvIMXTnOyi1a6EA>
X-ME-Received: <xmr:XVlyad78AQyXHmtvrHLyqz7hFTlxGpikot_7OXFH4K7Jb7u-WG0VGPuE87LVD0z6-L6Jvhv9HludE57rW03-w_gDsU_KTayRoenyMjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XVlyabmMXxX6ChAZwdk_OB2-rNdDSkvz2B2Hxe4yo2fZkycJMu0AlA>
    <xmx:XVlyaSr1XWIbkgLkcHi6UZqGfl9GJXVTM1Ud8EtHVtydw3IjdsQszA>
    <xmx:XVlyaat-Sg0OHvVWLZYZDk7HOGMyomnCawCYYuO_gys8oVeQTNr8Qg>
    <xmx:XVlyaXHsAxqv2YpSOJFw1mEM8vJO4-bkqnSQTDAdBhE4WFtoIbLdmw>
    <xmx:Xllyabot5fYIcvCgPAsSVAQL-7hdCn1HC05l3jx12dYzIhGe5M_vObBc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 12:07:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>,  "'Patrick Steinhardt'" <ps@pks.im>,
  <git@vger.kernel.org>,  "'Jeff King'" <peff@peff.net>,  "'Elijah Newren'"
 <newren@gmail.com>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
In-Reply-To: <014c01dc8b46$7a2997b0$6e7cc710$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 21 Jan 2026 21:26:06
	-0500")
References: <cover.1765053054.git.me@ttaylorr.com>
	<cover.1768420450.git.me@ttaylorr.com>
	<c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
	<xmqqpl7beugj.fsf@gitster.g> <aWgSzI30k0BZfZ4Q@nand.local>
	<aWgwn2rk/qw+fRoA@nand.local> <aXCTkVpjJkTabx_0@pks.im>
	<aXFni2tE7vn1dKFp@nand.local>
	<014c01dc8b46$7a2997b0$6e7cc710$@nexbridge.com>
Date: Thu, 22 Jan 2026 09:07:40 -0800
Message-ID: <xmqq4iodpodf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

>>> This would let the caller handle the failure and is thus quite
>>> flexible, which results in the following code:
>>>
>>> 	if (!u64_mult(expected_size, (uint64_t)p->pack_size, &expected_size))
>>> 		die(_("overflow during fixed-point multiply (%"PRIu64" "
>>> 		      "* %"PRIu64")"), expected_size, (uint64_t)p->pack_size);
>>
>>It does read quite cleanly, so I think I'm convinced.
>
> Are all of these changes endian-safe?

I do not think of any endian-ness issue around here; these "mult"
helpers are checking if the result would overflow using regular
division, without doing any funny byte-shuffling ourselves.
<git-compat-util.h> has definitions of unsigned_mult_overflows(),
and maximum_unsigned_value_of_type(), if you are curious.

