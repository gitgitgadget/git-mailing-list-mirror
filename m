Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF125A2A4
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932600; cv=none; b=MjrEqOQQ1fMBLeoWBe9CNc59WVQOoZ1yieIraEHQoEWMj+vD+gFSN/GaKKZqIZxjV1B0a2Hf9sdZf7qPqsoIIJsHAW6/AMN14ePiDtcvcljHXSR0j5cWrPxozGlqokINUVr0MOdtr2fGbMaCGLLtAkbJVFxcU9Eb0JKDglfVX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932600; c=relaxed/simple;
	bh=r/h0XlvO5RdD+o3hbjfiTJ/cluaIlbCmdMff1Ft6bd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RauRdJp7NXnHSewwy8HcJt+7dN1tjLrlhYxTQAuO7lRDLtB0K2O2KrrNEHL5dWHQzhiglSdb1VZpkXx5pWHVSRmeUWduqlICws5iXwMeULNo85ukFDMKu4OGCjwp1LLiE1TcSwbHoiPzgsz4hNTOeCt2lWAIBmpt7AuG8QtDRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u3y5RPuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=utjT3+rO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u3y5RPuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="utjT3+rO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EA097A0128;
	Fri,  5 Dec 2025 06:03:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Dec 2025 06:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764932595; x=1765018995; bh=mOweEOrCgJ
	CyxpqxZRVmqG4qvreT/WR806aNJzNrgqc=; b=u3y5RPuHH+UijVshxBoqG7dmfS
	ZBVKJ1gdWDBvH6B8H8LeM8gldRQWZbrNbWJ066jS+r+HTpmPrNRKgPxo99CBw6+k
	pQLkIxujY0N5j612mmLkqbsVqmoc8QrjSPL/mscGYBpj3jSmZbOh6HPwU1JSzRxg
	CAAA8bEGMWUA0SCl5bguBBdSvmgVIAg7aFcLyooY2AeZnrzq/sgSvCYRj2YSlobV
	vekPbsoooyJOaMmBSqaj/qHCy0kwkHx2lV3vRZOqFrLzHczUdwu9d7wcVE7KEcod
	mBLraT6A9EQ/RMAw0OSMjPiDGaqsmOI/8Bo8insu2Qwyg87JA9zSXgfMjQNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764932595; x=1765018995; bh=mOweEOrCgJCyxpqxZRVmqG4qvreT/WR806a
	NJzNrgqc=; b=utjT3+rOMe5MTdgy91DsRkMoPfasK2qlO0pbeO12d+/7O81svL6
	4JqitUo0Awx/Uc4jFlmfWFy+el4Q2hltuoc7xWA0a4mLH6EI+YGbUI0Uv0hmfyM6
	cOOGVZoPBmuXGObB5T4MEALj0m5YbjIK9QkpjhihhpUKr+gTh4Znj2oYy/b0LcG7
	8oKBvZT0JQ9Rg0FfDzqbpIpczaDdyNYzK2F5xq2fzeJEejjZlJNN6GYDccayv9I9
	8D/izKDDl0V+60Z1wwxrra9HbA6g4yOk3Xbv6h29/t2XrLFhr5HiFc+zKbPpZWRf
	U69MLhFOg+tCMhoqiCLBC6VPQa9zDOIdsLw==
X-ME-Sender: <xms:87syaaC_QFsLOUBopQdU052rcG0vSZ1TTDau-6RVYUa3zyMnLWXAvQ>
    <xme:87syabY9aImSVqQQlzTY2bLsoG4ODe53nkDXZzrhwDUx1e01T45-PCzUMchR5cQJB
    fNxFyXrH6h9aLazlnyxeaU_aYdP8LEF_23dkFUM9nMrf4t58_bX>
X-ME-Received: <xmr:87syaV5droPwHp9sdFVY0itBguRC4jEPsgo1K-VbUZX5KeyFZCYgEOlCt3k9A0vysZEwRNrA_gO0tIHaVNskHTqc8jQskHkXPeWoS5jvSBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheple
    ekvedvleetkeektdegjeejgeehuefffeehvdeuieethfeiiefftdffgfeghfeunecuffho
    mhgrihhnpehlohgtkhdrphhiugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:87syaUZfadVF4Zq5SJUABfcYalkd_7MOs48Lhe0KHkdqFShwHEsNKg>
    <xmx:87syacgxFEe_ORp36x2tTtsiBT5NSZEnuTFTPSmxdMt9hsEQk75j6w>
    <xmx:87syad87r8CO3l_l-uwHLIIeUaSM0sXnCNEqvA0093EYu01Mif_Pag>
    <xmx:87syafofNGRjzCKEkXic6TKbQLuhLnsnbKrPMq9SL6HVIZ-HpMygUA>
    <xmx:87syacbWe4tKTbjTE_Lizi_QVdkdfOeZGdqa4ZDaSp_MdsOYuZPvre3i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 06:03:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3700313a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 11:03:12 +0000 (UTC)
Date: Fri, 5 Dec 2025 12:03:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,
	Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <aTK77RFUvwpI-L13@pks.im>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
 <20251203211610.GA64204@coredump.intra.peff.net>
 <aTDFks3RW57Ytwvq@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTDFks3RW57Ytwvq@nand.local>

On Wed, Dec 03, 2025 at 06:19:46PM -0500, Taylor Blau wrote:
> On Wed, Dec 03, 2025 at 04:16:10PM -0500, Jeff King wrote:
> > On Tue, Dec 02, 2025 at 03:07:27PM +0000, Paulo Casaretto via GitGitGadget wrote:
> >
> > > The .lock.pid file is created when a lock is acquired (if enabled), and
> > > automatically cleaned up when the lock is released (via commit or
> > > rollback). The file is registered as a tempfile so it gets cleaned up
> > > by signal and atexit handlers if the process terminates abnormally.
> >
> > I'm sympathetic to the goal of this series, and the implementation looks
> > cleanly done. But I wonder if there might be some system-level side
> > effects that make these .pid files awkward.
> >
> > Temporarily having an extra .git/index.lock.pid file is probably not a
> > big deal. But for other namespaces, like refs, we're colliding with
> > names that have other meanings. So if we want to update refs/heads/foo,
> > for example, we'll create refs/heads/foo.lock now. And after your patch,
> > also refs/heads/foo.lock.pid.
> >
> > The ".lock" suffix is special, in that we disallow it in a refname and
> > know to skip it when iterating over loose refs. But for the ".pid"
> > variant, we run the risk of colliding with a real branch named
> > "foo.lock.pid", both for reading and writing.
> 
> Good point. I don't have a strong opinion on whether or not we should
> use an append-only log of which PIDs grabbed which lockfiles when versus
> tracking them on a per-lock basis. But I wonder if this would be
> mitigated by either:
> 
>  - Keeping the ".lock" suffix as-is, so that holding a lockfile at path
>    "$GIT_DIR/index.lock" would create "$GIT_DIR/index-pid.lock" or
>    something similar.
> 
>  - Introducing a new reference name constraint that treats ".lock.pid"
>    as a reserved in a manner identical to how we currently treat
>    ".lock".
> 
> Between the two, I vastly prefer the former, but see below for more on
> why.

Yeah, I agree that this is not really a feasible change for the "files"
reference backend. Besides all the issues mentioned in this thread, we
also have to consider alternative implementations of Git and old
versions. Those wouldn't know that the ".lock.pid" files are special, so
they will misbehave if Git started to write them now.

We could of course work around that issue by introducing a new
repository extension. But I doubt that this is something we want to
pursue in this context. The provided benefit just isn't high enough.

The overall idea still has merit though. So if we still want to pursue
it we can likely work around the issue by introducing a toggle that
allows specific callers to opt out of creating the PID files.

That'd raise the question though when we are most likely to need the PID
files for debugging stuff. From my own experience I only ever had issues
with stale locks in the ref subsystem, so if we disable the mechanism in
exactly that subsystem it may be way less useful.

If references are the main culprit one could also think about a slightly
ugly alternative approach: loose refs handle it just fine if they
contain additional lines. So in theory, we could write a second line for
each lock file that contains the PID. We do have an fsck check that
warns about this, but in theory this should just work. Whether we want
to go there is a different question though.

Patrick
