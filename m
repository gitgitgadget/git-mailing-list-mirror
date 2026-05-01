Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D519DF55
	for <git@vger.kernel.org>; Fri,  1 May 2026 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777618069; cv=none; b=bx+6QSsZ3GKTw5XA5hOl/8EkkR68i99Sd9OQuGKcPrDCm4+4oAWcy01AomwyCJhs+w5FsTzilG3RQsMfRkWG9AdhxcWR6ejQITH7Aq9b/D4r12GEWiogoJJ4Gx9XdAdG+gTgJ0UVROj8UQkwbfn0EATXS9TRpfmytEObzArvlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777618069; c=relaxed/simple;
	bh=x/DATjRrHDdZL6wR6wPRSTM0pT3zXtxMhB8hJ/AMES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS1dWy/IbO73IwZk4S+jxEiQH3uWu6GhBKOqJgjz29LP9Wg5s1olYZ0nN24w4k06/28krDD1Qj35fL5oUCyrn4CFVFBkcgoYmg34VZOLatrk1R4eKT6rshbvrv71hhWYu8ouFYkhP3m5qHEPZefTQNFal+pk4N5iURwJus3SgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NmOUQCqU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NmOUQCqU"
Received: (qmail 2312 invoked by uid 106); 1 May 2026 06:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=x/DATjRrHDdZL6wR6wPRSTM0pT3zXtxMhB8hJ/AMES0=; b=NmOUQCqUCw76ii/XjYF7yU3t5nBKiQR4RxAq8eT/CmEb0mnIFnjcTqgXf8H7t3kvw23b5t220nKGhgLGI124jtMocczezWOikWAD7esKkAWdVkMlTOVMoBkAMdamr66JNdRuHNhxKzZk6MXiZr3oknWRlu4luul4WnEX962IcSgA1oD0KwWlMJ+qqRi4puaohuaNDnS7UuMQnpgPYUZZtGrZS7qNrfiIkWTpM2KscdPPjW2PviZebFVz2+4QUtr+5/FpSeKODbZzeT/A+8+VFG1bv7crYOmmqyGO9Tqdis6K8qolN7MblVKfMQ8mH90C7CLJ76v0xhMBuuEI99DKBQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 May 2026 06:47:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3902 invoked by uid 111); 1 May 2026 06:47:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2026 02:47:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 May 2026 02:47:46 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] t5564: use a short path for the SOCKS proxy socket
Message-ID: <20260501064746.GC2038915@coredump.intra.peff.net>
References: <pull.2100.git.1777299669889.gitgitgadget@gmail.com>
 <pull.2100.v2.git.1777450974159.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2100.v2.git.1777450974159.gitgitgadget@gmail.com>

On Wed, Apr 29, 2026 at 08:22:54AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The SOCKS proxy test introduced in 0ca365c2ed4 (http: do not ignore
> proxy path, 2024-08-02) creates a Unix domain socket in
> `$TRASH_DIRECTORY`. When the trash directory path is long (e.g.
> when running from a deeply nested worktree), the socket path can
> exceed the 108-character limit for `struct sockaddr_un.sun_path` on
> Linux, causing the test to fail with "Path length ... is longer
> than maximum supported length (108)".
> 
> We cannot work around this using the chdir trick our own socket code
> employs, because both sides of the connection are outside our control:
> the socket is created by socks4-proxy.pl via Perl's IO::Socket::UNIX,
> and the client side is libcurl.
> 
> Use `mktemp -d` to create a unique temporary directory with a short
> path, and place the socket inside it. This avoids collisions between
> concurrent test runs (e.g. `--stress`) and tmpdir-race vulnerabilities
> that a static `/tmp` path would be susceptible to.

Thanks, this looks great to me (and thank you for fleshing out the
explanation in the commit message, too).

-Peff
