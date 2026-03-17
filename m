Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F403EAC8E
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761569; cv=none; b=rlSdGJhEvSJpyy14dgXKh0c18z/6gUYh00xrnjdi97/HWp+2Enjy5dDY2QVs+YRn/DL8u42lrjsdwiqqben5BzVYSycchs9rGkP3Jwn7XVXqrOFK2DV8IVDxL1jiA+SO39t9ol9nCK15+SbD6g4A6Ipiygh+4K2plX73IlZzNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761569; c=relaxed/simple;
	bh=9Wv0fHUaj5mF8ap1wv5DEqk1iHDN0/D88gt8eWA/GVU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pIxlm5qomLsF/aHbKeESDJiYD5jjTVzcX3H9fZJWplHBQZXv2nBAhzABrpdBuTFOnDaIexsHHpJuosMPKHiO1+heJUyjuwF4NQOI02ZNalS2/uiXipVlQhPuc0MeXcVODbtn8NpD4/cjcAhaCHS272uphB6LT7eSMVjV/Y5qywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=h2wKROiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3RCzSkro; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="h2wKROiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3RCzSkro"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B104EC003D;
	Tue, 17 Mar 2026 11:32:47 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 11:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773761567;
	 x=1773847967; bh=9Wv0fHUaj5mF8ap1wv5DEqk1iHDN0/D88gt8eWA/GVU=; b=
	h2wKROiv0AwHrn7HTZSY/seVUq4jxvZOpO969X6vdc39EL35E7kaRkRu9rMbuTq9
	mE/JrGtbIKRDSeR5WlqqSyjC0x3aT1f3M6xHbBjS785qs7Hmr58Lg0IeEGe3v334
	/lTmjhXnmIiq42OjJ0Ljfd73UrS8jAFqZczJxHTLwUDnxz+j+gV2QL6zx6NAVhjQ
	Eri84IXW3FWpfjD9IR2CKzHiJZrd/UkrSRmxlhNrPRGaj5hF6YYPwJhQ5dFSbpP0
	41AnaB0Oesw7Lu2uiVatsgLDqPcSju5VGvsRencRT6RzarBvjbi7aX/GiI3AEPH8
	uTIW7duoes6t11NFQ0A/Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773761567; x=1773847967; bh=9
	Wv0fHUaj5mF8ap1wv5DEqk1iHDN0/D88gt8eWA/GVU=; b=3RCzSkroJCWsVGFHL
	wGuSAaBDd9Mem5/m0Zbvf1iTouiAtwRa7QhkAQZRVo+WxsY6wYY6VD6Yz/N9zoe1
	fMxfulWMOeZAoI7FJAiCK/oawiDKoJEKFDxo1lgxYrO+rvcsVtStTqHitzOemVKc
	wVGADjyudn8Plklyq5iMzT6wNkvrmd3LxnirVjicDQVFXaS80lsp8pXP+dOnEy2j
	bsXYqKSSGWHmAcPsgKgXBNUEiN3gsBPqeetiV7PU5ItoQM99xWWAE0RYojkn4WXF
	l0X26sFO7n3A12AyXWYtaaG6fgeicg9mGexn+PiNGcZzXunZSXOiL0JRFoykt5iw
	M+S0g==
X-ME-Sender: <xms:HnS5aWBNSgMtKkTYtp0vNyUP-XV7PgAl3SLUXnL8l1qb80uLT-aWo_c>
    <xme:HnS5abUFNpia1f7MdF8CfBnaTp-zKtZ_tUahWugk14-PUhZ36hNXEORog59tg90Te
    wEhC-_P5liRrs_-fVh323JC9B18LM4TJUh4lJpYsdArgKrXS8f9Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrh
    hoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H3S5aYvMQnXg5UN7fNiti1vRx17zafPSyc9usFWoyA5epEDfGmdVMA>
    <xmx:H3S5aTZCNDOJ3d7gBlApiFOVM-d_n2yynMco6pwHvZ7HIr9XXiib4g>
    <xmx:H3S5abUyS4iaeyUaoE6pwXZ0kavIVZ_DMKfev8d4d3l9f2-NlGG5bQ>
    <xmx:H3S5aX4gB-oX4avOMZcJe_quPCY9b5x1tkfv_zZxdTwfOrXzEmKD6w>
    <xmx:H3S5aZytS3Kxjjkc814UuY3iK5KB8qUJUAOny8eAUk6-MUc8BrLPul0t>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E229A1EA006B; Tue, 17 Mar 2026 11:32:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARy7OMwtnI13
Date: Tue, 17 Mar 2026 16:32:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mirko Faina" <mroik@delayed.space>, git@vger.kernel.org
Message-Id: <f471643e-b434-47d6-9664-e834a92abe6c@app.fastmail.com>
In-Reply-To: 
 <7be0d6c49d09158739784cc70d17ddcbcd0a1fed.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
 <7be0d6c49d09158739784cc70d17ddcbcd0a1fed.1773530191.git.mroik@delayed.space>
Subject: Re: [PATCH 5/7] format-patch: wrap generate_commit_list_cover()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026, at 00:20, Mirko Faina wrote:
> While most conventions should not allow for the text lines in commit
> messages to get too long, when they do it could make emails harder to
> read.
>
> Teach generate_commit_list_cover() to wrap its commit lines if they
> happend to be too long.

s/happend/happen/

But =E2=80=9Chappen to be=E2=80=9D is a bit redundant. You can just say:=
 wrap if they
are too long.

>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
>[snip]
