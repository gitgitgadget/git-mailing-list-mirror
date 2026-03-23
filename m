Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878CAD4B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245455; cv=none; b=aLgMawMe82vt9O2jKFnPrj66ZzvPrVbY4p9vOuIFHoI6zT/JEz9lK4d0UWGZQOVw+9gzJk1IynJmCem1jMw6ebJpMU6h2GCr3GYs49/ldjOswCBX1NEKUiyHtP4c3IKEMtjR7SILSjEFYGdTeEE/zy5mJVRnqHjcpKSfOIxPqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245455; c=relaxed/simple;
	bh=aGjCO0zGaU3btMy13l2TM+K3UsGBPlm90DPOtOcZg24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAHZBPR2TeTLmOJpFTqYj0i6Ii3mSZUVqlL0cFxCFixaNiLxM+2kWpbji78UxEGQRwAV2O8vRUSDahPGiNrp15WPa055udK3l4w5cXnZkwv1NfguvPXFVj7VSOAxzTniX0AlllFqxwznb6oSXpuWCbZ06cKouQL6FI66i7SPptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UUupQJxG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UUupQJxG"
Received: (qmail 110124 invoked by uid 106); 23 Mar 2026 05:57:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=aGjCO0zGaU3btMy13l2TM+K3UsGBPlm90DPOtOcZg24=; b=UUupQJxG/ZpKV/yYOol3IQaUYVKG80CZ+2Sm2mfLLKFuD32orpVe0C/zugmUI+Yhg5ISb9yhs/UnSOLdUSmMKKEL1e0q/wUSABYhhrAk9itCa0ET5ZaNC42BOtWqxwMJGFJzpaCNURMGDXLFXG4/F8Xh481oCbcyetVlELsAcgFDCxbDWv4mAKw9R/T+D1xowyWVScuZcth4yXDOxIbyRKYM/KB+ZtQJsK4NJwr3Jl4z0cK28AZ5aW/1ARjCMudzZ9X7MGXxv+x8ORPB0HPcHxvhz3X9CQT8jCW7HywK1F+Vkizr8d0VxSpv+yZJU+TIBGJIVRUfPRRbKo2/XkGKeg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 05:57:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146860 invoked by uid 111); 23 Mar 2026 05:57:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 01:57:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 01:57:32 -0400
From: Jeff King <peff@peff.net>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH 8/8] diff-highlight: fetch all config with one process
Message-ID: <20260323055732.GB9976@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004856.GH3654226@coredump.intra.peff.net>
 <9d3633e4-6413-4932-a29d-e0347546ede8@malon.dev>
 <20260322204509.GA2047044@coredump.intra.peff.net>
 <9818e3ec-838a-4eef-8436-a395f2970d42@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9818e3ec-838a-4eef-8436-a395f2970d42@malon.dev>

On Mon, Mar 23, 2026 at 01:39:44PM +0800, Tian Yuchen wrote:

> > I don't get any warning on perl 5.40.1. Are you seeing one on a
> > different version?
> 
> It's mainly because I saw that you changed the required version earlier：
> 
> -require v5.26;
> +require v5.008;
> 
> I clearly remember that in older versions of Perl, the length function
> behaved differently than it does now.

Heh, it figures that dropping back the version requirement would bite me
immediately. ;)

> In 5.8.8 the output is:
> 
> 	Use of uninitialized value in length at test.pl line 5.

Yeah, looks like it changed in 5.12:

  https://www.effectiveperlprogramming.com/2010/09/in-perl-v5-12-lengthundef-returns-undef/

I had actually written it using exists() originally, but then dropped it
to keep the diff smaller. Which is a silly reason. I've switched it to
use:

  return defined($s) ? $s : $default;

which I think captures the intent pretty clearly. You could also use
"$s || $default", but I try to avoid that because of surprise-false
values. In modern perl you could just use "//", but that wasn't added
until v5.10.

Thanks for pointing it out!

-Peff
