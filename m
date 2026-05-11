Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959573BB40
	for <git@vger.kernel.org>; Mon, 11 May 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484806; cv=none; b=cJ293XkCx3fAhMn/etHPhDnCmjvRui01kAvuJSqQjrRxYIwe+AwcLKos0x45YFPJbjMwLfNh8sMaR6k9ymAyl45fySmgs2tWwyTbyOt+NqqKQZmhzOng3Qoa9ypePRrXY2uwLPf4NzncWUTzGw7kEsasxM4NZNm9ZeXJMytjo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484806; c=relaxed/simple;
	bh=1t6Pk0PWvPqnrtJCbxQP+T7vklu88px8B3p4Me6H0K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaTxOMQwh210EBBcBXnVRLYqqOFLluk8fqB6t0g7p70uWXlvlPxXwdrb1D6F73n/QZSLcU+14YU+li9fi7WBEfaT4qt4MQsWuZJBq9sWMUbfg+Z2SeJ8wVtO1zcfK5SDsPwlZkZL37uDL4k7yMiFJmV9UODdtoy46Xvubq6mXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PRVZ1Q0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdA8Lb4H; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PRVZ1Q0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdA8Lb4H"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E4399EC0123;
	Mon, 11 May 2026 03:33:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 03:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778484804; x=1778571204; bh=l0NZHeT8Oe
	FkfBr6TryKD+1MAL2vkNHuzkS5dFnhLMY=; b=PRVZ1Q0FWbkqKnEktWjrmuqpjq
	l+dS3WKNfSlSScb/Dzgq5EqxlRY8bAd9xMxDuwlpyQmTHzrdBwKG5FtrodsmBapd
	G6lWgctg3OGxI+Cr2+6ow2iheWz3yHrVraxpLRKgiLbiVFH8kFI/qbs+6Szhcllz
	LinBMsklbh1XZaFAJbzvBO6JV6UDVhx7aOWkDjuu+ToWuicfiUkMBkhHSxm5Lb8J
	sAortkb7dEf+ntAJF52D9vfWObRU44BvfZMp7bl+d6Dw29oNGNwidpa2R7QB5fUx
	KOb9KXxgVg5G7xd/tHwqcIObjAS16Z88V4eGWCQ3x/jmTFDAQKAr71taJTjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778484804; x=1778571204; bh=l0NZHeT8OeFkfBr6TryKD+1MAL2vkNHuzkS
	5dFnhLMY=; b=TdA8Lb4HiKr2gRpgAFm6lfFSPBJ7TQyfye3/aFT0KZLpg3j8+No
	oqUUxGC5cDXjR8pee1aumaANjg8SDbI2PyztfzgyGFku7HxOz1VgjcjZ1fayKLxt
	dbWkpzLwyw0zTlmO7FqIWrSGwGCFQzsMHzVGTrub+wbJAEEAuzUUrBInOzAL7Buc
	eBa9zoFWlgmtlF6mSa+ljXlFZXBSZUUPg4wyim3Vh3wzw2h3AdSeHPV5fJh8xxQ1
	ZErMsOO4U3wHU2SjG+46ju4WscFiEexhzYtjcr0S1NjyLpyjjNb8zZgQrOy0K1OV
	s8HaiIPlgS756ZmtuXpqqc3ACBYJuZi/qMA==
X-ME-Sender: <xms:RIYBao6G-HSUAhRunefq1mDRIF4zQUiYbuTKuRpD-B2ggrHRIs204Q>
    <xme:RIYBahXWbvfxjceN2fHSe3aBsx9g_Wtlqqv3dljDPpy_oph5i8x3XExus9hJVOZxJ
    OZ-GFn25jNfeSTZ4iFOlcEh2fz36PEnRsxUETU-e38HoqJHzuGWyA>
X-ME-Received: <xmr:RIYBak0NYrRiLhJGX1Y1X7xHyNCnH3IKSBb0JVecT9Il0zfVYEL8Vm9EAb7gaZvulEyUxjDlKBcTLqLd-VKIc5RrUi4eIrkcvhHV96So6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvrhhgse
    hthhgrlhhhvghimhdrihhopdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:RIYBam1beddKit1h-giHWpwsluHExBum-OvyQgGYh7mJzHz1wHIKbg>
    <xmx:RIYBav9Wrf_EWXpUoIHE7qN-LT_bJIBYIZAs1wUzD8cFJoeLwnvRuQ>
    <xmx:RIYBar2lnPhMoR8UBZbNWcqazzbLOkmetGeeD9tCjWvX8dcVgyUWSA>
    <xmx:RIYBak9pqbUvJ2cUID9qqe1Ct0CpNyJS8GSTBey4Kgx5UWTOFG1LHw>
    <xmx:RIYBaqh3E4vSzJl-c2BL5MumBLgMISdEVc9qOlQcdMnDtx8fwxFl4X4i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 03:33:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9b276e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 07:33:22 +0000 (UTC)
Date: Mon, 11 May 2026 09:33:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Joerg Thalheim <joerg@thalheim.io>, git@vger.kernel.org
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
Message-ID: <agGGP39V3_mZl7mp@pks.im>
References: <20260403100135.3901610-1-joerg@thalheim.io>
 <adYvSZeN0ZVqwRhi@pks.im>
 <xmqqcxz2vfpa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxz2vfpa.fsf@gitster.g>

On Mon, May 11, 2026 at 11:32:33AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> This bites in practice when running `git worktree add -b` concurrently
> >> against the same repository. Each invocation makes several writes to
> >> ".git/config" to set up branch tracking, and tooling that creates
> >> worktrees in parallel sees intermittent failures. Worse, `git worktree
> >> add` does not propagate the failed config write to its exit code: the
> >> worktree is created and the command exits 0, but tracking
> >> configuration is silently dropped.
> >
> > This very much sounds like a bug that is worth fixing independently.
> >
> >> The lock is held only for the duration of rewriting a small file, so
> >> retrying for 100 ms papers over any realistic contention while still
> >> failing fast if a stale lock has been left behind by a crashed
> >> process. This mirrors what we already do for individual reference
> >> locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms,
> >> 2017-08-21)).
> >
> > Famous last words :) Experience tells me that any timeout value that
> > isn't excessive will eventually be hit in some production system. Which
> > raises the question whether we want to make the timeout configurable,
> > similar to "core.filesRefLockTimeout" and "core.packedRefsTimeout".
> > ...
> > Honestly though, I'm not really sure what to make with this. We could
> > of course also add some validation that the configuration we want to set
> > hasn't been modified meanwhile. But that would now lead to a situation
> > where we have to update every single caller in our tree to make use of
> > the new mechanism, which would be a bunch of work.
> >
> > And adding the timeout doesn't really change the status quo, either. We
> > already have the case that we'll happily overwrite changes made by
> > concurrent processes. The only thing that changes is that we make it
> > more likely for concurrent changes to succeed.
> 
> We haven't heard any response to these points raised in the message
> I am responding to.  Should I still keep the patch in my tree,
> hoping that a responses may come some day?  I am tempted to discard
> the topic as it has been quite a while since we last looked at it.

Same here, let's discard it for now as it can be easily added back in
once a new version was posted or the feedback has been addressed.

Patrick
