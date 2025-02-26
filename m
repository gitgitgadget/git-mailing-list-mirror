Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8E26A0A6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555314; cv=none; b=hm+UrUXrJl3viwhIK8yYcSAkXXNpEiTKmvCP6m95fPBY7u/niPQapo32Php6qHvds/edUY4mnomiFj8xEWGlAIDPkpGLiml0XrkHMWa65Jzqb7ZYA0cQVDhdC6LBCwAEtdyoSP4XytFxUrRyuBbBZFvXVVQG/a8J7rwe/8NzfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555314; c=relaxed/simple;
	bh=jNqga0RNSOcxYKKS9OUFlUYhtoLsOaFwknmDU1Y7oOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSdvv5oKG1ADpWgIPU/flm8FT5rf/3n6ykoBK5P+y0bu0qGh/1oHutJ67yw7aakNvfhpmgD8tgoOtH2jDGS48G17Mn4C09eNRAas7o5ImndCP2LE6lxzTDrcp001ugfp8neAAPN3Q6U+VmBcd8yzYpojmIhaHpdTNd3FOlm0ZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CKYcSr/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kfF/gI40; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CKYcSr/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfF/gI40"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B6EC31380C16;
	Wed, 26 Feb 2025 02:35:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 02:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740555311; x=1740641711; bh=1/PfTK8kee
	oLCxdCGdsl2OsSGrFSJhlo7AZdWhuwJlM=; b=CKYcSr/uyr+QiAWe8rIuocOC5X
	GTcdlGNQ9kueLt4TXoBIOmOsszfs3ilCdQ9DBm7l407M4xTcK+OcbACjxauLMfmr
	1py/hVBj2cGaax9yc1ftaBywU8WtQIVYKW9S0503S6tgfGE5wzLhow0S3n8TKyNf
	clVfZfLW4og262X1UoxnSLIkJJ57hOouA5/xic873l9+zXnSYjitYsmWzeskx3x1
	VLM2LHpa6VTFNvl0Q12kP2qrh9LQlBSeZhRk2+W7AyC2FFWZU2IzHoLCxksxVLcF
	Ch5awSmzNBFubRupxbii87SaslC+OWoxPzyZOZG6sdARwTa9uIL3KQJtvd8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740555311; x=1740641711; bh=1/PfTK8keeoLCxdCGdsl2OsSGrFSJhlo7AZ
	dWhuwJlM=; b=kfF/gI40Bc9ATNxCTyf/kXwT1vlnhD4ZYUUlKwq5hV6GWeSDMEF
	H7clyR6QlSqj6lFacC8aSMkxgpuRf37XlRzK7O0xnfAsiiOvKTCQPa5Sto6hyeW6
	nNJAKvo8Ub+2CW2uU6hetb6KkKZC/ianLtkWMSJdqvRjvjACfieB07AdGhadsJHp
	g82vNUV/WwRn19eBUNKaGpt0UtX2IHT0NpZNJf5FvMSnrWzYkWfPYGkdI4gpWaiv
	GC8ahpwH3sgnuelHgxgaAMmr0Dn/NpS2LSFeZqOl/2S+xw6ChfiG3Qq+ZsZorkJh
	EhfYXfKN+q6XyH/m4d/Ydei9MWvZoToBtGg==
X-ME-Sender: <xms:L8S-Zx2xplVc1ZxnHzIXSciCkipno-cVq8MWl5JpBmVX2-L3yzDF3w>
    <xme:L8S-Z4GTy--0GxtPv8XsDwBX6WSF7FR5mYv2xYOzaVf4T6_9QDEZfJS8d1cmfkbt3
    l-MrsaWVLn_JQ2xUw>
X-ME-Received: <xmr:L8S-Zx4MgNAMO6HgPYwDdvt7nj1ew8zv36TUTBPsqt0rcrK6Gf6rgMmErFu-C_qXrHD8ELsH3KHA9jk5UzW5jbOdaTjgVD-lhzzXU8_yKyr8R9i7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfeigfdvff
    dvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecuffhomhgrihhn
    pehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L8S-Z-2I80UAbQKaOeVXJRm1W0lc28ysmpQvx9DHJWfZdsOulB3wFw>
    <xmx:L8S-Z0H_dZIW4CpgST0V70iXSulRQSoNlgUf8Gul4CbEgg5KhROPBA>
    <xmx:L8S-Z_-wZI4Xh-4CpM_pkmZUSzTynfJRYQbfAChLaNp8FRKbNQuvlw>
    <xmx:L8S-ZxkIltdS5mYEe6wqS5cq17BNVPUqIkvoXbNupfeNDE26AuJhpg>
    <xmx:L8S-Z5RT7ypEKCY70jG3HtKuf9pvrlXbW-Q9ftnNRYcTYZ2T1Px2jtIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 02:35:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c4a4fc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 07:35:07 +0000 (UTC)
Date: Wed, 26 Feb 2025 08:35:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <Z77EJRJwPDGUglLk@pks.im>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z76qYgV7B2eUJHiP@pks.im>

On Wed, Feb 26, 2025 at 06:45:06AM +0100, Patrick Steinhardt wrote:
> On Tue, Feb 25, 2025 at 11:45:47AM -0800, Junio C Hamano wrote:
> > As of yesterday, 'next' started failing all the "win+Meson test"
> > jobs.
> > 
> > https://github.com/git/git/actions/runs/13506034920
> > 
> > I had to do one of my least favourite activities working on Git:
> > bisecting CI breakage on a platform I have no idea how well it
> > works.
> > 
> > Here is the full "stack" of changes, it contains all the topics
> > merged between 'master' and 'next', plus a single change that
> > butchers .github/workflows/main.yml to leave only three jobs
> > (ci-config, windows-meson-build, and windows-meson-test).
> > 
> >     3a7e83b527 Merge branch 'ps/build-meson-fixes-0130'
> >     e59193e984 Merge branch 'ek/mingw-rename-symlink'
> >     a209cf1427 Merge branch 'po/meson-perl-fix'
> >     9f1e73677c Merge branch 'ua/os-version-capability'
> >     82f01cb375 Merge branch 'ms/rename-match-name-with-pattern'
> >     8b04381049 Merge branch 'ad/set-default-target-in-makefiles'
> >     2cab1bd7d0 Merge branch 'pw/merge-tree-stdin-deadlock-fix'
> >     92b43de9df Merge branch 'mh/doc-commit-title-not-subject'
> >     685c150623 Merge branch 'bc/diff-reject-empty-arg-to-pickaxe'
> >     c5093fc2d8 Merge branch 'tb/new-make-fix'
> >     9091607e95 Merge branch 'da/xdiff-w-sign-compare-workaround'
> >     01e86410fe GitHub CI: trim and slim for win+Meson test breakage hunting
> >     2d2a71ce85 The thirteenth batch
> > 
> > At 01e86410fe and e59193e984, CI seems to pass.
> > 
> > https://github.com/git/git/actions/runs/13528755524
> > 
> > With ps/build-meson-fixes-0130 at 3a7e83b527, all the "win+Meson
> > test" jobs fail.  I suspect that the series does not break
> > individual tests but the breakage is in somewhere more
> > framework-ish?  I didn't look into individual test job failures.
> > 
> > https://github.com/git/git/actions/runs/13529323827
> > 
> > I'll also note that in one of my earlier attempts (which had
> > ek/mingw-rename-symlink merged before po/meson-perl-fix), one of the
> > 10 "win+Meson test" jobs failed ("win+Meson test (7)" to be exact).
> > Rerunning the failed test succeeds, so there must be something flaky
> > in t0610-reftable-basics test that is exposed by this change,
> > perhaps?
> > 
> >   https://github.com/git/git/actions/runs/13528071468/attempts/1
> >   https://github.com/git/git/actions/runs/13528071468/attempts/2
> > 
> > As the ps/build-meson-fixes-0130 topic has 13 changes, and each
> > iteration in the above exercise took somewhere around 20 minutes, I
> > won't dive into the topic myself to identify which one of these
> > individual topics causes the breakage.  This however gave me enough
> > to go on to today's 'master' integration (mainly, by mark the topic
> > to be held in 'next' until this gets resolved, and deal with the
> > other topics).
> 
> Hm, interesting. I didn't notice those issues in our CI. Thanks for
> diving into it, I'll figure out what has happened here.

Okay, the issue was in 163a3e97ac1 (meson: simplify use of the
common-main library, 2025-01-30). In that commit we stopped using the
common-main dependency for a couple of binaries, including
git-remote-https and others. What I didn't realize though is that this
also made us not use the linker arguments anymore, but those are
required on Windows when linking an executable.

I've kicked off CI jobs on GitHub to verify that the revised version of
this patch series works alright. Once those tests pass I'll send another
version of this patch series.

Patrick
