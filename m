Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604710F1
	for <git@vger.kernel.org>; Fri, 30 May 2025 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748583362; cv=none; b=ny4eK17+guUXCTeNS5sQpETsTev+8a6tdUMLAQY803LmNNA2z/cesgd9Qzhf4fZxZkPtkx3I9El7ygvqRzr6bmbtKwFAfLicujtdcb3aPWeNrjMfzzXnP2VcI+U087HuC2ZAPLLCMwDd5PZtjU84j8DsLH2+BUrrKa75NDLVrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748583362; c=relaxed/simple;
	bh=1YNRZP7mUIvMAwjJfvAM3UAhBAuk9kOZB8A+O5bziQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP3M7lPNnkKVP92gm9u3XYQvX3AiVmFcG4Uaq6YOyadAStsH+YS8YCl6Rz6Zac4AN8uH7AU2szFRNAYLqXoZHatVmAoHs+Oks3e+ibfFdZdBpgu2gxPR0usVawS35ypEU+hUiOFuMzbGVxnrALWAxRBfHsn+9rcXnTm37Vn5ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ppOooNaR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Th+16Gmw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ppOooNaR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Th+16Gmw"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12AC2254014A;
	Fri, 30 May 2025 01:35:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 30 May 2025 01:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748583357;
	 x=1748669757; bh=VLdri7mJqQrF0QmHPO91A66WzgPIIFJmUl7EmVKK7pk=; b=
	ppOooNaRLhRvRtPXhlNefWcqrEFgFluBeNiAHlf/5CeAcQnrlsrCwu7TSICylwF+
	rRi5hZxoCFThPj14y9CG6KVvNxII8PLkKbGsBglehY09n4o/jzT+2VUKBXm0ECwT
	ybb437Efo+BZ9SSNMGMeDYOCFsbS9NAzXZ+In0szGGjXuvxnNoBHC8fQbr+HpHr5
	i/g76DCEZUdUOREdQs5L+YhhN/OUsoMquLdvojCiO647660L95HjBrlcVxEOCi/j
	V506HLFo2e0ToJaI2N7Mk0jdojlkqyQx3kBNi3KftLa030CKDlzoAXHwZZaJcV0h
	mshGABuGZTS2e3/dwjnumg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748583357; x=
	1748669757; bh=VLdri7mJqQrF0QmHPO91A66WzgPIIFJmUl7EmVKK7pk=; b=T
	h+16Gmw1BBvruORToY6msbMOcrayXYLe2IZsIa4nDn26P1UbpPGPBnltz7sqnzKu
	+SvqJTZieCiEd/k+f18IR8Og8Pq6hwZe9EnOEUqvFOwihA2yVWrZPUap4edmw/80
	pfqrw+okDCKzYNrkr0ZfcNxC6EoLDJSLE+pSi80digkZbqsA6rJGegpTayXu8V52
	LTU3Qj86Qz/O7886IqhuNIXBEIKI7z0JxSaTt19FwDYzInreR2hKPyHiwR60fvFS
	VKecu2KFqiUQaPwsoVdGm2oSmRTGvScGwmktAuoM0WPfStQ3Hdc1xs/M8Y/OdP5F
	Oqf+11/qMN0TBIVXjnGfA==
X-ME-Sender: <xms:vUM5aHqioGunalCqSQQMTnVBvXDgS-vscDuMvsI4088endGlGSgziA>
    <xme:vUM5aBrmzAFno8l_e3I6vr_E8jeIUCUt-qzcyZE8aF3sI_VV167lU_bLmzXpJzHQn
    BVof9RUWej21QGLFg>
X-ME-Received: <xmr:vUM5aEOtUX5GMMqWh6Xs9FLLLCvmRjKIpOYP72nLLLt6AG3Z4L8mmanFLOTcEMORQMSnx57QnCselhyjFT2sOoTEWvS9KRklcx1k5dp_IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeduleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:vUM5aK5jGEMCM_aOpynidWPp5cqonpIvFVVsa8plZe3FRWmFFHcYJQ>
    <xmx:vUM5aG6JnH9apArtvfPUcTNCCVVDeyFHPy0vle60F1z0SK-eCKDR3g>
    <xmx:vUM5aCj0bY_hpqrAU2zKm7bxX7qXvt0_NBBf-OhZu0zOILtVQ97f2A>
    <xmx:vUM5aI52qhJEyNPu9J4Xd6M_1rHngFUbF1gs3Jetbx8SPevLHvb6EQ>
    <xmx:vUM5aEP_oVJNJDPhLP67ox3C-2BKKW2ww5EjWoaaMtY9BzQ9Cjn9fU7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 01:35:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bca48000 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 05:35:55 +0000 (UTC)
Date: Fri, 30 May 2025 07:35:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
Message-ID: <aDlDtbUcX5NA8wCK@pks.im>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
 <20250529101136.16219-1-carenas@gmail.com>
 <xmqqtt53l7cl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtt53l7cl.fsf@gitster.g>

On Thu, May 29, 2025 at 09:17:14AM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > Since f93b2a0424 (reftable/basics: introduce `REFTABLE_UNUSED`
> > annotation, 2025-02-18), the reftable library was migrated to
> > use an internal version of `UNUSED`, which unconditionally sets
> > a GNU __attribute__ to avoid warnings function parameters that
> > are not being used.
> >
> > Make the definition conditional to prevent breaking the build
> > with non GNU compilers.
> 
> Quite a reasonable reasoning.
> 
> > Reported-by: "Randall S. Becker" <rsbecker@nexbridge.com>
> > Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> > ---
> >  reftable/basics.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/reftable/basics.h b/reftable/basics.h
> > index d8888c1262..7d22f96261 100644
> > --- a/reftable/basics.h
> > +++ b/reftable/basics.h
> > @@ -16,7 +16,11 @@
> >  #include "system.h"
> >  #include "reftable-basics.h"
> >  
> > +#ifdef __GNUC__
> >  #define REFTABLE_UNUSED __attribute__((__unused__))
> > +#else
> > +#define REFTABLE_UNUSED
> > +#endif
> 
> Corresponding definition we use in the main part of the project
> defined in compat/posix.h looks like this:
> 
>         #if GIT_GNUC_PREREQ(4, 5)
>         #define UNUSED __attribute__((unused)) \
>                 __attribute__((deprecated ("parameter declared as UNUSED")))
>         #elif defined(__GNUC__)
>         #define UNUSED __attribute__((unused)) \
>                 __attribute__((deprecated))
>         #else
>         #define UNUSED
>         #endif
> 
> GCC 4.5 or older may no longer be relevant, in which case yours may
> be good enough.

What I don't understand though: we have a `MAYBE_UNUSED` macro that has
the exact same definition in "git-compat-util.h". Why does the macro
cause issues in the reftable library, but not over there?

Patrick
