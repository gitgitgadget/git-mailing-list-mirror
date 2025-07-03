Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D48151991
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 04:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751517815; cv=none; b=Jq/iULhH10zc9tACUkvtLHKUpkVhl3tnKGFZCTiwZoUPtQrKuCWpmm/oXfbVW/OH7f3VRcWrlpx6V5z4XQYROGs1RYZ9MJH4YmMLPUMiNRO9U4XFYCdzdlAVB8y7K2sjI7zhuBHHDGYo1nFvWCSEciIAcXJM/0MH+C8p2vAylIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751517815; c=relaxed/simple;
	bh=YLZlkV9h89mguu+Tb2Qt3ajzZxxFW5T24IAvrVwbWfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnAFEWFRlQXAXxeRlXou9KTCU8yaQc6GF9PboneX4QBiW3g2WoRskwX3OXQ3kNtZT8q18SrbF/fEP8tdalJ/6HtikxtbV3+X3EbultyavUx+UWDUHZ2piGhCE58mhG3xYAJU6x6lh8TXMPw/t4SFoW1rOib3NuMoDJj3BfgYhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YeWLfuu0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jqj1y0Mt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YeWLfuu0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqj1y0Mt"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C1747A019D;
	Thu,  3 Jul 2025 00:43:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 00:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751517810; x=1751604210; bh=u7mXcUlBMw
	9PZ03EptQDO23Uxdj9revzfqp9EaBztag=; b=YeWLfuu0RhbOK4bG+b4XpfRE8x
	QWUotnZ/zXwfA/h6MAZ5bLHv9XNbOFinrAQcRZWihTWlvYHUp8GLCdRnTyVMOBBT
	rLqtUv/0KlCWUJYPhBXMO43WJ22qBeupu+fXVODdVLZH6PFWV3lAOv7A9KpBH9qY
	KLEZdcncfUChE80MeCAUzqaYxVSn88RGqutPiSpTGz2jrOCz6cjWxu9O+U9I7ZW2
	4/OUogamQMg/Me53cFE/4UhHiWIiB6vuwCcLzw13YG2/RCGXEOtlhOTLgGj1lGN5
	qGXLMXqcb4+nP+/VQ2oAaF3orUQNr1tlmTpyGnnsvY1mtEGprnnbOBM423Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751517810; x=1751604210; bh=u7mXcUlBMw9PZ03EptQDO23Uxdj9revzfqp
	9EaBztag=; b=jqj1y0MtVwVF+wmfMKY60mbhNqWaO/N2lKWR/KAYLLF+hjHi+oC
	zJYXnxul/aFoosdr6NHCjZ1OAbdgpDQiKLReqkgmob9AXgcDSW2LII0SYR0quL/T
	ZXSdOF+FOxptV2KcA/YQ8IN62BStzk5vFrShjmfl8EDm5/CvhQg8yZPOOt6k0BbF
	8fR/h49dwKRR5jAlTeRlXf7uBcd8+oStX1s2VHdzcBk/plAH5pXUrYPf3e0apJRl
	eS98ks/YfwgT5bY+1FUPgx7+4iQYb8RCGBPqht0vaC/jRLcES5LKxCLf4hyEoBiA
	i9KoItkxEPEcPwJPQptVkIFr/iFioIUwHfg==
X-ME-Sender: <xms:cgpmaG-dKd9UT6GCstOpGI0p1ze14FpN_Xu6HO7GolzMfSwN-1gJSQ>
    <xme:cgpmaGvecxRC4sy30zlZNHav1MdBk9B0zMox9xbmjSlf1Fwk9QyD6XKwvFJlVTGH1
    0LQ6VadHSDKymQpkQ>
X-ME-Received: <xmr:cgpmaMAtLptR72S68eBmBfIUPVSwQQNc1MICaEWZs8NXv8UZBCyU2VTa9Pz7q0SQi5tzhttaCYqhlEg9IKPD6c-jXBnA7qac9SuZD8yGeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehrhigvnhhushesghhmrghilhdrtghomhdprhgtphhtthhopehjrgihrghthhgvvghr
    thhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cgpmaOdmp4E1FM0_Wthj-hJcMf6BKCT31_j9JdI_CEr4rJaIbWDbqA>
    <xmx:cgpmaLMe8gVzjbw7rK58SdM8df7oMFi6pHk0V7vniQoO8TNOG1aw3Q>
    <xmx:cgpmaImAlhcdFc4PH-DG0fdcQJEVpWvX8VIUBvCtaIwLIxTateKj0w>
    <xmx:cgpmaNtheQEYuuwFElrxTb0oKGW1ajrMo9mQBrVgOCn0RB7Q5noh9Q>
    <xmx:cgpmaMk35Q2IsM7jBMx0N2bBM-V9otuUnqrFMSQHi_G9cNX-QDBnfM8Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 00:43:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb1948f2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 04:43:26 +0000 (UTC)
Date: Thu, 3 Jul 2025 06:43:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com
Subject: Re: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
Message-ID: <aGYKYmKwJr7nZrjW@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
 <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
 <xmqqbjq2ed9e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjq2ed9e.fsf@gitster.g>

On Wed, Jul 02, 2025 at 10:03:25AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index f93bd6a24a5..3ab0f11fbfd 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2541,6 +2541,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
> >  			repo_fmt->ref_storage_format = ref_format;
> >  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
> >  		repo_fmt->ref_storage_format = cfg.ref_format;
> > +	} else {
> > +#ifdef WITH_BREAKING_CHANGES
> > +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_REFTABLE;
> > +#else
> > +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_FILES;
> > +#endif
> >  	}
> >  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
> >  }
> 
> That's obvious one.  I think the approach taken by brian's SHA-256
> topic would have introduced REF_STORAGE_FORMAT_DEFAULT and did the
> build-time switching between the two in a single conditional
> definition
> 
>         #ifndef WITH_BREAKING_CHANGES /* 3.0 */
>         # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
>         #else
>         # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
>         #endif
> 
> somewhere in a header file.  Either way would work, but I wonder if
> these breaking-changes definitions are collected together into a
> single header file (say <bc.h>), it may make the transition at 3.0
> version boundary simpler and less error-prone.  We can just discard
> selected conditionals into unconditional definition more easily.
> For example if we moved the default flip between SHA-1 and SHA-256,
> i.e.
> 
> 	#ifndef WITH_BREAKING_CHANGES /* 3.0 */
> 	# define GIT_HASH_DEFAULT GIT_HASH_SHA1
> 	#else
> 	# define GIT_HASH_DEFAULT GIT_HASH_SHA256
> 	#endif
> 
> out of hash.h and have it next to the above REF_STORAGE_FORMAT_DEFAULT
> definition, and then in a subsystem specific header file, after
> including <bc.h>, can say
> 
> 	=== In hash.h ===
> 	#include <bc.h>
> 	#ifndef GIT_HASH_DEFAULT
> 	# define GIT_HASH_DEFAULT GIT_HASH_SHA256
> 	#endif
> 
> 	=== In refs.h ===
> 	#include <bc.h>
> 	#ifndef REF_STORAGE_FORMAT_DEFAULT
>         # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
> 	#endif
> 
> If some reason making reftable backend the default when unspecified
> turns out to be a bit premature at 3.0 boundary while the world is
> ready for SHA-256 by default for new repositories, then we can tweak
> that single header file like so:
> 
>         -#ifndef WITH_BREAKING_CHANGES /* 3.0 */
>         +#ifndef WITH_BREAKING_CHANGES /* 4.0? */
>          # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
>          #else
>          # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
>          #endif
> 
> 	-#ifndef WITH_BREAKING_CHANGES
> 	-# define GIT_HASH_DEFAULT GIT_HASH_SHA1
> 	-#else
> 	-# define GIT_HASH_DEFAULT GIT_HASH_SHA256
> 	-#endif
> 
> and optionally change the "if default is not set, use 256" in <hash.h>
> to "unconditionally use 256 as the default", but forgetting to do so
> would not break anything, which makes the process less error prone.
> 
> By doing something like this, we'll have a single place <bc.h> to
> see what are being planned, and we can "git log that-header-file" to
> see how our thinking has evolved over time.  Hopefully w
