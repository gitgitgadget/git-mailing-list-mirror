Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F443F7E77
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527714; cv=none; b=aE+/TB4G29cb1eZF/uMZDqabbyAA+n51L5v1cmbCx94qloF+Zfx4QMaoSF0xJlGfe46Q+zFfrN/aWBxdJRX2AAPrIdByR4PWaRIUXU9ltp3G1l4ouSzQ9OsGQs7dMy2jzftcdXAx39xsqjf2idEvnM7CDEX3lq4cdpFfaRT28HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527714; c=relaxed/simple;
	bh=bkiaRCiHnDEdTQH50k0WVh2PF5q314EABQvyXfekJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haM8cnSqwQHW+Cfus627vif22Oc/fOiCxCoHRft1MLz9RzmGpJzmNFNwo8vWJ+3GM2aKk7tGqnQ8w4T3zoQucnCNUT+nTIWnlaQvEnpAKrytVc2vNCDz1pYiwBWWaUCh09b2od29G+d6FyGVwFj6jnzID+CWfselb27y3Q2Jobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MTjzTPEr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQ0arymS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MTjzTPEr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQ0arymS"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 08E0E1D001EA;
	Thu, 26 Mar 2026 08:21:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Mar 2026 08:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527712; x=1774614112; bh=N44v3+OGNt
	yvDD3drtnch+J6Mu12l7BC44jgIaOMFqg=; b=MTjzTPEru+Y/5GvXUQmYiNYCcl
	+j+6Ur9tJ7d9LVzdLT4zxmxBXJ7EjrXkqT6lSJ8lj+0SostYOjb2Ja2HuLMaZwOj
	R0IPjh9ITewamtsZUCJrIz4LoVVdnb8e3qA3UKLrIyztTvi4ZK8mjUv5hhZQ8pVP
	PpvEoJizofATsQ+0ndbH8UVatAYFOk5qNuGVejDXYv0SFgDU7NQ7vaKNkbGF5fae
	OPDuT1ex3BjW2HqyOu2NAOwKuMeRVdXAiW4NebTii30zYLy2wLID+y4A3U7HfcdB
	VE8VKmFL4I6Zz3YYF3lS4IQOCuk++7MI9HLo5FYEmoCl1+o89YWBCNka49Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527712; x=1774614112; bh=N44v3+OGNtyvDD3drtnch+J6Mu12l7BC44j
	gIaOMFqg=; b=yQ0arymSxg5pSkxosjRbuTUOnNrAjrBjBS8NlEQjMwaAmXUq+3C
	8t60GozVixyJzLo3YRi1N68gHue+diT6pXCIilF+BZtvLdBeLRAw0GW1pU8C4ReR
	KDEtLRQHaPge/7pl9KslLa6F0PO3IaBMwnIZS2R3H3iJJU91UavAIACTRtRSWbwV
	91erla7/vjb9CruCFhHfQwf+Adk/l1YAnu+stlm9ryc6Wiw4CKUab/bMktWEyeVI
	TpuWxnEWXw2f2Qu31hgVzHMJ7sWDzRJNkjaNTMQROPebOrMzqy9p3Ye9EaXkWJ7M
	uGHsN3sZ6rUlIs38Jgxwhan1OZPjQV2lWaQ==
X-ME-Sender: <xms:4CTFaYdVCTvSRnFmvNTU27z3_kxqWNAb576IiF_cn4g4cyKXrJljxQ>
    <xme:4CTFad71tWcBaNSCnOvY8a0-8tU8rRx2bCZ7167L4YIcr3cDU6QjZGi5R2_9CZxDK
    PbCnrypV_kyxK3qCIsFf6yH8ydr6JQrDGcuGXeLKVa7mxZlmEaRbw>
X-ME-Received: <xmr:4CTFaTV-yhhME6WBv6Vgys2WfbA4BrR_o5YzsPECNDYAvTgQSU_oOdlht3_bWn5EoYNInwg1EC89TMFDcb7FiE88yvdaKoyxSUGZBqDNe-ucXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4CTFaU7KZK6w9rjm-G8yoQ3Fy5bXa2FbpdtwopTQXy2AzCX3peZI-A>
    <xmx:4CTFaWoGClniFltSxrmy-XOK44GAnqvX_wCtbLji1GPm_WQGZ9E5pw>
    <xmx:4CTFafkV8E83a1mxyL22qoqpsJnvSZ8WBqr71bxAnHaVUkOtRuxbPg>
    <xmx:4CTFaaOHi_o6X24Hs9vcPbqLIlYbUt16CdTrojPK9UPm0hiY1iCdng>
    <xmx:4CTFaUYYhgwFpmKwbg_H-XTo4IkolF7ybRPVeux2nr-g6jeQ3BC2W3nR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b35a632 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:50 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/16] Auto-configure advertised remotes via URL whitelist
Message-ID: <acUk3EAcL8-xM4VK@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:03AM +0100, Christian Couder wrote:
> High level description of the patches
> =====================================
> 
>  - Patch 1/16 ("promisor-remote: try accepted remotes before others in
>    get_direct()"):
> 
>    Fixes promisor_remote_get_direct() to prioritize accepted
>    remotes. This could be a separate fix, but is needed towards the
>    end of the series.
> 
>  - Patches 2-3/16 ("urlmatch:*"):
> 
>    Exposes and adapts helpers in the urlmatch API.
> 
>  - Patches 4-11/16 ("promisor-remote:*"):
> 
>    Big refactoring of filter_promisor_remote() and
>    should_accept_remote(). This keeps `struct promisor_info` instances
>    alive longer to anticipate possible state-desync bugs, decouples
>    the server's advertised name from the local config name, and
>    sanitizes control flow without changing the existing behavior.
> 
>  - Patch 12/16 ("t5710:*"):
> 
>    Cleans up how "file://" URIs are managed in the test script to
>    prepare for URI normalization later in the series and avoid issues
>    on Windows.
> 
>  - Patches 13-15/16 ("promisor-remote:*"):
> 
>    The core feature. Introduces the parsing machinery, adds the
>    additive whitelist for known remotes (with url_normalize()
>    security), and finally implements the auto-creation and collision
>    resolution for unknown remotes.
> 
>  - Patch 16/16 ("doc: promisor: improve acceptFromServer entry"):
> 
>    Cleans up and modernizes the existing `promisor.acceptFromServer`
>    documentation.

I wonder whether it would make sense to split up this series into two.
The first 12 patches and parts of 16 are all sensible improvements that
can land independent of the patches that introduce the new logic. And
given that I expect some discussion around the new logic itself, I
expect that these refactorings can land way faster on their own.

It would also help reduce the review load a bit if one then ultimately
only has to review three patches for the new feature.

Patrick
