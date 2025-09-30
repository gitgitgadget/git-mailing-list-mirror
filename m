Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754C4C81
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264087; cv=none; b=V3m3DRqS2faQWA78MSjlrLZpFVjxg9sS81NifXuMhggIibBpOasZlPzkuiwD5vRHD0mM3udw6WI37nzzbv5ycI+eenE/p66RerSrDn3SVTJGxRYRRFCT114JpqCM5AE9Ypc3IrLtTEnDUOY08Gi9tOu3KkMfr6RtwhXRBV/e57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264087; c=relaxed/simple;
	bh=aZYONbjGetId0eCbLe/hqGZhsQ6ShNqnHOC0kamBMU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfqEyhyo9AJ1khQ/f70131TxlTFt7f/Px9kT2elZCb/jWkwB3xnPOpd6uzMIvNPfDNAj9wuUclbsgPrCm8/3ZnfVUsOxMIcp3PV6DSWQv/pk8u1QDk/N2wZLHwY0LZGZ+yJtG7Ol6C76C3ftZY6v9b5oi8+513UMl/2eapMiqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SbWBHL0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4dylRVk; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SbWBHL0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4dylRVk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CB48EC0279;
	Tue, 30 Sep 2025 16:28:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 30 Sep 2025 16:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759264083; x=1759350483; bh=aZYONbjGet
	Id0eCbLe/hqGZhsQ6ShNqnHOC0kamBMU0=; b=SbWBHL0ISQy2b5BNnYB8Qw/SDo
	bt8CX+Fft++Bkq1GblknJiTCSGdpSNk7DiP/Ewd+1FTxBXOBOYvUHaCT4OzfkflO
	k31EiH0naFW/U1ppGLmTmA/6VtWkmz1+qE+NaWgzzB4ounAo6Id37fQFQYgbLQKv
	1xtOEVVSw8/UDBkaVU2LF7jbVx76D34yi0bRZvapVNeV0z7X7g/AsSR267/k/R1q
	AV1uHQG2bwged6PLOsKVDtzmF5y1+Zgae6sP11DkE9qKo+4nLiqenVSZhQvMW5PK
	rKe9gGQLBnManqdfL1Zhw/o2Q8GHSoBzJ+C2XOmxIb5BkxlF4uNh4sqUd1MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759264083; x=1759350483; bh=aZYONbjGetId0eCbLe/hqGZhsQ6ShNqnHOC
	0kamBMU0=; b=g4dylRVk76bPl2FXw2GByd9qOAzsHe6X7Q9ShrqY8QDhKEVppYB
	8MUywQ4Lgv8ntbAtu0XTBWCruxEiD/NExg/9riOV6vyr59d1Qz4k1m5ymeeVlLS4
	HpS14SaX7xj+KR0zIssclLY4y3Wy7akUt/NpFFm4IZ7BztSwF4j7/MZ9BMruhBTe
	ejHl4qna98kL2Hou0H2UG2xQqLYl7bYpRd8WSKt8LI7alLjq7lFC2kFaIQwdqsPk
	MwbGdPLAT8Zyp4LtX2oBTe5vrOfnHCrtPcoCgNqbc5EEEeu3yc/IrQfVsbY+zDE2
	+knBfiSqIIuQgXJAU8o9l2ujdtoe28aSM2Q==
X-ME-Sender: <xms:Uj3caFkPiohfQqqOxcsX-LePnbN8mk7Fg0f0hQWWrUyn1VNZ9YfEQg>
    <xme:Uj3caH0_zeM1dq0K12XdbBRm9XNWTMEQi_u2KI-qKoBgKVud15Vyf9t_hGko_eoeo
    TQMp87Vw5KgZqgvPTkbieW6Y9W4A-BPhN5wHttPR84yXQdKkLCv0CY>
X-ME-Received: <xmr:Uj3caApklMBAnM12cuhz4BNR6xqLcxFRIN7r3Y-v8Q4sFg1nTU1NuCFtfXm-QTMw79DqNJmrC5OjaObwSfrJfsDPojRO8Qt6F7mW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Uj3caEeiZw_VOjMJWbL-qOOG-gIte8WP9Z9LDm7nBERJw6rGvEyfTA>
    <xmx:Uj3caPoXoYPoyU5PQCY-v9ycHpQxAYjMJlLiuyb0B6mI1ihupNr24Q>
    <xmx:Uj3caFEfMPx5IftY6E2lk1PdwnXTDaHu9p-YrjTHR-rTaU6nYsMknQ>
    <xmx:Uj3caPsuN0F88MtkdRhBiFnx8SGEioZ-ZSWwpPJyRB87EB1lEVCcMw>
    <xmx:Uz3caJ553Pkb9K1C_QU46eJrlOLgxXX8dHi69deYS-OENha6MCvhjwLk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 16:28:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
In-Reply-To: <aNw3VY7npZvHDU7i@nand.local> (Taylor Blau's message of "Tue, 30
	Sep 2025 16:02:29 -0400")
References: <xmqqldm0am4b.fsf@gitster.g> <aNhX9AJ/zq4IYhmW@nand.local>
	<xmqqseg777k8.fsf@gitster.g> <aNsG5Jd_YLgrwarI@pks.im>
	<aNw3VY7npZvHDU7i@nand.local>
Date: Tue, 30 Sep 2025 13:28:01 -0700
Message-ID: <xmqqbjmr4re6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> (As an aside, in the pseudo-patch I wrote above, the maintainer could
> choose to bypass the process entirely, since it would continue to be at
> their discretion. Perhaps that's just a semantics thing, since by
> merging the series the maintainer is implicitly providing their own
> "ack", without actually saying so.)

This is exactly the reason why I keep saying "being in 'seen' has no
meaning other than I happened to have seen, not more than that".
A topic queued in 'seen' by default has no "ack" from me or anybody.
