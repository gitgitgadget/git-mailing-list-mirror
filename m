Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96284CCDCB
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545196; cv=none; b=qNZdkBy7TIcAAd7+320mRaKkfO9K1BNZQmZcr2CIBGOqJNX5p+ZAFdph/LoVTk85ULTkOd6Xeou1bhhCyOoPa8hb7jLImfA34lJB1QFeXWaNN+eE+pzQGwGpuLI+MoculriXGTe8F9Ee0/ujhDngLYuhBu/snt1RhbXmReyVcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545196; c=relaxed/simple;
	bh=u8QXIi2kTs74z8FULtiUxQ8xp0A/2TlWCfn8t9jpDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKVhvWH1qmJqXN/3OyWggqokB56wr/FI+ZiUbLZqsftEc6UKt25K7rY9hbPr256lzVSynM4+N09k5zwiIcX/VYc7s6zv+7QdpmiZegpW/upPuMIcMkt7mS87AE+ZhgU3KQWaEcc1E/HBHMb47ts3A1PGOeYsKbMHUhDxCLG/kCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oX50b+Bh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9cyjXp0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oX50b+Bh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9cyjXp0"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E15B1400112
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:26:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Oct 2026 07:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545183;
	 x=1791631583; bh=F4AuN4BnFf9uSZFbyUcYb1foYkLnuq9nUgRFbVJUu9w=; b=
	oX50b+BhXLKFmCwo8JOHD5b/q5GGto9yfZz9Sl5StfzQgrzaUgflnLAauIeYPckt
	dzkK+zSg5jezmNk+SLn+MBgPRwkE+ehCnFuSdKuC7esIALk9UFir10W/PHOr3Ozw
	Vqr0TutrLgW9OQ5eBQlPBMkxRnqrYIzlx9TbxFNfM9JgFDWXX2bjS1ey+OsWj52F
	TmwLC2S5p+4YR7eRmw6nI6ZUMmLtmkgGGoD/xV4vuV1yfvJc2LdDah6LzJ7In+UT
	l95g4a0ddkjw/bfsnBui+0zYaMIufps7XKfjiDlLIMaVX0GKgm5VoX7irHy5gLUi
	xa3XJ80ljQG1PR34Uh1p9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545183; x=
	1791631583; bh=F4AuN4BnFf9uSZFbyUcYb1foYkLnuq9nUgRFbVJUu9w=; b=d
	9cyjXp0J69qg0TlDBaobDZVh3DX+8UijGesFsSSOqBqLLqIS9XWjFk/UENzK5yEf
	2n280LRLwQAqk4xzT3ooz+XWrsR+ZMc2K7DVJPv3RMPU8iaOMo3vrMO7Um/rG8xH
	3/KK1HuShlbFrGdJY2pTvxPF2zwmmfV7JTnO/utMhB9lQWEWtgYYT8IFcvQKZGHp
	IiebrGA95PVHUSl7JdEI0GFf37RCsGi56bEX/ouqcA7/5VBTeICYaEDn8AS/oYFf
	j3U2/WVs7ZXTfAo/Jhiw3qAzlUyJtfteppMncL8cwErtRdxWCbgE2kRCjXPhtP3G
	CJepMsZf8leZkzysFNPWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545183; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RgaNP51N+8okL90WCzFTp/aSxXbd9TPM71S5dNosM4lLAbh
	YI74g/2qWy3osJBOcBXKsaqpc7wmZu1IA/4S15NFgI2DWU4R2awbP1CLvwoLM5X5
	rQPBQTFJNVQzejOBkYonisp90Bgc9xXOU+I0F0/rEN6F3+dMXMEh/qSvkavts5hU
	A4iBgknB8MzBHuwtAPSvSE7E6Fhq8JFyI6DVaN7IgL0PKQ59tI3EPjf6INBBSAoY
	Rn0hK5euQj7kzq52gEE0TE4Q1tNlhgzT7c3f/HRtMrt1ZYuWNo03k/liE6ZdeTof
	c6vxWTwTsAx6l6WBCKpRlD3yiNKLE64wvio+HIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qdOyRlVgRFcwnigy+ozK6H948NBgyvT60iZLpayfqKI=:u8QXIi2kTs74z8FULtiUxQ8xp0A/2TlWCfn8t9jpDUM=;
X-ME-Sender: <xms:X8_IagXuBJQcJrenzj8r-Uc63ZSQ6l2I_l9uHuOP_ba7X55iEQmOqg>
    <xme:X8_IasDNX-gahsNYiefp7rvGcmSsad2awSPQZ8xDU59xgBSYGnzcQTRxbtg9r5TGH
    Rb6DJ2R5ZxOT7P7Ud52BcYi5RDx6Pg07HNHUbiR9py6nwULFbw2CfA>
X-ME-Received: <xmr:X8_IahwjI2W4X3HlFnVSHSWVeNazl--LrSn0ktcenV5XYzZfTbor7MGh8gWusaHdDku15Q>
X-ME-Proxy-Cause: dmFkZTFhUjZf5icJyVLVLi0ehQJ/dxtKYfUnGOW/YHLmFj+PpHp3LtB1RMAGJxTxdWPoih
    KQDuYE9cGdDHcewvA+ZLp6eL1uHalinfP3JzpRN4+qI94PUG/ckp7UrlcPT9Vull4M/tuF
    FKDUCg0eeK47FcVI47YGjM9p9WFWY+ElaDZDoofiNg7ggGfLp/mEiAuyIlhzk5O3SJD5hs
    qqrUtHys626d7AQu1puXc13CDjRIyiMByk+F9QTRhNy4qmgtdOkAIc5Urv02k7O8qTu6y0
    GvomDWOAxh+Xox3CMrwQN5BQdvTPx4Lua0qXMfWY5+aSeLakG1HmtnqWgqw3HDjmOYUbYa
    hbhnlOAlE+f+c504esjdx9Qvn9vaoXpyW0oA7dQGYPb5ynRlA/20tmm9oeVAoFzEON2M+C
    jjXguatH0NURLqkLRjtxUPRWWbWwdaSyKT4ENNLkogEuZ7lW5znlzqj7CXWfIrubOcPW9Z
    A2MFTiE/mnBDsFTMhDwxDYKg0Kj2GUnlfsXqsIABXYndKR149RQOYlaiwSAnJ2djj6uzwD
    XjeyMKtH6DfeqLWG5p7GaGOf1IsRLykAGtK6ksPsw0WKssOyWd2AqawkxW7ECQ1ONuV0sA
    K9Z2N9RU7IbbH5LhSlc17wAKVB6HYMni3I2cRUe3dyG/ikONiYi6G0JTADfQ
X-ME-Proxy: <xmx:X8_IapCeGzCNyiDmMQQ0IBeYVxlobu62bNmb-fpnyQCOCA-2ThW70g>
    <xmx:X8_IauZeWcNoQLPRthNZbB8UTZwbk4qJexfPKu0UmWlTcNglPvvvUQ>
    <xmx:X8_IahiN6XIHLJK168GNSB4UL9ntjzDzDcaIs3k1QGDfR_kaynR-_Q>
    <xmx:X8_Iag6tJxJH3CfecP7srnBt3b0ZFLDtBiIvENtggN7o7az30Fod-Q>
    <xmx:X8_Iars0oFUuuI_XysMJBoOqmJYfbEVxNDIm1DaHZfawEv5XLIjSNZfq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:26:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42a93a14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:26:19 +0000 (UTC)
Date: Fri, 9 Oct 2026 13:26:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>
Subject: Re: [PATCH] fetch: commit references fetched before backfilling tags
Message-ID: <asjPWXAO3Cwpkerk@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>

On Fri, Oct 09, 2026 at 12:10:37AM +0200, Karthik Nayak wrote:
> In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
> fetch code was modified to use batched updates to provide a good
> performance improvement. Wherein batched updates were used to fetch both
> references and backfill tags.
> 
> When using batched updates, the references aren't yet committed to disk
> when we start backfilling tags. This means in situations such as shallow
> fetching the negotiation during backfilling tags, the client doesn't
> have any references to report in the 'have' section. Since backfilling
> doesn't use a depth limit, this can cause the server to send all the
> objects present in the repository.

So in my own words: the server sends the reference, we queue them in a
transaction, but don't commit it yet. We then try to backfill tags, and
because we don't have the refs committed yet the backfill will think we
don't have any of the relevant commits that those tags point to.
Consequently, the packfile negotiation will result in way more objects
being fetched than necessary.

This makes me wonder why we even do a proper fetch. In theory, we could
basically just ask the server for the individual tagged objects without
performing any negotiation, right?

Or... well, would that work with nested annotated tags? No idea.

> Fix this by committing the previous batched update and initiating a new
> one for backfilling tags. Also add a test which captures this regression.
> 
> While this does make it a little slower than master, due to creation of
> two transactions, It is still faster than not using batched updates:
> 
> Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
>   Time (mean ± σ):      1.468 s ±  0.041 s    [User: 0.839 s, System: 0.587 s]
>   Range (min … max):    1.427 s …  1.558 s    10 runs
> 
> Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
>   Time (mean ± σ):      84.4 ms ±   1.7 ms    [User: 60.9 ms, System: 25.8 ms]
>   Range (min … max):    81.4 ms …  88.6 ms    29 runs
> 
> Summary
>   fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
>    17.38 ± 0.61 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)

I was expecting to also see HEAD~ here to back up your claim that this
is a bit slower than master.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2decc6cfd..68b04d0f8a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2076,6 +2076,27 @@ static int do_fetch(struct transport *transport,
>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>  
>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
> +
> +		/*
> +		 * Backfilling tags has no depth limit. If we don't commit
> +		 * the fetched references, the backfill will report no refs
> +		 * in the 'have' section of the negotiation. This can cause
> +		 * the server to send all objects.
> +		 */
> +		if (tags_ref_map && !atomic_fetch) {
> +			retcode |= commit_ref_transaction(&transaction, false,
> +							  transport->remote->name,
> +							  &rejected_refs, &err);
> +
> +			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +								  REF_TRANSACTION_ALLOW_FAILURE, &err);
> +			if (!transaction) {
> +				free_refs(tags_ref_map);
> +				retcode = -1;
> +				goto cleanup;
> +			}
> +		}

Okay, makes sense. `commit_ref_transaction()` knows to already handle
the failures for us and print them. And `rejected_refs` is basically
being treated additive, so if both transactions have some failures then
the map will contain the combined set of rejected refs.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 300bd5396d..81865c1ecc 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1942,6 +1942,23 @@ test_expect_success "backfill tags when providing a refspec" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'shallow fetch does not fetch objects again for tags' '
> +	test_when_finished rm -rf source target trace &&
> +
> +	git init source &&
> +	test_commit_bulk -C source 10 &&
> +	git -C source tag -a tag -m tag HEAD~2 &&
> +	HEAD_OID=$(git -C source rev-parse HEAD) &&
> +
> +	git init target &&
> +	git -C target remote add origin ../source &&
> +	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
> +		git -C target fetch --depth 5 origin &&
> +
> +	test $(grep -c "fetch> command=fetch" trace) -gt 2 &&
> +	test $(grep -c "fetch> have $HEAD_OID" trace) -eq 2
> +'

You don't really verify that we don't re-fetch objects, you only verify
that we provide "have" lines to the remote side. Which is ultimately the
same, but in a bit more of a roundabout way.

Thanks!

Patrick
