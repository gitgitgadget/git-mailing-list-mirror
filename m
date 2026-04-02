Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4C37C0FD
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110572; cv=none; b=ldlOur08HjnrKAv4tSVDRaHPhw+PMpWOM/+dM9po3LlA/Kh9yPH46KTMxeVLuq8Bg53tViLba1aEGZJjnxhYzgrvI0lUMl/mdHbRmk+zdC3A/y/MOl1ekpn9bblDF2Bwjrt7ZOS0Ih65ZKG2D+Q6WMcqXi/GeYNvld1nXaO7K9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110572; c=relaxed/simple;
	bh=QR3ji3yDJQntsQOqkxGUGqvU72RlYnD2tYGMCUOofaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyGamjbWKx7nZv90GwQrl0u1TuMhc2G/q7pniYtqROpMgTnMyeLHOYsBdUnsut96SvNkU7F70YbmB0yG697vV9+3VLK3DP+DJv8yTGtLSAPl8dkyLrSQnQgWz4kLxNRwSLWTXNydYS7jjxR5o7q1u4RHm2A8xwdoPzcrwxq5GpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ibSdDcm3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ajq9iw5V; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ibSdDcm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ajq9iw5V"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F3C951D003AB;
	Thu,  2 Apr 2026 02:16:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 02:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775110569; x=1775196969; bh=L3pjn6nzIR
	HwCc7QeBNVX6QUycoAI7tpIVg9KolGKY0=; b=ibSdDcm3buF1/JR99QAXjuDhCz
	Z8tD9+ajY/19uZ1VhaUyOUkm8XIsubiDmIsK049N9rr1BzEMJUL3YdWxZOEpwSTs
	H2UqDbC/AU9cTFyuYp5UleRMNoRZOxybf5rOJulviWFSQG4p6ohUVc8bU72W+RRx
	hmjPuZDVRO6/X0b7TGGJbRzETTHpGAfhXFsmtkqlGnMsnKthpcWY8CTtpexdqjr4
	LEhpfRobJiqkdJnvr59EULZBvdJkdspMEp4ruyokp52etLguJI6Dyzku5WO26PwP
	CLeCpBA0JTIanccoY7ddytcnvF5aqjMhWT2PdUus/TV1kHkJHqvMSzzO40Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775110569; x=1775196969; bh=L3pjn6nzIRHwCc7QeBNVX6QUycoAI7tpIVg
	9KolGKY0=; b=Ajq9iw5Vju/i0eKw8Vpotn3/xyAgIVz+hUTAdTJwD/Jl9AaeHS3
	0ps3H0tnx31I0YrzKiaLGpTEUM3UPHoj4/TMqFZWLee1C+90y4FrzrrAvKkRu4+L
	nzsbAC3m32Z3c2nNLoU6HvHEHdqQ2rpQQarSLUaELqh/UwYzTElFLXBc4FrdaGXS
	aVHmy49lsfTWVnXbvb60iL6YzsonHyPo0aVEwjw+5AjqWSLieAiPhxE/zQ3NJ3X5
	EXhrFG07uiPgiBScUDEI3dfANNvkwgv9Z67O0c6xEW8aOC560N2AmeOWPLoYXKFk
	ATM5QQu+0r19AvRbVyyrX2Sbw2UL75Z+NOQ==
X-ME-Sender: <xms:qQnOacMYHtdHKbrVJsGBMJbF_LDCGDh6TfWPIM0IZyLepeZFk-7dLg>
    <xme:qQnOaY9cZ2guYYjP99ohpyWPxDAD4rPnC5xlfZ8gouSoiHA9hycmuvnNuSf_Ndybx
    kr2K7CU-m_okr1Ma4tSsljAWfUJALJJuIkkPnwT2M2HtpNm_g94BA>
X-ME-Received: <xmr:qQnOaQ7ZR9sViX9SgXvI-F0anurz_4bTZpgqGPU17haAtEUVEwP-n2tgTCxK36QOyuoHeyeEjK74-b3I574WPjQ8hNJEDhpbaWwHHIHUsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qQnOaf1HXE9K6HzKgFjfFd9IZ0XJbDprXDd5CYKY23qL6uMZlrDn4Q>
    <xmx:qQnOaXBy-l_Ncl3-7X4GHhs88jAwadGIDGcotbEignF6LguRXDcmQA>
    <xmx:qQnOaR1FSx2LUEr6k19nzMTEumCcPnXzSkglgHn1RHlw01Yb1KewfA>
    <xmx:qQnOaRsuddFGpEoPkLJNxcVmeop8oQacvc0dFMAr-s8Tm-bSqSd27g>
    <xmx:qQnOaXnE9TBB-L8N6JwcE23oyyIKRIc7hFgXpEkRxBn5I9b1gIregrCn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 02:16:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc7dd9b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 06:16:07 +0000 (UTC)
Date: Thu, 2 Apr 2026 08:16:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] reftable: introduce "reftable-system.h" header
Message-ID: <ac4JoLv7SUiedzm9@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-6-46bfae55c68c@pks.im>
 <xmqqwlyrzwh0.fsf@gitster.g>
 <ac0MDTQR484_yxuv@pks.im>
 <xmqqse9ewsaw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse9ewsaw.fsf@gitster.g>

On Wed, Apr 01, 2026 at 09:37:11AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > It overall is a tiny bit confusing, agreed. The reftable interfaces are
> > split into two parts:
> >
> >   - "reftable/foo.h" contains the library-internal API surface.
> >
> >   - "reftable/reftable-foo.h" contains the external API surface as it
> >     should be consumed by the project that embeds the reftable library.
> >
> > Now for most of the part, headers in the "reftable/reftable-*.h"
> > namespace are self-contained. But naturally, we also use some types
> > there that require us to include headers, like `uint32_t` et al.
> > The requirements that we have here are significantly smaller though than
> > what we expose via "reftable/system.h".
> >
> > So ultimately, the idea was to have "reftable/reftable-system.h" expose
> > the POSIX-like environment that is project-specific to make the other
> > public headers compile as standalone units. And then have the
> > implementeation sit in "reftable/system.c". But I agree that
> > "reftable/system.h" itself still sits somewhere in between of being
> > platform specific and containing project-specific stuff, which isn't
> > great.
> >
> > I'm overall not a 100% happy myself with the split and agree that it's
> > somewhat confusing. An alternative would be to say that it's the
> > caller's responsibility to ensure that our public-facing headers have
> > all dependencies satisfied, which I think is in practice only <stdint.h>.
> >
> > I'm very open to alternative suggestions though.
> 
> So your assessment starts as "tiny bit" and in the end ends ujp with
> "somewhat" confusing ;-)?
> 
> I am OK with two level:
> 
>  - A C source file that will be customized for platform and the
>    project that embeds the library to implement a neutral interface.
> 
>  - A C header file that defines what that neutral interface looks
>    like, without having any platform/project specific implementation
>    details.
> 
> But that header file, in order to define an interface in a neutral
> way, would need to be able to see common types and things like
> "inline", so it is inevitable to have the third thing that is a
> header file that will be customzed for platform and the project that
> embeds the library.
> 
> And in that context making reftable/system.c in this series the C
> source that implements the neutral API for the platform and the
> project, reftable/system.h the C header that declares the neutral
> API, and reftable-system.h the platform specific shim to show a
> common definition to reftable/system.h, may be a good division of
> labor.  So, while I found the _naming_ confusing initially, at least
> between reftable/system.[ch], I no longer see the naming of the
> files a problem.
> 
> The division of labor is not quite honored in the current
> implementation, though, as I pointed out that just like MINGW
> specific things that are moved out of reftable/system.h and to the
> reftable-system.h, other things like inline and compat/zlib-compat.h
> are quite specific to our project and belong to reftable-system.h at
> the layer that exposes a certain system services to reftable/system.h
> and other "more common" parts of the library.

Makes sense, thanks for your input! Will send a new version soonish.

Patrick
