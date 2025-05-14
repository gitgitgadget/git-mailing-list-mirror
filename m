Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A66221DA8
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225883; cv=none; b=JERHLSzJ00tiM3eJRKmEzWnrq9eL2anucanrYFHdStN6aoLh9+Iyx/UuKiuAAFwEccGc3B0QhiorKAwdzSjDQfyxj4/KwsyttSxwmoSjp5F5JybMh9aNff9x1qXPBAqewpjDIBNC7H0/1q4TqFEigWB9teLqDLs5LLowFwdKzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225883; c=relaxed/simple;
	bh=uFdlLqDoGYD81e7s/2Lk7Y7tuliBW2wJx+gqwDxUTxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP85GPDSJcDgsgRNYaOyX+h++0J1WHMTyMiNhX+/+9zYAT/5X+1fTzuIQbm5VPy0NskUrx38mhuyJuIDmlG3JNdeu0eI8Px7wuR779dywaExxMzZ3fmxd9hOOh/hsEJgr4qi8r1Ynp27l8N1bI+PdZCpTp0e8hyQVxY9GXBrSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WQgkDXl8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gA8a6GLf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WQgkDXl8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gA8a6GLf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1ED661380418;
	Wed, 14 May 2025 08:31:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 14 May 2025 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747225879;
	 x=1747312279; bh=IGEVLJKE8vFu9zCZnC2KQmfZzPl6Gr2f1/lkiZSJydI=; b=
	WQgkDXl8EG21sBJNfmECQ8DDs4S2wXn39neOjnvN95JJJOoug7sh8H3DtCIIlY6O
	p9GG9dZa9H5VOJdkRsiyPacASXidsKW1g0A+89+nhlhwe2gg/xygOLUdrbNNTCS5
	LRLf+f4lwxuQHxsHR6BLPLp3gX0sC5lVDtQcnG9QQmkfucTU7Ml7IuXaPelVbvJF
	lh7EMXKug915o/fcUWm8llvhZXmoba+Y9v3u3tMlkX6UJFLp5i2rwK9JGH8qAh8t
	7Y0xzqqLBSMLnEg3jJPdHzWryV6J2YQod7U33wHYJjtcNxwdzax/7LcF+wFkKEwh
	E84KIFOPR3qGlFT69n6Djw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747225879; x=
	1747312279; bh=IGEVLJKE8vFu9zCZnC2KQmfZzPl6Gr2f1/lkiZSJydI=; b=g
	A8a6GLfFBt5x5u0N2VJcyXnM4tP3n0nZZtJbsoTQ+nfJXYdSUrH53BzKf+EF4HMt
	n2CifvYTYVgLiPQObZH6AHkUgfx/jJgh5CBgwRcy2AF2KJVp5RALrR0nB1PbeKJ7
	6lCpdYO7NF83SvpmmS56rM7uiC9bmadga6k6BSQNvqwdxtsDCnhkoy7kwUNt0YQ2
	Shxr+VGIUNgSpKU82NaYTdDxI4OouCtc3kqbEcaPmNFDB8CYzslz2jy4QsueRPpu
	xDZoGhZHQwVi8SLr3gEuaXIC+MKFd9XWcutyeGf97CNYYHu/2CHY3MO50+ttCRVm
	ID6r8ojSPE70maBYYw+fA==
X-ME-Sender: <xms:Fo0kaGQ3gO8HKO7T2O9OuaoycWXAXTdpKfbRN-U_KnZ1fErsghdHCw>
    <xme:Fo0kaLyJgTtIPzRG40K2zhetsZmxfWr0Q8DhMxze1yioOuffTrIG-NT-4OzmP-SVC
    wbs77-dDWI02TQdCA>
X-ME-Received: <xmr:Fo0kaD3llrBQn8TWE2clyQyHSfjy8UYfe4oNuD4q-ARd34MCwCX4rm9-M2_xGJcJOrNVunXdIBArhXm4PclUmHUTlLz1TW2XrB4HvfBBVLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeileelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fo0kaCDVU0Eq8xfCQIfBtnmz2BEt0pd35b1IOyE_hI-P84HC0C_Y4Q>
    <xmx:Fo0kaPhC8JdU0QH3L8tjBXV48mIFK4fUhxsmqHjm5U2VROPXxPQ5zg>
    <xmx:Fo0kaOrv_dq1llxHciGr8iRtHCc-ch7V_Nax30RMA__pZ-q5lYRGPA>
    <xmx:Fo0kaCj0AO7qdXGXNuWPRgrK6OstVSfJh1IIw-Q5pHunI_nEFydzBA>
    <xmx:F40kaHf4t_-mUN6r_kbh2qz__HDCBUgaDAQVPfThmmZwdNZdH8jV8Cgz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:31:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43bb9d1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 12:31:17 +0000 (UTC)
Date: Wed, 14 May 2025 14:31:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH 1/3] fetch: use batched reference updates
Message-ID: <aCSNFMeh3WMav_Rn@pks.im>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>

On Wed, May 14, 2025 at 11:03:47AM +0200, Karthik Nayak wrote:
> The reference updates performed as a part of 'git-fetch(1)', take place

s/,//

> one at a time. For each reference update, a new transaction is created
> and committed. This is necessary to ensure we can allow individual
> updates to fail without failing the entire command. The command also
> supports an '--atomic' mode, which uses a single transaction to update
> all of the references. But this mode has an all-or-nothing approach,
> where if a single update fails, all updates would fail.
> 
> In 23fc8e4f61 (refs: implement batch reference update support,
> 2025-04-08), we introduced a new mechanism to batch reference updates.
> Under the hood, this uses a single transaction to perform a batch of
> reference updates, while allowing only individual updates to fail.
> Utilize this newly introduced batch update mechanism in 'git-fetch(1)'.
> This provides a significant bump in performance, especially when dealing
> with repositories with large number of references.
> 
> Adding support for batched updates is simply modifying the flow to also
> create a batch update transaction in the non-atomic flow.
> 
> With the reftable backend there is a 22x performance improvement, when
> performing 'git-fetch(1)' with 10000 refs:
> 
>   Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = master)
>     Time (mean ± σ):      3.403 s ±  0.775 s    [User: 1.875 s, System: 1.417 s]
>     Range (min … max):    2.454 s …  4.529 s    10 runs
> 
>   Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
>     Time (mean ± σ):     154.3 ms ±  17.6 ms    [User: 102.5 ms, System: 56.1 ms]
>     Range (min … max):   145.2 ms … 220.5 ms    18 runs
> 
>   Summary
>     fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
>      22.06 ± 5.62 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = master)

Nice. The speedup is larger than I have originally anticipated, but I
certainly won't complain about that :) For a good part, the speedup
should result from us not having to do 10000 auto-compactions anymore
for each of the updates, as well as not having to write 10000 new
tables. Instead, we only write a single new table and perform compaction
a single time, only.

> In similar conditions, the files backend sees a 1.25x performance
> improvement:
> 
>   Benchmark 1: fetch: many refs (refformat = files, refcount = 10000, revision = master)
>     Time (mean ± σ):     605.5 ms ±   9.4 ms    [User: 117.8 ms, System: 483.3 ms]
>     Range (min … max):   595.6 ms … 621.5 ms    10 runs
> 
>   Benchmark 2: fetch: many refs (refformat = files, refcount = 10000, revision = HEAD)
>     Time (mean ± σ):     485.8 ms ±   4.3 ms    [User: 91.1 ms, System: 396.7 ms]
>     Range (min … max):   477.6 ms … 494.3 ms    10 runs
> 
>   Summary
>     fetch: many refs (refformat = files, refcount = 10000, revision = HEAD) ran
>       1.25 ± 0.02 times faster than fetch: many refs (refformat = files, refcount = 10000, revision = master)

Yup, this makes sense, as well. We lose a bunch of overhead by creating
separate transactions for each of the updates, but the slow path is
still that we have to create 10000 files for each of the references. So
it's expected to see a small performance improvement, but nothing game
changing.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5279997c96..1558f6d1e8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1688,6 +1644,32 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>  	return result;
>  }
>  
> +struct ref_rejection_data {
> +	int *retcode;
> +	int conflict_msg_shown;
> +	const char *remote_name;
> +};
> +
> +static void ref_transaction_rejection_handler(const char *refname UNUSED,
> +					      const struct object_id *old_oid UNUSED,
> +					      const struct object_id *new_oid UNUSED,
> +					      const char *old_target UNUSED,
> +					      const char *new_target UNUSED,
> +					      enum ref_transaction_error err,
> +					      void *cb_data)
> +{
> +	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
> +
> +	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
> +		error(_("some local refs could not be updated; try running\n"
> +			" 'git remote prune %s' to remove any old, conflicting "
> +			"branches"), data->remote_name);
> +		data->conflict_msg_shown = 1;
> +	}
> +
> +	*data->retcode = 1;
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs,
>  		    const struct fetch_config *config)

Okay, so we now handle errors over here. Is the handled error the only
error that we may see, or do we also accept other errors like D/F now?
If the latter, wouldn't it mean that we don't print any error messages
for those other failures at all? That might be quite confusing.

> @@ -1808,6 +1790,20 @@ static int do_fetch(struct transport *transport,
>  			retcode = 1;
>  	}
>  
> +	/*
> +	 * If not atomic, we can still use batched updates, which would be much
> +	 * more performent. We don't initiate the transaction before pruning,

s/performent/performant/

> +	 * since pruning must be an independent step, to avoid F/D conflicts.
> +	 */
> +	if (!transaction) {
> +		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +							  REF_TRANSACTION_ALLOW_FAILURE, &err);
> +		if (!transaction) {
> +			retcode = -1;
> +			goto cleanup;
> +		}
> +	}
> +
>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
>  				   &fetch_head, config)) {
>  		retcode = 1;

Don't transactions handle D/F conflicts for us? Isn't that the sole
reason why for example `refs_verify_refname_available()` accepts an
"extras" parameter that is supposed to contain refs that are about to be
deleted?

Patrick
