Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29018E3F
	for <git@vger.kernel.org>; Thu,  1 May 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746103716; cv=none; b=MBIuxQkRujqa17xzi079veELnePXpuff6zgLZN4qdNE2ced4zA4ZHf3MIT2zpZWE4IuK+W7yieGw0h2ADtjWpTzrIbbHqfeImO0b/zkMeBk4FPNR/xwtYCmxKEvQ9wCSL8CesRI1h+5sJX1NMmJWi7ZAJT+m/ZZLX1QsFpe7RVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746103716; c=relaxed/simple;
	bh=LV9NQxeDbr2zlZ1zUCUxIv++tgbq61+elMyZkG6mymU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cl1EfN0Na9UiZfYYx8IH9j12UOmqy/sPcEDL0y455HNBRMOge91UBgxQeMwqE841Jkh6aQajlCCT8DgoLpVjqgJwh+0vfIFelKoZlYVFwxY7oWUvlnBdRLuFSwhfKQCxlZOq8kYaHmhZ8Mq2tTnvt2PFhfeYKr/kPv/BFyJGgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AhXCisHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJEPS6wY; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AhXCisHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJEPS6wY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DB07F11401E4;
	Thu,  1 May 2025 08:48:31 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Thu, 01 May 2025 08:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746103711;
	 x=1746190111; bh=LV9NQxeDbr2zlZ1zUCUxIv++tgbq61+elMyZkG6mymU=; b=
	AhXCisHNAzojb7q6MDeKjyKae6qDQL5IGLHl8QIRSUfGwSefpaE1aES2eAxhX+iz
	Uyr4zRnJpC2NDIiJUB8ZLGmX87PyjCKtG4cvAD+BfPx0TxXvmOcMjjsWFEqTEdQ4
	5iYY2JrHEntKabMlYZ20egGrWvNbTHnPtfccUviab3KX+I0iJ/mGfvSDFpCTvwnf
	bf5IIVUJj9/oUIJxvyJkhJLPemGJrcEalRivyKke9M1rHS+wmsLG2gEhFNKD032b
	qKLGFZz2iHlh3CX330h4inlgV9HyFZFeogd+rw5/lkeguYigNODuU9K+0eqXnyY9
	a3SGFpHNVsfX9tdErLjD3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746103711; x=
	1746190111; bh=LV9NQxeDbr2zlZ1zUCUxIv++tgbq61+elMyZkG6mymU=; b=m
	JEPS6wYe1o6K4c2JUi0vrbVeuLQ3YjZYxW1N8pV2XQjmxQQA27fvunXuUz8a2OsO
	mXDBubFX2hSPFMZiEAHD63UoyNIfDTO+l19IoZoc0rWm518fy4BGKoUzOt7n03hz
	16to4twyIWKPNmkcxaGKZ8sqDagMHrHzslUJcaI1E63b4OBtjCTPGfIq+WFvydky
	XV5ghr3xpOhg2e2BktpPt8pcHK6576iBJGfut6xfeFJt1c3l2/gfZhkx9oCnzJMX
	AXl7JNlDsl9gdQ4bzgmMCE6dfDE/f4HI9d1YJ73CS7hIokIuGLopB37/gMqS004E
	KVAGWb3pMyad7eSgh2HvQ==
X-ME-Sender: <xms:n20TaHdmJvavKFxGyOVeqB0W3phmzQHPKCNCQqWe6LSyjRMbRcNMq5Q>
    <xme:n20TaNOmEj7ro_h-VwKZnQDZZUyr3c10YIKR8nqB47rWISDnt3EKaD129Aqj5lU_b
    aP9kYJKpL279EYMxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgv
    rhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedv
    geejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheprhhhohgughgvshestghishgtohdrtghomhdprhgtphht
    thhopegrtghlohhpthgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhphhhoughgvg
    hssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehjrghsohhnuddutghhohgtrgesphhrohhtohhnrdhmvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n20TaAjytut5TJoKY_Q2rl8mN31UJQFwzo4OrePqUyHKs9ua4HT9_Q>
    <xmx:n20TaI-pmw5mBE0Q5LEnjRnVUSP305dEP12Ml1paaF4C8HqdekXcJQ>
    <xmx:n20TaDtwtaBg2HzA1Uds6pQmQkDE19mJ2jYhpV2I8iXuEYZBHvDW8A>
    <xmx:n20TaHFnYJGIkGcO_HDTSkWbDgKKzhDX1ZZQQQzECbBIge5dR3Xu-Q>
    <xmx:n20TaJAJHFolv-BnFTm5xH_y1u85lKtVciAtYkYkVCIsBxzEz_7ypuQE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6CA72780069; Thu,  1 May 2025 08:48:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4bb2f22e2cd75fd2
Date: Thu, 01 May 2025 14:48:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jason Cho" <jason11choca@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "aclopte@gmail.com" <aclopte@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "rhodges@cisco.com" <rhodges@cisco.com>,
 "rphodges@gmail.com" <rphodges@gmail.com>
Message-Id: <8a61dc13-0b7e-437d-b060-c17bff483c7a@app.fastmail.com>
In-Reply-To: 
 <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
References: 
 <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
Subject: Re: [PATCH v3] apply: --intent-to-add should imply --index
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, May 1, 2025, at 11:03, Jason Cho wrote:
> I'm following up on the bug reported by Ryan Hodges on October 26, 202=
1,
> regarding the `git apply --intent-to-add` command incorrectly marking =
all
> other tracked files as deleted from the index.
>
> Johannes Altmanninger submitted patch v3 titled "apply: --intent-to-add
> should imply --index" to fix this issue.
>
> Is this fix merged? If so, which Git version includes this fix.

I can=E2=80=99t find any commits by Johannes Altmanninger that addresses=
 this.
I also can=E2=80=99t find any commits that start with `apply: --intent-t=
o-add`.
