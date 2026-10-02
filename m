Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCB3EC82A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928660; cv=none; b=XD8CQUXpbaBwqlXRCwkC7/FQfrXzdNLakjuZvV7AqqaDsPs4CNlHNnNw2SINkmYSXkQxIrVFMGt9F9UI/Cp/AaFd5Cn3D34IilXKi7IwJxEVoU3X2UblgTgEm7bs4FIVCuzesym/eWmivXjjfQit18tX/vQVHYtxRx1rffkXCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928660; c=relaxed/simple;
	bh=zF5jvNDoazFy1ojl9jAYJSyVxuXjydiB+VBkISUHDzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUk1f8NxSTs0rBVT6DGSiRYdoF7tEEdaZCdmCuk5GhDToK7XlUMb/v6r3d67r08jBuFN68bnavaCkQ0MFilmropD+gWbNVXjHPF0hxG4f7txE67gqPxOxfn4Irwet5xsZdSMpMt1jz/T6DGKqmtUoCaubZJ+F6lOdwz4QCewqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EEJ7l3Q5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwHARVfn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EEJ7l3Q5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwHARVfn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B346514000BD
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:10:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 04:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790928648; x=1791015048; bh=MoQnblZ0PC
	hGH/DJ+5iM/Q2HjlneO1rlgDgDVc4mlk4=; b=EEJ7l3Q5llojv7O92KZ8/WEWnA
	owg1lVKdtWDHpyIlkj7FPUk1eWyJcKa35AKvTolHt0VQMWdy3pYQbWTCKKGiQTZm
	aAXGM2fCMYrDv9n1RfzGqoPWaHuTom0h8LJslT6wsUDFv7fQR2M+Guo75lmFfUmm
	rBR6gLnaX3QTtkiZFJypQIiv8nSE+p0tuEWXj42ZH0I1dH2N6GN45dv+BtMbVwzm
	bqolYA246UkMNnv7Be7adj1MQ4wXX1QQheHKpkIRNlLfZ7OiFNL2l2H9zFcHPh4x
	Hcht0CkSlN7TL4N7HGoGnKh72NnXb3V2c/fIGVsa/kNMjGttJVolo33SRzVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790928648; x=1791015048; bh=MoQnblZ0PChGH/DJ+5iM/Q2HjlneO1rlgDg
	DVc4mlk4=; b=XwHARVfn99/uzGURBxdwEiVnfvdghjGFRnwwnk3svhMPuw3Hk2d
	ILKm9NmsXQmI+IQaGaGlIxeB0YMT05eNfcUnN0o3tbivHnF2CJea+gw5yKrm3vQm
	c9uZwJONlyezY+FozlHpEaDmJZ12083qvZ/9S6vsWuEgyyiAYbE1D6AiYZcUOPoT
	L9E16IXrLlUH5X9xnxF4Cb8tkAZcD5OZ/WFcbxMDfc+P0fsobnUwCT7OeiGdRsof
	r8Z3smproZ2aZjbrGBZy6ZGz/xbq+yhWjZ6SyT0QI+PWmuJTT2xhmDOwxOSWEvJp
	2X6TUPZ2352yvQH3JqcQi7OxlptE/EyyI+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790928648; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fzuUZXsvzOnCSs3P8ehLIwU1a3QJb1YcR6a9S6u4k9bNbmb
	Qd9xtIsUA/5VqGCv6r5XRPvSJaSaI7tdRAYVde6l7CJT8etOSUDvmO2Zj3uOu7ll
	9/SCe8fm4L+nu5v/1oz3q2UdhU+EUt0oTdMfDmqxLpqlUV3AvipXqCdcc1tg+FWN
	ci7x1DJVD4moL4/FT5XvY5VUHAD0Q5LLvvxKUOXaVUHTHLMlmNEXa1CZCYD1EPZs
	Wd4gVusfJJSHatuXaSKVEP/HDYMhVdUsV8XiGiBidMGine48Vsyk75wCbSaJi+4P
	kJJH4CaHJzxGSuHbgZ8YZNLvK/0hHS+NogzNO2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5dTR62IEN7BBrTJlehmhRezlndE/qPXqu3t0WK+xo4w=:zF5jvNDoazFy1ojl9jAYJSyVxuXjydiB+VBkISUHDzY=;
X-ME-Sender: <xms:CGe_aoLXirH4kw9QySVY70KfIu--lW7V4NQ9Ohcav1FoW3PFOv9L_w>
    <xme:CGe_avmFZm9Ea9MYuaGkCpBRnVuMyXu7GQjYNUgOCxEhrXQXDKNhvu3b2SJuBNoRz
    wp5odDY_ra5fICXKssGsFhhmKmgcxYCZuAIKXZPly0SsrihkXBXZ0U>
X-ME-Received: <xmr:CGe_amHJDi_fFZWcjZvSS0oUNCby-r0PSCuiINSkyciy5n2nFTRSQg>
X-ME-Proxy-Cause: dmFkZTETSKCAUnnoAnl8JfJFmqoZkGMYrjyqwHQWay+ityo0H1d0fp/dxxCtxF2ChP15V0
    a3axpQw8WMANh5JCzSvccSfI9xV8tLSS4uhVdKCDDawlbPGKfIEjGtYxuiLWUhA6f+Kl2O
    ZheJwTRsp8jfUyYWnnyjyxFE8Y0Y+ga2hpNaMouJECYdO+cuWuu8qc5eKaiQXiregGN3le
    HtxSOyaMUEBmQKAx3Ngl2ZUH2jWBzBDnr7dq1zHqeK5iZVhnitSCeEpzhcnbL1n+gPwssS
    fqZ1dCu9I3znaCsMuNs8z+RgjBpe67J3D+FDCcsqHDT1SazGqGSV/4rpCAG76pQmxCkGkx
    8nEFJIFs5dUeUFASyUTB6/Z/iDah1zFSTkZ3j+F59IYq7Y7s/iK8wykyurJxswYKijTVCw
    11MAP/Xy7o/R7qPBqXXuED2lp6eSGQyWNysognl2Y9G6hzJTpmIWequKmBBhovWxBJVOpV
    TfQXZzedN0DVOGsia6UprRyWrJ+3AKZ22b3ubOOfCMdj3TnHuPzIYuDQs+PxXjW9NleYuC
    q0IJqF4wXaNu7lvtYe3dJfZPJkqaiDxsXdZaZQrOrA5WnmBtBXpLQepuq/7fePDprq7Nf6
    pf6ir2QD253nh+EAyx+6Xwft+NWwqI4GAnY9d2dp6fiKQ6F0JWTdpPkTM7fQ
X-ME-Proxy: <xmx:CGe_avFnb_6j4lth4gdJRsWG2xFwZ13mQKW5M0sl346gMhsCMU1Jww>
    <xmx:CGe_ajNDX6ceFxfocMA4q4dqSELIFlQ77OA3RhlUAP1VGkJo5LUlQw>
    <xmx:CGe_auHvhBEGZsiVaiOW77BjcZSzEqUUwE5K3f0GNcIOWa7T3ddZoA>
    <xmx:CGe_aqNSXZQueDkii0wlSemxIdLhecRgbbEpPcwEquV956CaEmFhgQ>
    <xmx:CGe_atBVNPdiCnKvXkB-d898OU2ofRhYH8Y3G34J1xdb0M4wHD6IrbJw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:10:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2e18e46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 08:10:46 +0000 (UTC)
Date: Fri, 2 Oct 2026 10:10:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Guillaume CHAUVEL <guillaume.chauvel@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] submodule merge tries to read B's commit from A
Message-ID: <ar9nBA2e_sEiFZ4k@pks.im>
References: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>
 <764b8c2e-cf09-4531-94f2-268f97a889d7@gmail.com>
 <ar5ppRMQ8NkGnbGp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5ppRMQ8NkGnbGp@pks.im>

On Thu, Oct 01, 2026 at 04:09:41PM +0200, Patrick Steinhardt wrote:
> On Wed, Sep 30, 2026 at 02:31:44PM -0400, Philippe Blain wrote:
> > I did not yet dig further, but I have a few additional observations:
> > 
> > - in contrast to the commit-graph bug, disabling the use of commit-graphs via
> >   'git config --global core.commitGraph false' early in the script, by moving the 'tmpdir'
> >   definition to the top and setting GIT_CONFIG_GLOBAL=$tmpdir/.gitconfig, does not change
> >   the behaviour, neither in the "repository corrupt" case, nor in the "hash mismatch" case.
> > - On Ubuntu 22.02 under WSL, the reproducer does not trigger the bug on v2.56.0-rc2 (on a dozen runs),
> >   but it does trigger it on v2.55.0. Funnily on that system with v2.56.0-rc2 I get the correct behaviour !
> >   (no "hash mismatch" either).
> > - On a Ubuntu 22.04 Docker container, I get the same behaviour as on RHEL 9.
> > 
> > > An AI analysis identified a likely cause: a delta-base cache entry may
> > > remain after its pack is closed. If a pack from another submodule reuses
> > > the same packed_git address and base offset, Git may return stale cached
> > > data.
> 
> Yup, that seems to be the issue indeed. We should really be clearing
> packfiles out of the delta base cache when closing packfiles, but we
> don't right now. I'll investigate tomorrow.

I've sent [1] now to fix this issue. Thanks!

Patrick

[1]: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
