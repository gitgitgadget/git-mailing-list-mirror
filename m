Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776812DECB4
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579344; cv=none; b=ZLfLNwVtMZ6DFvx8Ff6HdDSGfhN3yzUMrM3vvMArjaEAUMlje1wx6rw+U0CDtU8KgObrlhM9n8T/ZGK9Sm+8ZzgJTqErtopoOLLD8T00iaCLMkF482l2m1dPyoSw3t+wvpZW4QdU1opTy/TEwupn1C8fOcHU3RM3HzdekL3wFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579344; c=relaxed/simple;
	bh=WprcDVwmculeleVCWlkvUtC66MQGc5OV9nC6Oikyb1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4yQAVi1PsuhZsxAKLGNHF9qtsRjLAxSvInXZV2ohU3m+2baNhdOK/g0w2rD/Uop2fz4j2j5w/frbuOCTM2iAFhIpU/3BDTVk9T/IDaH/upz9vTdg5yHg+YVLbkF4DHXQWUxFRL3jDqFAvEmNKl23bMeuctoR7NqqaWBy/M64XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o+3bF61K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qx6ejZ+G; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o+3bF61K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qx6ejZ+G"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BF2A1400188;
	Mon,  1 Dec 2025 03:55:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 01 Dec 2025 03:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764579341; x=1764665741; bh=q/oHnh7/fd
	prakf+/Vj9wOtxR5lZA3BpIJqh8GcTPU0=; b=o+3bF61KiYy+vjI61C6p2Ek/NG
	Ait3s2QPZSg0gP66MX5CW+sDNxo5JeSnvIp5lSCbnAKaUpOwZnMwhpxTRKXW5djm
	2y9DXRWUfgDL7Kc3jImwlKvvw2jqqUjVVRlCTfHobfmLgxGMYaUXmYjZ6th4ULeJ
	51g9mcqDTIcjK39WxCCN1ghFx0deD+qSrx+Cn6cSZPCO4RJ2CDrOaiM0Z9cLmyB4
	Aa4NOOhitGMKqcyDd4k96E0cy4dpcxNts2gR/qnMr1QH7DSrj1WykEYBv+mmc94z
	rpPW3cXPu4momP5nHtDtOONhUaOhOlJfJ8QF5DnL9tsLTBmzmsnUyTcynokg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764579341; x=1764665741; bh=q/oHnh7/fdprakf+/Vj9wOtxR5lZA3BpIJq
	h8GcTPU0=; b=qx6ejZ+GXmU4IffRYfu9xIMPjPACvLX3kmbYWlLXA05qWJDIOlS
	ewSLPdJZXSg7v58I9FIC9CbOuscg8upm5h5ljhvUhaEBTw++GN0SclK9xYe2aamH
	AjntOPxPc1ldbE15n6rVI9Hw6TTAzzUg8AoYX2gQ8NUd1/wY1xNBBM5SWDiusP/h
	KFV+SbVq3HnGr83olsC0psOV8Azku8lsYc5vV8VDkn2ASOscAILAdX+9yNllYrvf
	Ba36vP6OC39i/pjs1DaPTNlmgXSqs+gLAsg4TBoIN/ng2UH4GIvpWD66ErbMZHCl
	tD1m/IUnCH0buiMB2a698T8RVfiATF+cKfw==
X-ME-Sender: <xms:DVgtaYZ_btaKs_spbW9N9sxg5VhnAz_4Thz89pC6pcPvx39N66CwMQ>
    <xme:DVgtaXHxl073Zv1iZuFRsv1hzaQKRbePxlW_WOw7ph1ury-Lugk2EbEf86G7sQI1P
    BJaDoCfq0aP0QGiuPG4UXZ4Mb7ILf2aL27zsJgWuHMyfUYcE3HP4w>
X-ME-Received: <xmr:DVgtacytjNRz5-p6A7l8iLELDVVGmjjd6Ono3YzDRLgJywdgohbQBv1jWSy2Jqy6abEM8pdHoZVKMPgyCifvJOd9O6UeVndOdfsPPsxm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheprghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DVgtaZm3COhMymZfPr3SJcYIfHo_Vbi3z07ULGvrbXVmiAqcZLlN2A>
    <xmx:DVgtaVlxK_Yn0jzgyzT24T9H6HdAwhZq1MUq9ixD306jQEfuVy0mxQ>
    <xmx:DVgtabxXkRN3VjIXMfFLfTp6cI-BI_buqXze4T2QQxRlpnXnPX0dwQ>
    <xmx:DVgtaaq5DeGRc9m_hOIjUeOImxz3cfmLe9oU1tDGvwRSBjGJMDm7Lg>
    <xmx:DVgtac0lPwVXhQrZkHLUrL35KrARuS5nHoXEmkkrqdTxKW8nrw6usi6J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:55:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb68e012 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 08:55:39 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:55:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] scalar: document config settings
Message-ID: <aS1YCAIrafQ2iEfz@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>

On Wed, Nov 26, 2025 at 10:18:36PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
> index f81b2832f8..b34af225e6 100644
> --- a/Documentation/scalar.adoc
> +++ b/Documentation/scalar.adoc
> @@ -197,6 +197,164 @@ delete <enlistment>::
>  	This subcommand lets you delete an existing Scalar enlistment from your
>  	local file system, unregistering the repository.
>  
> +REQUIRED AND RECOMMENDED CONFIG
> +-------------------------------
> +
> +As part of both `scalar clone` and `scalar register`, certain Git config
> +values are set to optimize for large repositories or cross-platform support.
> +These options are updated in new Git versions according to the best known
> +advice for large repositories, and users can get the latest recommendations
> +by running `scalar reconfigure [--all]`.
> +
> +This section lists justifications for the config values that are set in the
> +latest version.
> +
> +am.keepCR=true::
> +	This setting is important for cross-platform development across Windows
> +	and non-Windows platforms and keeping carriage return (`\r`) characters
> +	in certain workflows.
> +
> +commitGraph.changedPaths=true::
> +	This setting helps the background maintenance steps that compute the
> +	serialized commit-graph to also store changed-path Bloom filters. This
> +	accelerates file history commands and allows users to automatically
> +	benefit without running a foreground command.

Is this something we also want to promote to "default" eventually? The
downside of course is that maintenance takes a bit longer, but given
that it runs in the background anyway this shouldn't really impact our
users all that much.

> +commitGraph.generationVersion=1::
> +	While the preferred version is 2 for performance reasons, existing users
> +	that had version 1 by default will need special care in upgrading to
> +	version 2. This is likely to change in the future as the upgrade story
> +	is solidifies.

Is that still the case? We _did_ have some bugs in the upgrade path in
the past, but I thought it got all sorted out by now?

[snip]
> +fetch.unpackLimit=1::
> +	This setting prevents Git from unpacking packfiles into loose objects
> +	as they are downloaded from the server. This feature was intended as a
> +	way to prevent performance issues from too many packfiles, but Scalar
> +	uses background maintenance to group packfiles and cover them with a
> +	multi-pack-index, removing this issue.

The second sentence here reads as if "fetch.unpackLimit=1" was the
feature you are talking about, which led to some puzzlement at first.
But what you are talking about is the _default_ unpack limit of 100.
Maybe something like this reads better?

    This setting prevents Git from unpacking packfiles into loose objects
    as they are downloaded from the server. The default limit of 100
    objects was intended as a way to prevent performance issues from too
    many packfiles, but Scalar uses background maintenance to group
    packfiles and cover them with a multi-pack-index, removing this
    issue.

Patrick
