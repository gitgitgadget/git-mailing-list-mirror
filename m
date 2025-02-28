Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFB277008
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768452; cv=none; b=GFu8qNEeQ59rlwiUxFn9RuMn2XUAThk/1wiuAm/hW+c63tDlWSFHd+2bbW0BCyXqanS2wjk+C5XQSbMVnS+6KEMUKsMeHpQ8kX/j83P0oC4vvk7uLRigH2CuuCQXTl3igCk7+6dzvS9KepRK8hSslpUS47y29oRXNwOsRgwBMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768452; c=relaxed/simple;
	bh=RrPB6Bz5Is6HCkbhtKQoDqjTtspOH9VaiePZbtsBF0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EdREeBHA5nC34lkdgLZQ0zXTVJYUNJy3dlfRxaJfbfrIauvExUq7m7XeHOAmTLG1lBal9C7zkn3HJq0g8SLwmM3CP2itWghHObA56BKqzvpkWj6HuP+ZgYw3bocrua9jsLbgSfLLVkws3STHx/1/aFQ+gBJwtT1Oy7vKt3R7CnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D7ewTT6H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oQF9Hvqr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D7ewTT6H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQF9Hvqr"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 400742540148;
	Fri, 28 Feb 2025 13:47:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 28 Feb 2025 13:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740768449; x=1740854849; bh=hrcVQ0Kiu4
	NzSaSWSvArk5RVQGo6KewIkWCA0+moOA4=; b=D7ewTT6HhmhdCyLQ2wnn7MExMB
	3eX1WrkcFF3V82kKlpOWictVIddk12YoBwSwkSzjBuML4cbj6Bd5AWvu53CchtuM
	ndvnikX1jJKqzTvY/e8PYRGHmsGVKddy2T6BiIXKKYmnbaLZ+aIlnSc/9I8nGUcH
	jsrDkYRQG0e1G6z2RU9m4x+ILhhKZ5XdJ9N5qLHLjzlkgHETjdoOMYmAgy304mh7
	ezqZxfS6A37Dw4BLtqdCcrx+LzQAi54yrii274TkVc184UjPgaa3hKc91K4chcMI
	Vgf+CGMgcC0qGv+uJUmIG6IEmr+W473dAOrlgptmg9aiG7b+/p4FQuT/86mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740768449; x=1740854849; bh=hrcVQ0Kiu4NzSaSWSvArk5RVQGo6KewIkWC
	A0+moOA4=; b=oQF9HvqrkvbuDr+UQ/uLCa1SPlwg0q10/FoFU4QrfVhodhQO2Ja
	VPjapuLtiXRk/2d6bMVWVy+LLOFG2P6ivTXnk/Ue5TG80ytultsvDLxzB7PChMqw
	eUmp842fBy1LVAiVqQKumKbN6PigctPXPVsqZnBWKBesq2b7592TGMQdDIUOhpk5
	Usf0y+ks9xqx4mxemSltlmvgXc/s/R6JSEo/gfvQufaupdlsmIQ5bJXnYgBHohJV
	lfcVfGLpRo7R0V1JprRJO543rIEjhYouS2dulyWHLoCQBQ0HoTpCfHb+fQic0P5s
	V9qtTebhILevvFLR5g0ARxID5Zsb8E9hEPg==
X-ME-Sender: <xms:wATCZ7nD9IcuGyQUUUsJb6s2TeS7GkKo0Lveax7qQq5-mg7FfKN3hQ>
    <xme:wATCZ-2nke94_gIXWuxceA5Vh-bW_cqATa8iRJR5vAZJfbcin5uylh29keH8W_kat
    kn8xirKwDhvx2ixJA>
X-ME-Received: <xmr:wATCZxrGvynf5svExfHoyUcg5_jz_O8-PN_ib59g3FwUBUNs-VWrzkLkimrcDCslqndgBizacJ5WnfepmIp-FNat6tJIF7fgzhe2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    pefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevuc
    fjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgv
    rhhnpeffvdevhfdttedvueelhfevkeehhfdvteehheevvdevgeevkeeuheefgedukedvie
    enucffohhmrghinhepthhinhihuhhrlhdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhii
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:wATCZzkhfoNApThZDffhxQKp4Lr7e9qKicrSPpQTUE15NzAxCKHZIw>
    <xmx:wATCZ50fXZmpjw6OhOTbfN9DdL8VcFjGXETTurCloyvArLp14Rncvw>
    <xmx:wATCZysgsMITntw7K9kl3GXiFfdu-WYZ9tvdOL0SkUih9lw47Attjg>
    <xmx:wATCZ9XlJYaDFz0t5fV55LHOnjygN8N4BlLyDZu11hIgVOpztiMHrg>
    <xmx:wQTCZx8dMlzxLn21pvkzSFnIBexQyDGiiBTGL05goCaDP8T2hsLG6_Fn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:47:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/3] contrib/contacts: rename .txt to .adoc
In-Reply-To: <Z8HAv5I1hoNiQYoa@teonanacatl.net> (Todd Zullinger's message of
	"Fri, 28 Feb 2025 08:57:19 -0500")
References: <20250228034713.203461-1-tmz@pobox.com>
	<20250228034713.203461-3-tmz@pobox.com> <Z8FwIqnYYPk5bV7O@pks.im>
	<Z8HAv5I1hoNiQYoa@teonanacatl.net>
Date: Fri, 28 Feb 2025 10:47:27 -0800
Message-ID: <xmqq1pvh3o00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Since this is only in next and the first patch of the series
> targets a "breakage" in 2.49.0-rc0, should I split the
> latter commits into a separate series based on next or is
> ef18273a2d9 likely to be merged into master before 2.49.0?

ef18273a (Merge branch 'ps/meson-contrib-bits' into next,
2025-02-27) WILL NEVER be merged into master in any timeframe.
Doing so will pull all the other merge commits on 'next' into
'master'.

According to tinyurl.com/gitcal, we plan to tag -rc1 on Mar 4th and
-rc2 on Mar 10th.  The topic ps/meson-contrib-bits will have spent 7
calendar days in 'next' before we tag -rc2, so unless people find
issues with the topic while in 'next', it is expected to land before
the 10th.

Creating a merge of ps/meson-contrib-bits topic into the 'master'
(you do this yourself locally), and building your series on that
merge commit (and you send these patches to the list, saying that
they are based on such a merge in the cover letter) would be the
most appropriate in this case, I think.

Thanks.


