Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B962C11C3
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529262; cv=none; b=M89ul0eLXz1TippWCpT6OqKhQ7f0AlvDVS2bKvPzdbyJe5/IgapMqv6phsQWMbquNNR4AtUTJLFlQBxDNFXUFQ2FaT1eqZHnux8fuDsYRjur72TrGopvqJwMNn1+5RmZgYnlUvVU75IuLZ3ubRRT+wjs45zu7ecIOTKlw9VAifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529262; c=relaxed/simple;
	bh=UGStrXOQ4GjBnLQsISnBlqSXUzbiVGq6bfn47SC9nWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyo/FJgZU2UB6herprJeGZGB1cBhrKy63p7bDR7/IitX/nZCPIknTjtekiUdGL2WIeg9oFr7u1N5XEBr7JXDdMzq7hFC+BuFbAhst3M+eRgP8W7utLek1jiBXujR4laW/tdGuNyvzB1Dadlme/9t566xmAXE2fwIWr4u4jNfmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FSONtKhm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FSONtKhm"
Received: (qmail 43764 invoked by uid 109); 10 Sep 2025 18:34:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=UGStrXOQ4GjBnLQsISnBlqSXUzbiVGq6bfn47SC9nWk=; b=FSONtKhmn52n2q/8cnz4x+NyzZhg0tLb2sUkhyhGj7z5NsjfM2tECpvxBBX2lTxd0KZJm19RzsZ4w+/fQq+U8ORhJVkpI3n8jeHh4e5RyFNmLixnQ6TP1+uBKlNu4zUV5tbnY1NEG6/8/WwJ2KEyStg6Z6iJAFGVPeSHDKlC1tKVIqfu5J8kctWkutLMZYvM0nrpZ/VGhLjk8A9x/yUKvzWv28hPfpENm6MhjAJ2+LOTO7QxsdFqnQ8gT99y4mTELDiCxCK4fv4TmHKoOyqnmtyjpMSNSe31XLySq6zG79RAJ3QSjHqbfnCCORhPnjKc0mMnmUwsEK2KJ7oImYUk4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Sep 2025 18:34:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71428 invoked by uid 111); 10 Sep 2025 18:34:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Sep 2025 14:34:19 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Sep 2025 14:34:18 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250910183418.GA1157772@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>

On Wed, Sep 10, 2025 at 07:58:32PM +0200, Kristoffer Haugsbakk wrote:

> > So we just need to loop again when it told us that it found an alias (it
> > is tempting to just continue in the loop body, but that would miss the
> > case of a deprecated alias that resolves to another deprecated alias).
> 
> Yeah, that’s subtle.
> 
> Do you think this should be a test case?  I guess it doesn’t hurt.

Yeah, probably would be easy to add. We need two deprecated command
names, but it looks like we do have that at this point. :)

> > Anyway, I believe that is correct and solves the leak issue (because
> > handle_alias() does the lookup and takes care of cleanup itself).
> 
> Thanks again.  My local test suite passes.  (Except
> `t5801-remote-helpers.sh` which never works for me.)

I sometimes see failures there because I've checked out and built an old
version which creates git-remote-testgit as a built script. That was
later moved into t/t5801 via 5afb2ce4cd (remote-testgit: move it into
the support directory for t5801, 2019-04-12). But if you have an old
built copy lying around in the project root, then "git fetch" will find
that old version first (because it prepends the root GIT_EXEC_PATH to
PATH when it runs). So we run the old version, which may or may not
support what the more modern test needs.

And deleting "git-remote-testgit" (or just running "git clean") makes it
go away.

That may or may not be your problem, of course. ;)

-Peff
