Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEF1B29A7
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868819; cv=none; b=RYeBiXez160SeHupg86tMnETOKUzfRY5k+z0R5BuL5HadpXeEcNF0EWnHam2yezKg0pNeFsLUUKerADNKKRDNkLs6KHs3FB8Fh4Acst1BYRNNL8nTyesoOu73VrsRDVb4vB5Y1WHv/DEabfnWN9jCiwEuJOHtv7V96IruLdpmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868819; c=relaxed/simple;
	bh=z5KWnWSpHC1dixboyImA3g+4PWeW9WAlADWzCz168qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoeWkUjBrY6blJqN+Dk6BpcXX/b84pTjPPNWgVpLyv+v6nA7eqkO1OXE43oPeKwPy/c0D0GUx01RnYwpkwAfStMISaox9xLoMPZnIzp/Fvs1WVpqAESQ8iFX5eYMrYLCq5QkCls9wEEsW3flwWPSi6EDDaflXmectRxlL6xGvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TmZzyvdR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mp5Y1G39; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TmZzyvdR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mp5Y1G39"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FC1F1380288;
	Mon,  9 Sep 2024 04:00:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Sep 2024 04:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725868817; x=1725955217; bh=o2a4Qy6oEc
	8fRjOpmUKHCbh/EudpzuSMxBgGihRjs4A=; b=TmZzyvdR3drvjnpvqffNpbBnbA
	gxhAuLMEufn+exTZFiJ64R9b6vTE40jDdW/oVBRc/YQbuvNIbSDbXUHrxYahDCoY
	d4ZbNixnl0F4JrvbkfsOPMHPEuqHfCy4YBmah+F1ielLyGQhNnQV/9q2R4u8qfvB
	F8TnEZkEpEVU74JIHcUzD1B/pPjTO7Nth8JmSHbPbSnGVzPkVPzCXpL5d8SOiVZX
	Dx5TCvfHWy4twN4YQOnq02r+pZ8RvXrjUY4vKVPaIStgzGo1yJo12woPN1GROuO6
	VGmSzuEVoHRqu+CUz6xYJii5QjVtKmKofTIxqWAw5CPBKJ75e3Pe2sfN3/Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725868817; x=1725955217; bh=o2a4Qy6oEc8fRjOpmUKHCbh/Eudp
	zuSMxBgGihRjs4A=; b=Mp5Y1G39N3SD9f705x3VMlrsIZ+PI/TbsytaTBiLuesp
	Da7AQ4P9/z56cfHY8wVhEJyj86ClrBK1SDJtYHJvVkNUTd4BDeWRYZyl7YE+q9oE
	o0yqjD4c7LYAAmXbL9rpu8lQrpkHnzDDygZOM/lrVkwfKxsx1SgGO98hzAynyiCk
	ElHe/qzZ8gaRZ0N/PsF67L2bEm5Aa8lyK2emhsEahqpLMyuzlbCNdDsHMKnB+UW7
	eDJlWtxIjgCcko5yGP4eoxElzQdtg45O+JFI1KpRJKZm74sLFb9zmDbW5hRForGS
	EDFiHtK3xbXTqKuvLBYrVWEgKP6nYSWU1SyvCD6vZQ==
X-ME-Sender: <xms:EKveZvC9fUz5ESH1ZkxP8djwsj6z9n38AlZ-4dm09Bqtkd01MKBoXg>
    <xme:EKveZlibZQsEQGdFJaCmzj7oQxFcsVY2x4UQ0k1UJy-35XKTwmAREladGDlfyZkHt
    TSq_AJHmzQcI43s9w>
X-ME-Received: <xmr:EKveZqmMVKDki5gKYMd2u169OUvljg1_W6Tb712R-X8aAiAogOcAuv1fHwVhchIRgEYGGcuAblKju-T1r-yLq8_xXUv9hgMq0VpoSXpTSlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiiedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeugfegvdehleelueefveffgfehtdelvdetuefhveel
    feeffffhheevgfefueelnecuffhomhgrihhnpehsfhgtohhnshgvrhhvrghntgihrdhorh
    hgpdhouhhtrhgvrggthhihrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehorhhgrghn
    ihiivghrshesohhuthhrvggrtghhhidrohhrghdprhgtphhtthhopehgihhtsehsfhgtoh
    hnshgvrhhvrghntgihrdhorhhgpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukh
X-ME-Proxy: <xmx:EKveZhwmD7lO7euc59knLvZLj7df7OItxU07RZEV0B2zlpSdbg1xPQ>
    <xmx:EKveZkQmxA12CMkGzF_F0IvfwohWwHG3BinuJTmiRG5n33SceW17ig>
    <xmx:EKveZkb_e9aSEFMNnZP6TldEg_YTnK-jzIRLbrqKlluIzNAZZPTPIg>
    <xmx:EKveZlQmSjUrCgaErOpzJ9OdgAtd19C2mYqJqcAgso9ShtqatxMy2g>
    <xmx:EaveZnHx07Lz5AAerr3jfoNbwOHqYkk0llzNpoMPHSja_3nmS-uvziQ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 04:00:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2714f990 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 08:00:12 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:00:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday
 September 11th at 4pm UTC
Message-ID: <Zt6rC7TtUvxWGXN-@pks.im>
References: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
 <Zt6pbMP3Rpjy-pC_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt6pbMP3Rpjy-pC_@pks.im>

On Mon, Sep 09, 2024 at 09:53:20AM +0200, Patrick Steinhardt wrote:
> On Thu, Sep 05, 2024 at 11:50:20AM +0200, Christian Couder wrote:
> > Hi everyone,
> > 
> > I signed up for Git as a mentoring community in the Outreachy December
> > 2024 internship cohort. The deadline was September 6th at 4pm UTC and
> > I think we will be able to change our mind later if we decide to not
> > participate for some reason. So it was better to just sign-up.
> > 
> > I have also added a project with the title: "Finish adding a
> > 'os-version' capability to Git protocol v2" that I am willing to
> > mentor or co-mentor. I think it's possible to add more projects and to
> > remove this one if we find better ones.
> > 
> > The mentor sign-up deadline is very soon too: Wednesday September 11th
> > at 4pm UTC
> > 
> > So if you are interested in mentoring please sign-up. I think
> > co-mentors might be able to sign-up later but I am not sure.
> > 
> > Tilda, please correct me if I am wrong.
> > 
> > Also please let us know if some companies might be willing to sponsor
> > an Outreachy intern or Outreachy itself. Outreachy is part of the
> > Software Freedom Conservancy (https://sfconservancy.org/) like the Git
> > project.
> > 
> > See: https://www.outreachy.org/communities/cfp/git/
> 
> Thanks for organizing this! With the clar unit testing framework having
> landed I think it would be a nice project for Outreachy to convert (a
> subset of) our unit tests to that new framework.
> 
> There is still a bunch of work that I'm in the process of upstreaming
> [1][2][3][4] as well as a refactoring of the macros to make them
> typesafe that I'm currently preparing. But none of these changes should
> impact how the clar is used, so I would say that it is fine to queue up
> such a project.
> 
> Patrick
> 
> [1]: https://github.com/clar-test/clar/pull/99 (MinGW and HPE support, merged)
> [2]: https://github.com/clar-test/clar/pull/100 (CI support for Windows)
> [3]: https://github.com/clar-test/clar/pull/101 (out-of-memory handling)
> [4]: https://github.com/clar-test/clar/pull/102 (selftests)

I forgot to say: I'd be happy to mentor or co-mentor such a project.

Patrick
