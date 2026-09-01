Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89C379998
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238995; cv=none; b=L5A6iW5e59UMS28F9vhB/v0pcmQc8kMg2M6AcDgAJeTLoN/ZUurKPLRnAz/q7jzhxib1YMg4ePc8u9sRwcL8G3yezMhK4QcqV93yAM23FEjc/dYkv557bA0mLSEAAb9Zuo/o+ZXQw9060smlV41PANeJqOzcjCHVJ0xDgEV1JPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238995; c=relaxed/simple;
	bh=TAh0obFWtyQW1/Xrd77nY2IHt6x2zinI/3Cxt2Ap0ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik6AhiUGTpa94DPK6R/Kqb0a9Q6wbkHZx19WJ2azp3C8rYJNmX18F8o/FSowT7G4TxrQTACIc7hrZNgoD/ttflEVz9PQ29G1ciyZPy3WZqODNNnWdjSG/d2imRj+gVKyVaAz9LvTglKN5wYPuD+gBDxqAIICZ+bz8IVIn9jba6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DaFYBrqB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DaFYBrqB"
Received: (qmail 6911 invoked by uid 106); 1 Sep 2026 05:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TAh0obFWtyQW1/Xrd77nY2IHt6x2zinI/3Cxt2Ap0ko=; b=DaFYBrqBNtqE7DR5BPW6hXkj04KEnK6ekAjcygNo8IHrBQLYsUIvpNtl6byG6mJD56qeBRyKH5I4XbaTb9iHOXoq+lJfY5/julrXGa8mrfp13L9cPJ7VB+1AoH4Z27PKF5cIaQUU1bjAIGjLeF0hdZYxOxRjM4y5HZPfPV7ybHIKvP8Z7Z0EoYkT1cSGx967I8pCvRTZ5rcv83+sbK3KU1hsUQ1OwSz3CVo6GZgqY7DWbOoMfXBIhVbGMg7AqRtdE9xxQ0aGlIGG9l3+Pz4cSIGKowcRqzFBUOvCVYcIhPN3b5n9qV9EQbqRcP/j5lZjLLyIXXUmj89XxfW1F9UM/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 05:03:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33170 invoked by uid 111); 1 Sep 2026 05:03:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 01:03:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 01:03:11 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com,
	Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v2 0/7] trace2: stop allowing die()
Message-ID: <20260901050311.GA1077240@coredump.intra.peff.net>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <20260827052318.GC176544@coredump.intra.peff.net>
 <a41bdb3b-1fe7-4c1e-9d16-72390d93503b@gmail.com>
 <20260901050129.GB1075462@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901050129.GB1075462@coredump.intra.peff.net>

On Tue, Sep 01, 2026 at 01:01:30AM -0400, Jeff King wrote:

> > I don't have much knowledge of CodeQL, but the following vibe-coded
> > .ql script is able to detect these transitive calls and demonstrate
> > the issue:
> 
> Yeah, I think the whack-a-mole can be solved with static analysis that
> actually understands the complete (possible) call tree. And then you
> wouldn't even really need your banned-die.h, because you'd have the real
> thing.

Just to be clear, I am not opposed to banned-die.h in the meantime if it
is helpful to your goals. The whack-a-mole is not something I would
choose to spend time on, but you are welcome to. ;)

-Peff
