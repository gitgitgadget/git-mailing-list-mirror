Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BBFBF0
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415864; cv=none; b=hX0AcfzLa5P3l0nUhJpHt9xncsiFbyWW+fqY+WejCM0sILkG93tNLPH51M5dq0arZs7fCMJ7dP5E3j/7N6/l2V956SDnB6WBraGszU9mw2JXGTKaX9yc/zjwGUUCTf+eSSkS65zw7H34SxGDVfiPdXPV1Zyy3tqGJXcY7NSwQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415864; c=relaxed/simple;
	bh=/0jDcGYxnQSiDcovfEShDcUrqg1ZU59mgqFzwmgFln8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=We1vF7uTkyoaFEe3yaYs2MbhquCnglBGAyoTpVD12H39TIaGNUYoVWaM4PuMQR7zG/53Dc22XPUFVAVYbYvU+IeOVRRE7MDcHyRGkKcYNdxhOC8pEmWap6Wtz7NfSlac3nZ8Bfv5DyNGQ9M3AIgVs6W5wtueN6fekNWtmYedHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=Cft9WKME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZxCHTsP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="Cft9WKME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZxCHTsP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C96181140253;
	Tue,  3 Sep 2024 22:11:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Sep 2024 22:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725415860;
	 x=1725502260; bh=/0jDcGYxnQSiDcovfEShDcUrqg1ZU59mgqFzwmgFln8=; b=
	Cft9WKMEuRuR0utH6P42d4T3M4Sw9oaElSDIN/h7rdMcnT8WFNIALXPCYVhkFBRf
	icLBF0GWWkotRNaWW06YPs5O9Sz50pRHgH0KOhXHazFYF5F2cQv/807BLjBQFGuq
	0HE7MtetDXP74Oq0i+uXW3TDyQnsJGeekko2O7DL7ExfzcEhU6UfACf2+kXmoJs0
	+FTnqyCw9w9XFmTTaJao6pxVKXeAqWblmWklViVA4cyIWLjTU7PxbcyyDGO/u3vC
	bnwZ7vlrGeKAX9qaWSnEyZlWl2Gw1QoMkM+CZLO2HF1nmxVSHUzwjI8tg4JZQRe5
	s292dhrPYZiod0XleCurLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725415860; x=
	1725502260; bh=/0jDcGYxnQSiDcovfEShDcUrqg1ZU59mgqFzwmgFln8=; b=G
	ZxCHTsPRnTDA/Iq2B6d7qKZ57vYA1wYQFhxJptUGgoChmpdm4kbkhi452BJOxkKa
	RbiXNX3igVvmEYNUl4VWAJcn+7zn3pnzgVqL1SIKmmzjYLR9AyAmSuaRnc070h2m
	/riB/uNhCGZWjm//wHgmGOx24z1XOZ+mbvgaDSiKWO/Zqe0JtLdPd3uFrKLJQIsq
	YpEA5zveVB/mrvPV/C8wuqDp53oifq2duiVhrvIp9oVS3eJgsEoPON17arCs8LCU
	iCFMaihD5y8fjiGjnWV//iY+aa97oxW8Kka3+RRMxlGhLr5M9pZGpONpTm0jg7Rk
	3BN5gX+7W1V7Fomeoq8aA==
X-ME-Sender: <xms:tMHXZoypw3dQapks3Z6BkTY2QY2_e8yb8RABzW2nTpvIo2VGbHe5GA>
    <xme:tMHXZsQUqcVZ0Jqvr_RWXsLeV7gdlxIi1Z8tEj8pfzcZyPhGJ7z1mqxXslyb0Ro1-
    ux0cbR2zBJYSXxuLw>
X-ME-Received: <xmr:tMHXZqVHtiWpo6k3esSQslT4FgRnoUL_RPpsGOTMCi1VyQ-F9cKDTsiN9dMx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepfeefgfduveegfeduveevveekieffhfetffeukeff
    fffhgeelueekieffhedtveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    lhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tMHXZmgr-jl7g_6y5a1TdAUGtkX_-B_D-5zvYHzaz01bsGE2t-Tr9A>
    <xmx:tMHXZqCvp-Kbr_hCQxzrSd_MH7QGRbUfGZnRk79Y62-dleUn6wsroQ>
    <xmx:tMHXZnIjllGb1105BkN7xKd3LVCY9x3sWG-YJjXB9rW2GbqI9FyrCA>
    <xmx:tMHXZhAVe5zDR7Drwl0uTadPUbf9zMbTKonxQ5fDgvQwq2KDN8TZBg>
    <xmx:tMHXZh5AfpR2Src6og3_rENGvu7Z883XR3r9g30xiiVSIsvCQ3yNvznH>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 22:10:56 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Sep 2024 12:10:53 +1000
Message-Id: <D3X4VGA5L7JS.KX0H76M2YL2O@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "Calvin Wan" <calvinwan@google.com>, "Justin Tobler"
 <jltobler@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 20/21] environment: stop storing
 "core.warnAmbiguousRefs" globally
X-Mailer: aerc 0.18.0
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <fc6fcebf7f737617c635b338e3c0dce10e77881c.1725008898.git.ps@pks.im>
In-Reply-To: <fc6fcebf7f737617c635b338e3c0dce10e77881c.1725008898.git.ps@pks.im>

On Fri Aug 30, 2024 at 7:09 PM AEST, Patrick Steinhardt wrote:
> Same as the preceding commits, storing the "core.warnAmbiguousRefs"
> value globally is misdesigned as this setting may be set per repository.
>
> Move the logic into the repo-settings subsystem. The usual pattern here
> is that users are expected to call `prepare_repo_settings()` before they
> access the settings themselves. This seems somewhat fragile though, as
> it is easy to miss and leads to somewhat ugly code patterns at the call
> sites.
>
> Instead, introduce a new function that encapsulates this logic for us.
> This also allows us to change how exactly the lazy initialization works
> in the future, e.g. by only partially initializing values as requested
> by the caller.

Cool! `prepare_repo_settings()` is safe (and seems also reasonably cheap)
to execute multiple times.

