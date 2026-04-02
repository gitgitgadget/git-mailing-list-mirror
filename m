Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76B248F6F
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115980; cv=none; b=Bq9I365/p8gf6wyn6I6ty9mkJbWiYRYCWYvPKJ9Jbjz/gFbB8a3iubnVabhcRVIrfp6lLoCMXuKp4UeUX8mRLvQf5MjhUvpD1tBNseWBvsAekhcm3v+p53XEoh1PMs6z2F9WSjp2mqt3zWFCa1g2cb3ajGVtIIpENSQsCGVCOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115980; c=relaxed/simple;
	bh=tfOrfClE3rqsESpvmA2CdDsXbkfFgBU//zhbgQRIlRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOaKn+d8AOFmkwjd90DT10QgpqA1EWrVpgIUccNR+zPtxCayxsB4QodQDsZgUdDpn0jrt2lJOETRp7pdmHPLjEv5l/LP+A/LchFphG0AY5+ouDwzYBXpBqqPujIZB38ZsdM/cqDYT+uO07SCQ6L8a6bxfv6xcxJSzAMVChjmKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kn4FOcS6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4cyflQr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kn4FOcS6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4cyflQr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E8DB7A03C3;
	Thu,  2 Apr 2026 03:46:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 03:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775115976; x=1775202376; bh=pgw7b3BfbB
	QR4dqXWdGWCQKFdpGDeLnBl35LgJOzits=; b=kn4FOcS6rDS+MVzqoh0sGS3f01
	UpAmr/+9dLeNNLOwixYLNBvECCf8DnXMq69OCsm15AIVEOt7VGCW8FKlI1iZoo3b
	NZv0Y/b/xwGgkjQrSl8GnqpOTYCHVasrpCZUl4tIAKqoY5LUNZtYkg9pibYeQ/ai
	8zsPWLSeKrVa2PfNr7SbTqh+o+I/7qrFkNcASpQ9wrFnzRr7gP1kV/SBYjI1ffYG
	xhuKgCa41TwDbglYyOCJkUWN4mcm3d037y0vSmE3y9kMy6PzS+UBy5mAt/s7RLZA
	LtQC0TElXGNLN3dRXEkShtBfoRnTNwaHUDf6sBUpoXJaeAlJ2IAm+3JmeCoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775115976; x=1775202376; bh=pgw7b3BfbBQR4dqXWdGWCQKFdpGDeLnBl35
	LgJOzits=; b=Z4cyflQrQBnIQs3V8xZNNCHK/M7rXKJBRHQPBxGRzibPUbHZDpP
	RTqZt8c2XdlSVr0yjVkrCMUl7Un0OBktfWrGyHHyVSmRkAULYmV2PxG/8PYoebJM
	yX4xQGNK32h6MLhB6/vX92eKEuJRoyEMP73bbT/t7fNO5NhTFMAiUqXqy8h+C6S/
	epixKwMaWQsdEIfC01He1xwp2Jz9WwvQ2fdSIkalzTDh+DtC2isizaYm91NcdsGe
	0jN4depE0TEbIkeViG3Et035Sd4NfifyLsdCHlHxAYYL+zCoo4x4BItnuYIKOIv+
	rL+hQzOb0o1BJo9bIZhJFh/IUnuWwcGzdQQ==
X-ME-Sender: <xms:yB7OaR_fRactm7r-M2t3CwHX63T6-rFjJ7RHUvgQYLAlK9TodLDedg>
    <xme:yB7OaX_el5DbasDQvPOVwAPE27kedom2tiUkZHp6HclCXZ3xp51dyIeQQdnJzo0OV
    BZ9cwQgqud1GJSBLArrVU35nbsam0HHo15RWEp-8M4MfLycSoYrrw>
X-ME-Received: <xmr:yB7OaRSy5yzAI9-cMScHYfK_1b_m4PXRJWWaYT-iAuA8E7ZkhgZrs21960hB9kEOdLRwLiThGcPmNLzXwLYYmry3siIBoEUw_Ph6gOmzdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yB7Oabc4xFmAMTEodyb1tliigvD0JeKaH8dzG0dha_BaE4VIIuSYaw>
    <xmx:yB7OaVBk6cUSlfVP1oO-WRVWNweLAzq8NGsFonkd8oGqgqLi7ONnFQ>
    <xmx:yB7Oadn1jCCy9MHu_wCh_U3sKE3ou6FYT_i5DmjOu0rznLUHNOkH7g>
    <xmx:yB7OaQf_y8bb_0G6GrTBdK-kOThBYv09nCEE0MfcQ33KS942FSK8bg>
    <xmx:yB7OaWtNDzlOkUZOth09EwQbhBwiB6Whz5vSlFSD7V1WqkS2SMnYF4ff>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:46:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 381f90e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:46:14 +0000 (UTC)
Date: Thu, 2 Apr 2026 09:46:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 04/10] promisor-remote: reject empty name or URL in
 advertised remote
Message-ID: <ac4ew5oQNU7VJYOa@pks.im>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260402070613.85934-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402070613.85934-5-christian.couder@gmail.com>

On Thu, Apr 02, 2026 at 09:06:07AM +0200, Christian Couder wrote:
> In parse_one_advertised_remote(), we check for a NULL remote name and
> remote URL, but not for empty ones. An empty URL seems possible as
> url_percent_decode("") doesn't return NULL.
> 
> In promisor_config_info_list(), we ignore remotes with empty URLs, so a
> Git server should not advertise remotes with empty URLs. It's possible
> that a buggy or malicious server would do it though.
> 
> So let's tighten the check in parse_one_advertised_remote() to also
> reject empty strings at parse time.

Makes sense.

Patrick
