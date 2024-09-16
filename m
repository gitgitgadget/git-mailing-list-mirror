Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323313CFB6
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471814; cv=none; b=o90ahJlrO6kSO5qzkW/BMpgGBARMVbkyrj9rsFYJD4JIVhM63ZeVLyvQUC9e7Oxt/tGYRNKGeCLdHonCMqNw7QTr/L1aorekABie/81bJWcFDqARblAWAnAY5y/yBiKa8ILGwX9pDIGPmyuk9oNDBrl8UVhHK5sZtMC4xkScbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471814; c=relaxed/simple;
	bh=ViDZTtL8N0ngHoNOhnBTWonXqrUg60tm3XZp+auYdP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+8R6GNOBBebbUkG83N1e31u2VjOWZ8grRk68E1FMuYwwQrheyGun1/JXdSvzB2FPYDSm0ddU0Mh6aS0ohZDMIudVMmnoEWVJwthyR4Q6nfju/NOwt7hK8+EhesR9gn01eWVfsD9mYysA9znMb+Ux6qIZzM6ny7jVL/CxbddSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HRIusVU3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJOs/B4s; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HRIusVU3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJOs/B4s"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B471114020E;
	Mon, 16 Sep 2024 03:30:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 03:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726471812; x=1726558212; bh=23CDJtI0FQ
	7gV3Oze7Q/8ngDYb6LjebHyh8b8mpOX1M=; b=HRIusVU3NJxzgENrnq2DRa7r7W
	NEKhSzLptv1o6FFvctXkZBCtvjj0liebUp7ZUd23oLoNQh1b/rEdelThekAmdy6x
	4M9Gj0mxSZgb0sdVCMyxv3xCLKXCdcwsSFrbUIpee2TM0GnPJGfQunAbnglRCWNF
	kA0Ze1a49wNu/1Wx45UTZ1RYjlvQDiLg8wzy1ToPpAF7KiFbCZvb9snGNX6NHE7J
	oYTknn4rbhdce1+tWDHR3qS/S+jK28wL5p7fRcJscca2NPsgu56dRwZZCTQ8OtFi
	41ERZRMIvHBgbjZXmUWKNo0d9k5TiyacrfK2EUGc5C/ZohW+cV4JiHvJwUxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726471812; x=1726558212; bh=23CDJtI0FQ7gV3Oze7Q/8ngDYb6L
	jebHyh8b8mpOX1M=; b=fJOs/B4st9Hn9z0WRR7PNbZcIjn+S+InYSakPaE8DXKB
	k4dCVLkiTJ51eXDI2INkz0XQjM/J0F0PuPxH/j/xn+t0978oFdxjL3HDT87zzkeU
	7CdMPUESw8MM2WG54JTFnvEW8TzJJblsBDBuicSggLs1D/FqICNq3uE6WLIT7m6y
	7cVvrFriRAGchdUR53e4jY6R/bcjs7spgMo6T8ghwPbWRGkndON4KNqgEDQSWira
	dTmceond3n+CjtMMZEpJGjRaw7tksCztHBlVuAJyHj7FQuk7F1icoK8SIdl+Za4m
	Po9cK2IDcC7eDi0JyDxJRCqAGf6/oKWxO049QVgpQA==
X-ME-Sender: <xms:hN7nZsgf7G3gvU65bMA3xcLXZSSuDOcUQcw3eCT1c_GIvdfw6SeTyA>
    <xme:hN7nZlBUbfYOlSbbOxymWLw_jdw4VjPp2V4bZ-4fWuSeP1uwTynDBOPJmlhGxKiLl
    BIOpBEX5tijGULcsg>
X-ME-Received: <xmr:hN7nZkEebTf0DTx_Uv5Zpt0YRQ7ZOqwBcmpgnbYXB_YCf868yyPgp_Qi3Z_RxYqU_A8xRmPSos_-K-FhHfcOYCItjUe28eII0odV7qq3o9wW7A_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlghho
    nhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:hN7nZtSzcymqkfUVhQqdYLQL1gmb_Nxb62mFa7UsRm7eD8GR467SrA>
    <xmx:hN7nZpzNh3WaJah13uPffKvkeoqItVHyLre4g-0ChTg-tpzke7HFJg>
    <xmx:hN7nZr5PQ2KAiRQEOYIOozkG_PMHP6MA8qXbfd65ShvsDW2GL30nGA>
    <xmx:hN7nZmw5EwrK1JdkN5nTaKumdkaLGdotUTEj1FelxPNfeKnf3DGSSQ>
    <xmx:hN7nZk9yjNedDcATZHVmSVlvpmBIJ2cdBNK3tJiSwnaEnsFzl6dq3JbT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 03:30:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8ef5243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 07:29:53 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:30:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cbtree: fix a typo
Message-ID: <Zufef70mfdUwSwnY@pks.im>
References: <20240915230522.129253-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915230522.129253-1-algonell@gmail.com>

On Mon, Sep 16, 2024 at 02:05:22AM +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Thanks for these fixes, all three of them look good to me. For future
such patch series I'd recommend to send a single series that combines
such related fixes. It makes it a bit easier to keep track of these
similar patches and review them in one go.

> ---
>  cbtree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cbtree.c b/cbtree.c
> index c1cc30a5dc..cf8cf75b89 100644
> --- a/cbtree.c
> +++ b/cbtree.c
> @@ -12,7 +12,7 @@ static struct cb_node *cb_node_of(const void *p)
>  	return (struct cb_node *)((uintptr_t)p - 1);
>  }
>  
> -/* locate the best match, does not do a final comparision */
> +/* locate the best match, does not do a final comparison */
>  static struct cb_node *cb_internal_best_match(struct cb_node *p,
>  					const uint8_t *k, size_t klen)
>  {

We might convert this to be a proper sentence while at it, namely
s/locate/Locate/ and s/comparison/&./. But no need to reroll this patch
for that, as your change is a strict improvement by itself already.

Thanks!

Patrick
