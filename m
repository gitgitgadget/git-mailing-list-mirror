Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E6215717
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721697; cv=none; b=KgyILVWMwr68BEQB9L/WTRJaLucjiZ5yvZUw21/srXAgmVxF9FNX3DSOui3VORPj0ZsCcf4IHr4GJqT1635OZz6MgyjhGJNUFlBrvFpguvdAp9bdjXwZKnhmJ45te/Pn7m4UCkMfBL/HAPlvzPDftEbBAUJkXNk7S/9ODjPKD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721697; c=relaxed/simple;
	bh=ecELL2RajBBKRI56TCXYDoIv8hIm+SEoIpLhk89ejko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me6KzfkrjeF0Tp64MKILs2JmsXmd9qE4MC/HeEcw32VNgzryVelOgzBQvqRvmB3Wbjgi7q3yplnaL0GnbKHbu3F9CIc5U/jCWCNgqhoVcVD0PAG4lYa5l1FZRCK/ealOVkSO4ZgLeqyJwGYrcSyChVNael6mm3eNNuwOiCEH9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gT0OSXAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wZirgRqT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gT0OSXAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wZirgRqT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AA9225401E0;
	Fri, 20 Dec 2024 14:08:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 20 Dec 2024 14:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734721692; x=1734808092; bh=GDsW/JBNQ2
	1Ls17nW5ZsxBZaz4UnFuurhNSk4ju1I2w=; b=gT0OSXAnPZahzpB2OR03BeH12h
	y1iRdO/K6T7JQWDRmx/dU92Jng5YDikhNUd59rzgPjgGk18eU21eZXXeVrbdTqIc
	T8PTgjZ4KDQ3l03Jv3yQlxtKPKb7VP7VfZESr6b8oJ4QmJyyomBPP5btgXvSXRVQ
	v7o4wOsbAnogD3jBT5tDsbEcwU7vYm1hAr0JvmtstXBQ8QIuv3jIgyJk5HWeO8lX
	jadhskH0LC59Fuh1g/LPwcqdhqSI32CV9e8X1KalI1qyWWqmbub5QMc5KNsbKu3l
	eFUyPvBqYrD3yNm5liDRzkzS6kxBr0FLg1gxDRhrwb8q+9IaZ9667EQfIDmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734721692; x=1734808092; bh=GDsW/JBNQ21Ls17nW5ZsxBZaz4UnFuurhNS
	k4ju1I2w=; b=wZirgRqTkN3dncnSMjwTFy+Huc8yHDxFVLNBTkhTxl7VtO+Yiwl
	FeGyeRG7pdgdB8MxiG/6RuucOxm7KeCKWakoXoHYZaNaskDLU+Z6cc575/DNIe8v
	e6X+0RAuotYMLtZwNz5YHtptKNJq5hipqw29O/Zu2xCLMna3g21JXnLGiicQ8hnr
	B4YOMlhkU6Y+sTbDgNpBfVI+UyFBiWFiskZI/m6GmrbETJUclclgt10Ru/NvT3OG
	DefHcAPOm7qGn8DxvuP+8VEoO2ElOofZBByLAcdKD5GAY8RNyRBqnRR486YIWtkv
	bF4LT2s4xl5ekyHmrwEUbqRTS8xb8ey8LvA==
X-ME-Sender: <xms:nMBlZzLuBlFNarAcO7tch05DaAzj8fgXFNrDBi5XkA5S8VeLcIQy9g>
    <xme:nMBlZ3JzAvTZT7oIvferKyIArZmTy_-o9GvbC5HSghhKOtumJnbe5TwVZuKJiJsxv
    EFEp3mwOIf5OByJdA>
X-ME-Received: <xmr:nMBlZ7vrO1nTFXHsHhlw5U0DpZ35TrRIxzEnGry9_YJE2mWrm7g9uA-whLYLS7zWvd7FBCVdBbSebncgN5x3LNPJf8N8OSdNTTop0d1YHwtesso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:nMBlZ8bMlJNX4Ng-RAPDbGeWfoSCrDyQ-wWYkdboMnA78kEaK3F_Vg>
    <xmx:nMBlZ6bYID0zLG3z3C62Ah8G7qHe7iaLHYvqAeWfdRW-K0VIQGENdg>
    <xmx:nMBlZwD_j7fLUf-9-hIXzWRiIk3_kkCzgy-39hqaL1sFM8pM4_vcxA>
    <xmx:nMBlZ4YkBw7Nu08IsiFXCyo2thGrkmeEtYrtMuaufkItVzSxSZKbag>
    <xmx:nMBlZxV-6hRzSJXiQQ4Wvb9xCqgckb_JXVn8CzfsmX-K56nqZwGMAq6r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:08:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a64e186a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:06:15 +0000 (UTC)
Date: Fri, 20 Dec 2024 20:07:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <Z2XAiDC4pJ9OjTpC@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
 <20241220175136.GA203033@coredump.intra.peff.net>
 <Z2WxIRcV0LOvx6OX@pks.im>
 <20241220182427.GA213015@coredump.intra.peff.net>
 <Z2W56ux3mLnfJ43Q@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2W56ux3mLnfJ43Q@pks.im>

On Fri, Dec 20, 2024 at 07:39:38PM +0100, Patrick Steinhardt wrote:
> On Fri, Dec 20, 2024 at 01:24:27PM -0500, Jeff King wrote:
> > On Fri, Dec 20, 2024 at 07:02:09PM +0100, Patrick Steinhardt wrote:
> > 
> > > > Is there a case you found that doesn't work?
> > > 
> > > Yes:
> > > 
> > >     $ make GIT-VERSION-FILE GIT_VERSION=foo
> > >     GIT_VERSION=foo
> > >     make: 'GIT-VERSION-FILE' is up to date.
> > >     $ cat GIT-VERSION-FILE
> > >     GIT_VERSION=foo
> > > 
> > >     # And now run without GIT_VERSION set.
> > >     make: 'GIT-VERSION-FILE' is up to date.
> > >     GIT_VERSION=foo
> > > 
> > > So the value remains "sticky" in this case. And that is true whenever
> > > you don't set GIT_VERSION at all, we always stick with what is currently
> > > in that file.
> > 
> > Ah, right. Even though we have a recipe to build it, and make knows it
> > must be built (because it depends on FORCE), make will read it (and all
> > includes) first before executing any rules.
> > 
> > Something like this seems to work:
> > 
> > diff --git a/Makefile b/Makefile
> > index 788f6ee172..0eb08d98f4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -596,7 +596,12 @@ GIT-VERSION-FILE: FORCE
> >  	$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" GIT-VERSION-FILE.in $@ && \
> >  	NEW=$$(cat $@ 2>/dev/null || :) && \
> >  	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
> > +# Never include it on the first read-through, only after make has tried to
> > +# refresh includes. We do not want the old values to pollute our new run of the
> > +# rule above.
> > +ifdef MAKE_RESTARTS
> >  -include GIT-VERSION-FILE
> > +endif
> >  
> >  # Set our default configuration.
> >  #
> 
> Oh, nifty! Playing around with it indeed seems to make things work, and
> it's simpler than what I have.
> 
> > But I don't know if there are any gotchas (I did not even know about
> > MAKE_RESTARTS until digging in the docs looking for a solution here).
> 
> Good question indeed. I was wondering whether Make restarts at all in
> case where none of the included Makefiles change. But it very much seems
> like it does.
> 
> The next question is since when the option has been available, as it's
> quite, and the answer is that it has been introduced via 978819e1 (Add a
> new variable: MAKE_RESTARTS, to count how many times make has re-exec'd.
> When rebuilding makefiles, unset -B if MAKE_RESTARTS is >0.,
> 2005-06-25), which is Make v3.81. Even macOS has that to the best of my
> knowledge.
> 
> It still does feel somewhat hacky in the end.
> 
> > If we can stop including it as a Makefile snippet entirely, I think that
> > is easier to reason about.
> 
> I very much agree, but it's a non-trivial change. I'll leave that for a
> future iteration.
> 
> I'm a bit torn now. I have a solution locally that feels less hacky, but
> it requires a bit more shuffling. If the eventual goal would be to get
> rid of the include in the first place it feels somewhat pointless to do
> these changes.

Okay, I did find an issue where it does not work:

    $ git clean -dfx
    $ make GIT-USER-AGENT
    $ cat GIT-USER-AGENT
    git/
    $ cat GIT-VERSION-FILE
    cat: GIT-VERSION-FILE: No such file or directory

It does not generate the version file at all anymore when it's not an
explicit dependency. While I could of course add the missing dependency
I don't know whether there are any other implicit dependencies that
would be broken, as well. My gut feeling says "probably".

I'll go with my version instead.

Patrick
