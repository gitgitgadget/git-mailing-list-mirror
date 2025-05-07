Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7148221DB4
	for <git@vger.kernel.org>; Wed,  7 May 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606352; cv=none; b=ZzYEhE6HgeMVWaxjvKfnmclGEOabLwhBqQZCaLRN6QJR+B7s+OrDb3hNlc7rfnvQTV6Ptqz/SunrokdemWlOeBqAWYsMmMKV2ZXg+Xkph2Jo7sTS0wNhjBc5/qaXC8akzaF6bCvwcJOxBRIXc5TodSW88KhKAoHipPfTx24rXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606352; c=relaxed/simple;
	bh=IafVNesCpDHvAb6kItmedFMAm8RT0NFtbVLhJWng9C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgyW++viPOvBbTzWhenJZeht3iSJzX1wdjxrdS2Ko1faOWt90rRQItXrBwUUGXwwil6+yxU8lPWehJ18IA10Ta1ZTsSgdSpdA2nfJB3lFhRv6GwaLHyiZqojMy4afDYpeu5iYNVO24iFkAbyloSGegePqJOAPHsIzQ/SpJgE+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=16MTIosX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WU3zrcq3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="16MTIosX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WU3zrcq3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 986181140159;
	Wed,  7 May 2025 04:25:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 04:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746606349; x=1746692749; bh=7Xu4UaXLD6
	meHGUeArW1j207LUwb+xhegx8FXnYbLI4=; b=16MTIosXY1QKKmTEWICOTjjbwy
	OQyFE0Se/tF3dyiRknbKuKM+WHmfLI8jfSJupY+/HUtwX26qVYpyAYW4MRVnvbAu
	T4BW/szUT9yNRwN6SsPbgBozgS5J3y5M/PN+4dZZH82gIeEB+O8VN8kdJMQSXa6G
	ca3b77QMgJ6R1ztuyJPC/NkjLjKE+BFPZmfyw2zHlCa/dB1OmBSJ9dxaQrjG2HAM
	UrLlkB69oF+q5aj9k1U7yVXbU422gm3v+lvvLoOmdvW0KdMgMS5eUPqr8hltP4vu
	Lb/XPG3YlOGfLOjftuKMMeFbRUaaDDZzeW17hFxLI4KJGXfwH3+LXNfqYFeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746606349; x=1746692749; bh=7Xu4UaXLD6meHGUeArW1j207LUwb+xhegx8
	FXnYbLI4=; b=WU3zrcq3nub6dMyWAgXxtYLrK9aijFWmP0TNkRIc0vHp0L3c5vo
	h+NSCPGPmFaJAwy+UhFnsNW4pyReByLc2XrCaQ77rTBVBud6cJNiFmMj74FsANzD
	5Dk+WWvexK2cgHgd4MD8v8az26YpYBvhiznZZyCeF2PHOBGjZUNYcKKk9uzNkhFm
	+rS4VlDoPM21shLhJxC9WTox6cfD3VyW9LRxvHFTxjTc5xwB3BaFKL8GvYrxqyzS
	+0Dbb4QUBa85+TVuYDnBDLo8lMvHzkjSi1o+mf35PVblR3EHY3He9ZH6YGHu4ukD
	73iJbbhoeQaNsH0BnPi1bcF4NJyMKZ+SwGg==
X-ME-Sender: <xms:DRkbaPpx4eBerxj6jNezCPgkxHFWWUo3HwJWkche72mfDTHpA9t00w>
    <xme:DRkbaJo_0nJlFe5T1LmVhYSzOdVhYpj46s8uW-m1N9aRRoHtLwWWUEvrm10ojeCsG
    MTFPOARnRTgc7qs-g>
X-ME-Received: <xmr:DRkbaMPIAe7zt-25zWBK19AC4T3sS1Ksg2o2nsrrbqzFUXsaXAdcWQAyZKEDKP2ZXEu9Ddd3ArGMaGmL3MWhIKEGqXXHJmVuZ05PrMb1cJRJdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrgh
X-ME-Proxy: <xmx:DRkbaC4ZyWNf8eACgfcuC-iMnXymldffiijfeG4z3rKjmssA1Gs7Cw>
    <xmx:DRkbaO7Q6n8TkWpDPj0Ut-4mzVex5JXhtSZ2PRkt1HtDJw_0GUu9pw>
    <xmx:DRkbaKhl_-6S0DiafXS2I9KETQJhY_oV7brK1L05C-Hz2zywvpbzgg>
    <xmx:DRkbaA7KkBFpEQcqCw_CdxC4sFg_Kedei-rhggMCiSveNKctXa4tZw>
    <xmx:DRkbaHeG-kmOXNvWudm2_kcA_QtKHUT_5fWTvUcfTH06MvWxzyjs_vNz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 04:25:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0af42d2c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 08:25:45 +0000 (UTC)
Date: Wed, 7 May 2025 10:25:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] promisor-remote: allow a client to check fields
Message-ID: <aBsZC_MZw7BHxUiS@pks.im>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
 <20250429145243.992252-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429145243.992252-4-christian.couder@gmail.com>

On Tue, Apr 29, 2025 at 04:52:43PM +0200, Christian Couder wrote:
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 71311b70c8..4147d2cf44 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -46,3 +46,28 @@ promisor.acceptFromServer::
>  	lazily fetchable from this promisor remote from its responses
>  	to "fetch" and "clone" requests from the client. Name and URL
>  	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
> +
> +promisor.checkFields::
> +	A comma or space separated list of additional remote related
> +	fields that a client will check before accepting a promisor
> +	remote. Currently, only the "partialCloneFilter" and "token"
> +	fields are supported.
> ++
> +When a field is part of this list and a corresponding
> +"remote.foo.<field>" config variable is set locally for remote "foo",
> +then the value of this config variable will be checked against the
> +value of the same field passed by the server for the remote "foo". The
> +remote "foo" will be rejected if the values don't match.
> ++
> +For the "partialCloneFilter" field, this allows the client to ensure
> +that the server's filter matches what it expects locally, preventing
> +inconsistencies in filtering behavior. For the "token" field, this can
> +be used to verify that authentication credentials match expected
> +values.
> ++
> +The fields should be passed by the server through the
> +"promisor-remote" capability by using the `promisor.sendFields` config
> +variable. The fields will be checked only if the
> +`promisor.acceptFromServer` config variable is not set to "None".  If
> +set to "None", this config variable will have no effect.  See
> +linkgit:gitprotocol-v2[5].

One thought that came to my mind is that inevitably, users will
eventually want to specify different conditions and combinations. E.g.
"accept a promisor remote if it's announced by GitLab and if the partial
filter strips blobs, but not if it requires additional authentication".
I don't think that "checkFields" would be able to implement such a use
case.

What is the vision where we want to end up here? Should we maybe provide
some more flexibility now already so that we don't have to retrofit such
a mechanism in the future?

Patrick
