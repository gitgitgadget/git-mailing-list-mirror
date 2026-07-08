Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9433DCDBD
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492902; cv=none; b=rRMm2jtwYzc/ey9UCObpuW3e1c1wBXQ9+IZrOeKUbOZbHEAzg066eYexumLT4frp1IFKYPXjJ8Wn2ZCgCHEJW02m9ugxasYPs0xa6MruW8BN8id9yLrP0iDGgrAD8iC7d0WTMjJsPmvYI6L2AvwPyA76Hwwt0pokrSUqtxFOa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492902; c=relaxed/simple;
	bh=MAeQREeNIOnPOEd50bReaW5yj9s3Lh1b2v2OQCUV6XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+/iWiU6fOCN6yhUk65R0qYR5CJVZYDe92y3jy1IElVsUAY0+a27FpYHmEeoOxTe95GsTcH8blAQBaBCVhMdm8jece3XxUOvU0ugiE9cDvQPmNon4nHFUmRPecGWJr/srfI56bBfdO8a3Ydq54qd1TdwOvV/76Vy4lVDq73Kjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WomVEQUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6dtqCbi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WomVEQUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6dtqCbi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 538A6EC0125;
	Wed,  8 Jul 2026 02:41:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 02:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492893; x=1783579293; bh=MAeQREeNIO
	nPOEd50bReaW5yj9s3Lh1b2v2OQCUV6XA=; b=WomVEQUC1fpDOZGy6rsR0b9lAU
	XH8kgrw+Ff8ULK5YTtFuDO0juBTI1XzrxSEWGmn2dX5MDOG1J86wzWFK6v4HFuOQ
	/Tezvya7DUNCH0vf5J7TRUf9kDSURee/UGYx38ZnIpivenm6RB9+6a71J1ah0BEH
	ENQJhCHnvfAEFm2822Z8efjF9Lo7/jboB9xtqCgAb/nEzBD4u5x6G7tY9j+Mb2BK
	oH2eDxUVJ1IBLNKGF1CimKQl2lM5n6YaWjJECTyzL6xqgtgKaxDX2rNOQzFDWGHp
	sClk3UwHE3164iaAsvC3JbScfSFMftaX+vZjza7dB5Eamj3f/m3p5oWC/91Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492893; x=1783579293; bh=MAeQREeNIOnPOEd50bReaW5yj9s3Lh1b2v2
	OQCUV6XA=; b=U6dtqCbiq0W8UAzTKvCIKM4SPmKyGMSS7M7NjqL4cTODW6w+Z0i
	iemvtdwag7VAgAhnzmF20lCu7ZGTFa4AxcMwW52DeOCsLzR3wK8RMxbsotBrF9GR
	WJpvC4ZylrBrAGTPyXb5hD4oh1M48qJg66CY+mKJF3cwRHkSc550jKGRdqfvolIP
	MG8NzBZEDpyWrbHo4DxYCXnzRWqX4cck/zxJNTXK8KWWwR0UZzgJ0ft5YC8svOtW
	/a1wmPIpmKZNDGq/PfrJPQGua0cKgmb0yaQTVDStBHjZSPEp/xX7jt4aJyhXx/pC
	15JN/bLyZHBQ4Nj8EDFvL77I8XHKChWaySg==
X-ME-Sender: <xms:HfFNaqlXfaYHB6RcRAK7y4mbQZUzcCoV7t82DfPmFgGOv75JiGyGog>
    <xme:HfFNapQgvo-oz4m2h0oXyHOdynm6ZcyssQHkm3MH9VPMVXXz8xfrWdwwPg-n3g2IF
    5ujrUnKLOopkvsOmUHDp_Y1dAUmzwWxVXPxkccMF_qzti4FtXFJQ0c>
X-ME-Received: <xmr:HfFNamDfJpoktvxuNUXDxEim9J_5lAkisM_oMG03Barq7RwSzHbMhT0C5-6SitbZpdM0c_HjlZhsU8g_9p0O5YoVwwy5wnBEeKtpC_rO>
X-ME-Proxy-Cause: dmFkZTFt8U4JXv77RptHf8bZ38jzKC//7O6cuV+uI1egQIDCGwfNOJ8NTTmt9EcMUmSVLf
    +VPrHoMwCqAIDxRxaWuxirZB0YbEo+1slaYLtGH3ZHtybGWlrsrnY2dzTY+5vIPrWsSj2Y
    iq1J3CdZIk1/ytWQoYlEmRyzoGwlioL4WJsq/qMbxM4E+lClKTxzBb7y5O90j074U+n3zm
    b2tZbX/+/Rw7cZ/y7wOpsIZJvQOs3kL7HPiFXUrLYFGbG4YG7V7fAMpFX/56ePIFFmYZoI
    zdlF2m922L+SMu9lk+83k0kX7EHJbBxJWHQ5njpK/euilcgXTY+B6eyBhCuyo871zLaYSe
    GusSALbj/Cvt+sf6oJs60VgHZS5O8OAi/wnXijZEnOe4gDLzVAp2f8KqO1nB52gQhqyVTI
    VCr9zBVPBJar3g648c73bfNIsttnsCitng2afA1qKZInYwzxhaa1KR5/UxOfPcKDs/vu6u
    Q1TqGdp9v3CelKTefVQYLAJ0NqZ42orL7Qh1r9WdujH4jPc33epnn7LunYvwG0zHHvZqVU
    an6Giz6NzG81N9xqPRcC6nD5GXZMj8Fq299FCLFudXvaY85KEX+FRR2OGrdE8z+8FTONtD
    4fdaSu8KkRJRd8I3TKWhRQ04YTfeaA9eYArtbRsnQS5xcA8BtTl3iIMT0cAw
X-ME-Proxy: <xmx:HfFNaoTfh6Q0rW9ug9K8v_Q8FydlI7TqpssXg8CJ2Nmz4zH9Y4DsDw>
    <xmx:HfFNaso-vBBSX6_CN-VHQJyQnXMA_evfnJ_I5EqG4_xKwHTNnyiNag>
    <xmx:HfFNaiy5WVnWb_c76dt8qUACtwNSYdR_p-539Wze62xyFt3rqiwVFQ>
    <xmx:HfFNapJp9PGGx5hzuTvRiS9tskSL_-qa2XSvFzYXrMaSRYfl10AThA>
    <xmx:HfFNatTLjgthMNOp1ZN1My06I_C4_2-E4Bbl06KFqs054ycrl_GfC45D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e191b8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:31 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 04/11] object-file: drop check for inflight
 transactions
Message-ID: <ak3xGYaGC2njU-Mn@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-5-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:05PM -0500, Justin Tobler wrote:
> ODB transactions are started via `odb_transaction_begin()` and contain
> validation to avoid starting multiple transactions at the same time. The
> "files" backend also has the same logic, but is redundant due to the
> generic layer already handling it. Drop this validation from the "files"
> backend accordingly.

Makes sense, and it fixes a layering violation: in the best case, a
source only has to care about itself and not about the owning object
database. Managing object-database-level state should be done by the
object database itself.

Patrick
