Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD51537C8
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858625; cv=none; b=ip0wePc1Zp3RJLmBkXsBVw6ibLgetWqqq7dV/wLkHo7eV22JUfXLUo1wUXd2g3VkU7URNEyrqJ34FvnndTJ3v8vpDvu3yf7A1fPqSY9rga6JMaktIY5DG3zXBAr09RBl+euc12gR9SGPiuktaDQvpzDkErYfpi/FDpgc4QLpZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858625; c=relaxed/simple;
	bh=bNgzEXNCZvJqtXJGegxdg63BHN3s1/LBltW5E8OU/nE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UYnFan+qPcr6m3707jph1BCHB3Xf7feBXIDURXkc2ZUKXtbQ8dizfBMPkFOv3zdmXtquU3CUSeVv1M3Gkl72HCoJ48+6fso6zcnuM8h5pB7jnZvFJXqa2PV6EmQSqOLeVMmOWAIyxPccnR4RYWeRlFDGWldwSeVTF1Gib4rq8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hQSKJg9H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsDZ1WJU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hQSKJg9H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsDZ1WJU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68DE611401C3;
	Mon,  2 Jun 2025 06:03:42 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 06:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748858622;
	 x=1748945022; bh=tsqwODF38H3+wnytVnA2680OtW8ufkpYPIRooCHdooA=; b=
	hQSKJg9HFzuGyUMvxefGPez8fLKbjyaLIsxuFUAx9UMT0y3cCHfRoyZNvUZMo7rA
	GLFTqEzbJ8EnPRuR3aJ6hBefX0V2qVjaDUqpQNf+wDlaLVuAvwBDCBVGh9dEjufE
	pdv/x1r2u3u3H3IBIUDeFljFNYtrpog2fhzDpWuyEdQgS+y0f3U84wghGEZW8QRV
	FKQZ0Hzohu0B55DhboirWPbiU/o7OLie/3LwRBQxyRtm4rADZ1NouU6Mzk/FcdUu
	uUcJwPi8r2oi7InBCHvEZVZ8Om5t8noxfuTCE+BdGVVYj9KBa/liP0gX4rlGJ7OS
	6EPNVr4/tzvCsjDEhMqhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748858622; x=
	1748945022; bh=tsqwODF38H3+wnytVnA2680OtW8ufkpYPIRooCHdooA=; b=E
	sDZ1WJUR8oUK8MeeDcVSFKn/5gPQOnRrJGTVfTFHJKBDNZSgJBilQ3P+6KFjVDUh
	AM5s8rpKAzfScPXhL2PM7lbZqW0EkvhqWLlLYezTKpu9UothxdeHmpZ1Iv7gW5eb
	xO9qFVxm20nmHdHPliOhvn1hgNb4VKDxPzdVf8Oz4pBCjH6clQPkZ3WL1mjpd9Ih
	JjLnafHxjFePHJlpSKcEzp0Surg1z4IhnhS1L/tIrbdgAhp8R5TyDMG4SdYQ7weY
	qCcC78FE+iF9mOTNeF28aFIgVf3qAIUgGlKTLh/G67bhaj+ueMBe1LxYraez3CXb
	OMjXxPO1EIGumquLLYxvw==
X-ME-Sender: <xms:_XY9aHs9Gzhe0ActqLkgnWfzj9D3HGYX-j-3Y7W_uYgDF6g92nIRczs>
    <xme:_XY9aIfLL_zQOTWgNDfHcU-E0es3Njy0p3ZsGUGCyMpT3eAiZhT6Jx7CF6N2X_Xqh
    P-K7XysgHYcKITI-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeefleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhi
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonh
    gvthifohhrkhhsrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_XY9aKxKCfsFNZewXb9T4ymeJIFxddFiqlv7oXGHX3MYt8Nq9bRNZg>
    <xmx:_XY9aGO_fn9doUsH9usahJScNYhtPRrCYedkNGSBFmupkJPqoznPDQ>
    <xmx:_XY9aH8zcq6-EaWjjrPuXTnjMhqfvxLRKLG-BgnW_x0usvgbaHfbKQ>
    <xmx:_XY9aGWj3vzYNFarK9-3IFzoZXgF8NVEUltiOKdWHFEDtvtqjxahXQ>
    <xmx:_nY9aIdDg1uVJPQdMHeAgKK-4X1NQC4o6NFo_RzjRy03ZxnN55AyYF7L>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D19B61EA0060; Mon,  2 Jun 2025 06:03:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbe012f02e624288d
Date: Mon, 02 Jun 2025 12:03:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Yonatan Roth" <yroth@paloaltonetworks.com>,
 "david asraf" <dasraf9@gmail.com>, "Emily Shaffer" <nasamuffin@google.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <cab8e175-e977-41b1-b53d-6b9170c9e416@app.fastmail.com>
In-Reply-To: 
 <20250602-b4-pks-maintenance-ref-lock-race-v3-9-587d44252dcb@pks.im>
References: 
 <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-9-587d44252dcb@pks.im>
Subject: Re: [PATCH v3 09/12] builtin/maintenance: fix locking race when packing refs
 and reflogs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025, at 09:17, Patrick Steinhardt wrote:
> As explained in the preceding commit, git-gc(1) knows to detach only
> after it has already packed references and reflogs. This is done to

I=E2=80=99m a na=C3=AFve reader.  When I read this I immediately thought=
 that reflogs
can be packed now.  But going by the last paragraph it is packed
references and expired reflogs?

> avoid racing around their respective lockfiles.
>
> Adapt git-maintenance(1) accordingly and run the "pack-refs" and
> "reflog-expire" tasks in the foreground. Note that the "gc" task has t=
he
> same issue, but the fix is a bit more involved there and will thus be
> done in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
