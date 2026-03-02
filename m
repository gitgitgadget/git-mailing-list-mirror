Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D91F16B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478387; cv=none; b=ZeWTit8IVmbIjeeJnGunE5jtkE4N2EoOiWsJ3iKonLPnMSN/esKNrXWPtbI7hpbdQVdAvshCvbmQXYpN1I3euqFzVTTfjf5CURDwBI7QtKSuewjZntPWOwJv2STpLSgM3Bd6m4kl6z2MNQVWfwqpPGhqUyLwIxQUTdMiN8ubVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478387; c=relaxed/simple;
	bh=HuE5ki4/W0EdNzf4n7vcUP/Jk1R/6WoV2REEVy+0ekA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HPJNYLV8CpgfiqwOb2MooLHCnYNEvT2uK299PhGn1xMOgJJUMRIpLIvSgp5jyoJatuAH+xiVJ7wi6l3EVvpXSEvLLc/nbrKsq+8CjJPcEkL0YnqL9dSUJSxSBf0Oq17/SdE6dpRw6q0Ex4NmJewHWcR1lpsEgcaJL+la77he7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HorP9jXQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4Gr+CzzK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HorP9jXQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4Gr+CzzK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 727B8EC055C;
	Mon,  2 Mar 2026 14:06:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 14:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772478385; x=1772564785; bh=3HXRjpi5er
	vyuKIIXM2oERUI8qXYsVikygTBWpQYpuI=; b=HorP9jXQf6XsTUtgiFgHOELuxL
	W2VocLxXMtFGTXhBdNZ9G89C3NTOQYK7+U7BSSjgXGSG+NuB09t/q3/sM0enQDSu
	Iw3H6WX/P1MOkbYVYhkYir4fmmLZ7QplnKfyWSYvutTz0C/0bApJw/qg5pvJqCCP
	uGNEEv9eVm5Hh2f1CUizFUipFA5dBaqIvEeZgivDke35s42pD159h+QUKW3K2lid
	S/KHt1+kZ4EdEIBVqKpiNS+jM1dHo/vW5IVD0cEBPk+Nqx326Tg42jVLHKK6fQRE
	1QWQyyJru11WCKMjZ8UM8/MSI2MfNwNstH3Bn8HeWjXo97Bt15MXsbmfLU5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772478385; x=1772564785; bh=3HXRjpi5ervyuKIIXM2oERUI8qXYsVikygT
	BWpQYpuI=; b=4Gr+CzzKdyH2i/TdMjB1PV1UsFAu2wtttGeGbyrrGVHSCePU+4Q
	eQUsllbvAh2QcusHRND93F7FRSvNf4xEzY6igE4wMu7uvG344JSHAJT1mSYM20gi
	fKMwGt6tpGb/N3nm0cAmEP03vK+5DYm2FHCcqhiAXiqoweO6JhVv7zGRr9RNRVPW
	fcLTdIZOUfGUU9AitMUbJ0oQtBeh81IvNECwb/VQ5PqBmajMydjI05aX9bLbK1uQ
	t7sNdbd6Um54cbRkRqHQmG5nmb0df5l/7exqCGevOptv9IX3/ZCuryEx3+uYnnr1
	KalIJfdJI01wSQ0k4CKnuAEa4DAHhOhZTOA==
X-ME-Sender: <xms:sN-laWTAFwWhb-PzBySeHj4toeoSXtYJlsqvWkN98747gqF_fTcZGw>
    <xme:sN-lae3Dm8aSrQnJ1drvrtzS3ObuiSeDpia07xmcVhjXMgeNZGTpPCfZPLaxMjE6J
    YKT_eabOX37qspsj89yz9xi79v-b7sbAd_P_ft-4d4JgQBzIBXL>
X-ME-Received: <xmr:sN-laecx8wJY5iXv0aXWLchLzikzw9ddrLpsseoBqiKGYkP5gI2VD2GRap0qteISYDyWkVUbi7kuPzUUZxrSZMz2X44zfB2Xqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegrfedv
    tdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehsih
    guughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:sN-laeNAWOxIHDOIZl_B0PbPROHPbC52STB4jllfbyNNzIhcu3po8g>
    <xmx:sN-laaX74yqU_5Q2ugVGUJLpgY-zd4W039c6qKMyEbFM1Uwf4fM1Ug>
    <xmx:sN-laexztutiU-e39XgMuW2XmbbD9XiC-HUbSeZEA_VZVPQ3v97SAg>
    <xmx:sN-laZ8l4FeDPXvjIUhiXyLMrHh299_c3puxxtwC3vx7NcCZ_iozkw>
    <xmx:sd-laSyipLVgi4j_gGN2_qAZ6ovgv14TAi7cV-H2iDgIU7MAkeZopb5T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 14:06:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Tian Yuchen <a3205153416@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <christian.couder@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][Draft Proposal v4] Refactoring in order to reduce Git's
 global state
In-Reply-To: <eecd6531-a7b5-4f0e-8e4d-3807f47d1f9d@gmail.com> (Phillip Wood's
	message of "Sun, 1 Mar 2026 16:43:03 +0000")
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
	<b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
	<5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
	<0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
	<eecd6531-a7b5-4f0e-8e4d-3807f47d1f9d@gmail.com>
Date: Mon, 02 Mar 2026 11:06:22 -0800
Message-ID: <xmqqy0kayrtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> i18n.commitEncoding is another such setting as it is currently eagerly 
> parsed so I'm surprised to see it being converted to lazy parsing in 
> https://lore.kernel.org/20260228190201.3684705-1-a3205153416@gmail.com
>
> I'm afraid that the suggestion on the project webpage is not very 
> helpful. Most config variables are unsuited to a conversion based on 
> repository_settings,...

Thanks for a dose of sanity here.  Very much appreciated.

