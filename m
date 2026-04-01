Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663835BDA8
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045651; cv=none; b=o22UunSHEnR26nzDIzvYeJR1OIIUcbcoMQumRbiCsXRb1+x80NWIgiHvVZ1irn7VLkjHN6kHKisaTRWcLTgyR1WyO99bxvbfxbjhBmhyYqShuFopdgSPOt0TU+wqgkBYlM32zIXW7blqmEepcQjB1tIY4dnjNZ0u6YXZ5vSjny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045651; c=relaxed/simple;
	bh=yfQDhnI7XsCGSzs+SiQ0cpheuknPwr6RiuUuHq2U8Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOHOrBukU+mDUakT9ilGWFeX5rz5vaIen6/AB/48ko+IzpgV1INzKyz5ecsb1ZLyerupKaA3yb90dy4suDRMoyKjm6mshK/GVeTCBwz5zBmWhTzr3bttjROQcuChwlKtxcdhRUTeH0DHNwphXUBAWtlUExsJsHrIUX6RxPYuhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GcTgOna+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u+G1brZt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GcTgOna+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+G1brZt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D5181400274;
	Wed,  1 Apr 2026 08:14:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 01 Apr 2026 08:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775045649; x=1775132049; bh=wHax6hHuSn
	u1LfC/aombZIdLur1c/kTTdgS5d5uXo94=; b=GcTgOna+XHcxjMPXtICSEI7Cti
	4NEULggoIhFFp57hYnz/dK/mMO7u2UtgchcZ0/7T+NBUwrDNljweY6m7VeeWBEm3
	o5Yg+osF+v4CG82SZ5Mo+taFB08oPapK+DBWr69n/Nbon4IHq4bgSLqJZLwbg9fF
	0IbrxWNgiJybouNJrZexMzldIH6BMgKC3X3oexxcOpK9rXnAAUi7Ltu4McnCezKQ
	jtPTtTP6R+9kpfP7/9Tq3W7M84sFhg27emjwRxHDP+Ocwhri/YY/Rib2H2W6r/Y9
	zr4Uqm/Ok+zaouI70/pvSreXWt9zldYqRj3R1ApXIgjGArMUM6y829e2MmoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775045649; x=1775132049; bh=wHax6hHuSnu1LfC/aombZIdLur1c/kTTdgS
	5d5uXo94=; b=u+G1brZtgt0oN+7NlSd44ZakOCiC+umcbznq/z1lt/oMZ3ZQuHV
	YlSWPduuuGSLHjQGGIRrv3LyHlXBUb9sHjBAxzLbJkersPIc5KDIwen2UPi2j+MN
	MRBMHOAiC5QPk5sef5IuerBj26e/ic2ZXMqU0Lf+p0WZ1BODyrj9zz10lm4CPNnC
	TLiFK+xZi6wGSTxlmoLLYzpWK3Y7HGJO4eVoC1ga0Jkk41BjZGXkbRCXG0aMjEAH
	gjEPxb2iHxBh4SuLHZL4Al0w34+acM2/m9ndSRdK484OY0VzIJrzj51UU7ceOSqk
	IjuMcOl/r9fIXursNZ5Q+tQzPEtLhLJryww==
X-ME-Sender: <xms:EQzNadNBgSRdt-WqbyXm2rgqH9KfD406g2i5r7BvQe9bHklLgSscBQ>
    <xme:EQzNaV84RC3NkG8E35Jo7XO8UecfTdNLHei0rJVsSyFRulEAt79DVMKcxrfhDpKtx
    QAjC2OQHVWF-5ApREXIaT6WPveZLWXC4bSyiLlELN_F812AKtu4yQ>
X-ME-Received: <xmr:EQzNaZ5Qjh6tj_ZORKvHBijRo-ikOh6OlxvjcvXgxx_iRqA5pCqP7FJEE8KNCdkzW3M15-QVi8c1awa4VIvCMPFABlQRMYiOXCZrzXk29W8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EQzNaU2QiFxxh6ulWXKeP7URfSEbswbyIrM2QWLgcE_YzlLquK5-TQ>
    <xmx:EQzNaYAcjc5gmHHSgLRnsxad1iPo2MnCVtDC3UwOklQUGf1sADFQgQ>
    <xmx:EQzNae0NSJ0XDFJZYeZmF613sijmwougztpeHNkmNXH9LV69cjzUwQ>
    <xmx:EQzNaauOQeyaCyUe1KaKxkZa_oyvDk9YWhBFRINTuAxgwKSfujfZBw>
    <xmx:EQzNaYm18pK0-r8VKUQjqzwJWdrmTWFlmhRfrMsIolP380ZAxFzJPxay>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 08:14:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b80af6a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 12:14:08 +0000 (UTC)
Date: Wed, 1 Apr 2026 14:14:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] reftable: introduce "reftable-system.h" header
Message-ID: <ac0MDTQR484_yxuv@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-6-46bfae55c68c@pks.im>
 <xmqqwlyrzwh0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlyrzwh0.fsf@gitster.g>

On Tue, Mar 31, 2026 at 11:26:35AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We're including a couple of standard headers like <stdint.h> in a bunch
> > of locations, which makes it hard for a project to plug in their own
> > logic for making required functionality available. For us this is for
> > example via "compat/posix.h", which already includes all of the system
> > headers relevant to us.
> 
> Hmmm.  This is interesting.
> 
> > diff --git a/reftable/reftable-system.h b/reftable/reftable-system.h
> > new file mode 100644
> > index 0000000000..f90c415182
> > --- /dev/null
> > +++ b/reftable/reftable-system.h
> > @@ -0,0 +1,7 @@
> > +#ifndef REFTABLE_SYSTEM_H
> > +#define REFTABLE_SYSTEM_H
> > +
> > +#define MINGW_DONT_HANDLE_IN_USE_ERROR
> > +#include "compat/posix.h"
> > +
> > +#endif
> 
> This one is clearly tailored to be used in the context of our
> system.
> 
> > diff --git a/reftable/system.h b/reftable/system.h
> > index dffc717bd4..52f964c04b 100644
> > --- a/reftable/system.h
> > +++ b/reftable/system.h
> > @@ -11,8 +11,7 @@
> >  
> >  /* This header glues the reftable library to the rest of Git */
> >  
> > -#define MINGW_DONT_HANDLE_IN_USE_ERROR
> > -#include "compat/posix.h"
> > +#include "reftable-system.h"
> >  #include "compat/zlib-compat.h"
> >  
> >  #define REFTABLE_INLINE(type) static inline type
> 
> And so far in this series, I was getting the impression that
> reftable/system.c and reftable/system.h are where the target system
> specific definitions are stored.
> 
> The implementation detail of how we obtain the wallclock time at
> millisecond resolution is in reftable/system.c, the implementation
> detail of how our mmap() emulation can work to build reftable_mmap()
> is in reftable/system.c, for example.
> 
> But the corresponding reftable/system.h does not seem to be specific
> to the target system at all---it describes the common abstraction,
> like "reftable code proper is expected call reftable_mmap() on any
> system" and "the way for reftable code is expected to read the
> wallclock is by calling reftable_time_ms()".

It almost isn't. There are a few small parts in here that are specific.
I was also wondering whether I want to try and adapt it so that it can
always remain the exact same.

> So <reftable-system.h>, just like <reftable/system.c>, is expected
> to have a target platform specific "implementation", and not like
> <reftable/system.h> that is expected to be platform neutral (this
> neutrality comes from the fact that <reftable/system.c> will
> implement the interface specified in <reftable/system.h> for the
> target platform).
> 
> Which somehow feels confusing.
> 
> Besides, the definition of "REFTABLE_INLINE(type)" being "static
> inline type", according to the explanation in [1/6], is valid only
> in the context of this project, so shouldn't it be done inside
> <reftable-system.h>, not <reftable/system.h>"?  For that matter,
> what about inclusion of "compat/zlib-compat.h"?  Is it widely
> applicable across target platforms, or very specific to our codebase
> where this library is used/embedded in?

It overall is a tiny bit confusing, agreed. The reftable interfaces are
split into two parts:

  - "reftable/foo.h" contains the library-internal API surface.

  - "reftable/reftable-foo.h" contains the external API surface as it
    should be consumed by the project that embeds the reftable library.

Now for most of the part, headers in the "reftable/reftable-*.h"
namespace are self-contained. But naturally, we also use some types
there that require us to include headers, like `uint32_t` et al.
The requirements that we have here are significantly smaller though than
what we expose via "reftable/system.h".

So ultimately, the idea was to have "reftable/reftable-system.h" expose
the POSIX-like environment that is project-specific to make the other
public headers compile as standalone units. And then have the
implementeation sit in "reftable/system.c". But I agree that
"reftable/system.h" itself still sits somewhere in between of being
platform specific and containing project-specific stuff, which isn't
great.

I'm overall not a 100% happy myself with the split and agree that it's
somewhat confusing. An alternative would be to say that it's the
caller's responsibility to ensure that our public-facing headers have
all dependencies satisfied, which I think is in practice only <stdint.h>.

I'm very open to alternative suggestions though.

Thanks!

Patrick
