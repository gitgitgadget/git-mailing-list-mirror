Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF21B5EC7
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951237; cv=none; b=pk0XZti56YFhDqWlWnfXVcdOtZby3MG8VE315EFS2W5tkJOLHci+FsNqrPihNT6iSgcshUSg++cDn3TgrCSVycjTmT/ulQlpHHQI/aqzWYLWnJ+NFDaftLky5MW1Ma4XV/2pNHKhLz8O2xyamXY7QEezHjP8YE+Lcbn/PabeMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951237; c=relaxed/simple;
	bh=oj5PAbuhKSHq8gIlf6375KGp6Ga5pBcX+tnFroinXjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3zmI2op4jvofEU3mTu4SWrTnIR/pJ46AMuTWu/0l/psKw72pAlY43uaVcErsjpk2/+ehhMrmxwqISFGsZd+1vmBtzW4ivReE7H0LzANfhjC+qOaS8vy2SBixbz6Np2FKegoG5MoiD7NvaGST50SU+2jkn1usNOWfF56hIfskpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4651 invoked by uid 109); 29 Aug 2024 17:07:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 17:07:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8304 invoked by uid 111); 29 Aug 2024 17:07:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 13:07:13 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 13:07:12 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
Message-ID: <20240829170712.GA405209@coredump.intra.peff.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-2-ericsunshine@charter.net>
 <ZtBHbftK7vdTEz93@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtBHbftK7vdTEz93@tanuki>

On Thu, Aug 29, 2024 at 12:03:33PM +0200, Patrick Steinhardt wrote:

> > diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
> > index 338ecd5861..2efd65dcbd 100644
> > --- a/t/chainlint/arithmetic-expansion.expect
> > +++ b/t/chainlint/arithmetic-expansion.expect
> > @@ -4,6 +4,6 @@
> >  5 	baz
> >  6 ) &&
> >  7 (
> > -8 	bar=$((42 + 1)) ?!AMP?!
> > +8 	bar=$((42 + 1)) ?!ERR missing '&&'?!
> >  9 	baz
> >  10 )
> 
> I find the resulting error messages a bit confusing: to me it reads as
> if "ERR" is missing the ampersands. Is it actually useful to have the
> ERR prefix in the first place? We do not output anything but errors, so
> it feels somewhat redundant.

I wonder if coloring "ERR" differently, or perhaps even adding a colon,
like "ERR: ", would make it stand out more.

FWIW, I find the existing error messages pretty readable, but that is
probably a sign that my mind has been poisoned by using chainlint too
much already. ;)

-Peff
