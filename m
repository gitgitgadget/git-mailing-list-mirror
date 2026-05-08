Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D983ED5D0
	for <git@vger.kernel.org>; Fri,  8 May 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249709; cv=none; b=LA5bjACJvSmZOVa2Qe+dAhgSlDxpfXM0ECZKbPYsg6NxSL3b2LSOAorRHI0+2G8cE54EmPrS57sdcd5at7DoriOUbwwgNBS3CGyqGjZX5O22+Ihp/suX3qFB4SNQ6BvzE2SVkVn/Q6P8gsAddRuNwD7fcnd82YCUC6u0fs+a008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249709; c=relaxed/simple;
	bh=xX0VZ23+Km360Zb7ipm0EKbcR9kAGYg7Z0WNlg5vl8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF4wKk7KmV/SXLMZwWR1xDMFjVkO8Dc5S+PxUr+MeaoaXU2eTmMDDPQctz3MRANmskVEKlccjYinIK+SCVPGEhCHG9rnH2fVcgGYuQzzcoY0wcMqYKQ7FkgQTk4Kvr4/53u10vCdnsvl9/HQWHMJGxNLHfb4vp3a7wY+DsSRm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QFUW8n8p; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QFUW8n8p"
Received: (qmail 63121 invoked by uid 106); 8 May 2026 14:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xX0VZ23+Km360Zb7ipm0EKbcR9kAGYg7Z0WNlg5vl8s=; b=QFUW8n8pyClquGQuqKrR8HQUFbAGwM5m2+HtX+JMFnSINqT1CW6BmXveA4McwJC1aVQZfOCEUGhVzULpSfP3gMD5VzdlLVqMIMAUZPnKUlIgtOqaONg2Yj4zEWyF0jd5MsyE9IY8Dc9UHwJssarVLDQQ3QgfW6gvMJGQhWLnYbkMdyHfrdT3fEpYR0WXwWwL8HdtPeamfHc/WEOHgFcJaHSvObx3ALwegB2ySFNCNOBkrDLhs+uGdbtryeUij3Fo4zaEWoWBLKwkVWvgT+Q3Pxre/WWXc4vcc0LSPY8jxcAfjyg3tOx+1VoH111/5bpGPy9qJwW859vjpuKRH62+Xw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 May 2026 14:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 123799 invoked by uid 111); 8 May 2026 14:15:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2026 10:15:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 8 May 2026 10:15:04 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] mingw: stop using nedmalloc
Message-ID: <20260508141504.GC709299@coredump.intra.peff.net>
References: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
 <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
 <xmqqfr42fw30.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr42fw30.fsf@gitster.g>

On Fri, May 08, 2026 at 11:56:19AM +0900, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > The patches that remove the vendored sources have a slightly unusual shape:
> > the Git mailing list rejects messages over 100kB and
> > compat/nedmalloc/malloc.c.h alone is ~196kB of source, so the deletion of
> > that file is split at section boundaries into three commits, each
> > comfortably under the cap.
> 
> The history made strange only by the limitation of the tool (i.e.,
> mailing list) we use is like the tail wagging the dog.  Could you
> give a commit log message that describes droppage of everything done
> in the "artificially stepwise only due to mailing list limitation,
> but we wish we could do in a single step because the separation is
> not logical at all" in the later steps, to the first of such steps
> ([2/6], I presume), and give each remaining patch a single liner "to
> be squashed into [2/6]" log message, or something?  Then I can
> squash them on my end.  Alternatively for this one only after we get
> favourable reviews on the early two steps to drop the use of the
> library, I can pull a single "discard everything" patch that builds
> on these two from your repository.

Could this be a good time to use --irreversible-delete? It is not like
humans are going to read the 200k of deletion hunks anyway.

-Peff
