Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1520C01B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472025; cv=none; b=K+vShYhIGCk9XCUMyEmVaGFt4dcehZG3HNHy3n6Lmi2ZDobc1o1zO/ZmuFb/tKvzzBP0nroklTWsiu0aaj/YbUFZJtK1KZX71FdaeCcV7m1CHk5mle7UYnVB6QWUjLoFfIjAqWSI86XFgjvzkrHLFobgwKxGHxWBZvzfNeP/rUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472025; c=relaxed/simple;
	bh=/yM3iGLB0AatQS0NOIXNKzoAeOeE/A6QN77yVuGwJ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq07aHDyg5iOo5XVUDQwu4wERVhSF8OHbtFloPXliaTyKj1+1ANG2KskijgpBgiA7OO6lm/+AUSdPtv0nOP6adW6xDlcnTlfiVngiUgFJsCDHfqTHT6SArN/LaJvZPu4wOTm1rpNYx7BKlYDpmxyhaKv3paujD8q0jc7MoLhjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVGP30h7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CoqLdcyy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVGP30h7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CoqLdcyy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F122F1140171;
	Tue, 25 Feb 2025 03:27:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 03:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740472022; x=1740558422; bh=EjrU3euqTH
	X616XRnLEYWkkysdPA6TLyH5dZTXF/dW0=; b=IVGP30h7vVh+4yBNbedB44lSpi
	y1Lp0U+QukKMZftv/S0c6XuTtMQ14n0hiad4BIx1YwEJEXxgL5h8X+NP0dd2oLt0
	i9QjoM250knWZl5Zra9xB2ca4dT2f5uK8fLwI1ygB261BOG0boKDGLycj/p1jI/1
	2KQWk/XWcpnDyh/JP7qXVzD/rJ5o2dQF1LlqYqs+i6889JJYSzwyWkPLE9uFlXBA
	dzP5yndhnuW7dv8kiFMH9dPvaHTOs8B18S1xLKS/adSRDkgdtKwJ8XQUprgGUj8s
	w/JVKaVT0eDzqw+920bfyy9eb5lbetlTORQppoqzwueTinNogcmIcZ1zw/pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740472022; x=1740558422; bh=EjrU3euqTHX616XRnLEYWkkysdPA6TLyH5d
	ZTXF/dW0=; b=CoqLdcyyFetpTmWE5m21qiriC659yEXA8aEMC2qh1uPGO4jljks
	Tdt0xtgdOdmIe8Nf1DXbEYgU7e6JNVivxX41Z6e0tCaC4tVtBOaMd4LdxWzDnJZ8
	rZ0q/GL8W7oe2UzswJPOIxNTxFRdNbpdbGHfM5gaNghOMhHH9kpMd0YMPiajf7PJ
	lRMp6ebw2aC9IlQWmfzhr/nKhsAHsW58fmqJfwjHohE7LA4lCmQRn7aTxOpl8E/d
	FgNlhpCxJTLSPEii1SfFAYJ89wOvEaLkYJCUwPittwlzyHueT7c9bqMpQyUuV9qh
	T2oJw0nFHhtpbsw107kZUortXjTQCVRnkKA==
X-ME-Sender: <xms:1n69Z0sko6BfnWGcgX24EtNUd-V9L0JkoXFKY4xJB5xb9YoqnBrF5A>
    <xme:1n69ZxfyK7-tJFY2f9M-UtPl-foaR_IaV6iSZ64l4J1ANwnFOFJH7phAzKxaURqrk
    ecMAidl7KJs1SU8zg>
X-ME-Received: <xmr:1n69Z_wVy_dVzXAyqjLoCzpZYkpFyCj56sGz6g_X5P3KPkXK_wfWZsom1F9Uj7jSgmw4DnA20mfFWHc2KYpuOYH0zi_ILDrtPn8RXU6_9vYhMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdr
    vgguuh
X-ME-Proxy: <xmx:1n69Z3MwbAgQQHyAgZb0aRUBKV55d5WTINsgyxBQpeKNlukq_pFPMQ>
    <xmx:1n69Z0-332lb6yU7RFy_i_HiaW0gE43qB7Y5AI6fzLtOUQuAZ4OdTQ>
    <xmx:1n69Z_WirBJTYJTwUf_LDL1IV8CES3WHA5ptW-GhwZr4LAqked6SNg>
    <xmx:1n69Z9cRYzAghPqUNMPuDvI8Rkn5nXVsqIKGgjCP-n53bP6ChipyyQ>
    <xmx:1n69Zzkn0j7h_IkMfBE0obAKCxBL-TLt1mIoZsk8GQX-gbdN4JipKtmB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:27:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8efd8546 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:27:01 +0000 (UTC)
Date: Tue, 25 Feb 2025 09:27:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 3/8] packed-backend: check whether the "packed-refs"
 is regular file
Message-ID: <Z71-1EqdYVAu-fp7@pks.im>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
 <Z7NVbvyZTxspTjWX@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NVbvyZTxspTjWX@ArchLinux>

On Mon, Feb 17, 2025 at 11:27:42PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a7b6f74b6e..8140a31d07 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1748,15 +1749,43 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>  
> -static int packed_fsck(struct ref_store *ref_store UNUSED,
> -		       struct fsck_options *o UNUSED,
> +static int packed_fsck(struct ref_store *ref_store,
> +		       struct fsck_options *o,
>  		       struct worktree *wt)
>  {
> +	struct packed_ref_store *refs = packed_downcast(ref_store,
> +							REF_STORE_READ, "fsck");
> +	struct stat st;
> +	int ret = 0;
>  
>  	if (!is_main_worktree(wt))
> -		return 0;
> +		goto cleanup;
>  
> -	return 0;
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
> +
> +	if (lstat(refs->path, &st) < 0) {
> +		/*
> +		 * If the packed-refs file doesn't exist, there's nothing
> +		 * to check.
> +		 */
> +		if (errno == ENOENT)
> +			goto cleanup;
> +		ret = error_errno(_("unable to stat %s"), refs->path);

Nit: We should quote the file name: "unable to stat '%s'".

Patrick
