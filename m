Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130313B8D40
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527710; cv=none; b=dXn/CIxA/zYCOrLSKHfCIjgcvKVYSdLf+4VAGM7vFnckNbu7A/Y8wNCK6Gt9JtQyXaaa2gF8Ijv2/0u+wo1VgrgnKy+A5FWlMFs+8vVdvLEONMu3SFL16PduQTWNrH86cmQLMkZRkyO+/yvy1QTtSaOz5lyCJBrhYagcaGBRScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527710; c=relaxed/simple;
	bh=EYoTIIPPnziZh/OlZYxu4B26ztO+dzZJTkJsqKcDxqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdYin066k+wtxhFxfC9INjC8o9EhyvMOF5ULV7Y1dtEUlciNMLzOgNwoRXhkMULrykQcuB8TK5JR2f2EkYecG4tjKsVMWwvD88swYVTk0XnPxHpwRchFXYyWTCp13WPU6q1Poj/Uv7llxJM8F3lz9pCxmJTMTsjbf1BTf3vCZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eqO/FtDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKaqwd8p; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eqO/FtDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKaqwd8p"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 402507A000F;
	Thu, 26 Mar 2026 08:21:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Mar 2026 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527708; x=1774614108; bh=xoUW4Bg+qG
	FeBWBq407P5AnO37lyaqEOIuuHUb7i63Q=; b=eqO/FtDN2B070q2aveVSu2pt5f
	duNAvwubHfGvAsssof6lHf04eSYFum7qwLpfvSkoFhOl/Ff+njZqbz6FMaa54hiN
	KquteuNdiTPZ0IXaW3QamYVespdqoqZHdtJZpCsvhvC5JYOKXgFHYvlD6f0yWi9v
	VOBo7imbBBO0fJl7vz5W1BwFoUBC4bvksqSg1luW2iw+bHHGRmPB84ZdS3tWsHWl
	jXVbrqfVZSkBYeM2/xzUl/bjRHbz588dGqch/HWWMD70/g96p/p3eEG1wM9S7xpW
	Mt1coa/PNAy6wVlCvjUkGJimGb37wz64zq0PLhfpHRJ+sd7CV7LaXrSNgAVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527708; x=1774614108; bh=xoUW4Bg+qGFeBWBq407P5AnO37lyaqEOIuu
	HUb7i63Q=; b=VKaqwd8p905D+2XUT6/vu1+xk+6+c1EkrMTKECbRdnJ5U8w6x0K
	045J3LoGm80heyc7fBoipcnmLU1sI2aMqKpMpqSyxVCmdiit09o9NPUoR4lVwKla
	WQror56wb6bn/nPu0UR0IChs75LbrJ0zhJWIueEM4lUWXsvuYVT1wVM5IcZFtaBX
	X1XBC2Cto8GXdZqD1pK+IZdLsimof9tAu60mG4MiVEc3hIhvxnRvkppsudPQl4fF
	tV8cZDbqdUm5hHBDYfGfQFH53TgU87fw5Xsc1TNgJhjYTCx8XmYDw2FxoIS9IuvJ
	LBZXoTmVffyOxDH28m3j12KNzrB/m7Gk4Sg==
X-ME-Sender: <xms:2yTFaZ3cYolVf7LPrqRsbxerMl6CiWPlgg3oYG-CQ_0JEr4Wo1P1Dw>
    <xme:2yTFaSUB19ZjNXewFnmatsEW6ON8Weg4KJ3UacB0zrPfvsiRnA2hnMQVSqtrf1kAL
    H2FkKvG69Fwq_2nf02VXuL99CKyzReqDPMnz36Z3vaGX_56mqI9gEc>
X-ME-Received: <xmr:2yTFacKW8rMB26kZDNwnJdRh0eoVYaSLavcCLngK7AY9ZhcIA3ncsmDK3g18i0pHPR0-hE4fvQJZudFLS2atctF4iVb9krWYYBrXaZd5DIFqog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvefhfeeftdetleeugfdtuefgtdekuefgleektdehgeeikeduudeuveeghedukeffnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtgho
    uhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2yTFac3qQ1fr70BsCHoTqtKRD7M5B1pTaZ-8YAbIeJhWYZ6ZExGNyA>
    <xmx:3CTFaa77j6-gLfdiaPgl64FbwrPYf7ThydHb2SHXFavBgE7QZD53Aw>
    <xmx:3CTFad_cIVfH1KUE012dF4-OTrVtWXTDcZmoh-c_u0V_WgP7lefTAQ>
    <xmx:3CTFaZXASfkCzZ9JMJi6HDlcsbw57VnbIdxSpI1aU8Pb2TfaRqdE-A>
    <xmx:3CTFaR7LzvI0n_qbGJo8T1OV5KNMcABQBv217MjNdHJTafn-jIuQn8SK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 652bb2dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:45 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 15/16] promisor-remote: auto-configure unknown remotes
Message-ID: <acUk11mt06GJZaur@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-16-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-16-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:18AM +0100, Christian Couder wrote:
> Previous commits have introduced the `promisor.acceptFromServerUrl`
> config variable to whitelist some URLs advertised by a server through
> the "promisor-remote" protocol capability.
> 
> However the new `promisor.acceptFromServerUrl` mechanism, like the old
> `promisor.acceptFromServer` mechanism, still requires a remote to
> already exist in the client's local configuration before it can be
> accepted. This places a significant manual burden on users to
> pre-configure these remotes, and creates friction for administrators
> who have to troubleshoot or manually provision these setups for their
> teams.
> 
> To eliminate this burden, let's automatically create a new `[remote]`
> section in the client's config when a server advertises an unknown
> remote whose URL matches a `promisor.acceptFromServerUrl` glob pattern.

Would it make sense to extend git-clone(1) to have a command line option
that basically does this as a one-shot? Something like `git clone
--accept-promisors=url:https://gitlab.com/*`? I assume that many users
may not want to keep on updating their configured promisors all the
time.

Furthermore, this here reconfirms my thought on the previous commit that
it would make sense to detangle accepting promisors, storing them in the
configuration and updating them automatically. These are all different
things:

  - Accepting promisors is basically an ongoing runtime thing where you
    start to use announced promisors even though they are not configured
    at all.

  - Storing promisors is typically a one-time thing that you'd want to
    do when creating a new repository.

  - Updating promisors automatically is probably something you want to
    do on an ongoing basis when you have stored promisors.

We're currently putting all of these use cases into the same bag, but
they have very different characteristics. I guess the most common use
case will eventually be to never auto-accept promisors, store them at
clone time, and keep them updated whenever they change. This cannot be
expressed with "promisor.acceptFromServerUrl" as far as I understand.

So ideally, we'd have:

  - "acceptFromServer" to configure ongoing runtime behaviour.

  - "storeFromServer" and a one-time command-line option for
    git-clone(1) to configure which remotes to persist.

  - "updateFromServer" to update stored promisors.

Patrick
