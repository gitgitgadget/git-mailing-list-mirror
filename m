Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95342242D84
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668791; cv=none; b=OnnWaHH6O0BZb/BzTOAfPxy+yRqu08l6BPWjZqgoQrvUUVxEBhklPKN5Rgjgfs1qFxA2PPZn0ExGwbrWlB9a+32/PXtc3qQXakeQ5n9XexOSzVaYK7LliqLYJxAgGgc4jH4KJAaFPBs+2a6LIyobaONW9Y5vzLWEVwyOb0CBcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668791; c=relaxed/simple;
	bh=zkAqXk1HNPhSUsGV/8OgmzP/MSNuattAB8ct6r9jCio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVA8ooO+4DsHt5EYHQ2mb3EJoaVwHuhDV9zY+28sFK1DPl9HaCJiabyHJgl59Q/oqy/MqSUJkoZqlY2vV8G3Io3IIZcfF1KVBXjYCQv+3PwAFZEvXf8DJb/MtVn0jiLG/Ti49q5I5hjkBP6t6Zx3uwo0agjkm7hacQPr9qMQ4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BYr5MJmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zt1/2nQY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BYr5MJmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zt1/2nQY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E07A9EC00FB;
	Mon, 20 Apr 2026 03:06:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 03:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776668789;
	 x=1776755189; bh=844KDmGgx7ln0Npku8SCXfk6ufZzFkp7SNBwNenIozA=; b=
	BYr5MJmcOJ0KiiH1+s0/AWq7d8yUWE0myRCMx9UIaQGasqM2H7Fonddao+zAmS1M
	1IjFds49iyJ7pZ9z9EpUtoaKuKmgCQk6P8qVj8RgfhD9LJ1e3sk4SoxQHEwAwSzh
	3KxWRfZBsB2N3KcmhSajl63jdJMKdEoY1UXvrnWu7pImmJ1UDrnRgEEa8nNMs20p
	N1sE7BkavirK7hJWsad7YAymD8V8NFdHEo1GKj6RMYfOOzntfxv1ZCiBB+FpczNQ
	CoLw/k650Ir7WqcHaCn6tzUDN7mQcLUi9dzrIc1bfRSRRTsN1eTd4DNWUQLf8kpW
	EOjNSaNg1TcpXMgND5lASg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776668789; x=
	1776755189; bh=844KDmGgx7ln0Npku8SCXfk6ufZzFkp7SNBwNenIozA=; b=Z
	t1/2nQYkWPalab1rIoIvI5J+j0zPXUZY3d7UNThutwSKqYvfptbTRjTNs/ukkhQF
	Po8RXAv3MZQHxkfgeGXDoFShzQXp2aHTLUsC3Vgf0bhOVBax8DbhVkQQoPtLl2YT
	leWSmoKx4NmnKoPvUJ/kCluv17XLX/d23e/jjlhodU+2XtytB2T3651YB2h+WN+K
	NBUHA3vp4ae/87KiyexegvicyG6LFJBGpRx/FpkjQ0Sjl1SxKyl2XCrevclSpYWG
	qeiFQKwTFMbg8KDVDvo0trDdDZ14Lm0m0keWGyXkC3jUVf0JsDMgfRmyHx7uef+w
	yXu/IoHmCDHU+4pB1bYWg==
X-ME-Sender: <xms:ddDlaSrhAaCWiZ7uEydPSfPMwVnc_50HOlk7_7khkKB1S_wOX5CmTQ>
    <xme:ddDlaWo6ZKhmGSm8NDVr79x04paxxsjeZwbyFpwI4tf2ipkXGfqqQBU4pBqFbRqVM
    -3ISodMvBbI5Wyabhrft92my9Hbc9fY1EQAZ-HdgkwEpz1i1TASVQ>
X-ME-Received: <xmr:ddDlaU0RKbkaFJy6CyDc80Zrn8jOwdRSV-0C4Cpy5u4bZKCShiE3sSQNA6KqHqCOpdovLXxR4wacYP2rRkuFSWRIX_DoK9fzW__vU0PrusVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ddDladDU3ZwWHa5zIx3bEp15-u65HWceBwkDXi-9aJDGSyEJE2LuaQ>
    <xmx:ddDlaUf6LJFCyu74YGMuJOwhhch-2jRxj6dafII8oESuHMLhm7dBrA>
    <xmx:ddDlaahFDiIyFlAafsoGWlJ1DjfXhLq-NJTFXkclABVxsUBMDypESw>
    <xmx:ddDlaUpLHRUqPIoL0_SOn5a4aVRNF6h8V-hWBHCfOxGuFNj5TstVPg>
    <xmx:ddDlacZe7W5hByZhaZc3RlBSJAyd00NB4EIx2kWXtuMdp7-38WVAXHQu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:06:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4168b7ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:06:27 +0000 (UTC)
Date: Mon, 20 Apr 2026 09:06:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/18] setup: stop using `the_repository` in
 `setup_work_tree()`
Message-ID: <aeXQcDF-wHT4wEG-@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
 <20260330-pks-setup-wo-the-repository-v1-9-0d2e822837aa@pks.im>
 <CABPp-BHOvDaWXXDnpPsoDTe-En7T4LUaVqcJZ5Jst8zaQ-mrTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHOvDaWXXDnpPsoDTe-En7T4LUaVqcJZ5Jst8zaQ-mrTg@mail.gmail.com>

On Fri, Apr 17, 2026 at 06:11:48PM -0700, Elijah Newren wrote:
> On Mon, Mar 30, 2026 at 6:30 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Stop using `the_repository` in `setup_work_tree()` and instead accept
> > the repository as a parameter. The injection of `the_repository` is thus
> > bumped one level higher, where callers now pass it in explicitly.
> >
> > Note that the function tracks bogus worktree configuration via a global
> > variable. If we have bogus configuration, and if later on some caller
> > tries to setup a worktree, then we'll die instead.
> >
> > Of course, tracking this as a global variable doesn't make sense anymore
> > now that we can set up worktrees for arbitrary repositories. Move the
> > variable into `struct repository` instead.
> 
> Okay, we don't want a global, makes sense.
> 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> > diff --git a/setup.c b/setup.c
> > index dca32addae..64a030c6cd 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -26,7 +26,6 @@
> >  #include "trace2.h"
> >  #include "worktree.h"
> >
> > -static int work_tree_config_is_bogus;
> 
> So, we removed this global....
> 
> >  enum allowed_bare_repo {
> >         ALLOWED_BARE_REPO_EXPLICIT = 0,
> >         ALLOWED_BARE_REPO_ALL,
> > @@ -485,7 +484,7 @@ int is_inside_work_tree(struct repository *repo)
> >         return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
> >  }
> >
> > -void setup_work_tree(void)
> > +void setup_work_tree(struct repository *repo)
> >  {
> >         const char *work_tree;
> >         static int initialized = 0;
> 
> ...but we left this one...
> 
> > @@ -493,10 +492,10 @@ void setup_work_tree(void)
> >         if (initialized)
> >                 return;
> 
> ...and because of this other global, we still can only set up one work
> tree in the process anyway.  Should 'initialized' also be moved to a
> field within repo?

Good catch. I thought I fixed this instance in a later commit or in the
next patch series, but I seemingly don't. Will adapt, thanks!

Patrick
