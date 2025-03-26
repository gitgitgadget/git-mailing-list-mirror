Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDF1A83F5
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983849; cv=none; b=q2BANdTzw0fwS0yKAuEqyIFsdj2AInnMYEnYWRR0HpNUuxd9eqFYqopoJG/fY99JBk6VAeCHUJmZ0CWZLzbT7HBDFzsjN3RSi18lMKSuIRSImz+va644KGzVMQZQoHp4q3vPmJu36ydFkMP4UTtJleO5+t6Bj9zdze4AbJOYxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983849; c=relaxed/simple;
	bh=rTrO3iESQjmHyBoiRFc7st7fRInqgMarChrRi8lekPU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eFFYyEYapNErJL7YWyL8sWp02f2/3jh/VAmiKRS2k12dc+IqOAavfKvAoQ+xC4aXOHUJQTvwZ0+EdqTrTOET1tVaWitC3iQA5vLx0xYiSN4XmM/2pW6tAMbtK9oZJAk4GTvze3QFymRN0ZSXNMXBLgT66J8mO+5vy7LdodmZiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=exYAKcgO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIQG9AON; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="exYAKcgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIQG9AON"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21667254015C;
	Wed, 26 Mar 2025 06:10:46 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-09.internal (MEProxy); Wed, 26 Mar 2025 06:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742983845;
	 x=1743070245; bh=RyhWmUAxCsSlvkg8Sv+eWlblyPNbcXJJX2w08tsvECw=; b=
	exYAKcgOQWco76FiZgH1gw1deiN6wvIi95ndNHVxue8wO+rlhpmuwITFyaXOYC3W
	q+dmCjXsjwkjHsOl3bAs4n2OXBa9DWwp21Thyn1um8HBc5alJJrHgFTjIS1wE5og
	7n7RnnQt5psjnvSbPqaBxkOtew7k78nfgUcbNeFEs5aKwrcN5rWexoUjJA1Z7ylG
	nXCPNsiGTILYuZYPG6W6IlDfa8fzL2eQL2nswJ7m9wgclJaeNGUlLvHx+v6y/9SP
	aO0DLIYK9fHsGCtj3rwWg/hzQzW2YOOq6pCFtTllX4TeEtzAkWw0kUESubmQVdGP
	vpILFze5Ldf5k3mmWaF6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742983845; x=
	1743070245; bh=RyhWmUAxCsSlvkg8Sv+eWlblyPNbcXJJX2w08tsvECw=; b=U
	IQG9AONPqJZ5OxuKSKSu4natdxY8BKFln40Kdoi+02fZOopwME62BbxW05b8V72P
	j/9uv2B1Vug2baweOleZstLQXEaQGYUmUbWNk6SwBxJY97HNsjLIQA0ir27EUou1
	MIjcIkeLYP/IqD2+khX4BR7p+ke2uaPEgO91nRPZ51uOS9GyBMvNex4LNvd24gGL
	IhPgozcoQOYEKXQwjPeHzVqDK+WbLzi8Jqt0BRLCxseEebZolKKxN1iBJvELfoLA
	36Xd/oztNG+Sl+aXN2wKuJUV97L/7qTVAVTmWRla+yMFPr64MswvIix14DR/07sg
	fHT5ep575Qp02CeQnen1Q==
X-ME-Sender: <xms:pdLjZ-cM1Git6gquyc2khLBFUe5yxQNquKg6C_agMQ9lBg8Uf4o3zg>
    <xme:pdLjZ4Mky6TCO5eI5nTIITfbqvbPu_m499pXFlSxqbmA-2xAh6JIlNtzNKZxYqifg
    uagrap0cRPbU-rLdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhephfgvrhhnrghnughouceo
    ghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepuefgheffgefghf
    ffgfevffejleekledtieegheegfeevfeetgfffudekvdeuvddunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrd
    gvuhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrgifrghrihhmihguohhllhdoghhithesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pdLjZ_iVcOeWJbf1sSZwbG8dFc8_VWpK5M6OtTaKmZeI2qcUBM7k2g>
    <xmx:pdLjZ78WMEe91mveSd3wzrk8OTK5ElawJyrJ-kV3tGfMPjQ1t47vHg>
    <xmx:pdLjZ6sNQVqFqTG8opKOhNarfRpvY9Rt_ZDw3EcfdyLwlpcl4rvwfg>
    <xmx:pdLjZyEQhUS5WyQ0gk3vulQDc6bvt_IBU13-f9GL2FIEqvh6arvwmg>
    <xmx:pdLjZ-L4mDOYY_MDrBMCrMpU3VHl6qmFCyiZxVS0DCfouNYDiaEyjar4>
Feedback-ID: i96f14706:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 80DB03020080; Wed, 26 Mar 2025 06:10:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdb56743ddcdd4031
Date: Wed, 26 Mar 2025 11:10:24 +0100
From: Fernando <greenfoo@u92.eu>
To: git@vger.kernel.org
Cc: "D . Ben Knoble" <ben.knoble+github@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 kawarimidoll <kawarimidoll+git@gmail.com>
Message-Id: <7a4d6f02-50a5-4b1b-9d19-9598e66b6f34@app.fastmail.com>
In-Reply-To: <20250325222311.400748-1-greenfoo@u92.eu>
References: <20250325222311.400748-1-greenfoo@u92.eu>
Subject: Re: [PATCH 0/2] Fix mergetool.vimdiff.layout when "@" is used on REMOTE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> The problem is that it never really worked when used with "MERGED" (for all the
> others it worked fine).

Sorry, I meant "REMOTE" instead of "MERGED".

This is a typo in the cover letter.
The rest of the patch series is OK. 
