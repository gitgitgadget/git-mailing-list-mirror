Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028C3DE44C
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903960; cv=none; b=E9qMgTvzL3/zQ1V7C9i6qLzlSIlhNgZ/JpxPHOlu2nZqenDlCmyjEXN8rhc+Cjtk2h0ckV8iJgdKaR1E1G6ckw9o2E/3lEtlK/rFbJRJtKVfZjK8fsXdyHOJUKuVS+yzT6rUH0XK8+NCQdPNutdoeONbgbGyHCdxJ68m/weQCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903960; c=relaxed/simple;
	bh=OwDtRkg24JL9MQs5f7DCU1ydO2kjP51O3UmcWth5Tck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfURRp/pMcerPAOpJi0w0qVc0UdTLJ3b5SE7OhCiva3AniIOYxOtUGHszGJIZSv3rC6Q+LLSGXgnnOzqwpm4ZlhC2+67XAVEkpik97IYZRvzKTFLTTCzet4iAX0E/qnCk04Cn30FrE81qldBWySv5s8RDIEUATu2Stj6Jo7I87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bgVBQlD/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYei0DFv; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bgVBQlD/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYei0DFv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D30281D0007D;
	Mon,  4 May 2026 10:12:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 10:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1777903958; x=1777990358; bh=T0hxXPcH24
	B+czTs1ZzCUTv1kKelSWuvKgtxOdQjq+Y=; b=bgVBQlD/lzj0I4Ezfj9hPdCC3h
	PuImD6QeSqXaFVD8VWd4eOw6OPwpU9IFmidjuVftwEuEriuC8442rGbmgZO4k+L6
	aV1z3dvfubuh2/Yo8zHBceEHUS40k3IqBttk/ZgM4Nax8T43zBeb1MVVE385MGp7
	RVOnG0tbwKErdff9lSdlLE1MN+hdETN2LOvJ70JJvaYcxtPCrXmu0ScziNyyxcSE
	yWWGr/fBhPUJXdIBIbEPZ0rTusxWzS4EevbNe2WXH1cfoMBYOx2ihIq9KTEeZxCz
	8IaXj4QloAk0Xm3hW+pEN6CSN0nSM//BtydfmTNTBHWaGPgldvQh+A54YoTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777903958; x=1777990358; bh=T0hxXPcH24B+czTs1ZzCUTv1kKelSWuvKgt
	xOdQjq+Y=; b=VYei0DFvjag/QWWl18CR0dTVy8uQ8xd6uV84cMvS6V5Bg1VXw7g
	+Hf4qfG1uzqvC0PuOGJJpG+72Ow5VPBtlyZuq8KESQz0JYU6DV9dg0fIu1l/VRXA
	svYY93SC0yZJSBPlXptB3sFpR5HwzD7jL/GaIO7T4ibZfGwmesSkkRYFVJJ+1rcH
	p89rNTURb+o4rNDBERwDm96jHg5IR35krTTML1QDsg4vZQf/UyNIUXrt5Yg8rcQr
	CusulPWG2FL9C+kcfe4N0/8Ly36/JqAPy0eVdqXP7ebgXyxiin60CgryYlxRc2dR
	YXE9tEMzhgS/CiirXhtdjVN3PsI2XBQcJcQ==
X-ME-Sender: <xms:Vqn4aQ6E8k3IwV_QOvc8QxhHq8kkVKr5f749ohA051_4s20ne4da-g>
    <xme:Vqn4aY6O_Vamg79Nu5GKbMtSjLAurgNm70CgUVtwLBhmb9nfpNrN_1plrOs3ECVnr
    UaJBMPyD5iDF784aFtFc6GIlhS-lJAFWcsTMyX662UkJtiWerHc>
X-ME-Received: <xmr:Vqn4aUdU29QIUrBBMHH17HvcXSIBIXkg8FmW2st1bsznVuSCAfeGtQCGqclxgRqPn0GuWEvOK3mHKHSadYMBcEbjkLCn-J8c0k5TQAUkkoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelledthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    egjeetgeeutdefgeejkefgudduvdffueefudeiveegjedvhedtteeuheeifffhueenucff
    ohhmrghinhepshhtrggtkhhovhgvrhhflhhofidrtghomhdpghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshht
    ohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:Vqn4aUC6rssIUK3YFF8r_1IfuPKwV7X0WlnCXocBT4pznzrddw9vKQ>
    <xmx:Vqn4af8C_JQ3sZ0qzKF9kpXczQxQ5er5gbIBmgHAwOxc11e70Y6I4w>
    <xmx:Vqn4aXKuqA3tG1KrEUO6dgKEyCetQ_0fLfkwrFdUsjSgviB6FnFTQw>
    <xmx:Vqn4aQjGj5KNWD6RHmbOpkSRDkw65wM0F3UXt4YmEvhjUTd1x6PCsA>
    <xmx:Vqn4afByPV4vY3UPWuYuVRL87LXsPmyV60RRUnTf9sPCB8qcEibIjsEs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 10:12:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7625374d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 14:12:37 +0000 (UTC)
Date: Mon, 4 May 2026 16:12:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] maintenance(geometric): avoid deadlocks on Windows 10
Message-ID: <afipUq2HqJrcPvLo@pks.im>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
 <5c358919-0dcf-41c8-bdf7-912c41f77c31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c358919-0dcf-41c8-bdf7-912c41f77c31@gmail.com>

On Tue, Apr 28, 2026 at 11:01:34AM -0400, Derrick Stolee wrote:
> On 4/28/2026 8:52 AM, Johannes Schindelin via GitGitGadget wrote:
> > On Windows, maintenance_task_geometric_repack() opens pack index files via
> > pack_geometry_init() (which mmap()s the .idx files), then spawns git repack
> > as a child process without setting child.odb_to_close. The parent's mmap()s
> > prevent the child from deleting old .idx files.
> > 
> > On Windows 10 builds before the POSIX delete semantics change (between Build
> > 17134.1304 and 18363.657, see https://stackoverflow.com/a/60512798), this
> > results in Unlink of file '.git/objects/pack/pack-<hash>.idx' failed. Should
> > I try again? during fetch-triggered auto-maintenance with the geometric
> > strategy.
> > 
> > The fix adds the missing child.odb_to_close = the_repository->objects line,
> > matching all other maintenance tasks.
> > 
> > The first commit introduces a GIT_TEST_LEGACY_DELETE environment variable to
> > simulate legacy (pre-POSIX) delete semantics on modern Windows, so the
> > regression test can verify the fix even on Windows 11.
> > 
> > This fixes https://github.com/git-for-windows/git/issues/6210.
> 
> Thanks for these patches. I reviewed their equivalents in the
> git-for-windows/git fork so I'll give my LGTM here, too.

I've got a single comment on the first patch, but other than that this
series looks good to me. Thanks!

Patrick
