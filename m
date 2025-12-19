Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A142049
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125729; cv=none; b=MMAOWV3dhvwmaImTF4j4d0UqOvoHX2EBGSWN2NzTgd2mO1HC8H9ZzQqYcZwhs/HEyQ2Qd5n+wSHHfss075sAwgvtxoSLK8QdficSkD6C9Jsy2tYyDckMPb6mwtQOPABd+TTHAHLld27ui4TNKJpnmVF2K+jBDtKoMI6QtlDJplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125729; c=relaxed/simple;
	bh=MkyL9cyp0JPmuUzP+5O+ccEl62+ru0AYk5FYvt7RHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAalyIhzapu54e2RtoYxEoqk7USMpkHZy5KTgYA7mRrbGOIsejLdgBLsC4b857fg6kb2LAEfuqE8LAUwb5kAu/0jg7o03tZRrEhkpOaq1z34g9kXxqbCFKXacjZKB34qVRG1H75OZ06HsR5NifGv9iFzLX7m2Z4x0aRkmMICyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z5sMSyuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKAVnZrf; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z5sMSyuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKAVnZrf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33E357A00D1;
	Fri, 19 Dec 2025 01:28:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 19 Dec 2025 01:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766125727; x=1766212127; bh=7PTPX0iY5M
	DZAIWFWLbHq5bcbytAcxrfv9VBM91Tp2s=; b=Z5sMSyuYRPU8/rbGelrD+5+yeg
	kkPO9+ZEVglMYcxA9vvCzSoxwEozMGcENyqcR0j1lMEVX/kuE3duRxBtVVN5Kb1t
	GuSdcig71JCrV6iksfSayTwLefzrT5Nh3ZU1nKZ+iqsSwZNcqEhWA9C0L6pr9Opb
	FZVJyIA96fOeIsYNFVUBddmCySS6dG1y0yaOzQ1GYg2TtaN64SK4Vb8UkmVsvPaH
	DrkdiYDfFVUkd838FTIuv/n27EFX0tMGLbmN3853XZ9GJb9Mnxx2ensju2lpVz2j
	JZ+4Us+/t9wRaY3hKgZ+prU01s7J7ZVT+VGHZiRTBBXNpRz2gtik695lADdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766125727; x=1766212127; bh=7PTPX0iY5MDZAIWFWLbHq5bcbytAcxrfv9V
	BM91Tp2s=; b=GKAVnZrfS83LuANfxNNn96u8aW2m1Cb8NQXdhhcMb2i1mfNkVNa
	uZTBMarQdW03gYxqaXEBhnd2vrQhW/Cjl3iM1JZxiX/d8j9Y93LVFfaNwjmGCq1A
	3F7ycV7jAz0scZPxeXVaxdfhIwdYNbr3jGMj1iItf5/ap8jwDQtbVE1pPiFVnLHI
	nUAm7JDQicjlfyR4HO0cdys8XThJCTqWTK3tAqi3Ae2OIEa1nt8ZTfxHo7KSlmI3
	co1riG6hLTqpD5dAO/e6KdTWwZJsAMDA7GiDjo19+oYNAoNaSTXXVS3xYUU/2Rtu
	tlC69yCq4Apz597A0ifKDVdvw6YGN73yShQ==
X-ME-Sender: <xms:nvBEaX9KM2xvJrVod6ztRpnqQq6Yzk2xke6r0wMVCVBwoyzqMjZrxg>
    <xme:nvBEabLJqqcsytEnn_y3eDkQcWMGNi6cdoarPp6ofsBvOFTH09FFM2Y0xcrxnp9Z8
    FxHthdWUjwSo6NABuKEGogZSlEz1JA_UIYv-WmZNhpEFM3_rU3L>
X-ME-Received: <xmr:nvBEaSbVg1XQuFNZpfBgPZdObQla7fWIHjxzU3hhWqXsIqk5F53bndhCC590vxiXnbr70G1WMOtXZAMtLfrKw954tBuBEPmHqaCek9X9vwIh4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:nvBEadJodDYi79Nu3G38jHhecLPBJQSxKpGOPghK382wuJvB33A-lw>
    <xmx:nvBEaQDJtu3AH0ZlIlKyEQOXD0rX9vetTLH3j_Zyl3lfpzLlZ92OeA>
    <xmx:nvBEaSoW-8VYYMoe4nNuRdY-yWQA7IFxviKpvHGFablqzqZ6J7p8zg>
    <xmx:nvBEabg1XSqOlHON1gIlbaod4sQb-IOr3utx7POssIRDk-sHi0KSvg>
    <xmx:n_BEabVxBawu95CrXaoQlhD6VtlNPkC6do6kT8Tmb9WIlYjQm0c74di4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 01:28:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1da57b93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 06:28:45 +0000 (UTC)
Date: Fri, 19 Dec 2025 07:28:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: AZero13 via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, AZero13 <gfunni234@gmail.com>
Subject: Re: [PATCH] refs: dereference the value of the required pointer
Message-ID: <aUTwmSNfaoVzEIpD@pks.im>
References: <pull.2130.git.git.1766074249443.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2130.git.git.1766074249443.gitgitgadget@gmail.com>

On Thu, Dec 18, 2025 at 04:10:49PM +0000, AZero13 via GitGitGadget wrote:
> diff --git a/refs/debug.c b/refs/debug.c
> index 3e31228c9a..639db0f26e 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -139,7 +139,7 @@ static int debug_optimize_required(struct ref_store *ref_store,
>  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
>  	int res = drefs->refs->be->optimize_required(drefs->refs, opts, required);
>  	trace_printf_key(&trace_refs, "optimize_required: %s, res: %d\n",
> -			 required ? "yes" : "no", res);
> +			 *required ? "yes" : "no", res);
>  	return res;
>  }

Makes sense. One question is whether `required` will always be non-NULL
so that we can unconditionally dereference the pointer like this. But
from going through the implementations I can see that the pointer
already does get dereferenced unconditionally, so this fix is safe.

Thanks!

Patrick
