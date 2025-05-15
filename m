Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997401E480
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338940; cv=none; b=QxwMGMZQJggY0FmecmqulIJ+JOtGD5YROEpuu4izx5BkJt0IMOAjfIOX7tft7+1i5NKsiP/bZhtRH6y34vE4IDjC49qDrxDtMceTnQpkGOulFBWDGk4dtwYQAMJU1LRRuY//RVksvvzrr6qIP4Tn53yp6AR4mF3cs5KoA4v/c8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338940; c=relaxed/simple;
	bh=ut4AdmF7ibQaBYVJm73Dxx2H9iiC0rbDZWy5CwQvkJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAbxOvlewD0929XgwIO8DmwdoMd4NwAylN/Y0NQbI+yE9VT5IZ4ytHT9r0rDIGqtiiUkWy3EaL+ONcx2eaKdGQpKZKA0MD2ZVNF0fSyVflnh1Y6IGUprIZoJX7S1zFNbFJWqGaCnQPcopcHhIg7JweuYq+i6/yxJCkTWz3of9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R/+kMT+y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R/+kMT+y"
Received: (qmail 618 invoked by uid 109); 15 May 2025 19:55:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ut4AdmF7ibQaBYVJm73Dxx2H9iiC0rbDZWy5CwQvkJY=; b=R/+kMT+yEULNl2E4i09vCAhsIfzs+lTeWfkt6W1KIbm5N++rUyPqluBk2/O9OydnaauMHApmP4HVYBQSwi1lmzsy1LZrzFjPj4WXfn5IFNlPqjATRZU3y3Bit8dQJARNgK6y0uHDwrKBZc3Ga8TPj2IOwzttagTIivgvDqhJakpTn+ptCZEK/X1ZxyUNLJkI8U1fb5sYkylQPJhyam2PLQHCFduVZ0WaZqZkNvID8w+34FaSsjC9KVGIbdx43Z9O0M8xwquYtYYcKAzp/RrjQ/oaxL9kkUC808d796rG7UByxP5KqpRoxPf4wa2Gk0/9KQ6Zu93D9tzkahj5SoMdYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:55:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30496 invoked by uid 111); 15 May 2025 19:55:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:55:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:55:36 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/11] upload-pack: rename `enum` to reflect the operation
Message-ID: <20250515195536.GE3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <8d712a0ebc8d5161bdc80bdd7f4d05a967c66a09.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d712a0ebc8d5161bdc80bdd7f4d05a967c66a09.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:42PM +0000, Johannes Schindelin via GitGitGadget wrote:

> While 3145ea957d (upload-pack: introduce fetch server command,
> 2018-03-15) added support for the `fetch` command, from the server's
> point of view it is an upload, and hence the `enum` should really be
> called `upload_state` instead of `fetch_state`. Likewise, rename its
> values.
> 
> This also helps unconfuse CodeQL which would otherwise be at sixes or
> sevens about having _two_ non-local definitions of the same `enum` with
> the same values.

It unconfuses me, too. Nice change.

-Peff
