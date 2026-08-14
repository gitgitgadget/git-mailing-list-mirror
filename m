Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B2403151
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693775; cv=none; b=fs2NZdBR/M8lYnNpcv6YukVO/TO4conuJolS9uXqM9xonOoNbsuPFf+dm8N+fONNux+vMhEbyuOidq6HHgFebx0CgbLqbyh9hm785NnPLPAKamQC3qHAhdXWTUhBO/0wKOh3AJgFLgqUFeknNvYSvebsxwItxOcJczt4lZ4WcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693775; c=relaxed/simple;
	bh=rreguE/6xbQu4oYs6YtAs8EfcMLFXh2Ujuzr0fJx0rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQRmqxZPGW3uL4F9cD6agJqMgJ2bSrQdfw0ee8uygDGn5xKruyb0RGb+L5Zqhe6j3bSbT6i8uA93lUBLvKe5DefrrV7fS5lVkc5UHaUVSlms/bB/la+3j07VfnnqsSFePmSJh8tMuATosMf1UsKE59Er9Ar0jkXAsVQSmsHo3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NPbFdmE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSaayPI5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NPbFdmE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSaayPI5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B8257A026B;
	Fri, 14 Aug 2026 03:49:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 14 Aug 2026 03:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786693771; x=1786780171; bh=l14IMU7xlF
	I+L0ByuUREJfHfRDCr/RgrGmAgWGrmZQc=; b=NPbFdmE0LmDnv9bPj5TaJw8ptc
	GSXWwUryeIdHGFkvO6klrcykbf2oFqWnIrNE1puFP39XGhCxtXJegnxLy8Q9EqeQ
	e5JZx9r0Ho/Inq4pI3obzHawEX5ol9/gopzwPN5yja+x5MJ2qisUNJO7+oEylKE7
	IbyoYpWKnqc/m2aZPYy7CV+kUZO95qfjcOrpNy6+ogwMJm+L6UdoY3Jr+27F6quZ
	yUfqCh2YSy6cbN7XQp6ahM9yG9QqG9xlI3G5HcVeLIII+fPxksmW+XrGZPk3YEyr
	B1TyhfEH0Ls19Aek7bT6lBvajuHGMj6lj5VvH6ImdcZC+oDTK4e+vX6+RaUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786693771; x=1786780171; bh=l14IMU7xlFI+L0ByuUREJfHfRDCr/RgrGmA
	gWGrmZQc=; b=GSaayPI52Y0qEy0IWX831yOfoIJCJSO7OrKOtGw/mjm5aqytTd1
	ipD883GSfUfTiAZPRZdc16Br8YlqBdbKeFRGiH6nh9hMEm/jAEsBl+0xZNfvk5gN
	0aKwY9VJjLIP2eYJAsdto9hseYo+6lt6SMDGPKW/Gn6F4dgPOklRDl84k3c3tPGp
	ePjNE7jtuddpEievjicQA1cHOxXw2qPIdzpjS/7BfRCifdVyLBKNjxLofpEMKaNL
	clzAhRauHGyEucFA8Lval6VQAGdYzc+ZVrwO4MM6Y+7DpL488lOABAervLeEvqlx
	ZtjIpj231ffPRhaUnjY6RNLhaI2pgKJ1nEA==
X-ME-Sender: <xms:i8h-alec_sgmIdsp4Peam-2AK5q2d0xQOesLBk5O-BvyiOrtEexRIQ>
    <xme:i8h-aqN7QUrDXHkuJdyjXVe4f8WBN9MrPzSlNIHBH7-38Z4Tw2bfQCgYikKPLNAO-
    KVQw3dpd9TU98GFVjKQxU-REPdKOLpVywgyrcI4Nfndh76NO1MWDA>
X-ME-Received: <xmr:i8h-ajgkJDV1Z5BxVlF0Q9t__OZ0d5bLZ9Bjt6x_reqWJhY5aqJ_RbjEMMhiJ47i-XDFXJS9i29sFMrwm2kDYPd-HIVIHFgs9sErcercrmw>
X-ME-Proxy-Cause: dmFkZTElrfebw7WXXUI/6KjedN74Vo2BRX5n8aU6YYop926r+Tgj1OPAUaiODVciv6f/Qw
    IJ3Pvk7w3Up/IBzOLpTyCx7CSy1WvaMFZOvgNgoWcvDstE5fGB8QJY2X1zXL1OVohh4jzt
    vIrMrX1yW0slxhLQhLVPoRHgfgsU5wP9tBw2B0vGmooYVq5W4CY/hgEnZJkS9sGm4yHRnr
    u0KPFV7wj8V/t0Obn6B5Fs53jZcV73cDWGJn/7fHenUd4050fJpp2HtdnDL7tZzB6BfBZh
    WD092+nl7Ey4w2Je7ABs42tV0yFDTEGrO63mFbAm7AGSBLesNDSyet+VTNX89gdAb+nKVJ
    OOhj8u4iyoyFq/NmOkvEA2ygItO0NJ5YnBK6JwkKx5mn5n1pMggLDb3eMHDGG20zpxIyZ1
    Dvcif3AdWWiFSxaHmx60nDTGbeEGio4NINJbjB081aea3fQ+1dzAjp7QC20maKk9uaOB1d
    1UZ9fK5KYLFi7vDdAFkk10WN6QFsjUk+TJnjPSrCW1ml4MhozMF0yW1/3/jreHhfPgc8M0
    QsmqBQm7OPjltWSZ1p0MFQLp4qjOdQhEI59kaFaP3iQyvQy+sVGK4eLWelLgd0cua2tV3k
    go4PrWngN3p0qzAIihuF9PQffmgbPSXXF9vNOH+Upa3k4+RD/ZaXeuPGRBig
X-ME-Proxy: <xmx:i8h-at3JreU0YKOJMXPEiKhabdrSNoqTMMQJ4X02oeru6qTLi1AybA>
    <xmx:i8h-ati2WFnELfJwi0qIysNHCvORzYLkwry4j2MDq-kWjwvZE0J06A>
    <xmx:i8h-atc3wuz2yq8bDa_DPE9ROwEO5pNe1GKLVtETZvwq46_HeuKb0g>
    <xmx:i8h-agkE_MCnfNGhIe_xAzKL2xbyCGVzy7bj3aoEQ5qQgkjQPY3lXg>
    <xmx:i8h-ar-IvdloWP8hjPkkAz3DecdUkDVA95Z35RSMdRTD1AP9xQqdKqq7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 03:49:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7916db3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 07:49:29 +0000 (UTC)
Date: Fri, 14 Aug 2026 09:49:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <an7IhgES-reCzQMr@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
 <20260813161525.GB1386479@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813161525.GB1386479@coredump.intra.peff.net>

On Thu, Aug 13, 2026 at 12:15:25PM -0400, Jeff King wrote:
> On Thu, Aug 13, 2026 at 09:35:49AM +0200, Patrick Steinhardt wrote:
> 
> > An alternative would be to use a hashmap here that tracks the packs that
> > have already been added. It has the advantage that it also covers the
> > `prepend()` operation and that callers don't have to be aware of this
> > mechanism at all. Furthermore, moving preexisting entries to the back or
> > front could become O(logn) if the list was doubly-linked. We do this
> > operation quite often to re-sort entries in the list when looking up
> > objects.
> 
> Don't we already use such a hashmap via packfile_store_add_pack() and
> packfile_store_load_pack()? That comes from ec48540fe8 (packfile.c:
> speed up loading lots of packfiles, 2019-11-27) and is how we know that
> this "is_new" flag is true (otherwise we'd get duplicates during
> "reprepare" operations).

That's a good point, we indeed do! Maybe it would make sense then to
remove that map from the packfile store and instead move it into the
packfile list to make it more generally useful.

Patrick
