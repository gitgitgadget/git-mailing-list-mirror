Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022449C4DD
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047354; cv=none; b=sZLP+FYfiBYcvKKA6sihpomxG0ZtZqv2sSVdZH0uNd2F0MxeLjrIhzxX1H4fUY+jX6P6LflGyFeIDNPLCED810DEkG4KTyPg9fjMk3sgUZCWXhQyA0OYn/VpCPBxsvQY5XYJUYSxUDyF5ENY4xaGoJCkjbzLArsP+HkNCYRctj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047354; c=relaxed/simple;
	bh=sgM80fYaf1zr456L7PlNCwORGc69MG4cEStfAreOo9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+gwG9L00f3akou2BzJ7ShTaYSeiXu+vF3VwMzwiquQvWuxkeBMgPRz6yrruYQdSGu/1+wasFj68C0mwVlCXv5FKk69fIUeC7rnPyTVlmef5Epmhwc+euxTMkQPCrF4j4bDR4sutQrj7C8KulDlPOSvOTzsKT1JI4p9AxEP01JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U0qeqmZU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/Oyvt12; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U0qeqmZU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/Oyvt12"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B5B11D00132
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:55:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 15 Oct 2026 02:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792047343; x=1792133743; bh=JoGFJxvAt0
	Mi2ZJnN3e/pvAYfaje+B7PX4Kg64+NGxU=; b=U0qeqmZUwuVuEUohkC+SkDUOe/
	vMMdfe83AXbsPGRwk/z2q2q5HZsEHOWUC5gKQf5m9ZqWzNRpB49JqBnWdjr+iwUQ
	bNXKsXPUIQu6quS8rnRg4x3pFI/qos7y2w2Y14+TdNxjYB2UGtLBG9YuqVveScY7
	c5A3IozKM2639q4PJc4cU4m6vNPZRLwK+qij98j4z9V5bsyBORGP0+KXOJxKbQmg
	qUlyPx170UkTW9Ulp3eL24v8upRXyqXEz6cqahi4YkGXJWAdggJl+Dvad/w0f6nb
	BO90S0OLDcyVhr5vo0HyujJsLasJViOeLyesXs/hbOiXIKFv46gIAv/EcQRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792047343; x=1792133743; bh=JoGFJxvAt0Mi2ZJnN3e/pvAYfaje+B7PX4K
	g64+NGxU=; b=j/Oyvt12+8ACdmPgdKTS9jSiKrI0tDIa8bOAIEZXvmC8f7b5PT9
	F3YaB1q1a/7u26dd2MYv9A0JZkwCYXOJIvR3BlImjX8SI4gNtHVUkD0eXl9aXXJ3
	xd/M8Sv4gBw9btJfncLRtabVjelynmm2TbSQ6tcMz9KGRNTwC+aacFfskak2Mk9E
	Fy/8H+raZeirvLjk8hF5mrMNfE9jVsZOJNry/4UN0/Ju32y6MxbGauV8a2h0ifua
	252iLMv+HgwZQ9U2bkBJsI3xxdly1GOE4SpnuzSswWRiBNKMSNmSJwKgJYbiA19K
	QTnq/mGjjWhI6iwoyj7Hv43/Ea+2PPbObwg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047343; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sGhkxVXe3gn/YLy8xpkN+Pw5gZeKO40wm/jBg5xdChFO8te
	q1v8Xu3FQpt1xBYVISgy1WWeHOkGC4W2sW/ArP9xkxH+J5k+jSskQVcXQggYtDM1
	8jIs5u05Qr+bsQCUXIEH+am3N6VKtfITR/gQ4URjeLtchwi/b4lkycFsaIxmUIQ6
	9ARXGqLpBFHjmVMQRRF/RC8tnTHds290SY5G1qR0FSSVh4H9wPzQwu5wvRxNhVOk
	lsXgeaBVQOUadz/PbD0AjJUanXymrVeavAbpoo4frCu1HvlDAwY5GbwRDPR2zz/k
	ULGQKNOIhA0blJGad4JYrg3WgEQT2GYtL4KQnQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iekMwD0Cuz5ndPJjnFe9fFyCcHFFiWUaOl5783Swp3E=:sgM80fYaf1zr456L7PlNCwORGc69MG4cEStfAreOo9k=;
X-ME-Sender: <xms:73jQat7X3FzVskoflLUceWGAZo9f27rt1at6YUdtAmEgBa7d5EFy9Q>
    <xme:73jQaiVVcyrjG6sbWGKvW0UzCgDwf6Cs80YeZZwGnp0xw2lFn2YAMv_tHeJ55Ay9a
    zrJSYdAfP7NtiNc9rveQntb-Up4PTqLafmde2nBLQj3BQ9GBZXO0Q>
X-ME-Received: <xmr:73jQah2HNHoeNyFgJUrwBM0FUyFkGAK87l_VemXmnI_GKkZIGl1sR9f8mA2RRo8JTl8ftyE>
X-ME-Proxy-Cause: dmFkZTGCaI+9vszqq7PsXJlDqnjG2KgY6aHgBkg9+/r8Wip7UnB70qswzRu9NL6bdamAkr
    UKC2T2ACjmHXbDsrpfdQsotbw5kKNACBHBKELLHSeLkiXjvRErtOkzezkpdnzW9jxgfODL
    4KZARb+uQSSBCxiKE9pOQ7Z7Tisauq44+0r57nu/CXl4HnMIeY5vKDqnN27WT4+epbACK1
    AL9YT3mcXVrUxULNtyansdtLUOX26O3qwdnwd9NAb01gYCZhX4UQyD3TGTPF87ohXwqzpl
    hbfb8jgZIJHrAIxSiH3Rf4aYZHXRzf9CwoZUSGp3lM6A+5tRiyd5vjb1mbna6R/+Go1BAH
    eNeN1EWVjnQt22LOPJ/p6YuZ+M/nenWz99EfKB5wLANdHqPJsrVyxCdUy7Rs0EOt7CEeA8
    +Fp0jv4WCopT1tipRQvk1Rpxd1FjQFwk7qzgYrXg+BUVba10ghiNNXsWd57JiNkQI7ac+C
    eaLeQEVqcLNHE8/aIggZOCUocsschnuRPu1wMWzbHFVk0vQJJjrYb1U6Q19YPC8W1fdgA4
    YBiaoS/viS0ng/K6QmCsZliQJmabf32QATLIwTYKimE7IiCv3VZAuZXHnhyBVwm2P3GVhO
    PmclDNYVfS1LgeBb9SX0POpZBEhQk1pUqdR3twnsfCdQi2X3xySrQSR7p1Jg
X-ME-Proxy: <xmx:73jQav0YSNdwGll7uTqoaEEPOZD84UXJk1r00ts6XcYoin1-OnyDDw>
    <xmx:73jQak9tw0nGiXjvs0qwnBiBci-1rdH8C5fG79td4phOyPkWNtvlUQ>
    <xmx:73jQas0F0E3Vn09rcPlbjxU0wEbFuAjdaATl2TW2XSoGIPUyk52-4g>
    <xmx:73jQah-wl5OE0nZPS8qCXUuPPWm3bERvrmQAz5DoBXROZ1W27qAhfw>
    <xmx:73jQalmoWolKeL7PdlqRmAK4RPT_UGR7DrjFoah0kqiki37a6EgXtE1q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:55:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f502440 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:55:42 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:55:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 2/4] p5413: add perf tests for connectivity check
Message-ID: <atB468yrVqsp9Eg6@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
 <211794c9252181fa0c31fcd968379c189d001a8c.1791806877.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211794c9252181fa0c31fcd968379c189d001a8c.1791806877.git.gitgitgadget@gmail.com>

On Mon, Oct 12, 2026 at 12:07:55PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> diff --git a/t/perf/generate-repo-p5413-connectivity-check.perl b/t/perf/generate-repo-p5413-connectivity-check.perl
> new file mode 100644
> index 0000000000..9546996280
> --- /dev/null
> +++ b/t/perf/generate-repo-p5413-connectivity-check.perl

All of the benchmarks will need to be marked with the PERL prerequisite.

> @@ -0,0 +1,44 @@
> +#!/usr/bin/perl
> +#
> +# Generate a fast-import stream for p5412 connectivity check benchmarks.
> +#
> +# Usage: generate-repo-p5412-connectivity-check.perl
> +#            <dirs> <files_per_dir> <commits> [<hot_dirs>] [<files_per_commit>]

These still say p5412, but it's p5413.

Patrick
