Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581215B54B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058480; cv=none; b=MUdyS9yKyqmm+mVr131L2wgzCFApTyxdcmrVgC9nSOjSFNazxOs31ZU00VqnkwFDjigqJEzAg9lvY5FCwmWRyrqKeXfuUi3Wpyv2zrQ3gD+AoCFSXpYmZpyCfZJitom3gcvditmmfde9UF++z6b43tLRYaEfvk/lFz8smUQvA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058480; c=relaxed/simple;
	bh=bXac6xGyIa8val4AOyY5utVMy6YbFYMnI1VAhiMjtYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsVdIXZsYhrrKFkELYcU/fR46WgKzrvkx+NpYdKI7tHgbnBMUzX3dM6CZsy00mwf1hoPqzamj3M9hxNet2S45j23NlsHT3Wy374jhMi8pVywrtJFX9AWUKJ9tiznGCL405AShndP39ZHcUQI6Kj52yjxJ48qUFMLEEnZOjw2Nuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bhu49oUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XqHVP5a3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bhu49oUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqHVP5a3"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 57B86115058A;
	Mon, 19 Aug 2024 05:07:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Aug 2024 05:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724058477; x=1724144877; bh=JDighDTMW9
	nPtTc89RWufwhpm1es9vXcrsDeqqbTvLE=; b=bhu49oUEUadRiN1v83z5FXva1+
	+tsV7uEHfxzK6SkO4Y/B5P6lhvpAf/c/QKSSL7BrRN5q1BmEniVZjYHhd4q0b+c6
	9CejBObCleSgoA1X+O+9pYI4vURJtMmeLWz5cmefrtvoLr7JM/hWOYGaAbVd0w6a
	//HaIpWDFxMbsaark/e17EyNEcFw/LNdnD33UDRtYWTzoVrMVR1r7G94aLEz8boV
	vNothma/eTR3LGJ49LAry8Ll6NwX8VU3AF1TXOrXCUj6FEVD7uNS/b0gpr+fm57N
	ncJG4HDQBDPRWkWKJcw3HrkxXNN6uFHSptgtzEfcFdz79K4mPy1wZurhkIOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724058477; x=1724144877; bh=JDighDTMW9nPtTc89RWufwhpm1es
	9vXcrsDeqqbTvLE=; b=XqHVP5a3Ah69qUhnyOeROGkb5yxp8wPOje/5k6zRaP9h
	0ZrHQJa7lA3MhzXaPqHS4SB8MJIK5ofStqrUs+s6Kc7knW/8EpX8ZBEb3AZGepYJ
	ORmhSSI6xmHaPUhW6Ookft2HNOUQkSKPQOemeejJbOGIYFKGsaT4ZNs5YOE1sf4L
	eD/h9JmLXBxEOm3q3rl0/+qpQlljPcv8h5dl01ZMUB87DzO/V8PeTjVW4lTTPx2z
	ZyxRufqXdEr9D/TWLFxjp7SMvPKfzPFD5adn7HtBbWJdQnAaVLE2N8J9anww40OM
	Kx1FpISeBSBGEHfXLTsBSl7L5USqdnazwuEWVgQVBw==
X-ME-Sender: <xms:bAvDZnoeeaiqFbJGB3t3VcvCkJjiQklGkK2-Aia39s5T9t-Fils5-g>
    <xme:bAvDZhqyYblcOYiQy6m96zrmoEsyZuKz9OnVcJ-XV_dGZJhmz6nwUsaEZLe3EiMLN
    aCzGsbU6prpCu-HDg>
X-ME-Received: <xmr:bAvDZkOJ9GcxduO0zGu0aGH6Sbp13Wq5saovtfPJcevAtHOk3qEYsrYTNOT7oN7YpfF_5PKxFZqzN-Xwac-1swjajeiCJdz-g69d1_vpnf8wndc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepleeuffeggeehvedtteekiefftddtheetkeeutdekgeei
    tddvhfeuveduleekgefhnecuffhomhgrihhnpehlohhoshgvqdhosghjvggtthhsrdgruh
    htohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bAvDZq4PGN8RtQjzopI2yxa516HJJzPg3SU9HOQmF-EO53Qg-z8DeQ>
    <xmx:bAvDZm7FADC7ECvK1vJBEAvgXfr7pw2kE2Wi0NJm1bb1F4Cq692qcg>
    <xmx:bAvDZiiAAwiTxyGnfPEOTKyZD9o1Z9PGgJw3jyn_7_NBuv8-6Qg0Lw>
    <xmx:bAvDZo4SH9Z-_LeczyVNRwE326x4KsLwnIcMjAGVoLt6vyL1v1O98w>
    <xmx:bQvDZtb2YzsKC5IyFmstvN0bYZKc1LVM6nAM04yB2bh7jOPLNhSKASL5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 05:07:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc5134dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 09:07:25 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:07:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <ZsMLZ3Tlhxsg6Qdr@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
 <20240819085522.GD2955268@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819085522.GD2955268@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 04:55:22AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 09:48:05AM +0200, Patrick Steinhardt wrote:
> 
> > The "loose-objects" maintenance tasks executes git-pack-objects(1) to
> > pack all loose objects into a new packfile. This command ends up
> > printing the hash of the packfile to stdout though, which clutters the
> > output of `git maintenance run`.
> > 
> > Fix this issue by disabling stdout of the child process.
> 
> Ah, I wondered where that output was coming from.
> 
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 13bc0572a3..be75efa17a 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1159,6 +1159,12 @@ static int pack_loose(struct maintenance_run_opts *opts)
> >  
> >  	pack_proc.in = -1;
> >  
> > +	/*
> > +	 * git-pack-objects(1) ends up writing the pack hash to stdout, which
> > +	 * we do not care for.
> > +	 */
> > +	pack_proc.out = -1;
> > +
> >  	if (start_command(&pack_proc)) {
> >  		error(_("failed to start 'git pack-objects' process"));
> >  		return 1;
> 
> I have not paid much attention to the "maintenance" stuff. It is a
> little weird to me that it is not building on "git repack", which
> already handles this, but perhaps there are reasons. Anyway, totally
> unrelated to your patch (which looks good to me).

git-repack(1) is way less efficient than running git-pack-objects(1)
directly. I've also noticed that at one point in time when revamping how
we do housekeeping in Git.

It mostly boils down to git-repack(1) doing a connectivity check,
whereas git-pack-objects(1) doesn't. We just soak up every single loose
object, and then eventually we expire them via git-multi-pack-index(1)'s
"expire" subcommand.

> > +++ b/t/t7900-maintenance.sh
> > @@ -978,4 +978,20 @@ test_expect_success '--detach causes maintenance to run in background' '
> >  	)
> >  '
> >  
> > +test_expect_success 'repacking loose objects is quiet' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit something &&
> > +		git config set maintenance.gc.enabled false &&
> > +		git config set maintenance.loose-objects.enabled true &&
> > +		git config set maintenance.loose-objects.auto 1 &&
> > +
> > +		git maintenance run --quiet >out 2>&1 &&
> > +		test_must_be_empty out
> > +	)
> > +'
> 
> I wondered if you needed --no-detach here to avoid a race, but I guess
> as a non-auto run, it would never background?

Even the `--auto` run does not background. That was the case for
git-gc(1), but is not the case for git-maintenance(1). You now have to
pass `--detach` explicitly to cause it to background, which I think is
the saner way to do this anyway.

Patrick
