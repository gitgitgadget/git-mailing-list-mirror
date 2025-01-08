Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583B1957FC
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358063; cv=none; b=ouUVvY7zjx685YykG9NxNfYKOQiOOPxrXydiTsBKxpdvnIvCgJoo5TafZd2LV0Y54IFpOP352pB/qrDcK2ipIMQGruSAZkTfqEMm08L5puaKLvddNhyZUoY8hXkYjWxVyr5zjTM9E/sRdFwXrqODny0zW2gFa1M+7rZgTe9AemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358063; c=relaxed/simple;
	bh=nEfkhvLruqXCgKP7ub8YcaUzUxlWkC90fllIdsYsWLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3xnsXa7QaDyMB8ZdIS42qCDtNrCacWtyE1moEspbWQ72Th+JuS9MVndVpFKRIdkYpZuIH/7lNtOFPXtRFkPM8fKwKO7fATaT+FWI1RX+GAsgSzFc2c1AA8/3wlSn3+qjpR/93iCZMXIQYtKalpmvrxt33h+TNH+FtunRP9f7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ME8LfL58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d1pDFHPg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ME8LfL58";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d1pDFHPg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 511C311401AC;
	Wed,  8 Jan 2025 12:41:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 12:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736358060; x=1736444460; bh=CQjKwxXAbg
	y+h2Gv3mdsLvZzwmsZNdY/N19pHCnQNgw=; b=ME8LfL58f4VV4J+VrCpRIdxqPY
	Kjx7HBNXlKyrsGmM4oen7j9gx4D/cOfAeR9qescgmDIsJmmityf7n7+utTdlM83O
	NX6+ZCr15F+1Zen8SADQfLAXBLF+xVSRK/iAkCn1rBLl/dT5qs84p+GwCI7AJrok
	leoAVqFmrAQ7Lp+wWy85uYFESl80+ZM8oRsII2eyJTK9yBHJpe2SIHpegBR9I5zm
	L/HwMk6aX8/yqZqJ5UAuwpT/SC4xMvgbL75lSZm8TkDCX7cPL9SmVbYf+DJPIPUb
	s9iGHsrFbUn+Ad5iTH27BvTvo/CJJeHvqFemCrhACrhoW5JazPvUh66OSYhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736358060; x=1736444460; bh=CQjKwxXAbgy+h2Gv3mdsLvZzwmsZNdY/N19
	pHCnQNgw=; b=d1pDFHPg6RCpQ22D7++G6LmwBRq411h9v8JTCOVpsaZZexaysIY
	Pad+Y0ltvFhyK+eWB65c1oOfoN98cygSitEtoazzXdZuYNeZI37naVXrFSPzPSud
	3dlaXp7bjhCGnusriUqo/UF65/ICaF/bx3zebhyG0HknXm/iBVBJVsCR9zkOiwIF
	XRicuEoS9rcFSm9HCqyNhWvCfRPy9LAzZOUm/3SCibqua1A6zTETXG82CguH2l4R
	EZvkeqPNxzfGvUpHOCZw7VBmYNvg8iDTLk1+y6uILBq7czMAL2sLOOGYhdP9ZULV
	vwjaZK9QTGhcBuEq5PJ38hjghu6XUN2udyg==
X-ME-Sender: <xms:q7h-Z4HEo6HBdt1XjJWQJ7shXV-Bw3kH6gA_Yqqj0_qDdhpr4OKicA>
    <xme:q7h-ZxWtKELTxtrpqBv3h2xbKLSeGxE0SRGlgJqs_Ca5SUEtFKU5yYO1akMOGhK5_
    EWez4Re9p4gwXo2mA>
X-ME-Received: <xmr:q7h-ZyLojnNgXB1MQBq1L9Z68EnMECwGBOOLuw86N0y8ZkupTtcDjByaCXIvwRfaswJD8yyOwKcaKXv3ivX1_kdd6biOg2F-aOeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeegiedtuedvgeffgefghffhvdfhhfeifefh
    vddvgfelteehgfejtedugfefleehtdenucffohhmrghinheplhhishhtrdhnohifnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvg
    igsghrihgughgvrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q7h-Z6HOoliA4gmS5e0-g185EiXv2tNnqtiXn0rf4BXUBoELBEv21w>
    <xmx:q7h-Z-VkplmqZ3i2pNUapA5qXkRMCEfKOdJGU1Ff2Vz088wvcJsWiw>
    <xmx:q7h-Z9NPgcR_Rm7E2gSVwNbO3QPVo0zZHIdvBGjRzZtEETvgb-omAQ>
    <xmx:q7h-Z10g6NvNOtf2S-87-s3B6OEVzKJuM587jmOLHpfRlbsfcm-Nyw>
    <xmx:rLh-Z8x9aEq4Di6nFRh55FHe78lb4kN-GZ2jC242OKNUFlNgOgbdpo02>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 12:40:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
In-Reply-To: <Z36l--QUjaYYb6Uf@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Jan 2025 17:21:15 +0100")
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
	<20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
	<xmqqzfk2qr62.fsf@gitster.g> <xmqqv7uqqqu9.fsf@gitster.g>
	<Z34gfa-_dSbWD19h@pks.im> <xmqqr05dnwli.fsf@gitster.g>
	<Z36l--QUjaYYb6Uf@pks.im>
Date: Wed, 08 Jan 2025 09:40:58 -0800
Message-ID: <xmqqo70hmcet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hm. The problem is when Git dies in the middle of a transaction:
>
>   1. We write the temporary table.
>   2. We compute the not-so-random suffix.
>   3. We write the temporary "tables.list" file.
>   4. We move the temporary table into place using the not-so-random
>      suffix.
>   5. Git dies before updating "tables.list".
>
> Now we have the temporary table moved into place, but "tables.list"
> hasn't been updated yet. When the next Git process comes along and wants
> to update the table it would result in an error if it computed the same
> suffix.

Here, I hear that we _do_ depend on the suffix being relatively
unique.  Once our random number generator decides to give the same
number twice to cause collision, the reftable data gets corrupt?

> The reftable library knows to clean up such stale tables when not
> referenced by the "tables.list" file, but it doesn't do so on every
> write. So this would likely still cause issues in practice.
>
> I already though about this scenario when writing my mail, but didn't
> really think about it as "correctness". But I guess it is.

Hmph.  I am not sure how I should feel about this.  Our reliance on
hash functions (which can be made to collide) not colliding is one
thing, but is it sensibly safe to rely on a cryptographically
unpredictable random generator not to yield the same suffix twice
during the lifetime of an previous invocation for correctness?
