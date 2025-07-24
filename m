Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544A20487E
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336710; cv=none; b=QX2wxyywrEw4ixdfPllAG4rzaC7xjukn3xgwl8yGHHuCtWWuTMsaK6bbrvFuP0xqlNyMOMWNv433YQWKiP3NmK0QiOblccVNtN1/XQHUh8VbEkyQfQi5FG8/aqQ3HyKtJ3i3TdheLIs1H3wFnL8tzEF/MqSPvBXBc7JiNbnCNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336710; c=relaxed/simple;
	bh=38crzr6xcy/I+hIWBb42da71gA3LMuMfn9C7UJ0cvik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHhmZgoarcKldTrJA6ic85serRSKfAhDLDZw1+FlMx8mm/YEyy1i1bQ7LcFeKzBWXxG9kGGJt9VzwMR9NqsFn0d6bZ/AiUvMddpESeF/JyCwVNtzCZMXNa6ViwB85fhW/R/o9QSNQoeRJ9BVRQGFxRxOmBhp/xRfvApSJaOYHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mjTVPKYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2uEF975; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mjTVPKYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2uEF975"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B9517A0E2B;
	Thu, 24 Jul 2025 01:58:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 01:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753336706; x=1753423106; bh=rQKiTzNl15
	tO1YlzFp4trYMtzwx772+giwRiDfRawS0=; b=mjTVPKYEK9sDU4W5+fqOlHeV17
	5w7pzD3UCnBG0dguKZGidtZH8GUCGU9EoJUadthjqgjRTEzbpTaq7le7O/Ga/yG+
	JW8PfCwnQhmnNm4Z3d8ObKHHE7ZSVoOfWR8d05CEzdqPdun3ZKy4+ShSw0ulGNSb
	fhr1J5NDPzpqOyb6mBOadD+eBXywb+BIrIP0RYN1GaxJR9W64+G4nFnI/vGTOHdQ
	Y6jjZ+jRKOr3VaWxqyLjzOlDQ6jNfL7/f9RGALpgpsZo2r5IkWYTeXkY7PyTvNkV
	dDs4ofkjL9QtGCmnRR4mpm5PMI7LOAur6mkxxqvnSJTn4B9YWLb36YRsl6Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753336706; x=1753423106; bh=rQKiTzNl15tO1YlzFp4trYMtzwx772+giwR
	iDfRawS0=; b=J2uEF975KV6AzazZmMZ5fn3W3W8fUhcVu/SzHSTpHLWhgTzqsCW
	cBao/CMVGzU1CblM+/qdvzzhv2GXGigY09y49FLEgeQB4E/r5j2Agg8Vi5cPr5h1
	rbry5uqdJyV6YJ6zcXsbXwoOkD0NNTrVmlojVyfQu0/+plDfsc2s6Pj2E5g/fkW5
	ys22kFbrVREUX3zSm3AOll+ng3B0t58nBJdfFNX+t9WjUYa+y7UHmJFZazLU4jUB
	l++C53/TAL0yyZ+6wEry9lr9kKNzUgX6mCDcDniSJN5K32pi+5Tr5d09K+i+JJxR
	CJ8rxaPJ4RHMD7PuMJ2T9mVQd2wObinbWYg==
X-ME-Sender: <xms:gsuBaL1JZ5Znngvp7ZwKuy8PQBiHKWCx76Z8vKf73hothLm9u6owew>
    <xme:gsuBaG8IlD2c_l-mobnElhrS3Ijf-nu3sdiM1pAi2LmGLDJxc4bQOmXMyG86vhuhK
    LeWl6yKoBfJW0pA9Q>
X-ME-Received: <xmr:gsuBaLoGfE1E6CCQDFyqphDsHR9CGi_g11Fql16Hp13508LbaZWygIHe50uZa3Iol4vqIbKjE_6ihCq5xzQ7FgkuelnnyYWcWd-22Lu-ClU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:gsuBaAQp0mwI4yLN70tcJyarUPng7_AmZX6MfBdneSpb8r3Ujc7nbA>
    <xmx:gsuBaOPEpn8qjnaAHVvLc6q9QC2JUvbQDZKChwJJhLI-GYMo5XwDJQ>
    <xmx:gsuBaOjCMFNuPRdiwwJi_JAFW-tEqPqY22aNnQ2SUPjSNxnAW1Vrgw>
    <xmx:gsuBaLlTi5DHupqoMkoNXAJRQbbUYnttbwd9H7zOHVl4cU_YepezXg>
    <xmx:gsuBaNsXyutW8fphDdiXFaUqBVECOpAz5oKS1-sexCNaoqSLw8WEfxSM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 01:58:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3aa0e44e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 05:58:23 +0000 (UTC)
Date: Thu, 24 Jul 2025 07:58:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com,
	Taylor Blau <me@ttaylorr.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Victoria Dye <vdye@github.com>
Subject: Re: [GSoC][RFC PATCH v3 1/3] builtin/refs: add list subcommand
Message-ID: <aIHLdkhdVNy72Yf-@pks.im>
References: <20250717075009.26262-1-meetsoni3017@gmail.com>
 <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250723064313.29866-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723064313.29866-2-meetsoni3017@gmail.com>

On Wed, Jul 23, 2025 at 12:13:11PM +0530, Meet Soni wrote:
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index 5ef89fc0fe..f7bbc1902a 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc

Tiny nit, not worth a reroll by itself: it would have been nice to move
the extraction of the common options from our docs into a separate,
preparatory commit.

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 3d2207ec77..d7d8279049 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -16,11 +16,27 @@ static char const * const for_each_ref_usage[] = {
>  	NULL
>  };
>  
> +#define REFS_LIST_USAGE \
> +	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
> +	   "              [(--sort=<key>)...] [--format=<format>]\n" \
> +	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
> +	   "              [--points-at=<object>]\n" \
> +	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
> +	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
> +	   "              [--exclude=<pattern> ...]")
> +
> +static char const * const refs_list_usage[] = {
> +	REFS_LIST_USAGE,
> +	NULL
> +};

Shouldn't the usage strings for git-for-each-ref(1) and git-refs-list(1)
be the same, except for the command name?

>  int cmd_for_each_ref(int argc,
>  		     const char **argv,
>  		     const char *prefix,
>  		     struct repository *repo)
>  {
> +	int cmd_is_refs_list = !strcmp(argv[0], "refs list");
> +	const char *const *opt_usage = cmd_is_refs_list ? refs_list_usage : for_each_ref_usage;
>  	struct ref_sorting *sorting;
>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>  	int icase = 0, include_root_refs = 0, from_stdin = 0;

This follows the same pattern we have in "builtin/blame.c". It's not
exactly pretty that git-for-each-ref(1) is aware of git-refs(1) now, but
I think it's the pragmatic thing to do.

> diff --git a/builtin/refs.c b/builtin/refs.c
> index 998d2a2c1c..41e29d1b5f 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -13,6 +14,15 @@
>  #define REFS_VERIFY_USAGE \
>  	N_("git refs verify [--strict] [--verbose]")
>  
> +#define REFS_LIST_USAGE \
> +	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
> +	   "              [(--sort=<key>)...] [--format=<format>]\n" \
> +	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
> +	   "              [--points-at=<object>]\n" \
> +	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
> +	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
> +	   "              [--exclude=<pattern> ...]")
> +
>  static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>  			    struct repository *repo UNUSED)
>  {

Hm, this one is a bit unfortunate though, as it feels like it's just a
matter of time before the two `REFS_LIST_USAGE` defines drift apart.
Might be worth it to move them to a shared place.

Alternatively, we could pull out the logic of `cmd_for_each_ref()` into
a separate function that also receives the usage array. Not sure whether
that is worth the hassle though.

Another alternative would be to just say `git refs list [<options>]`.
This here 
