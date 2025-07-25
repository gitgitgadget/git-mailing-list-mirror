Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C523C397
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442135; cv=none; b=WW3mxAf3R1hBTZOwpkiuWh/1dd8zgkIdqzOjvuoh/L7YAtBkZldqp03DZA68SpSY/Y+sVOVUa66xBqdUmW7ITAYQ6wyVIMNMloGPXlhFBDXag3giZaSeoyan9VmK60I6nwl+AlIEiFLVB9bWgkV6YaoyQqDyrzUJf3lA6c9SS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442135; c=relaxed/simple;
	bh=cnDn0cQB5z1qeM/OJdYVrxMSubZPFDa1AWcFDbuaqUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz/u7qnrJAXWIqXzQ5oHqdRwSJzlMCvZvEX+5rP8GY6ewDoFQuj+TGI95CrvcrHHw3nYlpj3+vMjs6tGWlVTZV/M9aJWBp9mzBLlKo8M+4lw9QTVavKyBNAWMlB+3uYNiEhYDpiZMNvte8/AtBsT8L1f5j7TuuuJZN3r7f/bQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LvQU+7pn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LvQU+7pn"
Received: (qmail 26213 invoked by uid 109); 25 Jul 2025 11:15:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cnDn0cQB5z1qeM/OJdYVrxMSubZPFDa1AWcFDbuaqUA=; b=LvQU+7pno/XhrZhQfigD5UNSjMXgYdjZYCBAilZp/oThZ7SGGCTQ4CQPet5Zbty96Cu7MvFMuYu+QmYHnZSDTXGzA9V2+x+haMCxt8iGFkjCVchbtk3cs4dc1H66W3bf97Y77oCj7dzTYOY87GwbFzHaHfjR3Os/YJmLb2UjfYLtD3OSOAKD2m9MVJWQ/TYPJ10oh8qJZbS2QK7SPmOkSugUJ1BRq2CXJZ3Q2h4w+fHG1tVl0x4VqFUeeIqhXCZcKKKpWmUDp79LpuEJdZMDrly6aLgWYZomFKncxexANXiq/k4p7u7KSDQ9C995yhdYoKlgcX3ipLPYz/yzx+FNqQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 11:15:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21193 invoked by uid 111); 25 Jul 2025 11:15:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 07:15:31 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 07:15:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] test-delta: simplify delta helper with strbuf and
 better cleanup
Message-ID: <20250725111530.GA3015021@coredump.intra.peff.net>
References: <20250724093327.2261615-1-lhywkd22@gmail.com>
 <xmqqjz3xh34c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz3xh34c.fsf@gitster.g>

On Thu, Jul 24, 2025 at 11:09:55AM -0700, Junio C Hamano wrote:

> OK.  Except for the whitespace breakage, I didn't spot anything
> glaringly wrong in the patch.  Looking good.

Hmm. This looks like just a squash of the 3-patch series I sent earlier?

(Sorry, it was in another part of the thread and you weren't on the cc).

If we are going to go in this direction, I'd prefer to leave it split
into the 3 more obvious patches with explanations.

-Peff
