Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38130C345
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225887; cv=none; b=ZWNw4fnZ53mKLhomlEPc4FsWqNYv1CBIX68c7u25kCcUjUNowYp0rEKfCoXLD8GLsZOvu+SdzpzMocEkyw+N4n9SE+FGyPKgeXLafLmGOp61aKrfiJV9RyGxkK9EVJIJERHG+v2atK+dffXDbb7B6HWywWWn1q/n1g2U/Qmm+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225887; c=relaxed/simple;
	bh=xbtr6qRMDHXKvOEJO9at/X63iYaFn1qGfoc/OokW5K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbZQGungkJBNz1sseUHmGR7TqQ2+WfD4Ei1pVvwLHxW7Y+x2vGexEvgeR8a4Jflb9cGzjVH/52hss7zE+XILG7dQLXv/pXU5v7ehBBvwjKD3lSWlp3GK7wIaPM5QAqIK17s+eqMTV+QGrYsrtwVwTUC+sDvMjJBSqn4zGcJNf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SlZ9Bnsa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMtC0nvd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SlZ9Bnsa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMtC0nvd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D1051D000FE;
	Thu, 23 Oct 2025 09:24:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761225884; x=1761312284; bh=xO3bV1BMTg
	kSbi2nKFUssMFeiw0XOMJ9fd2XQsQ13xw=; b=SlZ9Bnsav+BZUWrw/ykwW1FxBO
	DtTh7ebXsnpJ+somLkHXXobzxyKd/JUh9MKOXDRJJVt6QtULU24jIE207YPS2Yrl
	06YnVGEpysOSJ+1Xj++JmLDmvhxPwHy2bS27TKriF7rI/B6FqN61WSUADONJQIXe
	hzQHMUKpWCis/J6sI83seoFsDrAYrpkPVRtPc6/tu3oUGzr463Oz/E9iJNd49Qxj
	hwb9Rfhj9FVHYIv2tTBQZk2iXZ6P2TFZPN2vrv/+30vgVSU0+0xRz5MhgeW8x+3A
	Yf0r4Fd26E12vbMu+43FmF9RdZcr/yfCrhBdvHRl0SfcxO0Dw+JXKonn2nog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761225884; x=1761312284; bh=xO3bV1BMTgkSbi2nKFUssMFeiw0XOMJ9fd2
	XQsQ13xw=; b=MMtC0nvdbTm97yqYr6bfvHLUr531cCPZZHdyGEkuRcwhsJsWJp2
	tVPNorZySB9wNL5niiBhf4J3dvxp5gLkfCYq34S60KjvzaPkDexLjWA6I2RZ5Zaq
	Cv4SRVAzicLdYKXociLkyZuoIlH+MgHmUKPIWUYatDIJup6FlWYvkQC/gdJ2bS+z
	N7bcNtrz6Zhj+K4+qBndI7c/slq8R3yN7TPFWe+sY47zJkBbS6ENQ35MrudrlPRo
	NnePEoQ9cKYiCWipREvv75jYLR6nhSbJP87EzamIx39m4fbaDm/Nl0/qSjtu4fMw
	nYwuwk5rLfumDg+iZ6IzEzIYJws85JqDgag==
X-ME-Sender: <xms:myz6aDpnUrvUUEDF7lWvlmixkxT3x1C_wNrmaQfencPd96f2L48Ojw>
    <xme:myz6aEj2eFvYk7f7IxjHOdathFZyZJtyF0hK51Yxtkbrg36aRlQBKMo14V0AJgoaV
    bNd0c5J5JOm7U39-E6xGa8JvHwjg1dYt4LsL23GLkArkHHazE8QyQ>
X-ME-Received: <xmr:myz6aIgfOL0I7dAdkyug0IBqK48u_JJTBbITSZX9ghk0rIALTXZhNoYoQbgzS7JWw5RJi_SNOUVjxVIkcxzfgC7J3forP8eOi6IhReDlfXLmUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepgihrhiduudduseigrhihudduuddrshhithgvpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtoheplhgruhhriheshhgrtghkthhhvghplhgrnhgvthdrfhhipdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:myz6aCjHOoQNPba1qwhyvdIvUBPIBFTRQ5dVeMEJ1gYhH-jC5UmTmg>
    <xmx:myz6aAJ56pmWcSDdMjSSk6OE91S6oPEdbQkesz9mrSp8Pz4EjMaC5w>
    <xmx:myz6aJGrYX-eyXvfQPYfgRTY_PTJp-PNjlipos-GZ-s5yM_ZwzsyCw>
    <xmx:myz6aMSanzqelSEOPNzGEPsKIHWT5q7uvxJsH1va6EgYHwiaX_8LnQ>
    <xmx:nCz6aFRSIIxlzGD1FPPrrepMl1-T1ULBEp9qy4V7rE95aNvqrXFvwHIS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 09:24:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3da2005 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 13:24:40 +0000 (UTC)
Date: Thu, 23 Oct 2025 15:24:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lauri Tirkkonen <lauri@hacktheplanet.fi>
Subject: Re: [PATCH] t7528: work around ETOOMANY in OpenSSH 10.1 and newer
Message-ID: <aPoslANELg4V286u@pks.im>
References: <20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-v1-1-f15eeec199f3@pks.im>
 <20251023124320.GA1163932@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023124320.GA1163932@coredump.intra.peff.net>

On Thu, Oct 23, 2025 at 08:43:20AM -0400, Jeff King wrote:
> On Thu, Oct 23, 2025 at 09:14:59AM +0200, Patrick Steinhardt wrote:
> 
> > As it turns out this is caused by a change in OpenSSH 10.1 [1]:
> > 
> >  * ssh-agent(1), sshd(8): move agent listener sockets from /tmp to
> >    under ~/.ssh/agent for both ssh-agent(1) and forwarded sockets
> >    in sshd(8).
> > 
> > Instead of creating the socket in "/tmp", OpenSSH now creates the socket
> > in our home directory. And as the home directory gets modified to be
> > located in our test output directory we end up with paths that are
> > somewhat long. But Linux has a rather short limit of 108 characters for
> > socket paths, and other systems have even lower limits, so it is very
> > easy now to exceed the limit and run into the above error.
> 
> There's a secondary issue, too: even if the path is short enough, the
> space in "trash directory" of the path will break the shell eval. That's
> relevant below.
> 
> > Work around the issue by using `ssh-agent -T`, which instructs it to
> > use the old behaviour and create the socket in "/tmp" again. This switch
> > has only been introduced with 10.1 though, so for older versions we have
> > to fall back to not using it. That's fine though, as older versions know
> > to put the socket into "/tmp" already.
> 
> OK. I think this is an improvement over the status quo, though it leaves
> a lot of loose ends, like:
> 
>   - what happens if "ssh-agent" does not exist at all; we do not notice
>     the error because the eval succeeds anyway (with blank input)
> 
>   - one reason we did not notice this immediately is that the failure
>     mode is to fall back to using the user's SSH_AUTH_SOCK variable if
>     set (i.e., their real agent with their keys in it!). We should
>     perhaps be clearing that variable in test-lib.sh.
> 
> But those are not really new issues, and I'm OK with just un-breaking
> things in the most expedient way possible.

Yeah. I was wondering whether we should rather do:

    ( ssh-agent -F || ssh-agent ) >env &&
    source env

ssh-agent(1) knows to detach into the background unless told otherwise,
so we should notice the failure and can then source the environment if
it was successful. But I ultimately decided that for now I'd rather want
to fix the fallout, we can still make it more robust after the fact.

> > An alternative approach would be to abbreviate the socket name itself so
> > that we create it as e.g. "sshsock" in the trash directory. But taking
> > the above example we'd still end up with a path that is 91 characters
> > long. So we wouldn't really have a lot of headroom, and it is quite
> > likely that some developers would see the issue on their machines.
> 
> I assume you mean here something like:
> 
>   ssh-agent "$PWD/sshsock"
> 
> Yeah, that is not buying us that much in terms of headroom. Plus it
> would still run afoul of the space issue, since we know that $PWD will
> always contain "trash directory".

Yup, that was the idea, and yeah, I don't think it helps us much.

> If we are going to provide a fixed name, I think it would have to be a
> true relative path like:
> 
>   ssh-agent ./sshsock
> 
> That does work (and SSH_AUTH_SOCK contains the relative path), but is
> maybe a bit of a booby trap waiting to spring on somebody who tries to
> access the agent with a different current working directory.

Maybe. On the other hand we only have a single test anyway that uses
ssh-agent, so that's a problem for the future, I guess.

In any case, I'd say for now we should just fix the issue in the easiest
way possible, and we can then follow up and make this more robust in a
subsequent patch series. WDYT?

Patrick
