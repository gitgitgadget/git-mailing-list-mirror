Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85C1D90D7
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155048; cv=none; b=YGzjM60sJu1t/5eDX7jO25GQeg3PEwXNqjBQWD6VTfB+EkrGcDyPoUzs8HDkxJwMm8VPDSM1WduBH78gY4sUseq+TpbMl9dalPqav4y8mh3NekCrzNRELcQcrMAlzX3SutxP+iSTZbYjFOANF3pHsv72PGHqXrNgAtqSCdRWUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155048; c=relaxed/simple;
	bh=0tmv0lqPKQrC6CxTgNlwAaRPG/fuji/MWesCGQqE8ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tSSzF7vb8lPxQtt3BgGDVpGJs6xEdTGDtPxfMG+mvc8Mz8E2se9t6LQtGDHbx4jY5vZ3x/KTsORRFAmNtAS0b+E03GIarZNy+q+h+FnoYPN4oHxvuMOFox8SLDrul9MKOlhFrULF7lPvitin6wvRPyBKEXGebqCu6eDfIwC6mcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PgYB01bu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWPKqfKp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PgYB01bu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWPKqfKp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD5BB114022D;
	Fri, 17 Jan 2025 18:04:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jan 2025 18:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737155045; x=1737241445; bh=3q8PMQI54O
	FwIwCcSy3TaP02FAhn9Cv47e3K5OZTnPk=; b=PgYB01buR7FT1TKHaVfUTyUvgE
	zvGVL6vcENbalEt2rg2AbWPcKxrP19A4UaRkDocbU8aaA+dOKjkqu6g+r60WhmsY
	8De5a38eXVQ18UF/YsXGLgvTwtEZBj0N0IkQ1ZUGFpc4STW8JFjjGg98BTa8F7zM
	BF8oWAPmtE+kd1LKKIwaHiryHVL9C6qRvv2Gse1vc+r5ZNJjNpuRO7L+GSTvOlXt
	SFJy9yYGjNrKs9DRAIu9xt9n8hXQtzV3o3TllR9Wkr+dh5cRaooVzVMMu0bXu0C9
	xpiVH90bjIJ67Pfz1oSWcbYmKpOPHWcX7xBbcRhcOlRnBz2YAmwJzcQjeRCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737155045; x=1737241445; bh=3q8PMQI54OFwIwCcSy3TaP02FAhn9Cv47e3
	K5OZTnPk=; b=qWPKqfKpmX7Ig36j8/UWkQZjcpudhkhhvU8OKAZ6YKlHwdUVof/
	FbN2RcDF5gT7XUhYQx7QwmjtSwXC95sgmAljKmtHR+lXXS0bPbHNQNV/jhsssa3S
	pfvzmsGp6sh5gg7JEmcI6HpBSg8zaYHXkrdBa9zCg4z7SAgNo9nZlrr0f9gfig9f
	V1/URvf+zcgSVYVXezWE6dHcDijxP+kw4OkmwNoakhQENsguhXRU08tt+8SNcBIZ
	1/Ez1H04CAAoShyZz3EpXcSGSQrFjc+L53sD7Tv0CAMe3fLsvxmhXFvKlbGinYD0
	Tt1TeppYFZDckt48OmcwiPnpxKMmYWp8iYQ==
X-ME-Sender: <xms:5OGKZ2NVMisrun2hzCviAUNx9Si_Eo78m-BJDxRMhPC_3r7sMngLVw>
    <xme:5OGKZ09pX3bG1S7w8CcNIzItMvV-D10D7QpTi_HMmGh0OsgCa3ZGbjk3lrMSqa-oo
    zgHiAGSuRxv4GZOZw>
X-ME-Received: <xmr:5OGKZ9Qoca23uT2KYzjca3WL4VR4vn5BLKOID9xb25RHuromu7rI1qPFNFFgx6enDPZglV7S51Y4GaSvTOEFug1lzbUMv_F5A_2f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrh
    esnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhi
    vddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhnhgtrg
    hikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:5OGKZ2tGMETIpw2LR3Z198uHWegwF91wqrFiy3vMPBneSZ14vAcTmw>
    <xmx:5OGKZ-fhuVgjxrTV9NAEfgA99wO5suVsgXkgZcWghv3NgM3eqnMShA>
    <xmx:5OGKZ61V9dv7YaqT8_8MxHmf6tcaxNKdVSlMso5nrVCMtU2wnKx81w>
    <xmx:5OGKZy96iIb3PJq2a6LHRNlskk4nOBu8yFu0Q7sw16ad7OwXhwqhNw>
    <xmx:5eGKZ01kk91gTUfRvsjE5O5quGWaoWACBc9l00MigNOvDG9meCcJP4L2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 18:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>,  <git@vger.kernel.org>,
  <christian.couder@gmail.com>,  <ps@pks.im>,  <johncai86@gmail.com>,
  <Johannes.Schindelin@gmx.de>,  <me@ttaylorr.com>,
  <phillip.wood@dunelm.org.uk>,  <sunshine@sunshineco.com>,  "'Christian
 Couder'" <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/6] connect: advertise OS version
In-Reply-To: <00bb01db6931$d7cd6dc0$87684940$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 17 Jan 2025 17:47:46
	-0500")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-6-usmanakinyemi202@gmail.com>
	<xmqq4j1xjd2m.fsf@gitster.g>
	<00bb01db6931$d7cd6dc0$87684940$@nexbridge.com>
Date: Fri, 17 Jan 2025 15:04:03 -0800
Message-ID: <xmqqjzathwkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

>>So the question is again, do we ever need to use os_version() that is a raw
> string
>>that may require sanitizing?  I do not think of any offhand.
>
> uname(2) is definitely not portable. uname(1) is almost always available,
> but
> there is no guarantee about uname(2). I am not entirely happy having my
> builds break if having to write one between rc0 and rc1 when this rolls. How
> is this being handled? os_version() is also not portable. What if we had
> something that asked for specific elements of the string, by name or id.

Sorry, I fail to see anything in your paragraph that is relevant to
what I said.  Especially os_version() is a function that is
implemented in the patchset, not something you would complain about
being "not portable".
