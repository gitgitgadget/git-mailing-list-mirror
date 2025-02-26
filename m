Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DD2FB2
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548714; cv=none; b=Z40zC72T2uZEMszqGuu44UA0oTF5urgJKbCgWrkjvUX68ZIVRZiVAh+V5lySjgR8zFWweerAHljIivHUT3hwqASJ+v7GVgO7Ar17QoCDG2Bu/s8ibGK5brnN9FHUKaUcuuri+oFh/GPggrF/8wTqwsrYEPXKoFCBB2g9xaDIQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548714; c=relaxed/simple;
	bh=57B1DkqRpbos792fd2uF9sk1Iezl9iuy8F8IR14yOvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNy40kwSQZg5FcM701AOepDJ3GFbhnFGFYPEIIcWC5ja+DMFer3IKhVn/mbkAVZspHcAt3daAZyR+sDMxhiDpzYF6ROxSx2tFCazyhGiKWj2RM0wyrcy7MnLtZNdyMchNAjRJHpkyEyh6/AP7crEvXeMuGSEsP82Y4SetZiN0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cSznxyL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNzuPofN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cSznxyL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNzuPofN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2EFA325401AD;
	Wed, 26 Feb 2025 00:45:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 00:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740548710; x=1740635110; bh=HFfMsqUBJ/
	PN6uLuBWLit/d6A0s7KYE1HNhC92pzKlE=; b=cSznxyL9tqEA+NlqI0RhxX9fY2
	EKxEM10rZprS+8QeXJpM9Vi6uNKKE/ofsVlcjp8BY+iADD6YZT+gyVxjDkx/7hAy
	MuexvSzyxQkRWiKERO2QDGgOUjbcIDt7onpuZAGbvspi7LrftjXfkFeeG2kdDhdB
	+rv5RdAG8sTD3K5Grq6tBaw8YPZhEVaqVNUdIFnbLEeyLSrOfHdQNYcHC3NdCp+W
	cFuxUPmhR77sP/aaVdF9dwC73+z0ETs3lqiCZgTnII4RSt/W+sjGMMx4SfXwZbn/
	CbGbYkSIpgjt2+Sy56KxJ7IlRn2Ge/fcUJsDROXaLrooOmYRqs4HJFxeAV/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740548710; x=1740635110; bh=HFfMsqUBJ/PN6uLuBWLit/d6A0s7KYE1HNh
	C92pzKlE=; b=UNzuPofNMqPBVUpUNdqHGG+Nnj7d2rc7e3BqAeUzsuhAvW46IDJ
	xYCsbz/7djOF+KNK+L+kSNsUBTwyZwzamSUvTj92sdnA/ZgWnxN/jMV86ZXKNeXf
	+jzrOv+oq0vJPoC6YzqRxiThrIbz9sfI1ipIROOEfS++gLrBuDzJlw2nOI58BCsg
	LonuH1cVWm1686V7JxyeX3Gl8uu5a2drSyDvO/lf/JMkKeR673FLuX2BVmDjppAd
	GWA0xDOr1c9Ybr48OA9LJPu8GmPZT87fpoA836S/Phe/ZZ6bxdKLlnUPPI1W5e3f
	TouImJ0jAxnfjM1SzfLtg7E//YVI1Goq2tA==
X-ME-Sender: <xms:Zaq-Z-DAe7RqlFrpxWq6NZoVs-D3Pej7bFvFRPFGU6mK-WSTKT2AyQ>
    <xme:Zaq-Z4h7cF5oIzScxhDLCj-r-zVf7vukaTQQT-U8bXZK522nyQBSdBcis1Zc3vkse
    mQLcU_NDz4ityamtA>
X-ME-Received: <xmr:Zaq-ZxkhoQ1yArlSsKWswwYKmn37qk6EaG_9HDBxqviH6tGvxOKa3jUKabZ9vVfZSFnYHiq2mZMlbyqP06ph8erIQAiBmYvGOke8896pg0kv3hAF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfeigfdvff
    dvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecuffhomhgrihhn
    pehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zaq-Z8z5RgfXRmjyWZVb-HEDdFuo-ei25muMTc7elydU63Ub4CzfVg>
    <xmx:Zaq-ZzRo-UkpM9dtRgR35haxvBAmmq0m8EQqyi9eCY23QpQG4fRS2w>
    <xmx:Zaq-Z3aypjtnlgMb05fDpPf-VpRQtbjkDkM0vxd2XY7nj2moQrMs7g>
    <xmx:Zaq-Z8SRtXURGmjWn1yYn2XzB3E36_DQydXR4ENAwzdjoKv10yR16Q>
    <xmx:Zqq-Z-fHLYlpSAeCvZF7WO-TB_MSOeWY1BNSlceZuNnvo8D4z6ZON51J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 00:45:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 764b4632 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 05:45:07 +0000 (UTC)
Date: Wed, 26 Feb 2025 06:45:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <Z76qYgV7B2eUJHiP@pks.im>
References: <xmqqo6ypiz9w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6ypiz9w.fsf@gitster.g>

On Tue, Feb 25, 2025 at 11:45:47AM -0800, Junio C Hamano wrote:
> As of yesterday, 'next' started failing all the "win+Meson test"
> jobs.
> 
> https://github.com/git/git/actions/runs/13506034920
> 
> I had to do one of my least favourite activities working on Git:
> bisecting CI breakage on a platform I have no idea how well it
> works.
> 
> Here is the full "stack" of changes, it contains all the topics
> merged between 'master' and 'next', plus a single change that
> butchers .github/workflows/main.yml to leave only three jobs
> (ci-config, windows-meson-build, and windows-meson-test).
> 
>     3a7e83b527 Merge branch 'ps/build-meson-fixes-0130'
>     e59193e984 Merge branch 'ek/mingw-rename-symlink'
>     a209cf1427 Merge branch 'po/meson-perl-fix'
>     9f1e73677c Merge branch 'ua/os-version-capability'
>     82f01cb375 Merge branch 'ms/rename-match-name-with-pattern'
>     8b04381049 Merge branch 'ad/set-default-target-in-makefiles'
>     2cab1bd7d0 Merge branch 'pw/merge-tree-stdin-deadlock-fix'
>     92b43de9df Merge branch 'mh/doc-commit-title-not-subject'
>     685c150623 Merge branch 'bc/diff-reject-empty-arg-to-pickaxe'
>     c5093fc2d8 Merge branch 'tb/new-make-fix'
>     9091607e95 Merge branch 'da/xdiff-w-sign-compare-workaround'
>     01e86410fe GitHub CI: trim and slim for win+Meson test breakage hunting
>     2d2a71ce85 The thirteenth batch
> 
> At 01e86410fe and e59193e984, CI seems to pass.
> 
> https://github.com/git/git/actions/runs/13528755524
> 
> With ps/build-meson-fixes-0130 at 3a7e83b527, all the "win+Meson
> test" jobs fail.  I suspect that the series does not break
> individual tests but the breakage is in somewhere more
> framework-ish?  I didn't look into individual test job failures.
> 
> https://github.com/git/git/actions/runs/13529323827
> 
> I'll also note that in one of my earlier attempts (which had
> ek/mingw-rename-symlink merged before po/meson-perl-fix), one of the
> 10 "win+Meson test" jobs failed ("win+Meson test (7)" to be exact).
> Rerunning the failed test succeeds, so there must be something flaky
> in t0610-reftable-basics test that is exposed by this change,
> perhaps?
> 
>   https://github.com/git/git/actions/runs/13528071468/attempts/1
>   https://github.com/git/git/actions/runs/13528071468/attempts/2
> 
> As the ps/build-meson-fixes-0130 topic has 13 changes, and each
> iteration in the above exercise took somewhere around 20 minutes, I
> won't dive into the topic myself to identify which one of these
> individual topics causes the breakage.  This however gave me enough
> to go on to today's 'master' integration (mainly, by mark the topic
> to be held in 'next' until this gets resolved, and deal with the
> other topics).

Hm, interesting. I didn't notice those issues in our CI. Thanks for
diving into it, I'll figure out what has happened here.

Patrick
