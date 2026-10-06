Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B194A341C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301610; cv=none; b=eFnCCj5+PelI1wVMChf319ShxZBitIrz63zh/1rQq3gqKuB4H+FdcoOITqcgEyUtSzYhCJZM969aofl6IIgMFS9SlDD2vCkP6BoaxUkJfyMVbzd+npod2ObiR8a+X1q+HJI+4anEJNLOLZZe8twkKjV3EKDAHw6vmt/iSoyptpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301610; c=relaxed/simple;
	bh=DqZkPgtLOUAp87nVCq5ds3ME4WzKU9YRbkW7AqPFXpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9/ofbX+6DjDaeGfimRU3wdrptL+3OS09DjyjmnijNgwOBcarYzm2S4kABxVtp2pHF9iABfpJv/RndLqMQCvZl4B1XsCbYbxSdJTztpUmCcUFvpYO9n0ZZnoEMxVJZW/fTLbvWRaX3V0kEpanPDHTNZhF2wp62WUdrQEyafF/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iJWBIBg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vel4XtJQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iJWBIBg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vel4XtJQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91E62140007C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:46:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 11:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791301604; x=1791388004; bh=dGCEqU4LmV
	8A2TnfN/wBUBbt6s0hOUaOBufy2oxaYHA=; b=iJWBIBg1KnQh2efGjrY1qlk/ru
	53SNDKxMMMGMhfRJcTx9MBu8FIQxIarfwLEGReLCBpYlaY8EpyuEm9QBjgweoRiN
	bweKzdOQbv5dlIFn72ftiritCTBkUi9ohJbBEUVc26d4ccmX0rGYCUFx7E8hjjV1
	lTMGbELrysCY84K2Np7fFd7rTi4XK13OOgfYCrROanEfQAAzLuyDUl6tVEe1ozxt
	Zri4H5Obo//ehXsd5t9828cK4T5ncSYCFC+JchCFs/tiFIGJNlk7t2k5QqiVGPr9
	39ovEYDw5sCvWHw0Xy1P3/BY3ERl2bLFH9rr1rT2gOejUKbogWY1qEl3aUyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791301604; x=1791388004; bh=dGCEqU4LmV8A2TnfN/wBUBbt6s0hOUaOBuf
	y2oxaYHA=; b=vel4XtJQwG0+Wb+6DgsvB6JzcZvmzPgQHerL9eQHsHSu5lMeKJa
	x37+DTNS05Wif+Kk9nK51+61JNcEheWEhlYSpkkbS1IU0RlWneSSY+3IuODzQ+F0
	W/Y5Ay3jZVlM8cbSZTJi5eZER3LfegTE3H1q6w4Sv6tjMwH39GlMs6id3cJQXtNS
	CdgaYd88gwVKFOKIcsXA7wZQG4KMwX4w4Oaw8pI9qwMKQZh9Hr34Ktlr9hQVk40Y
	1sbXlQ0VlOSL97gzadW5yroMBa6cYxkl35pQpjN+8Lcws4p4ih4uYfNJfH811Vco
	sQDOpDl5mZLO2xWcWNJLX5ErqrTMzFglXFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791301604; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CVeOCaSNT346x46m52kF1TtYDfYtiWUvbw2eVjhB8gh9aWv
	enHOAHUxt2D+OG54U0JXH3w2uaYlp9VBjchtcXA82fTY5awRZGWaX6/DdVLmoRir
	w1w/To4yf0MBQPduyKneCDDmEVniAqugZbz5YB+hEJwBJOG4CEbOHikwZcACu071
	u1Fns3zgwxDCdE3/27tpT7BKoB2L5aTfFbg1QIk6LSMLECTZPG1RmVepOz83gKYg
	rv90yq9t9WMLRkczwUwqndezn6sfk1TBkNi9FYY5fiYCIRM5nZ2OAjFs1E9Xenke
	HN0icVBVWQ9gLwx9iPKMx6tkgHRlrtmVTgxdZ5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Vnfna4MmYXw4PHbc59KIj8qE6b4pL9gJaoTdhrfUu1k=:DqZkPgtLOUAp87nVCq5ds3ME4WzKU9YRbkW7AqPFXpc=;
X-ME-Sender: <xms:5BfFaq2L6tPkoBIrKNQ_VLaQRzCVLZKDWqP7fTi-KdDZn2hKQpjmHA>
    <xme:5BfFaj_NA9mC6QXfYTCb9JUoSGRdKZ-lw69A1XUikVZ9lFUXLGnEVr9bDD0jKxF3H
    ryD-byHVo2NhduEAKDLlOfITffDClke2Y6Ij_SjnZ9oaXa-ycb8CBg>
X-ME-Received: <xmr:5BfFarOQK0yN3SfFEyh9M4LkN1kZOTmb9I2A3JUFABqwtYeELV_s7SOTO5P1LOL1x5doikS_ph8WRz2DNy-aAA5ZlM-C0jtligcn>
X-ME-Proxy-Cause: dmFkZTFQCz9/s7rIcYVYyfP9jIGq5/10+9jgHk4/JBiE9dTEv1pIkxS/sshXy0LRB+xaZi
    yOGOipkN5ROsMZLypA+p8dA/KCiOtgMpzX/tkXzTOzeIGaRwbTq9SbYdd0U9V4TkKfFyEh
    n1qDoZ8FwDX+pm5Ngrch/E/NGmNNHV16yhscvkPonOX82g3hkKaAnJM2S0vdpSijOJ5lPy
    l9cJ3Dksrueb7Sj60PZWl/DzEEfasTkNOlBH8ChrzlLUVDhqTIljowd/QdZcB01xNk1CHe
    bseF+HY5OqijJ9/kBz7kvlL8+NpaLrBaHzuoS/gcBYPw0m11rKDeFI1W6D+zFnY2KOmNF9
    MJh8ykfqPGoGmqtgcG1oIh3nmLcjlzt3sfp+oSS7smzBDeWa8qUgzZZcnxicwskrQilkiW
    ecgQZ0Of41s8DFLAH4PAtViWYqhkov67ecIxm1rQ8lmIdjw7CruXyjo2mCmhqZ55D83jEx
    ITtuX4f+ThyVUiNfpANaxe7ZPrQKHG/F/t4pDTnZuNI4jhKWMt3+CnEL19O3n0+PhUrcVd
    UiGSM2c0feHMn2ie+Ka4bKwyv0D4cmZVYQQBQECCfcti9lfgrKfUDul6Fhz/WBv+q3b1hG
    RoUOp+0riPtLRUSlQ0YofzPUydTc6EUFc0AEQLnHa+4F+ImdNWeT7x3VVOYQ
X-ME-Proxy: <xmx:5BfFaneYMrdz-F6J1DxWpoy66EAmLyAu2yCsVmMyiceNL_tYY_toLg>
    <xmx:5BfFaqWRT2qqmwZmK8NH-zeHa6_Cc02qRJNvEj63JKR8kEjvGrd0aQ>
    <xmx:5BfFavia0x7lbYeOMxrh4qnPiC5DsrypJtsi1sAxPCcq_mRZ5Vm2Xw>
    <xmx:5BfFap8TLYDn5TeE6TazmmGzwF9YyzrFUZvk_xtyqgdpp61R-67_vQ>
    <xmx:5BfFahNZCpZNzyAhFFNBNmUWo5yhsWremswktyv0qt4ssOPhrCVKX7n7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:46:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] merge: remember conflict labels
In-Reply-To: <18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 5 Oct 2026 14:24:49 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791206658.git.phillip.wood@dunelm.org.uk>
	<18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
Date: Tue, 06 Oct 2026 08:46:42 -0700
Message-ID: <xmqqh5iyg7bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> @@ -4969,6 +4973,13 @@ void merge_switch_to_result(struct merge_options *opt,
>  			return;
>  		}
>  		trace2_region_leave("merge", "write_auto_merge", opt->repo);
> +
> +		trace2_region_enter("merge", "write_merge_labels", opt->repo);
> +		opt->priv = result->priv;
> +		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
> +				   opt->priv->labels[2]);
> +		opt->priv = NULL;
> +		trace2_region_leave("merge", "write_merge_labels", opt->repo);

A "if (result->clean >= 0 && update_worktree_and_index)" condition
guards this code path, so we unconditionall call
write_merge_labels(), whether the result is clean or with conflict.
Am I reading the code correctly?

> @@ -5234,6 +5245,14 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
>  	 * to move it.
>  	 */
>  	assert(opt->priv && !result->priv);
> +	if (!result->clean) {
> +		opt->priv->labels[0] =
> +			mem_pool_strdup(&opt->priv->pool, opt->ancestor);
> +		opt->priv->labels[1] =
> +			mem_pool_strdup(&opt->priv->pool, opt->branch1);
> +		opt->priv->labels[2] =
> +			mem_pool_strdup(&opt->priv->pool, opt->branch2);
> +	}

But we only populate the labels[] when conflicted.  What would we
write when we do not have conflicts?

> +int write_merge_labels(struct repository *r, const char *base,
> +			  const char *ours, const char *theirs)
> +{
> +	FILE *f = fopen_or_warn(git_path_merge_labels(r), "w");
> +
> +	if (!f)
> +		return -1;
> +
> +	fprintf(f, "%s\n%s\n%s\n", base, ours, theirs);
> +	if (fclose(f))
> +		return error_errno("could not write '%s'",
> +				   git_path_merge_labels(r));
> +
> +	return 0;
> +}

Would the answer be "(null)\n(null)\n(null)\n"?
