Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AB1990A7
	for <git@vger.kernel.org>; Wed, 28 May 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419301; cv=none; b=BkzeDAja14l2pobTAP/MKhptOpg9EeGQPARcex0crHyKs/Qr5MjmFx1JpznSagTV/Po69Cfaiz6s/gQkANtNhCBaNuOXJBi6UdRK0RzgPCg6Sw7l+ChZYMuShhl8CVkeuG93l9SZZBB507hFzPfQu26xnUnPmtrz+QUwGQX9EUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419301; c=relaxed/simple;
	bh=4s1vUZuDmTDiSnpcrQKkitXXWG7nFPPNdX1h9LnFfrc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jVoMlBmFJ63M2qOICsskCSuUg8rgEVBTOs3urQKY8zz26a4BCYCL57UneGEDofZ0psQgx0ABhHzAHfGMSIsE1ovzoVjdCbF+wKmSlwdmgR73Y0H54TN0J/8u5HHiEnNd9qjWmvhvdD5TlicEHjD2WfKuxIj/OT3CqB0oxwGEYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gvOKkr5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3kkaLSQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gvOKkr5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3kkaLSQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E8B11380186;
	Wed, 28 May 2025 04:01:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 28 May 2025 04:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748419297;
	 x=1748505697; bh=4s1vUZuDmTDiSnpcrQKkitXXWG7nFPPNdX1h9LnFfrc=; b=
	gvOKkr5yQqiGHe4AjJMmiSO2mSaK4UkgqKJrFiSVTefQTvMHBSlRiwKcbyZPTENy
	e4LUmjJE6s8jY0+gCYo6cLNTc5ZOQwHoRgKTQfBtEVDgK5mkYc87AR4Kr1QjJ6ub
	VmSxG57DjFqNLdzhFp1dH2hQDhKS/epen4q0SsRJPwDW1jVyEeFT6MPGVfzCQcQ3
	VJCI5L93d/+5OHfz1HRuLdzU8kMCo5pUvthO5Da/wAkS9RDN9KkBGZ7nQve+aor2
	bhpo3kCLjHfSQjtqKciXAroe5KdQaoyQZWLH2hU+/nDG9AvWsv2IXTFWOzItv91N
	9gbEos/4Wb8WzFUXWgL2+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748419297; x=
	1748505697; bh=4s1vUZuDmTDiSnpcrQKkitXXWG7nFPPNdX1h9LnFfrc=; b=K
	3kkaLSQew4MqZbOG8NSvEy5fuzcS/5rY6dGfK0tmLhilu2GJnwv8rCtINzCA63YB
	R85vvoe+kt7UtNs+0dwUc0sMe1rVIal2gtos5hzr6mpbLMke0JtbrD+/RNrhLcRd
	ybLdPdEaNJ4zt3o4omCROdgEjQRlt014RgitWhf3V1L1Agt9UGC0O6RiwzioQH9X
	66vrce6FaEEjdpggSROavnMVRbJ8Pobc0jsV9TGXAfqyfukIKtf9t/WD8hzAmtzU
	FVWTTYIVm5cLrEkAWedaDzqYLa91fwSZRzzjweAPtwcjh5KB7L21UpXN+oN1bMFA
	pmkuBcv04j9YjTJTbcj2Q==
X-ME-Sender: <xms:4cI2aOWuu2-XKCqR0Mn1tmSFV9VOjoUc2UnFcLE11hwnzdvS_tUcY4A>
    <xme:4cI2aKlRHUtEwruwEO0pDK6eJmD_WGL_e8tyc5mOyHNh3mRPVwdS6moMOZ74GfFUf
    oIB5FuRHHNgpM92ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdejvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvge
    etkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhimhiffidtfedtieesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4cI2aCbzBSArokWlcfn5tTULSbtVPdfSkE1LpD5IlHYYLw1Y82A9Jw>
    <xmx:4cI2aFUX6Fq4OjaUTg72d2m9K6pL1feO4FyIboNl8M5fI2UpnhURRg>
    <xmx:4cI2aIkRaK7ZvSHNgfJIlKupLGGpgap_NPLKqQ9UsIlDhPr2HSVMwA>
    <xmx:4cI2aKcpQzsVVzTWzv_hCqDcPjuZJmvaoJiyd889WwseXYHIGscj3w>
    <xmx:4cI2aKQK18ZYO_3_LS5XJZSMsTL9My7bODTvdQSXyVzA1zChH2CnOQfW>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B6C61EA005F; Wed, 28 May 2025 04:01:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T05d811ea5ebcca3a
Date: Wed, 28 May 2025 10:01:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 oneee <kimww0306@gmail.com>
Message-Id: <4c1f645b-42fb-40b9-987e-08ce9e057e01@app.fastmail.com>
In-Reply-To: 
 <CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
 <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com>
 <CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 28, 2025, at 09:20, Eric Sunshine wrote:
>> Because then you can use commas freely inside each point.
>
> I'd like to push back on this suggestion, at least in the context of
> this particular patch, the purpose of which is to fix an actual
> problem in the documentation. The sort of improvement you suggest
> probably ought to be done as a separate patch, but let's not make it
> seem as if we are heaping extra work on the patch submitter; it's more
> important to get the fix itself landed.
>
> As such, the patch itself looks obviously correct and is a definite
> improvement as-is. It's not clear why it didn't get picked up; perhaps
> it just fell through the cracks.

Okay, totally reasonable and makes sense IMO.
