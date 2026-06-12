Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861D3546F7
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245098; cv=none; b=p+7Wk7LTo+yMsr6tV0POgu8ZGXdmDl8qtNm2k23hu7TrY23w7DSSSfnhxj1M1v2+hOBw6yEPhjB0RR4GsKOIWix7kIqoidOgFqCOYIXujpEitZ2/8yBZSKKh7y9T8ehyseGjHsv7HCzlemx1wQw/aHY4GspoEO0PkoeCxV+Riq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245098; c=relaxed/simple;
	bh=bZr2z5kPlDhQ4Oy9HTr6v8+JBQnRzglrdD7Z3WF45Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHAWymItaNDMy+Vq4kpx639VPuVyzNMkGs+IdgywWl4ZJQTBZiNryVLwB/RziAHu4G6y1gOOZ33LABHr4oybFLwiWd9Zw0U6LyjThjtW28g5rji54YAdty9JtUvPdHH79z7DWskjYgo8fOF0ograuWg4tgfVPj7rjs2s0iotSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cZtvoO64; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+iUP8EW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cZtvoO64";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+iUP8EW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB12314000B5;
	Fri, 12 Jun 2026 02:18:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 02:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781245096; x=1781331496; bh=R5PmZq/vI+
	ja05wfdLaqOMldwt/e8YleMG9zzAePUGA=; b=cZtvoO64TxR8kiRejKknVxK8yH
	rP/XW9toSbA1AbNKaB+fXuxE44yqZNwiDIvgacjoU84hgSwHpxrf7qehaxP8ipOP
	UtGRBGZoO49h8zfLEK+i8t90GuB5PwCpJ+pxztBU6Fg+rxLKoTVwxXRcThSg/h+q
	NRc1HAfvByTGshEuYbjXV/XZr+Wg9Z4f2Ei2ZeeA1hbJS/5cOOnk7fSfbCj0uMgy
	efUR1qavQX5kGFp7CVL+0bqxWoocS9VLTtdwF5DDiCfnp8irCicgVxUuibIe0CbZ
	QE+o0GtiL9kf6V1GZcAM3V56TDRC0KboTTZUQqiLD5EJYHRkUdUcRoadyf2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781245096; x=1781331496; bh=R5PmZq/vI+ja05wfdLaqOMldwt/e8YleMG9
	zzAePUGA=; b=f+iUP8EWb6FlvxEAxgCXBGdqpbdILNoofH7DZjkSpZTxliJxMZO
	vvqxT02TyjGgn0igUtEH5zLQ47I4aXHzfm8N76TpeFoRW+F05UPrVLo7cUd/5tgT
	H8/2eNwv/njXSo6zcaHW+kx/tTwloFH1p4hmydWf7BikMHJSlwm8x7tARkPJd39e
	Sc1eO3arrysKV/+0u4o57wT2HKXfWyV1ekv5eXk1DZHQU3AL+fTGEpdbPKo2FFKq
	CFCOZAsTEwzWJdfK5TJUmk474HxIxAhRN25s4Wp0mHDrBL3F4LH3lMVee7rv4FXI
	X5pyOG73XefR9jKDxa9FOkCcYOroTbLuomQ==
X-ME-Sender: <xms:qKQraoLb3Go9RgSLGtldy7-XtCdFRDpW-bJy4iNsGRS-WxIaDTDzGA>
    <xme:qKQravk56rbShfCY7O_TToGQ2as5dXS9eTytQCxxszTPgAlV1yIGKSsgmKSKQpLX7
    7XsfMF621gSwNf16ztxSboNoCVemNr7cwLOfZUKIaWUY_jFFEpZLQ>
X-ME-Received: <xmr:qKQramFt2uXo4RVFFfeqLaE7Yj1vGOkwNK9WDgkrMBheljdVlYx0wHDygWlT9rz0yZ5ntqw1YatB-g86lD7FCB1o6H_LCmmEmJFq0Sgqiyg>
X-ME-Proxy-Cause: dmFkZTE/iVGtSoPHBasVfDZu/yyGwLFwMreXruUGok3VgL6+Og5FUGT608VelEGqJHHnGb
    H0tPXPr6M0aHy95x2hrJiPRhuPCxDOP0XzjTyrbu3EMFi4jFQkBEBWO8sIAmha2JjkMoWc
    iMLc/HPctdQGGaNBPLXsH7h0/ukWWwjDtWUO0k+BuiP6ZQGXRN0lo4sj6VbVVxipAxJaEP
    go6p0sb+Phxt8P9POsP4jH106IrfsJuzFcFxtU2F7vnLuHcDqcvJH0G6X0owPF1rwDV5xy
    2XdwjOmKpuWYsdqDyVkkLT97RBih9mt17BpFkKH9ZIahqj1n4o3QX/9RYaIa5HP0Edw4GS
    kkFc9Z5mLwORNOd7XQzVQGxOEyFM2vFqWVSiO6JImqkOEAq6DoCpw38sVhqE9yGdvRvTyF
    JRKrO6neiyuLPA5T5E6C/RLJPgLQK9d6Vq5kOsXrcVvvaSJpmyVitSbkSiWSOYXojX+X2Y
    o7U+2aWYlZOBkZ0tK+lKHrAST0Amc/zAIaotkOIEvhv4XkMmXUsL8fSD3ixqRhorTyAldU
    xhuPBd5/wAejEQtGBPWoVKd3gArx5k22tWoqdWNUKrgXTryRuCGI8Mh0gcSBOidz0WnnS9
    BS1Eg72n6aSumD0LAQTNK3/fY3srUg5J2hN6K5sh6TFZvY8SB0mtZGIJybwQ
X-ME-Proxy: <xmx:qKQravE7fPjVtQfxnzB1Am04KMLkyvo_OQ1XDC8vxs1syAALMhwHcQ>
    <xmx:qKQrajOHTRVb6lAAZ2HymRXkmI7WJFC8nBQokm5MMGFF5E8-yHjs7Q>
    <xmx:qKQrauHjD6EZil5qjnAnQIshYF4i06fqEvVPTqoliBrIBWCoQkLzmA>
    <xmx:qKQraqM2v3nfz9CIH2cSjzWymfX6uNZGVA9dHGTuJoT3Zz38Sp06kw>
    <xmx:qKQranm1zbaCXTjod5tr5nbTOd-NPgwkqXk-lW9LhqGMLWrKgff5q6Op>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 02:18:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12994eda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 06:18:13 +0000 (UTC)
Date: Fri, 12 Jun 2026 08:18:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/9] setup: don't apply "GIT_REFERENCE_BACKEND" without a
 repository
Message-ID: <aiukox1_HrWFxnS_@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-3-56c864b01c43@pks.im>
 <xmqqa4t2wbb5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4t2wbb5.fsf@gitster.g>

On Wed, Jun 10, 2026 at 10:32:46AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When discovering a repository we eventually also apply the
> > "GIT_REFERENCE_BACKEND" environment variable to the repository. There's
> > two problems with that:
> >
> >   - We do this unconditionally, which is rather pointless: we really
> >     only have to configure the repository when we have found one.
> >
> >   - We have already applied the repository format at that point in time,
> >     so we need to manually reapply it.
> 
> Does the second point have a small typo, i.e., "if we have a
> repository, we have already applied the ref backend to it when we
> discovered it, so NO need to manually reapply"?

No, this is correct as-is. At the point in time where we handle
GIT_REFERENCE_BACKEND we have already discovered the repository format,
applied it to the repository, configured the reference database format
et al. So because we handle GIT_REFERENCE_BACKEND _after_ that whole
dance we basically have to re-configure the reference database format,
which is awkward.

Patrick
