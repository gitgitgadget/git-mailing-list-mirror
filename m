Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFC1BC39
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199726; cv=none; b=u/WKpRbpJON+CJSwkux1TR7HH6CH9W8izREUj20hWsaMABE7ENUp8FlCJtC52Myg2mnAsAS5ofJ5kp+I126QlDFtovH1rHAQ9psRwxgLj8tt9amR2/mTkSu565hbB4jj23mVRPqPLHaX1G/+CNd7TY5biUT7r1r68oypF8Dye3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199726; c=relaxed/simple;
	bh=986PQUP7QIPYxRKk/vtD+4jxykAPNTtUKap8im4LqJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh7gfm6srpZgdo6tV8J8Dmb1leSV55XOqtQGqTzxkdGNhsqusUalynkjc5qHDtBqLqwzCon0q7P4+oc2/IrxKTQcnoT2H+kpwTiTo53kgCkf8JlCQ+PZ5lEYrBGLYCdCtDcE64YnUrXn+VfYCZtYdoUoP4/jLDDi3O1HpqzsdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24445 invoked by uid 109); 17 Jul 2024 07:02:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 07:02:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19169 invoked by uid 111); 17 Jul 2024 07:02:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 03:02:01 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 03:02:03 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by
 default
Message-ID: <20240717070203.GH547635@coredump.intra.peff.net>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
 <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
 <fe8cd0d1-e451-43d0-b033-11bbb6d1ed56@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe8cd0d1-e451-43d0-b033-11bbb6d1ed56@gmail.com>

On Thu, Jul 11, 2024 at 11:10:51PM +0900, Rubén Justo wrote:

> As we currently describe in t/README, it can happen that:
> 
>     Some tests run "git" (or "test-tool" etc.) without properly checking
>     the exit code, or git will invoke itself and fail to ferry the
>     abort() exit code to the original caller.
> 
> Therefore, GIT_TEST_SANITIZE_LEAK_LOG=true is needed to be set to
> capture all memory leaks triggered by our tests.
> 
> It seems unnecessary to force users to remember this option, as
> forgetting it could lead to missed memory leaks.
> 
> We could solve the problem by making it "true" by default, but that
> might suggest we think "false" makes sense, which isn't the case.
> 
> Therefore, the best approach is to remove the option entirely while
> maintaining the capability to detect memory leaks in blind spots of our
> tests.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> 
> This iteration mainly reduces the noise introduced in the previous
> iteration.

Thanks, this one looks good to me.

-Peff
