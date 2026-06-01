Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD77218EBA
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291996; cv=none; b=YP+Ux7fD1DaM5fuM7mt0ZIUgp4v/P8oVjIJTfdbRI6gWYp8TjfzMbibuDtE5gUOos1da7VBOcfy9g452B2FrB/84gLR9Y+F/BW+dIR+QP9rkay7KyC58MIfLHDvzavOZtTAg2KS8WfPvqCzltSfFA2cNdwwF53uQIwuFNLTe36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291996; c=relaxed/simple;
	bh=a7a9zWD0TqhveFuGgNl5rnPZdme1BzRWjrT/18uNpiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tn2ZpOiwE286GgMyXGlI8MYOGLf/r6taOg3st6J5qzccTnPSyeDC0vDHjFJHPtjls72Wi7wnP727byWYO9TQvx4hT/bJO3dqfO3m+YDZgceWyQLXuMW3mhD4wmHEedO6f/72UsTOTm1ObEgyxa9hFQUclfwvsAGnntCNsCpJ47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P7GHb0L7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDP90flu; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P7GHb0L7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDP90flu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A13757A0197;
	Mon,  1 Jun 2026 01:33:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 01:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780291994; x=1780378394; bh=iCp6BXKL78
	X8EFR89sUmmogP/LlCf7LHe34QvUSAVhg=; b=P7GHb0L7rK4toKEVqLenSi69Ta
	vrFfcfT5GdUnPgGLSZiStxG6YR4phByb+vm3qRDro18CicatyMlOV9Cofe77Kb8L
	hYgbf3iDW6PU2kNHj1L/o/Qd0fPFcsbyKPrSptTCta9sgfIqAGIU9A7WRHkLFB7o
	MGUWPn26WkgteOf+8MZgjXSDuD/VAgBX7Hy23dzzfEWcA5qRX+bAbQicZqOr/pQx
	6poJznD2afidglWCJPDWqGY4LmLWGLwvs4EXliv8EXve/eb8kZNzPyW0S/4BYMon
	agwjQs6DHfSodNQdhzCjhACUixY2FheISfMDgzM/6XbtakG90h2PsFtNf6MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780291994; x=1780378394; bh=iCp6BXKL78X8EFR89sUmmogP/LlCf7LHe34
	QvUSAVhg=; b=cDP90fluOq68FQYcIL0cGBxE2/cy65xjJOX6+XwnQprReNzhT2i
	in1GKkcsMBnLSvDyG+Qf+HLGoPPOdc0+nR+YZOQJkzzk45KoOCA6V5CHbEXlt6so
	IBbzzGNZHlFs+Qczg7Bx4CHx+cAMDzPadR6NWx/RwUu5VZGowrOebASYFILXEzhk
	V5CoBGjlLAMVnlHuhR3WHGx4GEAhaseoZm7A/Pj9fxWgoEWzxVlsC2uzxwYTjkBS
	sjT6p72tWgJhOK5pilmTRK349mxPudnQw9DRKac1V3414mxBLpLsloeOxpR21sOR
	kZKjsDd6VCW4vbqf/qM4fTvDM54BTOy1+vw==
X-ME-Sender: <xms:mhkdarDhl2BqLDfSYnbQmHmUPebC9exEpOBgRgnsnqEQjJgJXa0sXw>
    <xme:mhkdaoj43aaYRw-OhSnkoTTrs3ePboJNAuizhJPGoINmrXzB56YBqo8ke_roTTzaE
    6ufnLwS-S270cgwprQ2EHL-EJy4ulKcVeKd_mrPgrkna6mvc1nb>
X-ME-Received: <xmr:mhkdarkPF_XPAB5Bvvj-PcxKukVcNgf6UCv9xppMmcfGEjXbNs9vhcoxjBQ1Be_6mhBmQgMARk8l8pL54XOWMOKG9KYmSPNAEkWm>
X-ME-Proxy-Cause: dmFkZTEt8eTmzjG+y/4lmWryUv7xCSa8oBI4ivlIqGA2SBd1/mDgjpQRMlcAUvy8je+5EF
    yy8Us/hLbefAfJPClVPi0IOfPyH1h7efwlLh1wtvlZiIwoObllta8qB0dJhmci+vhxqrLq
    b563YIOWTho2wYOhTfXj3MJxOdscpewp7CKZ+LRktMjKtlJtp5rJHBrQnl/Vk29tWiR+Ea
    1mmcCxcx5NPC8u1WsgSZxH5kEtcVmDYRJsCcLGju0aZif5JkbLisjF7jxS3FDmzZ4w3h12
    1fZCyHjB+AYJ03crZFZE5Hy4Jd4CP9Ul+8eQhhrCPU5FdFi2lBmu2/xiLWiDMBXr7j+uK9
    V3u2nHVWlKPTr7zlCGigu/Afk2cgnmLLSGSKac9EOZWnBu4nvJfD0CbHmXMiqd+30zRbm3
    fZttnAmkDx7zryT1/l3PBHDFebnu5IreINOCAd0CCAmxoh2L1OZ+fpi/CvdkdIBBz3JVuy
    UZ7xVjV6XSQDzJ6Y6o2si46gEFG4Sq+3Yg0as00EAxuD2FI4JCO7VUmM4am+bfOFVjUWCZ
    rBw5Nitwqe1yz/L+hUQqrCwwvZJBrgIdiAKZcEZFuIx02hJg87osaeRx7Mqk0RjShIs6uL
    vAdb6I/ri/J3l8cLibgAQSqp1XU8L7sKty4vdSgYvIglj9jIaDs7NSnhAz/g
X-ME-Proxy: <xmx:mhkdasr1ndghHzyBhK_fEGoRur3gVBkJIPY_g2Xkx0ZUUyHL4VSjMA>
    <xmx:mhkdasFYjpXtOZRtDQ4W19l4nlKfgv3rnw19PwfOx39Pq7xkL84MWg>
    <xmx:mhkdagx-2w9MRVGPWIHP6q9O9zmRn2xiL4pCfpAsbKA2r7tQzPntxg>
    <xmx:mhkdapqGrhbaifA2aaQzTbon2N-76uopOLysxQ5y3cOfhTWvEoZYSw>
    <xmx:mhkdanOAqO73aJBu2Jea1eqIadXclDQwOR6_A5FkuNXkyXmUBvr_UQdh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 01:33:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Wesley Schwengle <wesleys@opperschaap.net>,  Git maillinglist
 <git@vger.kernel.org>
Subject: Re: git hook question
In-Reply-To: <20260529052141.GA1099450@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 29 May 2026 01:21:41 -0400")
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
	<20260529052141.GA1099450@coredump.intra.peff.net>
Date: Mon, 01 Jun 2026 14:33:13 +0900
Message-ID: <xmqqcxyaakpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't think so; the command is expected to handle (or ignore) the
> arguments as appropriate.

We should also caution that the command is expected to handle not
just the arguments but its standard input.  Not reading any and
exiting may be a no-no for some hooks.

And unlike command line arguments, there is no handy way to say "I
do not care what the input is" (other than putting "cat >/dev/null;" 
in front of what you really want to do, that is).
