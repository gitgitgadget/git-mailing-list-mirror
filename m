Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD7171CD
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799658; cv=none; b=FW7tOz2FnLtEnyxgFZ7FeI20ZmVjgQ+1M5fAEy1Tki4liND38GvEzRfRE1ZLtjALypq7048bvnWqjaejVC/9cFSQfcgLxG/lOoQlCqvqaR4zc9zt1jhEovlDXvKN5UbGwXm7zb3XwR3OV6Vuu/H+ZovkGZktLyfXIwHQhY1crhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799658; c=relaxed/simple;
	bh=8/sC0dRsJmFpOCaRx/aHT/g1dcop8YhGgeewth8NZZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/ZEtviQ13A6LHtHc93q1qzAK55dGLEYyH3v3YN1B4Tmcmsl05IE8Jio5r+tlYBqWk6P/gD1OSva9G0pTblKtjgJXh/rh2xL0VzonbsxQcNOoUMvNEbQFFD3HzipsgHeoyCSZSTsfr4kzGe+EqkfMlQxjvabSvDr1n6T46rWEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TX26/5ON; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TX26/5ON"
Received: (qmail 94304 invoked by uid 109); 19 Jan 2026 05:14:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8/sC0dRsJmFpOCaRx/aHT/g1dcop8YhGgeewth8NZZw=; b=TX26/5ON8v2zMw3Z6QxET/pNUyKEEloe0P7qTy4PEt6rTx16c8gIVZODpbkE6KXVE6tzLx5k1iyhSti4RmQCjNTuC9IYGJlvjf0uBoQ3aviRUFK1D0WsLZZqfVWB8KuhCfWi+De0gF834dLQIT5e5+8+4Mz9/BtpIZiye4z7W8k9w06MPTBA0AwG7PuPKF5kDJ3dOv4E+HBUBLvZ6PgMoKWkd+b7wIMHW4sGLeBZ5awhsU7slffbFn2KU9f4pHH7YoDW1vm0Cz4Yoz+k7LDitw0u82u9Sa7knjug5AaQsvrxz1KgV8HgjeFQ7RkCmVIYuJz+8Ixt4C5AxXE8kw5pTQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:14:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153777 invoked by uid 111); 19 Jan 2026 05:14:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:14:10 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:14:06 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v26 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260119051406.GA1115353@coredump.intra.peff.net>
References: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
 <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
 <caa761f6153b5b8992c63fea5b5c0fc9b9d444a5.1768766353.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caa761f6153b5b8992c63fea5b5c0fc9b9d444a5.1768766353.git.gitgitgadget@gmail.com>

On Sun, Jan 18, 2026 at 07:59:13PM +0000, Harald Nordgren via GitGitGadget wrote:

> @@ -272,6 +278,7 @@ static void branch_release(struct branch *branch)
>  	free((char *)branch->refname);
>  	free(branch->remote_name);
>  	free(branch->pushremote_name);
> +	free((char *)branch->push_tracking_ref);
>  	merge_clear(branch);
>  }
>  

I don't think this line is right. The push_tracking_ref field is const
because it may or may not be a newly allocated string. In particular,
with push.default=upstream, it will be a copy of the string returned
from branch_get_upstream(), which is covered by the merge_clear() call.
So we'd get a double-free.

This is due to some memory-management hackery in e291c75a95 (remote.c:
add branch_get_push, 2015-05-21). The good news is that not only is it
not too hard to untangle this, but it is closely related to leaks you
are seeing on your topic.

I'll post a series in a moment fixing both.

-Peff
