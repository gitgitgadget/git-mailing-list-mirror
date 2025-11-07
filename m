Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0D280A20
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495497; cv=none; b=HvSQVlwvgotueG+XvAYQ+xGhkoWaiOSUnuSzU1nqRPUT5+1UlDQMFXzLe3Ih18CfsvgBReN3DPv2BNHGGgBj3ZLbzAaB+ndiB8hvPQinkW7lh8epRaZjYEl0gltsh57Dar8ucDV+yCT+r6ZJ/NNmWPKglxa+Zw5a70EIsmnSMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495497; c=relaxed/simple;
	bh=XbB0c1Bt/8YCgbuB/kJez2PIKqaKc8GtJr7xbpuFEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRXz8XHEId3nXYJfb3d53NOebfebMHh7uPk2pv+spcM2H7fkiEoNlvhQLkheUxmdNucN5OxzAJttLdtjm37jIgpGrrL+H7VhG4BTQX2HDABBI/ReknuZIHqTwlnrcRvNJfG2WksoqGfY2fAlI9T5bBLatZLRVPVfJ+0XDZ2rPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dvsk4e/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=szI1M3Dh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dvsk4e/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="szI1M3Dh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 74DDDEC020E;
	Fri,  7 Nov 2025 01:04:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 01:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762495493; x=1762581893; bh=OteCGldb50
	6PmqVz3MGTq3w3juap5NkD0GOGilUlyI8=; b=Dvsk4e/oE+zsB9AAfGno6lXOwk
	E8VHSk8hXwACkiUUU3mIxs0bTuPKxGjbp6IvSoug3q0ZkCqCGDDIj2qGUMx7fIYu
	y2TTwXfhGJJhtlrBGEmDGdBhBHDp6k5fc4u3aE1ByHv2X+xk5ABH7NBKlwvyU4hu
	I0Pxs4USJA/bt/geb8bagavRKhnGwQTZ5g+e9IBWdS8CzYnXEBbmCloBaunsFOlr
	BCFQf2reL6XJj2EkWWYDLorPGfr9lSLomJq6GG3uJWWBL3U5Ald3pgA3lgTzYiZA
	ZuAixKNvfYAoinGKgBypNR33wHm1IynmG1zT9N5JXQyMWqNd58xkVAcM+n3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762495493; x=1762581893; bh=OteCGldb506PmqVz3MGTq3w3juap5NkD0GO
	GilUlyI8=; b=szI1M3DhB/yjiLcbrbwqUsJvAgzged9g5tlQU6b87Zl7tUstwB5
	jukYfQI3/FfMNMCJp6V/oD9Psyc56pV4nib1KwDJ/ggFFFScwmYcxFrZtCQOJWAj
	28wQeFu/n+t7t7uicy/vwowbb6F20015IoraBIbP6035F/qu7vBOprFZxJdX9RSj
	o6Wd9UGLwTBfQZvwhoafykA4zpgGmqJT5t/hZkyVg4tXAT4sTdNi2ZG5Zy2qpdm6
	fOGvJHxoYz973Dcmv00CbvteAuMnaxdfLRnCVPjI6CcIAYKXQsjCIyYakl1g5ii0
	pIFD8aJkMfjtcT08b6hvij+8PTdZZn7/yIA==
X-ME-Sender: <xms:BIwNaamh9gkkugywFmjEIW4r6OdEtaKBWxyW3DgTZwZvtXLSE9aAQg>
    <xme:BIwNafq4LEKMdfSVuyX1hnu8XZvI6fQ9KWkmZDcSFamLiAFVW8e3TAsT2-3Eptg5m
    2h33tV3Fybvz1g1rbL9TxxHyFs5N9xnXk2YhB32YogHJX1YqI8JOg>
X-ME-Received: <xmr:BIwNaTGU9Fo3B1SxURTkFkg7oLTNRy30gsMYzy3shga9MFU-7FIdTMxGQXEgdiIZA5E1rLKQDHvfI8ShUoJXdzl7gRrxgJvmPSAUHUP_958WYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhr
    ghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtoh
    hm
X-ME-Proxy: <xmx:BIwNabxsCeF3IXlm-yAmkJzhQaOk182MTlCG76ou8AD69wis4V6m8g>
    <xmx:BIwNaYpH7xXKo614QSSoazss1tFFGN6IcqtVS1pYrwTwezBlJ4-AUw>
    <xmx:BIwNaVhYjAtLrLwdrunIOPX0P9I4l0OFHNPRHbM5z3f6tZm9ANOPCw>
    <xmx:BIwNaVhAU2a81j5mvCQbTMpZchNM62UWiJnqFU75MSqVhb2tHRnnkg>
    <xmx:BYwNaUiqEV4_CBEjo2A8D3LWrpwFNL71c9hIThvP3igRnL46Hz7WeZqc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 01:04:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe1b2f8f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 7 Nov 2025 06:04:49 +0000 (UTC)
Date: Fri, 7 Nov 2025 07:04:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: v2.52.0-rc0 test failure on cygwin
Message-ID: <aQ2L_a3q7MAUJI-L@pks.im>
References: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>
 <aQx-RnNX28BPU2cS@pks.im>
 <a8a03a31-8e06-4b72-b847-b59548156e60@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a03a31-8e06-4b72-b847-b59548156e60@ramsayjones.plus.com>

On Thu, Nov 06, 2025 at 08:28:35PM +0000, Ramsay Jones wrote:
> On 06/11/2025 10:53 am, Patrick Steinhardt wrote:
> > I wonder whether the issue is surfaced because we use the shell to
> > truncate the file. If you instead use `file-tool truncate 0` for example
> > then I cannot reproduce the flake anymore:
> > 
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > index 3ea5d51532..1058f83993 100755
> > --- a/t/t0610-reftable-basics.sh
> > +++ b/t/t0610-reftable-basics.sh
> > @@ -207,7 +207,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
> >  		test_commit file1 &&
> >  		for f in .git/reftable/*.ref
> >  		do
> > -			: >"$f" || return 1
> > +			test-tool truncate "$f" 0 || return 1
> >  		done &&
> >  		test_must_fail git update-ref refs/heads/main HEAD
> >  	)
> > 
> > But this may very well just be due to timing again -- spawning the
> > process will be slower than using shell redirection to trim the file.
> 
> I tried this patch tonight, letting:
> 
>     $ ./t0610-reftable-basics.sh --run=29 --stress-limit=10
> 
> finish, which it did without failure. So that's 32 * 10 successful runs.
> 
> (I had expected 16 * 10 yesterday, ie 2 * cores * 10, but this laptop
> has 8 cores 16 threads, so 'getconf _NPROCESSORS_ONLN' returns 16 not 8).

Nice :)

> > All of this is quite curious. I don't really have any better idea than
> > to use something like the above patch. It's ugly, doubly so because I
> > don't understand either the root cause nor why the patch properly fixes
> > it. So I'd be grateful if anyone were to enlighten me :)
> 
> Me too! :)
> 
> > I have verified that the flake already exists in Git 2.51, so at least
> > it's not a regression in the current release cycle.
> OK, that's good to know.
> 
> Despite the mystery, I think a patch based on the above would be
> the best solution for now. (Assuming nobody has a better idea).

Please feel free to take it and turn it into a proper patch. My main
goal was to verify that this is not a regression and that nothing new
broke in the reftable backend. I'm happy to let you take over from here,
as I'm a bit short on time otherwise.

Thanks!

Patrick
