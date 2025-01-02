Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA524CA6B
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735829884; cv=none; b=tiElV8uX4Rsak19hGfA7Tt1q0q6Ei1ZG45Yxt+bitz6eRgoIhkQujQdU/4KB4wFY+IPCPUhhwxZB7CSu7QUCRQtxxhAn6QgV/3FKe8JmrA4kJvGoOE2aJzXkju80NCVpG0VuT5B8SiBAh/cHCdtgZufyzaIdy+CcdLwWyBG1Wak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735829884; c=relaxed/simple;
	bh=HlQxG9RgfsK0MaSXP3JKHAXRv+MkKPiChQ5AFWFrpEg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JX8R0SfcGULe36lQQ2U+zy1qDGVMqySSCif9Yqyqc6b1Am5QlxvA1kcBGA/3YfzzCEkvRfsS9SKJbtOIpe/JJWyr9oy1vVIx1QdwkXEZj1eLuZnf56AzwN6zefDzpZWQQrUd8pW3BAfyXECKfJBIIBLAGZGg8nsVeuT7iuI5/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=k3EoxfVN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a07nJRqH; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="k3EoxfVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a07nJRqH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 82762200550;
	Thu,  2 Jan 2025 09:57:58 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 02 Jan 2025 09:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735829878;
	 x=1735833478; bh=qNpSPV0D8kpxTO0vhDY3nVL0hORH+qiCOaIH7JbMl0w=; b=
	k3EoxfVNTENYgDR6SsLnXzn7e1vlwV8cozjgP4zauRFkO35zo7ytUuYG4FevED/h
	0qlNciSVyGFcM3mgOHCT6Juzj52E6B/Z7dLauaf+xKJHwM49Z4vulb5Idq3+OM9n
	epGV/t36WI4qzgVyysQjsP4Y2GRvnRPj/yZQvxLmI+5TG2MvMqIwl20IBpEWzWWR
	RWNdmI1AQ9dXmmP6ImGKsQHtt9nS7+76toeAqJbX3ijhkBKIS26G7M+YGcd3SAh4
	nSk1pZiIPrN3Lk8QbyYeSWkBgbj+82+H7Sh1apvLWCd7Bw4xYwJAFEi5TRx7QO3C
	y+croGOtwpf7p6+6pOKxSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735829878; x=
	1735833478; bh=qNpSPV0D8kpxTO0vhDY3nVL0hORH+qiCOaIH7JbMl0w=; b=a
	07nJRqHYn6h3B1C0a3w47hhBOPM0ru4z/KlWr4DRlG5PPbldiYbxWjMcvFYA5T2n
	eHRgxehdnl70/Z5fIpLYcoO3QiyIkuczYgIl7nvh5imQb2a4weDpzEwkvRHz8TPY
	QZMKuEd5fUr3NX3alc7PtDcWWpwzW5QJlyR2YwYChS0jGCmeuLmo3uC8a/Z81dx/
	srklVwyu5ApYZnf1ThzT2jAXiDwzKayxmyipJg4gtEZi1inGCh8L66aPCN3YTV/N
	3S3Tnb9v0UbHE6ezfS0qWE5aeC3aA0rMdJaMavkc8VtqAA69cSzsmddAFyguHFFN
	nWhfhr/fhiqqsvvkVJU/w==
X-ME-Sender: <xms:dal2Z6_bUBSOAoDVpHatKpc_9vttRuUR3f2OF7JXX7d7gs6aO-aICQ>
    <xme:dal2Z6vfFtvvVkYNMrPUXdb4i0LlxuMFnGk3QxMjC_zQIL2m6q0DvV5PtQ5jWdhs4
    ZibSZS2bg-n_a9HkS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofgggfgtfffkvefuhffvofhfjgesthhqredtredt
    jeenucfhrhhomhepofgrthmvjhcuvegvphhluceomhgtvghplhestggvphhlrdgvuheqne
    cuggftrfgrthhtvghrnhepvdetueejfeegvdehgfelfeeltddtgefgueefieeghfeiueej
    iedugfegheehfeffnecuffhomhgrihhnpegtvghplhhovhhirdgtiienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdr
    vghupdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hhohhnghihihdriihhrghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dal2ZwA2tUijJBMPO7jMMOTS729CgADsFloUPGZ-Kn2yA8fTVcQsQA>
    <xmx:dal2Zydqj9CFaZDuE8Jm_kW8q-O9lKgFa2VG6cY3FpUiQsR-mMROOQ>
    <xmx:dal2Z_MAp5DiTyvT3nwDU_3QlHGUjO0V2gVfQjv0WLunocOJIYhk7Q>
    <xmx:dal2Z8lV4LwZOkVQ0_Pgp8sQgOgMYcgTMYh8k8SzCQn9mkTH4n9Lzw>
    <xmx:dal2Z1ZtedQssnUisz3kMdnSUn8E03HLksWNlHCceE67BGyPIBK4C-Av>
Feedback-ID: i8c5e488c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96D0BB0006A; Thu,  2 Jan 2025 09:57:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jan 2025 15:57:56 +0100
Message-Id: <D6ROC4RAYQS1.3V2K2W5GMAEYR@cepl.eu>
Cc: "Git List" <git@vger.kernel.org>
Subject: Re: Change the grep command called by git with alternative tools,
 such as ug.
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "Hongyi Zhao" <hongyi.zhao@gmail.com>
X-Mailer: aerc 0.18.2
References: <CAGP6POJX9GFsNkgGd7o9Pr-tFoz0sgRk51vVG4P0Kn1DPZe+3Q@mail.gmail.com> <D6RLU4BY374I.GQY9MLMV1AZJ@cepl.eu> <CAGP6POKLdTpwsaGo-oyGAiYJMRzwXN06rv3+V7v5QbL6xtDROw@mail.gmail.com>
In-Reply-To: <CAGP6POKLdTpwsaGo-oyGAiYJMRzwXN06rv3+V7v5QbL6xtDROw@mail.gmail.com>

On Thu Jan 2, 2025 at 2:39 PM CET, Hongyi Zhao wrote:
> Do you mean: by linking ug as git-ug will do the trick?

No, you would have to rewrite git-grep to use external grep-like
program. I am not sure whether there isn=E2=80=99t such project already
out there.

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@en.osm.town
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
To the well-organized mind, death is but the next great adventure.
  -- Albus Dumbledore

