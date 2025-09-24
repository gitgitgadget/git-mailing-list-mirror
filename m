Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156C524F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695570; cv=none; b=LpzJSjilv3bgyR+hE2Ywb+hjp7g6HQulta+AjWQLC9EAbhWqIZXKjM7YxxTHBUAWCEe5EkzlMvCcZZUWL15HhjhEFdrPYEzA/of3i5CgnxNXeniblh6VGcl2o35mcZm6Dn2VdJs3qWWsN8ymd8PGZX5J8vzCHvZgve3sA3gg4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695570; c=relaxed/simple;
	bh=VhZ89SoKlRCRHk6U2Tkynyyhxr5cdomaFN727ZwRZl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heMjyEXG+pFwVgZ064wjFTxs3qdutaGOYrRLz8gJIw7q3ACj2du0qmWkQllR88mlhhIPFOcjm0uqE++kmJ/ylqn3GKT0JCdhkjyFKGaxPpFXagJXf78RBFLkHMUdzlbWe7TOOBGvzLUqTGZB6DNaiK9Kxre8HAmb9hGtRqyIpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n7n0kXrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhSaRUoU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n7n0kXrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhSaRUoU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A61841400070;
	Wed, 24 Sep 2025 02:32:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 02:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758695567; x=1758781967; bh=CqIRz65blr
	xMIqiQMjfkI/bMaC0Oi8MDZO/lx/MWfFY=; b=n7n0kXrAvwliLFC20bgZxhXBFC
	7xZKPH0FKOwDuletCIAldnMhvYPYEffTzZUf+gFHDDrBGcZwQNpSTIThlljry6pc
	Cyd43V10LIHuy/JzMxetOVJ6jl3/xRcslCBZe4RWLhGGi1Sx2gBnWQ+PLvAziUSL
	zSOrejGGY4R0W19ExrIoWH/v4vFmcOr7lwoJ6ket/hf7OrlE6MWiF0olHEJX7Up1
	JbHBjYWbXki1MC6HozM17dYZY6u7rbrp3WHWatGyDK7wakDHh9spQTLsNbUUahPI
	N/Rd5+a3qCJK9Dc2NOaRbf1BtBXGQedE6+53Hk5Txt9h6a4UHmzwGgKSCcfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758695567; x=1758781967; bh=CqIRz65blrxMIqiQMjfkI/bMaC0Oi8MDZO/
	lx/MWfFY=; b=YhSaRUoUID0bdvwTBtaONiMzJ1NUMMHGDT1Dzj7c/bfueX+NDDN
	6g4UeSTT8ca3Dhu+af2JongW5vYu6LqxJOE4AtQZyD9TcuY1v9KJN4ZNzZkzQvqG
	wrmIoqcZiEWpkgpwynxac4yoWuXsYFYBfW+eDA8H2xO/+SmqMZ0YD5vHifV1Qx69
	c0X+1QdOzrwRqb/wHQIJmYfbWWd3cBG0izkU1vfXtIi9VaJ7h4HB4Z4SpsWW2y9l
	w/u3DsKdzDja7nPfLLUuYvEZtcJdVEazUQhMq5dxZPJNSYXejnJvmHBdSMwIx+jY
	5O8SDGqplCe6KCwmM42BPLiDNtL6dpPBvPg==
X-ME-Sender: <xms:j5DTaDQ2K0pBvhMtsCqC0LDLXCpe1UM5yFMZjz5cWQnVhe8D2m72xA>
    <xme:j5DTaMPD2igzBI4JTHNwxMcgvVJZ_vnnLgTpBc_wcqntG2KVaroKSZPVBaIOaZS1W
    e3SgDYojld0EbguNidEVy8MKp-XN_ykKTZjIFtPhtfp1jlGT-S9y-Q>
X-ME-Received: <xmr:j5DTaGOUSLdsTCKvoFOSeVcBJ5l_ynfgHe2IrIEAqbhBgYkdpNJBe0FPOeqhPSHspjykIaplwvCUzUlKpwUqad13XWHZ9XiPVdXfGn2TcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjh
    hirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:j5DTaMujRs2FxF415OPifsK6eHvqZ2YaWVbtMYf4nVNUw2wk6UFYZQ>
    <xmx:j5DTaAWbwVHZcqlb43f6etP6g1NgIcKGIoKQ8WofEEr1nIF9RSFIgQ>
    <xmx:j5DTaEsA4wnZnXX5H5XD1e3edk1i-KtfgW_j69jcu1CavTDn_dHgyg>
    <xmx:j5DTaMWL4eRuR_TXQQzIn7Bw2ehSyrWdFdbjrJELa2IM9aHMExFhFQ>
    <xmx:j5DTaDrgeZCo6fd2LFBgSsVN3YzAVZM3e0K8SDi5VsLmKoNxoklYo2ud>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 02:32:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cfb6fa43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 06:32:46 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:32:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Message-ID: <aNOQi04mS0uXD4iv@pks.im>
References: <20250923104533.21165-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104533.21165-1-meetsoni3017@gmail.com>

On Tue, Sep 23, 2025 at 04:15:33PM +0530, Meet Soni wrote:
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index bfa9b3ea2d..f07fe8c864 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -19,6 +19,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [(--exclude=<pattern>)...] [--start-after=<marker>]
>  		   [ --stdin | (<pattern>...)]
>  git refs exists <ref>
> +git refs get <ref>
>  
>  DESCRIPTION
>  -----------
> @@ -45,6 +46,12 @@ exists::
>  	failed with an error other than the reference being missing. This does
>  	not verify whether the reference resolves to an actual object.
>  
> +get::
> +	Reads the raw value of a single, exact reference. Instead of

Let's say "fully qualified" instead of "exact".

> +	recursively dereferencing symbolic references, this command prints the
> +	direct target of the symref (e.g., ref: refs/heads/main). For regular
> +	references, it prints the object ID (SHA-1) they point to.

I'd drop the reference to SHA1 here, as it may be any object hash.

> diff --git a/builtin/refs.c b/builtin/refs.c
> index 91548783b7..b473a78e18 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -159,6 +163,43 @@ static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
>  	return ret;
>  }
>  
> +static int cmd_refs_get(int argc, const char **argv, const char *prefix,
> +			struct repository *repo UNUSED)
> +{
> +	const char *refname;
> +	struct object_id oid;
> +	unsigned int type;
> +	int failure_errno = 0;
> +	struct strbuf referent = STRBUF_INIT;

Tiny nit: we typically order variables that aren't accessed by options
after the options array.

> +	const char * const exists_usage[] = {
> +		REFS_EXISTS_USAGE,
> +		NULL,
> +	};
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
> +	if (argc != 1)
> +		die("refs get requires exactly one reference");

This should be translatable. Furthermore, we can probably use `usagef()`
instead to have a "usage:" prefix instead of "fatal:".

> +	refname = *argv++;
> +	if (refs_read_raw_ref(get_main_ref_store(the_repository), refname,
> +			      &oid, &referent, &type, &failure_errno)) {
> +		die("'%s' - not a valid ref", refname);

We should discern by `failure_errno` here. Most importantly, I think we
should handle `ENOENT` and `EISDIR` specially to both mean that the
reference does not exist. So, e.g.:

	if (refs_read_raw_ref(get_main_ref_store(the_repository), refname,
			      &oid, &referent, &type, &failure_errno)) {
		if (failure_errno == ENOENT || failure_errno == EISDIR)
			die(_("reference does not exist"));
		else
			die_errno(_("failed to look up reference"));
	}

> +	}
> +
> +	if (type & REF_ISSYMREF) {
> +		printf("ref: %s\n", referent.buf);
> +	} else {
> +		printf("%s\n", oid_to_hex(&oid));
> +	}

We can drop the curly braces around single-line bodies.

Patrick
