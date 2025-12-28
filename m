Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C178F26
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766939230; cv=none; b=OgIgtrE3nIQoy6Rqenz2KHbZzrqU9InhKxZpeF6g7fJknGKc3vnDLRvk4GR0HtJDRNGwxy4+qO1sG/qyvAW1e8WIA7R1+5D6192VIh30XKKs/BMynshV9XAMWIntXs6ZvAkgN2UGFUZ9KHFcLgayZIjI/bq+fV0Ls7H648oJUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766939230; c=relaxed/simple;
	bh=vjFreCi76I0c/8CQYRZiTUwI4s/qKTTRABtrY3dvQ0M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tmnDBp6M7czp/vcPF6QNSDcRCu2uMHPLDpkaD7K8sQehLBthlMCEPxo+AxcU7R3CDukLW/UIUsPTCF+oUwxNq3Hm05BPvRAbcL4tCvxUFUfB6ubv+iZrURRSbMzeJIshNEpupA8KiWMHAkWAWBeIyef5cCmgicmcNJ5ypK5pO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomsen.io; spf=pass smtp.mailfrom=thomsen.io; dkim=pass (2048-bit key) header.d=thomsen.io header.i=@thomsen.io header.b=b0pg2lap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbwVDNKF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomsen.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomsen.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomsen.io header.i=@thomsen.io header.b="b0pg2lap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbwVDNKF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECBA1140007F;
	Sun, 28 Dec 2025 11:27:05 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 11:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thomsen.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766939225;
	 x=1767025625; bh=fDBwVP4sJjrB0ff9nD90pYBNAXRnqlfPXzN0uR3oIWo=; b=
	b0pg2lapc2nIciyW2UY/9p6UCL0ebxzcRXSJSbOAGUioFcu960mw1/6FTtRA70o6
	2NqJhUPnQ0kE82iyKF5Y9CC49tu6Jb/Nu8t8zXOTDL9t5I+V92L/1RYhvmtvkkBt
	DDyVj+O4rKIU5T6Xcb4EAEq8IYj918Etgdlc/4JQvXR+/8YuaNnZR0hBu6JbwErN
	Waf04d7Xl+bkNhIfPaEs8FU/UwMlmFnriU2exEB4QfMoo9HhIYnwRVpDQZX6s+mP
	cu0xieO1Da43kocCv9JYh/jEy+fGK/LAQ2lmnMlRGmaARp1hfv/9pYchSLiyWhli
	GEO4ovO8tas7QkeSXYyaiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1766939225; x=
	1767025625; bh=fDBwVP4sJjrB0ff9nD90pYBNAXRnqlfPXzN0uR3oIWo=; b=c
	bwVDNKFRcvyfU+xBc+MZb3n4Fwe+VVnzXnyYcNrRDxGDkCTvDDb+02XCsC6PRjqf
	5z/Q2I+v6Y/7mdbUX6Nh9aAIl2FSF45jxvHP5gLuhlPrB8AterUzHMzpJ9llM/z3
	TokdgiJWu/9MTlj6dbCldpQrZ9lCk4camvDOFzHnExVZEHqXXgR+s6w7kOhj3jDJ
	iuB/k+Wket4Nhd14jhzn6ijrVMpsuM4mG7IqCRb4tPEzw+NUEF5wAtugek1tUTFy
	sGsdV5kORjQTnmEANV2xg5o3Tu1fDPXceZzoom1ZNbRpsZFfzmrwGhSCjd1bi03Q
	sj0504yOM6/CdXRC9KVww==
X-ME-Sender: <xms:WVpRaQ7qrg2XnYJaHBKmrYjzP4UR2cqLPw2Q6krhjjuJ2p7J_MCRPw>
    <xme:WVpRacsPOb4zgsIrWL0NWFagvBmBJmun3Sdyg7vROWIpz40EU-lBs20k5ffsmK99y
    VWoFt01dpAiP8uVFXO75N4eiWeylyCZgjyLOpGiblSqKxFvdnFOKTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfvrhhovghl
    shcuvfhhohhmshgvnhdfuceothhrohgvlhhssehthhhomhhsvghnrdhioheqnecuggftrf
    grthhtvghrnheptefhvefhteevieejgfdtjeeliefffeefgefhffeggeeuleehkeeftedv
    tefgffffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthhrohgvlhhssehthhhomhhsvghnrdhiohdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WVpRaXXaEODbOHYp2-Ctg43Fxi5Rg0dHo8D-YlueUGpySV2nQQ_x4Q>
    <xmx:WVpRaXWlGE6nTkYdtWtcOJ4EUI9RLItgJa1KVo2o_v_iOI6n14_C9g>
    <xmx:WVpRaWcMY8174T4jtmcvZ_elPA1s9UBvv73gkNgh9-ADDNzVRKXQNA>
    <xmx:WVpRaQVT1jtjklPQ92uRBxo84Vqqzpf4G-b0lJ4Gz-o3lGpRWmGRJA>
    <xmx:WVpRaV2_GPaFrtVOacxiVrseaUvVLCN4-4M2j21Qd8AaN799WMINijRU>
Feedback-ID: i64d840fe:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A8CB18C004E; Sun, 28 Dec 2025 11:27:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABPpY6NV6337
Date: Sun, 28 Dec 2025 17:26:45 +0100
From: "Troels Thomsen" <troels@thomsen.io>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <a16bf8a6-2f57-4794-91b5-92615f184c4b@app.fastmail.com>
In-Reply-To: <xmqqfr8uk61i.fsf@gitster.g>
References: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
 <xmqqfr8uk61i.fsf@gitster.g>
Subject: Re: [PATCH] receive-pack: fix crash on out-of-namespace symref
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Dec 28, 2025, at 15:57, Junio C Hamano wrote:

> Fixing crash is certainly a good thing, but when the namespace is
> segregated and receive-pack wants to get updates only within the
> given namespace, would presence of such a cross namespace symref
> cause updates outside the namespace through the symref, defeating
> the point of setting up a namespace in the first place?
>
> I am not objecting to the new behaviour, but am not sure if it is a
> sensible one.  You _might_ be able to argue that an attempt to update
> underlying refs outside the namespace through such a symbolic ref
> should result in an error (i.e., a fix to the current crashing
> behaviour is to die in a controlled way).
>
> Thoughts?

I think it's important that the symbolic ref needs to be explicitly
created on the receiving side.

An argument in favor of allowing updates is that you can still choose to
reject them by implementing an update hook. Would the opposite be true?
I explictly wanted to share a branch into a namespace and update it from
there.

I suppose the behavior could be configurable. Given this bug has existed
since 2016, I'm assuming namespaces and symbolic refs probably aren't
used in combination frequently enough to justify this over using a hook.

-- 
Troels Thomsen
