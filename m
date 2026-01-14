Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7432D0C62
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429051; cv=none; b=d/TtV/gq6BpemuCZbXOE/dPYxvrXrQ1FoVgMICO1c4Hh59MzZTU1/lDUIk1dhou2+d9c2zA2zar+eb0XzYE0XZkidRyjCo4AeJtR2YsxonxXWy4knX7p7n2pQ4IvPK6Tj+Mq5C91ppmlf+KO3rUa8O148OvxSkFAqUzREiWSdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429051; c=relaxed/simple;
	bh=21iD5g4I0ZtbyeW2nA7rWV7Q83BFeaME/6IeKk1jrws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PddeYPB8uDJ+OOYQNK5EDp/BxFxctWm2fyiv+rDG73WTM2hJE+KcJBLevVSUMIb7lDJbhlAwiFsthqp9Rv4hj/xzCGcro3MOHgqu+WDJwKmdAMKfhI81Q17f9vJZD3XQAH9toHuyBDcTVcJodTv5ofTqSLJ3CNvoDrt4RdTvlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WlwFDXiS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WlwFDXiS"
Received: (qmail 42027 invoked by uid 109); 14 Jan 2026 22:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=21iD5g4I0ZtbyeW2nA7rWV7Q83BFeaME/6IeKk1jrws=; b=WlwFDXiS12MDXprgnRF7FLRiRC4y531eEj9oEHH/ojhR3yRI3MTdchOHis23OqVbKRAiElFW3pc55nQ2w6zB5kXFHXhGH3ABDmzhfumNUCMAUPlmFPJev34XuqQuAxr6Fio1xcqU62Hl7btfphK2w/3Xtj3NEayLI3YMAyIjQDTZHKw/XS8rjAUmbGjhPtCVT4ojBMRFmSoR26YqGwMJVmBQ11DYCR2UFwpL2HC/5AUcMQDQRXAKM6b4I2oEwFaHXU0iEcIAFQspl2zk/aST8f9NwK+ElPs5yQ09unu2FFKSnnH2oLKQS91ruL6QbT0vWGKacp9dm2p9vZmJ7n/isA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 22:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 70969 invoked by uid 111); 14 Jan 2026 22:17:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 17:17:19 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 17:17:16 -0500
From: Jeff King <peff@peff.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Re: Triangular workflow
Message-ID: <20260114221716.GA1013308@coredump.intra.peff.net>
References: <20260114162427.GA885771@coredump.intra.peff.net>
 <4F632782-4B1C-452A-A64B-CA223D2C16B0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F632782-4B1C-452A-A64B-CA223D2C16B0@gmail.com>

On Wed, Jan 14, 2026 at 04:38:33PM -0500, Ben Knoble wrote:

> > Le 14 janv. 2026 à 11:31, Jeff King <peff@peff.net> a écrit :
> > 
> >>> Yeah, though @{push} is usually not explicitly configured in the same
> >>> way @{upstream} is, but rather a consequence of how push.default and
> >>> remote.pushdefault interact. But it was added for exactly this kind of
> >>> triangular workflow. I sometimes will do stuff like:
> >>> git range-diff origin @{push} HEAD
> >> I imagine the same thing could be achieved with
> >>  origin/$(git rev-parse --abbrev-ref HEAD)
> > 
> > Sure, but:
> > 
> > 1. It is a lot shorter to type @{push}. ;)
> > 
> > 2. Using @{push} works everywhere, even on my non-triangular repos,
> 
> Just so I’m clear, this is only with push.default=current, right? I could never make @{push} work otherwise.

I always use push.default=current, though I think @{push} should work
with other modes. E.g., with this setup:

  git checkout -b foo
  git clone . tmp
  cd tmp

  # for the sake of simplicity, our triangle goes to the same place ;)
  git remote add triangle ..
  git fetch triangle
  git config remote.pushdefault triangle

then doing:

  git -c push.default=current rev-parse --symbolic-full-name @{push}

and:

  git -c push.default=matching rev-parse --symbolic-full-name @{push}

should both point to refs/remotes/triangle/foo. Using "simple" will not
work, because it demands that the upstream and the push destination are
the same (so it doesn't really make sense in a triangular flow at all).

But in a non-triangular flow, it will happily point @{push} to the same
as @{upstream}. I use a triangular flow for git.git, but most of my
other repos are just personal projects, and I push/fetch from a single
central source.

-Peff
