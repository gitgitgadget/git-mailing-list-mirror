Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66173358CA
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059302; cv=none; b=r7s27cVluCNWWU73Isbn8fkFbDQFVh3vw5qXkRWMhnPExv59eZAmP19hVAzbahUkbUw4UWWiwdJ+vFwuMj0eE2dPpt7aMg948ph2C/xZV9vQkgkemK24SJckA5x+JFkfk1wDh3KZvyrU0/Pl7Q83O+RrzyvY2Bpx+R4fDNBruo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059302; c=relaxed/simple;
	bh=9zfmCQ02/I0HXTbWqjb4LJJ2MQUpdqR3xg9tOnXqEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+hfMgPuEgdPpppRePhp0N+hckQ19rHFcClUrtN1LWJBY3VHqSC6F8/TuC/q/zbb3VyHHeQjbKS4Tb8d2UF1Mvi98eVftkwXLOdMzr7ZFeXK1lpYGaFm4NC3x+lEMi4MBINmjFV8wY0GWqImF1Mf/owC+eMv2jEJTp0rtg5m/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B5h27hx8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rte0ULsw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B5h27hx8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rte0ULsw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F00E71400054;
	Mon, 13 Apr 2026 01:48:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 01:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776059292; x=1776145692; bh=RHAADobL7c
	Izeu2tTd9THAws1PiXr1/cbmhD8Qk27as=; b=B5h27hx8BwjhsiWMV7DCrLVnkY
	l6vXZDdtCaMaYzuofYAGKuYRBPhiwonLZrkq3zlOfz/d26caEspPprlwWTjGGAng
	KFBMeqI23RM9+LFY8nGP/eeLE8kDbigazR1mJyyJ1HXeHpFtsvNaR/0H6lfukkeS
	yQYWOXO/N/LQ7BqdsZ8AnhtS2U4ee2kLSeevru8tgZdzt0GdpSfjGkxmMB/bcW2k
	0pwH10xgvJkjA4XWyzxbr44pB6c15Lq2t/A1ZiT6AAbUEq9nSTP5+HD4pXaRfm7P
	LHnsG36alIHPft5uO48C8YTs1KfH0AW8tV5tqhHK1gRmy27XFv5z5ksX2Q3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776059292; x=1776145692; bh=RHAADobL7cIzeu2tTd9THAws1PiXr1/cbmh
	D8Qk27as=; b=rte0ULswUKFvHwsYvv4bVS3kHLegwhXT1tAbZC0n4M1tT47cKRw
	7z+sFZeJtxRnzKzxc3ZsoY0CuJOtj50NvntB5ZjunyIzXFA09ItGpchm2I5eF+00
	ayI2z8TknyoqUzhZMvu2A69oLNVEchmkHHcU3RK54LlxKQYcNB/RY3qjOYUzkT3U
	5IHBF4CK/Bnk9vWV9MPR2D2Aj/iJWKnSgp/gQ2ztbhH5csFAnVWp07QOdhtw4FP9
	SFEVnOq+kf8gxy4qWhlkzNg8VatMGSJA4yeRb8TZHzRcOqvSJZP+/8ebfOyIN7eJ
	hb6FOaQes3xZA+q3pQxpGnmI/Hkk2f1aADw==
X-ME-Sender: <xms:nIPcadrzM-Tp-JXCOaDoe5m8GgWmnDJFbuzv4oGRl2I5iCcfWef58g>
    <xme:nIPcaVpPwIjORTtSVeiNNQEKxk9t9eWIS_Iw7Qtq30ILJk1DBFc7HLJQHfGoKfbBR
    F6YOt2Gtd1ViXXp5W2WGfMGEFNCq1vptQP0uVzhbCqcEYX6nDrRew>
X-ME-Received: <xmr:nIPcaX2bbWiNPiOD1OXnA29Om8GS2Z5qJRrYUQJfBWrcCmZn9yqEIl-JbzKz8Xn00ypjxFeFHqPdeQ3uOLH7ebxb3nuYW6oGOUnHI7dX7HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nIPcaUDLc9V6VBuly2q-K-utWDqlpiguupc_N2As3VPX6FLGX_n3Tw>
    <xmx:nIPcafeHr7PAQirL3Cz1Y3v993tU4CctTU6SlqNxzNCkcutHLsAtZQ>
    <xmx:nIPcaZi5MF2_GeIAqjltwW9nmAqRjx-EiUe6P1M50hlZ0wv0vmZSVw>
    <xmx:nIPcaXpIMji8f91ylchINs3yoXIr_ejFVlqTX4aZJPpb2W67XVh7cg>
    <xmx:nIPcaXYcLRq1Oc10q45XqQt-Bo7INSEhKPX56YC8S838PL4d7CKsAFaH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 01:48:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8175f97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 05:48:11 +0000 (UTC)
Date: Mon, 13 Apr 2026 07:48:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/18] setup: drop uses of `the_repository`
Message-ID: <adyDmC-y_P0gB_79@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
 <CAOLa=ZRrK_5shCZwOar47kODe1kDKzcfXo764o9mE5ZA7xGePw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRrK_5shCZwOar47kODe1kDKzcfXo764o9mE5ZA7xGePw@mail.gmail.com>

On Thu, Apr 09, 2026 at 09:05:21AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > I've had enough of "setup.c" and its complexities, so I finally decided
> > to take the bullet and start refactoring this subsystem. This here is
> > the first out of the following three steps:
> >
> >   1. Drop all uses of `the_repository`. This doesn't yet allow us to get
> >      rid of `USE_THE_REPOSITORY_VARIABLE`.
> >
> >   2. Convert a couple of global variables and drop
> >      `is_bare_repository_cfg`, which then allows us to drop
> >      `USE_THE_REPOSITORY_VARIABLE`.
> >
> >   3. Refactor the subsystem a bit so that we stop intermixing repository
> >      discovery and repository initialization. This is my original
> >      motivation as I want to get rid of `odb_prepare_alternates()`, but
> >      due to the way we initialize the repository it has proven to be
> >      extremely tedious.
> >
> > Most of the patches in this series here are rather mechanical. There's
> > only a handful of patches that warrant more attention:
> >
> >   -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
> >   -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
> >   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
> >   - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`
> >
> > Those patches don't only mechanical move stuff around, but also change
> > some logic to make it work.
> >
> > The series is based on 5361983c07 (The 22nd batch, 2026-03-27). There is
> > a single merge commit with "seen", but it's trivial to resolve.
> >
> 
> The series looks good to me as is, like mentioned most of the patches
> were fairly straight forward where we simply inject the repo variable
> into the function. Thanks

Thanks!

Patrick
