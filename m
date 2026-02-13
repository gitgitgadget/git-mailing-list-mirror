Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9E3590B3
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981971; cv=none; b=Esuwu/jG1ANzShVMvCvATbG2uTGnem07kPlkb9qXr0/RUv95lN7ut8D68FIhhlv9saXYxCBcyJx9fc/OUyDIXXgltGBY643/15qHybDOyRK03v2mciY9bFwvp2pRsRAS1fixtyBmRabfYC10uQnDblJQJbddG0saO5Zpy2uCT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981971; c=relaxed/simple;
	bh=fKz+zgbdiClywjzIS8KZP7ZTOmad8qNZSI0x9Jyk3DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syw0aOkCUF6SXWOFNXlBbA2PLFS1r0lqluXNQzjd11sVAZKmCT3MKbz7L7HEWPS9nA9jc2By9lu690WW75VXuIQfxrW6pGZYIscGPwPCzno0yYZKzwZvwmcf/3+o25qOPZjvLq2iOVaZCfRd1joIuDxdfpzjVgGDWtTL+mf9XyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n0/5AN3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXD3VkYJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n0/5AN3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXD3VkYJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DB13EC05B0;
	Fri, 13 Feb 2026 06:26:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Feb 2026 06:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770981969; x=1771068369; bh=0jvNeqzEE5
	8aAP2dFVEfiK0OsmozibSe0JhdiBOVyhE=; b=n0/5AN3excfGgyCrTk+XIFShjZ
	Vuv6ITKFA+YOPMlf0wt/hEbia/ZuOev2ulhH9k16z/zs8D/3zoRNzndiwgd38XW0
	B/fOK67nzoLNA7YtugP5pWMXZH+KDYgOVYFx7SBIWm3OVCQiS4Qp2ohQ4kQsZNMi
	sZsDpFqtZgNrDjhcg/53k8Auqg5Ydpe8AgZeMYHkJrqB2WUiDsa2Bj3bAjwkct+q
	Zw3wERULS370sahaJTWbBGI0GHew6IJVVLN/k+KxNyituRgY70CvYFTUU4A+Na5T
	V3Q3riHqo9QMtIU14B8Y+DrkeQvA/qAlJCzQFfBeWXCegX9VXKAyBrru2Smg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770981969; x=1771068369; bh=0jvNeqzEE58aAP2dFVEfiK0OsmozibSe0Jh
	diBOVyhE=; b=lXD3VkYJdItHhD/EtXjOneze77UqtgUOCmND0XpEkQzf/wnCcsT
	nJHoLvsEDikLbn0T1cXQnUbFugDUOTJm+Q1mI245xlbae1xtDC2NvsXsc6BFHdmC
	kDkNPXW6ukGOYlccs9LL7GEGjLsfE0nTwMFOMzd6YZTU4C6tHpDOSLqbBsHbVG/F
	0S4PNzIyTq2kDvGNHxmTBusGgQlkqKOMFB77GgfL7ogHycOHMIotfqH4qP89YuX9
	Cqk+CB9FGPyOKBSOFtnrihrNQg64Z21U0pRdwfQRl5+RC0CzreNlZiwlFAJglIJs
	yqnezE2sXTGlXIzgpHb2DCT7c/3OHUlVRZw==
X-ME-Sender: <xms:UAqPabFQTS-FfN6gVUAMrQ16myFKpnOulwM-FmcLqZqXoKqt6Kb0-w>
    <xme:UAqPaXZc_wkMvCTLByP1rq0Uk4E-SJyz3x0WMgvGkNIWDsk5sDAY5FrdDme8II71c
    -s4wHhjArY1iSNopeQ2DBNb5fJrjMbgvCUD2yvKJnDAgiCAMQ3EWg>
X-ME-Received: <xmr:UAqPaTUgIdMIY1yehKeRRB3vj2RlW3sk7EuJDizpvmP3-mWGV3xHDAlXbaFOfcoVYGDpnKBajaJZoqnZPuEMh6dK7zi6b-C5KMIVIBjU1K_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdr
    tghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvihhlrgdrjhhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:UAqPaVlyz8NTn3jCw0T0gKu_AWjvx0vCYhVAOzLF1RUM6MD09tQ76w>
    <xmx:UAqPaWA0WoBHmSDrSkk03DxX0iUE0B8f0Ms-B13fNYzXW76EzkrcnA>
    <xmx:UAqPaciKrhoOebgIGO4ekvhrRRSMsUF8oYfdcjdIX6-EX9iscWBjDg>
    <xmx:UAqPabwXJBCyJAjqeCzgj758vKnnFA03TYbhxqf8-0WzqjhyOJ5Vyg>
    <xmx:UQqPadFW3G53WmdSjNBRCaBk-ygSFhsX1lUUg85SjtVPbCpS6DHHeFGy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 06:26:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0f5aa30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 11:26:06 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:26:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 9/9] fetch-pack: wire up and enable auto filter logic
Message-ID: <aY8KTOrCbm7noIVw@pks.im>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
 <20260212100843.883623-10-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212100843.883623-10-christian.couder@gmail.com>

On Thu, Feb 12, 2026 at 11:08:40AM +0100, Christian Couder wrote:
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 40316c9a34..9f8f980516 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1661,6 +1662,29 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
>  	int i;
>  	struct strvec index_pack_args = STRVEC_INIT;
> +	const char *promisor_remote_config;
> +
> +	if (server_feature_v2("promisor-remote", &promisor_remote_config))
> +		promisor_remote_reply(promisor_remote_config, NULL);

And here we now pass a `NULL` pointer so that we don't have to free the
result that we didn't want to have in the first place. Good.

Patrick
