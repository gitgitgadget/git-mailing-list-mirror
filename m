Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6C22A4DA
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173261; cv=none; b=tkaovFl8mfmk6tgSGFOJfL4943ysx0KJbj2sflTb3IbJWk54KZUhUf8267tFsuNrtyz8m5p37rWQMe43dM7eVj751KPQz1dPRA/5VsUv0pLDgswjZ3ymPjSPhkxBq0zfxRP1ZS5zvAarOiYa1NDEb72JslNkMb/q0aNrSSd4TdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173261; c=relaxed/simple;
	bh=hX7XIijj9766EJm2axJy7x1VoO70zh/64G8KN5VZraE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHlxSAg6t0qyoQDiLnzw9YBCETOA1mHAEkP+peCK9dXRnMuBVfljFiOZfnZm73z0LrG8dVQY6LPvRf9zpTJwh2h+x91AEOcRF0QnHA6D3YFwCg0P4tY7XzH+dviSYSniOBWJJsfj/tnPCrwxu8TUBXAUL3a5IsjgUgoeLburo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tfbyyQ+a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dvPom6tf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tfbyyQ+a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dvPom6tf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 616E91380511;
	Fri,  2 May 2025 04:07:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 02 May 2025 04:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746173258; x=1746259658; bh=Em/5aQVERH
	GmovKR+cWQeWF4F9awE1M3biELmQjwQxE=; b=tfbyyQ+avxYP2uLPGVRTFl/6Bs
	zB+wmnQ8OXvOYK5VCmTPRttd71CLz9EECjrdEc/EK+4EmGlVQgHuYGeZW3K8TVLb
	VGX/lKCJRkyab4kRI/AxUxUznF4ElpSwOXgC+AtnmL1GA/tmdu9vAeasHnFYWZlK
	aCuDItG51/beGKom5ajtokghoCUlOknmBQ+Lky/HZ4cFzH6CR6TYMHfxTQdNGwGo
	Dz0DMrstrCqAizh0RzvLZ3If/VXGxXwLsR+3IpW0H/5AgZVrV7OBwcHdfnTlS1v6
	IRs6YQAhfpSVDoJtD9pI162cdnARpUv6U/eo6shzZdbkLJNW7uDCZ+lMOqQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746173258; x=1746259658; bh=Em/5aQVERHGmovKR+cWQeWF4F9awE1M3biE
	LmQjwQxE=; b=dvPom6tfR2L+6zB6MeAw1FQXLGsmvgjLZamZXcPDaFprx2UKvHF
	5qqUaRjHNGLYWfJTTSQmxRwgwhi4GK/LxZ0Gq4UwgqMvBF2tcpCgiLAxDJMUtbvr
	R0qls08z8LIDsIZRRwviddv9J3YgqEn4FsPHbEJoC2UETc1+GW/wQbRgHcUQ94Bf
	EP3ShdB++5jrTgF/tHzOMDIkHPFpP5DvZSfUd/OBxTMTWhequexKo3Q8WrUEdt3E
	p/XaNe1aelHMmNhMwtmJHptNleg/HadluZ5r4p/NYnzsnwyS9cTHNgX4wym0orRY
	3pYNSbiyrj7PiYssOCB0WmcRqcJPchLDCrw==
X-ME-Sender: <xms:Sn0UaKIsFZrvaAa8cBhfcvbOY_BNfFnyYujaUw_UYC5NmDsZ5PeOAg>
    <xme:Sn0UaCKpa4rQl-ZiMuSnj0-erLnxeAn8wgjykG88H_XGPTYmFwlzALXVfug79b8Se
    79bLJl3IjktDGLcHA>
X-ME-Received: <xmr:Sn0UaKvngwiVYWzmODlxdErN2Btexi0PavWi5-cpAgFEJbeKNt32OHP6IIoietRCn9FUwGllrdFk4p7zDL4D5RBtV3N2lADbQsmwafHc2bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepkeeftdffvdeuffeigfehgeduveekgfeiheeutdef
    ffehveefleefffetieetfefgnecuffhomhgrihhnpehrvghrvghrvgdqghgtrdgruhhtoh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:Sn0UaPax1EKdXpd55xZEJRBb8QR1uXCN7pDYK0XHeio0qtI1j5uTyw>
    <xmx:Sn0UaBaOfiug_DjS8tPcsAu56IgIZ9cACzk4GwhvXmUO0aKn9LphiQ>
    <xmx:Sn0UaLDfuMlyHH7wmhDkfgPbFjPBfALZfIQLqdy_SFX13P--bDCrug>
    <xmx:Sn0UaHbvjEX54IEZlHerKtjrpAuLQZaF0RN_TGkmKZn8o8gs0CQdXA>
    <xmx:Sn0UaF0Tl4FxkrxTUx2Dt3X__5xSAV_7r2GTvZZZrqixL-75HA_HI70_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:07:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0bce8761 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:07:36 +0000 (UTC)
Date: Fri, 2 May 2025 10:07:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/8] rerere: provide function to collect stale entries
Message-ID: <aBR9R3PxSCuLON6G@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
 <20250430-pks-maintenance-missing-tasks-v2-6-2580b7b8ca3a@pks.im>
 <xmqqy0vh1t96.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0vh1t96.fsf@gitster.g>

On Wed, Apr 30, 2025 at 09:58:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We're about to add another task for git-maintenance(1) that prunes stale
> > rerere entries via `git rerere gc`. The condition of when to run this
> > subcommand will be configurable so that the subcommand is only executed
> > when a certain number of stale rerere entries exists. This requires us
> > to know about the number of stale rerere entries in the first place,
> > which is non-trivial to figure out.
> >
> > Refactor `rerere_gc()` and `prune_one()` so that garbage collection is
> > split into three phases:
> >
> >   1. We collect any stale rerere entries and directories that are about
> >      to become empty.
> >
> >   2. Prune all stale rerere entries.
> >
> >   3. Remove all directories that should have become empty in (2).
> >
> > By splitting out the collection of stale entries we can trivially expose
> > this function to external callers and thus reuse it in later steps.
> >
> > This refactoring is not expected to result in a user-visible change in
> > behaviour.
> 
> I have no objection against the goal of allowing "git maintenance"
> drive "git rerere gc", and as the primary author of this code path I
> do not see anything wrong, in the "correctness" sense, in the
> updated code.
> 
> I however am not sure if "count what we would prune, and remove only
> when there are too many" would work well for this subsystem, because
> I expect that the cost to enumerate existing rerere entries and
> check each of them for staleness would be the dominant part,
> relative to actual "rm -fr <rerere-id>", of the cost you are paying
> when you run "git rerere gc".
> 
> And if my suspicion is correct, all this change does to the plain
> vanilla user of "git rerere gc" is to have them pay the extra cost
> of allocating and deallocating the list of names of paths in string
> lists.

Yeah, I think this concern makes sense indeed. I was a bit sceptical
myself whether this is going too far. Maybe a simpler solution would be
to just count the number of directories in ".git/rr-cache", without
checking whether those actually are prunable?

We could also adapt this to be closer to the original version, where we
only verified that ".git/rr-cache" exists and contains at least one
subdirectory. This can even be combined with the above approach if we
set "maintenance.rerere-gc.auto=1" by default.

> We need to see some performance measurement to show that the we pay
> for collection and counting is a lot smaller compared to the whole
> pruning operation to justify the "auto" thing.

Hm. I guess ultimately the answer is going to be "it depends". The
performance implication on Windows is going to be quite different
compared to the performance on Linux/macOS.

In any case, let's go with the simpler model for now. We can still
iterate as needed if we eventually see that the heuristic is too dumb to
be useful.

Patrick
