Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598842D0298
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511691; cv=none; b=hifATe0vTsWI+Pghi7TDnKQsx5q6J7m19ZRya0JtExekeoKS58Z53sv9AdHtKwb0MfSkOMFhrr78NYdED/Q/ZYOayWYiljx2530tavKK+SKvrhlNYQqsMOt5WTSDk1YiuP6YBWx/RiqNh8LKg79gy7KIV263VasgJqSIn3ULTFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511691; c=relaxed/simple;
	bh=mlpRoiOC+cEnmiBCQg6e9H2GEzmwDXjWs/Oeoa2N5c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQNsHl3nVkoiSJaOav++UVUojq4snYtOTEn/JzXmomxqQieOg2Y9upNtzWECUIJSuZCvA9YGJQB1vutdBLL8sRd1e9+4A4NjZmJkXNYbd0xanOy+t+GgKPbIUH9Epg6pmu27gIe6cnZEsPKKQE1dHNI6EjNTGGLGjvzPqaRw1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fKNktjLc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fKNktjLc"
Received: (qmail 50695 invoked by uid 109); 15 Jan 2026 21:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mlpRoiOC+cEnmiBCQg6e9H2GEzmwDXjWs/Oeoa2N5c0=; b=fKNktjLcAcRqbmxfNUINaYBeoJ8UCn5O7ZQb240JYCaLZqLaLDosubBu3O6GqEtQjaOZMomhSDm3C948Ds+5XHXMnrk74U55x0C6Co5ifO5D/nfYOmnCK/+ju3L1p+gkE8qphVYwYa4wZgthxUnpHe3Q+ppBqbr6rNazfDnmbIyLbYEpIwdJp0aS3ksGCYYfPRoOovzXRzqritjy5i05oviU9A+S8+QRSUTjoU7kBc9J+q0/02zbVqwGauRAWvRvdH1ScqgvkBF8Qpehkug8NSHzbC5uEd0HD3b4Mkm9dmAbmcOssdeEofxD15K0WQ/gVwr0QEqgU+0JObCI5sF0qg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jan 2026 21:14:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83085 invoked by uid 111); 15 Jan 2026 21:14:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jan 2026 16:14:50 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Jan 2026 16:14:48 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <20260115211448.GF1053259@coredump.intra.peff.net>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im>
 <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>

On Sat, Jan 10, 2026 at 05:26:04PM +0000, brian m. carlson wrote:

> The reason these sequences, along with other sequences not mentioned in
> this series, are useful is because people run tools like build tools
> (e.g., Cargo) or linters in pre-receive hooks and print the output and
> those use a substantial portion of possible escape sequences.  I did a
> brief survey sometime back of pre-receive hooks on GitHub to see what
> escape sequences were in use.
> 
> I think Heroku has a push-to-deploy technique that leverages this
> approach to build and deploy your app, for instance.
> 
> This is one of the reasons that I was opposed to this series: it tends
> to break what is a very common use case.  Certainly it is not as common
> for cloud-based forge environments, but it is very common for people to
> do these kinds of things in self-hosted forge environments (where custom
> pre-receive hooks are commonly used) or in non-forge environments like
> push-to-deploy.

I also share your concern that real-world cases may be relying on these.
But I am also sympathetic that some people may prefer to risk breakage
(or ugliness) if it might protect them from misleading or mischievous
terminal trickery.

Is there any reason we cannot introduce the new functionality as a
config option but _not_ enable it by default?

That gives people the tools to protect themselves if they want to bear
the potential cost. It just feels a shame to deny them the tool because
we can't agree on the default.

-Peff
