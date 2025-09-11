Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F56266B67
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572858; cv=none; b=QjgOKHTLcBUttmq3G297t7N9aQLueH/L4sQcPMaCbqzOH8RuU8jfBBcWvEi+FmeT0AjC7Dgg/+OGsBl0rmIDBH7UqYOkqR7oJu/z3WImVAJ+Hlwt2daXOmeI2BQmadxrIDUSS/r4y4gOcVF/UvZFMGsrqzksM0dypQGpmvIjrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572858; c=relaxed/simple;
	bh=9h9rXjovuiJEcTeFtx8U6XfFcpDrR1lj2K99Q7u/x2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA3bXe85ic8yv0FW903wqYLs7EZnAvEhg64qwHKZnVTuHRefIeUgbozKRCPEKse3fJYNj/jDPKLB2HfFG9+mz7Ubn4yRrUXcx6EEPQMKDXHU54+8vRR/9YbucAIf/ytgAsb08yeMw1DlRYHdlyuMTBL/LT0sHC65bWwatJVxXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TYmel5Do; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvLMk+mo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TYmel5Do";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvLMk+mo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E91B91D001E3;
	Thu, 11 Sep 2025 02:40:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757572855; x=1757659255; bh=MVQtV7DEfZ
	JtUFJyc0vbV8leMoRl/L2P/CZwSbYxz7o=; b=TYmel5Do1NrBq7+pX+mGGVrphC
	4Mul2cpNtQ0WtBeYmR39X9LhdTdaZpYbhqCd6NPP8pFdruB7BMsi9GtGWaQMvho5
	ZCkebVbd0/dGYvavg5FoyQMww1xU0SfGpsrQR0Z+yQ9z27BCabYFDZFjRdP7Vz/c
	69BJ4sI8xj1P4HOj8oDd3/OXHGzlt4H8HR0zYB6iy9FFeK/PlHBvl385cNjQScax
	eQBy2E+zPZgJXcyHX0H8qKnEVbEElzbipufx4KpWp4m6LiH/BF95nyegv6DWnAZF
	jKRhk9BdCoHtgWngRkbCBekfqam8vNmXxZp7+w68NlQu6PeY+r+KvS1FeAkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757572855; x=1757659255; bh=MVQtV7DEfZJtUFJyc0vbV8leMoRl/L2P/CZ
	wSbYxz7o=; b=CvLMk+moP83Pgb9PYHZNfboKatiJpc+6g6cYnNm6vgzB2DkXU8s
	GGwqMF5e18S7rSEmsxfVKsrB6Z1+ry+RbdB02DEXGIXVo3b/NeXqSHcStrHAD4aW
	eSkStZ9LsxCSu2Zc8GVLx5B8YCvJUS7Lb2mphFkvTpVjeKoqsHLGoLy4ZwgO5qiL
	XtmIeAqgIpIjx4Lr2ZvvqJe5wFfdd8X/EP5uNrR7Io2PlQdGqlyg4z70383SiIyt
	r1g2Jz/U74QtAf85leoUmw4UUFY14VlI9zfw6xVkK8pLdlMwhAW7I0cKs8FU636u
	26fcVB/58IDZGntGVGZOp9WhIzfVtiL97dA==
X-ME-Sender: <xms:927CaA2Fkq0uxbD2USAHkoxNRfU3BUQd1UVdGm3C-hhACyaL0XLy1A>
    <xme:927CaLRKMa1m4KchAlBs5uZ8r4PjAgctqAvMP9C_4bjXp-dla7pLrZcoj7cZHs-Kb
    haYbUuKz3eQSp71gQ>
X-ME-Received: <xmr:927CaKvP5CR9rk9KRAJuCEr74ZDChwtbQ600sDFEPVth-ueI0ZD-MungXzuC1Y4tdcaWFk0oZe2TFFLANGjwjDNgxTlH4JGCpukg5QtwkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:927CaIaLau2qiGUTVQGSgA7-QAqLWwqc1QafLwC1-Bx0VTu7bFr0jw>
    <xmx:927CaHu310BSyy6ykhzIJvtqRU-3fVjuTBhsXpfc_acFbzP2W4dfdQ>
    <xmx:927CaCFUqhXj9NtL_gQmgMH_slT8ByxruxE0p2rnBMQtYIEikJPwXQ>
    <xmx:927CaKxvWR_HKBEvC5K3uK7RdC7ay6oT0d4U5msuEPfHWnsL4HGz2A>
    <xmx:927CaLHafx4AkvhrRaK_7-q3KeWl8ycgd1BZFygB2eDmckqre8GvZD42>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:40:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 761d4aef (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 06:40:54 +0000 (UTC)
Date: Thu, 11 Sep 2025 08:40:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb: add transaction interface
Message-ID: <aMJu9LOAEa1NWsF0@pks.im>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909191134.555689-7-jltobler@gmail.com>

On Tue, Sep 09, 2025 at 02:11:34PM -0500, Justin Tobler wrote:
> Transactions are managed via the {begin,end}_odb_transaction() function
> in the object-file subsystem and its implementation is specific to the
> files object source. Introduce odb_transaction_{begin,commit}() in the
> odb subsystem to provide an eventual object source agnostic means to
> manage transactions.
> 
> Update call sites to instead manage transactions through the odb
> subsystem. Also rename {begin,end}_odb_transaction() functions to
> object_file_transaction_{begin,end}() to clarify the object source it
> supports.

Makes sense.

> diff --git a/object-file.c b/object-file.c
> index 91fddfc4984..aff6c6c6dbb 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1623,7 +1623,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  		struct odb_transaction *transaction = NULL;
>  
>  		if (!the_repository->objects->transaction)
> -			transaction = begin_odb_transaction(the_repository->objects);
> +			transaction = odb_transaction_begin(the_repository->objects);
>  
>  		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
>  						      oid, fd,

This function is a bit of an outlier, as it is weird that we call
`odb_transaction_begin()` instead of the specific function.

But "object-file.c" currently contains two different parts: logic that
is related to reading and writing objects in general, and logic that
provides the actual object source implementation. This will be split up
eventually once we carve out the actual "files" backend, so meanwhile we
have to live with this seemingly-unclean separation of concerns.

> @@ -1971,7 +1971,7 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>  
> -struct odb_transaction *begin_odb_transaction(struct object_database *odb)
> +struct odb_transaction *object_file_transaction_begin(struct object_database *odb)
>  {
>  	if (odb->transaction)
>  		BUG("ODB transaction already started");

I would have expected that this function now gets as input an `struct
odb_source` instead of the whole object database. After all, the ODB
layer is the one coordinating the sources and managing which sources to
tap into for a specific use case. But the actual business logic to read
or write objects should then be handled on the source level, shouldn't
it?

> @@ -1982,7 +1982,7 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
>  	return odb->transaction;
>  }
>  
> -void end_odb_transaction(struct odb_transaction *transaction)
> +void object_file_transaction_end(struct odb_transaction *transaction)
>  {
>  	flush_loose_object_transaction(transaction);
>  	flush_packfile_transaction(transaction);

Shouldn't this also be called `object_file_transaction_commit()` to
match the ODB layer?

> diff --git a/odb.c b/odb.c
> index 2a92a018c42..2cd954a1040 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1051,3 +1051,13 @@ void odb_clear(struct object_database *o)
>  	hashmap_clear(&o->pack_map);
>  	string_list_clear(&o->submodule_source_paths, 0);
>  }
> +
> +struct odb_transaction *odb_transaction_begin(struct object_database *odb)
> +{
> +	return object_file_transaction_begin(odb);
> +}

So with the above, I would expect that we pick the source to create the
transaction for here and then call `object_file_transaction_begin()` on
that source. Eventually, once we have pluggable object databases, we
would then not call `object_file_transaction_start()` directly anymore,
but instead we'd call e.g. `source->backend.transaction_start()`.

> diff --git a/odb.h b/odb.h
> index a89b2143909..c7725b3df00 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -185,6 +185,9 @@ struct object_database {
>  struct object_database *odb_new(struct repository *repo);
>  void odb_clear(struct object_database *o);
>  
> +struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> +void odb_transaction_commit(struct odb_transaction *transaction);

Let's add some documentation here what these functions do and why you'd
want to use them.

Patrick
