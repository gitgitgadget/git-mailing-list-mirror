Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED8224AF2
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887002; cv=none; b=FrsScDpQ67EkCxN0oNSf3/VWjvHMEwF8VUI5bo8B6i5xaNEQgDWGWXQcZeY+O6VMS3+Do+rCl9QM1BDLRpCsu5LOTQg+QeKWAikXl+YmixKBz+GsNlUBoakk9/EbN+Iya1ZgL7P8QhL6LhS8V0VAmraIBJEKQUZoiZcWTxj2PQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887002; c=relaxed/simple;
	bh=aJh7zFepfy1YmFAz22gc5Dc0siVSMQ57vMupW0kqj4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qssXqM/0HiCXFu8MWKhBsgt9kY/+mDctNHRjTDVAO1Zj3pDvMjDHWo0+LqNXmsAel2YRKA0Hpkjew6h/OwWPUg5mWsuhOzqJZPjsxD7KLKhDuitp6pjC3ndlcM7KcsQLY3dE5Av6DXs9FOAVGO3hI1XSGcCmadnHs/7xW+PF9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lmHVWp82; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNsodEh6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lmHVWp82";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNsodEh6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65F9814000F7;
	Wed,  1 Jul 2026 02:23:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 01 Jul 2026 02:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782887000; x=1782973400; bh=sFMcESceqt
	jN4Sz9c6pozrHOoqTBuBThtU3UMxZ5rpA=; b=lmHVWp823hxR1TnaTi0FhMgdyh
	ucnEx/7EbQ9hJdJ6yRQ+Sqh/1V4tSAlAB/jXjvFNeXU9wfuuA/qYTgZPAaTr160K
	9DSaSRqZpR07kQudP4HGRtCf84Jx2cZTT1ybx4OPrBR4YGXKrlXqBIP856cZC9eD
	iVTRHhd742IKEMOWwv73De5GOPl7fTngp8yK/Y6jRq3RIuRwKV9HgQJOW0vmqEXu
	MiWSCQ31+3npRLjDSFEcgoqhECWiL0C49cjCOKhxAl/0hVOdf24Sbn3w4hEOlilw
	QI8GgtbwttlDMosPEg8BNXnv9O/hQYWfOup57WE9b1wGmpNSe1wbE/inBltQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782887000; x=1782973400; bh=sFMcESceqtjN4Sz9c6pozrHOoqTBuBThtU3
	UMxZ5rpA=; b=TNsodEh6NkIB71GxVIwgNSP3/PvDmDq9WztS6R5R0XmEzlMM2SV
	RrbMh8cdH4sauncLkz3fHSMmfZCV7SrIaPYt2jg9BanSbxfVBAX9MlAL5+Ttg52L
	sCJX0FObA54XmPWl/DNFU9ebfDlPeYZkOpAZDYu+1cxmnRHEo5tih7DyovH61rdb
	yJzN/n9cbquXFKV0ZG4rWa35vSBQFIyoXZJSZY5JRW9Qzbop+2shlc1Lq6a+QSgW
	ReVepCZEZe2mSoMaTq2nXLMi1YZ+fOt4GLSynNYokd05ZqUctEZxImfPfVQt2n/2
	ugJzz3J6DqjNdPWpLkZodDSTIdkwG5/nrmA==
X-ME-Sender: <xms:WLJEaoOifD4Ykd3KhoE7av33wMYiwmcCUHFN59Zz6IbM1D-PO9hjaA>
    <xme:WLJEak-DatiQc11GsG1RcAwjRbYFf57rXi_a2knnyKjookZLpCDM_kJiKshhFxsb0
    1rj-dXOjcKRcdukLEz822DyHZxd1eIg4wQNiuKv078I3QjjMx0>
X-ME-Received: <xmr:WLJEas7Yb5qMSvwKc5XhHF7_zMgFJGRnRizGBDCUia3EOLa5P2LnUYL6W8fmRQtxaLp8L7KKuKu-s_I7r-x5RH8XdL1DVFRheYL3GWtiCk4>
X-ME-Proxy-Cause: dmFkZTFvc5x5iZRv2lrmYg8dqa0OrZGLh3ljGsq+/m8BrwFXF1UBjB7lRHEz1YA8cOSTPK
    mueje3eUKcaLl4glEuqgCcPCTAmaEcFqtqXw1zAslh7dtadD7GruUCmY7hHY+kqM55gIT1
    YT55ARd1I7wgBk5dZAcVajW/Lt3P9Zj8+o1bqC+ERH7DPYPDFpzcJznrcy8mlL02GYJIEp
    HusudL9aY9f1cHAurqRyD0NUdh/JbQVkKsXBkZc0PFE6WucrJ5GrgQ0PnVOMNvoZ8F08wi
    DD9CePQnQZtzmlEbl+mVJjBmq0q/F6pZ5Wxwh6tE0VslYY5E77hAhKQv10ChXC9qLal9pF
    LjNmDUUNyGTsdjDcmT8nkrN+FxjG7AoUycWo6jGTnZRCJBpXQOv5pMzzq9lYAQD0RR5sbk
    VmozdxDNs+Xz/W5qiv2kXAYIJXv8e1JF8poEp4v5zBU3je6NIyzcKhSORoc9ydiMYfrZ3v
    KzQsRLkskOWn605MOJL5wEwE8oWt1teaRsbljTIxvNrEZcBo10w4ofHILsOPUkrqNbPAJR
    nGSwfJ5LrSmZ3CM+h340ZXYBGnZDx8CPjclJF9bJxaB684hLp1Az8/753i/ZmNNFSQG6sk
    jBEXS/5C28lat5luV0Q+L/nfqqMfSHT8RKJRsLAyrscW4kYZeFv1jwRGX/UQ
X-ME-Proxy: <xmx:WLJEar2sKuhUcjdofJU0w15IXUJmGIo8E4GfgtyBuj1XahsuUTCjKw>
    <xmx:WLJEajDYXz8IfyclnrKszJGWwqBTubUj5PKi3a2kDGH_LEBgT20z4A>
    <xmx:WLJEat0X4qHK6zvemCvwkko6Ju41b0rU2OK3uPa17Z6PR5MF92jjKA>
    <xmx:WLJEattpBZDNeVCZecsqHwWliEhsi2EouswzBBHOtqjwUwEn35p8CQ>
    <xmx:WLJEajkuHLF1N-dLDzbNS0mylcBdzIy6QrV6ZVTVwn0ucQRRuaZIkJ3e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:23:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17786ad7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:23:18 +0000 (UTC)
Date: Wed, 1 Jul 2026 08:23:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] setup: mark bogus worktree in
 `apply_repository_format()`
Message-ID: <akSyU2kYWrFvnrmc@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>
 <xmqqh5mjsx4o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5mjsx4o.fsf@gitster.g>

On Tue, Jun 30, 2026 at 11:26:15AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +		 * we have to exlicitly unset the configuration.
> 
> explicitly (will amend while queuing).

Thanks, fixed locally, as well.

Patrick
