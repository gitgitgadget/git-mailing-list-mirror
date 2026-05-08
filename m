Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747953FA5C8
	for <git@vger.kernel.org>; Fri,  8 May 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252513; cv=none; b=XR1XiZMx0ctPZqH94JcknVD/pX8p5egbFj+x9WxEKeUcoNTNePSb1EqOIR8FjCcdk0OfwjRWQcyWcv5o4slK8MJHVnxroVZ+dY2MC9VZWMFh4c1aWvQw/9DkcDe33O/A/kT4SioKESNXsOa+zjf/XS8+NJBrynTEhzHX7XI3olQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252513; c=relaxed/simple;
	bh=8lu8+h5MQS7kJd/CbI54IgwlVkKXXz9S+fHeBUq27fg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jkFCJxODhm+GXLiPkcp6QzZxPaHlHue3iKM+EzFdjr6vtoVjZTJbU+NRuFimBjzejOjurUS8/8R8lyv4E9r+/cMNE0pyhe5nlc5uE1ojX9kaNxQNpneSLVj7YTDdWAVNoyOPsJlF6yGJG2yEyXLXSb24aPhXRpleMHGyv+iRC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=C/Q3Efaw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6Wlcaj7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="C/Q3Efaw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6Wlcaj7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B08A8EC020E;
	Fri,  8 May 2026 11:01:50 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 11:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778252510;
	 x=1778338910; bh=8lu8+h5MQS7kJd/CbI54IgwlVkKXXz9S+fHeBUq27fg=; b=
	C/Q3EfawcR4B34BL2SxwcYlYDbHnIMDWz5w9vddIP1ocTDTQcMdj7BB4S1ieSqTQ
	mZUnmo6UqiI3tDNyt6rq+i1eFkKqnn/JaqSObsoLULgHTFP7QDqF2CA9FxYK9VfJ
	qd2ugxM82Kr+dendfmILgGtoEYyqLFevwGKs91zMTvbjBiUezcK4ON4godTVAsfI
	vjIrYGD0Y+FC//AGmruCZeh3+VELolE+QGDWNyaSae9+MmvHgWz+64YtN44Yh2d0
	+y8F107MEGNsGONT6UHp8rCzE4BOjAoFx3TpCmEcMH0sBWWXhpDV8W1l4utlWEI6
	sbpnTNIR0FJS9N6A2RmkFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778252510; x=
	1778338910; bh=8lu8+h5MQS7kJd/CbI54IgwlVkKXXz9S+fHeBUq27fg=; b=E
	6Wlcaj7WpWelCBhiqzuGQcx1q4gXQdWAl0uEXcc0/1917uS9h4UGr1MTl3MCE+AJ
	VTcXfRVMaqtrevY4i0Tp2UF9LPP/nq91blsvSwtCd4H4yjEDEycGx8pdiMRWEwT1
	Yzs6zSeI6kvsWluGfFFLtTaiBYMJ4nJHI7ODlTMOZWSSDRm/ksacVtkbQqSdJNz8
	48ZxSLacLuZlIjUA5DQKOkpnbZexDk3dGfhMvi8b2AWs6LRrtMEpBpJa1NESNjQc
	vdRRxQ+4oQJd/YSoeCOpYQApLnXrDpparhLeVcYvjmarvRKUlJ0mlFHjVtyVPtCd
	tS/jka5KOiox/456v1u0A==
X-ME-Sender: <xms:3vr9aQexFeoDYHtY2aaczVsbAEJ828-7IWpBGsXziE3qFUR5KfKT_CQ>
    <xme:3vr9adB9S0jkVpRm7TtZpC1DUd5op-q3cS38jbjQ059fapAuPTvCF9JA7eARRFr-d
    AFSKKzF56JnwYJTby3VWRZ3rs9pFdHPQBta6WGzAj8XYb1_fvbR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhushesuhgtlhgrrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3vr9abC52d9qZ_wfxFf1-9z1eRPOLZUY8oK6OKAW2DxcHq8VdA7sDw>
    <xmx:3vr9aTBaaUBg3aRj8wcy4ailqPDRnjQLcTM_1G_B-7H-Bi-LiyT03A>
    <xmx:3vr9aWpDOA0bq0vaxilCkzqqRHfeKVvK4aLK82ktzzxHRnIrsfqOnw>
    <xmx:3vr9adlJOkPI_6YrSrdVvsTozL4jEmViAk96e6kmuKcshUgZp96wCw>
    <xmx:3vr9aTmt4wddk3coJ85PYfrj6wJCTztG3Lw-hwlLteOcqPsSxgQLpeY0>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84E74C4006E; Fri,  8 May 2026 11:01:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Fri, 08 May 2026 17:01:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <55d5d53a-ec30-4b72-9ff4-c5a0631620ec@app.fastmail.com>
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 13, 2026, at 12:20, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]

Sorry to Ben here who I forgot to set on copy. :/

+Cc now.
