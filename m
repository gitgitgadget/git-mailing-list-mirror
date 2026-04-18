Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8028850E
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776495019; cv=none; b=K6JvvH0GgcDDD58//RFTkUDbabRflZ0V5OeQRH99QXNUKD8MQ6o7wZ2vgMxufYyysuGCjQ7XF3oWqyiUAy8YoquCQANXa0fHk1fYuqmR3z9/3KRKTnaWjqqEr58zipzrX+ukdU01El+hQTfNQVBXn8fhCg78ZH0vv7iVheDwPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776495019; c=relaxed/simple;
	bh=dvi9I+/IZHJkjG9x6fzIpNTUaqx1MYTH26NidKQEIEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j75qKA7oDz+TSX8yUHmSV53JSmU3YwirxOphMjQm+QxpaJEGkaoKZBz/X/LdL0vXTCU1GUivFftxRo6k3G/qbm6RYRENPw2z2nDKzfLDRkBXa2xT3S+3WduZ3XF+yCfXJj6eHaPvb3wHGOfVhQZd2Cfbt825zJn6YVtBFnmOPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SqTADDS/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SqTADDS/"
Received: (qmail 388455 invoked by uid 106); 18 Apr 2026 06:50:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dvi9I+/IZHJkjG9x6fzIpNTUaqx1MYTH26NidKQEIEY=; b=SqTADDS/D+3QLD9hW4biFZcdQhkPH9A47moTeQwE2OHa3GfDDocMtWhm2sHxqlPdXSUKp5JfRuuyc92boVqHb21OOjZaJPzMnf+LJneYkJwxSDHAsbO9tN21zxSkhXi/an8bawmJ/+XWqk0N1jNKRkJ3eLKm4Uvg3pY7dp5VD/Yfc7sCsGTbJbczJni8yfwckr0C3EIH+U3lWBAvZOvoXVXO+ap5gqeLp0p2QREXyAhYR3sPHPCBxSjCyHi8PUaSAmaJJYjOcmwg35dKaRz6yzT3OBMIWX1Y3s6f0tNzlXGulv1Y9PJSyX2I1Vcf31PQpa1IS2nCxunGnuzq/hWI+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Apr 2026 06:50:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 649766 invoked by uid 111); 18 Apr 2026 06:50:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Apr 2026 02:50:09 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Apr 2026 02:50:09 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <20260418065009.GA2619713@coredump.intra.peff.net>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
 <20260417-b4-pks-tests-with-set-e-v4-12-44d43efdafb1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-12-44d43efdafb1@pks.im>

On Fri, Apr 17, 2026 at 12:50:58PM +0200, Patrick Steinhardt wrote:

> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -15,6 +15,11 @@ fedora-breaking-changes-musl|linux-breaking-changes)
>  	MESONFLAGS="$MESONFLAGS -Drust=enabled"
>  	;;
>  linux-TEST-vars)
> +	# Ubuntu uses Dash by default, but we only enable use of `set -e`
> +	# when using Bash 5+. Ensure that we have at least one CI job that uses
> +	# it.
> +	export TEST_SHELL_PATH=/usr/bin/bash

Thinking on this a little more, it is a shame we cannot easily enable
this for dash. That would hit most CI jobs, but also the local builds of
most developers. And finding problems early and locally often saves a
lot of time versus finding them in CI.

Unfortunately I could not find a way to detect whether we are running
dash at all, let alone a recent version. But what if we let the user
tell us? Something like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f7868c537..a0d07f75fb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -17,9 +17,10 @@
 
 # Enable the use of errexit so that any unexpected failures will cause us to
 # abort tests, even when outside of a specific test case. Note that we only
-# enable this on Bash 5 and newer, as `set -e` has wildly different behaviour
-# across shells. The list of allowed shells may be extended going forward.
-if test "${BASH_VERSINFO:=0}" -ge 5
+# enable this by default on Bash 5 and newer, as `set -e` has wildly different
+# behaviour across shells. If you trust your shell's `set -e` implementation,
+# you can set GIT_TEST_USE_SET_E manually.
+if test "$GIT_TEST_USE_SET_E" = 1 && test "${BASH_VERSINFO:=0}" -ge 5
 then
 	set -e
 fi

And then those of us who want to stick:

  export GIT_TEST_USE_SET_E = 1

in our config.mak can do so, and we could even set it in the ci/ scripts
for all of the ubuntu builds.

-Peff
