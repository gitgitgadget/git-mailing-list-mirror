Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB43218EB9
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718723; cv=none; b=KQXG5rVMgTnR2bgse169HOm3DRvom/+9pniyglZmOIe527B7mhADpvAx8mMlqO+fgf/EO/u9yHlEDM+ejNumOyBp8gjl2lACIik2mv+RHz8YaNg4DVaGA4QBq8UmPkIFLKZE3TAK/vU78R4vsi1Vsutw4SDGYFlTegNrhxr3l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718723; c=relaxed/simple;
	bh=JGDmy0W4vcEexZU+LFFdQ2ztki8xPOr7FCuO08tvpBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRwN9Q7rOcENErRiClfPogVJiZPzYksSfBkKb+pqyUx4ytR3sx7h7vy7qfSNtNFyLDr3Xz1aJdZGwPX7Bi0/zkuV7Yv5HVudPBHKlLwHGfJ2Z7vWuX9w7OpkYXtB+pgMFkVIpnZVU235UDeRRVbgj3KVfLy48oh7BPmOiU9Fvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CARMMQ6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXzGjEFB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CARMMQ6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXzGjEFB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EEB72540147;
	Fri, 20 Dec 2024 13:18:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Dec 2024 13:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734718719; x=1734805119; bh=38Iqyeo8hH
	NSmthIZzo+ogrVMXZPSgfj8H62aI5eBM0=; b=CARMMQ6UoJGhkUbv9/GX3Hqq0E
	jpJYsL7u6Y2zEvsKH1kEJH0rqEFsieu3AnFUSMUjCB2FhH3j90JCZq5eTGWFQ6ak
	mxA+AFbLBB2r+rN55kboylbLidyH0pR8MKzPRnPmNzuupGLNJiN92jqM730vkuYX
	T1r3ZWjGwymp7Kd6KuaAuin4X28NimXmK+CPHvigOU4jBo6R4C0W3PyDgBf2clKB
	Yb6OR4C6qHJFClkmvXU37oFrVf1gU8wqzKalekm2uOVn1r0d2dFEzD6b/JXFMaDC
	Bc/GJeyIgiWTlukYokLwO4aH6PlsVtCm3HecKL5TAfqop2vt+mPSXaM0IzSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734718719; x=1734805119; bh=38Iqyeo8hHNSmthIZzo+ogrVMXZPSgfj8H6
	2aI5eBM0=; b=bXzGjEFBvlUj9sEeVbxAq0nR8xjtpweO0TjkqU1Mz6ibNtJxAbX
	1b6NTADeA8h81Me+WSDXW26docBQEVhGwKg/qvumjb9oEtfhS63G2mfXG9OIXi4K
	3n5ka+eUlUwyJGmprLa802g7vf+mKR++AsRgx41YVhGdIE8VZpZANs51AxXJjHE+
	gbAvN43LoeLH3Zu3WDDKpXArhbb41fYFJNZ4apTrER2Emz4nI9iIGMQYAJAmF1Vn
	26eVcXmRp+2+vKjW5dJhTAkNoRjUdqfgCMA1NB3UGiBGKFaPdtKHw+5q4ohrgCKP
	BQ30YlE0DNTLZE/Zwj91jf1n58O/BdHlHiw==
X-ME-Sender: <xms:_7RlZykX5UzKPWzdvC5-nss6KlyQOzngK5OijXGc3YwyNpIKofElgA>
    <xme:_7RlZ53OG8BvqYrU70mhkg4J9wEnK5xfokMDCQbhOFZpC8xvi_uTUgTECa0Mh2Qtc
    xDEhjY0Ejjc-zh0oA>
X-ME-Received: <xmr:_7RlZwpflF1YHyKRCcEsXakcHsn1CgV1XedIAuv-ddGfNh-N2CPU69CrocBcoz2CNZuOvLOhHkXkukd-7EucU4oGxaqnZ2QLN96H4YmL0NLqkVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteetgedttd
    eiuedtgeevhfejfeetffegieeltefhjeeutdejgfevgfdvhedvtdffnecuffhomhgrihhn
    pehrsgdrihhnpdhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:_7RlZ2nfqrNhGdsJbyucZ2o-eREPlJLkaa51XM9ko_OUWpNVM0i4Sg>
    <xmx:_7RlZw06iUM1cYu-sw4yfrrL_ZhKkYJdncgktzZpwJhg4x9AmoppeQ>
    <xmx:_7RlZ9sBeFZ-79r6O3GyhVRtPHfT69z32CuD6U5bCvpqAfd0LUVNfQ>
    <xmx:_7RlZ8UdRbVLppokRe2BAz7isFj48HNGn5a-BHasCzu4vpxRNIApIQ>
    <xmx:_7RlZzTA0EiksU1gRDHkp6cYQYNXKLPrLwRrpWYqMyc9Ak4gUn0rnh55>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 13:18:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07efe07c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 18:16:42 +0000 (UTC)
Date: Fri, 20 Dec 2024 19:18:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <Z2W06zRsQei5E34D@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
 <20241220175136.GA203033@coredump.intra.peff.net>
 <Z2WxIRcV0LOvx6OX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2WxIRcV0LOvx6OX@pks.im>

On Fri, Dec 20, 2024 at 07:02:10PM +0100, Patrick Steinhardt wrote:
> On Fri, Dec 20, 2024 at 12:51:36PM -0500, Jeff King wrote:
> > On Fri, Dec 20, 2024 at 05:47:14PM +0100, Patrick Steinhardt wrote:
> > 
> > > > This looks good. It fixes the issue, and I am happy that:
> > > > 
> > > > >  asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
> > > > > -	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > > > > +	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > > > 
> > > > ...these spots get even simpler.
> > > 
> > > Meh. I just noticed that this doesn't work: we include GIT-VERSION-FILE
> > > and export its value, and consequently any subsequent invocation of
> > > GIT-VERSION-GEN will continue to use the value that we have in
> > > GIT-VERSION-FILE. So it's effectively only computed the first time.
> > 
> > I'm not sure what you mean.
> > 
> > I wondered earlier if we might into a chicken-and-egg problem like that,
> > but I tested and it seemed to work fine. The rule for GIT-VERSION-FILE
> > means we'll build it before make reads it, so that first run of it will
> > get the updated value. And:
> > 
> >   make GIT_VERSION=foo && bin-wrappers/git version
> >   make GIT_VERSION=bar && bin-wrappers/git version
> > 
> > does what you'd expect. And the docs work the same way:
> > 
> >   cd Documentation
> >   make GIT_VERSION=foo git.1 && man -l git.1
> >   make GIT_VERSION=bar git.1 && man -l git.1
> > 
> > Is there a case you found that doesn't work?
> 
> Yes:
> 
>     $ make GIT-VERSION-FILE GIT_VERSION=foo
>     GIT_VERSION=foo
>     make: 'GIT-VERSION-FILE' is up to date.
>     $ cat GIT-VERSION-FILE
>     GIT_VERSION=foo
> 
>     # And now run without GIT_VERSION set.
>     make: 'GIT-VERSION-FILE' is up to date.
>     GIT_VERSION=foo
> 
> So the value remains "sticky" in this case. And that is true whenever
> you don't set GIT_VERSION at all, we always stick with what is currently
> in that file.
> 
> I've got a version now that works for all cases, but I had to use
> Makefile templates and some shuffling to make it work.

The root of the problem is this [1]:

    To this end, after reading in all makefiles make will consider each
    as a goal target, in the order in which they were processed, and
    attempt to update it. If parallel builds (see Parallel Execution)
    are enabled then makefiles will be rebuilt in parallel as well.

So the Makefile will _first_ read in all includes before deciding
whether or not it needs to regenerate any of them. So we already export
the current GIT_VERSION in case "GIT-VERSION-FILE" exists at the time
where we run "GIT-VERSION-GEN".

That behaviour is quite surprising to me, but it seems to work as
designed.

Patrick

[1]: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html
