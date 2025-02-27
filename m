Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C24226D06
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648153; cv=none; b=JzDGMd38DyrDsuRSOQckpqSn1kQrwisuuV2micgvG1czggW9GWEvQ53s3M0tJniUVCsRS2P+zRdJ8AqzCvqAb/3H7E6ThSoxZvMiEetSCF7D0hH6CHSCWo4Y44OKHW79Uz+jVjKtgnsxpGNuXw15sXPC6wbKtBho+LcmqBOUJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648153; c=relaxed/simple;
	bh=djTwzbiVcFVHZPUiLLd2HAG2ZONJHpUnhoemvhOPH7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD4Trlr76KYW7YleR626z2hthfJhEpHQehnF25X3h/pHkRT6pLBMURCut0Vi0eMMy/e86KciB0ZzYl/9f3UGdYSYrWoHhHAhdXQbpBItWQfrA34jcPH90LuPjGvn19AGmDzd5xCuXLn99kLNrY4fiBxi8OfO4zNJFfthuUDImDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AIWTmAp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ql3LrFci; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AIWTmAp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ql3LrFci"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C17325401DC;
	Thu, 27 Feb 2025 04:22:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 27 Feb 2025 04:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740648150; x=1740734550; bh=m7c2xs3jUy
	G/LZFK8Ni85LwDEGOMlPOPBLi2f2vAH0w=; b=AIWTmAp51r6K2URx7hfnDgrhey
	IaqcHMML0neCZAlIJYa8RqQLP+bb7yS+JItXiiRq29251SsCneZC+nzwnikNm3mO
	T6JRsd9VitIYI25on+Ck21bEua2TmDCEagN+SgX8Pfy+4RYMrPDVFJZ7xQi0X/9M
	pvTLduGKZPi+fo7ynWbpfrIKGCj4kmcNXigoyNmCMkKoEcKBgrojhoY6n/rLW0HB
	79aSTS5YFp534CX2cMGyXKaJGZZWrN32/MH2pr5wvXZReThH74Ei0pYRP+J6ro1k
	G4JuZvdrWsOkzlHWfp2h4NdNV+l+dC97o+KDiyTKKV7SwhqaBNR7Ag2k06mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740648150; x=1740734550; bh=m7c2xs3jUyG/LZFK8Ni85LwDEGOMlPOPBLi
	2f2vAH0w=; b=ql3LrFcihH4X5O26SK68IF32boExwmjLHmu1JcB9gQXtn/Y02rM
	bODpBb93tSfcpn78/EDGn+Sbem416jdhBP5yFrpL6En+Op3t7MOQ6PlgfRlaH+zJ
	uamgkRfarXNsvfbW1zIzUqReeX0cBbW5mj0kRsLgr6KF52JElHfFJdjuEiRzny8G
	2q7HR6sSwxKJuXBBChn8Hh4ne/Nq4PIO6L7FVMAtURpIVfEJ/eEpnQBtLRYQ8Gwe
	LjQuy8PWjCcYPCNfD+MAxs3xdKzUf/UX+vm61pdlWWfINsLErKenMydxT+WMig/x
	zTlKUwDEQgIYz0jR09D+wqTWitQbL6Wvd/Q==
X-ME-Sender: <xms:1S7AZwDcrICe457XeWoTt9h9UKunE1dW_lR9GWcJ1K3-nAzNQn14kw>
    <xme:1S7AZyjINy9jGaIGSca2I-S8IsV8IJ6C8sbtt2l33-OkQ-jjiR4T0KVBrHzCdqygB
    tdRkSc_ts5EsuPihA>
X-ME-Received: <xmr:1S7AZzmB1GTD_LXWeLavKaKAE_qWRNgwOJIJhAx6i6b58GvWHX__ppHyNAvBeEPiilAlm6ZySIVMGzhwp0_jK4WSAgji4Dmb7aB5OyV17N3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopedvtddvheesuhigphdruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1S7AZ2ynA66aSXMrdON3BsCH675JIePFb-BT14xp7nBXA8POqJVxEA>
    <xmx:1S7AZ1QVzZsb_mlqRwFy7_pcOa6tlS5jkApCBPVbnWg7EXU6V8Pglw>
    <xmx:1S7AZxYp0plJgMEWNcSthrlUwX1zQeHTGfJHvQPx4Oe0sXOx4DEPNw>
    <xmx:1S7AZ-TTSrajxL5puDu8lVxuUC-VTvDWAgHOfoflUuAdBL7-EANfUw>
    <xmx:1i7AZzN7JYqwLb94f4qnzN8VcVIHlQ4DwiUEji-L0I3uDeYyhNhZJ4Ey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:22:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da4fb116 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 09:22:27 +0000 (UTC)
Date: Thu, 27 Feb 2025 10:22:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Markus Gerstel <2025@uxp.de>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
Message-ID: <Z8Auzjw29t91tEuq@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <xmqqikow9o5d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikow9o5d.fsf@gitster.g>

On Wed, Feb 26, 2025 at 05:23:10PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this patch series introduces a new "reflog-expire" task to
> > git-maintenance(1). This task is designed to plug a gap when the "gc"
> > task is disabled, as there is no way to expire reflog entries in that
> > case.
> 
> I think in the longer run, "maintenance" users should be able to
> treat the single ball of wax "gc" task as a mere short-hand to
> invoke a set of often used maintenance tasks, and we would want to
> break down the component tasks grouped in it and make them
> independently available.  This is a good step along that journey.
> 
> Are there other things that the "gc" task covers that are not
> available elsewhere?  "git gc --help" suggests there are things
> related to pruning (unused?) worktrees and stale rerere database
> entries.

These are more gaps indeed. I'm happy to work on them once this patch
series has landed. I don't know about any other gaps.

> Another thing, how much control do we want to cede to the end users
> the choice of tasks and order of running them?  When you are
> expiring stale reflog entries and repacking the object database to
> discard unreachable objects, it would only make sense to do them in
> the order I just said.  We could leave it up to the end users, but
> that may be doing disservice to them.

This is a good question. From my perspective, there are three classes of
users here:

  - Those that don't care and don't have special needs. This class of
    users is unlikely to tweak things anyway.

  - Those that aren't deeply familiar with how Git works, but who do
    have special needs e.g. because they have huge repositories. This
    class of users may need to tweak configuration, but we should give
    them an _easy_ way to do so. Configuring individual tasks ain't that
    from my perspective.

  - Power users that are deeply familiar with how Git works. This class
    of users may even want to tweak the order in which specific tasks
    run.

"maintenance.strategy" exists to cater to the second class of users and
allows them to configure the high-level strategy used to maintain repos.
I don't know whether it's honored by `git maintenance run`, but I think
it is (and if it's not it should be).

That to me means that the configuration for individual tasks for power
users can be as flexible as possible, including configuring the order in
which tasks are run.

Patrick
