Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA4396D03
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086216; cv=none; b=Ye5IKxOg+TwQAovl1m6hl5ZZh1wgCrGWprpgiETUqBQjMxo7+QQ6nchjtg4M0IH/YMfs9OLOK4U/5pLuI+yVxXwjlwqdOdOXkCwKqWBt4irV6IQkO0/0zgJZEkRF5AjoSptep9w/RJE1fovNE+rH/+jvsDtGS1aa1DNctHyEfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086216; c=relaxed/simple;
	bh=QMdPrip/QTfaK2poMP9Zw4ZI6R2k7hnBLddMv5SeaUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCoTT0iXL/OoeQtSxXh0pAsHoS/X2mBb+jj7kTAmf/XwztYSOIqfCnoraolMiR+0KfHxUJzSyo+QMLmzRQyXpj71GawOvLgqe5UeiebECMX0ayB+nviKqLnZ8lwP71LwsLwsGxNPdD99wlBIS0lE9htefkXKfMZ3CrPdui4xZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WqU/7YlG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l8Wspd9X; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WqU/7YlG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8Wspd9X"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E95A14000B1;
	Fri,  7 Aug 2026 03:03:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Aug 2026 03:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786086213; x=1786172613; bh=kVxnQj2E60
	g83TOVln2TCpve8ZKsqwwBJTBsqIzLwgQ=; b=WqU/7YlGvk3eEoaJqvRaE3QsC/
	YP+cwcwOl0BHfArBDqzcXPPQy8of53PZ+m5yRVCKGKugXOrsHMM6HzuHjajnFgrn
	4mYHleyBQ+Zvf8TpZ4ZMyK7c3Fp7JcZlysaXJ9ZAMa3eBt1KRPJgVa7h4ZZIC/Id
	WZqCHnVJD7Sew9zuYRTHq7VN/a8vxXfWhuouI9NrcXuWBLteMVBR66ULAypfOyop
	4uyWUFEUfNjM83KTRhe/Dvh/KkGPqr6M/u5bpjBKob0GzZv9Fl8NblykhRy31G9T
	3NZtIkyqIq0lVRDdNOzL+giYCQerHAiXk/jVgrNMY9wwbjeIid8Q73SyTbmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786086213; x=1786172613; bh=kVxnQj2E60g83TOVln2TCpve8ZKsqwwBJTB
	sqIzLwgQ=; b=l8Wspd9XKTeQ3ExJHC9D3WXvY/C7pXxwDC9OrXvNp4xiXCsmbeN
	iTI4WWqwk6KCctZ4U2LaZMc7FZvZiMP2z9lrYvgW+T+4EjUfl3NGVgKoFd4whmVj
	vC0u2W2gfFjYr3IzVZwCLW5WQf2bQw51Xpi7t3lCpFMQv/zFGBEVgwXnW7zrM5M1
	TdB+vdC/0vbL23E0W1lbs1AMxV2M/Ta9IglIkcWmZqReTJ5OLKje0vS73zXTmQ9m
	hVwxi92NNB/BCv3bybVwrh7UD87M33ISY4SUEnRY4gU0iGt3SMEEWbBwdaDRQdaL
	rpHJEy0vtDgnW2IGxdBflDjBbPxpGNS5KVw==
X-ME-Sender: <xms:RYN1aq4v7Kiqup8MzLi_ki-sCynoMBEcr2ItjSiAp0UDEbn6b7Ac1A>
    <xme:RYN1ap5AYtDJ5LksTEX6oAnoZnwrW5ivUX8vSlMjnFHe7yGF9BO8eDfB1tgIkFnAD
    LznV2gMqzpzzGN0RTY_MlD1JaS2q31zSb5l4f8lnSK3k3ja4eSndg>
X-ME-Received: <xmr:RYN1anFt1MmqbGipDKzImaMWE3rZhyG0puJdIjyv3tAvasRRAk5WyhR-lqa3f0jf_rdNa7zwphu8lsFHrpqDtWcTbFcleEswCzWOKoZ0Rx0ovQ>
X-ME-Proxy-Cause: dmFkZTE26y9njCNpXPcmZxYe4ifaNpV+sYlC5mYRUIr+ln+pB38Sh4kjo5WX0zU5LY8sit
    +oeUUeuwuVDmjatud2iyJtMdnBGrHtsLnRGmbTcsfv4XslNEpw1gmYRc4vkyxvvkVzb6bZ
    FW+Hc4Ewp0bN9yMqVLHrPU0VZXSxvfa2uONHO4C1LZMZN/4xo/SlyjWqoa1PpzuveaGMel
    tb8CZN49JwAhjMMI8vzeUDPe9GRJE1Pij+NlRwONiI8W2cbrpyJAIUbCY4UmewvnRVelNo
    mmLmZkIFSOfTf9/ExxwJZ9KjT4RrzlQa8TreUzcLYfr16STGdtDWK6anYTN5DZxvjKF6bs
    IyYTr0laDxaAQphaTr/7Asw0XnJnR4WYWKmZdeZHEOfRvokuJB5oWqMKVyHX/dndTbakVl
    b33WkWKa8UbLHm8oUrvTpY2EoK58wCfps7p5/D12a+GfMRu1GvrgEdw1VAEa9Kn6ht3nL0
    md7Je42FPLegYSjJJoQ9aYtyeWdqoOmwlpIIyz0L66O/8jUDwEzv4UWBpACzLBkFP7BtNX
    4F1rjhyqO0uLs4hYPcx06TLxDG70gE2OBLD/2nCFGyMTjSdvRqKYQP5m3epLgNMK071rnh
    ZjzbIhCve/Kqn6CST70rWmbZ/+rYZelGbzCDaqU8NWAP4HCnQ5LZCd9kBZTg
X-ME-Proxy: <xmx:RYN1aiRozNP8EODhBUFafZXCdRWKvDxHX_rYKtYlT4wc382nqXj5Vw>
    <xmx:RYN1agstj_YHzei6jwN0C60KnyMkpjzLhDT0bTFruWBA4dHA3zQJYQ>
    <xmx:RYN1ahz7KUtlI906IdmeRkX3fzFIQDBQjTClvh6IaxDIYmulBCyHIQ>
    <xmx:RYN1aq7F31lBrVQmkjjLkeGQCWspy1jhLgJ0BTPftjam7Gr-FufYyQ>
    <xmx:RYN1aor1mUdef1hLet4SPvafYuyz4ALCfTiDNzpCeuhPbCGL7VTZoweN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 03:03:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 895de002 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 07:03:31 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:03:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] odb/transaction: add transaction release interface
Message-ID: <anWDKwkRp1EK9NRi@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806213859.816157-2-jltobler@gmail.com>

On Thu, Aug 06, 2026 at 04:38:54PM -0500, Justin Tobler wrote:
> When committing an ODB transaction via `odb_transaction_commit()`, the
> staged objects are made visible and the underlying transaction is freed
> at the same time. Coupling these two steps does not leave room for any
> post-commit transaction operations to be introduced though. Such a
> capability is useful if an ODB transaction backend needs to hold on to
> lockfiles after transaction commit until references are updated, as is
> the case with the existing "files" backend in git-receive-pack(1).

Right. We don't want to remove ".keep" files until references have been
updated so that the potentially still unreachable objects won't get
pruned. And consequently we have to introduce an additional phase after
the transaction has been committed but before the refs were updated.

> Stop freeing the transaction in `odb_transaction_commit()` and introduce
> `odb_transaction_release()` to explicitly clean up the transaction
> accordingly. Note that the release interface also provides an optional
> callback for any backend-specific deferred cleanup. In a subsequent
> commit, the "files" transaction backend will use this to remove ".keep"
> files generated for packfiles received via git-receive-pack(1) after
> references have been updated.

I'm not a 100% sure whether I like "release" as a name, as it typically
indicates that we release memory and other resources hold on by Git. On
the other hand we also kind of release state in this case here, but it
feels like the consequence of that is broader than it usually is.

How about we call this "finalize" instead?

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 86933d8d7e..420de9aa7f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2714,6 +2714,7 @@ int cmd_receive_pack(int argc,
>  		use_keepalive = KEEPALIVE_ALWAYS;
>  		execute_commands(commands, unpack_status, &si, transaction,
>  				 &push_options);
> +		odb_transaction_release(transaction);
>  		delete_tempfile(&pack_lockfile);
>  		sigchain_push(SIGPIPE, SIG_IGN);
>  		if (report_status_v2)

I think this here is the only caller that we care about where we release
the transaction not immediately after committing it. This is because
`execute_commands()` is the function that's responsible for updating the
references, and thus we don't want to delete the ".keep" files before
it.

It would make sense to single out this caller in the commit message.

> diff --git a/odb/transaction.h b/odb/transaction.h
> index 4cb2eafcbf..ec0b27c449 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -75,6 +82,13 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
>   */
>  int odb_transaction_commit(struct odb_transaction *transaction);
>  
> +/*
> + * Releases an ODB transaction, performing any deferred cleanup and freeing it.
> + * Must be called for every successfully started transaction. Note that, if the
> + * specified transaction is NULL, the function is a no-op.
> + */
> +void odb_transaction_release(struct odb_transaction *transaction);

Should this function be able to report errors? Cleaning up ".keep" files
can fail, and I'm not sure whether we should simply ignore those.

Patrick
