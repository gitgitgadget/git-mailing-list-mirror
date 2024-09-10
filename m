Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576F208A5
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950684; cv=none; b=i5KPYwYxs1PEzpqLGObt8HAu7hGEXEWhAlUy8k86TqcDheznG8+04UD5nP35A274YmlDrPoPWYqPRex+Fy00jArbd7ul389EMEu3/j8V1V4xrG5Y4DE3gr4gINxVNe0dpZjoWhrSwpOm+MOSWt0vORz7CSjOLf5TdEjOmUFZefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950684; c=relaxed/simple;
	bh=fiVh0prUQKuatUn/0ey6UTb0FBQ/1+mKvRva1HbJekI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl36cmVEDmSdCWr5X2ZkGMqIsX01E0AWBBlhvwEM+aYgb55wcWEJCGA/NAalCOOBk158X/gZuKu4bUU7VwUnWKR3y1uWPlqiXJMCubkbUUCJbhsbvngAIZNj7G2mj+4J2Qp9Reh/9rp8lCaaSvQ6ZRr4Yg5Dbi3PPzqRvmaZ9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3383 invoked by uid 109); 10 Sep 2024 06:44:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 06:44:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29148 invoked by uid 111); 10 Sep 2024 06:44:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 02:44:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 02:44:41 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] make chainlint output more newcomer-friendly
Message-ID: <20240910064441.GE1459778@coredump.intra.peff.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240910041013.68948-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910041013.68948-1-ericsunshine@charter.net>

On Tue, Sep 10, 2024 at 12:10:10AM -0400, Eric Sunshine wrote:

> Changes since v1:
> 
> * new patch [1/3] -- motivated by Junio's observation[2] about
>   availability of structured problem information -- takes advantage of
>   that information directly rather than post-processing "?!...?!"
>   sequences in the output stream
> 
> * old patch [2/2] (now [3/3]) which drops "?!" decorations when emitting
>   colored output to a terminal partially justified the change by
>   claiming that the new "ERR" (or "ERR:") prefix is a good "needle" for
>   a terminal's search feature, thus the noisy "?!" is no longer needed;
>   however, I realized that "ERR" (or "ERR:") is, in fact, an awful
>   needle since the string "err" (or "err:") is quite likely to
>   legitimately appear in source text, hence I changed the prefix to
>   "LINT:" (with the colon since Patrick found lack of colon
>   confusing[3])
> 
> * rewrote commit messages based upon feedback from Junio[2,4]
> 
> * dropped an unused argument from the call to format_problem() which was
>   an artifact used briefly during development of v1

Very nice. I think the "LINT:" prefix does a good job of standing out,
after spot-checking the output of a few of the tests.

I read through the commits themselves and didn't have any suggestions.

-Peff
