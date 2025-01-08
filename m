Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0291FCCEF
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350063; cv=none; b=KcICwH5upYSW8M2cye/UeXYJXwxS6X/J2YPOji9szxEaIHimKO8WiajhdNqwUWi4+Htm9/JPJKIhzkINEleOcVY5d4tvwggxxiNikvOpLq7WEX7Xkz1pZv2yAUzgOZslqQ/COYY66POFGapBXyPGDeoBf+sWYGMMQXPkV0WObuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350063; c=relaxed/simple;
	bh=rd7Zv6vTlo323tbCg1FHe4PcP5teX+DqAtAyrOpNUJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCgoww3Wc76mTGbYb/yuzKdyK08eonCYeY7tv1olXDZ8eMFiYmo7jMpE4mrOd5xFP1cjTRlPIP4B8g53PthkHF8v/jGSM4B19C1UZpzNuOFrmNQZu8+y9q1SFRhZqzKH94TlPf7RP11ecEc6+1YXiqkXod/nyOySTxsB029A3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=5ZpO/x4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXDDn/F2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="5ZpO/x4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXDDn/F2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00B3725400BD;
	Wed,  8 Jan 2025 10:27:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jan 2025 10:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736350059; x=1736436459; bh=KroqpFI2jH
	ghQqr1ME7b5++kQ9rO+6tF/sEM/aOde78=; b=5ZpO/x4Kg5HRftTzRPHKXUTcBl
	SeKBYpiBjPbOj3GhoUnNonW29/7eHvKvCbLBm6qCJyAYF0zOCqf8/EKJOgLDYcWh
	6DpeTOar4tvBj3Z1JdjtmYyJsTMv4PpbPsavfkS1P95xDwh3II3yiBS0TSZo3FwI
	4mcm5qa7wBs58XBij5Wf6/XCOujo2agpubiM9aQrnCTLk/7Figfveu5umDhppED0
	guGHkgOaGjwz8KOJdGuZH6XDiVAssiWNpo+n5EU4x8QMacpQ/z6+fbA1z33P4rfX
	5BY145w75YvaP6ed9i8qGds9ck7CzAVGeb6Z424NDHZnzQQuXEN9moKZtotA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736350059; x=1736436459; bh=KroqpFI2jHghQqr1ME7b5++kQ9rO+6tF/sE
	M/aOde78=; b=KXDDn/F2yes9ySnEsvgtOMK9se41Mkwxs92a+vRGm0ZrtZ4MWT6
	GJ+5IarTz39/oz4Mre1upVrjXSu19Epm0VcolLJcyaVK8ezQwF6y4q5pdc/3vCo2
	CWY3M4+7PGOgzpggbGofnNF0xEv1weXUI81dI0ti56xxP8/K0kD58TNllCkcPKhz
	wJWXi02By+Zij73OV5mRC8BXbsSAUIfMQlObqG7TlXoQXU99VczuJBX5dHn4MjaS
	UT+mZQacBOA3N/T+EwLF1c/pCaSMTFdrgDpzXVB8RlXFTTisOumNkjotYIvFX1sj
	i0vLCsQlqwFErS2Vho6eHbUGBCpZctLEaZQ==
X-ME-Sender: <xms:apl-Zzrtsc2PdztNoqBWcKT4554lLXg_rw-a8fIG0VtscW0TQ4Hs5Q>
    <xme:apl-Z9o5UrUuYsAr6dDS5nLPhl4b2bTZAqOgH5PWtSxaOV30gL2X6NGiR-3y5nRBL
    ijhOAE6zZ9mo8EjZQ>
X-ME-Received: <xmr:apl-ZwPWVGwsgqyP_xs8XjWbClb9FutIpnnJs_k8yzsGqyX8-9RJrj0EXvDLo8Qu7Lg5o9ukd3ZZ-r5ttL6vBkucqlmPt5gD8Mze>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:apl-Z249DYIvaxXNqclifpggLP6kEkoCEmz5tZ2YH0qOtgdxhLBgEQ>
    <xmx:apl-Zy7Af4aoafLwlk0D0H-kaaK98dyeX6WkvWUDpt8CHovaT-zVGw>
    <xmx:apl-Z-jDXJrTliSHzWZCxfSQ4YiZitr1-7Ds4MKBSDyANw_fqfJhfA>
    <xmx:apl-Z05r_00fWA39V1q9pLcI42XgnK6D82xgzRxNuIeR4rnz6K4jWA>
    <xmx:a5l-Z0STGSBRZhCQVwP6h-sXMUC3OTwP0pTy3JEKZaxrN7hsxf10jTxF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 10:27:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t/unit-tests: match functions signature with
 trailing code
In-Reply-To: <Z34XvPjhY15MFHrT@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Jan 2025 07:14:20 +0100")
References: <20250107091932.126673-1-kuforiji98@gmail.com>
	<20250107091932.126673-2-kuforiji98@gmail.com>
	<xmqq7c76trpa.fsf@gitster.g> <Z34XvPjhY15MFHrT@pks.im>
Date: Wed, 08 Jan 2025 07:27:37 -0800
Message-ID: <xmqqcygxpbpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So I agree with you, let's scrap the idea and have proper function
> bodies instead.

Yup, sometimes, simple, stupid, and good enough is the way to go.

We could do

-- >8 --

#define T(testname, input, expect1, expect256) \
	void test_hash__ ## testname(void) \
	{ \
		const char *expect[] = { expect1, expect256 }; \
		check_hash_data(input, strlen(input), expect); \
	} extern void test_hash__ ## testname()

T(empty_string, "", "da39...", "e3b0c4...");
T(single_character, "a", "86f7e4...", "ca97811...");

-- 8< --

which may not upset syntax-aware editors too much.

Unless there are more than several dozens of them, I do not think it
is worth it, though ;-)
