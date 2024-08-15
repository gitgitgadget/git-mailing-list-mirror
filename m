Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F3176FD2
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704182; cv=none; b=fjgjeVGZSlzbYYSAInNVgbm+KuCjtMx0akNyDFwR6ztbtFH6InkBJXCgNePIWe/635Do4xvBRHG4yxNbkKLt4Gkb233d/2x9DUPrgg1Ss/WX+dZq3tD/aqC4o9FwuuC3HuEXFebewwxcu7/FpxJ1DfrlFTma0GVtQxJzZhwEvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704182; c=relaxed/simple;
	bh=0EGYVHTNYversNSrxFZNBorC7GjRebawvk+HMT6DJiE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=vCY7cUzWevPYCl2ywDLpho/Wsr+dKaFyCppxI2Xtvivw3xeeip2LqsW7lhKApYUcOZ/a+emfiwyZYrJM28G0kG5Hct63ZXVCleZhAygyDQZTStkAndXozWwY8pPifOUyumvzuBN0+78YYMfKUy6EjTbai1JIAqTYu60dFPt/fPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=FqfYEjQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/gLR5QB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="FqfYEjQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/gLR5QB"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4A6121151C08;
	Thu, 15 Aug 2024 02:42:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 02:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723704179;
	 x=1723790579; bh=Mex+5KjBN4DHMHooYFxHyTq0yOAxXS0gc3bdX6yy9Ig=; b=
	FqfYEjQGAOEvfT75r9cV9bJC6JOXV5DXdnvbj3xP2ztcCqn7sXFbM2yHLAan+k82
	rIZSQ9S6w/qbJY10GHFUJZl7aASFA3yGP9gazTXQ4iHrTYOI/uW6YWsYqoqyPQfn
	NAeGpwmmUTemgjmp9d+38EJ9BwbeuGnADgGlCKPKrZnrWSWrlwpVGT5RD/mYhDAk
	AbkHWezuVrhF088BpcN29fA68jaCqi+FD+0SDCSCTfEYsxtFkMFvnLfN8FxIsxDF
	irrc0KgQJUDzKsuuN3SqwVVThDDaNyg7d9p/QzZ9ZXrxVP5cGUUboBxFEph5bxjo
	mvW/SnFgZfPdGbmanaBy0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723704179; x=
	1723790579; bh=Mex+5KjBN4DHMHooYFxHyTq0yOAxXS0gc3bdX6yy9Ig=; b=L
	/gLR5QBofkZ9UxipyRYYDt82zZZdeAwHnDDkvs2SogHLn/9HnoIMvdCEU3WsY1vR
	st2GwZP3P+Ss4wYrV/2kGoEysTPThoRUYq1lFd4MlOL8apW+XZjAS/6B04FeQiug
	ymJY0DtfvEq/D9BYmdVrlzkiSCNaUaabW7tYlJo/uO/SKC/FX1cG8YwnWTiDSr5L
	MYtoxUvKsP1Lmu9V0CwO5XwPV0/dbq7XKDS3DlIAJf1o5lbuuX37MWlJd0pBybB2
	w8kwNWKVHwDgdnNxRfnpweUbKV+wKKfsWOHJcZ47wyvyfGv5W4lNRg7ogDZCjdKP
	DPr/kM7XEmfDE5RCfbABw==
X-ME-Sender: <xms:c6O9ZmAwCBZULXfBD-c_PkMknVasLpgXmvIZrwDPKqmZ3_0MXfGWbQ>
    <xme:c6O9Zgj1aN1-p_PW2xilhDXhgPMJCCyh7MM5RBtxxaT8nDfHfTxSgS8qFb878__bW
    jfET9Bb3hxfWr4HZw>
X-ME-Received: <xmr:c6O9ZpnclVwez7mlf09MW_3QE44K6rX7Sq80X4cGjwYCNLLbPOkU875m2Uq5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhephfetueehudeltedtjeekudelueeihfevheeugfeh
    hedvieektedtvdevgeeileetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c6O9ZkzP71-8jqDRWpvLO3X9r1fT_3kBi0JwZ90b2H8sPmZV_R0VzA>
    <xmx:c6O9ZrRPrYvSdmZEvJRWQuQtpCMagTPyx9KuvIVLf2rW9Wa73WfDsw>
    <xmx:c6O9ZvZDPUHKwwgMapsSl6ijX6X9Hg6uRNDPWVezwsQGjx5WyjshVA>
    <xmx:c6O9ZkSFij9fdy6tVRqBeD0wYvqv2pvNVx5uVL_YsyAFVhRiXac-Ig>
    <xmx:c6O9Zmcfp7OjS9n8dDy-vZQbLpfq80mFZPAJF6pve1Vd6lwTVGu7Kzsh>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 02:42:58 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 16:42:56 +1000
Message-Id: <D3GA4UVELOIG.VNY8MZEAEM5P@jamesliu.io>
Subject: Re: [PATCH 0/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1723533091.git.ps@pks.im>
In-Reply-To: <cover.1723533091.git.ps@pks.im>

On Tue Aug 13, 2024 at 5:17 PM AEST, Patrick Steinhardt wrote:
> Hi,
>
> I recently configured git-maintenance(1) to not use git-gc(1) anymore,
> but instead to use git-multi-pack-index(1). I quickly noticed that the
> behaviour here is somewhat broken because instead of auto-detaching when
> `git maintenance run --auto` executes, we wait for the process to run to
> completion.
>
> The root cause is that git-maintenance(1), probably by accident,
> continues to rely on the auto-detaching mechanism in git-gc(1). So
> instead of having git-maintenance(1) detach, it is git-gc(1) that
> detaches and thus causes git-maintenance(1) to exit early. That of
> course falls flat once any maintenance task other than git-gc(1)
> executes, because these won't detach.
>
> Despite being a usability issue, this may also cause git-gc(1) to run
> concurrently with any other enabled maintenance tasks. This shouldn't
> lead to data loss, but it can certainly lead to processes stomping on
> each others feet.
>
> This patch series fixes this by wiring up new `--detach` flags for both
> git-gc(1) and git-maintenance(1). Like this, git-maintenance(1) now
> knows to execute `git gc --auto --no-detach`, while our auto-maintenance
> will execute `git mainteance run --auto --detach`.
>
> Patrick
>
> Patrick Steinhardt (7):
>   config: fix constness of out parameter for `git_config_get_expiry()`
>   builtin/gc: refactor to read config into structure
>   builtin/gc: fix leaking config values
>   builtin/gc: stop processing log file on signal
>   builtin/gc: add a `--detach` flag
>   builtin/maintenance: add a `--detach` flag
>   builtin/maintenance: fix auto-detach with non-standard tasks
>
>  Documentation/git-gc.txt |   5 +-
>  builtin/gc.c             | 384 ++++++++++++++++++++++++---------------
>  config.c                 |   4 +-
>  config.h                 |   2 +-
>  read-cache.c             |  12 +-
>  run-command.c            |  12 +-
>  t/t5304-prune.sh         |   1 +
>  t/t5616-partial-clone.sh |   6 +-
>  t/t6500-gc.sh            |  39 ++++
>  t/t7900-maintenance.sh   |  82 ++++++++-
>  10 files changed, 381 insertions(+), 166 deletions(-)

Thanks Patrick! I've left a few replies, mostly non-blocking questions.

Cheers,
James
