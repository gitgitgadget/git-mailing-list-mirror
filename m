Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2B79CD
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774212573; cv=none; b=qtwrFqL7ve37ZdUYELRaDyg1WuXSvGJDS8rHF4r97ZVhv3TkkdmxqgmQ8K1u4zpl/ppwaSLvsvdgeiF/a9LgoXG2OVy7C92qdzCdnh7B8UTarER0gJNM2vqPX4mABhhZRZzsPNMRZCE7veXPjswmsjpxYd7M9V+Q1mPvAa7yaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774212573; c=relaxed/simple;
	bh=kjWrfl06d75hwZWrjjPxEcTED6+xRJd4KovhEewG4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc5dxVD6myA3hr2A/CGOgQzGsjgcz0Gzsats+cGRScn39Sh0EcCtwnIhu43A7g+ImP+abDIX3q9TNRsHgUQ1e8pTJBvkWLm5IRTXIv0cNGeXsU+Gz1/LBUbBMooLYXeBLz4cSdqo88nuELf/IIgOyIeG8jkH9oIQ4Mw6C/c8kLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GawMATnq; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GawMATnq"
Received: (qmail 106236 invoked by uid 106); 22 Mar 2026 20:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kjWrfl06d75hwZWrjjPxEcTED6+xRJd4KovhEewG4bc=; b=GawMATnqqT+u1luxpOabj3bH4phS4LqDhGwxyNC9uvHgu5VXUj9wqzHqsRddnPQRxaY65HfeyPgArc7ZwSRX1GoESES+mnqS4T16wyzx8199XsjxImWTafC6Cor930gIusEkdL8mINPnxFDU7r/W2zcea0Dp93q8MXKlyZsrEoy7RUb09744bg/Q0xornITHzriaFV7gQevlf2mRboxhJKmrx6gudnl8g3XWYelrPwTU4C/Y5hoWSIFNzgoFhwasaieYWKKodadf25DYQ4kFJylY/x1RV25Li1VAzVQDEwLw+J8rcS3NATCNVm0PkEkvpTGpMQpBR3f7smubaw0v0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 20:49:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 139831 invoked by uid 111); 22 Mar 2026 20:49:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2026 16:49:31 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 22 Mar 2026 16:49:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #08)
Message-ID: <20260322204930.GC2047044@coredump.intra.peff.net>
References: <xmqq1phc9x98.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1phc9x98.fsf@gitster.g>

On Sat, Mar 21, 2026 at 11:46:59PM -0700, Junio C Hamano wrote:

> * jk/diff-highlight-more (2026-03-19) 9 commits
>  - diff-highlight: fetch all config with one process
>  - diff-highlight: allow module callers to pass in color config
>  - diff-highlight: test color config
>  - diff-highlight: use test_decode_color in tests
>  - t: add matching negative attributes to test_decode_color
>  - diff-highlight: check diff-highlight exit status in tests
>  - diff-highlight: drop perl version dependency back to 5.8
>  - diff-highlight: mention build instructions
>  - Merge branch 'jk/diff-highlight-identical-pairs' into jk/diff-highlight-more
>  (this branch uses jk/diff-highlight-identical-pairs.)
> 
>  Various updates to contrib/diff-highlight, including documentation
>  updates, test improvements, and color configuration handling.
> 
>  Will merge to 'next'.
>  source: <20260320004138.GA3653623@coredump.intra.peff.net>

Hold off on this one, please. There's a missing &&-connector in the
test. I'll send out a re-roll, but I'm waiting for a response to the
reviewer before doing so (to make sure I am not missing anything more).

-Peff
