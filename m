Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F92253A4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944780; cv=none; b=mmkSMwTuLdqNOZ+ZvIxeZEHm8SUTaBOchQHVeEiraDE9CnpgLnqEGtCxxufpuZWsURiSjet627hUFtpaXE9Mf1xFI0YWBFFiZiOGlWtQSCxX1pA67eBD3PL6ROWcF3qFIeEaBxDgOgRzLqw9C+utOy7ozxBDn4kKiVJXZaNR0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944780; c=relaxed/simple;
	bh=O3Rs+Dxrp0plFcMAE577zbz4+LvpUo6t55R1UlhXHLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiZvqwvcnexGfEkBFuARvIkjmFvaqn4Oe97Y/Okyc6hLq9ldMz0Udw2D4FnR594GmiiLb5Ts4tEpVIDetWsW3nAnpTWGa/RwWEeQw9D/QXHgQQAPayO+bYdEFEFbD7KoSsoSx4thGD6C2nhUIw8V5wWE0PC1d5JJ+l1k6wA98wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b+7qT0EI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxnmJbFn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b+7qT0EI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxnmJbFn"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40B652540143;
	Fri,  7 Feb 2025 11:12:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 07 Feb 2025 11:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738944778; x=1739031178; bh=HXT+qs4tRn
	ec/lL8yd3DQLlacrWF7we8l2nt8xx1ABo=; b=b+7qT0EIX6E0hu2Fr52yUTcQLe
	Sl7myxWC1TK355p16UuOlOahBjnZ2n3mSqSUXDjN8YHtoImrICW0JvWtUia8l0Lf
	bl37r4b9S8rsMx+Ul0018xFLFe6NDakuxrahD9X+Krt309v1M1OaFYZo4V9Cp8kb
	NpTiM7xiO6IOuY7Izh+UdlqYcufgU8Z2THBoglg2Fm3efzY9dGs+CbFQrq474cwL
	BDRQs2rZFg3IWF9RLUu5ngaXFrPb2g8R9YP94BLCGhqPIkBNIsNCpgEoDtTnGj9D
	c9nvfdIkSgaLOXcZDNtEEjUvLALZQD80oVk/fBwo29PgaxGIEWFVNL8n6MJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738944778; x=1739031178; bh=HXT+qs4tRnec/lL8yd3DQLlacrWF7we8l2n
	t8xx1ABo=; b=hxnmJbFnOB0AUGK1GvqZnY4yl2+0OdLprcIc9kZkd1TeG0Ij6OX
	jwliJ7f+gcGo2t2wQ612q57+rTUTGOKGbjGXZfrYtDbGG79uV7KulJWUwHwVLvLs
	vtye/eDlpQFJlYXO1dpkvaC7ijzxedyWOrdeGtiwO2Jv2vBoayoaT7OrGtIcnDSZ
	VMCpw0X5SDaheG3Mhgxl6tAhc8q9CZ0QhuJvLtQCgHEfZT60zSgTB2/c9mkXr8qJ
	0i4R1bpjnixWa9QXBiQnN0DqxvGgnqEI2ZgSnWESzuXp3EIhhQOrDm48gE5kanse
	3mCNT/NiiSH/k1tPyKray0j4LayS0fPHymg==
X-ME-Sender: <xms:CTGmZ5mMtePJ3vZATzTIHdBSNWeN6VumvavOVVWDXZob3We1dtKddQ>
    <xme:CTGmZ01voKPxflmUniF0DlHOJUH8No6gXViCr37kngGfALhLdHsE7d0BBfjZFQS24
    g3drg6wIhlLPFScXg>
X-ME-Received: <xmr:CTGmZ_rpqicZ1g1awv6X41zNZz8v5kUnhNN1ZgtkCqUORWYx7YJNOpM_IJdB6mogzweCLT5fBZIl2WP0_bL1JCg4g9gTe12yf8g8juQoPTbhx62H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CTGmZ5mnVzUG2-_T_vDNqqh5lUTLzvDmhiyQtMi_foNZUZX1n8CsFg>
    <xmx:CTGmZ32WNeIEMobjKOpHSUjZTL3KYlzFUbSzaVohkaFClMZMMAQyLQ>
    <xmx:CTGmZ4v9Jxj22cq5r6hE4MC5SxLvkPGZh9YOAZBRuixCjWr8DMHd-w>
    <xmx:CTGmZ7Vnk--QC6EVFkFaIJwPf6x4gm__OobymAKXkiLRZxsfAWOpew>
    <xmx:CjGmZ4xpYNPpcCNliw7XNdhfxaQjyqH27R7Xp9zIAqXBLHDyFaBc8RDo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 11:12:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d8f95b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 16:12:56 +0000 (UTC)
Date: Fri, 7 Feb 2025 17:12:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 6/6] update-ref: add --allow-partial flag for stdin mode
Message-ID: <Z6YxB6qL8WQFZyWW@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-6-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-6-e6a3690ff23a@gmail.com>

On Fri, Feb 07, 2025 at 08:34:41AM +0100, Karthik Nayak wrote:
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 9e6935d38d031b4890135e0cce36fffcc349ac1d..529d3c15404cdc13216219fba6f56dde91f4909c 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
>  SYNOPSIS
>  --------
>  [verse]
> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
> +'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z] [--allow-partial])

I think it's time that we start to split this line into multiple lines :)

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 4d35bdc4b4b57937112e6c4c9740420b1f1771e5..83dcb7d8d73f423226c36b61374c86c6b29ec756 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -562,6 +563,30 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
>  	report_ok("abort");
>  }
>  
> +static void print_rejected_refs(const char *refname,
> +				const struct object_id *old_oid,
> +				const struct object_id *new_oid,
> +				const char *old_target,
> +				const char *new_target,
> +				const struct strbuf *reason,
> +				void *cb_data UNUSED)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	char space = ' ';
> +
> +	if (!line_termination)
> +		space = line_termination;
> +
> +	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,

Whew, that's a lot of placeholders.

> @@ -723,7 +754,8 @@ int cmd_update_ref(int argc,
>  	const char *refname, *oldval;
>  	struct object_id oid, oldoid;
>  	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
> -	int create_reflog = 0;
> +	int create_reflog = 0, allow_partial = 0;
> +
>  	struct option options[] = {
>  		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
>  		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
> @@ -732,6 +764,7 @@ int cmd_update_ref(int argc,
>  		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>  		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>  		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
> +		OPT_BOOL('0', "allow-partial", &allow_partial, N_("allow partial transactions")),

You can use `OPT_BIT()` to set a specific bit in a flags field..

> @@ -749,13 +782,19 @@ int cmd_update_ref(int argc,
>  	}
>  
>  	if (read_stdin) {
> +		unsigned int flags = 0;
> +
> +		if (allow_partial)
> +			flags |= REF_TRANSACTION_ALLOW_PARTIAL;
> +
>  		if (delete || argc > 0)
>  			usage_with_options(git_update_ref_usage, options);
>  		if (end_null)
>  			line_termination = '\0';
> -		update_refs_stdin();
> +		update_refs_stdin(flags);
>  		return 0;
> -	}
> +	} else if (allow_partial)
> +		die("--allow-partial can only be used with --stdin");
>  
>  	if (end_null)
>  		usage_with_options(git_update_ref_usage, options);

The implementation is quite simple, nice.

Patrick
