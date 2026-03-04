Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B2F513
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589980; cv=none; b=fcgYKfus04osr+vmInU+bDrBwZzYIskWdkF9PfZ4LUcrRYODFYoj0pqAoSMTjHPlH8dSDHckBL57Ow89/n3CiSsvBJu7WsTdr4pS5DnOgYCLAX900chjOcP0E9Oj0U9CtIi937DkION+MbjUZgx4f5+6uV9IuIZ1cbELgpkZZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589980; c=relaxed/simple;
	bh=pXKh5wITc9kdzCmUuy/+Q44RTpd1w5xdn3LaZakp3NQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oy7ifGxmLEUKYdiRsQMgmf1zGndE4bo6btAGyr7jFxzPEbxeNMjASUfeoH7NQp6QiB9dH/iYoCPRFPievqWu3l272QLpHEKFWbUnG266NATVjZpCkVgCyWuaae6No8Fs1+fsEvqALpC+HQ5yUONSI3oYSxJsXmHAM8RrFLX6Ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kAfKNqJ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UclsxBVp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kAfKNqJ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UclsxBVp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A97431400184;
	Tue,  3 Mar 2026 21:06:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Mar 2026 21:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772589978;
	 x=1772676378; bh=EAnsYf0YwIZhehDCc580xRCd3DCmZmQLIQ99wo2/XC0=; b=
	kAfKNqJ4uA1+7lT1T8EisGfOUCOysXk1o9ZONZ/z1HeL5sXmNPiM34IksxGHA50Y
	OZ+blURCEpksNLPQtWK8ZHlpjQT7WS5/6GlWHAB0bXjU5Dz5leIz9y4yROQtuRyC
	gzsFui9z8Ts1Bjd99sWMs5G3JQKjs7uIasUzMnmZfkAQmlyZB/VJFbTCQKm2qGpN
	+JgXA7KIPYBnQQBEtEDTy48GWs0jBZFbKPJQkIG8YZbDrHDLLhNZv72xYltFpVat
	0n1l9Q/alhWi+UNWU4Jw1uIGFo/3eWIljXfz+28JYD5lqqPH7HbE1e+h8V+mXCS9
	KzXgN8pHbYQ4k1KWdZB+iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772589978; x=
	1772676378; bh=EAnsYf0YwIZhehDCc580xRCd3DCmZmQLIQ99wo2/XC0=; b=U
	clsxBVphauJSHp/MmXa6Ro2cfEXdwXvG1VD4/OwsgaHp+tsYz4sxzCZtjbulG1h0
	YlM/yOfVQ+HBOH/E4Mnl6UigWQWWf0ttw5omc/YhtjBTxe+YYfFPuStKdgiJ82WJ
	b90puDjQXSaaPTwZbPFK953nMBEcRoNvBidnDzJ1PiI9aysZkQbGRRLOiy7pJgLg
	yF+nSCIvs9S4RMYl4lWXT5cTgiil4ZwXd63CBfH8HjKJD/WaAChUvPSh8FrMRftP
	9Z0g/BVngDZuvozbQyUijeLGQLUR2nsGmxdb/CBvdP6dN0700c2z9i9uOSUh1dTq
	clC1DuQ6HMcJDpJd975Xw==
X-ME-Sender: <xms:mpOnaSEVWjNN5v6vcQAJuGxwqYBX5oLTmy6VGyo-2rDYl37W6b12ew>
    <xme:mpOnaaVl8UeiCNVbVvPpowqOG7Qi-6aGIt6qSVHbJSEWNnH9d_Rd3-tyPuVS-AQFT
    G9THyAjNcsUGg-mNayjxdPBZ_pJlZRo5Tx83hW41VaShysIuJGdnjc>
X-ME-Received: <xmr:mpOnaRKTILv4aJ4fFwRvU-nBrlatikXjVTOTWEx3P6YKZ5pw0vS7NhI7sQ_wQevQRSDftO9NawT7AL9sr9CqDAuzOxrF58pXbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhvgifhhhughhhvghsleef
    geesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mpOnaa_YuPq9k-BTISb9NGjY77xUGj5qN73w3V3MwxKWQavVG4qupw>
    <xmx:mpOnaUKy9gMm7BcntXO-orFS0AMtp_x9FMy-dOYqj2aZdpBgspt8JQ>
    <xmx:mpOnafl_nzPuz6YkCNmaj2unHBLpS05LfF9gSGofk2Ft7WdF0fZfwA>
    <xmx:mpOnaYNGWrfVUHe3kEIci1I6cQ1khzjHtsyFa8RvqJMbXCM6Jqum4Q>
    <xmx:mpOnacqDwarCAwC_wLcKySVfQS2jw3c3tg5gTSVUC0pSGeNzT0saH5iB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 21:06:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Matthew Hughes" <matthewhughes934@gmail.com>,  git@vger.kernel.org
Subject: Re: Crash on git log with -L and -G on file rename
In-Reply-To: <54a45011-c0f5-4852-b344-b81c36ed8924@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 04 Mar 2026 00:49:53 +0100")
References: <aac-QdjY1ohAqgw_@desktop>
	<54a45011-c0f5-4852-b344-b81c36ed8924@app.fastmail.com>
Date: Tue, 03 Mar 2026 18:06:17 -0800
Message-ID: <xmqqseag9wme.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> I was able to reproduce this on `master`, `next`, and `seen`.
>
> • master: 50d063e3 (The 10th batch, 2026-03-03)
> • seen: 62670724 (Merge branch 'ng/submodule-default-remote' into seen,
>   2026-03-03)
> • 87284122 (Sync with 'master', 2026-03-03)

Not surprised, as I do not recall we made any changes to code paths
around either -L nor -G for quite some time.  I wouldn't be
surprised if this were broken exactly the same way since the
inception of the -L option, but bisecting might shed some lights on
the root cause, perhaps?

Thanks.

