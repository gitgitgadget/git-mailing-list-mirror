Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376D20408A
	for <git@vger.kernel.org>; Sat, 17 May 2025 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747511858; cv=none; b=loBK8SNsirJuZi7WiqeCe97va76H5Npgnm37wyt6vG6FIopUteg+qRFL+L8Xzdhf6zpuS79hpjqk2KjOeRwRwJ7he2HX63SGB7w5TGVOzKbnQmUNLAG8OAkKBOZgWm9xCWUkrpVUxBAJL9WC2rffu1iaX//7mGRW1fJuBWoLww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747511858; c=relaxed/simple;
	bh=sN5u0I1Zs0Y6jo2JN3P/wemHuShHD8LoRpmfIw0F50U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n151ZQOgMBr5R6Bp921AA+hRPtX+aqAvJAi481p6WI2wh3qcNCr9mVfiaYdU4u5kqBxOYfe74ihFBBkkp2tYucy/WrzNNeJdNjt6OI9sOIHZQ5A1UXaVgjLQRd0/x5sKrZ1b9HjX59B/WANq3lTSW1k59UyLv9cIRPyqQzBpFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VlQmsKNL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FfcQuzGY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VlQmsKNL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FfcQuzGY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CD5C11400D4;
	Sat, 17 May 2025 15:57:35 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Sat, 17 May 2025 15:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747511855;
	 x=1747598255; bh=sN5u0I1Zs0Y6jo2JN3P/wemHuShHD8LoRpmfIw0F50U=; b=
	VlQmsKNLbA3LTZGONBXD8pj2hT3c4nj6rutvrq3Lnlxofhdhbn+Ni0M4sth3Jtv1
	tJxLdrcK1aQbsIYAMsTbnbzCr6+BFHY2lvjp9o6g/3HlDe1QKMJ+l09uKm21Uab2
	Ief0lLc8Q2NBg+yrxcYsXf818wZLYPK5c5b8eai84Z0fhlMSYuDDXvBTq67zeDff
	30m7BQE42Kk7r/Wn5ok/rj6y1wuxw/vt+sOobIhD8jswdPqZpK+Bxmb97OVQZJI/
	E/HEJMkgOwKpY9XuRvdrCUpYKMeWH1NFubSkDYky7vsUbuBldrzfKP+JjtBUexYR
	hKr1bldvUWywBZprRlsdPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747511855; x=
	1747598255; bh=sN5u0I1Zs0Y6jo2JN3P/wemHuShHD8LoRpmfIw0F50U=; b=F
	fcQuzGYBzngKR3XuJlxENUGFchDBq3suyKRvS63seqtQ38m22t3FZt4/3fkD+2k5
	Tion2L/vPOKdFgdccQ0WOahmkaP4cD3v//kTtgBWYlfL5cP/M6Y0eY/vFyomWdeY
	PF1yFm9VdenQzb60ov3hfKAhOKicFC74WCrSsebdCb3h+4bwy94WcY7614CdFdDI
	HBBJuzWeMQvsuT85I9efsGl/H+uwirVZtyQtHv4exvgdIpnvPn+XwY8a+nC5ClLZ
	bXDr5F3crkDrb66rxckpn7vzSEhsKDjfHh8Oj74nlalZTUU7oI2AJKzY6+Z3CFOq
	m4oWh+SpObDx38Kwo5QMw==
X-ME-Sender: <xms:L-ooaLKI3Dfz27tiQXKxc5N76ctp1wpWNK1dVdnyBQnXiayh-M5Dm1o>
    <xme:L-ooaPI7xJPkgKgbUl07Zc9g8Mt2wAyhqk7UyremFvIX2HlovdbJh22Jf_uyHkIq4
    7grN4a02VXowVrYaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgie
    fgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L-ooaDtK4U4lWhAPPyF5ZS63CedHZDRnqdE29RpwCi1uOQXCLRtpcQ>
    <xmx:L-ooaEYJ5dvzMbrtSoRJ3ASg4lmY6FyNSGghT-kNBR9l35pg5174NQ>
    <xmx:L-ooaCabpeODNNyRqSXBV9h3R6E_dvUSbEmprqF1wpDGVrjhomfCIQ>
    <xmx:L-ooaIDP1TKfo4oaHuDtScMuIgxdksdx95Hy6PzS18qXY-ppzXgdcg>
    <xmx:L-ooaFhEyyTWPIbOmVGr_JX8ROuYC9J47wfdX8A1048Mi0W-boN47Q2Q>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 440F5302005F; Sat, 17 May 2025 15:57:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T370c812ec62578b2
Date: Sat, 17 May 2025 21:57:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <57dcdc06-d7f2-4661-a2bd-de48690eae6e@app.fastmail.com>
In-Reply-To: <6cc85081-bbdd-43f6-b17d-8baffedec8c9@app.fastmail.com>
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
 <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
 <7c40d3c921610576dc7947bc4c517055717dd94e.1747425858.git.gitgitgadget@gmail.com>
 <6cc85081-bbdd-43f6-b17d-8baffedec8c9@app.fastmail.com>
Subject: Re: [PATCH v4 2/2] merge-tree: add a new --quiet flag
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025, at 21:52, Kristoffer Haugsbakk wrote:
> Can=E2=80=99t they opt into a new informational mode where
> `--stdin --quiet` can co-exist?

Yes, I now immediately see the contradiction in the
literal text: =E2=80=9Cinformational mode=E2=80=9D and `--quiet`.=20
But I shall not weigh in on the naming matter.

--=20
Kristoffer Haugsbakk

