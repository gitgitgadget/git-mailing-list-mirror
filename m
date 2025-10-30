Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616E1E2858
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806253; cv=none; b=MxB9Umv4q1blJSP+e5n8rPZXbQQifiwhACyiJZd5hetLuxt/JIBLgPqP+FAr9sx37jAcNMfBACFi9H9VIUlysIJLAT+oxZM6qHbZN2UU3XlirTz8MKcgfXAV8T3TyjMeCDLEZMJYJEJzAJGoebS+16PlYwKAI9rsk1b2XNgSGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806253; c=relaxed/simple;
	bh=BDquwKx93S6bDbmegDlAEQ19ZU9VaEVOMS0wi67qvBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+1ez/OBSgSwVdE0MuuFGXuEGfpiUifo/PasLjSTSfNcjH7RkohYTkQBitOlibdkyi74Ec0/coedutzJLXqQ2REvt66ZXLMgM58GflbdtV/4V779K1K9EolTtXYc3FK3gbUIKnJHy/B0BaEoppf9qvRpgga0ucSBZi2JO7tVRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IkPg1xWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFrbyD7t; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IkPg1xWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFrbyD7t"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB3A714000BE;
	Thu, 30 Oct 2025 02:37:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 02:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761806250;
	 x=1761892650; bh=sTKVycGbAr8AAb4Y7SeledodxfmQe28FH/q6MAOoIqw=; b=
	IkPg1xWoB7G9KZRtUR9ZQrlreT+rj4i84e1hlVNR74sRbtsiXH6S/nQr33jyOOai
	WLNU9j/3gK5DHsq4r0Br4hPG1UKDTXM5OW5FS5fyLti8ZcaIN/ZTgrfFOvss1BUo
	UWJi4p1PqZHQSRyW6kHnmPrVJ7LY1Lpa24/AP9SXypV8hzNI66BJ6lg6PyxyPjLF
	7maerquDX7AtVZVmYRmWVWOmhqopicsaBO7/aNz0hzqsPMC9rBMBM+Wgu4iNrtJO
	T/lR3I4AP0xmMlYx5auU3xL8Mql2SBh18RS/IjSTLSEdQqPYcEYxpEkTK5r2UdNC
	SR7R4pDNmyWpgAfqYM1vZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761806250; x=
	1761892650; bh=sTKVycGbAr8AAb4Y7SeledodxfmQe28FH/q6MAOoIqw=; b=Q
	FrbyD7t+vxbLoJwKh/Rlb4njH0yvab4HE8SQXE+HZt1waERPlyOH+3lVKEsgBpE4
	HsJSG1cgkfdM07dWzFFKzThcFuayr2wJefeXbNCyz29nvCb/s6WhaCwKvvRDj1+V
	KE9VAvJoKNnXYol7D+zmlqEDXd9gQfd2FkIjawFmlKBPya9caS++XrnsLxXU6jc9
	S6n7aHIfUCihwy6ztMMFDM7c/ZJZZFJ3BBJ2c6xxOskYAqP5vX7+LruUwfmiGpVK
	Ql0GmlSWFDi17BW+ulGn7ygMXuu8JqLrtDaN362gNONtag2c2t33cxV6Gazi32Hc
	+pQpPOoPL0bkcifzuAHvA==
X-ME-Sender: <xms:qgcDacSsYDxb0xya-tyoXwSy_Pb-uyL1hsgXOxjRWecMS_imsd4pYA>
    <xme:qgcDaQqOPuhFZWGh-9gMIlqKVsvPM1zXdpyq9lRjJtJyzc3vmSvufqWXFpz9PbLnZ
    1djsHzWNByVpgeJxBvoP_f8GGgxFYmW1MhwvCEEinjDYXevs6CVgg>
X-ME-Received: <xmr:qgcDaSIJilbaoX_IKit8U0fUj9WAZ2y_osGLUg1nrj391ugJJHr55QCHTqi2kWeHjcxlc8razKwgcjw_DmUMbCbcRqyEXEQ0suQ037kDMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehsrghmrdgsohhsthhotghksehshhhophhifhihrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qgcDabqZ80khOFWnpgu5J1SC2LKizMmerv-hRKejWCU5AhjH-K_ZmQ>
    <xmx:qgcDaSxNY5FGusfA_p9Idq4KW-kV7jAgrPjDECerTlcnMaCCOEAJKA>
    <xmx:qgcDaXO9KW_abgmwZiuGMMxVj2AwC1TEf1sGzMTrEx4e9nAJs-CSSg>
    <xmx:qgcDaf5DOIvnTDQVbK4LSbyRMA3MZK8ROulK1Eq3chBGGbsPTC8TAg>
    <xmx:qgcDaYKDmEIT9HqrxhgCvNUfknYsIpz3TCk_e5aIi4ngWg95l5rrB0yz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 02:37:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe929c07 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 06:37:28 +0000 (UTC)
Date: Thu, 30 Oct 2025 07:37:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Josh Soref <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] refs: support migration with worktrees
Message-ID: <aQMHpfwZs2eqRAwS@pks.im>
References: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
 <aQBwiE-bhqcaSHG_@pks.im>
 <xmqqfrb3dnis.fsf@gitster.g>
 <aQHoKXtrbDx6eNpH@pks.im>
 <85d6fdcc-cee3-448a-8bda-72791f342be3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85d6fdcc-cee3-448a-8bda-72791f342be3@app.fastmail.com>

On Wed, Oct 29, 2025 at 12:33:15PM +0100, Kristoffer Haugsbakk wrote:
> On Wed, Oct 29, 2025, at 11:10, Patrick Steinhardt wrote:
> > On Tue, Oct 28, 2025 at 09:00:43AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>
> >> >>  `migrate`::
> >> >> -	Migrate ref store between different formats.
> >> >> +	Migrate ref store between different formats. Supports repositories
> >> >> +	with worktrees; migration must be run from the main worktree.
> >> >
> >> > It feels a bit weird to single our worktrees specifically. We don't say
> >> > that the tool supports bare and non-bare repositories, either, so the
> >> > only reason why we'd have the note about worktrees is historic legacy.
> >> > How about this instead:
> >> >
> >> >     Migrate ref storage between different formats. Must be run from the
> >> >     main worktree in case the repository uses worktrees.
> >>
> >> Two thoughts.
> >>
> >>  * Would it be unacceptable if the primary repository and refstore
> >>    uses reftable backend, and a newly attached worktree to the
> >>    repository uses ref-files only for its per-worktree refs?  If we
> >>    should allow it, then "if the ref store you are migrating is in a
> >>    repository with multiple worktrees, you must migrate from the
> >>    primary and migrate _all_ ref store for all worktrees at once,
> >>    into the same backend", which the design of this patch seems to
> >>    aim at, would contradict with it, no?
> >
> > The problem we have here is backwards compatibility. Right now we assume
> > that `extensions.refStorage` applies to all worktrees, so if we wanted
> > to change it like you propose then we'd have to introduce a backwards
> > incompatible change.
> 
> I don’t understand the motivation or use case for supporting different
> backends for different worktrees. But Junio would have to explain that.
> 
> Maybe the motivation is this weird (from a user’s perspective) limi-
> tation that you have to run a command from the main worktree?  Okay,
> that’s strange but you get the error and switch to wherever the main
> worktree is (that the error message hopefully helpfully provides you
> with) and run the command there.  Then you forget that weird thing five
> minutes later since this was a one-off command.
> 
> >
> > I agree though that it would've been great if we would have said from
> > the beginning that the worktree-specific configuration is allowed to
> > override the ref storage format for a worktree. If so, we could easily
> > convert any of the worktrees (including the main one) by without having
> > any impact on all the other worktrees.
> 
> As a user I don’t understand why that is a great thing to have.

I am commenting more from the developer side here. In the best case the
user wouldn't ever care what ref storage format they use. We simply pick
the best format available and the user lives happily ever after.

But from a developer standpoint it matters. If we had per-worktree ref
formats we would for example be able to make the ref migration code a
lot more robust, as we could now migrate worktrees one by one. In the
current situation we basically have to migrate all worktrees at once,
and that significantly increases the risk of the migration going wrong
at any point in time.

> >
> > But we do not live in such a world right now, and getting there would
> > require some significant reworking of how we handle per-worktree
> > references. Unfortunate, but I also don't think there's a strong enough
> > reason to change this.
> >
> >>  * If "you must do so from the primary worktree and we convert all
> >>    the worktrees attached to the same repository" is the only mode
> >>    of operation we support (which by the way I have no problem
> >>    with---the first bullet point above was asking question, not
> >>    suggesting change of design), then would it be easier for the
> >>    user to use if the command noticed that it is not in the primary
> >>    worktree and switched to it for the user, instead of complaining
> >>    and failing?
> >
> > I'm not sure. The question is whether the user recognizes that migrating
> > references in the worktree would also migrate references in the main
> > repository. It might be surprising behaviour if we did that without
> > asking.
> 
> On the contrary, as a user I think it mattering what worktree I run this
> command from sounds very weird.  (But again I can tolerate it requiring
> me to run it from the main worktree if there are technical difficulties/
> limitations.  But using different backends for different
> worktrees is very weird, again.)
> 
> If I run `git gc` I don’t want it to do different things based on what
> worktree I am. I want to operate on the repository, and the repository
> is the same no matter what worktree I am in.  The same principle applies
> to this command in my mind.

It does though :) Only very slightly so, but for example maintenance of
references is dependent on the worktree you are in. We don't maintain
references from other worktrees. So it's not really a new thing that I'm
proposing here.

In any case, I'm happy to change my stance if the majority of folks
thinks that migrating the whole repository from secondary worktrees is
fine. I mostly wanted to avoid that operations that the user perform
have a wider blast radius than they understood, but if everyone agrees
that this is a non-issue then I don't mind much. It's only going to make
the implementation simpler.

Patrick
