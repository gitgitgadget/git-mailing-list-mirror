Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85D344046
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431003; cv=none; b=aA09URTMyTYENJt/eK7klmt3IQqO2ggTYNvN+YyQeGziwnwiOI30dJS2j3Uvt8JoC2tLbnJjLqUqaiGdhC/n2LRYZqaoZGrXR0GXv+3+MgrI9qqQaF7wPliqyS3vumTjzyCIiszUzM5fwPpOAhio8rX9qwYQICvDnZaOyDzNzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431003; c=relaxed/simple;
	bh=ZjsX2jL9Lzvm7w2gSp2lWQRNP55T+pC/IvFpOuvH20U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bzZgmMh0PYiigUtAnah66FTNH9xIpAsEuQYS8+6reBwCJsvUZKwS2eT5x7H5pi7s9WCToFQ559e2tt2JeSATysEpZN/d3UubMezeTSVQgdbiY2NubQACg5vZh/hvaeBpbg2i14PZaQhg1cd/S/jsg4N6HAX+wXxS0b6OR0mERmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=wCl2pdP3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqmAlRp+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="wCl2pdP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqmAlRp+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52E517A0163;
	Wed, 18 Feb 2026 11:09:59 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 18 Feb 2026 11:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771430999;
	 x=1771517399; bh=ZAu2GwfjrQ5rFtlEfvdNFDC4pmF3UQE8REyCu6hCvsQ=; b=
	wCl2pdP3JBIsw7XwzOukInDqqayuPpOpzcoFzsNpeGDj1tSAARxOpgwPFXJ4cpn1
	kwPjuqD04U5omERv2DoewKJ275J/+ad8kfCeSQY9QRv9zXiNw64bfVJUxCUK9OAm
	0n2gw9kgnPLJb6qk+X1xDKZIdvLKqdXSjtxu0OHAzAarjPOzalP7Yc8PJiNk3P/9
	wWjS2EAkztbbSJ8LGrO3NHwAXKj6289/jVDQ6axzRHFQ55lH68EquIOSqznOw7W+
	IBAUBYZvFefoRTYalR30b+fKmbrlnlwY7YhyT3gN+CsxR9VOEM6G25WBNvQjNJgH
	Z9Q7HnEI0ER3h0sJAWBoNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771430999; x=
	1771517399; bh=ZAu2GwfjrQ5rFtlEfvdNFDC4pmF3UQE8REyCu6hCvsQ=; b=G
	qmAlRp+guuy/QNObtL4oq4FjEEbDVtp1CwiuJVGLBV+co82CimC8P0hS4K9J1Bqg
	Orj4R5bQDOE+4VoRS8mU+3xa4ME2WryPfCBdRBCh/bTWTOy7eRthuLqrJupagzjQ
	U+t8vBf2C4I9h64D7Hs14E3rtgrijhmgfB33XDxsTu5gLpYjyV2AkMY7OTliLZSs
	3lkeF6japxp1fwOdOqFpjgenu//dF07c5WT9dD9y3962Q0aDbAb98SJUwyA/a77j
	FdCWCAOsYZN5Y/loiu8QEKdVtRz4Wu4YefCdj1XjQYwnTmCwIj8Q8Ys02xPX4GiG
	1700y8JUNSO5W4aVyE+hQ==
X-ME-Sender: <xms:V-SVaVj7-Mjj-k5YHZszWX2t6QwDDHy4G8v5GHDdLpPXFTBS2WrolQY>
    <xme:V-SVaU3ogiSilHcFlm-wtf1Ou8nj-SMxdLFfQhqkAN0YCe1XG4io1v1iWP4LH-I8_
    H4oBK3QCEMOlvdoz9rZWIHZlxBRk10tnBD8ArGp5iIhc7H8ckMtqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V-SVaWlvWjto_bYlw10AGlLoz1RicXaN5yZmKVP5vv67RH-Cwn1cJg>
    <xmx:V-SVafXvBs6Htpar_TowyehkPLtHWWAWv7JPngx1e9ASRsT6rbV7_g>
    <xmx:V-SVaUsGfNUE2iYn9tS-vZ1QJ5cANiw4WS2ZAi9StjZzuCgMpTGTVw>
    <xmx:V-SVaaZpli7Dw8rxBO9MEDxp64JoGd96D5UyH8ZWI_2PF4lTZGwOUw>
    <xmx:V-SVaW_MyeCldC0Eh0zhId3PFgJZd_jtw2fz2gZm_k3sTdxl1u1Rb8Gy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0050D1EA006B; Wed, 18 Feb 2026 11:09:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIMZSWp5gDXJ
Date: Wed, 18 Feb 2026 17:09:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Koji Nakamaru" <koji.nakamaru@gree.net>
Message-Id: <11a91368-7dc8-4081-bd13-d208126beb7b@app.fastmail.com>
In-Reply-To: <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
References: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
 <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] osxkeychain: define build targets in the top-level Makefile.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 18, 2026, at 06:14, Koji Nakamaru via GitGitGadget wrote:
> From: Koji Nakamaru <koji.nakamaru@gree.net>
>
> The fix for git-credential-osxkeychain in 4580bcd235 (osxkeychain: avoid
> incorrectly skipping store operation) introduced linkage with libgit.a,

Nitpick: Commit references should have the date:

    4580bcd235 (osxkeychain: avoid incorrectly skipping store operation, 2025-11-14)

Like the rest of the commits you reference here.

> and its Makefile was adjusted accordingly. However, the build fails as
> of 864f55e190 because several macOS-specific refinements were applied to
> the top-level Makefile and config.mak.uname, such as:
>
>   - 363837afe7 (macOS: make Homebrew use configurable, 2025-12-24)
>   - cee341e9dd (macOS: use iconv from Homebrew if needed and present,
>     2025-12-24)
>   - d281241518 (utf8.c: enable workaround for iconv under macOS 14/15,
>     2026-01-12)
>[snip]
