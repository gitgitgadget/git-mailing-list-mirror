Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5D23D7F4
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626985; cv=none; b=NdDu51qR473V12ItT8MnF5y4ldOzK+HArVu8LAybItf8eqy7EYp9CB5yCLlPjE88niTy2ON3NlEDyqRu1wRHq5Pe4K+sA879VAKJZamm2UB1u9+DsegSlZBkjcbNuJaWCaQSoo2kaJQ66d/SZmgK/LAFH/FyApSKrQTx6iVZDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626985; c=relaxed/simple;
	bh=O5UdaFpKNmsO4J7wq+dx9cU/HK42R5dyC9+0D2TKxBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brt70QQqGSbHFA9B0g19TQSVMhdXmAkkATuH8ajxkHh0DIRAckpDI54UjLDgEwqEUKTJgyXkzL3tDMgvikH6x59AR2ATcWV6a7Vxac9/fWE2gR1ndzr/3kZLqj4kFE0OtFc7XuvSQi/63HFOZW5xPLBo1rXWPvx0+Nnbo+ttrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TCtLCBAo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TCtLCBAo"
Received: (qmail 14716 invoked by uid 106); 1 Aug 2026 23:29:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=O5UdaFpKNmsO4J7wq+dx9cU/HK42R5dyC9+0D2TKxBw=; b=TCtLCBAohpIHgH6YPWw2sf2nFDKvh2vgaW6TxWFCjWVh0go3SjEgil7b8UpnS7aNUwgp/cSh3IStcQpDVq5gSUp7Cf0ou1udz6ieKO9pZlwYNzDq8PnzbaVy/E3XVFXBzTV0Bcl507IChtSKTiil+6+2bNIc943dm3oc3EabrCrtO+2p5VHclJhrlFgCZwh97OmfOxMr6JaYu5CsML6JdDkypA5xLjhiD7ASRWuKusDuZleVJ5m3E2Bqb/k3SGMZbWhu1qwqZ8EIelk193hGODIYlRKQuiTMkvNMSn91spia0ooD/+2OEn0qpKT1yxR+QHoG0GtsKmoeG3Zw+yPgZA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 23:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22538 invoked by uid 111); 1 Aug 2026 23:29:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 19:29:42 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 19:29:41 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chandrapratap3519@gmail.com, karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
Message-ID: <20260801232941.GA2097163@coredump.intra.peff.net>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g>
 <xmqqzez67yg1.fsf@gitster.g>
 <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
 <20260801231437.GA2097059@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801231437.GA2097059@coredump.intra.peff.net>

On Sat, Aug 01, 2026 at 07:14:37PM -0400, Jeff King wrote:

> Yes, this conditional loading is exactly how we use the pointers. I
> agree that a bool would be smaller, though I doubt it really matters in
> practice. You shouldn't have a large number of object_info structs. You
> should have one that you use over and over. And it does not point to a
> heap allocation, but usually to a stack variable in the caller.
> 
> I don't think you'd need type_valid (at least not as the object_info
> code is written now). If you ask for it, then either the query is
> satisfied, or we return an error.
> 
> I think the pointer system goes all the way back to 9a49059022
> (sha1_object_info_extended(): expose a bit more info, 2011-05-12). It is
> mostly just mirroring the pointers that would be passed directly to the
> function (but marshalling them in a struct so callers don't have to pass
> a zillion NULLs). So:
> 
>   read_object_info(oid, &size);
> 
> became:
> 
>   struct object_info query;
>   query.sizep = &size;
>   read_object_info(oid, &query);

OK, I tried to read through the patches here, not having looked at the
topic previously. I think it doesn't make sent to use object_info here.
It is about collecting the options to make the query for _one_ object,
so it expects you to point to where it should write the results.

But what you want is to query N objects and get all of the results back.
You _could_ do that with N object_info queries, one per object, like
this:

   enum object_type types;
   struct object_info queries;

   ALLOC_ARRAY(types, nr);
   CALLOC_ARRAY(queries, nr);

   for (size_t i = 0; i < nr; i++)
	queries[i].typep = &types[i];

   /* you can imagine this is calling read_object_info() in a loop
    * under the hood */
   do_many_queries(&oids, nr, &queries);

   /* now we have our answers */
   for (size_t i = 0; i < nr; i++)
	do_something(oids[i], types[i]);

But it's kind of silly. Every query is the same, and you'd rather just
pass _one_ query struct that says what you're interested in. But since
you are not calling read_object_info() yourself here, why use its query
struct? You can make your own using boolean flags or whatever.

And I guess that's what started this conversation. The fundamental
difference is asking about one object (and using pointers to tell where
to put the answer) versus asking about N.

-Peff
