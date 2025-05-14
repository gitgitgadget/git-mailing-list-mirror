Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AE1C8614
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225881; cv=none; b=ZfxnXTWfXtjBgSXibKWeqXfEU6Zyoel/AXB2Qg/30uARLrcYyw09l/97VaCrZu/XEAsDcMlZYzSNQ2+MlGgxu3kjUuIAEmalqvORyH6QLDTykR6JnoVZgzKp+yk52XZD2WXIAwNRWW4W2Ndxv7jz/uE1aEQhBNZiPxzA04umxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225881; c=relaxed/simple;
	bh=mTFHKNpnxwJ/4mBSttIRTC4+aut+qAuQEMbzLf6X5h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkW6s+Noirb+cvvxb/rY6xPpVYJnw+yIv0p7uOonrk7PsTpWM5xJNok8WrhiJ4c3vGOgLNpkRni04i9sO5RMFzpDmEx/iebdNrDexR3w225JbeSAMFFSb631CAAyGzpzhYRoocX51O1LfroY5wA3BWJ7Oh3ZxssJsSNKFRIbqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0+91iPrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGBKYWqw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0+91iPrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGBKYWqw"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 116FE1380313;
	Wed, 14 May 2025 08:31:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 14 May 2025 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747225877;
	 x=1747312277; bh=TQYsqKrz1rojS8ashTsvEwkhSVIDjUfP2d/77qa6I6U=; b=
	0+91iPrTL+El//UZ3Lm2+2MI+MD7iiiaj6wkQVZFJXIrwHgRloNucpjoFsU6cRmd
	m+abRb5HpEUD3IB+KqWCWoPUK0HkuVYwCEhEB/OooPfs3uPgm0qopAzznjzQKJNe
	fj3fTu3J5iIofHewu6zCKOum9vDQ73CScrbSBqLLany1nysjshHOvkCVnpZNGlPK
	1/SBbQ45cJnwt87ozn8fYD4w9xwhwk5HX96olAH3MuYCLlO4uaaCoyb16yQYzFFQ
	Jg+gTafGLmlEJ1Gba2VayvZ1i9m2hjFpQSrug65nZNwqCymITzigyLJTJ0beXMK1
	GBEfQw8eXHxOB72BVp9etA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747225877; x=
	1747312277; bh=TQYsqKrz1rojS8ashTsvEwkhSVIDjUfP2d/77qa6I6U=; b=b
	GBKYWqwrO/uPhFNJjAYacriJ9Q8poZC9bbPHev0Ui7g+5OYqi9Nk5ZknF/DnKRV/
	44nT+MT6VdKt7ZUuQgXaXoI6NUY2xzIjVSA276xt1ngrldEE5LT/VHVV0s7mzCxd
	ZlI8sSDpy8d4wpOQ56o8t58QeVxLcMErikAg6canUsTKXL0oTMx2JsDzIKzOS7Y4
	ei5rQaiQBTihEtMf8O5bmj4ivjuIFK3INep03ox/4Rk+T4u/g8GeBKJGbGsKtf8c
	PRRRbkUURQDDnzYECoNpO3qKHf0F1pCd2dYhLKayEgb3Mlqg3qkCy78JF9OU6vDc
	C8g4YM2vYfBcWpWvWybRQ==
X-ME-Sender: <xms:FI0kaMwCuIj1ZBIHsla4PLHdu3Z5bWa0c9c1vuD3f0LYd35kYqtWiw>
    <xme:FI0kaASV4kxuoXqxWyWjk8PFfD1E3M621H2ElOL7C2o_FiGLUw26m2cHkkkpcmEA8
    v7udjZXRyaSx4y4jA>
X-ME-Received: <xmr:FI0kaOViax3GkDvCQ31CVA_RU8kdwh_AVCk2ouTmGHGKZ3CuJJMuQF1fZZWXZIc2SeMqBc1WD_5ceIQoqt5ytJpViIREJmy9Z1Vum0Q76lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeileelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FI0kaKhFkgcr37T8PTV62PYqT_tHMZgrg98juyqlQqqXcl8p7m2zmg>
    <xmx:FI0kaOBcAMcxVD2PoX1Gkxl5IVg5Jg0P7KqwieWrr4BdTE8Eutchvg>
    <xmx:FI0kaLJn_22l2p84B6Lt-dix7pG9Vty-erNi3SVB_22OLdm23_59aA>
    <xmx:FI0kaFCknrMTpoPNR0uw1KwpBUT06oTWOdwZauDiZ15CtY9-4i2HpA>
    <xmx:FY0kaL_tVIhxp8fDtNmET_pJJPrxSfZlonTih-pmlYozy0Pktxw44Eio>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:31:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cdd0d1d9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 12:31:13 +0000 (UTC)
Date: Wed, 14 May 2025 14:31:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH 3/3] receive-pack: use batched reference updates
Message-ID: <aCSNDbUX-MMJZj5S@pks.im>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-3-7c65f46493d4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-3-7c65f46493d4@gmail.com>

On Wed, May 14, 2025 at 11:03:49AM +0200, Karthik Nayak wrote:
[snip]
> With the reftable backend there is a 18x performance improvement, when
> performing receive-pack with 10000 refs:
> 
>   Benchmark 1: receive: many refs (refformat = reftable, refcount = 10000, revision = master)
>     Time (mean ± σ):      4.276 s ±  0.078 s    [User: 0.796 s, System: 3.318 s]
>     Range (min … max):    4.185 s …  4.430 s    10 runs
> 
>   Benchmark 2: receive: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
>     Time (mean ± σ):     235.4 ms ±   6.9 ms    [User: 75.4 ms, System: 157.3 ms]
>     Range (min … max):   228.5 ms … 254.2 ms    11 runs
> 
>   Summary
>     receive: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
>      18.16 ± 0.63 times faster than receive: many refs (refformat = reftable, refcount = 10000, revision = master)
> 
> In similar conditions, the files backend sees a 1.21x performance
> improvement:
> 
>   Benchmark 1: receive: many refs (refformat = files, refcount = 10000, revision = master)
>     Time (mean ± σ):      1.121 s ±  0.021 s    [User: 0.128 s, System: 0.975 s]
>     Range (min … max):    1.097 s …  1.156 s    10 runs
> 
>   Benchmark 2: receive: many refs (refformat = files, refcount = 10000, revision = HEAD)
>     Time (mean ± σ):     927.9 ms ±  22.6 ms    [User: 99.0 ms, System: 815.2 ms]
>     Range (min … max):   903.1 ms … 978.0 ms    10 runs
> 
>   Summary
>     receive: many refs (refformat = files, refcount = 10000, revision = HEAD) ran
>       1.21 ± 0.04 times faster than receive: many refs (refformat = files, refcount = 10000, revision = master)

We see almost the same speedups as we saw in git-fetch(1), and the
reason why we see them is basically the same.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index be314879e8..b4fceb3837 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1843,35 +1843,91 @@ static void BUG_if_skipped_connectivity_check(struct command *commands,
>  	BUG_if_bug("connectivity check skipped???");
>  }
>  
> +static void ref_transaction_rejection_handler(const char *refname,
> +					      const struct object_id *old_oid UNUSED,
> +					      const struct object_id *new_oid UNUSED,
> +					      const char *old_target UNUSED,
> +					      const char *new_target UNUSED,
> +					      enum ref_transaction_error err,
> +					      void *cb_data)
> +{
> +	struct strmap *failed_refs = (struct strmap *)cb_data;

This cast is unnecessary.

> +	const char *reason = "";
> +
> +	switch (err) {
> +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
> +		reason = "refname conflict";
> +		break;
> +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
> +		reason = "reference already exists";
> +		break;
> +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
> +		reason = "reference does not exist";
> +		break;
> +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
> +		reason = "incorrect old value provided";
> +		break;
> +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
> +		reason = "invalid new value provided";
> +		break;
> +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
> +		reason = "expected symref but found regular ref";
> +		break;
> +	default:
> +		reason = "unkown failure";
> +	}
> +
> +	strmap_put(failed_refs, refname, xstrdup(reason));
> +}

I'd have expected something like this for git-fetch(1), as well, so that
we don't silently swallow failed ref updates. Would it make sense to
maybe provide an array of reasons by enum so that we can reuse those
messages?

>  static void execute_commands_non_atomic(struct command *commands,
>  					struct shallow_info *si)
>  {
>  	struct command *cmd;
>  	struct strbuf err = STRBUF_INIT;
> +	const char *reported_error = "";
> +	struct strmap failed_refs = STRMAP_INIT;
> +
> +	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +						  REF_TRANSACTION_ALLOW_FAILURE, &err);
> +	if (!transaction) {
> +		rp_error("%s", err.buf);
> +		strbuf_reset(&err);
> +		reported_error = "transaction failed to start";
> +		goto failure;
> +	}

Okay. We now create a single transaction with failures being allowed.

>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>  			continue;
>  
> -		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> -							  0, &err);
> -		if (!transaction) {
> -			rp_error("%s", err.buf);
> -			strbuf_reset(&err);
> -			cmd->error_string = "transaction failed to start";
> -			continue;
> -		}
> -
>  		cmd->error_string = update(cmd, si);
> +	}

So here we only need to queue each update.

> -		if (!cmd->error_string
> -		    && ref_transaction_commit(transaction, &err)) {
> -			rp_error("%s", err.buf);
> -			strbuf_reset(&err);
> -			cmd->error_string = "failed to update ref";
> -		}
> -		ref_transaction_free(transaction);
> +	if (ref_transaction_commit(transaction, &err)) {
> +		rp_error("%s", err.buf);
> +		reported_error = "failed to update refs";
> +		goto failure;
>  	}
> +
> +	ref_transaction_for_each_rejected_update(transaction,
> +						 ref_transaction_rejection_handler,
> +						 &failed_refs);
> +
> +	if (strmap_empty(&failed_refs))
> +		goto cleanup;
> +
> +failure:
> +	for (cmd = commands; cmd; cmd = cmd->next) {
> +		if (strmap_empty(&failed_refs))
> +			cmd->error_string = reported_error;

The reported error may have one of there values now:

  - The empty string. Is it correct to set the error string to that
    value? Shouldn't it rather be a `NULL` pointer?

  - "transaction failed to start". It makes sense to update every
    command accordingly, as we wouldn't have updated any of them.

  - "failed to update refs", in case the commit failed. Does the commit
    fail only in cases where we couldn't update _any_ reference, or does
    it also retrun an error when only one of the updates failed? If the
    latter, we shouldn't update all the others to "failed", should we?

In any case, it feels weird that we use `strmap_empty()` to check for
this condition. I'd have expected that we rather check for
`reported_error` to be a non-empty string directly to figure out whether
the transaction itself has failed as a whole. Like that, we'd know that
we only ever do this if we hit a `goto failure` branch.

Patrick
