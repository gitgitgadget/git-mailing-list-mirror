Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0813AD03
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656743; cv=none; b=jKLjVNhJF1lPGEmxKz69s1ERDQN/WL33wOfAVlxd86/PO28lnL8thiQplKpWKkTD3ljLT2Nlw7hSZAVpVgviPpqWaJhIfdoYFasj7mO/fWyTX1kX588xmXNYhN9O+mVFTNIq51iX7AGbks3yvmFyVEVCWFRyX3i0loyrHwB0owM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656743; c=relaxed/simple;
	bh=FyzHlWWNLj6SZoWsW0r8YBXCbYRlgQNgnjk+kx1n2BA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZyZEZysNmKDZEdAAzFDs1NFon/zUOnwUh/VKQQtgIYVDEgjgcAgcD04MuPQpsJWgn7VJ1LcNEFdImpmtJcrm1zXbKpEDogbG+a+b94uZb1LRFJQtt+3dl9np5YoXmFHoLZLLkFjynu7voRviqDbQXBWND6/HGnCFtftCrRsv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PzIg+4YW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axqNrs4l; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PzIg+4YW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axqNrs4l"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 78BA111401F5;
	Thu, 23 Jan 2025 13:25:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 23 Jan 2025 13:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737656740; x=1737743140; bh=FyzHlWWNLj
	6SZoWsW0r8YBXCbYRlgQNgnjk+kx1n2BA=; b=PzIg+4YWgOEYctfrZTUVRFcAij
	HP3kDF0U9XONa8k2ZZomghPtxTGJaBpFbui+Issfofo+dZXueNjVJVOXkyJv+3r/
	3ewFdYHD7yLMwnPyz0+ObzZnTrWjN9v/MIj1+fNFA/8iFphjs0taaD6J3Irrvb9x
	9n4uAxLBb+uFpW5Zrnosh77DLl91wb648jafRc0CuDRHi6NRv2Ghq/9UxlQhmAR/
	akuczPNYCCMn8pryEJI/We0VyX/ESBuW4XxsNxvUyCJEDsECoBJDQSw8X4Ml2uxZ
	yMpdXwHgcew4g+RQRqnHifWjvPyoegoiOj5b01G6yyckTawza19BvHojQ1OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737656740; x=1737743140; bh=FyzHlWWNLj6SZoWsW0r8YBXCbYRlgQNgnjk
	+kx1n2BA=; b=axqNrs4lSSNJDePAhBGfTikXlfWJ0OZ6LJ0jag9nTcUMiPtVCDQ
	Zx00W53ZQpARlS3p9KiJUMpc/UTw+zZBwx6V3orIRzhmuEc9s2/uvJ1VVNGeNhXD
	cIwlev2WJ2V/cOz51E4J5Omua2SRL62mb3NnoqiBJ5j3kvb/YA7BhJkPYdVIzW2z
	6ifY5fID/XHwHa1uMzig5MP67AiiSjAmMFDtCkd3w3GYIYhoS0q/TcPPXFDciL/k
	CSWKiIhDkdOA5yhrIh2tSIc41Im8aUs+lSmvZHcN23ptS08x6YokCjHRF7f9UVxe
	bHtRV+htqd1PjOEyWzKJOpjMCBJnXHuw/ZA==
X-ME-Sender: <xms:pImSZ6xSrDiJ07kU_ACGi28G9a4KmXK0cEXKp8CiQcHsgManMChfZw>
    <xme:pImSZ2TXK5pD8k1GFcb41sEs1OqwYZvNi5sxh_sarNOa2rOaKfIEKHA6iIn1Vt64D
    acU3X9tnM8s5-JlCQ>
X-ME-Received: <xmr:pImSZ8XlvkdUa5LoEYy2T5DSpxDuRXUCWpq2QdU1ZdzcJzZA8t5mDdpixI2mak1bWL7tSa-G4wv45YuuyJMYYgrwIlXqnPb4BmrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pImSZwg_Nvv7xRGmHEj95TWIl3N5jwQsAfqDUYdPHo9xgcVMjRIfnQ>
    <xmx:pImSZ8DKXfqiryTI9GtYR5sKckKhvBIX0HoK0737BZJKJrAQEXdsog>
    <xmx:pImSZxJw_se7rmCtnzbJo9S8eoawJqV1acKq8qZqdBwdAifGeo7Dxg>
    <xmx:pImSZzB1Ox_Ec5dKrf98daO896YUGR_rfZ2PMCDK0M9eyNlIDChDHw>
    <xmx:pImSZ_95VAm-ny-IEK59IJWVFa5atfFytNm-3BpNmKYN4HzpbIjXNW3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:25:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <Z5KAUo4FeG2M1mIa@pks.im> (Patrick Steinhardt's message of "Thu,
	23 Jan 2025 18:45:54 +0100")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
	<CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
	<xmqqldv1tpgp.fsf@gitster.g> <Z5KAUo4FeG2M1mIa@pks.im>
Date: Thu, 23 Jan 2025 10:25:38 -0800
Message-ID: <xmqq1pwts7z1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Karthik has meanwhile sent a v2 [1] of the broken patch in (1) that
> fixes the issue discovered in (2). Given that (1) has already been in
> next, (2) probably needs to be rerolled to be a patch on top of what we
> already have in next.
>
> Other than that yes, I think (4) and (5) can be merged independently of
> (1) to (3).

Thanks for sanity checking me.
