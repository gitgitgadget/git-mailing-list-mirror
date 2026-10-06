Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE1378828
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289925; cv=none; b=AV2pzSsxpWp5tHRbbhk+wD55suqoaMIdMkwiC6fL8QBDGdXHBnL99xel3if9yOm8wGPa3lHxEW0Bi8pqc1B9ffTvJf6qjbIU/tPXHTkv0krioVQmPeuLwO1lywy69s7roFoWuaCCZLRfxs4kP53VKHpytbNhQ74rBGHwkk59VEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289925; c=relaxed/simple;
	bh=bGCoOr/Ppxj6yFv8Hj7ROWFwahjbCPtAuNLtoVDpPMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otlUUBi20BAAgNIiTVVXlRIMjPLQMYod92IkXsmqc7P9G/DvH3ltdIvVxFCVfZ/8mfb6UaEi1A97CAiU018sir+MYxXsWtkYLHzqwqBWxFseaGzaZ+842EOl2yNW6Cyo6H4N6CvXOPzsfn2jHUH36Z+vKzeG/QXJLMexw/ybxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eavjvlQJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sMGTcfbh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eavjvlQJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sMGTcfbh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70CEA7A007D
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:32:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 08:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791289922; x=1791376322; bh=myZRjhil+X
	lyjUHUBZIcqShg0BNbeQzQCwLLJt7FK/M=; b=eavjvlQJdO/SNhyPAz0Lj6FrQN
	rHYVgzt78w8xp24LDvz2tJ/4WwsL4imA1INVWE9CQvpZdpeDiqZooUvhx5rOlmrQ
	mPr4/207pOMULIvkrqgV9SNzF2/gu0Ut8RckHym3bkNXpzVBxfaNfw4oTUtqfwy1
	OA2+EIWM1+KLnytF/axo//sy03a/SPUZA6WIMfn90KHK9xD1o3TIxSaioPanMx9u
	sAk/JyHsunXl7AIIWsdwpUhNl4rr5OX0/YjT0cZkSyRFdV9SKjmm4hjgHs6Z3xzA
	fr2ulVKr1Xv3x8GXN8zk2P8IwhVO2pW6F6OhkVmW/iBCk96L67eU6iN4Hr2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791289922; x=1791376322; bh=myZRjhil+XlyjUHUBZIcqShg0BNbeQzQCwL
	LJt7FK/M=; b=sMGTcfbhHiNPRjEB9dDslWo2DHwNBHVKJScu8Q/MfMrfJUvMEVo
	OG8ZAmM1m4Yjf9EmwnYrX+ETv0umSNISuxSK5Jy7GxUW1lagTqp9FX/xFpSgFilW
	RLVFuQl0WmfPo27SDdb0X+XHUHB2iPhmW2eMLvSC1WJmmOyPVCwnQ6YCspXDt7xm
	NnavLGbcpKQssM6QAR9akmWUqYTpXtH/eoLzbQz/eV+XKJqAT63+OYBqkiYvMGpW
	cLYi4AvzeM33it7zdpUmP7lncuzr9au2A9RsvOcyrtDC62QdTqSzwMYVdsRFy4zq
	BMJkXgvWv7mdEGyqwQurWQNmFyyHcO7ClQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791289922; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KvELAo9XqXMJ0jQBDwzEm8TxntkJU/5axjr1uxZci652Zal
	Tb1i49zbyUaBX1qbBwDY1BgjDmD4G3EpJblih5py0oGU3SySJZBGU0C4rrfrDIge
	yGBT4nDyCFaEYuD/btFujETHQwYIyR77UXrf3nnyuQjoKN9LDgKbuDunrnj1FJYO
	d52FaKra1aOdiKGOKVcYwCz64S0KUHS1LwNnpEO03oCXx11DfocQjH84PXnOTGIi
	VfNXJDAnMO1i1DR9Anh1BDiuzRSoHGQ3tk32/Roqb89v8NnPKFosV+CzLMBkreHr
	E9ipE70hj7Tta++yl+WUSyFZAd6J1S3Q/Y2EErA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RWIbN8wryxQb6Aj0I1rgAQ5Roh6RC1HGzzWkEJjcD2U=:bGCoOr/Ppxj6yFv8Hj7ROWFwahjbCPtAuNLtoVDpPMg=;
X-ME-Sender: <xms:QurEavIP-ZoVmzPLs94rBavc88IBt21ay9EPnlAbWCGTy7kRzMQ0lQ>
    <xme:QurEaqktSQFWC2fbVwEAlLIbDU0iNAzoXwT3UQczwvrb-hiKtvGDBFw3cj7PiNO6M
    aywPIdtrbmte_J4G2tB7msk2AMyN1nnvqgTvOLYMqQ3tFJVBvDL>
X-ME-Received: <xmr:QurEalFPeCXNPT7BUxcYCkb2o7CLSJHsUIf_xwbM1e4FrghlhROw7VZiGxoTJMp8-5R2XA>
X-ME-Proxy-Cause: dmFkZTE7PaBuRyfloPFlxyBTgxZn64y4ID6+A2w4HXMTQ9gaDHPNUdYoI4wWhlwsGZ6Khx
    pS/Nl1S2maC+1op1V6Eecm5pzoCbQDXyfhLS//HZCQWATeILgRhGGFsbMvlM332rsIbsx6
    kn57sfvoLfyL999lsOx26nDQR0BTQcA1MSg8KpVDiKuaZ2CH2SfiweQAE7ExclugXy+MBt
    B1OSLZuib2RhuRLr/ce3h3wHKbwNx5S+LEjefN4WsIgKN4X6fithVVY1xa62YNHWDP1szh
    atZVh4sFORoh/vfB3s/GPpA/2qOGjufXrTLM3GFLSFP5CE+TA7DISWPjZwzyD1aw1F4oTp
    TcN7gJ0XB/+B2u8s6Q7p9lbysUOsFI4YQ4dw76S8rLpZco4j3bgBZ1+fWwekD8xNr5dd4e
    mJVYoL0g2ttn5XEuXW4ObJrky6eFMrVBAlqnvVWKIhfIKxirYYIGYSYjlVH8vF2hZDVQmD
    7u4I+U4c/kCWKj1cO2KyaKPSA1emSJQ03GMGllahG9EI1zVAsiJ2FfSPMzmtZzWvHy1Vkg
    XG9+lLHZzsad6/iIVhFFUgKFYkhVWXiyfGtWXCwKa6d0zLy+cUzv0cKRa4ayW5TsyYp4oy
    t8dtW+f+ED3BFyZlTKXGJMC+sQbk8Erc0JDtRc+REWrZgsMUQEekgbgHUpJQ
X-ME-Proxy: <xmx:QurEaiEP81AuxDr_2FzuVVIdOu8uorzb-8fGl0qRf4-AM6DNSiTSCA>
    <xmx:QurEaqOS4tH_KsFcJN8oyQNT3pIilJYbK0uycRQqlAjspUBV0XH8iQ>
    <xmx:QurEapFiDICLNXHj3igpaF0Kcy9MT2cy95H-LEGubdmaeWk7oeiCiw>
    <xmx:QurEapNHU68ckV6x-63jSF4H0tyv0z_LDmUqsdpVytxP9R9WeGWsIg>
    <xmx:QurEaiklUHBs_Wflnzw0cIwAiIYRsha5C02X1alNvZtm8XJSmMC4AqKW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:32:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e436b3b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 12:31:59 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:31:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
Message-ID: <asTqPcCl3RdS8YN4@pks.im>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>

On Tue, Oct 06, 2026 at 11:18:40AM +0200, Karthik Nayak wrote:
> The `write_with_updates()` function uses a `struct ref_iterator` to
> iterate over all refs to write to the temporary packed-refs file. It
> receives the iterator from `packed_ref_iterator_begin()` which takes a
> snapshot of the 'packed-refs' file.
> 
> While writing to the new packed-refs file, writes are routed via
> `write_packed_entry()` which uses `fprintf()`. Even for references which
> haven't changed, we use the same mechanism. Instead, let's track the
> position of unchanged references in the snapshot iterator and directly
> use `fwrite()`.

Nit, not worth a reroll on its own: you state the status quo and then
jump to the solution right away without stating what the problem is with
the status quo.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a73fc6aca7..43ad674cf4 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -879,6 +879,12 @@ struct packed_ref_iterator {
>  	/* The current position in the snapshot's buffer: */
>  	const char *pos;
>  
> +	/*
> +	 * Start of the current record, set when advancing `pos`. Used to
> +	 * pass records verbatim to `fwrite()`.
> +	 */
> +	const char *record_start;

The way this is written makes you think that `pos == record_start`, and
thus one wonders why we even need this separate variable in the first
place. So I assume that we modify `pos` in some cases without modifying
the new variable at the same point in time. But if so, the above comment
is not true anymore.

> @@ -1233,6 +1240,19 @@ static int write_packed_entry(FILE *fh, const char *refname,
>  	return 0;
>  }
>  
> +/*
> + * Write an entry to the packed-refs file skip any formatting and directly
> + * write to  the file using `fwrite()`. e.g. when deleting references and
> + * remaining refs need to be written verbatim.
> + */
> +static int write_packed_entry_raw(FILE *fh, const char *entry, size_t len)
> +{
> +	if (fwrite(entry, len, 1, fh) != 1)
> +		return -1;
> +
> +	return 0;
> +}

Nit: this function is somewhat ponitless as it's a trivial wrapper
around fwrite(3).

> @@ -1530,9 +1550,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>  		}
>  
>  		if (cmp < 0) {
> -			/* Pass the old reference through. */
> -			if (write_packed_entry(out, iter->ref.name,
> -					       iter->ref.oid, iter->ref.peeled_oid))
> +			const struct packed_ref_iterator *packed_iter =
> +				(const struct packed_ref_iterator *)iter;
> +			size_t len = packed_iter->pos - packed_iter->record_start;

Alright, so `pos` and `record_start` do get advanced independent from
one another. So the comment that you have for `record_start` is
inaccurate indeed.

> +			if (write_packed_entry_raw(out,
> +						   packed_iter->record_start,
> +						   len))
>  				goto write_error;

Other than those nits though I'm quite happy about this change. A 20%
win is nothing to scoff at, doubly so because reference deletions are
extremely expensive once your repository reaches a certain number of
refs.

Thanks!

Patrick
