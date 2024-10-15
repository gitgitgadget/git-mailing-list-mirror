Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317528691
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015554; cv=none; b=uH9LpGPWrlYgz9h5Y3JYO8H6GOSvxXM54p6Agp/6+EqN6ndQohQiyUQ5dltnu2JopxqcBK4II4l2n7jhE/KITGbY8o1fixeggAfLXB9YUTzcqis+HX4FQwilzuDrVTe6dIMzx4S4rxatRDxr/yu0G6i6FA5K2pT9j+BymbQKPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015554; c=relaxed/simple;
	bh=/K9aWB9mCYj4v0TRy4xYy+GFIhnYPROiI99GFpxU7XA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sK5qGVdXtFuzUCoQ/rYZnpLsooplzkVctFQlxmXlc2UU3C47Lp9hxRPqooDlkAszVSjG4xJCdJ0hqSuRmqNBszipRxiBydJ39W66M9FztwZYb80Teeld1wShDc4+04OKIKeTjmseeIoVwanKTmf8Fn0C0oi8fs0Fwa9peHQi804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jBJ7ou4O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nDjOAUBP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jBJ7ou4O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDjOAUBP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61C43114011B;
	Tue, 15 Oct 2024 14:05:49 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 15 Oct 2024 14:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729015549;
	 x=1729101949; bh=EuGXQIQU/wLGnf5sA9rtgZ5hBMoPOID/v3AnQFt8lLQ=; b=
	jBJ7ou4OcVO+4/u+0C9rm9IP2RzwMhNRnbV49uP9rWhvALpg3+vsjDOF2/6Hj8Tk
	vQ3FqdSaVGaDSQrXRueHGbTpcsN3+MYn7GETj1uODnXp5I9rJ1PZs2w4h7aiNGE6
	mwwMB8VYfW2eMnfrcA08Ur3umIFjHYearZz72L2bn+V6AetHrjPUoN0WgKpSgGGs
	8IduPrHA1/2aopMO0xSECMU36ttE+uVw7HXqUz3pv2ctWHxxroPNe5OOSB7lStyr
	nGUtLDbT6Dzm7eICg/ljKDgqeth/wJ8FKzeAr2NPlNCpqhEy/gCO/EjZNgpMj79i
	SUE2yGCjs8EBWv7B4/xd8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729015549; x=
	1729101949; bh=EuGXQIQU/wLGnf5sA9rtgZ5hBMoPOID/v3AnQFt8lLQ=; b=n
	DjOAUBPamkVP3fEXdcokcDjcza2VG9EwNPjve+aSNtJt0llKQzwCf3DhWXkTQRC7
	l6R9JgpzxiEhL9g78zvkWij9vyEvLI8n3uspedwdSG2UIAZ+CjWpZKhoALNgULYG
	1OVYFfxZBHo7TWkR1U3c/B3COvgBivMLE2xZGBE+lBM5LR0xVQti+cERA5Se8CTK
	OuMXCBQD3dAuK8M8UAtbzm6861EtIBXLaxVWGdlSh1GYSrBXFa2xfRuJVb1dOgfL
	GVrztDPqCy4+SbjceOLNKZsTiOcond+hlZzEXkp4OqWhLJvSoC3N6rOJaYOuhrM1
	EsghG6dHCfJPim/XcZRFA==
X-ME-Sender: <xms:_a4OZ3RjrRqfrgq5HqpmsRg4nmaqY2trJZXsAnt5q3wUI8x9RwkVTxg>
    <xme:_a4OZ4ysE7IbO-oSFyJPdzbzxsQvmaUMO9HB-mLR2658WkdgqiTSO2jBQDQl8Q10j
    p-t4ZIWAYFYpx6Bag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhveegveefhfelgeelveeluddv
    tefghfdvvdelgffhgedtvdeutdffveelfefggfenucffohhmrghinhepshhtrggtkhhovh
    gvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhoohhtsehhqheirdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:_a4OZ82X1u-8GfX6-41_eYlRxX_qc73r2sPTHJItBqUpj_2Fly-iqA>
    <xmx:_a4OZ3A8oOaL2xvtkAZLgiPgTNK0nz-toiNqfZ1u4QtH2jRItokiqQ>
    <xmx:_a4OZwggCjyew2Mea_NDEy5KQxJ_ANYonnNYVNyEalverdVk38JFpQ>
    <xmx:_a4OZ7pvXaHYyDK-GzJ1IGEzwkcAj26-VF6Z_tGnnQOQ_85oH6ukwg>
    <xmx:_a4OZ8ZluKd2KKS_SxDhQuR1Mj-QhTSWakR4S3fj3TugzsQBbTi_wCW->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06A40780068; Tue, 15 Oct 2024 14:05:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 20:04:58 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Henry Qin" <root@hq6.me>, git@vger.kernel.org
Message-Id: <22391e5d-c6fa-4b33-a12a-b63bbb979d81@app.fastmail.com>
In-Reply-To: 
 <CAO8bsPCWkqDFSqWwJ3gQt7O2g1okodb_Q-NbbkTq9bc7M=zU1A@mail.gmail.com>
References: 
 <CAO8bsPCWkqDFSqWwJ3gQt7O2g1okodb_Q-NbbkTq9bc7M=zU1A@mail.gmail.com>
Subject: Re: Feature Request: Document the log format string equivalent of built-in
 formats
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Backlink:

https://stackoverflow.com/questions/79089206/is-it-possible-to-fully-rep=
licate-the-default-behavior-of-git-log-with-a-format

I took a look at the code before today with search terms like

    CMIT_FMT_DEFAULT
    CMIT_FMT_MEDIUM,

And it looked to me that at least parts of it were implemented using
regular code branching.  I was thinking that maybe the built-in formats
were defined just using the formatting primitives.  But it didn=E2=80=99=
t look
like that to me.
