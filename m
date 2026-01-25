Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EA19C566
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769360821; cv=none; b=pzbdTFxZ1GI3+6tLr6EqMKIlxhGdfjKLUCMuoSx2oRsXUzQwAsQrf+72BR05ie/792KXNuBBJQt58zZ2NVYHTvsgG/IrtDZ7NiKxBDWNZgGRq9qRCW5MkNGX6Wbo3B0WCkt2oXUhxHK2g1gVdhVROKPpk2fYgFAjsg4bbI37A/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769360821; c=relaxed/simple;
	bh=NrWpTBR7Rjpkd/x2q9Nb9sMz5qZtFVOo3qe/oAl3xVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nbzr9w+GcQBFkiwrVAPJUb7BSRCEy8pj61lkv1dUOq36dmMMZn+oCzZGT1fAeLa+kUaonL+dZ/f9hq4//z9Xx/SPsYtcNgJviZjBGtQG04Kal7t6MxWUxE44HM/N+8klQr2iUSHeIBgJX/C38ZHaYTEpNMA3VLwv7Q3urIbc8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hla6xhmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tk0Gwxbw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hla6xhmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tk0Gwxbw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F2B561D000CB;
	Sun, 25 Jan 2026 12:06:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 25 Jan 2026 12:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769360818; x=1769447218; bh=GHChb3khv+
	NPZnexXIwRLQHhFRoZ/jgHBIrY1H0Cz9U=; b=hla6xhmVHOPhpwLQojzmwVLWI3
	wQSe+UlqHwFxUu6qEZX4eNdgeIt1h9Er2el5AVrzhIukwVO3ZJYCI+8SCnUhofC9
	3cbjrEJguFBTY5tJ1mO7HDXT+JWQodW1CnBua11TzIXk6RLVc4sy/ll9iMm57x3G
	q/3rcFSmP0MSc70YdBPAQwEPxFaGvfhYoUnveEGXEd15CS6M/bGgl4zCXoKQ5HJv
	Jx9fknjH/QjGsByl63s+8aD3xJyNfk+c+KJ4f5kOLvoQc3lqNYhpwQb+bWnwXhe3
	UEXJ+01g73YVYL0CArimTi7s297UimB+Fgh0qKEkSbsHMHFcFp8fQDeaAXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769360818; x=1769447218; bh=GHChb3khv+NPZnexXIwRLQHhFRoZ/jgHBIr
	Y1H0Cz9U=; b=tk0GwxbwkDmcGj3y6QYyeOF9IbWPdgxc9ORtshs/eX5rbjRIMgh
	qOq9TW2bdNOBiDn0mV9VGJcGXnpOdkZOLuiNxS5Ybdl8QEHwUwb86wAVhgmnnvO+
	0YCTjA6UksiEdu0qZ4aC4ocqrGsA2ASnVt2SAhsooloVC7HyTK+VRsd5CtQAkB1f
	FnTPZCgR9M0Y5ONuFN4Bf0aLxuRniKJW5NUsL8YgmbCCQEmo6GozBkULpCMqn+pG
	xosT0rOsacltOwcBCC8zB7PeT/SGjQ+LHOofvT+Ew8xUrBj2IQBb+vXqgH5xGxPC
	FHoTtOmUYiAyKrf+2Uiq+hqu5whBJisDoYg==
X-ME-Sender: <xms:sk12acUXiYhGKh9PFXoDZCLFaF6yZREuXYPleuFCw8eN_iE8fpjtig>
    <xme:sk12aYAUKL_m84uzSorH5oHEAx1OeVT-XuaU0Xvg0AOQtTyZ37w_lrlh3_wHo01WA
    PfrtrzaAIkQsy3pbFeM94KhKYYP4CLSO4dYeYSR37cFnxuDEXvxBA>
X-ME-Received: <xmr:sk12adzC-YC7yRK2K_T53QmyIlT-WIWgFNyLterpoQ80Vo-IjSBr3HJXUaCsJtk-G_pQOD99dbW7EvE_c833NpsCLDJfiCJF-2Nen7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:sk12aVAjBKMvM0lnaaIka89xbTiJ9N6ghArLnAxcbnJImac5rMEOEQ>
    <xmx:sk12aaZknngJ7kAnjJMN7OYZZvzOcK5pxUNg01RLgUaNh7sWEfH4jw>
    <xmx:sk12adh_d3FPObtZLBAv26uslQVctK9NgALNBdn5IcmuMKQS7Mgu6w>
    <xmx:sk12ac6IsEXs9O1uRMUGlR_TSYRHhXywgtYxNpAL6-Rwi8is713ANg>
    <xmx:sk12aTsAkiQhQ7CANf5w7kc0Im0y-dGj5P0GPZtPgURzSpsgcTBiLuAM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jan 2026 12:06:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: more Bulgarian translation updates
In-Reply-To: <b379d47f-00c1-4d81-bfc7-d485699eab32@kdbg.org> (Johannes Sixt's
	message of "Sun, 25 Jan 2026 18:04:25 +0100")
References: <b379d47f-00c1-4d81-bfc7-d485699eab32@kdbg.org>
Date: Sun, 25 Jan 2026 09:06:56 -0800
Message-ID: <xmqqa4y1liz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 453fd8d14ce441896e0b39b85c67c9c26e34d46d:
>
>   Merge branch 'master' of github.com:alshopov/git-gui (2026-01-24 09:25:29 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to 1a729ccb930f3c3e206117aeb4f536c9864e09c9:
>
>   git-gui: mark *.po files at any directory level as UTF-8 (2026-01-25 10:53:08 +0100)
>
> ----------------------------------------------------------------
> Alexander Shopov (1):
>       git-gui i18n: Update Bulgarian translation (558t)
>
> Johannes Sixt (2):
>       Merge branch 'master' of github.com:alshopov/git-gui
>       git-gui: mark *.po files at any directory level as UTF-8
>
>  .gitattributes    |   2 +-
>  po/bg.po          |  90 ++++++------
>  po/glossary/bg.po | 402 +++++++++++++++++++++++++++++++++++-------------------
>  3 files changed, 306 insertions(+), 188 deletions(-)

Will do.  Thanks.
