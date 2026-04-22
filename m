Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F83CF680
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856561; cv=none; b=LMX+hzpV19jPdSOr92aSPI8ekQgIZ5sehJiNe0OzEc9exuARQgdkv33DNuMYWa51FCMaK5K5GOVDHBHJmOJ3U+uqcbKlsCBg0JcJ3LFxBwpronRoS67HljAFLOqqpDs5WXEGLPTjtNsV6d11h8eSg/UoN0Y3uzUOx3yBhwn+Ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856561; c=relaxed/simple;
	bh=iPAKRd0QOxGCBCjnUC782RvmeovWch03wzSw01Cne7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQmjftjYF373p6EBz2xIaoUzIJe+Y5rDHaIlTRYGmee+JbxLsGM/7NVxMpziDbJd7E2fxo9mznkj+xadaUcDWpMV//1YssxKiAa8hSBq9yogOrvRBTCKAraNDf7V97Kw/TGDi7xly0RX9/Ba5qCqki3+8T5l5IIdZ2dwhQCSMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zngxgWd/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOBS9R0G; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zngxgWd/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOBS9R0G"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5373F1D00237;
	Wed, 22 Apr 2026 07:15:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Apr 2026 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776856557; x=1776942957; bh=v6OsZKfJ7n
	9W4yxDNv3u2V/388xXBRgiW/BKLadenP0=; b=zngxgWd/ezg5lcAgTBVrUKZSlD
	RAiA4Q/6jMbt6yav4sbDEUlezIo10cORPtXKXvqQ6qogzjycD6qxDRS63IG2YwaL
	qsRyas25nGkQ+/x/212+gfafoNyhfQbqoTgaCHBSk75pQLcc5qct3qWfESuSxGoE
	mo1sWtOnFCkWpcsNNROLYqCzonJIs3lmuPhCRNaR0MmAxZgf2k050Po1DF7MHg3F
	ZoQRkzHpSeNQZZq0WOCsfwY9FduZ1LYaPtB9rBbQ0e9PYQOucivg6R3NExsxB8Oi
	4SNtG1kJSsCSoxQ7t4gXzKgOtWaFnRKxwj2A6KplVp2cYVa84H1Tsj63flyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776856557; x=1776942957; bh=v6OsZKfJ7n9W4yxDNv3u2V/388xXBRgiW/B
	KLadenP0=; b=ZOBS9R0GU+qfGzr3ECKOK/6PmWjL1c8ZlKj9VE+onypqEF5xYbb
	BxDEqyws9gsxMfxT2vCXKN6faBHwyXZ/r6vNR6m+22p8HFnIn4TW+FmZ9bZjh03Z
	lFoqsS/twiu3DenShbJUTNwCTzMtEe+GgwLWgimWr/0BfJO1zOxypHwIW0a7hTC5
	B8KtGEXKYleIx/kDXZGg+f0Bga2F057cc64sQAq7TFItRkUF7FQ3LPfcgWrfaLZZ
	rGQHbZyaQSgPg0SYA0k/7DobJuC0ePAJymbfXHA0I2gdWzb5X7pszGVf1DcAmzhV
	LSGiVCW077jjyrMj1rnEw+Sl+fOCvSxRXLg==
X-ME-Sender: <xms:7a3oaZo7YAfnXITvWUDonirSnFOJjjdFiG3OGb2ayaF3-gD5moYZ4g>
    <xme:7a3oaRpcEfCWj7e-6Duo8M8ttjZt0eSbL5tP7g55h9zEtVAE0Mebdrn-OwJYLME5p
    EAp22PhG8WZT5b8G_PgbhEbvzgnvwLsxrktpDpzPJuB3l2bYxOF6A>
X-ME-Received: <xmr:7a3oaT2JZHgwRfSis5MNjG0hiuCGqwOENZCNyoeSmS2m0jE9bqPAFgahjf2agYP9RSe-8VxiCwDi1bP0qkC_Ofa1WLCOK088YACOEiGEAzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7a3oaQCGMSjSCdrQQ6FCJzmDHw7qcGWr-8bzlvCiOKllsz7azkSe3g>
    <xmx:7a3oabeLQA30v1NRUXWh196HevCF1J5ZeVRJ5rVrNGK_Ry9wZK-vsw>
    <xmx:7a3oaVjSTb59xfxmijhj-6H64FuGs15cSpQT5BY1X9_mxzhTn3wSGg>
    <xmx:7a3oaTpS0gYN7qZl56vXshqevG3fJNabv_ihpPLehAZANY3MJ2ALmg>
    <xmx:7a3oaTbgx8afmsdLq8l_LC_gvrL-Ea2z9g_3lb5J-lxYhzP5UCeSycd8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:15:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60edd078 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 11:15:55 +0000 (UTC)
Date: Wed, 22 Apr 2026 13:15:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] update-ref: handle rejections while adding updates
Message-ID: <aeit6Ic4fUa3Xx1Z@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-5-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-5-513e354f376b@gmail.com>

On Mon, Apr 20, 2026 at 12:12:03PM +0200, Karthik Nayak wrote:
> When using git-update-ref(1) with the '--batch-updates' flag, updates
> rejected by the reference backend are displayed to the user while other
> updates are applied. This only applies during the committing of the

Nit: s/committing/commit phase/

> transaction.
> 
> In the following commits, we'll also extend `ref_transaction_update()`
> to reject updates before even a transaction is prepared/committed. In

The "even" reads like it's at the wrong position.

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 5259cc7226..d1980c60c4 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -268,11 +277,13 @@ static void print_rejected_refs(const char *refname,
>   */
>  
>  static void parse_cmd_update(struct ref_transaction *transaction,
> -			     const char *next, const char *end)
> +			     const char *next, const char *end,
> +			     struct command_options *opts)

Here you follow my earlier suggestion of using `_options` for the struct
name, but `opts` for the variable :)

> @@ -289,11 +300,18 @@ static void parse_cmd_update(struct ref_transaction *transaction,
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> -	if (ref_transaction_update(transaction, refname,
> -				   &new_oid, have_old ? &old_oid : NULL,
> -				   NULL, NULL,
> -				   update_flags | create_reflog_flag,
> -				   msg, &err))
> +	tx_err = ref_transaction_update(transaction, refname,
> +					&new_oid, have_old ? &old_oid : NULL,
> +					NULL, NULL,
> +					update_flags | create_reflog_flag,
> +					msg, &err);
> +
> +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
> +	    opts->allow_update_failures)
> +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
> +				    &new_oid, NULL, NULL, tx_err, err.buf,
> +				    NULL);
> +	else if (tx_err)
>  		die("%s", err.buf);
>  
>  	update_flags = default_flags;

I think this could use some curly braces to become easier to read, even
if it's only single-line statements.

Does this change have an impact on the ordering the user sees for
printed errors? If so, it might make sense to point that out in the
commit message.

> @@ -341,12 +361,19 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
>  	if (*next != line_termination)
>  		die("symref-update %s: extra input: %s", refname, next);
>  
> -	if (ref_transaction_update(transaction, refname, NULL,
> -				   have_old_oid ? &old_oid : NULL,
> -				   new_target,
> -				   have_old_oid ? NULL : old_target,
> -				   update_flags | create_reflog_flag,
> -				   msg, &err))
> +	tx_err = ref_transaction_update(transaction, refname, NULL,
> +					have_old_oid ? &old_oid : NULL,
> +					new_target,
> +					have_old_oid ? NULL : old_target,
> +					update_flags | create_reflog_flag,
> +					msg, &err);
> +
> +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
> +	    opts->allow_update_failures)
> +		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
> +				    NULL, have_old_oid ? NULL : old_target,
> +				    new_target, tx_err, err.buf, NULL);
> +	else if (tx_err)
>  		die("%s", err.buf);
>  
>  	update_flags = default_flags;

Same here, curly braces might help readability.

> @@ -644,6 +680,10 @@ static void update_refs_stdin(unsigned int flags)
>  	struct ref_transaction *transaction;
>  	int i, j;
>  
> +	struct command_options opts = {
> +		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
> +	};
> +
>  	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
>  						  flags, &err);
>  	if (!transaction)

Suggestion, please feel free to ignore: we could also pass the flags
directly instead.

Patrick
