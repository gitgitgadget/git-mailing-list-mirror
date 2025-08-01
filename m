Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C123AD
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066645; cv=none; b=Nebz7F3esSXYx76vtYqpFovUVJ1B5N2enJE6Ss9G1p/Oa8TMbSVQ3bM4pok1QOU2kkUYNHcuRQpT63us9Zk6UmvQOgv23XaYZv7wUCusRgSQiX4IJGFjEE4Y35K9TMGGKq6emoKwTJbFDx1lJ3UyqysVHsjMCEZ+4kreVop8BMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066645; c=relaxed/simple;
	bh=EALVoWJnhcOhh6/FEIaBOvuLawFAPOM/AlO8s49Selw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5bz42c0NaNCehGbUePBKY6fH+XKKaIFtf3Pv5NrAJTO/5Y+MxByBV4qnulOnKIb5nPzn/KDcpV4+HnpVvPGQOD75rRBvAmhbx4UWyABStwWT68cdpZ6sDbcPgyb2CNgjbzTdcOUWEpdIPh1m8pRSfh42wCsvUxGP5e3Acx7nak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QSamVEpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDsJXt1W; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QSamVEpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDsJXt1W"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 14CB47A015A;
	Fri,  1 Aug 2025 12:44:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754066641; x=1754153041; bh=wPzd5XtZY+
	sIQ4SN5Z38WGpd8746r56V88g5eD1DsFk=; b=QSamVEprga/gRwDuywr1hJ0dQs
	A4wTEjIVZQM+8z6sDtobYQLWGDyd45Hw2xaPDjWR6m03dwQ2tRCyXE9ePsJRjc0i
	ZJ2amTQ34JYnnjMr9BkncS4KErCCIdz5Pk6mLBfOiEGCv3EUccMfzx+NMR/CkxOH
	NW0r+yvTI7vZsz225k9rxYcPa0YlmG/zQOvLPS8ICKWOQoERJg/Ovsv32fwfbBpj
	X+VHB0EhKv0oT6irkwUqyIc6UjWbYE/B16CcYhwK/e8kQekg418cIXoNojNt3T6x
	UdcBift6xIyujWlKuO5E0UAJOV8Ki2w8ABAIg3rDOg4j48/jTB8SDXVL/1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754066641; x=1754153041; bh=wPzd5XtZY+sIQ4SN5Z38WGpd8746r56V88g
	5eD1DsFk=; b=EDsJXt1WhTqTMpBNNS4+DRlPYjYRmPyLIzb0jIJB8M+IkSveJ4e
	F44BnzjQUlBcpP6rCj/+GcWO9YtHiiIV5LlHzdeCVy+XTTCsbhp4JnrQV48Bas3V
	6LRln5x1c+y6Q4d3vDXLaTlr8pLYIrO1ay0oO6Bof1QzZvOERKA/OJmet9RMHQwA
	A/cWBupNTDMjs9Xqr7bhnDENw+Vc1elPTP4QJOqltLlYsDVLChsVdJsnwETcxQXt
	Ia+pPaXhnEhiJElhhLq6/q574JdA9TLnxviKLumSpu0S7adtu4L72kJo/wKruuaU
	q6CqdZf/nFMhR20rgY0hrmX35Z/44IFrQ4Q==
X-ME-Sender: <xms:0e6MaOxfNaC3evMAut35eU4vRsOKL4R9Zs86JoTPSddyQrIyyJyFvg>
    <xme:0e6MaH27uyvzSvrE7sZrujNUHUjTafMBTWXrQl8g4AhXGeTdpM9m-y2jpBOKe50E2
    X0k1Q6E334FxjihFg>
X-ME-Received: <xmr:0e6MaGyQTBUYqH-KUEO-xlBXmtvpriD4Rk4-0bxHIPLSKbY366SKQjaMbFx5qsPQAUZ1z0y6XD0l4_-_9oRmtpjcOMa9jDkpWtk2Ddk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:0e6MaGFan-7ATvUa6OqaAEOeWyH8hsNVMBcD3XXUY2rf6xNtIy7OUA>
    <xmx:0e6MaBYBxoZR75TeoYZjiBkRW70M-iOyrmgdbjKVA0B8jYhCBFB4nw>
    <xmx:0e6MaACWas_ypcdz6P4jOEegrS3eyz-eswE0A3gxyogrMkvo2k9KPg>
    <xmx:0e6MaBnZjumHR0ahgUqmpXzU_zZmWMP0us3Tlhs5emYTJmu5ENpMdw>
    <xmx:0e6MaNP007r_exBDFC8Ei-hCTrh7yMOJePdG-uyJ5v5pBvuTIAD3FGVM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 12:44:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/6] builtin/remote: rework how remote refs get renamed
In-Reply-To: <aIxJrvqLvEl8qM7V@pks.im> (Patrick Steinhardt's message of "Fri,
	1 Aug 2025 06:59:26 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
	<xmqqcy9gqiht.fsf@gitster.g> <aIxJrvqLvEl8qM7V@pks.im>
Date: Fri, 01 Aug 2025 09:43:59 -0700
Message-ID: <xmqqpldfm1ps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jul 31, 2025 at 12:15:42PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > The series is built on top of e4ef0485fd7 (The fourteenth batch,
>> > 2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
>> > invalid old object IDs when migrating reflogs, 2025-07-25) merged into
>> > it.
>> 
>> I'll use the newer iteration of the other topic that ends at
>> f0fde561 (refs: fix invalid old object IDs when migrating reflogs,
>> 2025-07-29) instead; that was what was used in the version in 'seen'.
>
> Okay, makes sense. I'll adapt my local base to match then.

Curious.  You had sent v3 but based your other topic on v2 and
expected the result will merge well?

>> > I'd normally have withheld sending until that series was merged to
>> > "next", but given that I promised to send something on Friday already I
>> > decided to just get it out. In any case, if that causes problems I'm
>> > happy to wait a bit before this series here gets merged into "seen".
>> 
>> Thanks, will try to include this in the batch of this evening.

Which has happened.
Thanks.
