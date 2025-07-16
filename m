Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4531264630
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678984; cv=none; b=tBglKP3XvNTCfHdcquXaV0GpAI3GfpHCV87YtvzsnmVNot3oCyiKTVSThlAnk80puTHULamO3VPXDc5UublbwwgLXrRzmSJtMpKilSPV4wIqrvThovJptZWEV6h8cjTGYEdI+DZb4K9NUC2MVkvvPhlkcShXeIgZTtIvstjymKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678984; c=relaxed/simple;
	bh=RwVqhZzI7/zGXtRonWpM8ffQlJKgwHpFQLi9e928GoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsFotW5fisgZVNIEEhY69/Xay/WL8mW3Fq/w8Z41jwGUPbC/bmuOnisupdmuMvydncs7GQLgMNLTIs+vnakrLD90w40UgacQZTWH2pz24io3bkA8XG1DGfNs4Xr6f6IpUsZDO9EhQcbImptKnF9vHwll3jIjeqG4gtlhrTCqc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=adKQ9EF+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/3Le6wR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="adKQ9EF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/3Le6wR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4AD17A003E;
	Wed, 16 Jul 2025 11:16:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 11:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752678981; x=1752765381; bh=Zor6v9dcM2
	UAwnVdVaxUGmLXS9OGKbK5ePgOo5UxZhM=; b=adKQ9EF+sTG1NIMm2poYS4Zr+f
	mqUAjb0Tvb/q8YQit9nnZ1ZbT08OEJvH1s6ksG1x6K+2HPxLO86oX7BVcZt2JbBk
	MkhICQEppRDm5bd94ChN0SP9oS89X/J+lVqjMeknEjv38N82+u3Y9G3mb2YiR4iW
	zTBH2+4QR95VucTOXpZb8X4Ey9CZy1jSP/KrR3argvwv5uwIsdP7MnCXpIEbO1P1
	LEwjQtscXm7reLoJfMmpGrT5wJcl//zNSwdnc3YA33TNlqg/vyQVj51xdq3dfP8A
	lpBqxDDXeAQHtBNSMxmdyhihAzcaeDKR7LZ1cXwWx6qF19J6IcuarZFoJtow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752678981; x=1752765381; bh=Zor6v9dcM2UAwnVdVaxUGmLXS9OGKbK5ePg
	Oo5UxZhM=; b=j/3Le6wRHxh8W4s9wWVM9NzEsTUfDMZNT0zAcOia+y8hZgOoJHY
	d8N4HV79C82q7g0MFnjRK1MzseL0/7Z0JXHsbLUQxg0DWeVVa4FbkfSFYIdBVFl9
	bN4z4xiE+7/aBS8xoeDPcDBFegkxdfoKmBgkX26c0kAShaFEmyQQlfi1RS7vQnCa
	EZrGwzlf7zioLRVYEUTiDvLMlRsn9GSZqfiEq+HUT03T84BgdWoK3gouCiwiU+Pw
	sVbRrE0m69Y74PXBtf9yCM1peJt1SG7zrh31/XOYLOkqzjl98uM89MbLWyfyrffq
	laQQ91W/EZKk68kYBA1316xsfcp/QjOmu/A==
X-ME-Sender: <xms:RcJ3aFO9x2KzZ8Q2sKsA27YAYRpXXyl-Eyo4e88-Oy4ZF3KRDDLUug>
    <xme:RcJ3aJdYSYtwtP4tXtEAwGlyITo0nGv1eye2mgwsRlZJV4nJP1lHGeKPs_i7Neljn
    2SQIx_4R3u1c5X58g>
X-ME-Received: <xmr:RcJ3aEUfHAbG3-iajzrdGM33oPjIXm4ZM0Vlm9C8fc6ZFxC2mf5JkXPP8SJ_jre1t9gBCkZhLpQQIISxoyPhD6Tfa_319wRc0dC_6SI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhephffgteeivedtjeduueevvdehtefhff
    eukeevudehveehueejudeuffeuvddtleeinecuffhomhgrihhnpegruhhtohhsthgrshhh
    rdhsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    ihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehhiheslhhoohhp
    ihhnghdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RcJ3aBioqYvkDUmgzYxB5c6n9P314SUcPcjQjZfBF5LxMzXXFV3sYw>
    <xmx:RcJ3aD9qmwDLEk1mSrypRiZmH0qFCaP9PW7NC3-rmKMzgvO8R1lKBw>
    <xmx:RcJ3aDYYJm9IXvv1fzDzxpA2R4mif4pcHSJuLXusJBUf1F8KVSI_7w>
    <xmx:RcJ3aK0thPvTe4gk9mwB97zOK5b5aoW0fPitMHxXGtcbKoAPgqOHyw>
    <xmx:RcJ3aB7GK4lUYnjHBoIdq42izFuVZvtaoHRpg0Qt1CaoxT32SqQ_lzsA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:16:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  Bryan Lee <hi@looping.me>,
  git@vger.kernel.org
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
In-Reply-To: <26cef1b9-1f17-447e-b647-3d32a3984997@kdbg.org> (Johannes Sixt's
	message of "Wed, 16 Jul 2025 07:55:34 +0200")
References: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
	<1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com>
	<xmqqa555gp1i.fsf@gitster.g>
	<6AEC3113-D687-42E0-B6D0-DF62FA1A9A8B@gmail.com>
	<26cef1b9-1f17-447e-b647-3d32a3984997@kdbg.org>
Date: Wed, 16 Jul 2025 08:16:19 -0700
Message-ID: <xmqq5xfsdv3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Instead of this complexity, it is most likely a lot easier to fix the
> origin of the misconception that `pull.autostash` is the correct
> configuration. After all, it isn't even mentioned in the git-config nor
> the git-pull man page.

git_pull_config() does pay attention to "rebase.autostash".  

Either it is a bug for the code to do so, or it is a bug that the
documentation does not talk about it.  

The reason why I think "git pull" that pays attention to
rebase.autostash is a bug is because the user is more likely to be
much more familiar with both branches involved and more likely to be
prepared to deal with conflicts potentially created by autostashing
behaviour when making a private merge or rebase of local branches,
than when pulling from other repositories.  So those who show
willingness to accept the responsibility of having to resolve
conflicts that arise when popping autostashed changes by setting
rebase.autostash may not want to be cavalier to the same degree when
running "git pull".  git_pull_config() that pays attention to
"rebase.autostash" breaks that expectation.

There is another curiosity.  git_pull_config() does not pay
attention to "merge.autostash", which seems inconsistent.

If I did not have any existing users, I would actually vote to teach
git_pull_config() stop paying attention to "rebase.autostash", but
we do not live in an ideal world.  Perhaps rectify this at Git 3.0?

We could give a convenience feature in the opposite direction as
well.

It is not inconceivable for the git_pull_config() function to
pretend as if rebase.autostash (when pull.rebase is true) or
merge.autostash (otherwise) is set to true when pull.autostash is
set to true.  It would have prevented this discussion thread from
happening.

I personally think that such an arrangement is backwards, though,
for the same reason why I think git_pull_config() should not pay
attention to "rebase.autostash".  So I am not sure if a new
"pull.autostash" variable is such a good idea to begin with.


