Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEBC257449
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382373; cv=none; b=lIPaKWu9cFA5+ghtx8febVCakOsbEWU9MAHT0jAqWogvy9KZj9fiJKBBC7CbnJvlHkfmPWNZl30qfuRYhp5Wn5PRAipHMOGsWceUDPfSsBPVHTnn6VX+CFQYfwRYg/RT89G6/MgDeZtgHQBa2GXJRpb7qnsUiF1NgZQKyp8J4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382373; c=relaxed/simple;
	bh=m+5tzVROIEUXjaOzZreAZFACVv2oun+ijN/JlRs6OJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zb/Wy3agX9IAnZYCXXZbrQ+xughTKEOm3kB68nWESTqXitQ4vtls/yrEWXQ6Ar3uKUbxGYoSxYS5+x1PsBV1twdvAKPlhro6C8fC3FYHNCxsGuPWgrjNmEkI02atlOotxfAU5cgB1hzsGc1atxJTEmmU40PYsaXSdYEIc2dIdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0i3BR2Pe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiyaE6kk; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0i3BR2Pe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiyaE6kk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 78AD8114019D;
	Fri,  7 Mar 2025 16:19:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 07 Mar 2025 16:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741382370; x=1741468770; bh=HwA1cI2qt5
	6m19P/3qAjoX25lnaXQT6+k7ZGe/3gwVI=; b=0i3BR2PeOAjGFHU9pu1JGwi8JE
	KFu8pgG4u5TWEhp5WcoUezIAIZKMgZytuwO9Fto/XcVKP2LEWMDirlAXoaNWH7E9
	vhv1v4AzGy6jH3Pte8J8nk9ch/Ss+h4NajITieUYwK9rqZF4xXdBcj89eEOCxUE9
	DIDF22BuSPkxHhh1ZpA0ifJvnX6/cf/liiVpKJaTXR7XanMqE0okgCqYsuoioS5A
	awNrjE/2Q+HXpcP0smykSzTd46isnze9KR45fAzGbXQutdI4Jir28/Ql/KocRAlC
	T5G8vtdvWHxAZEKRO/RV0G62FZFeBNP8b0OEY3NLJRRb8aPM8qX22dD27y7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741382370; x=1741468770; bh=HwA1cI2qt56m19P/3qAjoX25lnaXQT6+k7Z
	Ge/3gwVI=; b=PiyaE6kkJyol7f3MhFbGoV5kFPeifxoHIpc94MaNykDRWN0V15P
	eq9ZBkXMWC6OVudNnzaBb3byjfpoOa+5d9/28yR9hVY5pTpGekbgLFi6UDwtgyiN
	s6mpMnrAF9HYxy3N6MBpTjmHBlAmp2tauLLFwmkAZQiVaVvyCnSc5afMpIGr6S5D
	AtnQJY1u1OxdnxhkRmc/PPs7zoa55dyjAoqk40EZMYitGmuQEAtGUiDB0kZJffs7
	+k92mfptWtX5PnhNmstXT7skxYacU0X1fbVP1bbQ6bAq9oEArUise2ji1g7lx/W2
	AudLrskTK6HrhlC5yAgSxr4p3Be7ShjRUYQ==
X-ME-Sender: <xms:4mLLZ0ionkVKFMYPwX6fGXl-W4l3kOeh4MQnyUPuWwfmbckezO-oJw>
    <xme:4mLLZ9ByFAqpv-wQZDuFQKLH25n0hYKmM3hMtEBkyD_I74R0ExWZ6OP5zzysVPzoQ
    MHDVjwW-zKbaG3poA>
X-ME-Received: <xmr:4mLLZ8Ea_NgfcHMoCCWRCJVKlBcGe1MptZlxSTxmm3jGlTb2nBuFzmw4FIfhjZ9Gt8gvbTZTAuMMSWfbWWzhQ_FUPrxFVMwVwiDt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4mLLZ1Q2MDAWX9CRFP5YPyRcpOGXGk9D8BLRLygrIFkZMkuOjqLLXQ>
    <xmx:4mLLZxxeCv-VZHhf61CLdSmUVG-t63rUE0XmNZAk2EiA1Bqb4KMC_Q>
    <xmx:4mLLZz7WrXI4dZz58PFhXF-VH2_BvGFwClEKoGTVKuhOgBcPQspDSQ>
    <xmx:4mLLZ-x9RbovozYwqR4OZ8cg2Wx9jIOBUmq9jVCRZoQyic4yqE3Rvw>
    <xmx:4mLLZ5-FFx_9M9VjVT6T-h6kAVfoAWdIr-BPS62pj7TFnses0YXgSyL4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 16:19:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] reflog: drop usage of global variables
In-Reply-To: <20250307-493-add-command-to-purge-reflog-entries-v1-1-84ab8529cf9e@gmail.com>
	(Karthik Nayak's message of "Fri, 07 Mar 2025 12:17:25 +0100")
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
	<20250307-493-add-command-to-purge-reflog-entries-v1-1-84ab8529cf9e@gmail.com>
Date: Fri, 07 Mar 2025 13:19:28 -0800
Message-ID: <xmqqo6ycczdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'builtin/reflog.c' file uses the 'the_repository' global variable
> directly and also via 'git_config()'. Since this is a builtin command
> which has access to the 'struct repository', drop usage of the global
> variable and use the available repository struct.
>
> With this, remove the 'USE_THE_REPOSITORY_VARIABLE' macro from the file.

I suspect that this is not quite right.

    $ cd w/git.git/; make
    $ ./git-reflog list -h
    usage: git reflog list
    $ cd .. # not a repository
    $ git.git/git-reflog list -h
    fatal: not a git repository (or any of the parent directories): .git
    $ git.git/git-reflog -h
    usage: git reflog [show] ...

but I also suspect that it is mostly due to the original program
structure that uses OPT_SUBCOMMAND() that the subcommands fail to
respond to "-h" unlike the top-level command, so this may not be a
regression.  I do think however that this change is making it harder
to fix.

In any case, when you are adding a new feature, I would strongly
prefer you did *not* take it hostage to unrelated internal clean-up
with a dubious value.  For the library-ish parts of the system
(e.g. reflog.c at the top-level), not depending on the_repository is
absolutely the good thing to do, but the top level cmd_foo() are not
meant to be called as helper functions repeatedly with arbirary
repository instance, and a churn like this one, only to mollify the
USE_THE_REPOSITORY_VARIABLE macro, does not deserve to take a more
interesting (in the sense that it improves the life of end users)
change hostage by pretending to be its prerequisite clean-up.

Thanks.
