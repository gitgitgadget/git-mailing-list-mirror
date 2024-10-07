Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46B1531CC
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284323; cv=none; b=h9OvYMELznf31WYsgrqVuMFSMYuJF254rIMQ32Qkrsml7Jh0IWB8Hiz1MurjHPRxMQdY4HEvlTJYeOpskO/5fCL9jDrxQpP9NeFIcUxRTPrbL3orQedYXUIP67KoDhm8L3SYGHGTrE5nph5cdwkGcqZp0tEtZy2idOYFvLLcsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284323; c=relaxed/simple;
	bh=ObsDba5y9fxQKCIVyIir9+xI85qrILyiW2b7Au0JNTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2z810hxcarpeJriAwmQ19FnnvtxU61ejfKwDF66bnl6SmzcT7qJ4jQT1y5m6q+fG1mRMBsWjsiw2R2Y0AWlZSSrHzHE0ZSPzE+ISuEaoNLKCH+sqc1QMF1DrVdBzfVShxCey4xDfHnyUHd5L6M+3vSP3y5TvBeVnf3xZBJvyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iG0KUAmS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bR3z1j2u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iG0KUAmS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bR3z1j2u"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D263425400CB;
	Mon,  7 Oct 2024 02:58:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 02:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284320; x=1728370720; bh=CYfe8aOYJs
	4iWzgxtI2P6L8y9HedptgLMPoJ2dvNaKc=; b=iG0KUAmSlowLr0Pl1JsmlWxIJi
	zuTvwnyfGnt3Fn6MxGj9xyaEhXMtNYwbF2btteJeVUhI87a3l/Z2sgibbHW5vt/y
	mNg+3pK3sbu6vljoEQ2zn7/MoiUZtErOq+4tfve3GnZRQXClBlj0emcpHeBm9Mdk
	ksNvmZQoRcLVR932Q/KGzn7DpsBilyxb6tHYgORSYEYzP51i450lYqR8/Ffk0uOX
	6XlTiekD4zWQv/0Ir0G3grY5o5ZU7lsj3zEAVGp5aHvDRNKdfK0bbrnncBUzglUD
	utQIwSJVywXnP6lrxtzK8cMgtlZFKUPJnzRndzFZ2U2VsAAJs4TqFy1vvNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284320; x=1728370720; bh=CYfe8aOYJs4iWzgxtI2P6L8y9Hed
	ptgLMPoJ2dvNaKc=; b=bR3z1j2uRnaDlZtGqvG1w58J/6Yeduqh5Hd6zqS0Ij2H
	6wh269QMR/qqfSfUv81UxdcUjupW6jJN3F5wQhqTN4EJzCm53U6oIJdIXR7XDlC2
	n1zk2wTDg4ceRXpA21IrTuwgMyfO5MKVigoyzZNxK3Hto4mejGvvfsWI1p0mOSIw
	+JxiVQliU5ImKSkIkwhSx8IPvUkQmnnSrGVfYIKZ8I5VPPVnz6Yv4F7nyjqmVhwd
	jG6PZvbs6sBFSpGpr8sO8ZEUNI56egAzz3oQijbVuYnVJ5sSNin+wM0b4skaCb72
	tlwruNVllsl2ocv67zX5GTatJFp2JQ9BBpeCNF7zaQ==
X-ME-Sender: <xms:oIYDZ_vOdfZjQ1X3cEIHNYzIXsahnVplp93_FRY7kKXBgSddkspMtw>
    <xme:oIYDZwe_eImktUaHL2NW_IG7yINtU001JM03FFG8psrr5PkK5nJeBQpasj7BLxdfK
    SK5cj-APoXtk8wPlQ>
X-ME-Received: <xmr:oIYDZyz43ScqoAuFVa1ppob0ofAncADgtsfMdamHOCGdgBd7qbgXLdALxLf_zDJqv1eZO5iX4Ge4zM3bRufPMD1fHqp2KOGyzIALgnDVIMhDBT5s6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:oIYDZ-Oe7ZtMgML7nzHdoral_i8xQbTnRDuO8StYA5qci9rosc10Qw>
    <xmx:oIYDZ_9cdHAEqXlqZzzUNyVWIDafOTHos3-TQIcZ5_6v98mp3kvd-w>
    <xmx:oIYDZ-VOE8vchgEU0w_wt_m4ey8yDyinhv2GPDXXp-BNnln2EMHtjw>
    <xmx:oIYDZwfn05MXYUq3c1nA0GFTAvHoLXzH3VsDoKjEqC-R2UbhdTv4-g>
    <xmx:oIYDZ7avwrwWTy4UirWACAyNy0O3Ru32Tmaggfd2J3RKlBibd5GflAXO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2c07cc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:41 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/9] ref: add more strict checks for regular refs
Message-ID: <ZwOGnQSqmwALK-9z@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-sBX-0AFsuFDC@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-sBX-0AFsuFDC@ArchLinux>

On Sun, Sep 29, 2024 at 03:16:00PM +0800, shejialuo wrote:
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index 22c385ea22..e310b5bce9 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -179,6 +179,14 @@
>  `unknownType`::
>  	(ERROR) Found an unknown object type.
>  
> +`unofficialFormattedRef`::
> +	(INFO) The content of a loose ref file is not in the official
> +	format such as not having a LF at the end or having trailing
> +	garbage. As valid implementations of Git never created such a
> +	loose ref file, it may become an error in the future. Report
> +	to the git@vger.kernel.org mailing list if you see this error,
> +	as we need to know what tools created such a file.
> +

I find "unofficial" to be a tad weird. Do we rather want to say
something like "badRefTrailingGarbage"?

> @@ -3541,6 +3546,21 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  		goto cleanup;
>  	}
>  
> +	if (!(type & REF_ISSYMREF)) {
> +		if (!*trailing) {
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
> +					      "misses LF at the end");
> +			goto cleanup;
> +		}
> +		if (*trailing != '\n' || *(trailing + 1)) {
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
> +					      "has trailing garbage: '%s'", trailing);
> +			goto cleanup;
> +		}
> +	}
> +

I think we should discern these two error cases and provide different
message IDs.

Patrick
