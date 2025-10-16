Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35448205E3B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628333; cv=none; b=pSQrW0ZP24zgpqK7EHrjB1m6r8ttlPGcNoG8t19j1ulQfirYdnq/5Z7lFOOPEh8zKsIlUpb96I5YQVqvuhnEEDa29rkn+qD2tfm2byjwEM6IxYFMAn7jIfOCN5X1fdhynSRhiy2xgoUB+hTMVlRqf+ZObGe2WCI9PyRHwW1/9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628333; c=relaxed/simple;
	bh=WjIfPbwDG+Ol5JHYtXs1iLurYqNjM1cHvgHLzlEzBdo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KffNhJS97Y5WNWXKMQOjl1uiOQKCKDOmhPV0FKirS1yCcAlsjnQm+FP3z0eAR9ccKV49eSPe+orIxhiqWCLBKPNmIn2Nv3L1hxZpanIFaRh/JNA+Wzteb11oCElE9XBbIXRGFpYAO1TBt4ix9SZ609XuZMQAwVm1hLVT5sdbLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=s7i/mCGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=grsXZ0lS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="s7i/mCGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="grsXZ0lS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5363DEC0251;
	Thu, 16 Oct 2025 11:25:30 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 11:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760628330;
	 x=1760714730; bh=WjIfPbwDG+Ol5JHYtXs1iLurYqNjM1cHvgHLzlEzBdo=; b=
	s7i/mCGaYC31nDpwoCuUL9HvSAvqlotfMF+eFCxUDEuAaQbpH0dpEGulHcqb8Bw+
	dU3WQVaD1FN6RSwJ0GXxPXgJSLA9EQpjs3bAoD+15KbVnJYInG0xlduM27OtsPmB
	cfpy93HbxpiC4fNrDzweSnl6VyC9bjIl/X8Rhs0gXl2lQWcRm7XwaO2hZXgh0ZyD
	pu3gOv87625GAd0PXEWmLVgbKlKcuq8vDHd/FzfPTzABdojn8HHUtjkby95EENZD
	mV9vr1ZZQbN6zTLkmkvqgBX8Vb1gdtj+qzmwa3x9/nuL/5mCNxNtFNCR3KM4iKAv
	Z5zRrhToV5DSGEwdUhOf0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760628330; x=
	1760714730; bh=WjIfPbwDG+Ol5JHYtXs1iLurYqNjM1cHvgHLzlEzBdo=; b=g
	rsXZ0lSLvXasMm5gDGwLFnAEZBzi8LsB+PzlfCRAkEv6/EXihQFgqj5s1k8vf+kJ
	2E2JzKpmjesTGdXrBVqAs2r09DAazqEQdCIItNvid/3o1CzkXdAGcOK+7UeCP7rF
	yqaCaYbY08J90+lVt6SziAmkZ9Ssf9F/F0HXppirHimO2knCOSfXaR31tslEs/UJ
	yXzrlig8t7WErpllNw4McCXhDd+DgStYXjkbzw9p6WLOPWt/Vx6LqFVU0IzmoGBs
	lSL9+71Uh4A28wjdwwUMjkaOOy4YQnxIcvhCtb7fX/aEUMmpCHZLlIUJEZOssxOa
	+QOMW00sJDc1gjfeP3SbA==
X-ME-Sender: <xms:ag7xaItQFg3jzb1ioBYMeDvsP9_Kfihp4C6qMX1w5_SLexa1cL-XOjo>
    <xme:ag7xaAQBkESZffMT9B2YWKDylIIl1858Xc6YY2KHHqD5E6pqyZdy_EqpiISvdhrQL
    7pnnUdw_yErfHro0GpvqgLc7MsfX1jzWM5JNWKC9M-tq0iLlrhSNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiieehucetufdoteggodetrf
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
    gtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ag7xaNSwG5eCKvCjC9gh1ZsnE77PZkxBTMSignzhH6Q2oBa4KZoLDQ>
    <xmx:ag7xaITsuZjtzg2HRGHHQbL5eIVID6LV1wC1nDoioLtZD5PgAfqwEA>
    <xmx:ag7xaC4JbsjTScJfAPcqXBLN9E4uVOnhUMzCgmQXcQj-Ug3cAC0SRg>
    <xmx:ag7xaE2WfZFyZMhmXM0s0s6SwtH88MAUi8xQzRz3KTs3nTl8mQ5hTw>
    <xmx:ag7xaFnjXzKUiuMKR3eC7jv546cw30f9XOIh73UfGZmGyEIHmqglFxij>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE37A1EA0062; Thu, 16 Oct 2025 11:25:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Asrm_GTbWIKg
Date: Thu, 16 Oct 2025 17:24:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Julia Evans" <julia@jvns.ca>
Message-Id: <0ec8192d-558c-4caa-9d18-0e0c1e1203ca@app.fastmail.com>
In-Reply-To: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [PATCH v3] doc: add a explanation of Git's data model

s/a explanation/an explanation/

On Tue, Oct 14, 2025, at 23:12, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> Git very often uses the terms "object", "reference", or "index" in its
> documentation.
>[snip]
