Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DA356748
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923400; cv=none; b=gLn57lwOWw2an0e+cnLQExjDxgaJ7/soP0KUCO9SGZNRQvsiGXJppKevGCzkinMHb2+e1G5wvB+C3/N8jR5rhwl2oy2dD2jKD6rS5IN9EPyeEiYhgZPhX2XjOA1QBf4fUfR3fJ/NcLU+GkG9T/7vLYN36V3wXfSfuXMyHSULPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923400; c=relaxed/simple;
	bh=KfEr+hZH0iuuiTSGkZHPYs70nRTF9WFm6R6EadGYNgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPa5W5aXXXMledFtkILlQMx46fS+BCR2acNEKxqEslfVBWb6neo3c0OhztZpERifDgOItUcG+6MhfDlaW7ISt6JtlFITcPGLbe+wvOWvkfK1DJYl1xhdW04IOsxi0JLUK+hbblZhDTNbJgkdeDVFaFglI1x5fBUalwNFEF2wVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=djwE/iyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIlsMRSp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="djwE/iyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIlsMRSp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 28DC21D0005E;
	Mon, 13 Jul 2026 02:16:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 02:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783923398; x=1784009798; bh=vuEvnrLlFt
	dG60IpISF0rF+QSfMoQoph1z/lzPGkc98=; b=djwE/iywN5+skSQTmEdeztwqFf
	y5A9G7batZI8XGWI37zpK8cDTZehQ6+FBYtiGbIXKrpvFnFdV8re9ivXPdq+VIGp
	CHytFjD/TDqGnyeeE0CceLwgDDYYebblxiShtikKOVdiO0tfue9x6VThy6Fpp2dJ
	7GXFVRUSL/ePjwA8CzYUsHPp6ofhD3F4huHkk8NVWgk7U6NKqNeGif6efOEETvzT
	aXTge/n9PjAzSzVTzcykUABlELr4cE6dh2ert75XxMX0xR5kpaibYG1d9CC+mFwy
	Fmf212k38GJ01gbuVePEYMdLMeq2BUBvEnE+u9VlMdvYMqkqgWknuXT9a0rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783923398; x=1784009798; bh=vuEvnrLlFtdG60IpISF0rF+QSfMoQoph1z/
	lzPGkc98=; b=GIlsMRSpmT6jfXEaG7VUAAEbJ/Zner9rOHQtXTfCRGWxv8R7HrY
	R54Tn15tfSatGJFkbFyZyO+9cOskkH23NRfHYb23r1KWLyxT5E5/pWYoLa6L0vHN
	RbvoY2m+OFxtplu3isQczLxjckyVYt6rVyZnU14ShqBEllLnwTmyr8MHyLqgu84n
	nTyjKYMQtKvnqoEIiM9TzqmOX7luTF+ofxqyb5qp8vUmKXgKCyaKsDLtZ4rOieOl
	EnA+zGvkVTUEzNNtNS/L5CWAPJSiLFwDn07F0IQCr1MMuYmHVqe1NbSfK6fFz2hq
	h9TWETu1d38HsQ+4rT55At+7MfbxON4UKmg==
X-ME-Sender: <xms:xYJUam7kajaoYRve05Yz6Lb7aVr2VguzFi6ttofQqp6IxEbiZcb-_w>
    <xme:xYJUaiIb9Cw5_cwtHlvI_xQE8-VNhZNmYkSMMj_Vo_oEcyRzZNS5Y_uzvV0kK8Bx_
    iaG6C6tDGr9OD3uveqHijjsIbK0r2antVr3i-lPaE7H8H0LUphySgs>
X-ME-Received: <xmr:xYJUanv16945xcO5B4DUUPebikVsgyz-WrWepA_RUCNhMc6oC_Iav2DrsPGilols8usmMxs-wCByBp_D0uPPQViZ1UrkRfjkOHSHM4Bw>
X-ME-Proxy-Cause: dmFkZTFDUm7KCLVOA4HJStmMNSVO0u62Vvfavd4RRpyr/PrNY7hkYlpC5MvVGK3fWIllbA
    wDyVYyhqt07t251Qf8rvJl2BkNwvJfkrNrgEPvJx0SciNJkXwq6FO93z5/+ZYg6W2iEpEV
    86vlTHTW2kRBy5UvLVkUfFopZDDSgXinNSFdcdg/ezOb0wDaU5rKdHFQX/F1nUwPFQKTuj
    vKDj3ujQsCV51mJDPz702qPAVeOgM/bybV/41zZwzTjAW+YLBoHYj51QJi3RMQXaM+sazT
    Q+NUwZzPjFyC/zNN/QaX2UcZHcs6IWRl/hvE0rrY84fd+zuFiSehlXohWTC2uncbRwyPd4
    ZI+cJMs+tU0td+61fPHZ3vGKaGcynyG+1gphhSOGUG3vDkKhxpBvTJOXHsButqcJ+d+Vpp
    XHAvhQBQwonthcY7Mh3biM+FuWBlAHGWRH0zicADlfEXh2XBJ32LCHPcbZ6XkagGQS0lzU
    47NkNgm6M6ZWgHBygtra/iwNcDCj3UBMpbKrpdDQNwtzyw710M0Au3+OqmzmcKHFuXTChj
    XStw0BuagW+PoVTEWnwcVJSitTfOobK5iHPK0fuhRbNN3pLmCNaDV/7UKHS2rpk0FM2oQq
    B6QiPBHQurpKxIFw3Ywznhhws22YXbDMAzzceObB0XCq+C7r2afKIGz7BzIw
X-ME-Proxy: <xmx:xYJUapJ1F2_3mOyL6RAjX-o9g7lpmpXAKCisHY7MhITugauXv13OoA>
    <xmx:xYJUao8P66ZI1qXl3psqC3NBls-TOGzU8QPKnkejXVO0EKciWT21TQ>
    <xmx:xYJUaqx5Me73fPnZACzTVILJbiwmigoDitvc25d9h6lZISQGX0VIOQ>
    <xmx:xYJUat6xy6R8E0SLO42u_bAMR1Xm3Msg3RCB6UsbfivDDv3adeQXwA>
    <xmx:xoJUauaHBtsRVktdtBwsVs2E1HYza_WA5YhyjGrnSNbGyvhTXHSE5Nz1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:16:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fabc4bd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 06:16:33 +0000 (UTC)
Date: Mon, 13 Jul 2026 08:16:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Kristofer Karlsson <krka@spotify.com>,
	'@com-79390.smtp.subspace.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
Message-ID: <alSCv5I94qjbSucQ@pks.im>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
 <ak0D44nhSH/98WYD@nand.local>
 <CAL71e4OuU1+KHd0TrcxDX2dyoWEJXmi86m8u+E7vtxhcSF6M1Q@mail.gmail.com>
 <alFuxPQQcFxseAzh@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFuxPQQcFxseAzh@com-79390>

On Fri, Jul 10, 2026 at 03:14:28PM -0700, Taylor Blau wrote:
> On Tue, Jul 07, 2026 at 04:57:13PM +0200, Kristofer Karlsson wrote:
> > (b) Move topo_levels to struct object_database. Since
> > fill_commit_graph_info() can already reach the odb via
> > g->odb_source->odb, no signature changes are needed.
> > The write side becomes a single assignment:
> >
> >     ctx.r->objects->topo_levels = &topo_levels;
> >
> > and cleanup becomes:
> >
> >     ctx.r->objects->topo_levels = NULL;
> >
> > No chain walk needed and the diff is fairly small.
> > I am not sure about the semantics of it though -- should the odb
> > have a reference to topo_levels?
> 
> This seems to be the most promising approach, though I'd be curious what
> Patrick's thoughts are. The commit-slab API is really a property of the
> object database, but we treat these as a global as I do not recall them
> yet being touched by the ODB refactoring effort.

I was investigating several times whether we can remove them from global
scope and move them into the object database indeed. The answer is that
it's somewhat complicated because we reuse the slab for multiple
different things, and detangling that has proven to be a bit of a mess.

The other question here is whether commit graphs really are a property
of the object database itself, or whether they are rather a property of
a given backend. Sure, we can only have a single commit graph at any
point in time, so they feel like they are at the object database level.
But is the current implementation of a commit graph really the best for
all potential backends out there?

If you take for example a distributed backend to store objects, then you
probably don't want to have a single local commit graph that is stored
in ".git/objects/info". Furthermore, the current format may not even be
the best one to store the cached information, either.

So ultimately, I can see one of two approaches:
 
  - Either we make the commit graph itself pluggable as a standalone
    mechanism, too.

  - Or we treat it as a property of the object backend.

I haven't fully made up my mind yet. But I guess detangling the current
mess that we have with the commit graphs would help regardless of which
direction we eventually go into.

Thanks!

Patrick
