Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D92222CF
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595219; cv=none; b=kpAFtEkj2ANLVCRphx0XPNagWlONUPNZ/s3NuWJGDP8P9tKn+n/6VcynQLWGUngJ0ab8ELoS6l73pVG6pSla9QSyO36kcFj2Yo9lhPEziDXRAPIoQSpdTwPuyivY+u6nMFV7oJ2qAVz4gUJYLDx7pKlzL2eDu2b55WTT6/LGA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595219; c=relaxed/simple;
	bh=S7doHM6Q5pcpCwSDu9Tyax4YdMf3rk84n4D4+hfdBAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WzcEL8EK+67iv3EtD7mbpPneHN9tGLfpV/PeFRrITXapn4MCERMkJ/NWNB3lDnEiYX0OqiX1KhARM30vrs6UodIPQYZ5MQ8qQY0N2ppvtfjQMQFq5eotyZqRFFYujseKuTclKNM9Tq/xn5DfZoTOUicjpS6E1ptwxGlXlZY1eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bMWgrV7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNpBPYxp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bMWgrV7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNpBPYxp"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BDBF813814D3;
	Wed, 26 Feb 2025 13:40:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 13:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740595214; x=1740681614; bh=S7doHM6Q5p
	cpCwSDu9Tyax4YdMf3rk84n4D4+hfdBAM=; b=bMWgrV7RXqiVaJ7lXgSl5oZb5W
	mN+lAL6CImZJWsvgbL3vT/DKHNLyk4lr7DpkInMttO2OHz5aetlygWwrrApQAv9u
	V34Mx5C9juwkSvkN1o3nkq9zRXHKzK/QgUF+isSSk4/HkXHslLc/y6/udU4XAZJf
	pjeaAh4oN3HOdZJqSR1BcKfGOO7nN1JwOaryhO7zl2Vbo5lkIPB8PZN5oIFz8Yt+
	GrIezJJZPq28lhRueBNPIfjEimDm8r4vZ3Cg+Nhhfd5wgRbw6JAwy0rHMk+L9UWk
	DG8SAkj5W22Ip2qDJN67sSthroYV8HoNNhUaPRMB6nT0yTphZ1Q/ZkihDBQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740595214; x=1740681614; bh=S7doHM6Q5pcpCwSDu9Tyax4YdMf3rk84n4D
	4+hfdBAM=; b=lNpBPYxpkQudsqPervnFb+y53ZvxdtnQFh+GCfrmN4wl/VwoGeo
	RdXOft7ZpCk7BEGUnSQOWwUguw/FVkSHMWO4ShIKFB+qGBEu6YrpEZvJTdyMAqJv
	Kn/ovNoWk+LKQCaknRHrQ5BXUYf23SZo/ku+JJcDaA4GDuzd3k38xKpaSaNwY5B5
	I7CmR7mbiywPHWSMztyp3lHU9snbUVms4F7RE70mRvc151PTtxC3eHIfJSMKySue
	B1iq+UzpJIFwN2nuhUSoejW9bMHhby6Rt0hn12ey6/jAplu23xYqCxAb6hgWhfiX
	Y8MbSZrN5houOcaJTJifxvZi0xgG3Hd0efg==
X-ME-Sender: <xms:DWC_Z3Ixh6NHqsKpi6036lGjjlDIhAnHiBOTSDKPNe45wxpuiV4XqQ>
    <xme:DWC_Z7KVCtDF2NCw0ZfSuP3hUF_S1uTbtW0lxaHTdB5NcwWm9jP3W4sHEVPTqizlJ
    eTubvdQLUCBOLPmPw>
X-ME-Received: <xmr:DWC_Z_sAeGo5ZIPcO1iplMEAnfboZwbS19TDDFII8Mh3F7SnDyzJPZWGgcwoSAxDPUQoiWNLEKY1_hl_2KMtIBMQ6lWd9txRA2pp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epvddtvdehsehugihprdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DWC_ZwZZQfw2G1v7PRsnb5VDpJWWVuOeinj6Jn_SWieyMJH9-rs9Ag>
    <xmx:DWC_Z-YPmp-aDBSe30DtbUyC7PnRPQtYJn4a3j11knzy2y5Oosnt2w>
    <xmx:DWC_Z0AF0PuTutuq3IiIn3DnypggOEigywD7tNHyzFzCdD7Pfd7PDQ>
    <xmx:DWC_Z8ZN5-VW6Xrw0RlT8LYGphhCL2pW_5XoBOgpk5siWvnQgFOGGw>
    <xmx:DmC_ZzPXy2Zo2GKH1Jrma_3rRuckih39yy3oZiDk64VVu_yC8doU579p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 13:40:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Markus Gerstel
 <2025@uxp.de>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
In-Reply-To: <543e1914-d05c-4053-916d-e8286edecf50@ramsayjones.plus.com>
	(Ramsay Jones's message of "Wed, 26 Feb 2025 17:50:04 +0000")
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
	<543e1914-d05c-4053-916d-e8286edecf50@ramsayjones.plus.com>
Date: Wed, 26 Feb 2025 10:40:12 -0800
Message-ID: <xmqqtt8gbldf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hmm, I don't know what you have in mind, but just as a data-point, I have
> never used, and have no inclination to use, git-maintenance. However, I do
> use git-gc extensively: at least once (times the number of repos fetched
> which have changes) per day, pretty much every day! :)

That makes two of us, but everybody knows that we are old fashioned ;-)
