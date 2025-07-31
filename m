Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03509635
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989347; cv=none; b=PkENOPfRcd4wZ/Ckw9U9blQEdDXe9Ye5shZhVi5zPl+rDdKm0O/bpaoEkrZtDnr2aVWF0gUAwDVD/ZRIedknx8UPcYIxmY1VRqIDM2rqeCR838Qzlq/N+ORkJuX7RiYRVlRSBp4JlLSghaxBOrNIR6Stfs9OsagSlevdCWM57nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989347; c=relaxed/simple;
	bh=PL2QBufTdeC7Lv6AdEeIpDoXM8gORIGnE5lip93sjDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGk1tgDuGr8a/7aZaCWM4aF//FufD58avZZWNMI9pKv28+U1wkz+e2b9eMo8Iw1fq/GNVUiO6FWvBVilDA9najlInwVZg5H472CKLGWCF3l3i8keb6wCAAuoqWwnLmqJJwMtKPts1ZEHatXFVR10gNHHPPAAr02EBebWFv11PCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VXb37WMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/ceb+6Y; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXb37WMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/ceb+6Y"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A3E414001B6;
	Thu, 31 Jul 2025 15:15:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 15:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753989345; x=1754075745; bh=PL2QBufTde
	C7Lv6AdEeIpDoXM8gORIGnE5lip93sjDU=; b=VXb37WMU4iBPzX1tWCIJoDl9Z2
	AjFYrcSeNONzuzwMJfmsahxpsToEIA8iiQy6z7Et6ml7GR+yxN26YbiaU6Mg3BjM
	xuhmcgYm0mXcH9kBCbzjDNJWkelqs9sJYVt/ioL8ejaYktp+gx1MtikI023JAE28
	PH65fSKQ0+QoUsZ4uCu/QU5QGYEKdknrdRVQdWn9pq/5hGlo8pQbnssAet2mwr1k
	ZwDmFYieCKBd1NiMgBWb5FL+C7xFVZhxysV/FxAADsvCIQUeokPekJ3ZMigP9k3+
	Viig9GGTyq7dDxkihevW/vPid8ChjTJlNwFPrGFl1tHotjlWZwwESuuFhEkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753989345; x=1754075745; bh=PL2QBufTdeC7Lv6AdEeIpDoXM8gORIGnE5l
	ip93sjDU=; b=U/ceb+6Yjxr6RGekvEs949DkZ3yRxlTmwUtCd11X2+Nsz2hdyc2
	xmcrM4eQwp50kH7k2ekmDCvs2G+67LL/ErXv1uMm3JePzbIlGyeywSBNjL76WZuM
	hz0isswWiMeJjBA5ya7BlTRnc7PQp45oaQRpQl6q00HxZbocMkIL4D76J3zHIahI
	24bsY1e6MydjTVV0otV3M+CCnJFPawz70Xyhe8iALycVqWSS4dPTdegioweYiLvg
	H88uiG0wH9AVjVRwiYJXVoyNbuc7DbAwS+hfzYXD5tOyfV3rWR4nGF0e76yL7ATD
	ELfCFNnvr4ebWeoHG+3Rf9sAI72yAp6BzpA==
X-ME-Sender: <xms:4MCLaC5ys2fmMHaduG5nKd_bNRdECtKTPDMp9MuZ5v7YftidLGJJSQ>
    <xme:4MCLaJfNqHET6R1vNsaKIobKwd2EisFZUIFvQdkW51G0kevDzITPN-GNXQtS-5WPn
    iVXXOCFcfasu_nEXQ>
X-ME-Received: <xmr:4MCLaH6heBVHJT5jMJFIgCsqtp5VIivEW91VNhryNStJMviluZ8yVZWt8cppQtfHc4VfO_DumHAzMw_jPr-hzW1-2mToVYZvy5CGsp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduieefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4MCLaAvLUPFZHEuPVoaL-5J_tjW4qaR9MnhoDFhMTzEjeZhFfsRy0Q>
    <xmx:4MCLaHi1Q2CYqp9nZ2Ob50uVqHIX_pN1x4z6HmEOJdeguh2LDQM8dw>
    <xmx:4MCLaLpvWKDTB4Gi8sCRYVPp4ohb07pPtA-fHiY8KUcO_Vq0TRlzxQ>
    <xmx:4MCLaEup6ZPlcTBwfB6JH4bxBfOzkTNNI8q_i8o2HwAe0zJFc3zf7g>
    <xmx:4cCLaE1IpNCzxYO5WJtInmj9WNz0Ajgy3JBq5FtBr3mFlCzyG-O-pVA5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 15:15:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/6] builtin/remote: rework how remote refs get renamed
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
	(Patrick Steinhardt's message of "Thu, 31 Jul 2025 16:56:48 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
Date: Thu, 31 Jul 2025 12:15:42 -0700
Message-ID: <xmqqcy9gqiht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of e4ef0485fd7 (The fourteenth batch,
> 2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
> invalid old object IDs when migrating reflogs, 2025-07-25) merged into
> it.

I'll use the newer iteration of the other topic that ends at
f0fde561 (refs: fix invalid old object IDs when migrating reflogs,
2025-07-29) instead; that was what was used in the version in 'seen'.

> I'd normally have withheld sending until that series was merged to
> "next", but given that I promised to send something on Friday already I
> decided to just get it out. In any case, if that causes problems I'm
> happy to wait a bit before this series here gets merged into "seen".

Thanks, will try to include this in the batch of this evening.
