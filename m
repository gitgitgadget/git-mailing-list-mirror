Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED53225382
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944773; cv=none; b=SGQEjhSBJom3XSjpLi8KN4AFszxi/kILR2K9m2rlhnkeeckN+35NvOROXcjAQiaypykYs7VUUgnmktI+EYBP+isSs4kDKo9lYanngwb1PkHMyj4a872keppQ4Qm4FXS7m7Cx5Exiz/5ETpYstJFjfIDskGrIJUKUkc3aWxfc/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944773; c=relaxed/simple;
	bh=FI8+S7WdtqObnIGGHs9OxwbEJH3m32WB0aq5tiAYrZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVaKiz4dQalC5UYaFB+kIjmQOqAzt4NxzM+5ehbswuA1LtwzkPocImVF5Otcrl2gUBTUKUGIMFBFeIpk/RrHve01Xm3YCXPgWXt8ZNROrwQdzZ3LS6alYT6gBe8go9iPilVzeryCQGgi5Kt0k4s4CGs35VGlSOXQW+j0eH3w1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X4fTY2db; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZnM4oe6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X4fTY2db";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZnM4oe6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D44225401B0;
	Fri,  7 Feb 2025 11:12:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 11:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738944771; x=1739031171; bh=O7K1/iyc9v
	Rteoon1QPwCAhpDyUoiuH/+RG8jor4YMs=; b=X4fTY2dbR7iHuwSGxbs3DWQ/18
	gZc0jRcZH4Q9OVI9cj3nys2HhbgyZUdXrQ81HUoYQwuPPXiveuy3QeYP967vRgxd
	vsa61eXC8286d67DnbIi3sL6U1m3B4Ji8tNcm6VWVPj9GxnFI1SK/tsv/FdZk4kO
	pRJ1aWTE2TmOwanHK8BdureIy22IvL4RGtxPQElbnappPvFxqZJ8jFNaw5Ae/MjN
	CvDUdSTh5ncY8thj+pK6sHasdiWm8huYBSPENOjIm2fm3w1fSX7IyQWRzIGLRvij
	r/1nh7uJwh8beLB1aKGcU7uD4XH2KGLHGszVzM4MrSfN8WHJbVzmDVW0nbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738944771; x=1739031171; bh=O7K1/iyc9vRteoon1QPwCAhpDyUoiuH/+RG
	8jor4YMs=; b=VZnM4oe6ny+XUUdCOGDbqjq3PHrGKWW+igP9N7eROQBGBC75cMf
	ScYYVpcB/nQZj1KXn8dF8hvM2QCDIb1YrTAwl0//ZgJt9pcHJ3rYQHVC9fBXXdG/
	u7YcEkVtBFg4JekgnoUxvmuSmYEBknrN96UaeMZcVWniNymzcnDDkfhQoakksS+F
	Iw6QiYxXCdUqoRIyKRTewWwIaH9PoKg/a4UUcMczJ8veurJg/qWOpn+ClWweHNmC
	gSSraYAr8kQMemWVfyX5Tankrgmr/nOafzgx/ghKeamhM9Gfcqsu1UT10pGqowor
	hlmAgSHsSHvtmxOn4hjy+GkRSI4V4rcKUbQ==
X-ME-Sender: <xms:AzGmZ4ak4RSUt6MtR3Xw8EXVzAi2s4crX5KmSZtBgLPxH5NjXiQpIw>
    <xme:AzGmZzaNYcUesf6NUqDAL0mW5BUyard2RBxSCN6rPSvEjndAan3rSfUi8R8NC4foX
    Jy0AUWRh_DWV2LGxA>
X-ME-Received: <xmr:AzGmZy_8j6gckQd1iV-QMO2EugaWYSeB8wCth-A0MZA6Ci2DK1TnJtgRIUc2wW939o9dyJV5nM5qm-XRnsL0rJwnDa-BVniV1hUEgYxXcfOVYUJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AzGmZyoGGKSLXTuU_KyPZHoBlZrFhY_umb8LxCoJ1G9yAgVDeMXNNw>
    <xmx:AzGmZzogwMrWWgf-DWDViYfHxh4xmM5upb6sCWKWgzRah2B7vJCRgQ>
    <xmx:AzGmZwRxIHNBDP4kUv-F-IWsyWUBp6_oyECfm2PH56ISC-wRrL7gww>
    <xmx:AzGmZzpIp0TzU_0xNSsDWFqzsQkQh8XMEKv5GoaJAUUCjUg-BS7qxg>
    <xmx:AzGmZyVznLQ6kIkmGPS2ybt4ASzBd67ZHhNMtdEkXqr9GsLaDM8Y_fqF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 11:12:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65047bc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 16:12:49 +0000 (UTC)
Date: Fri, 7 Feb 2025 17:12:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 3/6] refs/files: remove duplicate duplicates check
Message-ID: <Z6YxANrjhHRUSv9a@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-3-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-3-e6a3690ff23a@gmail.com>

On Fri, Feb 07, 2025 at 08:34:38AM +0100, Karthik Nayak wrote:
> Within the files reference backend's transaction's 'finish' phase, a
> verification step is currently performed wherein the refnames list is
> sorted and examined for multiple updates targeting the same refname.
> 
> It has been observed that this verification is redundant, as an
> identical check is already executed during the transaction's 'prepare'
> stage. Since the refnames list remains unmodified following the
> 'prepare' stage, this secondary verification can be safely eliminated.
> 
> The duplicate check has been removed accordingly, and the
> `ref_update_reject_duplicates()` function has been marked as static, as
> its usage is now confined to 'refs.c'.

Nice, I had been wondering about this code in the preceding commit.

> diff --git a/refs.c b/refs.c
> index 4c9b706461977995be1d55e7667f7fb708fbbb76..b420a120102b3793168598b885bba68e4f5f5f03 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2295,8 +2295,13 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
>  	return ret;
>  }
>  
> -int ref_update_reject_duplicates(struct string_list *refnames,
> -				 struct strbuf *err)
> +/*
> + * Write an error to `err` and return a nonzero value iff the same
> + * refname appears multiple times in `refnames`. `refnames` must be
> + * sorted on entry to this function.
> + */
> +static int ref_update_reject_duplicates(struct string_list *refnames,
> +					struct strbuf *err)
>  {
>  	size_t i, n = refnames->nr;
>  

Doubly nice that this can now be static.

Patrick
