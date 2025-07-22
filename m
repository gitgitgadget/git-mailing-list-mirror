Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36C2882AD
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222162; cv=none; b=UXvHnGJ5tgsZbm98wsjrlYF+j1XFwukxb8QC5w2DTMuPIEIEl+AH0gYUO74mIM+Nxi2mvtT0NA5ksej7E1t1HtvvaLJAiUlUCtFg0wjWSZS0W9JHhdUz9a8IoF2q+xxljlVJC49Ud8aVaYXHygUTJUPS1ZzSLY7SDYBklctsdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222162; c=relaxed/simple;
	bh=modi0a3DcZbmrkmYe6L81RSoIp+/Ir4DcqEfBi8EiB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+/lKOAUfjD+N38CCngmP3NXDcTCIESBQKYRjuBp9ASg2XRMIC3b368WDhwlaGZrYm/KETGEmaUO7UUe7iqHDXdCljNXHd9KhqJ/rj3C902pJmr+5kDCXXNLqyImpdGJgmjKBCUvslD8hgj/MI3X0xSuBFuvG7WFTk23jjUzUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WDrkCliU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3SJYEtL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WDrkCliU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3SJYEtL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C492814005F5;
	Tue, 22 Jul 2025 18:09:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 18:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753222159; x=1753308559; bh=rO8HJ6pJV3
	5sT+aVa7UzF/bDSUSvsKf91ZVTb1xXZrg=; b=WDrkCliUMWuyC3IJQHoCmiXaKZ
	twkS5oJHff7d9smKD0UiiAN14E3JkOx3r7wwT8SQGqMnvarsafZ09B8FLcS5MTAx
	G2i5tWsBOv9nDySH6HFBbZBVPZnB2rB/rLy8uxSUpGkob9cnTjVE/hxt+7xMHmpw
	x3URRTuLGGZs9Wnl7aazSxEGZPsqPIzfFK6tHbOaSn9/ERAQh/IsIanFZf2JzTsl
	NwMO2rtAlCkPfCesfXetz1I8UJB/Q4iye9ZZmyaFUa3Mcu4iOBhBCyH7uoxq2eaT
	DsQ9/y2F1BvSbwEU38/udAJKvgbY3Ry0qES5X3TizJi9xcbx4gKCW9PxM9OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753222159; x=1753308559; bh=rO8HJ6pJV35sT+aVa7UzF/bDSUSvsKf91ZV
	Tb1xXZrg=; b=W3SJYEtLAQxu1kvPF8/vbXpKAytNBptUZkte6CMEfehB9pmYk3e
	hCRi95xha+bsJrSIMApcKcOoypjm4eEz4qZgW7vI2//sqcJzQhzm5ZVEVDrcedTH
	Bbtr75Rom/tH2ZNG8SlCB/9Xf9CL45YTXLTDGy2XJhhPPEajEHe7XcrqD2JTM50D
	c4hp82OgvLcaX4mELa2dGiGA1JI0PadHqU151zcPBpzz2ugJtK4K5BnxMHTfl0GP
	uTM1OHwCzQrspwksoqwrhdliujKxijW8yS1g1O53fWPrFpItKEhYqPaERiBRayRt
	r1e+KoBtP5JEOmPAYfiFtlgK6mHu8mMStvQ==
X-ME-Sender: <xms:DwyAaPudboH8FAElKDAtLfoklUjKUgVcuSaUMX9wgj0thLyNXTBBzg>
    <xme:DwyAaLDTVjm9Hpjte2YKVlPCJttMM24eI2VddR4nEj6nMlE-XP33ZHZdo_lJqhSa9
    YX753uDK8vMvE6OYQ>
X-ME-Received: <xmr:DwyAaPVPiAtDNstOuP386DlDyf-Roq1rRCaTOqHuXXBUkec0W1LnBKHsB_nir9fRjJbayuIZwV_DkaBTvXq8AX9Kh208dQmT-VSCaw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejiedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DwyAaBBf_TmZjATDUCGizWm3knAMRLf06L9eKnlmArYz3BA2EjisKw>
    <xmx:DwyAaK8noCXi1YK-l0nk9afAy9HqiR7lnyjHy_Blw0ItWSp9MD39_A>
    <xmx:DwyAaAEzF8hT-kcxUscizCVFK-DVN3xZwedV9IPWl2x3kh9a2inL0g>
    <xmx:DwyAaAOEzAcFBzUqn-yFzPD8LCIqP9AgcccbfCJipbXUBooCRs1aIQ>
    <xmx:DwyAaP8hSgoBXaaAWngciXwLiN9nB0NXacacwHkOfF90DKuwDpzy0hN0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 18:09:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 8/8] refs: fix invalid old object IDs when migrating
 reflogs
In-Reply-To: <20250722-pks-reflog-append-v1-8-183e5949de16@pks.im> (Patrick
	Steinhardt's message of "Tue, 22 Jul 2025 13:20:57 +0200")
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
	<20250722-pks-reflog-append-v1-8-183e5949de16@pks.im>
Date: Tue, 22 Jul 2025 15:09:17 -0700
Message-ID: <xmqqfrenri7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +print_all_reflog_entries () {
> +	repo=$1 &&
> +	test-tool -C "$repo" ref-store main for-each-reflog >reflogs &&
> +	cat reflogs | while read reflog
> +	do
> +		echo "REFLOG: $reflog" &&
> +		test-tool -C "$repo" ref-store main for-each-reflog-ent "$reflog" ||
> +		return 1
> +	done

Let's not cat a single file into a pipe.  What is on the downstream
side of such a pipe is always prepared to read from its standard
input.  I.e.

	test-tool ... >reflogs &&
	while read reflog
	do
		...
	done <reflogs

