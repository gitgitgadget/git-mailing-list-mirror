Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6C25B0AF
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300415; cv=none; b=adQ4+FFM1xlvAbsie+vwKcd9kuah7FLrT/32Fc7cR4Qht6/f/UNbUmLMeaHpn8ONu43SrVF34IvCA5lZrrfr6PCwGcM2YShTYcbgk5uysgzNykP0h/RocePARmxqgE53X3fABoySR38zV6sOUnPLhKkFk+lJREbebfNa/37RH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300415; c=relaxed/simple;
	bh=WHuk9KrvmxqNIwjAKzgGYYiNH8poQU8xkGANkWMNVLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7xUfstsx/FEgN9eyfdT2Rb96nCamhuBhD27vz1w6jO81SI7SMTyDMR+AX1hxb8qkrJnS9vLQ6YKL2pR6fHC8yk4EWtVSfg+4uTKcxfGFOX8IrYS662OhYs/8oHKQKI0CehE2kPooA2i910wW2JNuyigDqHyFgarOLdCZCctWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E90fw2Mu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgyuxOa/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E90fw2Mu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgyuxOa/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 422657A011C;
	Wed, 24 Jun 2026 07:26:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 24 Jun 2026 07:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782300413; x=1782386813; bh=m+XIvzqNpY
	Uj6QEwd6w9Aa5JX8qmJikgZsKdK+PbOlE=; b=E90fw2Mud+PRyTLAkz+AP7d8LQ
	uMmexnmeO7ZoYrgw1PmWHW+AyvfVynb8E+uJKS/yd4osWLyXYvgtIhxaEOZY4eDX
	O/G8Z+A+EZ0joKLTe6MuAXe577fj4Jxjhr4Koln2zKjQ7iik80VrZDSGnSHeY2k0
	zK2eJcSNjqq57iXGBogWh5de2S1pVISBrfvobo4PBtM064+Ab+Pt7lfYQNzraQug
	8srmDnTgOdDFtIChCdb+AcoeceTjUvjczM3v4I1Hr68UUMJt3bABvD7gbiwTF+/R
	fKmEiP4WADJ8xFCkyV8iDDd39vpiA/YB54OwxOGF1ywAyKdI8kWt130u2rsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782300413; x=1782386813; bh=m+XIvzqNpYUj6QEwd6w9Aa5JX8qmJikgZsK
	dK+PbOlE=; b=XgyuxOa/NFDD+r90KjY4grFHSRTVGFWrp7NuFzn9jKROh9Xd78m
	RC99MpUhxy1pGhEtVrSQoz6aFz1wgvYJngk/f7fCAMPZsIiC2ayg9q6zWFWBw73p
	zTHDcNRbb7GD0mVG4uYcVqCVA/VUBEQlnnN6nJpqdTbGLav5Gw0Rau5lc1Gc0pMn
	AvEodiHt67yLEl6b/d+DlsEp/eX9qfXBg4k8v4TQXs8fAEUufQUBpJtSevuB3VB+
	wyu5gdU7rwenMRwfUzV/Q9Gjy4r0iVBoel4fSHQJFxM2QBTmSku+Z/iOkqck8Jyd
	GypZdpnck2JSWv8K+a4fGzLgytpiMGdozgg==
X-ME-Sender: <xms:_b47amiVq18Jpv57GVzvMp6oP7UXJf6fT7aJSfF1VQe_iCxhKUm0ZA>
    <xme:_b47atCsvahr_iyTxTLJpNtCoz7MyQYkeMUrG7OQnyOLceFPjq5vzH1fCADMxePaN
    NMowpsgdKDorhPmBneY9kp1m72ffI4pqvh9K0ugKFX6EuK5D-dlug>
X-ME-Received: <xmr:_b47artqDiZH2Zn0r17MARkWxhZJN318ZpmllCwt9uikVTSKs4FoujqZAOoY1ZTkKLlHSYRGW4syOdwgWCQhndHhzJQYBr0C88vQ8R4q>
X-ME-Proxy-Cause: dmFkZTE8nadoKE78MhcMgd+5yQWfYE0kD+bQfooTkEol/2jwh+xQsSE2EvTICLpAxVc6wf
    Mde+nLtwhCDFgylcTHk/OMcTocidOWfSjCfl1ep4tPfzxsNejPrls4ML+APBsOAX3uzheb
    JA5MEHFKwGvkD+b/6WuDd3yQyXQ427/ILRxgyd3XU1A7aAwGy/3gEHwr1+FN5NtTpHsvce
    YqPsamkWBANJ/ROUZROvLaY01t1XVO7syFfaNDCALE6hrnBXo62XNAv4kgX+djkM/VYmwI
    BDkK38geuCKVXOnLz1wAfv1L1r+mzoInrQDXRoyahUbur2UGZZXpoWwgZQ+JkM10xqHIJi
    j6u9kYVKJdux4rcoLrM2/Z5pDYOqfX8ZTIgO1Qcjb54W5TYsQTJEDCyecs/SA9PBdB3e47
    oIE8UzFAm8lFbGYUdwtzfBPyvreXAwH0HZ+1WxrcSY/OLpropzxLCmcuwTbF4yzPu8jdLY
    koOPpjsRffcztdW9/6NQBtjLAfmZV/OzvYIulzuzHiqzeJ4mL4tO1cW4sN4zJeohkfKlLg
    rsjH7I5ib+m0eJVImr6TXATVqa+XBr1JBqbl1qqqKvtKrdSREBgMTjNiOphH/h3k4EDhdT
    dBhzfFcl23eGV18aPVBmeFZTx4JgmC/LXY51wov57q3miShEFPz/uxPkxgdw
X-ME-Proxy: <xmx:_b47aqa8Rd4k7WlpPJnZPqoeyDlcXC0pTXav7t_HxOEl9FfFlM-wyw>
    <xmx:_b47amX0_BGroQN6bWalnyqoCL9_yqC5ohhqL812cvFiLkGnZDEBIw>
    <xmx:_b47am64-mzWEP1ZnOOJGET_mUEaoPaphNjIU1TPaOFEsY-64UVzhw>
    <xmx:_b47apgNcO3GQWe8CTHQvA55k7vlstPb6kHAhzXkhAnuidGGt0mXMQ>
    <xmx:_b47auSmF8AhB7srdnD0yGpL_R0gIBk3Jexbr4WcRoRctJ3eM4zDLitq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:26:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d0559a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:26:44 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:26:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] odb/transaction: propagate begin errors
Message-ID: <aju-8hUeuyL6gnNU@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624041920.2601961-4-jltobler@gmail.com>

On Tue, Jun 23, 2026 at 11:19:17PM -0500, Justin Tobler wrote:
> diff --git a/odb/transaction.c b/odb/transaction.c
> index b16e07aebf..d3de01db50 100644
> --- a/odb/transaction.c
> +++ b/odb/transaction.c
> @@ -2,14 +2,20 @@
>  #include "odb/source.h"
>  #include "odb/transaction.h"
>  
> -struct odb_transaction *odb_transaction_begin(struct object_database *odb)
> +int odb_transaction_begin(struct object_database *odb,
> +			  struct odb_transaction **out)
>  {
> -	if (odb->transaction)
> -		return NULL;
> +	int ret;
>  
> -	odb_source_begin_transaction(odb->sources, &odb->transaction);
> +	if (odb->transaction) {
> +		*out = NULL;
> +		return 0;
> +	}

Hm. So we may return successful, but not set the `out` pointer to a
transaction. And...

> diff --git a/odb/transaction.h b/odb/transaction.h
> index f4c1ebfaaa..cd6d50f2e5 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -33,11 +35,20 @@ struct odb_transaction {
>  };
>  
>  /*
> - * Starts an ODB transaction. Subsequent objects are written to the transaction
> - * and not committed until odb_transaction_commit() is invoked on the
> - * transaction. If the ODB already has a pending transaction, NULL is returned.
> + * Starts an ODB transaction and returns it via `out`. Subsequent objects are
> + * written to the transaction and not committed until odb_transaction_commit()
> + * is invoked on the transaction. Returns 0 on success and a negative value on
> + * error. If the ODB already has a pending transaction, `out` is set to NULL.
>   */
> -struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> +int odb_transaction_begin(struct object_database *odb,
> +			  struct odb_transaction **out);
> +
> +static inline void odb_transaction_begin_or_die(struct object_database *odb,
> +						struct odb_transaction **out)
> +{
> +	if (odb_transaction_begin(odb, out))
> +		die(_("failed to start ODB transaction"));
> +}

... we don't special-case that here, either. So a caller may invoke the
function, not die, but it might still not have a valid transaction. That
feels wrong to me.

Patrick
