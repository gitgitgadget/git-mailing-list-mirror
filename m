Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760B13D891
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909997; cv=none; b=f2ZvQHeTcchBhM3lQOQnuXwgDhfzosK6avEd5EXZyff7F6sMG36+YFHkOYMMPWxTufx/1UYf4StVcy03iZAmgv6rfOu1wufxyS6IV98hIPWxsuRYRx49hx8L8ac4JNNpOjdLP7lishKtgab7jNkpNCTKfeceGDs96lQ6iJFIBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909997; c=relaxed/simple;
	bh=BOx8R/9+owKVKeFz79hB5b1ur3W4O7h7dCykaRgdtgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh38u2y2BNdBI4QEVG71RIiP/HI0ZVA7MEzMCePSQDjWgX49Es1ozy59psU+5WcyDGmg3tZC/KnjnQg1KpliBJXa7WDS1jsdm82RDYhTN3QWsDepDBnXsDbE/sIaF59KhMuoweKFpsgvr52QLruKXjB/ScEmptDVcgmY+44rPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N6/KvLFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aex3kO4t; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N6/KvLFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aex3kO4t"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53CF8140013E;
	Wed,  5 Aug 2026 02:06:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 02:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785909995; x=1785996395; bh=ShD/wC1ol4
	+4wZXO1mIFVsgRsA5Ba4R1OcIMKJPyxsQ=; b=N6/KvLFvV/vavfxs+mb2yx/PZj
	ApEU5SQ/hA52m8bGDFtCEklwtmPSiEWjq/deQgrxj2ot+OuAM8EhmsZ1jwNq39Bq
	0UoE5ytAs3HZ5/vR5HySl+fbDqbvR9qr5VJU8dQEZD/WGQlXpQVtWSqb8Ht6SKi2
	g2+FinVA5frBLaDO5tbXvlFKmCGb1poBJLFS0reEe3M64kOBxiqFet560FPIBXk7
	fXfFWfsRIcOX/WA2u5wvZSu0ey/a498yjECYXSvhH9nJU+bLEZ8zJJxown2jwW5U
	/+/3r7FMrITs29lhChm2sZ9+K+rD3Cm3sghGZlGQrd0bAwnz2TchoWQSVT2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785909995; x=1785996395; bh=ShD/wC1ol4+4wZXO1mIFVsgRsA5Ba4R1OcI
	MKJPyxsQ=; b=Aex3kO4tbrhCFGKoxyPBsluMAYNSLhbr4aEf3f5WI8hgLpeOE9Q
	zlf7IKFX8nkWHWjZ5fQVnAHlN78r1GAf1CObO0Ts12GKyD9WTKI4jIz6IXdD3epF
	0xcqqkaAenkGJ4y+QzqYRD31hdH317hAKLH3uVO8Rsb/2xqzV3fUrMZi/LEajteK
	vS9OK/OwMiSlioUXpmfbJYL6wMUmDIYpWlWksCOkgcfT0Su9GjZu2Z60HEfV585e
	YTE7ZRJM0vsMaEVjUcFutTyNmpmMNU41GxskOapxFDd0vCaqThj0CY/QqwG9Nisg
	mN7w2E+0AWBpcQn9Ywda1sk9M6gSVxS/SpQ==
X-ME-Sender: <xms:69Jyau-Y0JOOPBzkSPj0dwrzZeLhl94NDDwq1uFgKNQKoFpdJAAFSQ>
    <xme:69Jyakt3H3DlEjd3qK6nqrGkBY1c93CIXPbzXiJ6NgFrQVfyN93xY_CcTrqpLI0HY
    YbYGIAYvNTWXzYos6RJ6qFnAu1NIG7vcl6TKmRSSxpZgum2uxoZuQ8>
X-ME-Received: <xmr:69JyahojADrmKXMny0TXCIIUyhQffgUWRltXerDM-o_ZdlYuJzlZ_hJaZ9ML_BssJsJoMJ7GKD7DnWxE0zVD4W1m05WMhHKkulvLFDEgIw>
X-ME-Proxy-Cause: dmFkZTGEhgwsSZXXVeyf3hOyf/yMOX6eCdAAz2f0pe3xQV639eURlsqQv4j1Ou2T9FdyH+
    OW/TSWIf+LyQq8fDFT4xDB+gDbJMvWCl/M8qNvedjZmIItHVqmTIhwtQu2Kt1LBdIT1IYm
    Eijs7DL58t+RN8Az7PC/U18ZBO625l0cxETytSYr8oZ7ZLTnrc8bsPdRMEKszcHVMausT6
    2vfSxnogWU39vlrO0XcSo74O4VYoElw80x7toGBq01WLFXC4nBb2GjubRPFB7Sbc/JTPOW
    djUKr9OCGsIANmeZMDZWA3lZitw88MOc6Jl+N3mKpPUSS1ZpADfYv8RK2x3IYdS0noFqJR
    CnsoPswrJX+6Ok1yG1OWKlxzsueL/mYLhCyHujB+TT8RoEK1RRe6wx8Ob9sv8Xof/2HhQi
    r2PZMmenWRhNk207lo2zXlj97g2e/NTdjniVvWZd2cyK13LgbbH1/w+IQ5RABRF4G1waaw
    nk3GOAb7rwuM9KlXvrjbdTVJ8+xDgNXKEupgjfKAihb6CkMIcsbfkuxvjbYX23CNpNC+p/
    RJb/K8+sRYv8HGHRqzvf5JLCcsGG47eKLlc3a8bSy8sj3Aml27uoAzb3pWRUYii5hyYHbW
    w5iS5eLMr3cCy3j4Y84j59zWVV1SicmyCsxc25yxtCBoSREFwCwo3ZpNq15A
X-ME-Proxy: <xmx:69JyahmXauFAahEwLExo-n0AkkTPWle0oIFIx7nt_-H6aQIaDSsZkA>
    <xmx:69JyalxJ9aCrr1LuOaZLu-HZEE4GMP3IGl39dK1PsxEdnz3pv_wHIA>
    <xmx:69JyapnPwO6njvKzL_wasV7F-JpTaIXnjDRC5kPZGjA77E8jjI1p7g>
    <xmx:69JyaueMPM2sggLSvDX1HoQA408x9jzMUOgz4GrcZ0e6OncbgkMMxg>
    <xmx:69JyaqXKp5nSa5IXH-hneFfT0dQgy1BhmY5xhr-PTa90L4hGZikaTPXq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:06:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 507f256b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 06:06:34 +0000 (UTC)
Date: Wed, 5 Aug 2026 08:06:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] odb/streaming: support streaming arbitrary object
 types
Message-ID: <anLS5z22CpF82cd7@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>
 <xmqqpkzxvhqm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpkzxvhqm.fsf@gitster.g>

On Tue, Aug 04, 2026 at 11:54:41AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The object database supports the ability to write object streams into
> > it. This functionality is used when we encounter a blob that is larger
> > than "core.bigFileThreshold" so that we don't have to soak large files
> > into memory.
> 
> I am still not sold the benefit of using a single "stream" type both
> for reading and writing yet at this point in my reading (I am not
> yet done 50% of the series yet at step 3/7), but I agree that it
> would be a good thing to be able to stream objects that are not
> blobs.

The reason why I want to unify these two streams is mostly that despite
their name, they basically do the exact same thing: both stream types
allow the user to read data from them in a streaming fashion. The only
thing that's different about the "write" stream is that it doesn't
encode its information as part of the stream itself, whereas the "read"
stream does. So having two types is quite pointless in the first place.

> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > index 01bb81c63c..4f76db5496 100644
> > --- a/odb/source-inmemory.c
> > +++ b/odb/source-inmemory.c
> > @@ -293,7 +293,7 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
> >  	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
> >  
> >  	ret = odb_source_inmemory_write_object(source, data, stream->size,
> > -					       OBJ_BLOB, oid, NULL, NULL, 0);
> > +					       stream->type, oid, NULL, NULL, 0);
> 
> It is a bit annoying that we treat 'inmemory' as if it were a valid
> single word both in the filename and in the function name, but more
> importantly, hash_object_file() (used to compute the object name of
> the object we are writing into the variable 'oid') still hashes
> assuming that the object is a blob.  What is the implication of
> feeding the data to odb_source_in_memory_write_object() as
> stream->type (which is not necessarily OBJ_BLOB) with that 'oid'
> whose object name was computed as OBJ_BLOB?

Oh, that's an oversight on my part. We'd use the wrong object header,
thus arrive at a wrong hash and then ultimately store the object under
the wrong hash in the in-memory source. Which doesn't really matter
after this patch series as we still only write blobs via streams, but
it's a bug waiting to happen. Fixed now.

Patrick
