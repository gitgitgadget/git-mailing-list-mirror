Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71C2D0629
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099326; cv=none; b=U4bjXE2TZrnbQuYydh5JDaWaG+AO9WlqpRbxwEPJUAPMa+insO/uWXm2zuDJdXmi8oSB863IkJsvOywMJTzwNNnoncFPedymFYq0EAGb1/qZDv9wpd7RmNbeiy32ATHG5a5IulOB6WVPGPlDLCmboeHRF5SIIzpjJWvy5poZV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099326; c=relaxed/simple;
	bh=eE/N/kgOaTSkAQryDQ8GZSO+i0ZOoiR4n/D2YcoKqks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5dlnnx79AG/TrhbAkIONv8WNS9wzVmyEeYkT58wLjkFGtDsRdvIVM2FoTNCQRRSmKzWwy9WvvmkIVf18qilE7PUKsvYR3HBrOZOz6SkO0Kv10SCu7Vi3vXxAxHnN4wt6tx7TLxK+IynvJkADMw65oFd2cgpf+/DLUyw99Qtv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NNTf7x9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dwzDMOTl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NNTf7x9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwzDMOTl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58F0114001D6;
	Fri, 10 Oct 2025 08:28:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760099324; x=1760185724; bh=79og72QOxN
	8lKGMqdoZw1mJb3+7kcDC8wOtuu5C2BFs=; b=NNTf7x9UeK+y3KZ/0zVJObo5k0
	5LQWDhPv+LWsiDZ9QQrlrtVTZAm8WcA3JTmFsWR2OnUvMdjFvHmC3wHPg15tST4L
	s8N9gaoH6yCZBf3YaTyGQQ5z77cxH8WOvAiiV8Pds9Pe4uzMGheuFWw2e00q7irp
	Y7pTHWbdjRaZHJGaYoGywDpkM8H7G36xqoYPaMFa8Xb19U1xj9CqM9MHkxjgY/z+
	1QyWPUJtQWOfa1xfkP/cLwVGxRd2iRcYSuRFty8EqB11bdykEy2h78MHpAe7xt6b
	AKhZdbkHmS816s9Wk6C80VqRPNufGNJc5cE5BkWTPqP5keurganLqW78+Htg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760099324; x=1760185724; bh=79og72QOxN8lKGMqdoZw1mJb3+7kcDC8wOt
	uu5C2BFs=; b=dwzDMOTlMinF6h8wcEMLc8lE9B2Qj8T0ZoaBrC1JUjMV1gND8HS
	ytt+3sVqLpbJYOhs7KEfukB7OVu3IGZvL91b0CjIoLIQvCcKlSXCwEuT+XvbMTwy
	xTDo8Qv7lzGHRG69zykVpM43+8mIJLJTB32tw84fqtx9gp10DNT5NFxwp14yFY97
	54VjBC9saj4bL9xt5cTgk2Oy0HUo4g7qp/Xnei894qmFLG2fIQF18YN1Th9pBhjR
	YawnedGafNyZhMVyuOrmX0Y1ZuuenqucVM+JYubs/GoxaJ7pxZyZB7K+bPEztsgv
	bAEhlRbuq2EWKz03tQu59OHVJnGXeCVBeCw==
X-ME-Sender: <xms:_PvoaL1jd7cncQb5ZkjaaWBrLJT8BJRY0dpBeUs0EBLswE3wkOB5fQ>
    <xme:_PvoaNyGHjEU8SQrclWRCECj_rMQ5L_bfcZ2lxtnbVpeVo2TH6P2xOmXAKQr7oCtI
    eCx5CON0hhQmxZ2gLw3IvAqVMwA5TvXUEphGsM-TTZcmbUvDPvz3A>
X-ME-Received: <xmr:_PvoaFtuvLp3QU3yW7p4Bb-0c1RYQ9WZoHEXT8jwjBlQ3xfgjLOYmz2Yakga-qPzVmkhOi6PCqqfDBMMHz3QioZXbKnqq2nLmqUYEmHFRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_PvoaHwuMleoiOEC9WKRSvHanxXN_jnbt85S356C4IjZttAYIgW_kA>
    <xmx:_PvoaAAC5_61W2FHrmykqvyd4jsGESpPKaLHRH0cvn02V4xjvilNHw>
    <xmx:_PvoaNf4V3uZqiug4GfZTq52eWW_zu6OcjlGgRR_lKHvQidyu2RFiw>
    <xmx:_PvoaCmUQnQW1l-3h4ZZkfijFwENuZo3sE4TPqCVxOvNGzQ9rpSQ5g>
    <xmx:_PvoaOTL65zoe_iFjyiecxr0ljCRnh6DWk04WJ5u-OVIDnFzhUYJTvWR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 08:28:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8957585 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 12:28:41 +0000 (UTC)
Date: Fri, 10 Oct 2025 14:28:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 41/49] builtin/repack.c: use `write_pack_opts` within
 `write_cruft_pack()`
Message-ID: <aOj79rYGyYWYUGGY@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <7826afc17376f0d4a7f3169d9aafce21b3273ff5.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7826afc17376f0d4a7f3169d9aafce21b3273ff5.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:09:57PM -0400, Taylor Blau wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 6df7c88085..501359c580 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -221,9 +221,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
>  	strbuf_release(&buf);
>  }
>  
> -static int write_cruft_pack(const struct pack_objects_args *args,
> -			    const char *destination,
> -			    const char *pack_prefix,
> +static int write_cruft_pack(struct write_pack_opts *opts,
>  			    const char *cruft_expiration,
>  			    unsigned long combine_cruft_below_size,
>  			    struct string_list *names,

Same question here regarding the constness. Subsequent patches also
surface this question.

Patrick
