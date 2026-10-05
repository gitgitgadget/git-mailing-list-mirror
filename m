Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FD17BCA
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791170640; cv=none; b=HHiw8hw7NGG1Z7aeCAio7Y3/0eG8k0pi5eHdHal6GVHYHSWqNmHts09SaylU8O3IMkYOSgXtnON5xI9Na7hzpGCJQhoeOLnwLqnhcdM01HHe9eZg6QvZSBdHcWsWBYDZWc8orVilPEYgzA9F8zQ4ZZ9gpguQC4twiJbYXAocVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791170640; c=relaxed/simple;
	bh=XzfD5APzTKyx7GDCw1LDOZFpIExxwZd1/4INA/ral+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxEuZ/P2FF0Nucsn52i+AqvMijZzsz625kNBxHj0OJf/bhxr9Dl2L3aS8BcJPLvrFvaL4VBcO5T/i5sm+Nt7HjH9XjpVykSMxZDswSIRLDey1s4gLZwHykuZd8DNkdh0awr80gwo12ReQCcRgnhe1ulyFPOTHQc1+jsMv9AW/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C6pHWCqs; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C6pHWCqs"
Received: (qmail 25164 invoked by uid 106); 5 Oct 2026 03:23:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XzfD5APzTKyx7GDCw1LDOZFpIExxwZd1/4INA/ral+0=; b=C6pHWCqsoCvs8wx31YDJIIrTZv7Up5GumlGm76dG0nZDyqfjVTtQzjACSlpw7of2hOheZfjmtkb6ChO3hxASTZlXHdqbLdWNOYSdb40K1Oy3U9YVpQNrP6Tx1SxitowERCtHVhozQwlOXG5esut/Qsbeaz/lQOhwq7YrG5fHajGNj+TIUgyvB7iz7yOFao4kfDzod2VS8+FlAyrYNuS46REgpJqbSZPmhp6Rllt78UZbknMtFpq/nX9YjtSkmj1uv1AA/FtNopZVIvN3ruKK9QD7MUe2q/DGD1HR7rGmzv5DRHIUBYAYGgGeZjyAbdc3m9K0zeEnkJ+BsbBuj73jxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2026 03:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 81188 invoked by uid 111); 5 Oct 2026 03:23:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Oct 2026 23:23:52 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 4 Oct 2026 23:23:48 -0400
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <20261005032348.GA10163@coredump.intra.peff.net>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
 <asCY8kLEV4OAG1BG@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asCY8kLEV4OAG1BG@debian>

On Sat, Oct 03, 2026 at 07:59:43AM +0200, Alejandro Colomar wrote:

> > I'm not 100% sure, but I think "git show bisect/bad" should work.
> 
> Thanks!  It works.
> 
> I guess the plumbing version of it would be
> 	git rev-list -1 bisect/bad
> right?

Yeah. Or even just "git rev-parse bisect/bad" (maybe with --verify if
appropriate).

-Peff
