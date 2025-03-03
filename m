Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A71E98FF
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998456; cv=none; b=t3kTyHkEPDrPSEdP0Ag6RGp6SKutqXXtF4Xu2Eu4aLrcnZpld3tQ1SjVwSdjg1wM0R8fFdG4GjU8bz8RdGEP/uHXYwkUq2ENGqL0UsiFz1FDe95U13xgFhuZYkNvYmsCf/2hQvMZaGGcAsiDher8Q0SSTus5AUpgSOQScJRfTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998456; c=relaxed/simple;
	bh=uAE+ksvXazhctJQj1hYeW5Sfc6b2HTFn5pHPl4C74XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URwwQllAbnLX4QNJMMHFlocQCiN6sG8abPBpcHSPYdNKAXgo7aMpK3B4Pane5ppPI2Obvx26me3H7DuaOy68PDLld0Quf3MgwxFrCFjre2N7X6vFv1H/sWmreHWWj7P3l/eEO2cUHc/52lJyGTwAma7cFEXmD7XjY5Y2U+4K23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EPKp/Hs8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=09cjy70f; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EPKp/Hs8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="09cjy70f"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4013625401C9;
	Mon,  3 Mar 2025 05:40:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 05:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740998453; x=1741084853; bh=caFgokW054
	6Tl+iFv7ubzEko0+fDNUbALJV1oC6f7ss=; b=EPKp/Hs84qiDZsfm55EnUCjoHk
	t8DWdLjgVN3CnYeVH8rp0w2NQw4QdUXvSILyNXQKr+Z54L/bXQ4ngXyxkPD6atSa
	FzttrNqjfsbqUbINyolMsbXF9uZ9ucu9i1Arh2stwoN3qKT4y7rhtu9eq3lnkbMC
	DFU9vQ7d+jVVNQcpLdLL3oepR+NcYLnPitEwqF4RQxQ1UW/xnoB2Sxf7xxpSY1SG
	qhvkYdcovRdJASP0vnNFJmFAM+vK7tHFXsTgw+dX0rZPASJU6OkA7voFidP7SNbB
	NeL5zwBxPor9Crq7ZkhXNDZaLbxD7eUHVCUvdvs1ZS5JeSo9nVz+Vp9tTW2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740998453; x=1741084853; bh=caFgokW0546Tl+iFv7ubzEko0+fDNUbALJV
	1oC6f7ss=; b=09cjy70fZFl/h+GALxoxhPoAo/g1churQGosb4f2CJ51ebOyLcx
	gK+X6/TV5ltrqSFRzpSAsY3kpi761pQVDv8QMmCJTJO8T52iY3Oop8cxsKPtQHc1
	DbnW18N9rH1T1JGvNS7fIlilAvywYpDFcKhEQunbfxwqr+qCG3BITbXlDnQisbqM
	oRfE2hiSE9Dz5r+TVsVRMFrKj5psQEFBke3LRWXpap/OQ0264ipHz/gRxql0ve6p
	XiIwvm003FNOp7kN7nN8rB2ab81ST65RgIG3NKOzctI+dUIugmqV/6kXstV3xj3c
	BD3870y/XEcBGks6b2rkdoRPnXSnDBJlDgQ==
X-ME-Sender: <xms:NIfFZ_mgd6AnEucHxmQv7x1u228DKtxBwyM3kQ7IppE4C8gw__9pDw>
    <xme:NIfFZy1cEWk5zT0vkGJsh1uaatRbvJdVuiJgQSaFfrBSTmVdr93BV7tVnCyLfdKMp
    xES7QhchPBN6RqQZA>
X-ME-Received: <xmr:NIfFZ1oFEUx27wmhmb2NtDwDUd3L5ljvW7eu5kYGct_svtUCbI0KPhu53BWIO3dUH8Cbmo_9r49pPhsJxRhli1FYTTGdnrceZW9w1rgNok0tKKCS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:NIfFZ3mP6e3fIOEnhIxVQAqumJGyCeYOYA7u1ho_qlGo2YQVSb4PeA>
    <xmx:NIfFZ92QKJHcaJHBj8_eWysLXANuQe0owsCAU8ZwK2Z2S_s9MqKmAQ>
    <xmx:NIfFZ2vYDvPIxQlnn4s26Y4-L_BnvnWUBPunhGT2_XV-epZNjjgYMg>
    <xmx:NIfFZxXZA5OleF72gUGBHbob5yydI7BlOMpADXwZRYOjrb9-2GcD8g>
    <xmx:NYfFZ2zAcy_bCTUXUC6rGKsJwSvLGsO5C2VMgiODfJqLgNoRU6_1W6kP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:40:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e018b933 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:40:50 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:40:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/9] builtin/cat-file: wire up an option to filter objects
Message-ID: <Z8WHMV_5rxKjlkhE@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
 <874j0graug.fsf@iotcl.com>
 <Z8GVKLee75GDG2S4@pks.im>
 <xmqqikou2ccn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikou2ccn.fsf@gitster.g>

On Fri, Feb 28, 2025 at 09:44:24AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > Note that we don't use the same `--filter=` name fo the option as we use
> >> > in git-rev-list(1). We already have `--filters`, and having both
> >> > `--filter=` and `--filters` would be quite confusing. Instead, the new
> >> > option is called `--objects-filter`.
> >> 
> >> I'm not sure I agree. I would rather have consistency in various
> >> commands. Because `--filters` doesn't accept an argument, so I would say
> >> having both `--filters` and `--filter=` is fine. I see in various places
> >> we already use `OPT_PARSE_LIST_OBJECTS_FILTER` which defines the option
> >> as `--filter=`, so it's pretty standard for several commands. I'd
> >> prefer git-cat-file(1) to follow that as well. But that's my 2 cents.
> >
> > I'll wait for a third party to chime in as a tie breaker here :) I'm not
> > feeling overly strong about it, but still think that it's just too easy
> > to get wrong when those options are so extremely similarly named.
> 
> $ git grep '^[^a-z]*--filter' Documentation/
> Documentation/config/gc.adoc:	`--filter=<filter-spec>` option of linkgit:git-repack[1].
> Documentation/git-cat-file.adoc:--filters::
> Documentation/git-cat-file.adoc:	`--filters`.
> Documentation/git-clone.adoc:	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
> Documentation/git-clone.adoc:`--filter=<filter-spec>`::
> Documentation/git-clone.adoc:	`--filter=blob:limit=<size>` will filter out all blobs of size
> Documentation/git-pack-objects.adoc:--filter=<filter-spec>::
> Documentation/git-repack.adoc:--filter=<filter-spec>::
> Documentation/git-repack.adoc:--filter-to=<dir>::
> Documentation/rev-list-options.adoc:--filter=<filter-spec>::
> Documentation/rev-list-options.adoc:--filter-provided-objects::
> Documentation/rev-list-options.adoc:--filter-print-omitted::
> 
> The above does makes it look that whoever called their invention
> "--filters" when they added it to "cat-file" wasn't paying attention
> to make things consistent, but that is not the case.  The word
> "filter" in the context of existing feature set of "cat-file" has
> ALWAYS refered to the act of applying the "smudge" filter chain to
> externalize an internal "clean" blob object contents for the working
> tree representation.  We should thank that somebody for not using
> and squatting on a shorter and sweeter "--filter" ;-)
> 
> "cat-file" should call the feature "--filter=<filter-spec>" like
> everybody else does, or the feature should not be added to
> "cat-file" at all.  Unless we are willing to rename "--filter="
> options for _all_ existing commands to "--object-filter=", that is.
> 
> In retrospect, such a longer and more explicit name may have been
> nicer.  But given that all users of the "--filter=<filter-spec>" are
> about object transfer, it is understandable that we didn't invoke
> deliberate redundancy when naming the option.  Historically,
> "cat-file" has always been "give me the contents of the object I
> name", and never about "I may ask about many objects but do not
> answer requests for objects chosen by these criteria", so it also is
> understandable that we didn't redundantly say "--contents-filter",
> too.
> 
> Am I third-party enough?

Yup :) I'll adapt then, thanks for chiming in!

Patrick
