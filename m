Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283772356D9
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975289; cv=none; b=hLmW9NYsEQURJsb6zfPJGEMBv8KXqHo7ei5PVyaY0Vx1ywdPi3/XpfLbl4AWjL+eB0AWKROqV5amCAOCULY3ByYfns4O+DIVQOUIdZUJo+3abaDe56Z++k5G+jqOhBIjZOpzVjOCxAeWN1hcTo0IQFm84K2r2lp6qpZ++XdvvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975289; c=relaxed/simple;
	bh=8trOnqIUuSLmeFX2Srnzv9a+1/OSNvvVRyzjt8OWwVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr9mffaWUsIcy9hDHSQEF6J33XLvBAbXGYuwCPErfmorPwSLnSuObfBOKlz7ZxiGqyxuAy9PTWrF9Vk3T2fnZ/Tzva+5P2vr84qxeOx3yoICIGfO9vutMTaGhYTqQhrS0Xky7tGS9c31Ilag7TheSICi0iJSsNB+YczoFLzsncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v+L171AT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqMDaDKA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v+L171AT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqMDaDKA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7415F1400A42;
	Tue,  8 Jul 2025 07:48:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 07:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751975286; x=1752061686; bh=j/F1RUtAWF
	kEm1sShAhvDhRm7kS8U86G/YoiIG1BRk8=; b=v+L171ATxPd6e9/xC/jMmTYlqb
	0mMLhJRlkIofCNefmfpWeMehqEb7kixEL84bRPPKzIgd1WdbMpHv/8unmh+FMJTD
	Fow2Pfx5PR9SIfCrKjZo0ViNdrvFl1MlGXP9Ct1QeuS0mWnqImgkoCt4Sy8pW4HK
	mklDH66ZmLM/y9YelySSGUgCdxgDWO9mLqXYPE3dbd3/UtOIewyWZvv5t0wYqmqC
	6e1SUZcN0zHegnsF/ZyBa57C00kknfXLHb9lZbLtqWaCZxRyJyRoxJjyDE/3RdfT
	Y9jQS4d7hCBpnfZutdOYkBr7UBtPALPkYebkkjpXWA9lMlPiykBOmtNOJA6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751975286; x=1752061686; bh=j/F1RUtAWFkEm1sShAhvDhRm7kS8U86G/Yo
	iIG1BRk8=; b=UqMDaDKAHr3lmiwTV+i68egHkEZ9h9SasYMkxLG2gp3rNGQ6Mha
	yKvNhx0Iofe73K1LelD57dV3WpwH4Mqxxhv/HQ/fRmdRgBUPdqowd0MJoZwiK7Df
	lle9twAxrsEYfwGYi+s8j7W8kGI6CwUk5f55XMoTEKKfcLJvc+snljlErtjGHdJp
	oCsAxEZyMpG4N2DBhi9EbaJaZespwrVdVbsvlphAixWgVguUpyJuvHnQuwsYzoZI
	3pq5R3ybz48p5C8KeaaJQj+SWcyTpAFUmS1JH+3EzSUUF/n8zjcNSuzoYBcjcOof
	FzTW6KvMfmpcdglxjcZXpLNy5tCXaG8v+6w==
X-ME-Sender: <xms:dgVtaCvOnRqnCsg2f17-IOa7bLz5Fsuh_UnBQhXESE4vB_gIZsnB3g>
    <xme:dgVtaHpgWKpLMMN1vdWOZF3z8ohO0R2IKUYODe6TIeYVUqUIQ_Kh0dgga8FoqGGe-
    cBGlEbbPrS0nRWwRQ>
X-ME-Received: <xmr:dgVtaPn4oNLqNDzAHbZfCCDHcUOPP0Iqt57p60IAghCH9zYeLDwHK-JfZT3miMlA-yql6XXPhcLY7Jr8BpK09r-rx50lwXu4BwraFfnX0DI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dgVtaLw1jKuHbGGZxjZT6Aa4KalgqpbfDqnLgkwXCu4BdDpLefa0Jw>
    <xmx:dgVtaHm04TFKE23fPmLic_d0EYAj-No-9JpoK6ZlvsWxI_uVKn_gow>
    <xmx:dgVtaEdAXy4plAJR19IQT-MEaGeEyh1JvTSajiRNu4ixt1pOTbjaXw>
    <xmx:dgVtaNoflNd9ArKoSgKrohlxTS9ikTBxl0zVZfQUHNdPfEiliAd7xg>
    <xmx:dgVtaK8FUpVwhoaDU_39KkBCBlhw_G55QKAC5-HHCoGFjsExD5-ANUHN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 07:48:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c852efe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 11:48:04 +0000 (UTC)
Date: Tue, 8 Jul 2025 13:48:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] docs/git-pack-refs: document heuristic used for packing
 loose refs
Message-ID: <aG0FcY_SVqe9pe4A@pks.im>
References: <20250708-b4-pks-pack-refs-document-files-heuristic-v1-1-e28d65a94573@pks.im>
 <CAOLa=ZSmY8ooXL1c-jE7tqjfMuz2o+wkWaV6W3_XXQFncv0JrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSmY8ooXL1c-jE7tqjfMuz2o+wkWaV6W3_XXQFncv0JrA@mail.gmail.com>

On Tue, Jul 08, 2025 at 04:43:42AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
> > index 652c5497715..42b90051e69 100644
> > --- a/Documentation/git-pack-refs.adoc
> > +++ b/Documentation/git-pack-refs.adoc
> > @@ -66,7 +66,10 @@ Pack refs as needed depending on the current state of the ref database. The
> >  behavior depends on the ref format used by the repository and may change in the
> >  future.
> >  +
> > -	- "files": No special handling for `--auto` has been implemented.
> > +	- "files": Loose references are packed into the `packed-refs` file
> > +	  based on the ratio of loose references to the size of the
> > +	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
> > +	  references need to exist before we repack.
> >  +
> 
> Nice. The explanation has sufficient information without going too much
> into detail. Perhaps a small nit would be s/ratio/logarithmic ratio/,
> but I'm happy with this as is.

I was very much on the fence on whether to add "logarithmic" in there or
not. I ultimately felt like it hinted too much at how exactly it works
without really giving enough information to fully understand it, so it
felt a bit useless to me to add "logarithmic".

I don't have a strong opinion though, and it doesn't seem like you feel
strongly about it, either. So for now I'll keep this as-is, but I'm
happy to change it if others also have a slight preference for adding
the word in.

Thanks!

Patrick
