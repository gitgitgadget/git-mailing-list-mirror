Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900B2F0C71
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319117; cv=none; b=TkR2t2SXMe55cwUHm4xJRsbLSJWRiWuL5HvV7CTjhSZI5Z0DMFG6iyo/7u2kBNJtO47rRuTj8RkPaRxiSxeOfw5Bqnid0oTx1F7q9Xv+FRkIbsYiOQGciVuXtPGg6frzOyO9OwmSVvQ7GMyFPu7eNmlR9GzaOw3UUcvP9Wi0ZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319117; c=relaxed/simple;
	bh=GkSKnHuB4tBlKKn1l/lUR+ld8mD71VggGjhn/0cgVQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAgmH9yyuO6Das+9CIyzHOxxkw3g/TZFPv2B/8BkwzoS4UISUyTCiAKehEyPNW0eqZd0BocjakVk5elwSnECcFeJpKjrznj1K9Yag/ITKe5vuEuBULBJwv9YU2ALGWIV1qzJ+qgLF3qlTBhiO4PlHcdUNxXa/kKk0Xx8dAWXaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nKWeGTlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=is//UyPe; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nKWeGTlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="is//UyPe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CD357EC0606;
	Tue, 17 Feb 2026 04:05:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 04:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319115; x=1771405515; bh=na2bd9zrES
	jCTK68FMq8DKQI/+tWmgZ+DmR6qmDiKHQ=; b=nKWeGTloqx5xWhMktZog9ZAglM
	o86N1vU1Y2p9cfoxCRAab6BFjRgFXCi0tTwx6r6BD6MRFg+1EVcXGcCJhv2gH8Cr
	7gIpx2lI3cB5jvlu9+U6GFiHvf4SzuEv0XnhIavSkL0M6HEHvMrfG8toeXjKg1OP
	72Lnfb4lyTqD12b6UsJyFunj936V491Ul3Ud0ISlFna3CPL3u4v12hZlIbk8CeSD
	2uri1cpOLMJ6Wkj1y9kO7qPryhZY4ZvkiKLytruANlQLHsPCSjmYn09e7NfoseZK
	Q8fz+qzo/ooFjNa9+wcjMkWPxEjC+oaXAG+KmOs5sSrGX0LEPt8hPtVdp06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319115; x=1771405515; bh=na2bd9zrESjCTK68FMq8DKQI/+tWmgZ+DmR
	6qmDiKHQ=; b=is//UyPezDtUnGVqNHiynTfGDG/7QLfpezSVdh0ww0MXIe540a/
	o68SBpGfRE6CpNBIEWCmGjTnnRsWuWkKfRqZ2r+IjmiC5DOxA0ZUqExQdz9AtFMd
	xi1J+b3oT1IfrTQJe2zoPySS+ecgEeL6VcHSEFIW4JCHbVX0bQbVdXIdEv0jBwNZ
	yecBUr2Ggxbb+6nKQ/zX/8CJ7ZhRFpU2RkLNYjR6gRt897F40k00oKl5GW9UMP2N
	e41FKBMIDeJqFvSfza4EkkhPTMiW/gPjpch5i/xHEC57y2tPFcnCNQk0F5zydXYc
	GskOZjyAh8+FFVKlyPOf9HwAFsxW0EEJE3A==
X-ME-Sender: <xms:Si-UaaVbbqxqU9rVUcME_8vMri5rQrUIE8RT2vnm-lS2KxHpgZqTNQ>
    <xme:Si-UaVo-2LGf0rytCsnT60Y1XrpRtZtjoH1abhLf6TRZtBs5y7C_9gxQy0BOEooli
    nV-WTZwcMbMsixnj93O8B33Rsq-eq_mhJ-qWmQrgKeZ94edVIcc_A>
X-ME-Received: <xmr:Si-UaUkmnBuKUfPJansI-a4gQ0WFenGbj2v32NaZAsn7xEv1y7FLLuUCVY9JFNdYyW7ksPKJjSAJJz4SzL0yLxHWq9X9mjItL3J4jCEA7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Si-Uad0AFxoo_Z5UtaRIYvKzk7vbomTtpAXoVIUSY8xefI8Px5EHsw>
    <xmx:Si-UaZR6jGCDI3-gfk_5m6TsosvvJiPcO_uRhXENxwOptxwWnJYpQQ>
    <xmx:Si-UaewmGYvcST-NHMucZ2q39PTQmkT1SCE5Jjdntxi7vAcRu8aBVw>
    <xmx:Si-UaRDrAN9VMWJSMhsqWHjMUf7yiEyHbmMD4qXvUC6RugjRHH3faA>
    <xmx:Sy-UaV1FwtztxDICwGGMVYR30UbP4HQxeRSGtYy6YvUWFKZJWiO9qc-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:05:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 479fc9ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:05:12 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:05:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 06/13] config: format bools or ints gently
Message-ID: <aZQvRH4vPkPYHyg9@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <0a428d2ffe092c2af6789b5e698dc769b0eb883a.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a428d2ffe092c2af6789b5e698dc769b0eb883a.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index 2c169fc126..2c93e1725b 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -274,6 +274,34 @@ static int format_config_bool(struct strbuf *buf,
>  	return 0;
>  }
>  
> +static int format_config_bool_or_int(struct strbuf *buf,
> +				     const char *key_,
> +				     const char *value_,
> +				     const struct key_value_info *kvi,
> +				     int gently)
> +{
> +	int v, is_bool = 0;
> +
> +	if (gently) {
> +		v = git_parse_maybe_bool_text(value_);

This function also returns `1` in case `!value`. Is this intended? I
guess so due to our implicit bool thingy, and `git_config_bool_or_int()`
seems to behave the same.

Patrick
