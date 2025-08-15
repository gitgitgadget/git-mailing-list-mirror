Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28801A9F9D
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229131; cv=none; b=fMHtewqNeR1wV1M+TCXZa9WRL6Z87hICXpLbASWFh85YdoYOF462MrJjvXgSOEKSIzrVwsKO7S2se1FI0bORhiZ0pV6bh7IVQH24lF9jXgUDszKg0AT/Mr/RnVX+fjPDoCnVo6U08KfLzocQT0pbZ0K0i1aKQKNr18EKzUC8SEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229131; c=relaxed/simple;
	bh=8+Lhtx4n2aBuFN2efsWKuo0c48hoFoNv2inin9YNwZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAkc9IRIStep+GvYaTCwUIRslRtQi7JMu1ZHsOc5Y85lNeb411/D5S5OQPTuL50TIhVx84/mqQLbuGBLdR6wncFVkCHlCBt/dqvUqvOYmiXJNQtHs0pG/s0iDrBSMucZMb/Z/+SWODY8YzoNLmKWFFfny7+9+1AE8vdcSBmLYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ENUiWeWp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4FbEKJ9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ENUiWeWp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4FbEKJ9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C8CE0EC01A9;
	Thu, 14 Aug 2025 23:38:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 14 Aug 2025 23:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755229127; x=1755315527; bh=zDCEJ8gEEu
	gTLqE0yiRDwHFv/RRupDjfC0IbH5vuB2c=; b=ENUiWeWpH2UTYdH3mhc9V3hEXw
	BumqcgDhSJZASuGxrsC+QPcMLdORD90B5s6tv5WIIfAYFPWyMu+NwXtzLZCaZy93
	IOSUWNHFN9F3kGLRDk7Hhwd3iXXxdHVCnC/CUHDyDqQ+ZE0MaNBPttcuWZDN7nMI
	4vnqsufDY5VFqrHtgVEamRZDoXBJXmBTwT5nOdRqDIP2bUF3WeJFRN5yEBMf38mL
	kUDdOBoVlhUWvvHcz7ggTHz6Of1HdoMimYPh5cNrwkto7lSi+zPBYtEnc6JZCyiT
	HPMeat7f7R8M95zpJjnG4+ffpz+eanh0L1bC21pk1dofqdzHEhINC6qvZkVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755229127; x=1755315527; bh=zDCEJ8gEEugTLqE0yiRDwHFv/RRupDjfC0I
	bH5vuB2c=; b=M4FbEKJ9RTLf5PN4/NT+svHbCJk/JdwBMKDEWJkDqL4SP9aNQOb
	+fVcQSmudJ2lijURdTo2g1/G+Yb5pnkxajfhB9HiBT9x7ys6KPE3fnTap/lDmm1k
	HcDJnQbC6gmMXpkbkbJi/CXqdFOl8gVVXIwwfy6dgR6fchpcckmFuZRMofbpzdn3
	ypJ2oKqY2TMiGcf+p9SmC1L6UXENzFOPK8VidJm08rGsSzquPHp49afK+YfDl/dv
	QlnqHVg66NLWELxBp7+kKHONPuJt2TzrSFx2BUVlA+1sFfWvCsyDHdRZCVIaYcCw
	/w1Yor4ShNr8wgyZkNZNSpeBMqDXdN4bYsw==
X-ME-Sender: <xms:x6ueaKxejX3Wkw2QBA_u5_wNbdxwteMD1WrhojE2IrFnNKBR7vYqNg>
    <xme:x6ueaD2zE9J2y5LiRXABil6DHjV1WTUZjGc-Zc2nLsr9sdoZxCwPyK6ZYBDNB2H-p
    CQM_wqmqFAH1Bklvg>
X-ME-Received: <xmr:x6ueaCyNV9ZVYN-CghKnX5YjRaR13jMUiMV2fCkb44k3ARTAq0B91HtSeytBd73nRENyvobHunDJVK5poOkZJzIw1B4IKJT3-8NBIsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x6ueaCF4YYA5EG3G_0BcRDUZZvlj6c3i7o6nadJORul619leWZc1Bw>
    <xmx:x6ueaNYrJ-rDy2bEVq8-G8iGbR63N_tlbGhRV0-lkVzc1rrKC1r-xw>
    <xmx:x6ueaMBJMlVcMzhnqQselCTwj8ZLj62u5CTsyW8s--eVIyLxPQn7bw>
    <xmx:x6ueaNnhFIDFuWkocD4PnoxG5I4CWef5s_2YYFVR-Zkr81WT91wLPA>
    <xmx:x6ueaLXqfzw_uCcHK9UENJ6zNgyFOdQyUoiymqm3hnZujOr0eePqM0fy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 23:38:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Aditya Garg <gargaditya08@live.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 0/2] send-email: integrate with git imap-send
In-Reply-To: <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 12 Aug 2025 06:44:34 +0000")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 14 Aug 2025 20:38:45 -0700
Message-ID: <xmqq349tuud6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> v2 - Fix indentation in patch for imap-send.c
>    - Minor edits to commit message
>
> v3 - Rename imap folder to imap sent folder
>    - Make an error message shorter by removing unecessary details
>
> v4 - Fix a bug causing emails to be copied to an IMAP folder even if
>      --dry-run is specified.
>    - Minor edits to commit messages and docs.
>    - Add another patch that enables copying emails to an IMAP folder
>      without actually sending them.
>
> v5 - Avoid using -[no-]parameter.

We haven't seen any further comments; shall we mark it for 'next'?
