Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048428C009
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789012938; cv=none; b=HG8IldVJTNlWD+M2cAVhOfkSXAXu0gUN3R1JisL1RE7pK7jJwN7n4kwIeFkbCQ4owwqJKWuvf2AqOKB9X8S2BMdoNazIRHBBQfCs+GZ+vSrsprzrAc1GHonGeIz+Hut6DVibFs0TidET1v31TgGSm+TlUB6dW66RAojFkkFDY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789012938; c=relaxed/simple;
	bh=Yb//1YWe/ld2Euh4wXrNmExWVtqL9KNoRlckEAAcuVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/NCApaZQXk587xcJxIW72mkbYHIQhR5lIgYdx75JKBSzzfg/v+SgY5kSIk6vnXZ8noAbpxJ9iM8VhfMC4WmmnZgBFAw48LjMawVHzRbgEjMbcdvKcq4djb1qoNLcSRGTBGLScxZf9x+iEynE96/pDdH8l6iLdxJvQfffwo84h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OE9pQkvM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OE9pQkvM"
Received: (qmail 29934 invoked by uid 106); 10 Sep 2026 04:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Yb//1YWe/ld2Euh4wXrNmExWVtqL9KNoRlckEAAcuVc=; b=OE9pQkvMAapq3nqrg5SkuxDZSRl7K5limrQCX+0EyvMPoivLC4b0QirH/h15w4hKtblfMDABq16Ws7Wgb+lZjkb8YqcnzgwtcPw6+MYV5WTmb2svLep6mYInHR3I3JzO0zwgBq/clMl48TkrEbdH94U+nPOrQSCEdz31M/1T/mCG8C3mRHNzEcB1q3uIbqLtYKCEvRZWFCPxtDSfSanW2nrBOM+GnpNMWj2z/2IOyC763a/wOlXpnROL8JWetSoVLkMoj4DpKOi+4K1LKrvzb/PaxrcGKqGeLRvrYzWorMGG/U3tzF4mVgsa7r/t/4Ty1+SU7ca1kZFg5tNH+A/JZA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 04:02:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 150687 invoked by uid 111); 10 Sep 2026 04:02:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 00:02:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 00:02:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v9 0/4] hook: introduce the receive-report hook
Message-ID: <20260910040214.GA240960@coredump.intra.peff.net>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
 <aqF0mbWgYU5rMR-f@pks.im>
 <xmqqh5jys5mx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5jys5mx.fsf@gitster.g>

On Wed, Sep 09, 2026 at 10:20:54AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Sep 09, 2026 at 04:51:35PM +0200, Karthik Nayak wrote:
> >> Changes in v9:
> >> - Fix a bug where we were causing a BUG() when no report was requested.
> >>   It is perfectly valid for clients to skip the report and we shouldn't
> >>   fail when they do so. Thanks Junio!
> >
> > It's curious that nothing has failed because of this. Are we lacking
> > tests here?
> 
> The "send-pack" client we have will ask for report if the server
> side advertises report-status or report-status-v2 capabilities, and
> there is no way to disable it nor there is no practical need to give
> a way to do so, so unless we are willing to write a custom client,
> or a configuration to disable server capability advertisement, such
> a test is a bit impractical to write.

You can do it with a t/interop test, but we don't have any that push.
This triggers the BUG() when HEAD is master plus the v8 patches:

diff --git a/t/interop/i5800-push.sh b/t/interop/i5800-push.sh
new file mode 100755
index 0000000000..b3035b555a
--- /dev/null
+++ b/t/interop/i5800-push.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+VERSION_A=.
+VERSION_B=v1.0.0
+MAKE_OPTS_B="NO_OPENSSL=TooOld"
+
+test_description='push to/from older client'
+. ./interop-lib.sh
+
+test_expect_success "create repo to be served by $VERSION_A" '
+	git.a init --bare dst.git
+'
+
+test_expect_success 'create commit in client' '
+	git.b init-db &&
+	echo content >file &&
+	git.b add file &&
+	git.b commit -m foo
+'
+
+test_expect_success "push with $VERSION_B" '
+	git.b push --exec="git.a receive-pack" \
+		dst.git HEAD:refs/heads/foo &&
+	echo foo >expect &&
+	git.a -C dst.git log -1 --format=%s foo >actual &&
+	test_cmp expect actual
+'
+
+test_done


Ironically the test succeeds despite the BUG(), because the client isn't
expecting a status report, so it happily returns while the server side
dies.

I think the interop suite is probably more trouble than its worth,
though. Nobody really runs it, and there are all kinds of hidden gotchas
in trying to build old versions of Git. So this is more of a fun answer
than a serious suggestion to add to the series.

-Peff
