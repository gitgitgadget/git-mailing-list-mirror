Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17923AA4E3
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454761; cv=none; b=LQABmfrXqXH165fdeyJY81REcGFQr98h/Gvl/8BrQNmMWwUiM5+rMEYZiPxw7jJTgPpRH3gc5KprlWbldNqQp64aV+WF+MHlZm5Yj8w3CigXhRwLt5WeRKuvROIjqg0tQiL2YOyagkazRGa+rNldLeVzxQ2jH8eDe86Ml7U1XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454761; c=relaxed/simple;
	bh=7BF2RA0SLWkJjtpa3DL/0Ix/XT5YQPxStjc+jJL15qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYz74ZyUvqTYIXcxjMlf8lp75bDC/sfO/0QcZE+U0C/MH1jGMl0K8yXWP7yhGAMrHrARyJqepKcMlJTguDL2Qd+8nTxTPOXLk0D/JsE3TdVqZd5reV9C5xHUGBuluwLG/ZF/VKnqqRxtxUZbJIz4X8dpXsg55lQsCFixsuqgsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dlx5ma4x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dlx5ma4x"
Received: (qmail 22752 invoked by uid 106); 7 Jul 2026 20:05:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7BF2RA0SLWkJjtpa3DL/0Ix/XT5YQPxStjc+jJL15qw=; b=Dlx5ma4xWY/QkgzSoLXJxUMUjiGPOBvxa3c5HL6HiXLbCzMoRTh+CdzmjSZMN8fOT2gryaBRVp9zlB+vTq3e7vDu3wIJ8E9di89pXsHo65F5ANARGv2gnwyn28K5tdzkoJgKlm/WkF89jdSW6/w90dutgU6RVr2cNCMCRdbSL99Ac+KctlTPbs2Put47KkLrqnMS/7URyjugI3H+oiJiCEhP9VUVSstqYSVgfXgIIgd/dcv3NEpZ0lduRst9KvTF1DVJSzouD3NfhBculPVUG5BEi6gchs50VeuWAghK4zKx7mnaL/rMyf/V7ddwD5WmHbIUa3MLxQa7Qis7V6VgeA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 20:05:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34072 invoked by uid 111); 7 Jul 2026 20:05:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 16:05:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 16:05:56 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/7] hash: document function pointers and wrappers
Message-ID: <20260707200556.GA11780@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050557.GC1288294@coredump.intra.peff.net>
 <ak0MnN6sUtFimvYe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak0MnN6sUtFimvYe@pks.im>

On Tue, Jul 07, 2026 at 04:26:36PM +0200, Patrick Steinhardt wrote:

> On Tue, Jul 07, 2026 at 01:05:57AM -0400, Jeff King wrote:
> > diff --git a/hash.h b/hash.h
> > index 0a23ef4dfd..5686914b71 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -341,12 +334,40 @@ struct git_hash_algo {
> >  };
> >  extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
> >  
> > +/*
> > + * Prepare an uninitialized hash context for use. You must eventually release
> > + * the context with with git_hash_final() (or final_oid()) or by calling
> 
> s/with with/with/

Thanks, looks like there are a few minor formatting nits, so I'll fix
this in a v2.

-Peff
