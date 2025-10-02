Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF71C4A10
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397230; cv=none; b=Hknk5SVC13DBB8+gPZkJKVGBWkxjDfiwhSftXYxUWOjBWjnRVPp+A80sUM4PT2sU2LMOab+lRB51ki7dYS9gvuQTubhy2eWwn/P7Y/SZY0zj5romK9hfREuXgCisfx2BYeyJk/D5+Ft+TNcbwlghWJ151SAB2O4MujQ/r2P5XB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397230; c=relaxed/simple;
	bh=uLm1er10EKe6JLOHsWacVx5Ycx8rnOgMMXrfm9Ub3Hg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BnAlvWVBxj/SixbPuuVPc7sfSClEvn+dqJwVgLKXixD7/lPZ2lZZljcqn79/8WqPiEBSLXOXej7ne9UpyLA5LDf+boqEGVLlm+uZsAI0zZ13wXqIzA9ftT7z/8tuuGrxihVTuxMJ4IkfYr0lUabGmSICHIPYGyRn9mODi1rGj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SuX8BLMt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/ivF19I; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SuX8BLMt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/ivF19I"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 39B671D00151;
	Thu,  2 Oct 2025 05:27:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 05:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759397224;
	 x=1759483624; bh=uLm1er10EKe6JLOHsWacVx5Ycx8rnOgMMXrfm9Ub3Hg=; b=
	SuX8BLMt6RKSSI/BQD7Kr3AH6lMFE1pnke468D9jPaYWEY+mskjSAA87WSV3UCq0
	BGXB1YfTHlv/CKvipGJ5XIVQG6XoCfZeEexqAKtH464BD1HiHbwHQAxJaKzKFsGf
	eo7JB4rG6ozP73OmBUTkt4TfXFZX7L+8clmUWk/BlJvnmo7mlXsRFndrSdERBwYg
	LLHs6XTH4gWrC9z5D6I5bF5zbEzvFo7Bth1xRkKhooXGEdKlt5m5IyTqA1ZsLUh+
	8Sv27JtdIygQ6svS+NYiVVstIZP5oMo5KJgVpBpD/lKdIhi+KBiGtLtqbfMa5XyB
	J12dWFiGVJfsUwGI5vd3LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759397224; x=
	1759483624; bh=uLm1er10EKe6JLOHsWacVx5Ycx8rnOgMMXrfm9Ub3Hg=; b=i
	/ivF19ItnW8g4t0N+pC46XHzBLwV8HhfUjbqzzhvCj23mXlK/VvsiyJ233TzM0zD
	jl+ggGJSj+vvx8AN4zAPKzi8j0loIPUEpCHAfpowehXH9Wu1wBsvd0QpziA5nena
	LpWWhkL/FHNcFA52tQuY1HEJIsQQ7yOAd0bWQtiplv7aW0/c3fj1M7h/525qXPVA
	9T1p8aFuVO3RYo2/AOjSB0q2lSkrjUjehnVEJTleEvACdljHP5j14H2QeylNjsUe
	KDerKxUPLAx7wCPbL2NiW7oHYztCMPPDjqzhT26IYQa4t8f+Vb4sQgpnAj9r5ZYk
	cPFW6kb8WLZe3XZ6XYHhw==
X-ME-Sender: <xms:Z0XeaK1-nbeoBeR78SELGwmgC5IoFpluSDM6x_TX3jnP0hWCu5OJGJQ>
    <xme:Z0XeaH4x6VZtl9rOjLDRP5p-2xkG7_9cUlpbrhblcpeDAVp3erb3KUeIDw-62ZpFj
    Y6HlO5TqVLu6_uTf9OC0msh0zkPG_bZ9wJvbl6FodjnolrJTXS->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z0XeaGJKAoR3jiwU9sdQIUjshJ_TElce6rSd33p7wMsX7he334KV_A>
    <xmx:Z0XeaILVDkcj-T0g2dlpP2qoB36cYO-cdi77eyiwEh4QXhpFjxRf3Q>
    <xmx:Z0XeaNVCOk1uwfw6LcdZKPJR4pIKg3OVjAWy5FuL_immce_JbLyUrw>
    <xmx:Z0XeaJnQ7WyJuvI2wBYKsxmWcwHW314n1Zd38lV6BVrcR5JwoJ2tGQ>
    <xmx:aEXeaJ2h49Pn_iakfUl_QdQg-6YtFAdtXN2fcCg0mhY-uVfKQj4EUFBC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BBF211EA0068; Thu,  2 Oct 2025 05:27:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfVL6sCB2Jhs
Date: Thu, 02 Oct 2025 11:26:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <2607e71a-b7a7-405f-8eb5-e8cc756b0270@app.fastmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
Subject: Re: [PATCH v4 05/12] builtin: add new "history" command
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 1, 2025, at 17:57, Patrick Steinhardt wrote:
>[snip]
>
> While these operations are all doable, it often feels needlessly cludgy

s/cludgy/kludgey/

> to do so by doing an interactive rebase, using the editor to say what
> one wants, and then perform the actions. Furthermore, some operations
> like splitting up a commit into two are way more involved than that and
> require a whole series of commands.
>
>[snip]
