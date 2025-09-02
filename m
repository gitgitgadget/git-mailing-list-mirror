Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B322BD11
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808292; cv=none; b=QyPgXA+3wOtN9se6QL8QVWE1bq2eeuLp0opiN3JML8OseuWrcnM2MxnoGQU9RNrJbiKzjA76Ec2w8edzfbWgmLFYIams1q4hQ7OlbiF4pfXzT3JFNuIrdRoox6sSz+F7RgQpafr81UmRVcVYgwdGB4kLs5bxCL1QbsfOLjRTWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808292; c=relaxed/simple;
	bh=P8iTRxjIh/uia/97LHuuf2cXHkXJ6Zcai8iQOwsHwmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi+ktAXG9YEfhCPYyenpdc/G21ggFCvDhepr8TtJ9AAImezD/s8FfEIhuAh27sDGBHNymEUzsedjNhcsymF3gIgczTXcRJHxBepTDjYsLUA7S1/14qFV6ZO7F8gmnwE3nu30KvN9vQrzZ3w0LqgwmNnj4o5zuLoCE2J82JWNOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sGyji4as; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UizYwUf5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sGyji4as";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UizYwUf5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C90F4EC03B8;
	Tue,  2 Sep 2025 06:18:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 02 Sep 2025 06:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756808288; x=1756894688; bh=47HO9ZYbXC
	FDZzyJLVb/xAyPTkHv6YvGkG5EM2ZYL0o=; b=sGyji4asArWV9NU7WnM/pRvT+2
	YrErUnnb3pGmMx4GxA7C9rudt6sRtgA5N32I20uaVmL/B0xLq3X07PGWyupx2LLz
	sixCmOA3ZgvX0Jzr34gx4YPxwl16WQEJdckaFu9fIP2N03ZhBDaGnAIgQg/Ytnul
	qbbiTTIa60gZ/dfVBHCwTCVLogu5x7NESIuQu5fLEtPFPD3g9wAx/5MM9D/OTI0r
	w1R8FP5lpQyGKWGb+3K8d8aAYMqA+mAFPV4Rc86ng9s4obCvy612ErQpA8sRfbug
	5tpAWbHpf0KyBos5zhfAleYzW1MGJuQQP5E9v7NvdNY4jzT4H3RryAMnp/QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756808288; x=1756894688; bh=47HO9ZYbXCFDZzyJLVb/xAyPTkHv6YvGkG5
	EM2ZYL0o=; b=UizYwUf5hpKB2hvBBPExlBeBAEMEowpcw6dNXCaSI2hCic1YA2B
	/3aRUMWRfTPy9y8oMR1pDZ70yIdifFeDLNM1yKm//ewW1mV5Vbfm6fXh3yrFNroK
	kQgKr4j35iCi33BK5M8MKMl2qWUhRlrGOSBhXGdy93BJgkHSpfDydup6eR4IgOCT
	HvgmTxdKDF4wWGTQ8GK2ECe9oh0JtY8z8Hi9/0ktyMfD1jx2omtr/DK9+6ejxAUN
	6DBYb8XCScC4uOjswTRkGv87uqM+mWiMgAJdFHStgoZ97tfTXWHmWvNyjMAe02rs
	/elz0w6SLEljATTErmZL1lWk/Mpfr5lWf1w==
X-ME-Sender: <xms:YMS2aE-5PDxT81VnE_lZcOAiwpw2VoRcVF2PXKqmoQAiQw6osUcDnQ>
    <xme:YMS2aEdk9nO8f48Fn8i8iYS7vIfbfVmEhux7nO4dPfTrGVjI7_b79zn6H3MO2fZGE
    klOwqYfYk32bBqa-A>
X-ME-Received: <xmr:YMS2aNH31Su4wUheXnS3ff0uOEPopABRlNiiLPiZBFCUUGvmTJTRcPJHvsYBQng0Lfv1NlMEvSuj9xkTcCgbMjtfM-rtKVLoXEtnTjFGgQxIew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghilhhouhht
    mecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvf
    evuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjedttdegff
    ekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvght
    shhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:YMS2aCfL_aMI9RrejLEh4-DtRzE8wygmrMZDyYOuNESY4uEFq-G1iA>
    <xmx:YMS2aHGTW1-C1r2GNpemaTIjNn59hiWWyrcLOgR7SbYiRG4LQ1eHQw>
    <xmx:YMS2aLUN0C0gUn11sZVIBUQ5IjBl6A5qmilsST2DXvq5E43Gp-h3_A>
    <xmx:YMS2aOKBrHTTGTu5RQcm_rsEKF6uKW1gIi4jyUspvUuKq0tRH2bkUg>
    <xmx:YMS2aPcxrqMXwG4aDd-rLAm6bdeNxXAFesyZ0cVe1LYqrnfegqsvF4KA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:18:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3eecd012 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:18:04 +0000 (UTC)
Date: Tue, 2 Sep 2025 12:18:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into
 a helper
Message-ID: <aLbEWSHUotkmSiCq@pks.im>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826073645.1074397-2-meetsoni3017@gmail.com>

On Tue, Aug 26, 2025 at 01:06:41PM +0530, Meet Soni wrote:
> The implementation of `git pack-refs` is monolithic within
> `cmd_pack_refs()`, making it impossible to share its logic with other
> commands. To enable code reuse for the upcoming `git refs optimize`
> subcommand, refactor the core logic into a shared helper function.
> 
> Introduce a new `pack-refs.h` header to define the public interface
> for this shared logic. It contains the declaration for a new helper
> function, `pack_refs_core()`, and a macro for the common usage
> options.
> 
> Move the option parsing and packing logic from `cmd_pack_refs()` into a
> new helper function named `pack_refs_core()`. This helper is made
> generic by accepting the command's usage string as a parameter.
> 
> The original `cmd_pack_refs()` is simplified to a thin wrapper that
> is only responsible for defining its specific usage array and calling
> the shared helper.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: shejialuo <shejialuo@gmail.com>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  builtin/pack-refs.c | 31 ++++++++++++++++++++-----------
>  pack-refs.h         | 22 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 11 deletions(-)
>  create mode 100644 pack-refs.h

Shouldn't that header live in "builtin/pack-refs.h"? Makes it way more
obvious that it exposes functions from "builtin/pack-refs.c".

> diff --git a/pack-refs.h b/pack-refs.h
> new file mode 100644
> index 0000000000..ba51d154e3
> --- /dev/null
> +++ b/pack-refs.h
> @@ -0,0 +1,22 @@
> +#ifndef PACK_REFS_H
> +#define PACK_REFS_H
> +
> +struct repository;

Let's add a newline here.

> +/*
> + * Shared usage string for options common to git-pack-refs(1)
> + * and git-refs-optimize(1). The command-specific part (e.g., "git refs optimize ")
> + * must be prepended by the caller.
> + */
> +#define PACK_REFS_OPTS \
> +	"[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"
> +
> +/*
> + * The core logic for pack-refs and its clones

And a dot after to terminate the sentence.

> + */
> +int pack_refs_core(int argc,
> +		   const char **argv,
> +		   const char *prefix,
> +		   struct repository *repo,
> +		   const char * const *usage_opts);
> +
> +#endif /* PACK_REFS_H */

Patrick
