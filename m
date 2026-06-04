Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEF3D525E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554087; cv=none; b=DaW5glJgQMIaHxXD/6rrn745CS7C6M55QPbO1dvrwI9Qc90wWcPX3tsPiYPSSWbTads0OPYaeY414z6VBiy5f9AfH/YkX+0ZeqFyHscD/o4yhMbq8fX7xtg0oqxU0MmgDW1czi4PzyC9qAso2PbrKPXui2UmQUU5zx4vg2y9MU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554087; c=relaxed/simple;
	bh=eTjcSHEElp93GJKMRUAu7eQlultTsZWTU2Yqd/1EhJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etgDpKcpy7quXy23uFlnX4a9yeShYqeW0ir1JZCS6U0ziV9HI8KyIxp2PvBehjVK/q1P7DuggxRvThl9OmTr4eZYIqFWNy09QiSuXyNvJgX/xgH5zXMEJZpSKVD/C1rZw+AFkXLOtKgBfqpNNaJIMpTnLeqjbEZOZixDaudDuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZCndmemS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZCndmemS"
Received: (qmail 43262 invoked by uid 106); 4 Jun 2026 06:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eTjcSHEElp93GJKMRUAu7eQlultTsZWTU2Yqd/1EhJ0=; b=ZCndmemSOdO1LFs93ULspwg4XSs9sMxyFDXoyoTH6oCBn+JzVhg1MOgDsgZvqA4bHuGp3vnyzPprQVcPuZKRGV78efBHEtE/g6KgQkV5Fd2pg6fuefmbVENu7aFlqROzbJmNgLJLy6fXiESNzf3eZpqAy531sXCAvZ5SQaZLVoCF+Yvq4WnddtcLu/BCsap74jEim+KuCsuc8QJA/NJ1CtgCaHx+/GEJwow1VfV2+QlPMqjVlp2VBU6REVY8oauIV8Pqc/flIaZBPavgPOAfllVOK7gSuTmqw783mh6MQcbxJS3y9wg0GHf735+XaiFELofR2/FeAPkIhWthGgTzvw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Jun 2026 06:21:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 110425 invoked by uid 111); 4 Jun 2026 06:21:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Jun 2026 02:21:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Jun 2026 02:21:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #02)
Message-ID: <20260604062122.GB3194609@coredump.intra.peff.net>
References: <xmqq8q8vowvt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8q8vowvt.fsf@gitster.g>

On Thu, Jun 04, 2026 at 11:35:50AM +0900, Junio C Hamano wrote:

> * ps/t7527-fix-tap-output (2026-06-02) 4 commits
>  - t: let prove fail when parsing invalid TAP output
>  - t/lib-git-p4: silence output when killing p4d and its watchdog
>  - t/test-lib: silence EBUSY errors on Windows during test cleanup
>  - t7527: fix broken TAP output
> 
>  A recent regression in t7527 that broke TAP output has been fixed,
>  some other test noise that also broke TAP output has been silenced,
>  and 'prove' is now configured to fail on invalid TAP output to
>  prevent future regressions.
> 
>  Expecting a (small and hopefully final) reroll.
>  cf. <xmqqtsrlw09t.fsf@gitster.g>
>  source: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>

I guess this is the source of several CI failures on jch/seen that look
like:

    Test Summary Report
    -------------------
    t7810-grep.sh                                    (Wstat: 0 Tests: 264 Failed: 0)
    Parse errors: Unknown TAP token: "/bin/sh: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)"

This happens in the dockerized jobs whose images presumably have a very
minimal locale setup. I don't know if this is a sign that the tests have
never been doing quite what we expect on those platforms, or if it's
simply noise that is now being caught.

-Peff
