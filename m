Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643633F361
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774662269; cv=none; b=WFjDiI8eIg7544cxDDoPgtQhO98NKwMlaZM6Y8oveG9zI8vDXFxgIHGlRqRjGw/zpndpOHXTH+dGjHcgNEMO89rzwYyYnZQj2/5R4FghU/FIddRzbUXdggxvWCvadmlClPyOkbycFCafq1lUgzssT6i7SaHZWFcnBV0xRRphafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774662269; c=relaxed/simple;
	bh=E/tRiDDKhuzIdMYnPgov2xbRWfKhn/7ekKiKcHbX4Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4yn2t0wEmJo6LEZzpwuLS+RQvin2nz0WinPT+ITXmgmiIVGGSy2mWk+1tCykjqRYc5tzXXrB/9/bwTaMxLdf4S/04p84Pj4VboJkRL6GEYNk9gsvB3mlr2BkpVGtIjsus4PeRAtD+p8X8BHAszSQPrmlup7i9KEeTzz9k5tm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PBURgKd3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PBURgKd3"
Received: (qmail 173440 invoked by uid 106); 28 Mar 2026 01:44:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=E/tRiDDKhuzIdMYnPgov2xbRWfKhn/7ekKiKcHbX4Aw=; b=PBURgKd3Ai/SB2r1TDfNoDn5hKa4Nn4GIrGVQzgAVJgX4GN2k2PpedKGsNpebr8j/w7zIsLIYOsSO30Pae61BUwSKmMILpIteMzPhg32EYhSqaoYHbisnwmK6v1I0SUDYJ86g7w/JlNi7B1KjMlYn+qmhGu/tiRjiJChyk0wOSlEy0YlKilNszkmv0kZjdjhZGE1TnUJd52610Cl4L1Ip0AftnkXVIBhZu/VnoGTHIaESMZ8KKGci8jCSuyxMffof3DwT+oX9a/lAZH/+wC+chgeXn2B2w2644Ntr2kS3z48j2jlEezDPUf13UmFup41Cs0Sw5LOO+sEBbXMOvMNUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Mar 2026 01:44:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 243609 invoked by uid 111); 28 Mar 2026 01:44:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2026 21:44:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Mar 2026 21:44:26 -0400
From: Jeff King <peff@peff.net>
To: Wesley <wesleys@opperschaap.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] connect: Rename name to command in connect_git()
Message-ID: <20260328014426.GA621762@coredump.intra.peff.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-2-wesleys@opperschaap.net>
 <20260327213308.GA598533@coredump.intra.peff.net>
 <3e9d8d71-9595-4151-8133-300b89b3b7f8@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e9d8d71-9595-4151-8133-300b89b3b7f8@opperschaap.net>

On Fri, Mar 27, 2026 at 08:58:22PM -0400, Wesley wrote:

> > So probably "op" or "type" is a more accurate description. This
> > conceptually ought to be an enum, too, since it is selecting from a
> > limited set of operations we know about.
> 
> That's a fair take on it, "name" is really a not the best name for this
> variable. I think "op" covers what you describe here best, it reflects also
> why I named it command. When you check what is sent via ssh, it looks like
> the command:
> 
>    ssh -o SendEnv=GIT_PROTOCOL git@gitlab.com git-upload-pack
> 'waterkip/git.git'

Right, but it's necessarily what is sent via ssh. E.g.:

  $ GIT_TRACE=1 git ls-remote example.com:repo.git
  [...]
  trace: start_command: /usr/bin/ssh -o SendEnv=GIT_PROTOCOL example.com 'git-upload-pack '\''repo.git'\'''

  $ GIT_TRACE=1 git ls-remote --upload-pack=foobar example.com:repo.git
  [...]
  trace: start_command: /usr/bin/ssh -o SendEnv=GIT_PROTOCOL example.com 'foobar '\''repo.git'\'''

That's why I think "command" is actively misleading, because between
"prog" and "command" it is not clear which one is going to be sent to
the remote.

-Peff
