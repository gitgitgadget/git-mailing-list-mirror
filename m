Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC455392C48
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023865; cv=none; b=OhBppPgz0zd2mW5G3FqTKLztHeiD+sLKC8rEeaI/V9CzSnrKili+fi/4zScDUICdwt0ktx6vZ+pfsMS/5C+PSOuCMjMBnR63g8NEEfIlTpW+ITyEgfGOZvwFyfeQgbRzYryUe2QVu9qF8ceWVVRfgOxWKbsGcU7RBQpBvfIXRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023865; c=relaxed/simple;
	bh=PFfu6gexGunyOvmGVgBrZsFbZgfCgccKj4H5y0yUNQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsEtOnMWDKQbAXcOv18PGqsTliL0Tmu9QlpDV83diqtbhtyW5qyLwJ3xifHBo1y+pGz/tAZlIDdV6z3hVExYRx3ab6rN/0uMdgVmTkxjZfVtp6W8eA8GcvaRQBsvr7tShRCvltPqFf4V5Wz66JMOOKFfn43Uzx2hUN9hu4Kxwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EvqAWP9f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SD/n1eml; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EvqAWP9f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SD/n1eml"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFD557A0132;
	Thu, 10 Sep 2026 03:04:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 10 Sep 2026 03:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789023859; x=1789110259; bh=7NSWogEAGw
	7OZhjGuV/8SwWdv/ajqpDEmYFeiAjqoLw=; b=EvqAWP9fZhNJY2f1/hf/dMPdpT
	AmjkVBWQ+Hnrm/prNpMrtGO8IsH1yXgwCwEQ/XsUVs3O8GrIzoLbBpybJ7WaIHSJ
	C9HjKF6gDopdry3oBEJ++4+3o/vpsY/WMIbx0RzW1Id3qakl3c70DsyIHDfEh2O6
	/3o/Ooh7ErHklanoOsLWyMldP6Ls2PQwEfxQiuOzSG9m4sLr07FZanKobzj0ML+D
	8wCRWmOOnZvFR984o0N0gsre6JFWf203sTOXeBiQofv9d90zn667J/thK97sLOBR
	mVyfL9QipNU5Gm6aM+mEOMkMQD99nFebf1Ygro2nai+p4cFibIsgTg6Mnvhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789023859; x=1789110259; bh=7NSWogEAGw7OZhjGuV/8SwWdv/ajqpDEmYF
	eiAjqoLw=; b=SD/n1emlWq9VnmDk0leZxn/iTlEtPxAxliGx2c23gkO9MzphFz8
	KjfFB6+EQaUGMzf3iDrQHnj2uimsIw2vLAjpminAGxjYcbICViyfF/5/3KuovB7B
	kltpv2KtN0WSbBzopRqdxcbpUw+ye2jKnwgyCAIYJEukgKgMKkyFB6UegXIFF3+9
	3Ue7G9tB+rp9H5pNFhnIDla0p47NA7WdsL6wU7Ype3GVYUeuXHEwZxrBq2LA1lVY
	2ABpglHS35OipzeOux/o/xlh0gJRUj7p5w4sN0z2b9l35J6xYqbYbUzr1cbhvqHc
	AIvzAloaq8suSzLU5YimX0Urbmd16IJ18GA==
X-ME-Sender: <xms:c1aiamhI-2B7jbz5rIWo7KZUKJDvPv6ZYxwVJmhJUeeyPZmaQI5XhQ>
    <xme:c1aiat4qGBmZiFo2CRHpDxpnAjNR1yF4NbD9zo8JLxBQ4z4RyCY_qRg1y8jUD3Mmi
    5QTQ_a6r-fLlaYtcoLxf69JQMi9g-tnlIumCoopkjFhCc-7A4dlj4s>
X-ME-Received: <xmr:c1aiamZHiBG7tSYz-ASATigME62jPk2jRVp89uLeiWqOr-CcJLhv7Q>
X-ME-Proxy-Cause: dmFkZTEk0L3HpALCiE6TtBb2I5fX0Zczcp8mWSvz9GNppDuMaOOnFDKAGvua+JfzvLj2YV
    4AERTVSa891OlpMUszD3VICN4plONrXhxLC5O9Z3nt7GIZxpo9EdZ/FMubPvVkIcMB3Oie
    yI6+bYbEh6GUb/uk987wiRp5J12vLFwNZYObzHi7s1mXlKhLRofb8OjikDx/msYLz8JWWC
    lH5CkPgQF0ndWDNJJd2J+hKmZczCnC2rFplQ9BQvFsKHTIkO3xvcDzQjs6rW2iQhjKL1Vc
    AhdEp4LKJD3kYswbSL67jDHBPg/2G4rQFCBh+esst8hnYb/Ba86kmeIkI/DwOM4atuFXqX
    sA01PnUxRV4Ku9qI7KOPRWqlc6vnx8yXd0pf3HHuuVkdFrt7TdB8j+IXx5GuEt2XH/wpmV
    XDL91M10mpAdvodt/RENa8iab/I+rqhha36aM2Xoep4e1lEkE16mbREFPEgowMkZd2A6bo
    fiiBCU0tfrZwLjX3r0MAoqDUG7mhFnVr3/pnPbn9J43n8y15OwU2xEvSqkbpnG2TUIHP5W
    Qn7Ii46f3vlnVCFeKilx6f9ktyKKq1v0MYzJoDhVl9xtjfwSIDe+f3yJhhGAyHnX4IBTb7
    z8IWLph8i5DHACFMhMlha117/Pxo92utKoKQKomaa0OPcaO6Vn6UXsW++4cQ
X-ME-Proxy: <xmx:c1aiaq401bIoVtyaPd962uKL8qlHu6odlCP1VYcRhJoYMxrUqt63Sg>
    <xmx:c1aiahB_mVueJCXRSlfzkCxSV7aGe70JWklHBDAXoGOw4fGyGh84Zw>
    <xmx:c1aiaofTP-9GfoALY505u5CFBZoaBFVtVVlrNxzRwLxK5nUDsm1itA>
    <xmx:c1aiaoKi5Z7ebixn2qTiKmU9wWUJ0lwV7p9_egfkaLzeSLmp69Dw2A>
    <xmx:c1aialKgPDIqs7mPzdzdqxz8ttFOeFtO_pN94CHE-FPIngJMoBx3Ymn3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 03:04:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff91d35b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 07:04:18 +0000 (UTC)
Date: Thu, 10 Sep 2026 09:04:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 5/6] last-modified: check pathspec against Bloom
 filter first
Message-ID: <aqJWb1kq81A8AJWI@pks.im>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
 <20260901-toon-speed-up-last-modified-v4-5-a09949800404@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-5-a09949800404@iotcl.com>

On Tue, Sep 01, 2026 at 11:10:25AM +0200, Toon Claes wrote:
> When git-last-modified(1) starts, it builds a list of all the paths
> matching the pathspec it needs to find the last modifying commit for.
> For example, every file and subdirectory listed by:
> 
>     $ git last-modified -t --max-depth=0 -- src/
> 
> As it resolves a commit for each path during the revision walk, it drops
> that path from the list.
> 
> To avoid diffing trees for every commit, Bloom filters are used when
> available. For each remaining path, the commit's Bloom filter is checked
> to see whether the commit changed that path. The Bloom filter says
> either "no" or "maybe", and only in the latter case is the diff
> calculated.
> 
> git-log(1) does this differently. It does not expand the pathspec but
> checks the Bloom filter against the pathspec itself. This way, commits
> not touching any path matching the pathspec can be discarded as a whole.
> 
> Apply this same check to git-last-modified(1). In a previous commit the
> function revs_maybe_changed_in_bloom(), used by git-log(1), was made
> public. Use this as a pre-filter in git-last-modified(1). After this
> pre-filter, paths are still checked one-by-one to only find those which
> don't have a "last commit" yet.

So in theory, we _might_ now do some of the checks multiple times. But
the expectation is that the number of pathspecs is typically much lower
than the number of expanded paths to check against, so in most cases it
should be faster to do this pre-filtering?

It'll probably be possible to craft edge cases where the new logic is
slower because we now do more work in the matching case. But overall I
think this is a sensible tradeoff. After all, we use the same tradeoff
in git-log(1).

> With `--show-trees` the list holds more than the paths matching the
> pathspec. It also holds each parent tree entry, up to the root. Each of
> those can resolve to a different commit. Thus for the pathspec "a/b/c",
> the list will also hold "a" and "a/b".
> 
> When a commit touches "a/other", that commit could be the last commit
> for "a", but revs_maybe_changed_in_bloom() would discard it, because it
> doesn't match the full pathspec.
> 
> Instead, when `--show-trees` is given, use
> revs_maybe_changed_in_bloom_with_parents(), which indicates the commit
> maybe changed any of the paths leading up to the path in the pathspec.

You explain what we do and why it's safe, which is good. But what's
missing is the "why". As far as I understand the reason is performance,
but if so I'd have expected a benchmark demonstrating the benefit.

Patrick
