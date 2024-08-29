Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1121BA26E
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960457; cv=none; b=lrHlGqqsDbH1VZ7fQaE5WHyOZG4wSmhem4zzWaSQNpovFxGhbOhC8Verl72FY2W05ufow8Pdmqeh+O2jO2UeiuFoCVe29m+WlQaBIvqZleki0tJ/MZEmswyoR99535rjRliB17vx3qaewOsCQhj0Qpgo57PDj3N8Wa4J3AKFyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960457; c=relaxed/simple;
	bh=Bbc5KCNtbM9AzjhaStABuN51prSuRxJBVOHLs85UsX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th4Xt0nmbwMGpigVaieS5EkonGJ0YuVMr/jU9h7bG5uAYrJFLiGyC/JjdDrY6lsh2yp9lzMiW/51jN2AlrP9EIJZDiQDH7PWxAaF32A2owUSor77VgyXAeRGhMsqQrCaOYuLGM4QPkD1uj4rBCfXw42SdUAL7KOTSlF7F8Z+eBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5860 invoked by uid 109); 29 Aug 2024 19:40:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 19:40:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9978 invoked by uid 111); 29 Aug 2024 19:40:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 15:40:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 15:40:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] CodingGuidelines: also mention MAYBE_UNUSED
Message-ID: <20240829194054.GC423429@coredump.intra.peff.net>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
 <20240829040215.GA4054823@coredump.intra.peff.net>
 <xmqqseunxtks.fsf_-_@gitster.g>
 <20240829175215.GA415423@coredump.intra.peff.net>
 <xmqq8qwfw6e9.fsf@gitster.g>
 <xmqq4j73w5up.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j73w5up.fsf_-_@gitster.g>

On Thu, Aug 29, 2024 at 11:18:06AM -0700, Junio C Hamano wrote:

> +/*
> + * MAYBE_UNUSED marks a function parameter that may be unused, but
> + * whose use is not an error.  It also can be used to annotate a
> + * function, a variable, or a type that may be unused.
> + *
> + * Depending on a configuration, all uses of such a thing may become
> + * #ifdef'ed away.  Marking it with UNUSED would give a warning in a
> + * compilation where it is indeed used, and not marking it at all
> + * would give a warning in a compilation where it is unused.  In such
> + * a case, MAYBE_UNUSED is the appropriate annotation to use.
> + */
>  #define MAYBE_UNUSED __attribute__((__unused__))

Thanks, I think this is good. There's more nuanced discussion about when
the "MAYBE" variant could be used for non-parameters, but I don't know
that it's worth trying to enumerate every place we've found it useful.

-Peff
