Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D222DF86
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613928; cv=none; b=UzEGAZKeY+l3TLuXfoX6MmYy2K3pENYcpPt4Z7qkXJvBuWgmAD+YfXNg6KrEd+OZowyrlFP42ieB/mkEnB8BTwbuXkNa2aLkbuvb5889xg7FbmGbQpaN6ZyJP7dA0jVL0z2Td+nRQ+qCQvYXNWcIvCNThJIoYLWyLeDvFqvOGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613928; c=relaxed/simple;
	bh=XQMHKMWKq/6VX6Ar9Ivkv+MxStp3HUYsiz5C+sFAwNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrdqHQd64LWLigf6+yCL4F/2SwObksmrm65jSSlM5FXdJNpzCnxS+gCNV03gGCNShaqTuTDwJg1PKa52HDyfOsuQ0+6jAEZNynAG1w/TlinWBdhxt+Hh2brxHRlF6GVMJttCDEOu32Ecwhf2Y56rO7DkCMq2egZeXwhjxRJNBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OAvf5I39; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YA8MkOaL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OAvf5I39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YA8MkOaL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 796C011401B1;
	Fri, 30 May 2025 10:05:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 10:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748613925;
	 x=1748700325; bh=IG6rDvqjYlhZHCr1iPkvLL7+A1Lsf9Hliz3i9q/mwEQ=; b=
	OAvf5I3968VVzxH4kS83Eu3sMSl9CyHnSbpAJzr8gdJBnemWSiv9D4hfYEYce/PL
	VV7S6+U/UFpkDGtPpDVYsLS1iWf8zbPzRQRkNuAtWFXo8BIesEO8J+/4hYeypDi3
	2O4s7pl0DfUfCrzf7aBO25rt+B3mR6VIUfiosFvFXLe0IosIZbCQlPraEGv9P49G
	wwJ2G4QCiXjiqwvtk/2w25J2J1W14sJcM9FrUH8V5957ArXo0kBF0l+3c+peRY4I
	Euh6B/9dE7PzB0BwKx/PwJIBjq6zaqXg3d9VrW10Ds7uKUgbJK3stAZjEClqZKeF
	6sKFo1X+vpeu1w9BCInTPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748613925; x=
	1748700325; bh=IG6rDvqjYlhZHCr1iPkvLL7+A1Lsf9Hliz3i9q/mwEQ=; b=Y
	A8MkOaL1vJnWORTcu5Un35MtjgmPa0IiDmhY7DcpjDOg0n9MiPECzmRoAYju4uOe
	SbZkbPsIr+WBdIrVxMrWHNG/vqcc5MqRo2PKvZOYxeIyGo5w+gYDbamhLOxxAh57
	Q0HVXCIa+vYM9V2peNW1AAFrbndUZL8JIsVtuApU1ZqNMvcili4i5ctfnLaDYQpJ
	CqqKoHvxvYMV0FMgMT4v8qh73Uh3uBTCGcLh5VtJQPW6oBASO9uNqz9zmNX+7Obv
	Hu6+1Dh2Y6O7EdB7ZGeHbO6DUgFlBodXsjpMM0xLGrdH+PU1uPz3LO+ZuYLr64+u
	Vv+wqVKSfFbDJNksd6GlA==
X-ME-Sender: <xms:Jbs5aEKgruEmxBh15mD-19veAeUMRdGOVrpN6jLWSblNQV_dTSXOfw>
    <xme:Jbs5aEKkIzxSsVjiHEwt-8VH7g5Tthav-IG77kyLTVYu6wKNsPx3y0UzXNmeXrtea
    Sc7gaOt-iFh3QmKRg>
X-ME-Received: <xmr:Jbs5aEuU-ECDZTOD2y_JsFPXX5Oq_HHG0K3-qV-5LKso198e0_zK2BClHgyclAlUSRIqXgobFJTrNo9QkodgaMvEkdc2MRdtFe94ao0Vjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Jbs5aBbyGQNjpWyIKN6GWijjy-MYSBsM2IT-H2f9z-5iUFY6l3yjsw>
    <xmx:Jbs5aLabFx7VWOcUHbHNl2x12DuimNM42UbGXsf4fcZEeatTfk4Tvg>
    <xmx:Jbs5aNBsoebn3rmKZnLbIfeo2HnR4j5NVkdetEFqb5IYU5STwr-izQ>
    <xmx:Jbs5aBbG21x5TAVtrAfakxtHrrYYeHdhsn4fn8G2-GUuPjk_MPg2Og>
    <xmx:Jbs5aISH4RgztG3n84l1LhGBRfcSjLF5GzfxUuiAkdj5QlyP-8SYSX6X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 10:05:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a8a4eb1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 14:05:22 +0000 (UTC)
Date: Fri, 30 May 2025 16:05:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>
Subject: Re: [PATCH 11/11] builtin/maintenance: fix locking race when
 handling "gc" task
Message-ID: <aDm7HcdCbam6wgbA@pks.im>
References: <819EFBF4-C435-4213-91C7-BF15B49B1B09@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <819EFBF4-C435-4213-91C7-BF15B49B1B09@gmail.com>

On Fri, May 30, 2025 at 08:55:49AM -0400, Ben Knoble wrote:
> > @@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
> >   else
> >       strvec_push(&child.args, "--no-quiet");
> >   strvec_push(&child.args, "--no-detach");
> > +    strvec_push(&child.args, "--skip-maintenance-before-detach");
> 
> I suspect this would be more obvious to me if I had the manual
> available right now, but if we are not detaching (« --no-detach ») why
> do we need to skip something before detaching (that presumably won’t
> happen)?

We have two levels here: git-maintenance(1) and git-gc(1), where the
former executes the latter when the "gc" task is configured. What is
important to realize is that in this setup it is not git-gc(1) which
detaches -- it is git-maintenance(1). So git-maintenance(1) runs in the
background, but any tasks it invokes itself must run synchronously in
the foreground.

The flow thus looks like this:

  1. git-maintenance(1) starts.
  2. We perform the pre-detach tasks from git-gc(1) in the same process.
  3. We detach and thus the main process exits.
  4. We execute git-gc(1) in the already-detached process.
  5. We wait for git-gc(1) to exit.
  6. The detached git-maintenance(1) exits.

So because (4) is running in the already-detached process we ask
git-gc(1) to not detach again. And because we already ran the pre-detach
tasks we also ask it to not run those again.

Patrick
