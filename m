Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD1222570
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717754; cv=none; b=LpvgUS5jPC4XeeR/R656Qdpj2YcaF39ayT9KhXmQOVI4Otlj+AxEESJUxKvqkHxsDbSXU1ovolpEqjaQWLXaiBMBDHbevogWbrFeoovN6omuS0Tuze+t2Bdr/TMWgjamfKTJ2k1LMTebrqbFB4JUhdEaxd9jjUukydX+KzqBQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717754; c=relaxed/simple;
	bh=S3esyriCoqm18W57cNj450DsDCkfPWEkjsaswrR2oAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpl/lhkt7cqvskHsV3evhso9+FAyNKFIfBnf8blM6aLM3KnQktODbpi9fR1/ZXemoT4q2fNRDHxIKdkqewsJOdxZkUmV+9eE4eeuas5oeCngmZeTQlVsAIcNzyFJ3SWr4J9MP11akjYmKajr2RTxY9kYlT3eH50kSiLq+yLXQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GClYOMbe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5qucDpF1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GClYOMbe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5qucDpF1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36450254012C;
	Fri, 20 Dec 2024 13:02:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Dec 2024 13:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734717751; x=1734804151; bh=nNaz42iv51
	B/w83eEXzGJCkGnFQGtc/6zyRaLT9Trv8=; b=GClYOMbewAwlxuYMKmTWqCPvzA
	oKXuw3G+u9X5JijqhaO/EfEJkCjTwu+wBNptm9R/HHJC/CvRes/rSu8xKF67ttJu
	3kZfT/zG+GuheAcdtq55Wn7ZmiwrmkS8XImz1b5CRqmRp/MtaU1XouaUJdqgPZnk
	HmAgDMsJeUVIemNdT9+c3laRfWINQxHD6d03GdNNR7O/w67PcuW47m1QYCw/l+X3
	gHHsFUswyrZT6V5RmmuBaGDgCtqzWs0gq7p5MmB4swMRBNI7knXSTvtcnQvpkeSE
	O034RzqD31K9UcVu5tqCtn2NgBqBLbDMYQE02qeAQHqdoNpDJ/Gxws0oE9hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734717751; x=1734804151; bh=nNaz42iv51B/w83eEXzGJCkGnFQGtc/6zyR
	aLT9Trv8=; b=5qucDpF16aMzNP63i4iTCN6Tt9Vr1yqVeImZ7YkEcFtsvmS8kPj
	SxL/ygFijsWVjVa+GyV/KAXeVzkuJp8s62bMLdzU+YcfunLkNM/A27UBLoYXwmYF
	73A2Nl46bHSYAT3cxv3FHQBDSrv3D7lJpKh8T4YVMacZWuURYvnrbuRI0B/KpG35
	TvdAMdJLxW4I1gPrqVMJ5MxyhfPFhvxxL5oUTuRdGj5AWFtRaIXcVPtKA25ZRIbs
	zJVZua9k1Lc9pvb6+O8uKqLvr/jvf/DZJn/lAU+jdbQ2Z9wn1tI65nybTdaeitP3
	NV/yYdITyONOjfbUoyW1KDxMEZutqzn84kw==
X-ME-Sender: <xms:NrFlZwXrwfFwGSzMdE-nDt2aOlgfp6HkmRVHaMf4G5UqMSVILm5DXw>
    <xme:NrFlZ0mrSW8qY_4xlsVG3bnd0SAfJ5dFVqM4io7NCCZiiSE51Bjh0-p9HNkU8J-TO
    P35VPtY8Ff4hHfP4w>
X-ME-Received: <xmr:NrFlZ0bc7b7ISMcy-dcGCRMCVlR-wpzJ4QI6NOe8zuX8GjhwciJvOE4eGvr0lgq1-gvKcw-eQA9Bc6dMICrg5ch5s1ynK0HHIWNHUsGWMJX7rys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleeufedule
    duteegieduledulefhgeetvdevleevleekhefghfehgeetvddvgfeunecuffhomhgrihhn
    pehrsgdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NrFlZ_UZmQib81kIdmEKIUR-Ts-YLd-Zuj_WLDPBhkidQfjfXQIjCA>
    <xmx:NrFlZ6nvodZMAnkXB5FZJQIivCQ0OA2TRQVx1QnaRqav8eE0koEAPg>
    <xmx:NrFlZ0d9994fIOP_5gX3toOO0_PfgUVJyVpG44KgGvOyqRrjt0OR4w>
    <xmx:NrFlZ8Gy_8uOeX2qDeCHhirlIODsErpb6bbu46hSG56vrxx0lPW5UQ>
    <xmx:N7FlZ7B40iV94lY8e5sliq3UizCeojM6BibK8304NkGUexwzdL0p8OW7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 13:02:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4220380f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 18:00:32 +0000 (UTC)
Date: Fri, 20 Dec 2024 19:02:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <Z2WxIRcV0LOvx6OX@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
 <20241220175136.GA203033@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220175136.GA203033@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 12:51:36PM -0500, Jeff King wrote:
> On Fri, Dec 20, 2024 at 05:47:14PM +0100, Patrick Steinhardt wrote:
> 
> > > This looks good. It fixes the issue, and I am happy that:
> > > 
> > > >  asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
> > > > -	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > > > +	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > > 
> > > ...these spots get even simpler.
> > 
> > Meh. I just noticed that this doesn't work: we include GIT-VERSION-FILE
> > and export its value, and consequently any subsequent invocation of
> > GIT-VERSION-GEN will continue to use the value that we have in
> > GIT-VERSION-FILE. So it's effectively only computed the first time.
> 
> I'm not sure what you mean.
> 
> I wondered earlier if we might into a chicken-and-egg problem like that,
> but I tested and it seemed to work fine. The rule for GIT-VERSION-FILE
> means we'll build it before make reads it, so that first run of it will
> get the updated value. And:
> 
>   make GIT_VERSION=foo && bin-wrappers/git version
>   make GIT_VERSION=bar && bin-wrappers/git version
> 
> does what you'd expect. And the docs work the same way:
> 
>   cd Documentation
>   make GIT_VERSION=foo git.1 && man -l git.1
>   make GIT_VERSION=bar git.1 && man -l git.1
> 
> Is there a case you found that doesn't work?

Yes:

    $ make GIT-VERSION-FILE GIT_VERSION=foo
    GIT_VERSION=foo
    make: 'GIT-VERSION-FILE' is up to date.
    $ cat GIT-VERSION-FILE
    GIT_VERSION=foo

    # And now run without GIT_VERSION set.
    make: 'GIT-VERSION-FILE' is up to date.
    GIT_VERSION=foo

So the value remains "sticky" in this case. And that is true whenever
you don't set GIT_VERSION at all, we always stick with what is currently
in that file.

I've got a version now that works for all cases, but I had to use
Makefile templates and some shuffling to make it work.

Patrick
