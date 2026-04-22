Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF93CEB85
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856534; cv=none; b=Bh7c7Hbn2zBRNT1QsHFwkOIxvFJ48atGzy7IdQrMti6UwpMov+jyGuMnep0EWda1rh02wml2JNRwXQrhrDEAsuHknnGkM7RHHvcifPKQb+9ZhCSRTQDA9u8KXUVrdYesPkHuFjx08N+N6Hmjcl0O/KSrnKoWyybuq3svDzBiqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856534; c=relaxed/simple;
	bh=8nyGU0IT0N3rORktfs9eu/1216TiV9hVioiy7NFvF94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmnaZXhMu2EBkJbxmhOgIMKG03h6VAcjQCTV0YQfJYb6cx/JHELPwR9U28Bh1QWivVqYhfJroClLNI+iw9uTHdBjir9Deoua7WPesg78E1kK40lGM7DmqcuLh0MXs23xdEAI/FZp+ZZm0QbvaSl2UOOD3+7njezA7/iih5HKv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pFVd93n1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1Dw6ZAk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pFVd93n1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1Dw6ZAk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A4CA61D0016D;
	Wed, 22 Apr 2026 07:15:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Apr 2026 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776856530; x=1776942930; bh=I/Q/8JMTGb
	uRpxCQmZEpH2kk3avq5SL2OLPMbgSbCuo=; b=pFVd93n17vSy7nJaazvEtXoSFd
	XoHo/7RaGTu0pD4z7SWLFbEvc3XB1Uczq8ecOv3ThiiYK1RitZj+PePLjQKYEUkM
	zxnqcS9fjvXxoyvPOeO+yJiGujMdDgo61DN6y8g54qt+FQYdLYG8CbZ96QVaK/cC
	pD6SdMgn4AITzeMUvgqpZeXG0UhABiTnhPo21oRQWktcjsyNRSlHl9E/7aLfDqme
	/4yQ7FlSElocPaBOfXsFMXxFFyD+KkSGw0+QPKYeAZ6GQxa6Se8Zxv/jTExNRq6m
	4XR7fnszbBJkOkUGVRlf+GMb8fLOw5qK6ZjVuVFvmo07bbPkuFHTiLbrKvww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776856530; x=1776942930; bh=I/Q/8JMTGbuRpxCQmZEpH2kk3avq5SL2OLP
	MbgSbCuo=; b=X1Dw6ZAkSwJm85uAYMME7C2fXKvfgZ688hvYggPyFJ/o2vxq7jO
	0S6p2yK7a0aiqQAcRF1QOZ3BiUUekMPzuTEnhmozdc+vFuGJoc2uA0mnXIs6RB1N
	giSB69hcFkqv4SiHv16hLaf1i7V/OPXIMpFXWDiuIiFD4U4Xlj0+fAwV2G2wr8st
	Fy4f9ExvV4B6NI9DeK4Gbs34EfDsEkUrfNcF1hzuBWfPbD7V1OXxPxExVeieDVp6
	OHXCJoEuLclIUtQj7TnWwUf0DmjH7r4JAv7P/HHKLjGr+7ZBadjp6kYyFZqRVu8a
	jfmeDDLulA6EigJMrzOBdTFydl6bEFpjtZQ==
X-ME-Sender: <xms:0a3oaWAtYPAxTKNnleEPIL5vo4bUtu6NIc1WZVGc8HIfF0YsrrXr8g>
    <xme:0a3oaWgxy67p6uKU8iKoJYDrEQxnLqTIGvCLrlCPHKs0o-eV0Qtn3aAxYl6kgyekG
    KooNXJtE8Rqd0fN6gXZjTJSMFVZjJaW1blyL7peNJ8SBnSvZFs6aw>
X-ME-Received: <xmr:0a3oaXNvEOs30Xtj6Z5pZ6dmnIlgnNPM8VDKpOUFSfLsMU98lfRp9XbAZhpKnMWnnXuCZiIAL5a1Ip_e35eeJCn4WkzU_-jTmO0JGMaP6BI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0a3oaf4O_3nX6CllYvusn8ZnZXz1UlBuSbo2NmMo3iAg_uMzZRIRoA>
    <xmx:0a3oad0TABlx8IgVRcLkgIFsqwHKrvR-1lNEBoES5w7iDBHwW2NdUQ>
    <xmx:0a3oaYbuNEqf6RGs0lGyvNpA-CeFdKNV8DUOiUM7SD1JrZEGRpU6LA>
    <xmx:0a3oadCl8hnu7hksBhNcuyvgYKfUCVhpc-_ZdiprUuKWk7_88v_Lmg>
    <xmx:0q3oaVz-EizKA0EWVIQmU9xMcOsUgj-E8fbuiWR-gWeft1HBJsOids1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:15:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ad112ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 11:15:27 +0000 (UTC)
Date: Wed, 22 Apr 2026 13:15:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] refs: remove unused typedef
 'ref_transaction_commit_fn'
Message-ID: <aeityL_05KDRZF98@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-1-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-1-513e354f376b@gmail.com>

On Mon, Apr 20, 2026 at 12:11:59PM +0200, Karthik Nayak wrote:
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index d79e35fd26..2d963cc4f4 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -421,10 +421,6 @@ typedef int ref_transaction_abort_fn(struct ref_store *refs,
>  				     struct ref_transaction *transaction,
>  				     struct strbuf *err);
>  
> -typedef int ref_transaction_commit_fn(struct ref_store *refs,
> -				      struct ref_transaction *transaction,
> -				      struct strbuf *err);
> -
>  typedef int optimize_fn(struct ref_store *ref_store,
>  			struct refs_optimize_opts *opts);
>  

I'm in general not much of a fan of these typedefs -- there's not really
much of a point why we'd need them in the first place. We don't use them
as a type anywhere but in the struct definition for the ref backend. So
we could just as well move them in there, which would also ensure that
they cannot become stale in the first place.

Patrick
