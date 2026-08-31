Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B425771
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164077; cv=none; b=lQLST1W/G3I2BnA/ZLAZPb4fBwZm2P2kkNJlmQSG/sCJb3+67WG+n46ySkJ8NVgt6acLn3BjvUfqmTuYtFl1Zwr1rp/ij/kBj18CdQFYw8yrb9T//SRrjZidWja9dHnLy121gJMSd7dmSr8GrAyjf7doLHqg7aJINFWwRf/VD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164077; c=relaxed/simple;
	bh=Kjl4cafSvHZzicoJeoXs5J/JYBcznSk1LepwSq6cxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDDIWVwaH3Pb9BV1L7hOL16j0UBite0tC0PvV9evlreDVsgggdaJrzvoJjX6Wwj3Y+/egJk6quyBSfLyG2hLTt19JB5XwjVaji1/SiXCnje+eHiCS19ODBm8hQ0STtPN3X6LLOm7rRkr0VSXRlpf4let2J4kgAyLhyUY39wqUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HWQnFJzV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Es1csYki; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HWQnFJzV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Es1csYki"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EB2B7A005C;
	Mon, 31 Aug 2026 04:14:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 04:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788164075; x=1788250475; bh=/k2DL4y3S/
	gJAw9TU6Bcfhnevbcoec0BCIh9lfEFsiI=; b=HWQnFJzVvkkVqVhNTPmBvx2kWj
	x7OUus7bCeZADniPgKFiVr3QvaTqsl+YYnJVCB0Dgq08y/ze8D7QlUyNUg+3c0kj
	gOIhaGUv6Mlq7eseyQwllanzLONWxJFQo/aXzCDRF7DLEd57w/zMeHfvN29ydV1k
	684GgEy/qY7R3Bt2E7PAAlrGfZBLgX8dN+Taqp+efa0CpvSodMwA1uta2QXFM5gX
	BMIT07FVZp/H2mALpn+PRohx/z464Zz8MWXpxZiEKRGdLERU9c/PjxDQYNAmeq2O
	tEgWnAOyAPqJOkAC/qfn+mk1Z61YWX0Ylzfz6VqEWph19bLtEZpb2apzlRzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788164075; x=1788250475; bh=/k2DL4y3S/gJAw9TU6Bcfhnevbcoec0BCIh
	9lfEFsiI=; b=Es1csYkie8WxORyGOtpVo0xEKYOtw4/nQiBNOnRofkrisUlReel
	CAn0j8nREGUhUdzXwWHy0Xhwi5w8cWGVM/yXP3xng4X+PFSVujGHspKsUvd5MBYq
	wPH0KK6+96eQ83W4LPeN5TYnuDqURm8LDwwh/Hl3LBSkxx5zJMD7KBEpxS9gQ87Z
	ydxltJYcLtCqPCaOCzldmybcVdO5WpzqrtNqWEyAJIiKMg82lQ41231y3pIWkrkX
	1sJjVZ1/SXDEuUhuqHOWtpCpgK3R2t+4MGfTaavDgb8LOwnTZNOdw6IEvmQLpnC1
	uPDYLpQW1I77Lv2GpaP7UVHf/ZLBUqpOzFw==
X-ME-Sender: <xms:6jeVai9q-k-R5aXBsXKkdS3j6EaCBKb2qQNvUeXxLYzGDvjMUysKAg>
    <xme:6jeVaosP7YYnpDUxtSz3LEjEISh_Vi7hnBVnu0xifyEDPfQmVGvama_sT0ACIL5dB
    adQ7sotmSWWr3I0WJ5ZhfPMvvkUyioNzhXiGsVModqrMh8F7crfNcc>
X-ME-Received: <xmr:6jeValp2U4H5rHPiJwVZ9WruUlf_kpMmAmo4BOqMHyXQ0EtJaDWyDF9xDvsiqOhTrAnbtw>
X-ME-Proxy-Cause: dmFkZTFZXM4nlK7FuyZfh7KCinb1QyGk2t3KSS9yX5r1PCB1Xa5vcF8NfeAsZ67pSXj2ji
    fAT+1vdX3nk639xkgZMwzZT5pzCYuwKtrrf+X55yT+oZv2K9xDX23VMWH3hwqiWhBV8BwZ
    Wy1AB3wM7mVN+sc4Q2PZI0DpMgOEfkJBhrhHEEQCGbDsPXyNrDwh8Yxp3EKVJStka+0YV/
    cA7j1H4qwk/p45uS6WLyAy/hT4bB0VmK1lbYNulT9LAUcZxIyA4CjG5osStpowI+IyYttD
    w5TXW1cS6UZxtFPb/7gVJaYXUWCdvApbm08K6ecFPdWCI73cTqUzZU/ZpZik8DucGQjdsi
    jE0UhonBcQt5+EDqOcgbcm13X1X9LyEwi/keLiw5MC69e9+6SJQorrqiFIbsD8dkcn2Xnj
    kNca/m57bjeNP35nYVmdg17OqqIoVf7p4LyYDn+jRRvL2kQ7Mw/dWyU2SAMEz1Ic1d6fgu
    AwK+0Zj3XqgoBGVQSo7uDNjmpzhBryIEwd11r7p/Znae69i00vZ2izIWb6gqkpJQdqMwfz
    hZHtSKf8lHwEGFR7gQe3/27DJw9hsHqI/sZeAki+af4V5EnA3f5fA4U2L0XzjRPZw+JN9s
    P+Ylirg1yesXomO/tf53QMWGuIhHb5BWLRHNeHttYVtt1AeRUwozP/jr2Edg
X-ME-Proxy: <xmx:6zeValmJsFuim5XBmn8U0nzsLOHgF3v4PuUPJJ59KOaveCyAJwjiDw>
    <xmx:6zeVapzuYltzTwE1svWlDK1sXG78ByzUll39Ei7Se63T_iBCYhPgVA>
    <xmx:6zeVatmr56isIqr7ZyXro0R4yGi9ckktFOoqI8lKC3vQj_UG0fG6kw>
    <xmx:6zeVaifUqYTOZucRNI4OuytIlOQH1BmVZjGGouMmRJOS2oiDKb6_PQ>
    <xmx:6zeVauU7U-d7p9o9Lvtr_SuhJ88RS2lfyOzquIaoH2ab3odv4LNJmFmK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:14:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47ae3bd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 08:14:40 +0000 (UTC)
Date: Mon, 31 Aug 2026 10:14:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] odb/source: remove the ability to write alternates
Message-ID: <apU35PsS6kzMbQmd@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-8-911513ba95c3@pks.im>
 <871pbiuwhw.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pbiuwhw.fsf@emacs.iotcl.com>

On Fri, Aug 28, 2026 at 04:53:47PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index 5e77b21d9f..feef9e169a 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -303,59 +302,6 @@ static int odb_source_files_read_alternates(struct odb_source *source,
> >  	return 0;
> >  }
> >  
> > -static int odb_source_files_write_alternate(struct odb_source *source,
> > -					    const char *alternate)
> > -{
> > -	struct lock_file lock = LOCK_INIT;
> > -	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
> > -	FILE *in, *out;
> > -	int found = 0;
> > -	int ret;
> > -
> > -	repo_hold_lock_file_for_update(source->odb->repo, &lock, path,
> > -				       LOCK_DIE_ON_ERROR);
> 
> Why is the new implementation not using a lockfile?

Junio asked the same, and the only reason is that I simply didn't
think about using a lockfile at all. Will fix, thanks.

Patrick
