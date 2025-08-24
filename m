Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E162E11D1
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756058916; cv=none; b=iBorwwxeANNLaAGX5C4GAKUzyvIy7b6/JCmoSxABgww7FZOpNS/tLI7u/GqDj4dZFNk8W5YTwiBOAX46dgE3/11k65RcuY166QlG9jnyFOH5WtVuINWn8Kk97OZVZ4X7T+4QpVH/Xtz4ysBNF3PAW55ftnmhCnOWYkyA/q+A8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756058916; c=relaxed/simple;
	bh=YdrSyHEJx5NmUo5M43rJP1TiLgZ3hFOonGVBL/A/D+0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=okEhPIFqUJ99h4TzJE2ofTS6JBADMYe09NQ/sSQOkHRTltn20u3sEg8DrkY4Et5TSn/ZSlafgVMGLKnsr/o/r40mhAG9bGKyMa4ndWJxCGuxbr2SKdVRHswE6OURNGPPtE3IAPyfnCHiRpDU8CEThsbQaFYycVS8aDJDfzMvl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=tzdDoS/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiVo6n1m; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="tzdDoS/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiVo6n1m"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E484CEC00FC;
	Sun, 24 Aug 2025 14:08:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 24 Aug 2025 14:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756058913;
	 x=1756145313; bh=+jiAxI8mVJLEwbGqz7keAKzmZtpcq6OD2iL2jg/SaEw=; b=
	tzdDoS/yoJQJ8tqQ31gjGstdKHphiG4WpwND0wOxbEePbG2IqIVjyMWnds42vDzA
	hRdmSd2VR8wBPsDSOVBELcQgvsbQEiCKlNul1AErjQ2lbJ3Mdeu8zJfc1mXzGafy
	VDM6rOPgm+K9y1wsGn1U2XZZM61Pn3Ttv31l/OJ4Gbw9PVXK9v+t7sSsZRlZ4ISQ
	bW2OD6h/wQ+qy9OIfNQ01eCOHrjVJWVy5FBzl8k2bqYzGf+z2yHQyT1s+pZ/Pn3u
	CN1FAgxLl4JVuCEiB74UkDe38wpbywe9OegyCAo/LPEuI3I6cossQRec3QF3zei0
	Ny0Xf/u5GWGtMZ95GHBSGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756058913; x=
	1756145313; bh=+jiAxI8mVJLEwbGqz7keAKzmZtpcq6OD2iL2jg/SaEw=; b=h
	iVo6n1mx9T6WT8HIst3YQ9Sj014asY6kDVoSYPQs0DeFKcPHIX2jF89i0wNfg6JL
	eAFe32rHErE7gxl9xasYf3xb2nqYyGaS+LvllRrUuc5WYzPfA0peV90Zm4qf85Zo
	vyo/ScyzXuBuUD9rofaxs1XRmkfXTbyLiue3/k/+zWrc0L88s7nuPiMTFIUGvWgH
	r2euXJ2tlFr53ssvgcr/jDGzteU/0va/7m9Spteb5F+F3kAfaOYs/NUhug15FwMg
	C0QkBYAqMQ9P8oEp7oGLOVKIXJWvkIaXuuSeY7m5fyxP0odBP33cAsdm8/qAOt1/
	RqMDU3d37VrwWQwR0hjHw==
X-ME-Sender: <xms:IVWraCpFsYmjaQBLHdf69RoKuqkbjY0uG4ASoQwHPN95dbl0PQFx6L8>
    <xme:IVWraApLTFslHYRN0fco26mnROTRkP2_85tbbVZaeWfYWTDFPGFBQh5LxI9NQQW8T
    zyiduSuoGCLCrl9DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IVWraHayygZFiYAWAOlANftkWMU0gj9hSEIIpaDkh7qdciUK1gdTCg>
    <xmx:IVWraKPUICGPy5EfOXffyeuHt4Cl_k8TxMjFAYvbgXj0T_cDJbvlfQ>
    <xmx:IVWraDBblkwknWd21OtsT00Vy4rvWcOGmD-Jg_r5yntVQHquzd_gjQ>
    <xmx:IVWraBJPDNYeOUJ3_nTqoUPHXt0yYKjdN1O8ww7S03SYkiCig9Bavw>
    <xmx:IVWraEBYN3DQBqiWCujmwvEJZzfRcMrGAcAQxea6Yi4nyuOHW7iRVYo_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 99C6E1EA0068; Sun, 24 Aug 2025 14:08:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaGeA4Zfr29s
Date: Sun, 24 Aug 2025 20:08:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>
Message-Id: <5079326d-497c-4335-88d0-a248e0b8c6d1@app.fastmail.com>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-16-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-16-964ac12f65bd@pks.im>
Subject: Re: [PATCH RFC v2 16/16] builtin/history: implement "reword" subcommand
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025, at 19:42, Patrick Steinhardt wrote:
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is essentially the same as if a user performed an interactive rebase
> with a single commit changed to use the "reword" verb.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

I get a =E2=80=9Csplit=E2=80=9D error when I typo the commit to reword:

    $ ./git history reword ./s2
    error: commit to be split cannot be found: ./s2
