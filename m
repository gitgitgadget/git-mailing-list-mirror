Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0433F20ED
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042634; cv=none; b=p0ZUZBc1B5BpOIJkwDRpEaumhSCX+/wEZ+gEwOk49TRUQocb+WzVQLXukWkHwAxxV9UzTNGBJQ+l5N7om4ggqmjXlj9ChxbD2GHAr0N1CrOzfJn4OKZ9oHgU560tPrtuIb9DwyNRI6xZxtHJ1C3kEmsgNxoTe/R1LjGZlyMWffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042634; c=relaxed/simple;
	bh=7+N56wpt/dAdeI1H6NwM2uKRaepH8Su9IkGfc8XkpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqNY1Sqc8m9Q+ldtuf6pTPl8GY9M/YAyiwVdztDaE16b8Pr6Qiji6BpvkfAwSqh8zkbwOj9UXkSFT5MutOV2hZUMtLkKYLKcYpOmwhpaCWMkjmsdMeFtUrNQ+KBB+Yxt9R35t3fB/3401CRa7KURAxDWcVbOZs+mBDqJu6YdDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=okeHHblc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNJkH7LM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okeHHblc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNJkH7LM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F6B07A0312;
	Wed,  1 Apr 2026 07:23:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Apr 2026 07:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775042632; x=1775129032; bh=zcJVk8g4WT
	hCbCo3D+1nev+c4+UwUAlczCkzmA+/TzM=; b=okeHHblcIwnwz5ag2rLIuSt0aB
	u3QD9hcm4VBhXkLKGaR9Q3TmTPrlX+qdFWGHK8eHzBQAaDIxzKwR744/8rhfP7y7
	OB14UalS2PK2jPJj3yIgtQx4O3nbvee39bc6nmFhsx0bI+ZWUGKVjBfMI9gCP2Wv
	krhSMv4QmdTJoRvqazsn6IUbTJubGjjVG+Ql/ND6i60NRS9XQHbV+NdH+lOHZE11
	R5Nzwfddt3bGivv2pS2M1clmMokjjymLDLS6SMrJk/MQrcobxnd3dHYm3t3nfW1w
	9mnAUKs4EjuNJ5YraxzoguDS4Xl+fkSUOyYrkyIVaedgeM98IYW6wDGrcC4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775042632; x=1775129032; bh=zcJVk8g4WThCbCo3D+1nev+c4+UwUAlczCk
	zmA+/TzM=; b=QNJkH7LMMLzA6MY68eugFWNF+G4XQufBVaiyVrPOoPEmZYLRh1S
	jJUirEaUYhJJNua1CYDx+V9WiuB/5+96dPnCGQOGJySkO0pOPMk+k6AlzAb/3WvM
	W5mPQaHkinSR3SJmS38HBVJ6tjDcV6+I6uPvuzRmj/xBM8IaJOY54iyvpsULJ15x
	dwxTBtymWQc02xsJEADjcRqKlOYm5kMRqLCboaReUqjnevk5kvPJ+YM/zNG7uLJW
	xhkeVhi+7xYw0ld0ptIHunoHrdms4FP8HvPKn/RiN3TBdSkWIDQnT8sKi1ll5SY9
	thG8rOXau4RNeD973GIyCsRv1NiC57Mucyg==
X-ME-Sender: <xms:SADNaQ3yrwM--oDxemPOJB29rIGo73caoQXlxruvTzDT0Og-bE9I6w>
    <xme:SADNaSi1L8HpjNYXzlGelYxr_kGlKZJRSY-dYvolyce3yPrGhEXj_bVR1xHGgam7E
    Rtgqa15UY0L0dAFmdbEwDpJ4lSIoQ7-nAveZ2u_tngFKMby8dChpw>
X-ME-Received: <xmr:SADNaWQacAN3SX_5tqez8jz_eUxkaUb2EmR5qeFvX8A6BZqb6Z3PECAVTf6AcDcNUtxTava2KOBeD9mKOef2pvhLpxA1xucfpOVN4lLPL2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SADNaTiYayOTMClGk71p8bSO4BKb4zluhayyMXCnSVD0YgPKwaq7AA>
    <xmx:SADNaW6bkw38FBSKkJoRgez7O8ln_I2PbAZEk4JplviIP1G_fNJXoQ>
    <xmx:SADNaQCDdx3kq9p56DGv9bYuF2whOR-WZ0LoAkfTsKumdnnN7RlXuw>
    <xmx:SADNadbQZx1w9AVawJHtqxH36s04dpKzCyC6xq2wckW2aSYw-z7PbA>
    <xmx:SADNaWhh_MliK5OFhXLcMyqp-5z6a5VHIe2LqN1XSlgSCzUIuhYw5JcY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 07:23:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2dd6dea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 11:23:50 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:23:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 4/7] object-file: remove flags from transaction
 packfile writes
Message-ID: <ac0AROkfM_GQ9fEW@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
 <20260401030316.1847362-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401030316.1847362-5-jltobler@gmail.com>

On Tue, Mar 31, 2026 at 10:03:12PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index f3038756fc..f317a24ccf 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1412,6 +1411,38 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
>  		die_errno("unable to write pack header");
>  }
>  
> +static int hash_blob_stream(struct odb_write_stream *stream,
> +			    const struct git_hash_algo *hash_algo,
> +			    struct object_id *result_oid, size_t size)
> +{
> +	unsigned char buf[16384];
> +	struct git_hash_ctx ctx;
> +	unsigned header_len;
> +	size_t total = 0;

One nit: I think `total` and `size` don't really give a good sense of
which variable tracks what. If this was instead `bytes_hashed` and
`size` it would become a lot more obvious.

> @@ -1666,18 +1683,28 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>  				 type, path, flags);
>  	} else {
> -		struct object_database *odb = the_repository->objects;
> -		struct odb_transaction_files *files_transaction;
> -		struct odb_transaction *transaction;
> -
> -		transaction = odb_transaction_begin(odb);
> -		files_transaction = container_of(odb->transaction,
> -						 struct odb_transaction_files,
> -						 base);
> -		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> -						      xsize_t(st->st_size),
> -						      path, flags);
> -		odb_transaction_commit(transaction);
> +		struct odb_write_stream stream = { 0 };
> +		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));

I would assume that `odb_write_stream_from_fd()` knows to fully
initialize the stream, so zero-initializing shouldn't be necessary,
right?

> diff --git a/odb/streaming.h b/odb/streaming.h
> index c7861f7e13..e5232cd4d1 100644
> --- a/odb/streaming.h
> +++ b/odb/streaming.h
> @@ -5,6 +5,7 @@
>  #define STREAMING_H 1
>  
>  #include "object.h"
> +#include "odb.h"
>  
>  struct object_database;
>  struct odb_read_stream;
> @@ -64,4 +65,11 @@ int odb_stream_blob_to_fd(struct object_database *odb,
>  			  struct stream_filter *filter,
>  			  int can_seek);
>  
> +/*
> + * Sets up an ODB write stream that reads from an fd. The caller is expected to
> + * free the underlying stream data.
> + */

Hm. Shouldn't we provide an interface that let's the caller do this
without having to know about the stream's internals, like
`odb_write_stream_release()`?

Patrick
