Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2538B7BD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901315; cv=none; b=JnKOUNWGiVKC7Xb2ZPdBU6fHK59elABDPjQeP2RQmHLZbFkU62dx2EjwW1SSuAdycLsqqx2gF9rc2M9srcY9oUgbTNPTTrXJtvJ+mHKKDUpbwG4uAGMe+79Xn9nq0xT1ct0xO5LEnH1aqLLFHwR48J+HVo6B1tVt9elbRjJZ8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901315; c=relaxed/simple;
	bh=7H8c7l2UxnAlnsNtZ2v3J7bzjC768dL4vogChf9bLFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOA2LJco/WwAmrlP6p7Ap7/uRu5P4jbGKBRvWFsJo/+1luEwzWxMDe4AK8Z4+riWSYZSPwt/xLfjtM0TQ2tZWxX4I0Dq3MIwbul26uRUddXAPAdw0qQC2jsV4JzGKBi0Qzeiwg9td9H9Jam/3dY8QDAVXEjJaEM2Q6VlEwL+lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hD5m8INf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7MVAILu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hD5m8INf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7MVAILu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BD2B7A0068;
	Mon,  8 Jun 2026 02:48:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 02:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780901311; x=1780987711; bh=7H8c7l2Uxn
	AlnsNtZ2v3J7bzjC768dL4vogChf9bLFQ=; b=hD5m8INfLhW2XI6xhuulkyrLx0
	Xopzv2XrQnzPR5g7YqeJoCCpZDYAtzh4Io5fvNt20e1vATOJFk5Z8a6qDkaXKSF0
	uFvWlm9mMax5Unbyid5malsbl8aBfAAY/YazajocFSdqb47LxX70imSRllG23RQf
	pPhuEqQKiDBe5lUlxovJbGY6JC4+2PJjQ+myvdpFd8/KxbOgCBxLM4Lt/ITAzoM0
	BDXAQj57PP5GTUAUovmcaZywFD5b11WQIyyMCKDdlEKS+p4DlS6sYyhCVwN6Q8kX
	Otvz/cawpTsOa5GwKEi2dBIXdxfbvfTNx2AUZ2es4fG0d21kDP41mqnR9Jgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780901311; x=1780987711; bh=7H8c7l2UxnAlnsNtZ2v3J7bzjC768dL4vog
	Chf9bLFQ=; b=I7MVAILupizpxoxSlmCbrkqxTLOjn+pro3X2hSNGaAcXjQfGx/R
	UhaEqVjruy+q7aqhaZY+ssVP9GAggMh1qGcLcLFc2z3hxxBSPqBgl86ySTvwca7E
	HWAIIJNll5Sy6pmcGo8Ds+5+gMBY7sLWuRTpqflozMraNmWhn/BTiLS5hTRHwwPX
	EdQJvklWS9/mVQze2wem95OJbs3lbwNT4+QZDeXOjBge2/vhwUXBJq57lsI6queP
	00lGMVVwe4NZAy9/5mvM4hHr+mADt2WtmjuSktY85q5E12xgMFpjkxtOkPSEcps4
	kpW2pGM89wpjWffzqIkPgYzYQjHhUNyKHmQ==
X-ME-Sender: <xms:v2UmanrZio-UW_TDiTLi9UF7fKpcBmlTMxlzpsvkodEy-WvusEzfKg>
    <xme:v2UmajJfm6uFYaFlHGaUg-lvztkyfgy8s9WVKyi1s4hOT3_OMbnVMQ8EjFfh8_Rn9
    kobhpZeiRBWL4T14hRFnevgUIYPJtmd53tiJiP-yKP7b_mPyEPpEw>
X-ME-Received: <xmr:v2UmakQx3PsZc_yNBUg13uyPFWAIaUp4N1EkHrRu3yXz6gFwOZzc6mgEIHj81GDvvCd0nNpkEzt_h08iSOoV6R4KvOJVxe5o6iA9b5Ku6w>
X-ME-Proxy-Cause: dmFkZTEV+p9vbX0g54NnYL/7SD4L+BlH2Z+jPlwwu7gtbo5CA37pTT7Y0dA87aYYQOXfAE
    Xle6wJni/r9LGxZKp67HRSeseP/RRLA50sXf5NCe69FHcAYEcjSLbp5cP3Q3WZuO5C5q5/
    KQn2qHxXYZZvrMtVSMTEVm0sb70uox0f/ErCXG0Q9+tFZ27ZekO/S4xERS4JJDDrzEqGLU
    famCGUFdK3kKE+qZknZ0x0uflXmojS44Yh9EAIckiXTB4TzSMtH1o9+yI0TPjnU8nBUBEh
    94zimER3k4aKHxNGAPflnF7SG5EFHin4NTg7GVw34m79iwrQ2HMzuwgehSdCl0GFyXgPiD
    U3LQnwbJWZBrPJW8ec0Hg2MLzOpRSe3bfItJnmfBBHIPd50jyVWPiUPLdBJPZauME6UZQd
    hqXUrqDh/a5OSOqqaV9TcR2Odcna2sXen2D5oIMzxK/74hCIkQ3VhBl51ImFPy2gxkzdxL
    OS7CupSsRnfAx2vHGmN1mYPxRJfREdswORffurFT5EsmgsND6DPlZQJARxLePDPjOuUbWg
    RyYnyBYmppCmeFMdYPuHujFBVqqgaFkNvveq38jT7pS2unI9GuoISPS5zaGkfBCqq1pM2d
    Avn0yfqvr1KJ1cgd0gnTyO5CX5eBQnNk/1Gt5wFhzfPj/XV4CyDe0qJ7hj1g
X-ME-Proxy: <xmx:v2UmaqtrsHeWVw1s9h0Jsw6aCOXrhcnIcgx4euzYzO-m9QrO0s0r7Q>
    <xmx:v2UmatbBtliAj_EIPZpcJ2Kil3M8QFg1WNO27bTWgq2cBOmAGJzrQw>
    <xmx:v2UmaoENsDQ5hsuMvVULZNbfusOSDRrXuvzAFbWiTC4G_6Nso9ZqUw>
    <xmx:v2UmapwAxzT-EZwJTkhWAb7lPYxS7uF_h756Chz_gnZ_5oH90nDUkg>
    <xmx:v2Umat_ttkXUnmvhFC1BcmRyjgxrGz96RM03alHz-VLwYIDw_yS1_fVy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d304722e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:30 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Message-ID: <aiZlu36Fh020L1Ip@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
 <aiACDLOtd_0_CCD7@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiACDLOtd_0_CCD7@wyuan.org>

On Wed, Jun 03, 2026 at 06:29:32PM +0800, Weijie Yuan wrote:
> I'm afraid there will be some chaos.

I think "chaos" is a bit exaggerated. We already have both styles on the
mailing list, and I think in general people are able to cope with that
just fine. :)

> As mentioned earlier, GitGitGadget now supports deep nesting of
> iterations, if b4 changes while GitGitGadget doesn't, it would be
> inconsistent in the archive. So, negotiation is necessary here.

That's a good point though -- if we change the recommendation, we should
aim to change it consistently. I'll talk with Dscho (maintainer of GGG)
today.

Thanks!

Patrick
