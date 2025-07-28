Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7791F3B89
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736060; cv=none; b=MT0kH+kKkE1oGjq87kIGWaZ+WMVZPSTnbLA8ReGhP4pbat6b0/59t10w8Bgr02RUqqeNTWY2hpskDfS44xSMRuqCelbqgI7hHr9mEadNkRs64qimsKODdz91rvt2fbHNC53VkETt9k6Gl2kYn0NNc8nzy4U+Djh5vPfXRCSmaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736060; c=relaxed/simple;
	bh=kv4jMhCgnq6GLzpjNrUh1Y4hgL+D5HPZ3YVfRjixt+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qH87RKT/FsP3iD7E2PrNLFJh77dA4gQ67xbKH/TRXzzMbQ6XEjuDVj28qiK7A/NzBe1OG6RA2e+we95XEVpH6PWTEinylxQ9QX5c9uF+YP3CP4Isr0hJ4TS5dG839mYZbrONf/dLFg2ZjRpR3CXhLGbsnRZEIormQPguZhf2Z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fq7W3aoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gH4YBSds; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fq7W3aoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gH4YBSds"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DD16F1D003CB;
	Mon, 28 Jul 2025 16:54:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 28 Jul 2025 16:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753736055; x=1753822455; bh=regIbt6Y1C
	z87oaRvjSPR2KCN+D27qb4FTkzdN0Sd+c=; b=fq7W3aoTwFYKf8zV60wKhhXyVa
	+RP0niZs1hlQToSbnZbHYEXHO3lZYTdoksIPaThDvvV8WwSa+pm3jC+NhBOo2E24
	J+HEpIEuGPsMszDpXWyw/MjxL9L0FwAMNZijvSGC8obpSrrZHnrcyR3aOX9LflTj
	A5e7+JmDg3z3lLvOBi+5WqdikyS2ZIC12rOMN+rt4PaMp2cQ3I11z0k0hiyL+Edy
	nnTuzcLj339MVwh7lv3ZmtIBScu9uooBNNSHb/WsvuDmojpu+PRngkGcr582QpTH
	4ol4i2b0LpJg+vOpzGlFo9yhx1aCXF6ma5qYiCdWASdufWUsW4SWp9uO+hRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753736055; x=1753822455; bh=regIbt6Y1Cz87oaRvjSPR2KCN+D27qb4FTk
	zdN0Sd+c=; b=gH4YBSdsuiaqU32mGnHx/2uNv4In5A7jHNED5mgfm178CUO9iBd
	6z0hwQybagSsfBAhzpt0d/rz2Q1i3aV68giHzl8iGpa7f6hs1T90nJNtI7mqFgp2
	GWc6oKzuGaCzB36K4f7tFM0n1GBdxsZapzG7ZJAzS7ukTBhNrn7ugwCNyg8ICMel
	TNnnuk3gjN4Q8PNDGIGvppLKsoX2FeLIs2aEamGosDVcCoQ4E2u9AvjWrSfteZ0K
	6ihDOcrR8yJK9RcHc2X8Dcretvo4P40kf9oevS5SXQmU80byf3NHDVRhod6ha2bc
	QZs1LqWGII1stkhmw12CJrkiBxi6j58Ao4w==
X-ME-Sender: <xms:d-OHaNRqB913axkiRoXT4G86fz3XBvVG2qHDFgTu2Xr3yuAX9pq21w>
    <xme:d-OHaD6xqE6-2alvl14EO64ildQKmkPgs_iMrVnz2pdv0jyviPZxnO7kkVd645CMy
    LoMSJbA538Fou7DaQ>
X-ME-Received: <xmr:d-OHaB2FNTo1RioN1V7tDzLdxq-PxpjfVFkcp13xQlguRZowOtfju79MQ6bJtTHLVVHqEban_4QgMDMu-47C8xMLIByisYMdGdhR0r8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopegrmhhonhgrkhhovhesihhsphhrrghsrdhruhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:d-OHaGADVxFHAIrqBgeiBLy1oHYdEj7cfwrQuyTAWqaOZkKRqtFeNw>
    <xmx:d-OHaEPxBeMsEYLRtbHnV8OtyilMKjZGBsxvtofUbgiNFBav9tTOvw>
    <xmx:d-OHaDZG0cxaLnLBU9qNQIe6LCt_Uk2AKt_aVBAC2xT5V2kuDSdSOA>
    <xmx:d-OHaLvY5KtqCgCGIp6I53sSY-glqA92-e97v9BIxEQv4QRe2AOQzw>
    <xmx:d-OHaI31qre4vvDNuEg0nf7vpzLRMjHQppRgBxq_gj_xNMwVoQ-owsLM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 16:54:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Alexander Monakov <amonakov@ispras.ru>,  git@vger.kernel.org,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
In-Reply-To: <2e70fce9-1779-4d35-ae65-42792e710054@gentoo.org> (Eli Schwartz's
	message of "Mon, 28 Jul 2025 15:56:21 -0400")
References: <20250728190520.10962-1-amonakov@ispras.ru>
	<xmqqa54oun5w.fsf@gitster.g>
	<2e70fce9-1779-4d35-ae65-42792e710054@gentoo.org>
Date: Mon, 28 Jul 2025 13:54:14 -0700
Message-ID: <xmqqseigt4sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> At any rate, quite untrue. Glibc's wikipedia page -- and also its source
> code, luckily -- documents "LGPL-2.1-or-later", which is more permissive
> than git (and equally as permissive as xdiff).

Ah, OK.  That sound very nice.  Thanks for correcting me.
