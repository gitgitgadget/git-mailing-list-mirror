Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AF199EAF
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933728; cv=none; b=j/fb7tyRZ48NCDSqRX0OYx7hohblntdj1P+D0DEahf8nXbZmIXdax7our4ww3Tt/TnfBAHXmXhRi+Bs1N2GvTakuPvHdeDnwjP795EY2vC/EXRu4BUPxlNV3xWV1b/rw+avKQou3UsQG9+pHHCt4A+mqmSRGk5mbZ2HUQosdhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933728; c=relaxed/simple;
	bh=bzJJR/AtawbGDBv7tDvK0kGfY1A8W2XEP/THE+BLNmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdtb5FOjxk0FWhpQGltEoP7vf9QVqQxZuvvETsy5e4Ero9/VpXLPaXYnxFFEz38cDjgwQ5xn4F5WrByzeaSQUZC9zM+xjOtRqTMVbslequRaEdJHJ2XtyWGJvhMvouIf1cZTB03nJcPAb/DCnZqdipQwUkFAuonf/maDPtALq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ILjUaL7J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILjUaL7J"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ED7831380652;
	Mon, 18 Nov 2024 07:42:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 07:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731933724; x=1732020124; bh=kgPS5MSG1B+mqsQhQntsp+iYrV9+xViRfYI
	Dd7sGGig=; b=ILjUaL7JANjhfVKTx60f9jYoX85bzvxS/fBbpqLO86VvHBWTL0r
	74vyXHQ9CssmDjNvAuggRjMZnOHeLS4JL7LDQLyaFgdvAx96Zbe2OU3gpKvCHoIh
	nimvcjXeIOuEwh7zmwP7KfO71m+lHGibCL9YTB1F+b8NM3e8X27Bl5bhrSUfGUT9
	lMy8f1baEISaCHbPhhmfi9GTBQ2E3+0xY6VWPvCwoObSygCMFzcsw02EIpIo80Pm
	5Ikq2GUm4Thv3ZuTJWUzHTPCah+Azqoem7kBvNxriCo8eCWBhOzcv4J966Yw6/jU
	1/bzWHmEXfNTbThlvvhKygK7bNRRcOZ64+w==
X-ME-Sender: <xms:HDY7Z23cviSWTet__scDC6ykWenmbUOGov9A-qM0AfBJDffEYUEcVg>
    <xme:HDY7Z5HkvyGcjtSO7YpOK7jpvFpxxxVvYPlWSWzVA9ilA62MoDYOP3oFc04KNBLOS
    EVfjNNegwPwzRf8Og>
X-ME-Received: <xmr:HDY7Z-7vGjFZiqlb7TiV8KEwnwYNnjw3c1aqRLFZ5VaPF5quXIoE6df7g6IjN1aagFv0-fitzhXwZ0UA-017iPW1qBmbjjC0mFR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefgedtfedvheefjefhfeeiieeuteegtdevjeeh
    ffejffeiffetleegtdffveetleenucffohhmrghinhepfhgrtghinhhgrdhpshenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HDY7Z31oU_T-9xLID-eqLQ-qfmQhPPZHF-2Xlj7LNVQEtYteeGr29A>
    <xmx:HDY7Z5GP4-ywfUuuZwrf8IeriefR_kmYaPEJS_sMsr1zXD4HOqAO7w>
    <xmx:HDY7Zw8Dc-hk-wvVoYCrXyWxndHjsAraYlOWyVvlpGXdl847FeLI3Q>
    <xmx:HDY7Z-lYKZSxLF6vVVvBNMFBExkPA9K76N1zaAT5tSF_C90vZfzRTg>
    <xmx:HDY7Z5AbjQ2tBEFCxV4QTgOVo91TMqrhnBlu9FrrxNpA5EFISL7Xpwfu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 07:42:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
In-Reply-To: <Zzr4cgk_5MJNcHm1@pks.im> (Patrick Steinhardt's message of "Mon,
	18 Nov 2024 09:19:04 +0100")
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
	<4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
	<xmqq34js1kd2.fsf@gitster.g> <Zzr4cgk_5MJNcHm1@pks.im>
Date: Mon, 18 Nov 2024 21:42:03 +0900
Message-ID: <xmqqjzd0k92c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>     ds/line-log-asan-fix # 1 (2024-10-10) 
>>     jk/fsmonitor-event-listener-race-fix # 2 (2024-10-15) 
>>     ps/maintenance-start-crash-fix # 1 (2024-10-18) 
>
> Other candidates that fix regressions:
>
>     jk/fetch-prefetch-double-free-fix
>     tb/multi-pack-reuse-dupfix

Neither of these has hit 'master' yet.

>     pb/clar-build-fix

Not all that urgent (it is not end-user facing).

>     ps/upgrade-clar
>     wm/shortlog-hash

Unfortuately, these were both based not on 'maint' but on 'master',
and cannot ever be merged down to 'maint'.  The last topic may
deserve to be cherry-picked to 'maint' when the time comes.

Right now I have these lined up for 'maint'

    ds/line-log-asan-fix
    jk/fsmonitor-event-listener-race-fix
    ps/maintenance-start-crash-fix
    ps/cache-tree-w-broken-index-entry
    db/submodule-fetch-with-remote-name-fix

Thanks.
