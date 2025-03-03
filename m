Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E31F2BA4
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997847; cv=none; b=efPxg3407ij6EoGgKZycrBV6z1TQ1Et/qvU2xC2LwAycwuupWHPfB//V3Ma3ZFIPs349xbfGAagVx/VVraTe2VzWPb6HVcZe51JEm+hiqJH5wJ8o0sLfBinpiaakh+tcHDlGsEEJo8eGe5+gTFruK97s6JDSPDAZUB292TSUTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997847; c=relaxed/simple;
	bh=qurzAFB1FmHRefPeOuX+dc48pvku8mSD1trcN0JqlSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drUFpiyjDR61I1EOK03k5q/yjuS6qVyrp2InrpYN/2YnTW4FbfonSDubLcmz1j9rg6WCe5aE9BYlDrQHuPNDtvJsK437PZQoJHmrBaspsbXAPSyO1wVasPjCLF6lCv19Ui+z1ZPr1U7XPUCsNGSd3TbgHStNr/O+nK89CHSP0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UHJWHQOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHYnpq0v; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UHJWHQOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHYnpq0v"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A032A25401D8;
	Mon,  3 Mar 2025 05:30:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 05:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740997844; x=1741084244; bh=sWfr6fVZnO
	rGNvBTIkzg8Vp6qoDJMaVtofLxZkKNTI0=; b=UHJWHQOD08MFGQzXQ0mncHbvpj
	fIAb3yntEHDCgvgHuxl8FoCn1sekC2C/APtziAfsDt+5AVUDsqG+cgi0+RbI7DmD
	C8AVxS6feRNv82iRrZ+ETaQnJOFNhBPAR0Cv2HCLlAmRUuwtpGtj0yi7fV9MM2Y2
	ZZsvoi759wY9lI8yJ0Lw+NC75xMq9EuA4fxsqNcZcoSJJmDyELc5ZhIShmpV/KAx
	TJ9Bm80w1bzM++jak7QbNyhYm825D0Z53hE8e9zHHdOE8cFE1lod5LSsw1Cqzhvn
	165fVld+0Hgq/JP+Z8WyxO3M9tDYtDsLtvfwRwApevB3Eh7SbMq1U3cO4X7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740997844; x=1741084244; bh=sWfr6fVZnOrGNvBTIkzg8Vp6qoDJMaVtofL
	xZkKNTI0=; b=kHYnpq0vtO9U4iyzrfbTpqFQsUDmyuM345uJdSAHr0M/ijclKlF
	B6WximAfNPbO78xil9gkhQHEePrlvFHtDU9X/JGMfImnN+RcQXMMwyPQIOw0Pn1a
	wd7ys5otanijHbgrajM0UzuO1bFKocmbVxt+wbVtw3vIzPc9wjOAk8TRLk2j3gcG
	4iTsS0k0gQ83fju7fg1bD8q8sNnRYUSZLDejqtDVspuX/RZiJg82xVZBbT7e/29X
	CMpQwtgsMY3G/SKr/otiTcyckOsMPHtdoL7z+3FSJoL1k5DcpycblFLtT4rOY8WO
	3Bzu48jQn+qPxiC7n0XowGGGhHbNWFrdxcA==
X-ME-Sender: <xms:1ITFZ_XE9nll76UT7QKNml7AFf5Dubt3T99v2xgJzK9tgnpiJuF0GQ>
    <xme:1ITFZ3kW2PL07ZvuqmwkDc9aR6a7bUfYEkdry9nrMorkJGhp4wJ5-aKoyQZ1hGrHy
    RquFQZIlG317Fs2-g>
X-ME-Received: <xmr:1ITFZ7afHieaHKGQnFrsGbPFrShc8THohUj1GvOTrw7YLOBumU-QXeGhLtwiCnkYf7GfWMsJSc8KGW_-6458exWjt2jAGZkP5RdaCLW9SlzXLZZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfegleeuue
    fhhfejkeeuhfefveelffevjeeffffhkeejieffvddvvdfhgfeutdelnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhithefrdhishenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1ITFZ6XwMoDbqYy3eN64-aRtmW649w6rPi1XXcmLMqw2cjMRlYeGkw>
    <xmx:1ITFZ5l4RITOSPpt5_tiEA8AGrItXU8tic8DWp6JB6sshbD48AbGiw>
    <xmx:1ITFZ3drczEXokw7vwVcAmWK0NDL7DULNlVrI5-8kY2YuV8_pGMh_w>
    <xmx:1ITFZzE9A3fVBPTiBoOm4kWGawAtNxgMikRwwTsG5Ir4J-dvduGXgw>
    <xmx:1ITFZ_goe2ZZsL-K-p7XblqUTnGev-52j3p5ckY77om6_45Fkcn5oy-R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:30:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc2b8218 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:30:42 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:30:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH v2] BreakingChanges: early adopter option
Message-ID: <Z8WE0SK5QS4aVyYr@pks.im>
References: <xmqq7cb77810.fsf@gitster.g>
 <xmqq1q0mcnt8.fsf@gitster.g>
 <Zw9ppbrFqVN5S50J@pks.im>
 <ZxA5OWL1AuQxA/NC@nand.local>
 <xmqqv7su2d3e.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7su2d3e.fsf_-_@gitster.g>

On Fri, Feb 28, 2025 at 09:28:21AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> Subject: BreakingChanges: clarify the procedure
> 
> The point behind a compile-time switch is to ensure that we have a
> mechanism to hide myriad of backward incompatible changes that may
> be prepared and accumulated over time, yet make them available for
> testing any time during the development toward the big version
> boundary.  Add a few words to stress that point.
> 
> Since the document was first written, we have added the CI job that
> the document anticipated us to have.  Rephrase to state the current
> status.
> 
> The discussion in [*1*] made us abandon the "feature.git3" based
> runtime switching of behaviour and instead adopt the compile-time
> switching mechanism, but a stray sentence about runtime switching
> still remained in the final text by mistake.  Remove it.
> 
> [Reference]
> 
>  *1* https://lore.kernel.org/git/xmqqldzel6ug.fsf@gitster.g/
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/BreakingChanges.adoc | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git c/Documentation/BreakingChanges.adoc w/Documentation/BreakingChanges.adoc
> index 042709a461..bdfad29d8a 100644
> --- c/Documentation/BreakingChanges.adoc
> +++ w/Documentation/BreakingChanges.adoc
> @@ -66,22 +66,21 @@ changes are made at a certain version boundary, and recording these
>  decisions in this document, are necessary but not sufficient.
>  Because such changes are expected to be numerous, and the design and
>  implementation of them are expected to span over time, they have to
> -be deployable trivially at such a version boundary.
> +be deployable trivially at such a version boundary, prepared over long
> +time.
>  
>  The breaking changes MUST be guarded with the a compile-time switch,
>  WITH_BREAKING_CHANGES, to help this process.  When built with it,
>  the resulting Git binary together with its documentation would
>  behave as if these breaking changes slated for the next big version
> -boundary are already in effect.  We may also want to have a CI job
> -or two to exercise the work-in-progress version of Git with these
> -breaking changes.
> +boundary are already in effect.  We also have a CI job to exercise
> +the work-in-progress version of Git with these breaking changes.
>  
>  
>  == Git 3.0
>  
>  The following subsections document upcoming breaking changes for Git 3.0. There
> -is no planned release date for this breaking version yet.  The early
> -adopter configuration used for changes for this release is `feature.git3`.
> +is no planned release date for this breaking version yet.
>  
>  Proposed changes and removals only include items which are "ready" to be done.
>  In other words, this is not supposed to be a wishlist of features that should

Thanks, the change look sensible to me.

Patrick
