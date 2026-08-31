Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FF36F8F0
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187683; cv=none; b=bY+zAb7d4smznQ6Mt0MNaqZne2i39eyY2w18QRdnKdovtBbzPe4HXJOmwFHXJGKFMhunHs/G+jOFiuKwFsn3USHfNnynYjk0tv5tl4Xl6ykEx6l66vMwQDDlTJj1+bPQBiLF/vJGSMyBRkxHYIyT1LGs/lkQAoqc7IQ4PI/1geE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187683; c=relaxed/simple;
	bh=bdL/fbrU7gkgLvLenaB4Gnqmr7EuUSersj5J3XgBIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7QafDSj2tEzxTN3GUfKJ+NYB3uaYV1OZeNZTwZJ3eijDhaxs3n4EBS+82lKqKtQBbwZv3TVLbdfq2PpDr8yaVqy4ODmukh//GEC8QPCnyT4wPLxnlGHDdLFc8b4IyT5Wf58HiS5oVWdZol5qyFJr4ZCDRHgZjyXfzXm9Xvr6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QdUULI8r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZZ8RvhH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QdUULI8r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZZ8RvhH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 030BD1400154;
	Mon, 31 Aug 2026 10:48:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 10:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788187680;
	 x=1788274080; bh=rMuKXOMJdZtJpQlWGymi2MV0NxdVcr2qWPzmDWjoV50=; b=
	QdUULI8rcSyVAyq06l5hPg/FJawyN7CqmPcVZU+MX12/+gIWhMvlejKLj4DAwzJC
	3DcxZHGPnupZJ4QaElp5CNBqCwhmxstur13r+0GAA+FJMEEFEI8pgPDhh5OLsO87
	ly43VqlfpsRjjtoGs0YO1+R+9+kXxpZu7p6vYcNUW/VMBhslQF0oJX3MhtqoqwhI
	fLSelNnGc/r1OWadfLwx26qFXtizuekS7BNDRZKZFywXy1gD+6QnrAJ//f5IK9vJ
	szDXndtxPMaYfGTS/YkK8WWvaWPsr3XsP0j9qiO2Iqw+dvBXewMpni/iWVxnpQor
	DkyWQONInQzI3UOAivy22Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788187680; x=
	1788274080; bh=rMuKXOMJdZtJpQlWGymi2MV0NxdVcr2qWPzmDWjoV50=; b=i
	ZZ8RvhHCVzTbS8x57b74On34FBMcbhLOPA+dWDZHE2lC55t7zBPaZt/rHHDr5TMl
	vJtec30pr9VdiISRhPNVw6B9dGVX0xe+RyH4FDfCCZR6p9B1Dc6YkVKlR4dIPxNy
	yUYh/p4boPspFhdYePa14ybF0DyQ6Jo26NPTZHNIAxkVbRpx61wsTrcNoZeAWHHM
	ydGLeXG0uZZ1cjN3p4QuZCCr4AXqMVV69BbWfmeh/vNKAKn6HMEr5luT9pBEtps1
	3xHo/+on2gafAhuHR+t+cpltN21/zq/TRc2GKa0TLDtPTKC0Ui9OKuvGz5zR+1Pc
	LLKDXOkfbqi5DISATD90A==
X-ME-Sender: <xms:IJSVah4p01JymT5HTampqbYKnKahe4CngDXZ1tSHp2b2XwapJaLLDA>
    <xme:IJSVaim38t2Xg8hxtlU-1UYhyqdkIq92obLB_dfAgx35mlKzjpRDBWNvl1Hcs1zMw
    HOWsXDiIMHk9jylLKuOJ0h0yF_u7-dd_Qg9sBxAZbme3BwEtuynmw>
X-ME-Received: <xmr:IJSVaiQtdkFiXQ_va-OnXH2b7XiprWzR2TBBRjLamnRUwmWmIO-SqWDBybNC7mOdXqpiYw>
X-ME-Proxy-Cause: dmFkZTEY4gBnCHm9OnPGstjPACE4XUN1RkL/GA1EZoi3itt5B67BPt2yVcD6P7W2NFgdlI
    Oo00TnxBDPbOeVvcdf104ZmDSrmfYtK29Y+FTj34LtUiahgj92PBvpvnZNUJACyEodcIqg
    yR1gc8ZZaJK+jSEGqdSSqiPxytdeoHludUlqpLtmeV81sHYzqO6Lb1k8Kcfg/Y0pUBrZ3S
    IRonQe+m51SI3I1cMSXXiJNh3axyiCyWgFWIEq/LRrPpBqcIgNglcCkieeAJ4bZ8wDiVrd
    mBqms7GOzAPiZlW+mM2BsU9lP7EWKTKbIpqbP48GljTIHql5+n+uFF/4mtjReLzC87A/Dc
    JFhlDRZQixV/xPEsa76XSerAYQb+QEFDYSogI5IRbw0fcOvFZ5AP1d7VGpI6BrT65RB77x
    VOycDgUixRXXtMjtTZGILfMMA9h7wP92PjWcg4uHJ+HHuEvc76d7m7jysLoOn1HXY4BqDt
    yZPRk9mBf+1b4nGGfvVs3nIX9zLBCkvz16BN4c47zuHHqCpKweFMgtEJykD5ngmr+erMcs
    X9tb9NDgUliGj0tpqr0hSgOeLYMn+RPdnN180dh8U0NxQKKqawhrhaGQrhheZLNKSSB2jV
    I7Wexsqh3wIiMKSCK0lDSYmoi2c1xsfK8td/KyqLbIYBs7Wm4mOKt8EYhtiA
X-ME-Proxy: <xmx:IJSVahEA_cTxGIKArnRDb-J-4bu0p7W2MyVBgVV5OpqBVzAQtmvxkA>
    <xmx:IJSVanEc6mHO1usmaOkwl1qIBoRCqR-Z1aF-cu66CGQWHYOV9wetsQ>
    <xmx:IJSVavTAl8v8jWvo62QYVAdcJaUtiRnLTvTSDzIXW1wREoSF9PLAHQ>
    <xmx:IJSVaoLW8I2MneoV51hWiICDXMDme6A6cZHPz6wfet536jB1Lh99EQ>
    <xmx:IJSVauFEiMCjmk9SnLCzXAr-002DJRAlCmOu-0wfDyynpgf_7WSDmCnV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 10:47:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be6dc847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 14:48:08 +0000 (UTC)
Date: Mon, 31 Aug 2026 16:47:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <apWUGfzQxx7vArpo@pks.im>
References: <cover.1787231825.git.ben.knoble@gmail.com>
 <cover.1788010335.git.ben.knoble@gmail.com>
 <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
 <xmqq8q5n1fa2.fsf@gitster.g>
 <CALnO6CBejkZTgPM9tK6TEGeNYSRfi9r2-xi7R4ckTsRm4ZGaQw@mail.gmail.com>
 <apVJAzddTPPCI7kA@pks.im>
 <CALnO6CCNwXC1_PUCTWEU-HXBk+W+sBGqn7Sr8D=ZHW3Mxcu20g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CCNwXC1_PUCTWEU-HXBk+W+sBGqn7Sr8D=ZHW3Mxcu20g@mail.gmail.com>

On Mon, Aug 31, 2026 at 08:57:49AM -0400, D. Ben Knoble wrote:
> On Mon, Aug 31, 2026 at 5:27 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Sun, Aug 30, 2026 at 08:27:13PM -0400, D. Ben Knoble wrote:
> > > On Sun, Aug 30, 2026 at 5:15 PM Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> > > I would happily prove that at least none of our existing tests fail
> > > with core.useNanosec=true, but I'm not really sure how to shove
> > > configuration into every test invocation of git. Even if we could, I'm
> > > not sure we necessarily want to add another CI job for that (though
> > > that's a separate matter).
> > >
> > > In particular, (among others) I have not received any concrete comments
> > for
> > >
> > > > Comments welcome: I haven't touched any tests; I saw a bunch of hits
> > for
> > > > "git grep racy t" but wasn't sure how to fit this particular change in,
> > > > especially since it won't be equally valid on all systems? Advice
> > > > welcome.
> > >
> > > so if there's at least a way to exercise this path on all the tests on
> > > my system (which should support it), that would probably be a good
> > > thing.
> >
> > Yeah, I simply don't have a good answer here. It's messy, and I'm not a
> > fan of the current direction of `repo_config_values()` because nobody
> > has yet stepped up to untangle it from `the_repository`. I gave it a
> > quick shot at one point in time, but the result was messy at best
> > because of how we populate it via `repo_config(git_default_config)`.
> >
> 
> I took a quick look (being unfamiliar), and yeah, it does seem pretty
> tangled. I suppose one way to go about it would be to have repo_config()
> forward the repository argument through configset_iter to the config_fn_t
> callback? I'm a bit surprised (leaving aside how pervasive the_repository
> is otherwise) to see it doesn't already do that :)
> 
> Is that the approach you took? Or, where else did you feel hung up about
> the resulting code? Just wondering.

Yeah, that's what I did. I don't quite remember what was awkward about
it though. It might've been that callers have to be aware whether a repo
is initialized, and whether it has all info to be able to read its own
configuration? Or I was trying to make it auto-lazy-load or something
like that, but because our config subsystem is so fragile that led to
lots of weird edge cases.

Sometimes I really wonder whether that whole caching layer is even worth
it. We already store the configuration as part of the configset, so
caching the parsed values probably does not buy us a lot. For some very
central aspects like the bareness of a repository or the location of the
worktree it probably even makes sense, but for everything else... I
dunno. By now I feel like it would make more sense there to find
localized solutions specific to subsystems instead of having that one
big global struct that has weird semantics.

> > In any case, if we see that your changes interact badly with some edge
> > cases that we don't currently have on our radar then we can still
> > refactor the series and move the value into `struct repo_settings`
> > instead, as that structure works alright with different repositories.
> 
> This sounds reasonable to me. If nothing else, this series might become
> good motivation to untangle repo_config_values…
> 
> Sounds to me like we might be ready for 'next'?

Works for me.

Patrick
