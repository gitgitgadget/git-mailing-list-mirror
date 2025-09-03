Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6C2E8DF2
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894512; cv=none; b=ZQNf8VWctILGZBX60x9EIDCeEsmujg0fTaKmaEDtKfaC46pAcwnIhqbDYHKNoJWD8WrUQEYjyvow2dLapxKjWhsbzoqLsaxhu7QR4redOG/yxFJAYjUpDDm/r92t7xxPKhYV+cce4QvEDGoj+u0rTrxq/8UFma4PYkUPRkFF4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894512; c=relaxed/simple;
	bh=Na5en/WHDcXWQiEUw1eZ4AC+/aOaAOFa0pQqLaq0GeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3uGGXFKx+QFpx87JcrbhzvPjswwWwf59jV+FtgqaBEsZ6y9LHLCYNwl9DtRgQIqGMn+BLHBrdsoJnHzzCULqFmwFiZs4LB24iDndaDPr2gHueA17+NG9pln3+f3+vytToiXjW9rcAHGm9+rWW7m6EUydrZLUeRHCiqSeuBNp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OynVZ171; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXWQ4fWz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OynVZ171";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXWQ4fWz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC3511400411;
	Wed,  3 Sep 2025 06:15:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 06:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756894508; x=1756980908; bh=+UrwAenzXV
	EnLAqPcIDTiR8OHksWLpTvLBJ1WOIn2Mo=; b=OynVZ171FqxInrnoGDhj8or3St
	nAQj3+i5/Czx2N3vvWscYUBC9SRWfNdJSGlNEsjKAjaePiwiSatxdI6TmsPOMWMI
	fHCszPzjKKWaZg9efNrYjrd8Uqoa2Sow5RLWKsCaIxbTLKVspqlFAPVnYnFVZ86m
	aMHpGXq4mtgN/GUM4JPXLOTNzetqRvGs9OkW1vTvzphCw/CFAjhekAo897kjI8RW
	+pl8CMHUibeOITX0ANoGuDrQXueYCUxPJLbfweuooJcl5w38Xp4LNwqf2NWJADlH
	bu7/j+c5ylXnFc/cB8MxhPzTBxUq12kn/F5Ig5Ok33vLTlkGdzyM4uqpgqew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894508; x=1756980908; bh=+UrwAenzXVEnLAqPcIDTiR8OHksWLpTvLBJ
	1WOIn2Mo=; b=UXWQ4fWz97qgD1IlVzQ8B3aztBKjMSHhjH5cdz6S7UkJHsBbtNY
	vT6NnXaPx2/+6fZ501ikZRA6RuuKMAzBizciaMfoPvg6LBpqzADwrRub/58JoeMO
	EgKYuzDa71iTvkQxd+Xrmzs3mpivCrx9hLcScTkfCIMsoNGcjb3iXxKZ7Tw23WRX
	muoAsPWkP7qVOC6kuyirFcb4F+dzvhzmIqvK2e5eip0yPaw3g4+TyXWsh+c399LL
	tbGgGcuoqADZ72dvfp83ZnqyUnkT4yXJ78Urlpu3sLR2Gv+EISxnBpCqLms3ypaW
	n1RxKPq/UUqeVoEeRpB1qT10bHeEZIZxZIg==
X-ME-Sender: <xms:LBW4aHrGS2Awhn6DxLUa47WJn8I3Ncer0MkZFPNidBKEZDq_uCqCtg>
    <xme:LBW4aNKwH3ztkwsfXfOQc4rj0VbdoueHVT7mZ95mP-D5LCUjve2Yb_G-vGHJiInMr
    1cofWGe9s2WZ9h13Q>
X-ME-Received: <xmr:LBW4aKoflPXF6vxG-UfpCGyUU1oVJWQv3cWn8_CVU1fgw1TbhocRcy9Na0mGxVLwt3YcbVEPiXxPqtJAM_McCn-pp1taU4PWgW4NxSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:LBW4aFz0UXYSHVDCq6yB0J34mUFAEZxxTr9Z-O8rFtbpI8wxl2e2ig>
    <xmx:LBW4aOMMPBOxGTosueer2dFWOM9SalkwTtzgJ5MP6Y12VCwudCWpdw>
    <xmx:LBW4aK62ojWIufDiwch4NtHGrJHIvRualQmO62Hevp_mVp9j6mC-eQ>
    <xmx:LBW4aHldQUqUcFRKM3bvwYZsM45EgOPcAtPTS2jt2jYzl_O-KhbjyA>
    <xmx:LBW4aBuRCNTExLqofTnTwRRS019PytTxXewEmhaeICYuPUX2Oh6KEcsa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:15:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9261639b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 10:15:05 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:14:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/6] midx-write: only load initialized packs
Message-ID: <aLgVIPpW9QBFmgb7@pks.im>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <e02a444315acbc638a3d31279c10a936f0adb7b4.1756589007.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02a444315acbc638a3d31279c10a936f0adb7b4.1756589007.git.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 09:23:22PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The fill_packs_from_midx() method was refactored in fcb2205b77 (midx:
> implement support for writing incremental MIDX chains, 2024-08-06) to
> allow for preferred packfiles and incremental multi-pack-indexes.
> However, this led to some conditions that can cause improperly
> initialized memory in the context's list of packfiles.
> 
> The conditions caring about the preferred pack name or the incremental
> flag are currently necessary to load a packfile. But the context is
> still being populated with pack_info structs based on the packfile array
> for the existing multi-pack-index even if prepare_midx_pack() isn't
> called.

I honestly don't quite understand why the conditions are necessary here.
In other words, why do we need to be careful _not_ to open the
packfiles?

> Add a new test that breaks under --stress when compiled with
> SANITIZE=address. The chosen number of 100 packfiles was selected to get
> the --stress output to fail about 50% of the time, while 50 packfiles
> could not get a failure in most --stress runs.
> 
> The test case is marked as EXPENSIVE not only because of the number of
> packfiles it creates, but because some CI environments were reporting
> errors during the test that I could not reproduce, specifically around
> being unable to open the packfiles or their pack-indexes.
> 
> When it fails under SANITIZE=address, it provides the following error:
> 
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==3263517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000027
> ==3263517==The signal is caused by a READ memory access.
> ==3263517==Hint: address points to the zero page.
>     #0 0x562d5d82d1fb in close_pack_windows packfile.c:299
>     #1 0x562d5d82d3ab in close_pack packfile.c:354
>     #2 0x562d5d7bfdb4 in write_midx_internal midx-write.c:1490
>     #3 0x562d5d7c7aec in midx_repack midx-write.c:1795
>     #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
>     ...
> 
> This failure stack trace is disconnected from the real fix because the bad
> pointers are accessed later when closing the packfiles from the context.

Okay. So in other words we need to make sure to always prepare the
MIDX'd packfiles, but we may not want to open them?

> There are a few different aspects to this fix that are worth noting:
> 
>  1. We return to the previous behavior of fill_packs_from_midx to not
>     rely on the incremental flag or existence of a preferred pack.
> 
>  2. The behavior to scan all layers of an incremental midx is kept, so
>     this is not a full revert of the change.
> 
>  3. We skip allocating more room in the pack_info array if the pack
>     fails prepare_midx_pack().
> 
>  4. The method has always returned 0 for success and 1 for failure, but
>     the condition checking for error added a check for a negative result
>     for failure, so that is now updated.

Nit, feel free to ignore: this change feels like it would make for a
nice separate commit.

Patrick
