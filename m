Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7322A7F2
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717102; cv=none; b=P3heCpDJU3AUVDJZrnWYLEDITEWpbSXbiDFwi8C7j9T0ck2Oyy6AzsBZxkjpWGrMy5OlE80RZKcT47HM3Zj5e74wig+nF8pJTWwnApwsRblVD+pJ/eMTBpfzQsdFX6RyQI4sYTn1JM88hF61DcYeRtEvwAZqf6MDTgGLNj0xZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717102; c=relaxed/simple;
	bh=DtE2/Eltg0BTmVKnO8ur36pqJWj73YlQZKXbF3w4q7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg+u3GHhghn9TtpI5ALNFXHBVtwApchBrAhtoMSBAQW1usGfM8UqPgwsoKKA9qg0d6HBkK5oWqgAz8VoMWSl+lpK4fBAlS9mL17XhCx0dnus+Z8gdKwEgkdpK1x/PD2E2SjZPQWLN01+QmZECXSfE+AbrDrIjQTK/IOF40DDAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Jkkp08aO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Jkkp08aO"
Received: (qmail 15374 invoked by uid 109); 20 Dec 2024 17:51:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DtE2/Eltg0BTmVKnO8ur36pqJWj73YlQZKXbF3w4q7s=; b=Jkkp08aOFyycbgeTG3+is7M/9LgVjC1Ni7R51WKUTGBI2R2RCwrRwpgFGS0Iw0ttQKT/EM9hN+LAi46FNsV98kkJWlU97h4n8nzr0UL9YKTAAQ+kf+XrClT1dRm2/z2ogIW2iPhuko/tUrtvZtusb4PALVutoELOCHpKhlRv65cjhGRZ86QMHHyC3BHZRvf+B/+G9HLH4WmQdI05Q25dD15VVsakRcRVifyMEjrneHwpzAQPRPRPB/vJWPAVuDEFxkVpAFvqX69qcwXYkPv013+Lthn5HWun2GDmg54yGfNgYEfETe6m4NQyq57X1MWjU4KGeumxCXYil1CNhO5GVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 17:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20259 invoked by uid 111); 20 Dec 2024 17:51:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 12:51:36 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 12:51:36 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <20241220175136.GA203033@coredump.intra.peff.net>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2WfirfrpYYFgYdw@pks.im>

On Fri, Dec 20, 2024 at 05:47:14PM +0100, Patrick Steinhardt wrote:

> > This looks good. It fixes the issue, and I am happy that:
> > 
> > >  asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
> > > -	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > > +	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > 
> > ...these spots get even simpler.
> 
> Meh. I just noticed that this doesn't work: we include GIT-VERSION-FILE
> and export its value, and consequently any subsequent invocation of
> GIT-VERSION-GEN will continue to use the value that we have in
> GIT-VERSION-FILE. So it's effectively only computed the first time.

I'm not sure what you mean.

I wondered earlier if we might into a chicken-and-egg problem like that,
but I tested and it seemed to work fine. The rule for GIT-VERSION-FILE
means we'll build it before make reads it, so that first run of it will
get the updated value. And:

  make GIT_VERSION=foo && bin-wrappers/git version
  make GIT_VERSION=bar && bin-wrappers/git version

does what you'd expect. And the docs work the same way:

  cd Documentation
  make GIT_VERSION=foo git.1 && man -l git.1
  make GIT_VERSION=bar git.1 && man -l git.1

Is there a case you found that doesn't work?

-Peff
