Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29121754B
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895778; cv=none; b=s5YxifLagffsuORluSxtfG6zve3OF6ugQbn4DYp9QG/rrK1RmgDjEsJ7JwH9oA03oktIqAYVx35uvBNT0jkVh2WF6s2D7jXlwj9xgz3F6s0silSgH2exJ5SvWqIPopLwVcYczVDBC5/1o9iemNw71Sx/JqFXtwUMVvRZ4kwB8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895778; c=relaxed/simple;
	bh=Ska5duMWTHAroe3WFa1I41qlNpqSMHtoi1cRsmOqbA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYtS7TA9pM/nIF/QW0yhiLT+e7ESuk7bgl3qL02TQopjmIUjMxMg8n4JgaH8LZ6qfS5osSwHi7cmeQ8SWejQtk25zm8eBlCpqEXuCFhIsDqrN9lX6P/FSp6SVO7kF6yhqUxpYBpjgf09JmAAIOQFxTmZQWuuZL9sZ3GoiKdhc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10842 invoked by uid 109); 12 Apr 2024 04:22:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Apr 2024 04:22:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2544 invoked by uid 111); 12 Apr 2024 04:22:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Apr 2024 00:22:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Apr 2024 00:22:47 -0400
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] ci: also define CXX environment variable
Message-ID: <20240412042247.GA1077925@coredump.intra.peff.net>
References: <cover.1709673020.git.steadmon@google.com>
 <cover.1712858920.git.steadmon@google.com>
 <e55b6912725fa478134c7a67a9e4aeab7dca2c57.1712858920.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e55b6912725fa478134c7a67a9e4aeab7dca2c57.1712858920.git.steadmon@google.com>

On Thu, Apr 11, 2024 at 11:14:24AM -0700, Josh Steadmon wrote:

> In a future commit, we will build the fuzzer executables as part of the
> default 'make all' target, which requires a C++ compiler. If we do not
> explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> lead to incorrect feature detection when CC=clang, since the
> 'detect-compiler' script only looks at CC. Fix the issue by always
> setting CXX to match CC in our CI config.

Since you took my suggestion in patch 2, this "which requires a C++
compiler" is no longer true, is it? And I don't think we'd even look at
the CXX variable at all, since it's now FUZZ_CXX.

So this patch can just be dropped, I'd think.

-Peff
