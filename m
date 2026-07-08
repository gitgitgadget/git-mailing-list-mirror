Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A7380FD4
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492913; cv=none; b=AlbgGaNRGEotCCTUoIJtLEbL7g8yQMLaXI+VMVbcdjyliQFzKnmc6fVIfVs86NjIyTdiRF/gaVCltu1/xjoOG+NRcy03xkv+OlIW4BXYyTe3nmivnCf6Ds0BP9nofFoBV3dUKaXxZEydSyB7CRnKpUIsKeOTB8/BPChMCKwQLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492913; c=relaxed/simple;
	bh=F4UCau1JZtbeV7nSQAKQQt8a2R6JSVXV0Ix6Jgt4Z8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeJP7Zi+3QUKVH6j4zxwGsUvusHRTEfQsaCke6n5yZMR9mBgnEaRSwm8U4iGr0xd5NaZH/PaBATovN/wmx2gKC0Qu6juxbYnut+djS5fmgK0Fx7Nr6JHIsBWcYCa2lbT+v7KA8G+G1ILRPeIOjV3iQB9KWJvtNGljb6MoOM1r3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SeeFVB0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbFUUT4y; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SeeFVB0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbFUUT4y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44CB21400052;
	Wed,  8 Jul 2026 02:41:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 02:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492904; x=1783579304; bh=fswP8VHDub
	KyGOeWPFigMcwtcZW3jRfF1WYC0j8ubHQ=; b=SeeFVB0yU41X+Wz/i1S3PIKKrI
	AoB77lDA0KEd6OqFBsHorkRc1zyyOfdUcVcKwXiuqHQrrrxh+Wmm9hrouBq5OgA8
	VhOgpN7I29fkkTq1TzBgqfK+crG3iMCBER6hXbc5I/HK6poDJ1U3L8KJwBgm6e6I
	SoFmI2gdUqzo+7RoEfiCx7SFs94SHlI6ajN2nUpAkTTdfN1P+XJxQnVjd3DsaIwV
	IyIcN9fvGxBmJTJWuXziiVoqDRNlMY6xoxEs6J3KaT//SIvtxniR0GHB47MsyDmo
	aCOINJQnoFa5PKrYwEM39NhR4F4r7owph5frgwAoWJ25SUzOba3Ov1fiWTNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492904; x=1783579304; bh=fswP8VHDubKyGOeWPFigMcwtcZW3jRfF1WY
	C0j8ubHQ=; b=rbFUUT4y8NnouPIhd/URZDsZnDqz2zFSeFt1uxPZDEBSK0OSnm/
	Cs7SqgKBjMK/tV5/6KqEmNJp7R9HiuOLpve31WTjK8OK1jCta47vcCdBUlUDAcmc
	IqR2BjQhkGl+Px7Ja53kVltkYXyChtp+A/kvCiPOaH1D7u1cB63wdvOXlvduKjX7
	4HGphlO1ZBQE7QFbxbkrPk6Z/M9EJ9xlgxm1nQYkSoCE0FfS3lrojqmTHoglaNFZ
	VYPyu8Iang+K0BnpZ1rWBDB99h4wg1REbFnPzaW/4LmVVo7WJRzIiKw5K8igLoJD
	MslP9DLDJoTnSyTHC79dxh0wRYs/UKaSBrQ==
X-ME-Sender: <xms:KPFNapr6iW0V6disgJ3sEaAE09FuXk7YZO0J0zpOvkpyW-DOuSOu4A>
    <xme:KPFNajEHsN6B-d2KY8MKXMlLFaINK2WQRgjfFTxBTjv5quB2RVoychpt_iuN1akHS
    3b31JDoF6xdhontqVrvCfBsp5qcxngnaf0INeW9e9N_4LqlyLgZ9g>
X-ME-Received: <xmr:KPFNajkeE0vHf3v-DXuy9W0LNebsbjOYBO5xIFj_DRRL8ot7oT08D0Frr_Z9PS2TDz1_rh0NPUAleuTlhPQ_OCPtfvSlLGR-38N-EhUT>
X-ME-Proxy-Cause: dmFkZTGZXL/xVJBZRT0XjNqQmj0NiEBsL4QM8RtI8yDGZADKrRfylrcgFrWZI9uiDIKpJG
    NjKjs02P0Mm6RVE/7hDfUtc9cztgn2Cw1NuVWkTQj+sAuE+2j63eSJoWyolt/Iiji6uwfB
    AwsPpkAgDLBwGtskl6J4DfVEmE3a8CrgO0CsSJrcgOSpTlkDb4uBEU2zo8XcOuoumIzvPq
    jcg3C9N3hj/0A3Ui37jFkht3TKzzhYoJNu6TlM4CtvieEBaYn4bcsRChYX5mEXYpyukiBZ
    qNG2o1iENbIAOWxM/sLhn2X9ptN7rf4lBdIWSM0XtBgVFCdgfwbiDeFlBqFipjcVgu8+Mf
    mWKp9HdZDpsG/OxFEd1ZVyau5FFmMoupyvXjkGThUh23WWgzKG4zUK6z9ztZEMGJmB5i1s
    Vgpj252Y/2WV13/QbUJ9RpiBlN0MPnH+Q5LJPG7UAlzzga9AINbZjlZwofOP+twZuhvH8s
    cuSxJBrh89t+eSfClD1LrkZKn4cYOl2yX/lskQwWCManAtcv/Emf6VMYLOBjhMCJmtvM6l
    f5QT/qC4egvaMlAEORuWtf+/doJEaumw8BJgzxMUId4gJeEsIoEC8exOcfJrzcDVm/kZ5E
    NhhF4a+wWpbb5LFBALJympe8ljNUHGF19G+QbKmaWanSIRZs2uuFhOPwSj1w
X-ME-Proxy: <xmx:KPFNaumXoVcOiLZfEQW7TvsDOmfrLjXXCdpW7-G2tBkPySphm2Ji1g>
    <xmx:KPFNast_dgFY3mmw-tpNQV55bd8v0IENy_lxAQvUVzLM7e4j1EoQyw>
    <xmx:KPFNaplM-vkr_NTRCJ3RB_RJJKNJZh6nwSe8dtA8EcCqngUOcyh2eQ>
    <xmx:KPFNavscQwnw6AOxsbJ6ea7JfmcCd7QWtbMVY6u9nLYVbqXqBjU3vg>
    <xmx:KPFNarE4q6JIFjPps-TKx61EkfQFGV3tCmAF8gCI6lBkpoA4HTQspiAz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0529c7fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:42 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 06/11] odb/transaction: propagate begin errors
Message-ID: <ak3xJFDqTSN1Naoy@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-7-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:07PM -0500, Justin Tobler wrote:
> When `odb_transaction_begin()` is invoked, the function returns the
> transaction pointer directly. There is no way for the backend to
> signal that it failed to set up its state, such as when creating the
> temporary object directory backing the transaction.
> 
> In a subsequent commit, git-receive-pack(1) starts using ODB
> transactions and needs to be able to report such failures rather
> than silently ignore them. Refactor `odb_transaction_begin()` to
> return an int error code and write the resulting transaction into an
> out parameter. Also introduce `odb_transaction_begin_or_die()` as a
> convenience for callsites that do not need to handle errors
> explicitly.
> 
> Note that `odb_transaction_begin()` now returns an error when the ODB
> already has an inflight transaction pending. ODB transaction call sites
> that may encounter an inflight transaction are updated to explicitly
> handle this case.

Yeah, this change is very much welcome and results in much saner
behaviour with less surprises. Thanks for making the change.

> diff --git a/cache-tree.c b/cache-tree.c
> index 184f7e2635..8eec1d4d52 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -474,6 +474,7 @@ static int update_one(struct cache_tree *it,
>  
>  int cache_tree_update(struct index_state *istate, int flags)
>  {
> +	int inflight = !!the_repository->objects->transaction;
>  	struct odb_transaction *transaction;
>  	int skip, i;
>  
> @@ -490,10 +491,12 @@ int cache_tree_update(struct index_state *istate, int flags)
>  
>  	trace_performance_enter();
>  	trace2_region_enter("cache_tree", "update", istate->repo);
> -	transaction = odb_transaction_begin(the_repository->objects);
> +	if (!inflight)
> +		odb_transaction_begin_or_die(the_repository->objects, &transaction);
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
>  		       "", 0, &skip, flags);
> -	odb_transaction_commit(transaction);
> +	if (!inflight)
> +		odb_transaction_commit(transaction);
>  	trace2_region_leave("cache_tree", "update", istate->repo);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)

Callsites like this really make me wonder why we even care to create
a transaction in the first place if we basically just commit it
immediately anyway. And while it's a bit sad that we have so many sites
where we don't really know whether we even have a transaction, I think
it's a good change that we have now annotated them clearly. A subsequent
patch series may then eventually refactor those sites so that we stop
depending on `odb->transaction` and inject the transaction via a
parameter.

> diff --git a/odb/transaction.h b/odb/transaction.h
> index d52f0533ce..36032a5365 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -1,6 +1,8 @@
>  #ifndef ODB_TRANSACTION_H
>  #define ODB_TRANSACTION_H
>  
> +#include "git-compat-util.h"

We typically don't include "git-compat-util.h" in header files.

> @@ -36,11 +38,21 @@ struct odb_transaction {
>  };
>  
>  /*
> - * Starts an ODB transaction. Subsequent objects are written to the transaction
> - * and not committed until odb_transaction_commit() is invoked on the
> - * transaction. If the ODB already has a pending transaction, NULL is returned.
> + * Starts an ODB transaction and returns it via `out`. Subsequent objects are
> + * written to the transaction and not committed until odb_transaction_commit()
> + * is invoked on the transaction. Returns 0 on success and a negative value on
> + * error. Note that it is considered an error to start a new transaction if the
> + * ODB already has an inflight transaction pending.
>   */
> -struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> +int odb_transaction_begin(struct object_database *odb,
> +			  struct odb_transaction **out);
> +
> +static inline void odb_transaction_begin_or_die(struct object_database *odb,
> +						struct odb_transaction **out)
> +{
> +	if (odb_transaction_begin(odb, out))
> +		die(_("failed to start ODB transaction"));
> +}

We could make it a bit simpler to use this function by continuing to
return the transaction directly. But on the other hand this results in a
more consistent interface.

Patrick
