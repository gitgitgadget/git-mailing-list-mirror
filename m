Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E923C50F
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398243; cv=none; b=afdJ4OYwTqzfd4rRCLwRDByy5FJ6rufEaO4L08MYiIi+3QNI6yxO6t3Zl3/MF2PAK/H0LxAJrwTyb5NRO3RcAnA5lkduBsNqOMlpjs+amjmj+qx28KprxnR8qf3Leb50Bskiyn57p0uBjjKOd261+USlHGmzbGYt4unkGWP/nWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398243; c=relaxed/simple;
	bh=7doz3XjWc+x9VkvJyavGuN8RoWjojLwfdC6wNMa2a1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbZvzpi7QQwIn/4jeYY5LHbMNi1I2Ingf29AbFAHn8S062rFTnh6FBK4uSd2t1odjaXF9koKdsX3E6N7lsBenAHFSyANMVaM081jKwhWb8blA3Y7Kn770Y+/m4YlQOntAzAFIYsldbtVDPul7cvLlPBEAYSIlGw/tf+/TLJgoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kds+o/9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmxaPwiG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kds+o/9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmxaPwiG"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EEA39EC0203;
	Tue,  5 Aug 2025 08:50:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 08:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754398239; x=1754484639; bh=xIAB0qRHwu
	9IuKBW9w0OMhmpBBsBS8okOuzDmD+y5VU=; b=kds+o/9JPReZoKzOMCUcLRyfva
	p04KwlNsmAooC6y2cPlk/AAV18aGkgT/CjfDwpU1yP8Wa8tK6qK/7K+eZwsdXEhD
	XfWfh2FaCCgTXZPLrzMbo0syQKJPiWIXBPBlNfwPfoRHkXa5zEF1WkJYT51OCXNn
	QZ7wq8T/RL1k9nMytJfiuwls0517/6huCkPsSKSEAzlG3Uf/HnQcVaV5W6bhA1Ab
	CBsJ5G2VrHUXTFEQQkcQiY4gGiubJqJRfmgcNm58oe45LzqJhxgkLXuAWBK8v4Nk
	g1PF+iQY1Krc4YobUXAE43DiAzwe7ySG7/mxpfqCf5xWdNsZClZg0l80XiHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754398239; x=1754484639; bh=xIAB0qRHwu9IuKBW9w0OMhmpBBsBS8okOuz
	DmD+y5VU=; b=lmxaPwiGiZcggDru9/itAQHZUjpBv34jpL/EvZzfnQ+Hj0FX8jW
	ewNOxQU+Jqaf35JgnuD2frrP3kr7oqeFCSDa4kwBO/Qbx1ERh1EKjv6odqDm3H06
	xJGyR1+cdmkdJmP0Pcbsz+07zzisYf4TyPMqu54/D7dv120U/lL9y4cPrMwydBAE
	pr7+rh1dIuMamA0fkRB2a2nqBQYlMjjDxVNiTZ3w0sjaWFJlt9v5m1OTsBIqcdtV
	zgnjn26rErmJpYaqItW6UCP/4F5S7n0Qx89DTAQHxLPKKULrssxf0wi7xk7X+rGr
	BaWkjlQ8A/8fsiPTNupysm9o3i4L6NEl9lg==
X-ME-Sender: <xms:H_6RaNSKiilEZU-RnQiRLYnN3pjNrHS7zbKHyJX2gYgAGvzqdCfEEQ>
    <xme:H_6RaEJsRVhYGSOAYlSOc63osBo15bifSeNWxB1VlmBrwUml2h2J_p0rl3nGCHynU
    ZJYf-xoqvZi9957AA>
X-ME-Received: <xmr:H_6RaKLbrNZ-s2U3sHsasNJmAe3jz1VMk0wAfAJsZULmlu2n9vRtNG4m71elM14SL6SFEeloGtzUxFTaZYJ6l3xqQX50sJAuq2BF6sNzAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:H_6RaPh4BT5Xzdqiu-xPYe9bSBlqzeI8G3-K87DTxgyfFncs42M44Q>
    <xmx:H_6RaENiFaoLVlNzEkL96yj8c1joeUCxCskxpdub0yCDllhd7iyAkQ>
    <xmx:H_6RaKrKodovXjeRHF963DN0xTmZuDb3i3y3-sfgoYmIgZFLe-oukQ>
    <xmx:H_6RaG6MKBYQfg63TmbTrCiaMw2w29rrs3-UvDqn93ME1mifenCJPA>
    <xmx:H_6RaGi1uUqRVgZGM3jURUze2h5Ogr_Gs4p91V9m9VimjWpiMeyhxRGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 08:50:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8935acef (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 12:50:37 +0000 (UTC)
Date: Tue, 5 Aug 2025 14:50:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v7 5/5] repo: add the --format flag
Message-ID: <aJH-GhcWyZLRV56m@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-6-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801131111.8115-6-lucasseikioshiro@gmail.com>

On Fri, Aug 01, 2025 at 10:11:10AM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 140ee3a0aa..b735cf4737 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -18,12 +18,23 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>  
>  COMMANDS
>  --------
> -`info [<key>...]`::
> +`info [--format=<keyvalue|nul>] [<key>...]`::
>  	Retrieve metadata-related information about the current repository. Only
>  	the requested data will be returned based on their keys (see "INFO KEYS"
>  	section below).
>  +
>  The returned data is lexicographically sorted by the keys.
> ++
> +The output format can be chosen through the flag `--format`. Two formats are
> +supported:
> ++
> +* `keyvalue`: output key-value pairs one per line using the `=` character as
> +the delimiter between the key and the value. This is the default.

Let's also mention that the value will be C-quoted.

> +* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
> +between the key and the value and using a null character after each value.
> +This format is better suited for being parsed by another applications than
> +`keyvalue`.

And here we can then explicitly say that it's not quoted.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 56c3a4027f..4015cf88b7 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -74,18 +79,33 @@ static int qsort_strcmp(const void *va, const void *vb)
>  	return strcmp(a, b);
>  }
>  
> -static int print_fields(int argc, const char **argv, struct repository *repo)
> +static int print_fields(int argc, const char **argv,
> +			struct repository *repo,
> +			enum output_format format)
>  {
>  	int ret = 0;
>  	const char *last = "";
>  	struct strbuf sb = STRBUF_INIT;
>  
> +	char kv_sep;
> +	char field_sep;

Nit: we don't usually have newlines between variable declarations.

Patrick
