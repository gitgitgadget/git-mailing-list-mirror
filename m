Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F122882B0
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781750; cv=none; b=Tb/q6CrSeKnr/X1M2yAN9+hFI38iIt8lND6S8I5+IPzzD52fpceRFLiRvUxdPbzX7xFwEzm4A3sLBmcFVtHVTQBnIKL1WzV2QRAi5lGvJEdptJ/Ez9cr9cK2PO+vyFuy/YW+uQ46sEyH1ksnC6OXOXiPF0lI+AtKBx9qKBawCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781750; c=relaxed/simple;
	bh=9sxp/gQW58ZRSKAgcyAPhQu8c8YzeCOz87lY9n/V9p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF2L9j0IlHzbKL1+A1ai7Lx9yWj6mueBonmcuPzvitrK1osiloUDkmEaPpXXyqqkBpg5OuR5GlpUXjBxE5g5fq+D5ZP4C2uPGAWKcqmcC1n6cMvC6cV5BxZfw8VrdtRaLtYsfo3agH2ohk9RSSaYlvX6+x0rwr5VOgjioeOCIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jL5srAAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJl4Eo6K; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jL5srAAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJl4Eo6K"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A60257A0CE6;
	Tue, 29 Jul 2025 05:35:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 05:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753781747; x=1753868147; bh=1vWJzLpYs/
	+R3326xXZPn3LV6+wKwjm4D9p0Q06fczE=; b=jL5srAANAelgGdSxqaHDyIYbVk
	Ub1bmQpEq71zGBc+1LLURh7RbTewOQZpyczpBg9+1c/zCOn9RYOHkqem09k8Gz2M
	xS4R849SATdpMZPEDIrlag5hzHHnpC6zMetMImSB2XHrMf7vdVyEu+H/PzeYUycI
	g+8iMGxdku2NoTaSf8JYFynEPqoaWZy4f3VGtnf1blhOyVj3q4K7DuQy7NBS9hvp
	jL75/zy2Q9S1VMgZkmHMFkYcuRN2R6HmZEhz8spBlWgGCSXr7nRksGE8IoheL67W
	FZXZ5zNiBAFPQUlW8j0Na6WbyviW/4hPHoh5lDmrtVOURdei9A9jyqIHUCLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753781747; x=1753868147; bh=1vWJzLpYs/+R3326xXZPn3LV6+wKwjm4D9p
	0Q06fczE=; b=fJl4Eo6KuA1u17D+08aTD1jiQxPrIPTsjmNRP989QsegohuPGn6
	HCxCckoPntCtXZp3XaAAVjpwBIgiylpgI10h1lOtqo+AW745r7z6jS1PE6FWK/F6
	01YTVgAm8/2rvSKXx3t7kTK9KMkUmakcAk2YK6vvEB2Btcyfrt97ZcKF5jC/b0qL
	HOkPHk40zSkBnKVBywvXD1vd5tAv0Qxk7/zyFJuCBSuQoaOxmdS+84+15YJRhGat
	58mtHkqdjGLWL/hexmQwM0ostMJUHXwJX8DOg/gbNcDYMsTh/BjTGiwvj8Z5XwmO
	1BkCasM+RfDsScC5zBLH+TC0UnWTzuipsUA==
X-ME-Sender: <xms:85WIaCLH_ugbvU5oCrC3QJjYVcjb3OaCMkrF4zj7RPt8Bbfk2W_2-A>
    <xme:85WIaEyFO6yEkTZo9fp4YHBuXxOf3TgzmPOWCualblwZVBZpfFBfOxBa_absBxAsc
    Afcq3_GXQq-_5F7dQ>
X-ME-Received: <xmr:85WIaIu_y6pDn3McuW7Ih_bS5iS37AByajHd9L1JsGuOQhlLKtezxn6AdGtsp5uP8nN5rUS5snQZnBCHiMpNyyVOxwh-gibxgGR5ZQbxvhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehoshifrghlugdrsg
    huugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:85WIaHBsAq5iC5z3521_D1WYErRluJajUn8c8Iy80_lW5iuQc0xIuA>
    <xmx:85WIaKGygNM6i-Wwm7aM0BimNzHQzt6P9GE34JaC0g82ouB7ALtm5Q>
    <xmx:85WIaHDtWmwFd_ZG2jzkOumVWll8YrEQu8d6TcMC_KqIiT--E1S2sA>
    <xmx:85WIaAm6vgdosVtU1DgKsG0uRSaI-PDpjoDKwS4saNeyakV21NPBeg>
    <xmx:85WIaNpWVxbXNSGQ81gj0icXiYH-oLb694QHixfU0dbS0Yj8Jqz7nHSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 05:35:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39fd3f06 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 09:35:44 +0000 (UTC)
Date: Tue, 29 Jul 2025 11:35:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
Message-ID: <aIiV7cz2Tx50JZUv@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727175110.84770-3-lucasseikioshiro@gmail.com>

On Sun, Jul 27, 2025 at 02:51:07PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index d4f01e35e2..02d5821c77 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,12 +1,90 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "refs.h"
> +#include "strbuf.h"
>  
> -static int repo_info(int argc UNUSED, const char **argv UNUSED,
> -		     const char *prefix UNUSED, struct repository *repo UNUSED)
> +typedef int get_value_fn(struct repository *repo, struct strbuf *buf);

Nice, this now uses a strbuf as recommended.

> +struct field {
> +	const char *key;
> +	get_value_fn *get_value;
> +};
> +
> +static int get_references_format(struct repository *repo, struct strbuf *buf)
> +{
> +	strbuf_addstr(buf,
> +		      ref_storage_format_to_name(repo->ref_storage_format));
> +	return 0;
> +}

And this prints into the buffer diretcly. Makes sense.

[snip]
> +static int print_fields(int argc, const char **argv, struct repository *repo)
> +{
> +	const char *last = "";
> +
> +	QSORT(argv, argc, qsort_strcmp);
> +
> +	for (int i = 0; i < argc; i++) {
> +		get_value_fn *get_value;
> +		const char *key = argv[i];
> +		struct strbuf value;

Let's declare the strbuf outside of the loop and `strbuf_reset()` it on
every iteration.

> +
> +		if (!strcmp(key, last))
> +			continue;
> +
> +		strbuf_init(&value, 64);

I don't think we should explicitly initialize it with a specific
capacity. Let's just use `STRBUF_INIT`.

> +		get_value = get_value_fn_for_key(key);
> +
> +		if (!get_value) {
> +			strbuf_release(&value);
> +			return error(_("key '%s' not found"), key);
> +		}
> +
> +		get_value(repo, &value);
> +		printf("%s=%s\n", key, value.buf);
> +		last = key;
> +		strbuf_release(&value);

And the call to `strbuf_release()` should be moved to the end of this
function so that we know to reuse the buffer. The above early return
would then be converted into a `goto out` so that we have a common exit
path where we know to clean up all resources.

Patrick
