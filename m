Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46863382DE
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691476; cv=none; b=HgypUKBuJSbQdMqrh61Jh85lNH2J6U39v4R2E5YQg4Fzqmg6k3UO2PvudAZSEdDvvxhzFFPx1Wt5trpjmlIcXPxs+OJekHplSLhaUvsQ7xD1CQcYmDqWvuWuWZWd3upbQPerRchqkFHSW8q9QqFQUCBdQwyLOU8OzXnKWaENPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691476; c=relaxed/simple;
	bh=8VJkI3B1epD4rMLBNXz1OsvkRBCsBe8hoEEKEuE/lPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oBDJit3PSoDIpyD4KW925PH3e3gZLoRKBwFEbZuVgDLH7P7joWHiNPe5JjiR2ZbzBtqhvgkhAOPFUNFl+hOW1VdyFBwaHefTrkp5L2rHa5L1mgZD9ox9q5Y3bfO3qNBj8/7QBKIQuIhyguDK4PMNVvLxf2ia9MgrtdA0KHVaB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MGT5Qv8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5eKYiwbM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MGT5Qv8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5eKYiwbM"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EC6F1D00013;
	Mon, 16 Mar 2026 16:04:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 16 Mar 2026 16:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773691474; x=1773777874; bh=gMFqO01DB/
	nBU/MEGLInFuwRtAChU1kzmVDynqN5aUg=; b=MGT5Qv8MXCTgEunyjRnvgA9mR2
	v1vEaZO6KGkLIQ94FKMdeE77PtIVRp/ogLjv9bI0cJEQpmFNyKxzJVvxJr8tn57/
	JOyCJ/lRfaB8/bpbfHdy2aSvEipLkhD8B0fDhiEEexMwgacxGCU7c131Z9r2xWY5
	xV+gtJCY3xiSV5Y3GZhOr5Bg+wiXdm+ze5bCH3Q2uZ9PK2+qhD62sGuVAj+3KjDs
	0JDkD0swHycZ8giujOXl+qeqsB+EoPkb1jZ6k7Z8fBsjOnPkPcus/O0QuWbQwhKU
	vySYQw1lOQx0Ufa0+Asl+OgFhK57T94/HdQNZOWM6mIgoKhVrZAoUTgQGCmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773691474; x=1773777874; bh=gMFqO01DB/nBU/MEGLInFuwRtAChU1kzmVD
	ynqN5aUg=; b=5eKYiwbMUu8SfBUq1V7+qJCxzJZ1g61l4OJSj97ybKeHKMmh66g
	ppMCC15uIYbq7uV5O8H2Nm3ArCaGyX0h2p6JAq1sLrLa6+BWHwTliKdadBTqN1tS
	MRozMI1TmttYD+NytW3Q5EEXkfRpxlCf8lME91sCLVtBi5HFep4TcSzjJXmJ8lB0
	19jAJ6JGjE0bduWiaq03CQsfPrt07BGHMAoXqdfJ/LfDTtPB0j5npeJaqqFQ7Anu
	Buv7ih1CIxZYCj9Vw7lRdbfVlJ58iz6PBnVXVGdOmJdb9TajUTXBMSuaooycBUsH
	qR6AZPdLZHOJHNiQmyLPBw9FcILN4Yyo8jg==
X-ME-Sender: <xms:UWK4aZNuKf7_ek2qlEHwLAanHhcShXju3V9TKRiLcQuqEEoxiOL2Kg>
    <xme:UWK4aS0NrfWstEhIvvENi31F129yqEuSXIFQf99nd0NwetCWVhyyWBD_gFA40wzmJ
    HHTyZhEwTy4ZyPe21ekYYLWQQEUc_wIl5OpEuVEfcGepRSrpFhZ>
X-ME-Received: <xmr:UWK4aQmdE-Pvgphpee7fv6Qjjo1ZFQsd3VQv3sg4-Cs5GaTM2DQ7rbYM5Wx6ZzlKN-g0SwmydkPwKmvg-7ogUMFziFJWjHLFUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    grrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UWK4aRUdXWYlkxwKF369pXV-T2UMZuCJhrrdvBLXxvjN0lFsgENgzQ>
    <xmx:UWK4aev8N3iLoqjLmzrCC9vzHmhlMUQt7_sXnROMgp98PhygiWzqwA>
    <xmx:UWK4acYrsnMdWLiEK_zAnZtC5wRD-8Ki82ClsCOGBX79rzEjEi430A>
    <xmx:UWK4aVXP8bpOYcLXb4vWE51wX94ZS1hO8SZ6yxNawJKuAFWjLfG-4A>
    <xmx:UmK4aSFywNhklBx6rBOBQIIG60_Q4o3grXZ4IYUxJZxOUHhSaRV_GMPk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 16:04:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <564a8207-6a96-4f42-b0bc-807edafff330@gmail.com> (Phillip Wood's
	message of "Mon, 16 Mar 2026 16:36:10 +0000")
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
	<xmqqeclpi00y.fsf@gitster.g>
	<953b5842-a4ae-40f6-8cae-c4f81239c903@gmail.com>
	<xmqqms0awcs8.fsf@gitster.g>
	<564a8207-6a96-4f42-b0bc-807edafff330@gmail.com>
Date: Mon, 16 Mar 2026 13:04:32 -0700
Message-ID: <xmqqcy13o81b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Why is the dry-run of unpack_trees() not an extra check? I was assuming 
> that it was because we do the dry-run and then do it for real after 
> possibly stashing any local changes. That's why I was wondering if we 
> could avoid the dry-run by creating the stash if the non-dry-run 
> unpack_trees() failed.

Ah, I didn't even think about that possibility.

Try to unpack anyway, and if unpack_trees() branch switching
succeeds, we are done.  Otherwise, we can trust that unpack_trees()
did not do _anything_ to the index or the working tree files, so we
can create the stash at that time.

Makes sense.

> It turns out I'd misremembered what "git checkout -m 
> --recurse-submodules" does at the moment - after testing it, it seems to 
> simply nuke an uncommitted submodule changes rather than merging them.

Makes sense.
