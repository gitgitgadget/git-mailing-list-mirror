Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A2263F2F
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870548; cv=none; b=AA08fij+VyTmsyva4TWcMQo//h4N8I0FiPakkH1Z/R+foHIEV0+XTGHKLZPmiBbHUzArRKCYZMc1nJJ+oExoXWRtrZ5ENbNAYr6/SM4IYQsaptLvPpast5x+w+CdjqR/W0SPH3/e5nFxRissvThQxTZF0X5bDpnVAUCbkqA/6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870548; c=relaxed/simple;
	bh=FIpo+Vl15/4V6Uw+QxG2y5okffkx3DdJq+lQfdEbJZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RywMdxKwPR7zB4FDW2eYaA0kMoa/SzB8ElRvfayjIi0tyKr8qpm3TVuMm8T6AbH2nAP7sSCe1fP1YAFYZDeZxShnN+1NM60Nf/piySHJDcbxbLWdZup5+nMnMEbDwulWlcXCHY3raf7YXYlRO2qML5c5azLATZFqIczDAWE5U8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D8p3666W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mO/n0JNt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D8p3666W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mO/n0JNt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8609A1140204;
	Thu, 13 Mar 2025 08:55:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 13 Mar 2025 08:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741870542; x=1741956942; bh=OoJ35BPKeV
	/TrEaq5WXnQLGKMKWUBTg219dLztRSmGE=; b=D8p3666WWoy7ArHZfpNQgOVJJs
	Yn40WTCfeTNbd/wlx8kzBIF88Knzh0Kz6zRcZg3WqiFMhI0i48WIzM65tcsJ6zPC
	Qm/B23qwtBNNSK6OlMy4krdnkizssx9vCZXJioqSwwrDmyNL+AJRlUBOBLt+cP9j
	X1E6e+5kL23R3RhvAuXQcNdQCoV5u3oSTTQUon+jt+SrE6fE2/aOlbQGG9WxhLFA
	HgMUNEGgQOTLBlil7BB3yszg/sr2zduu6nu5I8deKGn5SOK2HxMgoS55YJd0szB6
	qWIkRPWf79eO4VuHcFwa0/f+I97TtdcHoFVV0tlLJD07Mo660o2TR80jgfaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741870542; x=1741956942; bh=OoJ35BPKeV/TrEaq5WXnQLGKMKWUBTg219d
	LztRSmGE=; b=mO/n0JNteqX4Tkb2YOX5XVccOOZr0qvnmcrVDK1nSTfuIUfXSdW
	go0QBB7e0v1uhjYvkdSgtxsV2QTveHtso/LDHjT1cVrlrIAiTgSXkPJe5dl8HmRF
	KV/w2tUWU9OC0MoUnaWdVV/cD3YhCrHLXOKunoHUx1iGmNQTkhhOPdMnZY5mg593
	BQXzPih6pWt7oTUu1IJ8Z/Tnn33AvNT6BwoRRmtcJnW37CKPJQjwSQkJoIPKMYKs
	NSle8VaiLy2mRVYt19eHddC/S7Tke2JZqML0iK28mPgH3WywJTKiN4U46RHLzoIS
	jnbuA9bIQAuEKyi3iaxGFikQShzgZAAH6bg==
X-ME-Sender: <xms:ztXSZ2us8o-oqcq7lR67rCgtBsz1PloPfyjYzQ1emm4B982KoxIDXQ>
    <xme:ztXSZ7en1VWPE7HzjfuMuUWw3trVVo3g-QBMjXisOURGMnwStNv4H7irTaPpEIzYM
    RSGRE1kOHUFOWrHTA>
X-ME-Received: <xmr:ztXSZxwru8YyV_aY0eecan3rrM9Pbv0qfMpp7HSs8olgW2Sh60k7pcoJH4KAFTTuqF6PrRhoxIJTQZ7YUdLWj_o70Gz85mCaVVQFdzF22xObRX8M6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvght
X-ME-Proxy: <xmx:ztXSZxPvHxFpHekdnKLq3-PNJefK5cOx4QrxKUel-zWGv65MQE-umQ>
    <xmx:ztXSZ2-hKxca3sc0-IofaG5YA-8ydf32zKMWQ6Z-PuPQOUnD3SAOvQ>
    <xmx:ztXSZ5US2KUF_wPGoC4UnXtNlBoz6WBVpQDcNQYZ3QxfiQ7IQjcQBw>
    <xmx:ztXSZ_dYq4ehKsAyC0pkOILry4bObw1DrUS3OEGMFRHd2KvfjmAIFQ>
    <xmx:ztXSZ9mjG6dr9jMC8VZ5pRkZPxgnQgMkI7SbV-Ap_de7grRLhXQn14ph>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 08:55:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59dac139 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 12:55:38 +0000 (UTC)
Date: Thu, 13 Mar 2025 13:55:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net,
	ben.knoble@gmail.com
Subject: Re: [PATCH v2 4/6] rev-list: support delimiting objects with NUL
 bytes
Message-ID: <Z9LVxt8urwRXLLcL@pks.im>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313001706.3390502-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313001706.3390502-5-jltobler@gmail.com>

On Wed, Mar 12, 2025 at 07:17:04PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 785c0786e0..166d3cd19e 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -361,6 +361,29 @@ ifdef::git-rev-list[]
>  --progress=<header>::
>  	Show progress reports on stderr as objects are considered. The
>  	`<header>` text will be printed with each progress update.
> +
> +-z::
> +	Instead of being newline-delimited, each outputted object and its
> +	accompanying metadata is delimited using NUL bytes in the following
> +	form:
> ++
> +-----------------------------------------------------------------------
> +<OID> NUL [<token>=<value> NUL]...
> +-----------------------------------------------------------------------
> ++
> +Additional object metadata, such as object paths, is printed using the
> +`<token>=<value>` form. Token values are printed as-is without any
> +encoding/truncation. An OID entry never contains a '=' character and thus
> +is used to signal the start of a new object record. Examples:
> ++
> +-----------------------------------------------------------------------
> +<OID> NUL
> +<OID> NUL path=<path> NUL
> +-----------------------------------------------------------------------
> ++
> +This mode is only compatible with the `--objects` output option. Also, revision
> +and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
> +delimited instead of using newlines while in this mode.
>  endif::git-rev-list[]
>  
>  History Simplification

I feel like this last paragraph, where we talk about `--stdin` being
NUL-delimited, should already be mentioned in the first paragraph.

Patrick
