Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C114188715
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694733; cv=none; b=fSSnxWzROVIhOEHdM/JUQJo1D6TejEJyoM/7GMJ5MZQG0p3YDidcY5yIJQCa/EaOBWyAywCx1rdxug/ukbAVGS7/QMcon/ImvnUkU0VHSkE5r9zTDiqeoMD+DiR17VrsmokQoEIfvti0ZGvfvB1CorT60eEcGoBRJgWqTYEac9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694733; c=relaxed/simple;
	bh=NPq+RuPVumFqkM6rDZvsnnrtTLeN/qL/fAGYS2iI/J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ5vSxiX17PH05dHE1rvejDKUEFmZz9BRfD20k96UV1NXco0lA6SPPPSJtWx5oGqZRygZq9dsqppvJurn/HrSxaj6VxpIAcM8wZup2qd6c3/izItQhbz1ONriXm0P9gRuoGwUoEx4J6YcyzHNkqQGhhrafJB1Tka+zhgrJC5RxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c6ClDnQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnLDE+Ip; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c6ClDnQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnLDE+Ip"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BE5B3EC00C7;
	Wed, 24 Sep 2025 02:18:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 02:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758694730; x=1758781130; bh=DhUKPtilf4
	C2Ej+MWWbK3ryN4khWVamq3tWLLvrH+IE=; b=c6ClDnQoY1lShlpDwbcBjlsq1S
	wELoi7KbJXNfJ6NMAcBcUFPBH0fQtlsftC2lCbusPpiXkkRId1EfP6LWjgdDfpyU
	U+cpCwIxi6wY1pyMbnQzj/GkmMQ3p1NND3pc/O/koXmpqVKA8mFvjtda1FyGLe8t
	VKDlON9L/3Oav1EDu44a29GRGvLDtym+exikkH+xSf+/9xyt1hD0Jv0I7eccE0rF
	YEALwPSV77ZJE8GZwSTam6ShCZYQfHU7PvY/nHywzdrTlMZNDCKpoTt/QTHV1fbA
	LimIJpIbzRQ1s5Sk/eJSePlfCmbAS1ycKDIXFjv2M4tlvrgEK5YS+uwS8Qkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758694730; x=1758781130; bh=DhUKPtilf4C2Ej+MWWbK3ryN4khWVamq3tW
	LLvrH+IE=; b=XnLDE+IpwqTBySWACMpRG83/tj1ew6wPYMBo6Z7vNLyygUh29hn
	2CiEFrxRGg4Kop/F9O8/2seCgfv1ynxNVxtgc1K84hUqRmp5LYaOQ9Qh7KhDC+70
	vsTSvP7ZEZBKYH/g7aaCQiFgPEl7XucGOrNCtkpbZp5sUKszV42jEDH61F6mXrhD
	bIePRvurZ74S3Ck19dpas8I3yhhma0nKAxws125ZJZE5iATGCd3FO14vOaxEbQUa
	di1IoD/FuNWI5tizVCotjc85Q6wUgrt8No7xwKKKs/TTrNopejb7xCox2t3RCdNm
	fJaSiqzgNErC6IGLWne4WsEoj7GZGz56HuQ==
X-ME-Sender: <xms:So3TaJYNeXmHDIs86J2IVqLN-Qo23xOooX1kawaTsR-lF1S7vubTQg>
    <xme:So3TaHZNNnhvuSFYQn9neI8XT_h_rTYV43KhpSL86ctCmGUIOFfoj54631MLrDAJZ
    QUrcE7NDRMbhxx8aDs7eOtl7gko3kFNy0ibzfE64Fq6qk8GAqM4>
X-ME-Received: <xmr:So3TaA8NaSObuggF2rBT9SudknWOV9yY8XaLdwKmWtvKn58aHb3H9fHfNR4PMMFym8fstYiV-eZn735xkKHdyiXOtHK0Z16iBsp-pf19Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:So3TaGgXalq_rGUqlDBf0ilDkGhQXZaQTgTQBZx713U9ATiNLQsdaQ>
    <xmx:So3TaAedVEFjtpWjJVTNcNba7pVSj0quqZSq8ecy7YIKWs8qNr23xw>
    <xmx:So3TaNpzJfnlr9LxfwKDORs1Y4WN02TzMMUtNgTRh10sFKS561Xggw>
    <xmx:So3TaFBD6xsks6X6qLzoh6U9BDwsc5GRINnstg2uWnh733K-83mAfw>
    <xmx:So3TaAd8ioIAbl9rdXAps_gK82nSSi9cTVjxNHUzmNpGW2P7MvnAjB-7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 02:18:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d43b94e4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 06:18:48 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:18:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v4 5/9] builtin/pack-refs: factor out core logic
 into a shared library
Message-ID: <aNONRY10f6R-3Il0@pks.im>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
 <20250919082647.535213-6-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919082647.535213-6-meetsoni3017@gmail.com>

On Fri, Sep 19, 2025 at 01:56:43PM +0530, Meet Soni wrote:
> The implementation of `git pack-refs` is monolithic within
> `cmd_pack_refs()`, making it impossible to share its logic with other
> commands. To enable code reuse for the upcoming `git refs optimize`
> subcommand, refactor the core logic into a shared helper function.
> 
> Split the original `builtin/pack-refs.c` file into two parts:
> 
> - A new shared library file, `pack-refs.c`, which contains the
>   core option parsing and packing logic in a new `pack_refs_core()`
>   helper function.

Should we maybe host that file in "refs/pack.c"? This ensures that all
ref-related infra continues to sit in one place. We could also build on
your previous steps and call it "refs/optimize.c" right away.

> diff --git a/pack-refs.c b/pack-refs.c
> new file mode 100644
> index 0000000000..1a5e07d8b8
> --- /dev/null
> +++ b/pack-refs.c
> @@ -0,0 +1,56 @@
> +#include "builtin.h"
> +#include "config.h"
> +#include "environment.h"
> +#include "pack-refs.h"
> +#include "parse-options.h"
> +#include "refs.h"
> +#include "revision.h"
> +
> +int pack_refs_core(int argc,

If we want to go with "refs/optimize.c" I'd call this
`refs_optimize_core()`.

> diff --git a/pack-refs.h b/pack-refs.h
> new file mode 100644
> index 0000000000..5de27e7da8
> --- /dev/null
> +++ b/pack-refs.h
> @@ -0,0 +1,23 @@
> +#ifndef PACK_REFS_H
> +#define PACK_REFS_H
> +
> +struct repository;
> +
> +/*
> + * Shared usage string for options common to git-pack-refs(1)
> + * and git-refs-optimize(1). The command-specific part (e.g., "git refs optimize ")
> + * must be prepended by the caller.
> + */
> +#define PACK_REFS_OPTS \

This would become `REFS_OPTIMIZE_OPTS`.

> +	"[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"
> +
> +/*
> + * The core logic for pack-refs and its clones.
> + */
> +int pack_refs_core(int argc,
> +		   const char **argv,
> +		   const char *prefix,
> +		   struct repository *repo,
> +		   const char * const *usage_opts);
> +
> +#endif /* PACK_REFS_H */

Patrick
