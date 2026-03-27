Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13603BF68C
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597815; cv=none; b=ltTlkj7TXloO8KzDC9ev44eH7GaN7t1r4ulDD9f4UiClYize7q7tPhG01zC28x6vBqvK0PkVuP+8vZ6vMl3ujFEdkNr0XqWY7VYtvPA8lJxt3gQ31C6jaULa7gzP189uH6vl4PEdV/q85gYDZ4Pd5mqMaq/rOqdRqgt6ffXwn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597815; c=relaxed/simple;
	bh=gB8APKH3wbBfE6EC2acd68hc7GrikVa0rOm54BBeNYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIdr7WzfDfYUBnryosSsuTpanExQnSp2XsdnzvHxBB7geWXgDU+Tckdj6zRoYumGiCoHCQo4m120BY8/WhKTI8E48abumk+G6P4GI50QavRGOPLrl6Mx+ZmW8khmxFvIugaU6a3kv2+RCff4dPlh1EknBwZpVBYUx9e9R8Q7Vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MFhTn08N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3DDVEgY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFhTn08N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3DDVEgY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A188D1400200;
	Fri, 27 Mar 2026 03:50:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 27 Mar 2026 03:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774597808; x=1774684208; bh=MAfivMdvfX
	wjQisz2rbhPbYbGzHTEhJHGqHHOVFA8EU=; b=MFhTn08NwlR005mldvqDVh+888
	6d0uYDkfX699mhiq7V8DUU1EgSoSYqGkCvyar7oQoDkIWygIP5gDOT372KHEqlPp
	zMUGDsHqug8jKcJs0ioLToujE5Fsam1C0OKx+VqMGzCtzMxvA7SdDaDKAhEFubcW
	SQ0GNy8VlFyp2r3W9qRTKEdMesW4LqPMMcN/WsjR3NbCoxBVzA1CxtlIaxjbWlVG
	WWyoMBVvXbzfzXyoHqAZPFMgmBhkpdmDHQ2bH7Gym0SXngCW3JM/D0c9VI0us+yb
	CAKRqBdHmh6EoLUhVnZV0EgQqU3liXCsC19+RRl2pawOEry2bUb8qdnU3YPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774597808; x=1774684208; bh=MAfivMdvfXwjQisz2rbhPbYbGzHTEhJHGqH
	HOVFA8EU=; b=h3DDVEgYsxvrZvxoUt5qmAm/Gw3EUa/3lLu1BglsauFuySM8Ogx
	yK6DB/ImeYQEPGvrhFOoIRPWUM7U20eUH6ocw2vQOmX98pTr0BatrbPTMM549EMG
	Lf2EcBKCI7ro+WedBOqyGcm1NQybVUqRMQMve+qq0xsVKpM9NNsTPlSFq1Q388Vs
	EhaiQ1IgAz6DwCN828f3+DFZfKP0TRBjbTcjA/43B/b0uiIuKCYnrJ578m8JqXvU
	11WznBfHXnpNgtPEr2k+Duf0qQPx/XiWfcPLVtzYXsdWo1Nn0reiulk1SL+PdWT0
	4LD+S2uz0zRXL+pVP9ati75wMHMsESiX2oQ==
X-ME-Sender: <xms:sDbGaTnfi5KJX3LvocfT4HuaSULtjfk2STY4-HS-CKSjrpRTc932Ag>
    <xme:sDbGac3gOh_AcyHJI7NRGnU7IF0wjNFvIqbjVyHOWDlmH8iN3gXaR26Q3rSsGMXwr
    wXOpmNtzQcHA8bloLT_9LT-CkvEaFY5BUEXX5StxYATgqgeEzzW9w>
X-ME-Received: <xmr:sDbGaXTbTmk8lC4yL5tnOiqGsVlWwx4KPYZhnHmEfYmVMVcd2VruRWMTN_JELNR80Q0ICHxIFahWdiD24MM6GfWResbrH-ikAbm1cM-elA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:sDbGaWvxh7688e7EvzJtH0zJh_AGO3tJ7TDfsQB2ioGyTcmlGmPkmQ>
    <xmx:sDbGaUZqMoUpd_9MtrDDH1nBiVWS-75pt0qhu4NNHiJpuNe3LahDrw>
    <xmx:sDbGaTsPEkxmVdnQxoSVEo-4_45IK-7-vtD8MAEjFBtOMwTtG83D_Q>
    <xmx:sDbGaeEwWK0EdyDmS72guJez3PYvHQg76n_COe-DexfWo7K-RElSxA>
    <xmx:sDbGacVlZDHAGvKl0SDfw2VFS0R_1bis18SNSSJN9pDzvz0hoUGPeSxK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:50:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b029b818 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:50:07 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:50:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make get_files_ref_lock_timeout_ms() repostory
 aware
Message-ID: <acY2rALGa-CdYK1J@pks.im>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260325164833.1216577-3-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325164833.1216577-3-shreyanshpaliwalcmsmn@gmail.com>

On Wed, Mar 25, 2026 at 10:14:19PM +0530, Shreyansh Paliwal wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 7ce0d57478..ee8dd771a4 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1190,13 +1190,17 @@ static int remove_empty_directories(struct strbuf *path)
>  	return remove_dir_recursively(path, REMOVE_DIR_EMPTY_ONLY);
>  }
>  
> +struct create_reflock_cb {
> +    struct lock_file *lk;
> +    struct repository *repo;
> +};
> +
>  static int create_reflock(const char *path, void *cb)
>  {
> -	struct lock_file *lk = cb;
> -
> +	struct create_reflock_cb *data = cb;
>  	return hold_lock_file_for_update_timeout(
> -			lk, path, LOCK_NO_DEREF,
> -			get_files_ref_lock_timeout_ms()) < 0 ? -1 : 0;
> +			data->lk, path, LOCK_NO_DEREF,
> +			get_files_ref_lock_timeout_ms(data->repo)) < 0 ? -1 : 0;
>  }
>  
>  /*

Makes sense. This function is used as a callback to
`raceproof_create_file()`, and that callsite is adapted accordingly to
pass the new struct as payload.

Patrick
