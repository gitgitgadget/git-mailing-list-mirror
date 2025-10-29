Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C83254A7
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732667; cv=none; b=ee1SYGWSDXhqe9j++vlCuajaCrTJzv9406z2lISzGjRCw+5XmeOeXtDNGLNbp8DZePlcSvUxb6T4vBmYAjhyALdKknLPhsPpgaK5ugCsZJ6MKtmogp0MbchMwqK7XGrv0wtrlVWnnfNTT9Wriu7bziHpcC7FZjxSDNrSKpDbSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732667; c=relaxed/simple;
	bh=PQX2cAv6mpUaUYj7mrwEW1zXY7Mtbt3VEaMaFbb2ncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEaLzMi6Ux6rmU459OPmriib76Xs7DhNc7zJHOBE17GBgCyR+qKxdkBzGnF/dbpxy3aNq3rRAK8bBa2RA617wo6YMkO9Fimm8+yvmoK6FVgellxpLeX9gRCBXICRxW5/hKWwdfbJLe7vkn4X8SzgiBTzuoFLP6MQTRrrttE/dhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDr487sO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wjALywuw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDr487sO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjALywuw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B20E1400221;
	Wed, 29 Oct 2025 06:11:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 06:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761732660; x=1761819060; bh=1cuyVMRTMo
	mLBOpbkY9d567MBvMFpVSubN/2OVqJYgg=; b=UDr487sOLAWcz96HORpXYX06Hw
	LAFm6VlyJpXeaVWSsN59X5bSqYYURKBH5LrbM0uHg1Iovo0ZwElA1XI1N4WHPuLQ
	r62+mJqKlNXDVleEaHUKdnBt5IAmN5KPVDuGNJkXspFrfZe5H0DhhYisAdbVIUwv
	3falzAS4slZakoVEIFv+F2AEJbVcINhsTt7RiuXi3O1tVOF1cQEyp+ErXNM4RGME
	RpVlAeFgYZMYF0rqiKNEcLbaDSA6G9BQeHiFomHnsoNGxqvmH61mlJqlKmQnTDVf
	9qUWurq0TWuzB1WyVUYPzUl4p7wth8SMK22Rj0s25awmZyRzIL6Oxs+BeRdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761732660; x=1761819060; bh=1cuyVMRTMomLBOpbkY9d567MBvMFpVSubN/
	2OVqJYgg=; b=wjALywuwLG0+ml+zWf5mnE4/OMr+FKAKqn4splmUZ2W9lLZYqzv
	28QCH3LfT+HqlSgz9UtKI64a9WdWDDH04JKZj/WfJPz6RePmWh+Idb10jE6u3U+f
	PGIPamSerTIVvWfkOKftevdNzv/uOB/w+kBDdmq4R/3tokM3o1KmRUWzQ7nc5k4X
	sL3jAQbJ9TY/CfbJiBa6QoUR6UwbpKgcx8skyYNbbi4CIcGys8uMnJLKw0wSIfi1
	T0BQPMTYwV8fQ45lTV3bKTew3wvN3ycd/c9ZSe+F3rCIK3q9aNMyo2e6RP2yX23e
	+dUlSxjTxqofDjAeDuzJWgsBXEgcXZOKF5A==
X-ME-Sender: <xms:NOgBaTcGiEOzFvpbNDsanQiv2g3v4qVnSs6HlvBySNCUmZV4vpnyig>
    <xme:NOgBaQPQYsYUkdE9pSromyYRs5LghJriWDHkUYnCRn3UYbixOQDyZzZ0K5aSlGtHU
    LMDtC6WwzCIBieCf3a4hv12ki5l_hvRlmejT3XEHP0-1MkwG5REXw>
X-ME-Received: <xmr:NOgBaRhRowmd9XmeiZrd6jBOFgdQsLvKdmgNIPqWy01ZjiyLTJyZdDSkvbFhisdxwFkuPqNczm2zSGy-BZDjBonqFQa3Us_yDkX8fim6nCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepshgrmhdrsghoshhtohgtkhesshhhohhpihhfhidrtg
    homh
X-ME-Proxy: <xmx:NOgBaT0lpUC8XabDdIygDoZKv44Tcw4MN1oW7udS1-QZNAsVxkQ1rg>
    <xmx:NOgBabjeQs0UsVL4kzEQFBR-LlrXshQM6KLa-Kw-j00FICQgicHsLQ>
    <xmx:NOgBaTdyyKntWztVzwA5ieIyCRbSQTYPXWhKkm_fkDFR9_GwNWsonA>
    <xmx:NOgBaekeleW-NizZm0Tnctd1fdQ7DEvWFG_brPsTbD1SmOqhOO4mRA>
    <xmx:NOgBacADe8ARBhn1k46I0c-sok4MY0tX4sWj0PRCGcFKwfXd-EvdrS22>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 06:10:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a6cb7fb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 29 Oct 2025 10:10:58 +0000 (UTC)
Date: Wed, 29 Oct 2025 11:10:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] refs: support migration with worktrees
Message-ID: <aQHoKXtrbDx6eNpH@pks.im>
References: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
 <aQBwiE-bhqcaSHG_@pks.im>
 <xmqqfrb3dnis.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrb3dnis.fsf@gitster.g>

On Tue, Oct 28, 2025 at 09:00:43AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >>  `migrate`::
> >> -	Migrate ref store between different formats.
> >> +	Migrate ref store between different formats. Supports repositories
> >> +	with worktrees; migration must be run from the main worktree.
> >
> > It feels a bit weird to single our worktrees specifically. We don't say
> > that the tool supports bare and non-bare repositories, either, so the
> > only reason why we'd have the note about worktrees is historic legacy.
> > How about this instead:
> >
> >     Migrate ref storage between different formats. Must be run from the
> >     main worktree in case the repository uses worktrees.
> 
> Two thoughts.
> 
>  * Would it be unacceptable if the primary repository and refstore
>    uses reftable backend, and a newly attached worktree to the
>    repository uses ref-files only for its per-worktree refs?  If we
>    should allow it, then "if the ref store you are migrating is in a
>    repository with multiple worktrees, you must migrate from the
>    primary and migrate _all_ ref store for all worktrees at once,
>    into the same backend", which the design of this patch seems to
>    aim at, would contradict with it, no?

The problem we have here is backwards compatibility. Right now we assume
that `extensions.refStorage` applies to all worktrees, so if we wanted
to change it like you propose then we'd have to introduce a backwards
incompatible change.

I agree though that it would've been great if we would have said from
the beginning that the worktree-specific configuration is allowed to
override the ref storage format for a worktree. If so, we could easily
convert any of the worktrees (including the main one) by without having
any impact on all the other worktrees.

But we do not live in such a world right now, and getting there would
require some significant reworking of how we handle per-worktree
references. Unfortunate, but I also don't think there's a strong enough
reason to change this.

>  * If "you must do so from the primary worktree and we convert all
>    the worktrees attached to the same repository" is the only mode
>    of operation we support (which by the way I have no problem
>    with---the first bullet point above was asking question, not
>    suggesting change of design), then would it be easier for the
>    user to use if the command noticed that it is not in the primary
>    worktree and switched to it for the user, instead of complaining
>    and failing?

I'm not sure. The question is whether the user recognizes that migrating
references in the worktree would also migrate references in the main
repository. It might be surprising behaviour if we did that without
asking.

It might of course also be surprising if you do that from the main
working tree. But I think there's an argument to be made that it's at
least _less_ surprising.

> >> @@ -95,7 +96,7 @@ KNOWN LIMITATIONS
> >>  
> >>  The ref format migration has several known limitations in its current form:
> >>  
> >> -* It is not possible to migrate repositories that have worktrees.
> >> +* Migration must be run from the main worktree.
> >>  
> >
> > I'd drop this bullet point entirely, as I don't really see this as a
> > limitation anymore.
> 
> I agree that such a limitation should be lifted, but if we have to
> say "you must do it this way, not that way", that is still a
> limitation ;-).

So with the above reasoning I'm not sure I'd call this a limitation.
It's rather a mechanism to protect users from unexpected consequences.

Patrick
