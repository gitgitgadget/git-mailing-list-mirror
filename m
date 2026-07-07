Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E8423765
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434408; cv=none; b=H5gvtayWEpLy1AfOU4wIkq6ia/BunuFoq1s5QMYLebp6koF/Xjq1xGO7nMZUNe0LIecBtc17V/JCRCVBOF8RS0SJ+6X5K/Xr5dF0ZfsflBYxrGMp7CpwrQBEDhZgnjyimt8X8e/rY+RA5o85mWJLH97n30Q6tDciW5e1OSnX9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434408; c=relaxed/simple;
	bh=4oUEcW2dObBq7Btjyd2aIad8nD5KEGGsRVqbPFyiG5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHygT1gUK6habPFRdtN2TwVNnTZcojW5ItdLwaYg1Id4yX/ab6fTnQmL1tYnOjDAaQ0QjRFlA+jiyj5hu9oLJ3VSt9ELOxF8zgkGAE4+5902mnAoRN/AxIsh2aJQYV4R3W6B8/+gt8NGL0Pk3yjVgaDPQCV8AwKfNx5M76uxZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ONDH55Vt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDtxhKs5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ONDH55Vt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDtxhKs5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1C5D1400142;
	Tue,  7 Jul 2026 10:26:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783434402; x=1783520802; bh=0PAJX9H4Mu
	5ZZyuH2X6SoalXRi5yAmYRFI47DOlQmXo=; b=ONDH55VtnMbI/rGWqYPQceMB95
	TWBBs7NA+RfZQslKMA0OmRw1IdazsNpDxoEFWt5GLXmIR2zuAeWD1EOjSuUxafVs
	zmKI2l2q0QeSVFLT/gKqlWFrTgztk12ILmcVCjh+kIJ0up1OUdnzT2bSjJbx0xAg
	tv68HHwilVoNtoU3RougzfNg1VL9COTF5CWKo6uzvVg+CCvgttpZxY6capBhyOZn
	nQArVLSSlUzkEHl+oIVbHS8IJIejop5FGQM1+4xGWL3U0y1SUbu3L7CFzT8yB4NP
	RpHPbz8tCybyd/3ZLiaylofTjPRheWCHHHKEBmfVSoMRHHZpoRT9nE4upOxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783434402; x=1783520802; bh=0PAJX9H4Mu5ZZyuH2X6SoalXRi5yAmYRFI4
	7DOlQmXo=; b=fDtxhKs5OkANiaiH4BAlMpabJknipuDgOx1F7nAu2FvJ65OcEzA
	jKASLxpchl+S8zYO9HOvixLXfMZBGJpdf7eR4JFPXoaghm03E0xIVnNRQ20xvXw0
	C3jSG7ZbTezlCdDkpMFYVknu9ixcfewbAGtO5DZ9RCCY7LvpTJ377mtrKIcfy1i4
	lk7C7apfEqYZSKH39EpIMrX6uBGWbWmq/bT2PLNOdDMpnhUnz4pQidxz/i1wF0hG
	CIh0n9nCiYuTSAR1VzQ07Qs05DtoIGVSMNwEzgH9dQ8Vf76LCsY12yHUQJjNhpu3
	XvsJteNUxN1Q4cVNHQ0+737iO7ptTKJhh9w==
X-ME-Sender: <xms:ogxNaiwO27azBFWQaAA1BLh8cc5ppNlqYJQH9qaDPlvZZ8WpkaQd9A>
    <xme:ogxNaluIYpQhcjyJjqcp2ng1UuUWck42LGTf543qwX2nd_hVsOpgmTJjjv7E3f1y2
    bYc-i6xFJQjUYVJNlb_17LElCN0lDPrNSgV4Cu_VBSvSw_4L46ADg>
X-ME-Received: <xmr:ogxNahvZ14aMb8_bAjzRrt6Pew0xUnURYq2JpkL9MgIulqDbg3_UvDBSyMbp_5eHwbFE9GtpkVnGeGtf7n1_gqwbjoMBpcNUY3TN02nHqQ>
X-ME-Proxy-Cause: dmFkZTE2oqIMkAhWbQSJwW66l2gN47n5ihrTOAaWHYJKA/a1YJdPbU6iPpRF0/gQedU7bI
    8aTy+OLQQYM6uDdDEDSmxGwzSQxptfoVumhMLOwjMIFC5+HS/LCaEaEwzeMnbwCvAJeb+9
    aHU5k1Gufq6/XVdv/p1NQe+4Wx6eAu4dHj1y8gG+3p++EDIL9iNtKWWB4eM0JwHBr08OpJ
    9F//pOxf8LvT+Q4QuzwKsm3v/MsDAhgln1U7c0rwl8NS4v4K+H7CLxRrg66XhC2nEpEdJ1
    nWycHyox0aXAEjYCZa1gEZYW/p1RHL4+rKU92Yq/kkT4e1CztmjhratWhKcugvYGtsVNma
    1HuqOT5/aDXLKxptLqCiSrSW3jwv6Fj9zFkh+qwfUrkaFilXKS5FW7NaHGmra7Us0R0aKu
    lCfCfsLXJFVHdiClYkHYCxHLcSA+hTAXcRY4LnY2UB/Yq6GWyHMTIwB40rSyGTdeq9HpMV
    itbxRbw0s/IPs+grSXxBQAxyOV48rg/UNF/2ZVSWbjfmlwZc99QMpwODj+GYqzSaYBwqev
    hpWQzxdDRiNyvrF5oY400+u3Pn5HZVdLj5Yw+7AY7NozOqNnFAGEy8m7L6xuqnw6XzNltq
    T73KDkieYJJWy3ibcyTRJ8hRcUt3BXYZ+bL8GRkG+ZMMH3S1zaJOgPXUfkrQ
X-ME-Proxy: <xmx:ogxNaiM2pM4d13d5k0cHdr2dd08ZN7aEjTUm6n-DWrjosACzAw3wug>
    <xmx:ogxNan36MzEnrcuyQ14MfdouYH-MQoyjfJxoIxQr-HywJ4EZn8-S9A>
    <xmx:ogxNamN2-wHZ-43ofZ1nRVDdoGiuL95JAntpGrwVaghMytJPg_oA-w>
    <xmx:ogxNav1jhS90ebBRVFxlcE9UzRIv0Ez6GI4nrOASnoLVbWhLcWUP0Q>
    <xmx:ogxNauz9QUxD6ajaZaG_QjiBdfB5o0XaFfzjzsPFSo71gHClQZby7yjj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 10:26:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63966d78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 14:26:38 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:26:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/7] hash: document function pointers and wrappers
Message-ID: <ak0MnN6sUtFimvYe@pks.im>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050557.GC1288294@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707050557.GC1288294@coredump.intra.peff.net>

On Tue, Jul 07, 2026 at 01:05:57AM -0400, Jeff King wrote:
> diff --git a/hash.h b/hash.h
> index 0a23ef4dfd..5686914b71 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -341,12 +334,40 @@ struct git_hash_algo {
>  };
>  extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
>  
> +/*
> + * Prepare an uninitialized hash context for use. You must eventually release
> + * the context with with git_hash_final() (or final_oid()) or by calling

s/with with/with/

Patrick
