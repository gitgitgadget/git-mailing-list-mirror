Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF2846F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072535; cv=none; b=pT6hH7tFimHKCOgXfZiMSDFhuSMIHQ06X9i02CpKkhLFOFypn8rrskbNx0Xx25i8eBPRg/lqbl7VQkjppSvkQXaRquoFqJnN2hjQEqLSjXjDuF/ncCrObtvOjpEmAVSKCIRw1bPi9x7GumpKbgUmOnkl7u3w6lutkr8BCa69PiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072535; c=relaxed/simple;
	bh=ABPbN+XUASOrTtmCLNuGvVCFhtpXHhtR28qqTwGzkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOL/z+6dBIuYKtw0/LdvQWxj3FHEefrokYsob5nAFfWHM5fqrIHhF5TkwnTWK2NHIVXLtqKIUAthqU/Zt3FDT7ecBWssrjgw9F7fqMqwX7YeSPVV7WZW1VsAksd+IdpKJqHAZRZZn8cTBiKUmYx40XN7yIf3QdXtB1dZrt9QaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UM8QtRab; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UM8QtRab"
Received: (qmail 181818 invoked by uid 109); 10 Oct 2025 05:02:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ABPbN+XUASOrTtmCLNuGvVCFhtpXHhtR28qqTwGzkiE=; b=UM8QtRabiIC+1Ko+sE6R9OaZ/BdcnRi0ye/RyzJxZ2smHGKBSkLGjWosml7FzDhA194sKSxtkhgeZ3Z4weBaNSFiGh5Bb3bSkHYa7LpVHo9kp0BOyB7OMkNwjZtlupl4FMEkY3Uv4lzDHlSezLu48MDRmntlk6NbxwEcws1X6ZMwKqp9SznzgQchce4y4Knh/qHS3reIR1dvd0UpfcrHGrDJ/B6L4v5/czhYVBs963E3yOoTTGZnAvkq93ZHaRlubPEXcUw0IHsQQZ/CXDXrN0HmyHyl2QWmZrsiaiUdQrRbGHGeN6/1nFFbMkss0JI5fhd73gC/e+ooH+5vX6QY3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:02:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282599 invoked by uid 111); 10 Oct 2025 05:02:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:02:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:02:07 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: fix accidental literal blocks
Message-ID: <20251010050207.GA1897715@coredump.intra.peff.net>
References: <7a955ecb1b5.1759923933.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a955ecb1b5.1759923933.git.code@khaugsbakk.name>

On Wed, Oct 08, 2025 at 01:48:46PM +0200, kristofferhaugsbakk@fastmail.com wrote:

> Make sure that normal paragraphs in most user-facing docs[1] don’t
> use literal blocks. This can easily happen if you try to maintain
> indentation in order to continue a block; that might work in
> e.g. Markdown variants, but not in AsciiDoc.
> 
> The fixes are straightforward, i.e. just deindent the block and maybe
> add line continuations. The only exception is git-sparse-checkout(1)
> where we also replace indentation used for *intended* literal blocks
> with `----`.

I gave a quick look over the results of doc-diff before and after, and
all of the changes look good to me.

-Peff
