Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3631E522
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265546; cv=none; b=iT0WqGy3fNWGnbgDRhmc+5dHo/45EfjGkibYA6wYL09qZP7qTy6StqgNuCxYMSwMX0tbLh8WDAG8d2ikaR3wilIcYoOq+/MO7fWutfy03boUXhScnYEItNoowHnnits/vvaVDMsf8GL/XjLDmryK3s3EcyV3hztwmSY/o7FHHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265546; c=relaxed/simple;
	bh=ePMZ8AJAUD4G4NUenGTwJEZmHjv+r/R9kcE+kdGCvbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1O6n1H8LaTRnHy7/eiHsL92NsKbMbP3QE5KfK/VO+QztAXr8nnPTqvzqMcjqV18VbUMDrC0cWF3GbtVhDGjELKyrNtjefYJTCXOiq/dR8FG2HjW6TtndtFpeeFBmdSzInPiH7oKWt0nJ/JMF5dvQxxTxIyTMWCY1ycdihZBVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fd9NNwEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zrCapgfM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fd9NNwEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zrCapgfM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E27D138011A;
	Thu, 30 Jan 2025 14:32:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 30 Jan 2025 14:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738265543; x=1738351943; bh=Se51o6Nt5V
	gGgFfVvDBwfuR4dStPWEZE0fq4jmVaBI4=; b=fd9NNwEW1irEW8BKjZOVg/+jpQ
	fF78baU9KZRbpn3vL4cfeZ0FsUcYSbXh0bJroowFkJGnuKW1GXUW0mkU1MUxAucL
	KUl7ekbOH0lf8mAS0IAXbRnRZqMNXtq/X1Kg8mtoUolUs510I5zcoAy1sBwED36T
	Es4qu0oNWXM+HewfINY9cn3qS/mGEIqeBxcDkiHOvy0xvvo7w/66UpWQdIsXAyEz
	R8VQssHLkfOpOXS2pPTFyjUytiKZY+RuFqJPAb7fScIpVTwF5FKX94wIVOIhkrx6
	RRSW6zUVdkch5qG36x7eenIXWdoXqoCCaNO1WQRWkCJTkM+8Xn7tEy8OEiQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738265543; x=1738351943; bh=Se51o6Nt5VgGgFfVvDBwfuR4dStPWEZE0fq
	4jmVaBI4=; b=zrCapgfMdm1SC+I7c296bj8e0xoBPgZYcvaBHDs3uz+Afydzhcb
	wXsRzyZv4tfm2s1S4RPB1tfUMpLUwfCwkGvfHhK7BI+djSxkhGpDmFBE0KB/LoEb
	cpZc1q7T8rO6fzmgXPBS8o29O/XNH2NzmX5m2K5VylyPMPEhbSIYDtf96bCHRu+J
	OrpqScyY3MZrMxgiPaoYSYeCsoU13Cx8m4A1L20E6Q+tRgld9QJiUBedNtO8Fg6l
	nfNQJA7KBMUKPJAAYxw0tJEuPnECAOLJ7fTPCMZ0c4fslVH/PVnzX3WRYht4Sjf4
	M6M44sYjcjmUs5iuwufCFfCUL3ugYqLRAzA==
X-ME-Sender: <xms:x9ObZ6pd5l7ekp-_0zapKsBV4r6a5OejgsFlTnYYVHvnn2JAlP4M4w>
    <xme:x9ObZ4q56mwZ1OTwX5_ZHJT_V1lS5eMeSlfuDYpMs9Uq65soloa7KP9Qs_NzXM3gd
    AQkRHFXis41p4Gq9g>
X-ME-Received: <xmr:x9ObZ_NTO_Hq10VtC90Rljs57zDbpHTPsRIi0JMWNieD1l-umoOq9DVwwlXTnbmDKl2LdJipVT9T0esZra9RVJFHbfiaM5bxBB2f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmrhgrsh
    hssehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x9ObZ558lmYsuezEfzgIQXEPrBpqR_01jFYU63sRemIJcRHbuhU2OQ>
    <xmx:x9ObZ57H9APlitzOTR5-SyNtEEYK-PYj7uoV6_I63cEKenv8W2plcA>
    <xmx:x9ObZ5iOHyUVN70O04P3DhC8S91omX7aWVex0bLQjbGYfzlskXQ_7g>
    <xmx:x9ObZz7YSd9YLvW_EzrOhbVUGmvouUGVx3o7Sb3NZU5jafJS9VT1Fg>
    <xmx:x9ObZ-EA3A2wWEDKW3Y6BZ9bM3SLncZDdXesiXaiJ5Vogggj-ZFazdEs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:32:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  calvinwan@google.com,  nasamuffin@google.com,  emrass@google.com,
  sandals@crustytoothpaste.net,  ps@pks.im
Subject: Re: [PATCH v9 0/4] Introduce libgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <2217da71-d18a-446f-a7a1-6db4d358bbe5@gmail.com> (phillip's
	message of "Thu, 30 Jan 2025 10:49:43 +0000")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1738187176.git.steadmon@google.com>
	<2217da71-d18a-446f-a7a1-6db4d358bbe5@gmail.com>
Date: Thu, 30 Jan 2025 11:32:21 -0800
Message-ID: <xmqq7c6ccd2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

> Hi Josh
>
> The range-diff looks good. It's really nice to see this being added to git.
>
> Best Wishes
>
> Phillip

Thanks.  Let's plan to mark the topic for 'next' unless there are
other comments.
