Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44F21D5AC
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719070; cv=none; b=qG6rm2h1XQWTsegTMPRGqOwirUcyQRnFjSu//xB6COwgMynO86l6dWp41kqOjcyzMC1AzBMk4WCj20FBtp0DjuaKBYLxOrj0qmFWpqiXnbqVIrJm+qugc1ZLjDiRzsCAiw7q2hQfSGxQNwSl07uAOhpOevXDzKqeF0or9vcaf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719070; c=relaxed/simple;
	bh=52+K0VY3i1LS21FdfjsDyis7NSZHpmA+f1JfjOmYMnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc+wF52G9rnfbKpVV56+MDHnyiJzfB8UqPz658KHUC+txexvyHl4F0/ikMYSE8rbDNtWxfh6xc1OTi6Cv1r95bjF1BU2s8aMPHuQeFI43gnvJSOpdxAlRqOu6dQ9IZwAsK1ivZNi62m+3KUAC0ZhBbnarQGxpj2C+BVNnbY0Jko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OUhR5dar; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OUhR5dar"
Received: (qmail 16552 invoked by uid 109); 20 Dec 2024 18:24:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=52+K0VY3i1LS21FdfjsDyis7NSZHpmA+f1JfjOmYMnY=; b=OUhR5darOp+jnSntCEg8cJWkZ00RD/WkNwvDgj01fnCnwFolzl+b0C+pH2SZJitRxRm+05FBrzORM0VCPFQEv7Qkghv/BU9TcYE3CC+DrRN9p1t3u9XKp8AZerZL1+Z+ZdoTewFg6sqnJe83BN0pyYiOe8Q5eeJT3iqkoBwqYcUxKKdPdMFLaUFm2knGS3oGiPMhKp87GNompJv1kjtaEdTliIB5JlDOTdPYqdf76oHGKL0GaIpxtSPJ9mpUk4z7U954rQmz2bU4fxYwtDPPYt8Joinia7GV7YmF2U+v0Xgo9MN54F0PtRF8OVd9K/Jadvose8dOzCCTkfVXjSzK/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 18:24:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20793 invoked by uid 111); 20 Dec 2024 18:24:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 13:24:27 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 13:24:27 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <20241220182427.GA213015@coredump.intra.peff.net>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
 <20241220175136.GA203033@coredump.intra.peff.net>
 <Z2WxIRcV0LOvx6OX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2WxIRcV0LOvx6OX@pks.im>

On Fri, Dec 20, 2024 at 07:02:09PM +0100, Patrick Steinhardt wrote:

> > Is there a case you found that doesn't work?
> 
> Yes:
> 
>     $ make GIT-VERSION-FILE GIT_VERSION=foo
>     GIT_VERSION=foo
>     make: 'GIT-VERSION-FILE' is up to date.
>     $ cat GIT-VERSION-FILE
>     GIT_VERSION=foo
> 
>     # And now run without GIT_VERSION set.
>     make: 'GIT-VERSION-FILE' is up to date.
>     GIT_VERSION=foo
> 
> So the value remains "sticky" in this case. And that is true whenever
> you don't set GIT_VERSION at all, we always stick with what is currently
> in that file.

Ah, right. Even though we have a recipe to build it, and make knows it
must be built (because it depends on FORCE), make will read it (and all
includes) first before executing any rules.

Something like this seems to work:

diff --git a/Makefile b/Makefile
index 788f6ee172..0eb08d98f4 100644
--- a/Makefile
+++ b/Makefile
@@ -596,7 +596,12 @@ GIT-VERSION-FILE: FORCE
 	$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" GIT-VERSION-FILE.in $@ && \
 	NEW=$$(cat $@ 2>/dev/null || :) && \
 	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
+# Never include it on the first read-through, only after make has tried to
+# refresh includes. We do not want the old values to pollute our new run of the
+# rule above.
+ifdef MAKE_RESTARTS
 -include GIT-VERSION-FILE
+endif
 
 # Set our default configuration.
 #


But I don't know if there are any gotchas (I did not even know about
MAKE_RESTARTS until digging in the docs looking for a solution here).
If we can stop including it as a Makefile snippet entirely, I think that
is easier to reason about.

-Peff
