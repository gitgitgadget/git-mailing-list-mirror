Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0A40D57D
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713811; cv=none; b=quy+985OgoNr3chycTgouuhvWKkrFFhSR7D0ZHxCN+JYUnZOTL1HH+a0qNNwV6yqvkGh9H32XgQluCItRz4zKGJPt+3TXWSNXS9G23E4dYSpsRGdswxpWzYoHYqAE854PjXpdPPNoCv871zeWAXkym8c6O+RrV5WbWuoDUF/tTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713811; c=relaxed/simple;
	bh=ngOFwjP4GUiaCanA5KljweOD+D2PSavOO5BoaoMs998=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJxB9ezJ0A8otpjUZUPln33re/Iaj5s9OsZNT1f3y5D2I0shSDb/UU1oMLhToxitycuGb1yyLjgXxb9EaYIh/KysbRlNXRWPPaJsbDCxPWBvawaf5JXK/BS1wtFW86gF8xbNlM0M152VNTProLufMQD9rrIunbG1FFTg/g9mRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q/zLmolk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCxWEVL/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q/zLmolk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCxWEVL/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 406C37A0036;
	Mon, 29 Jun 2026 02:16:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 29 Jun 2026 02:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782713809; x=1782800209; bh=D2ka/FTz0I
	CVn7mJPXO8cnIDS6x6GBmqsC5zGaNkxRY=; b=q/zLmolk0DvpEg5l5ABxZvYPp7
	FKx/RdktntIIaaReOVKB90wogSbLvMllF0UUzL9c8PGGET9PcefBF3CDwlCqpVAE
	Zm19fTq5JIaTMB8HWEois5mP4gk+P1JRPEEipmNZwBqEQJjnfvnNXV4JQppErLZf
	FCElqSCQnDXZLy9AoqLRdDkN2F0kicvG+wVotZ5k/BdmB26a1w5Lz1wPKfJF9Q5p
	KdmbG9somYjGwHTKUcY0izfr9ENQRrin9MHRHo1/xCk0MuKqjDyfKHODz8QRBRBx
	7GkzhinQXiprX2ifGsfzX47KIFdUOYjzBLIX2+iqYeZ48agCYNKoAzYd99pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782713809; x=1782800209; bh=D2ka/FTz0ICVn7mJPXO8cnIDS6x6GBmqsC5
	zGaNkxRY=; b=cCxWEVL/oh8Py1G2pFfiTDcs73oVpWDcWvEBKKFQtOZmr9siheX
	+cG1g5DvurH6Ry2JC5FhAMqYjLD0ZfX7ewukb3acTL3rlPT8tJj16leIuasNKupz
	jVkEayBYM86Z0ycwHoLIBgqr3BUszqIXlNr6I2Cs2LQwp00QzhD4ySUNYIgZ+dFK
	8H32hfRw74VfqzWZlwM+2oqsP7hKO+lcjBusghVCyMV2qEDvg6uPDXRzIHDev+Mp
	+OnJvrAE1C0mfQbm+tGJVK2MkO8Mwn5TNQSoHLpze+plaWjwKwu4U2lWfmBE3WdP
	nImEJcfsHcMUggsJ9ads7cFIORUYKj1gBOA==
X-ME-Sender: <xms:0A1CanDTAlqkgFUMH3fUf6Z0eHUWOBR-kTQcILr7Xh2GmcUeSDW2fg>
    <xme:0A1CajhG_sCC5y1-ekj1EDpiM6hMdePJX33PajLT5ah5X_1Wv9DBKLSyEHOm6uMF5
    n2j0RvN7C5IkCq-bWZdVDOqMdfLyCtc1YYt4saqFMVMNPC82pCIsQ>
X-ME-Received: <xmr:0A1CagMsQx93MP_wxU8BONr5AQcyn_Qf2VtXMiwu_oCeJU8hMptYyoal8PiQvh6fy0GQHweiq6nMAuSEEFftvpFKfRgPwWsFj797GG7v7Tsb>
X-ME-Proxy-Cause: dmFkZTF5fk4vrgZMHjs2kxsE94CfSZdGUkxlg1wKk3QOhrpZ5Sh/3GIHVCMXmiu6xENqSD
    QkzpC7wLrS8s/teS6gVTSE4zR46KOov8xzl+Ina/5kszDTEeUoql008MUNlNiwOlYOK63g
    dbXnXD4UUBmq7pHnSWRMwS/WIF7ynMjWxSJe+n8XQIl8/zn4I5IXD/b8th0ATc3SonzW2h
    98CTnqP9D8l8Y8e9QY9cTSkkyqSXoRDreXqaZ9ViV1hCVM3Iu4iv83jlZP0dceKqx8x8k8
    irlt8R2ixUcl0WQF2urzpApg648nZlH9/KQwROT+ypxNclcy05oii5zAgUJBog6SueDbEg
    e4Cu5aRv2mfHKzU3H/HNiXtgGlAZ+rbDRUcG3ueUqiQ/kjHBvkCBNfhmD78eJDQAYtdaqo
    sne1MqU9rAZCtaRaV15LzzaJHDvjwZE/ua303bopg47XJe4ccxrm3378C5yArRz6irglVo
    xqNKjddaqUTk127XjrFtlKI4I2OAF+WcPkg0yAmWroARIYvmeI5iI2Ro2aCtDjZDsN0EvO
    4QQV6VABxbS1iTxKFAjfDcx9vN1pN6w0y6CFFL27OI3KkzN4te0xeKCKmEOSUFapiD2rIY
    r6Uxneq2V/6EuDzqb+ymtsR+pSU+ijNr276BmeMHeBea3UKbyXYBWFywuS5w
X-ME-Proxy: <xmx:0A1Cak64wv3RHXdJmF5CbyotGvjqnmHrW94MTE1_sWjcwPEgTllHiw>
    <xmx:0A1Cau0KLXO059Mr6j1wkWaHC_p6RbIBGXmb5Z3_aK4owTWFov8HAQ>
    <xmx:0A1CalaAErjdILHStWwTHdBu1P4BawNURDm6mmwv4t0WwzQiwiyb6w>
    <xmx:0A1CamCbCr5fJQ1o6tpZr26DXtEfG54ebviLx4QzdABVQiD-KM39-w>
    <xmx:0Q1CaqZZ9lieoUJ6R1tgbdzoa5JUuCLa6kHZRFs5CD6OClH-G4aVbk3R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:16:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8dfecee8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 06:16:46 +0000 (UTC)
Date: Mon, 29 Jun 2026 08:16:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] odb/source: generalize `reprepare()` callback
Message-ID: <akINy-hP5EPD4Y4e@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
 <20260622-b4-pks-odb-generalize-prepare-v1-1-d2a5c5d13144@pks.im>
 <87ldc14i4n.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldc14i4n.fsf@emacs.iotcl.com>

On Fri, Jun 26, 2026 at 02:10:32PM +0200, Toon Claes wrote:
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 8080d1bf5e..7361bf071e 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -1361,10 +1360,8 @@ int cmd_grep(int argc,
> >  			struct odb_source *source;
> >  
> >  			odb_prepare_alternates(the_repository->objects);
> > -			for (source = the_repository->objects->sources; source; source = source->next) {
> > -				struct odb_source_files *files = odb_source_files_downcast(source);
> 
> So you're downcasting inside the implementation by the backends itself.
> That makes sense, but would it be worth to say something about that in
> the commit message?

Hm. Would that provide much value? I'm probably quite a bit biased here,
but I think that it's implicit that the backends have to eventually cast
the generic structure to their own backend.

So I wouldn't really know how to clarify this. Did you have anything
specific in mind?

> > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > index 42c28fba0e..fa5a072488 100644
> > --- a/odb/source-packed.c
> > +++ b/odb/source-packed.c
> > @@ -15,7 +15,7 @@ static int find_pack_entry(struct odb_source_packed *store,
> >  {
> >  	struct packfile_list_entry *l;
> >  
> > -	odb_source_packed_prepare(store);
> > +	odb_source_prepare(&store->base, 0);
> 
> Why are you not using ODB_PREPARE_FLUSH_CACHES here? It used to do
> before?

Because this was calling `odb_source_packed_prepare()` before, not
`odb_source_reprepare()`. So this was calling the non-flushing variant.

> >  	if (store->midx && fill_midx_entry(store->midx, oid, e))
> >  		return 1;
> >  
> > @@ -47,7 +47,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
> >  	 * been added since the last time we have prepared the packfile store.
> >  	 */
> >  	if (flags & OBJECT_INFO_SECOND_READ)
> > -		odb_source_reprepare(source);
> > +		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
> 
> I think the new code is correct, but why wasn't `packed` used here in
> the past? The old odb_source_reprepare() expected a downcasted, didn't
> it?

No, `odb_source_reprepare()` is the generic variant. The naming schema
is typically:

  - `odb_source_frobnicate()` for the generic variants, which receive a
    `struct odb_source` as input.

  - `odb_source_<type>_frobnitcate()` for their backend-specific
    implementations, which cast down the generic `struct odb_source` to
    their backend-specific struct.

Thanks!

Patrick
