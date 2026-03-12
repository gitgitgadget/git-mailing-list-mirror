Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99F3AE1B1
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300437; cv=none; b=IMNVj+SjsOkUs7al51DN0Rv1rwAxKzzVgSxcgcwBVQZE2LQzoA8kmB2hKC+8HQmVtx6QkD1KlotOETbyjeDYTHdCMTrnPplR+aiUhHG2cWcUlLcZ4WAPVLQkK+ZRwnaCAMjkn5NJ0kAhckkAVAF/ZcAtKwYXeJ0Ljjic04U1W+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300437; c=relaxed/simple;
	bh=DUSS0vMwjZy9Rsn2vHq1nz06hA3NvfkRUMBSV//Yfxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYUWFBFsnyZMgoh38c6yLT+n0coVHUfcDKKtMxGWYAQfdyf++4ZupLXIoWC15a5LSz9SdoBIAFXwGWIJDY95tXGRkWWmj14OthhUWFrxZXHIevZJ735hyWd8fE05R5Yq6BgjxX1y6YK+RPhqdmQaXuvJM/tGzhKVakSnw4C5Pks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K3zgfeo+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9W3M9Iz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K3zgfeo+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9W3M9Iz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D3791400188;
	Thu, 12 Mar 2026 03:27:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 03:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773300431; x=1773386831; bh=q/RVh48DZz
	wMA52MdsR8Un3t1LhhwUfrxGFfq/b2YcE=; b=K3zgfeo+hLnyJ+hBDTMoPxay+J
	2xO84jbaeHqVDtNgJuCqrtigyX0/lH1BHqgM666rzPY89JCAvSnBz9tU39gb1EPR
	8GyrdjYAVBTzGKepdI8nQBq8YdC3mKT2+WKTe0Zqaz6BzhqLMqwTlhINQ9crFuKG
	ZI7wZTS9SHT2aYmi2LCU/V3Txv5Q3aTZCeYFE0ePuZgOEsuKywvBJCf0JIBwic+s
	8uByKz5Drbgykcjg8DxdipNS1pzgpStWdEoWpIZiNioR+VyvZoZd+ZihPT6hmHtc
	bUB1G5xsYLfpwEcfaDKMNOlaxTxb4oPaWxQNQ16sROaDEsxy2IlDARu9oxQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773300431; x=1773386831; bh=q/RVh48DZzwMA52MdsR8Un3t1LhhwUfrxGF
	fq/b2YcE=; b=G9W3M9IzinimtVzirkC64BKsZ4rT4UhuV2I38ATdAMQoKyObipb
	RWgI5HfWtD+0AtkxYakOWChUbbtmzdubzClN/LcPlr95qvAMTYndlCgFUjhdbko1
	N0SdntWdhJU2O2PGh5EauQ27kqBd1L4NQFm1KHil+Snrg0nP3MdU5rhnfJvx4qli
	Y2b+zbR0wmk3+z65Kg/velHXoupB1tCakpv2xgaWTpgVLB+hkNUouHP7QGzEGQnr
	VWQR/o+8GdGisTKdC5iGfEhVnBmPVK9garamzH678+g4wpF6JPlr5pet1bwHQ1cC
	JPtN9FcOO8qrTTz4YfXHKPLgzCVOASfRT/g==
X-ME-Sender: <xms:z2qyabwI1bTpYEzFAxMpWwu4YRHw0qa0qx80_SrPNa8u5ekBK6JOxg>
    <xme:z2qyaW_hTnGXvAYg8-tgsEzti8u-CJcKXD9uOoMfd45VByssWlV9Tu56JF97Vb7f6
    Q7eRiJYQ5Su5lf83N2Kn1MTZTDYo9adRAeQ6wb5h6S2PzyavH-U>
X-ME-Received: <xmr:z2qyafIQN3pzMu-MWd6g58dmKpwBL1N8n7p_GsbGv4Q7k6dJfeHvYGpkOsjJggJMGMg7mMQkpiOC-e2qae1e6VPtypYlJuIfiHN0pu1HvtTpYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeiudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehhrghngihinhdrhhigsegshihtvggurghntggvrdgtohhm
X-ME-Proxy: <xmx:z2qyaccSseGF9haJZN8i-6ACB1czF8xtlpQ13YintUspanUKYK3Bgg>
    <xmx:z2qyae-XLXfV0XL6pmymsORMacHGOIXMKsD57UbHpIt-DpbCaubGJQ>
    <xmx:z2qyaZqJbpaeZczEJcQ9Xa3IOQUSUk6Tny5bSLt_8vEnOGiSVUCwtA>
    <xmx:z2qyaTBpsdDKyBATm_dqn1uv-tq2jb8tePo3BtsoBJawpQmFPB-CXQ>
    <xmx:z2qyaYOqcbCJkKCrXTOxcmVzxYnFOZgyj3pUnNPTWsNqrhnG3NUl9GUI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 03:27:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66870bbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 07:27:08 +0000 (UTC)
Date: Thu, 12 Mar 2026 08:27:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan <paul@paultarjan.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, christian.couder@gmail.com,
	hanxin.hx@bytedance.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] promisor-remote: prevent lazy-fetch recursion in
 child fetch
Message-ID: <abJqySqfdFoY8cEu@pks.im>
References: <abFJhFhHLhS4qdrM@pks.im>
 <20260311141846.12315-1-github@paulisageek.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311141846.12315-1-github@paulisageek.com>

On Wed, Mar 11, 2026 at 08:18:46AM -0600, Paul Tarjan wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Is this a theoretical concern or a practical one? I would expect that
> > backfill fetches never cause the server side to send a pack with
> > REF_DELTA objects to nonexistent objects. And if they did they are
> > broken.
> 
> Practical. We hit this at Anthropic: 276 GB of promisor packs written
> by `git maintenance --task=prefetch` in 90 minutes against a ~10 GB
> monorepo with ~61K stale prefetch refs pointing at GC'd commits.

I must be misunderstanding something here, but how is it that a commit
can be garbage collected if a ref points to it? That shouldn't ever
happen, as reachable commits should not be pruned.

Or do you mean to say that the commits don't exist on the server side
anymore?

> > Hm. Can we craft a test that shows us the resulting failure in practice?
> > Testing for the environment variable feels like a bad proxy to me, as
> > I'd rather want to learn how Git would fail now.
> 
> Good point. Reworked the test in v3. It now injects a thin pack
> containing a REF_DELTA against a missing base via HTTP (using the
> replace_packfile pattern from t5616). This triggers the actual
> recursion path: index-pack encounters the missing base, calls
> promisor_remote_get_direct(), which hits the GIT_NO_LAZY_FETCH=1
> guard and fails with "lazy fetching disabled". Without the fix,
> the depth-2 fetch would proceed and potentially recurse.

Great, thanks.

> > Okay, so this seems to be an issue that can be hit in the wild. But I
> > have to wonder whether this really is a bug on the client-side, or
> > whether this is a bug that actually sits on your server. So ultimately:
> > why does the server send REF_DELTA objects in the first place? Is it
> > using git-upload-pack(1), or is it using a different implementation of
> > Git to serve data?
> 
> The server is GitHub. I did a blob:none partial clone and after some
> further git operations ended up in this state. I don't have
> server-side data on why it sent REF_DELTAs against missing bases.

That's certainly curious. Do you maybe have multiple remotes attached to
the repository, or are you dropping/modifying the object filter at some
point?

All subsequent fetches need to use the same object filter as you've used
during the initial clone, otherwise you may run into a situation as you
have described. But in theory, Git knows to continue using the filter.

> > Note that I'm not arguing that we shouldn't have protection on the
> > client, too. But I'd first like to understand whether there is a bug
> > lurking somewhere that causes us to send invalid packfiles.
> 
> Agreed, there may well be a server-side bug here. Regardless, the
> client should fail fast rather than consume unbounded resources.

Probably, yes. What I'm trying to figure out is whether there are edge
cases here where it's _valid_ for the server to send a thin pack with a
REF_DELTA. Because if so, unconditionally disabling the lazy fetches
would break such edge cases.

I don't think there are such cases, but I wouldn't consider myself an
expert with partial clones.

Cc'd Peff, as he's implemented a couple fixes in this area a couple
years ago.

Patrick
