Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10D2F9D89
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054515; cv=none; b=bSpkaujBEfCZ14/XR/topObYGj4Nyw6qahVvhz/JIgkwMF0FP87dbVuC4snvL84Rh64BAH8NFNUGPPoQuy6OjEpUvjau8xtJAw+N7uPF4AyTVO67B5TCWl+mPHE6BHtpUCnJqeaiGEAgfp6kJTvCmUG2DA79/n2ekxiWl3VrsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054515; c=relaxed/simple;
	bh=JdJiOfJadx27eJ98LyBZahyN+T4MrC+H+8G+NMlmFFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk8qJJCXNr/70Igu4rc+e1c328Nh3ye6YageY32V0y1UV2nBO5rEEEKq+Kd7KuIEimRvzPiFq5WUeJFnaKwjq7dH4ewN8zr7gG6S0hT0kyTGwnx/rzoPwuep0x7XcIieJgjf1F0tgNd2VFoWJJR2OzTAtOaTMCkJU6QmGOsmMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hS6id8sm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hS6id8sm"
Received: (qmail 102530 invoked by uid 109); 16 Sep 2025 20:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JdJiOfJadx27eJ98LyBZahyN+T4MrC+H+8G+NMlmFFg=; b=hS6id8smsVRfF+fOXxX1oN7sfAnjnDrTxuMg67zY9pKATb+Z0vb86eGWsA8TMP/p9jFEY30FukFUQNVFDAuCkmv/kDrkt2G6jL1LGg6ug4BiHODgcujzC6Vb1kUshp2tlMnn4BGzd3RBKxGl+zi1G/kkZEJNjrAOQSWjMz7vWsDd8WORSm6zBcy/eIdkC+lKI9+WoC4J+VRQdWXYC4qrfYnf+UXsJrdbAs5v+WKuUi6doKPnMvuZsi6katEebTsOABwWVMGk43n9CSP8AP/5sEi42Lw9b1xiL8/mvMJb93fnH8JfeY1PgtPVsnv6rq/1aYlVVlAYSonmpZgCeCkXmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166336 invoked by uid 111); 16 Sep 2025 20:28:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:28:32 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:28:32 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/13] unraveling the mysteries of color variables
Message-ID: <20250916202832.GA613002@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

On Tue, Sep 16, 2025 at 04:10:37PM -0400, Jeff King wrote:

> The good news is that my digging did uncover two minor bugs, which are
> fixed here in patches 2 and 3. And the series should improve the
> readability of the code by using named constants and appropriate types
> more consistently.

Either counting is hard, or my brain is fried from looking at this color
code. At any rate, the fixes are in patches 3 and 5:

>   [03/13]: grep: don't treat grep_opt.color as a strict bool
>   [05/13]: diff: don't use diff_options.use_color as a strict bool

-Peff
