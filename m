Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0D1DF74F
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899627; cv=none; b=ex0dc1HlwuHtK+UGNIneVoLX5t5/zcxVIeJKIFbjVTaJp9oFHNlmkOtbpKOA6hIpkHSZs1hAmqKN5ZTNbrfJC+KvlaYqa70Cn+v4SvHAxMW6WUhGJM2o15CqdBKR1p/SG9hprM0BME+1ZekrQT4UfNyGIP4dysOfLwSyuQ1puMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899627; c=relaxed/simple;
	bh=7MYUcA9L94Ro16oeDZGWt5EN7nJzUO2GjK8Cnm196EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1ICD5WLdzofnYKHcmrXrjwx0bt8K9hWH+K73z8t1U9YdwPRVJee5TEaTldxbD+bWhPUnvqZ4bnoJcHFRig3zGJ80GQ0zxEu00RG+XfqlT3chEljBOL2OfcnzPvvSVAC6gAtLI+OkeSj0k2uGv17R1TnTV7cf6UowDxFV6lrHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QfVpg7rX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDQR22qM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QfVpg7rX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDQR22qM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 667481D000D0;
	Mon,  8 Jun 2026 02:20:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Jun 2026 02:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780899624; x=1780986024; bh=QXkjJTR67B
	6ytcibG3HDsrAAJNihUSMc6dyCesUEYXY=; b=QfVpg7rXaoKK7hhDwhCg/nsBCb
	XAU+B35ksTYIxr0BUb1WcoDfEvlbNCCG5lvfPLIPeClgzr1wEF26dao+M5l3W5FU
	pUnTcSn52oFtnkcWeGhOTpBYuMKpSabN68qmQfaOTr3eOx8SlxeEuJea/PXUK0d5
	H7b8YGVBQqULa1GVSLljnmOu96WqHnHeVtC8eyzUjp+evKEIRB4iAqXOjQfFlPyv
	sJh4X8siU8b+7C1MahxnWiEKkYiTopPJFqo7xznw6jUU1nQKB2WGgXgmjUa0BzFL
	tYfOyrfa8G7fS2YHyfJ72DhPgqGcoe5Fb4IJur2KEFI4pRvoo5NRVWqCIdFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780899624; x=1780986024; bh=QXkjJTR67B6ytcibG3HDsrAAJNihUSMc6dy
	CesUEYXY=; b=lDQR22qMxww6OcNO6yBVJy1gYC+5HLOSkYg+6LvwKi2+cyrx65F
	PFXjyFPZqzmsO928le94g1zoRAEcq1QWhYfXVlzX9HBYrXXtFnJv2Ni3i3mYu40R
	hc45uyf2CLwQQyg5WjzWwqNtEvA8G/TSkpxpuJkR22K5XP1N8Gs1Klse+8QXoQVZ
	f4SSAMPH6AhgLj57m5JLgVq46ETE7jeFBBEK8mUBZvDjmYj7FCo6u3ko9Ce6gDLJ
	ZA/VUDoGVQ57YfCP4yRFiGG0j2Yevc8O76JClqooxaRNLXsVljoA1eMibSdZNaRZ
	gceuMNMi7xOVhKlzxKWaoxoP/Q44gWr5t2g==
X-ME-Sender: <xms:J18maotYBEk6TyQWAAE7f9S6t4jHQpxwq9l3S6ej_9TO0cZZE5myMA>
    <xme:J18mauwEeAw5NEaSjOebASCadaCx794LYcjGAsklP3-UFGZNnrEZmE_f1MuBC4VWl
    CL3VbCaGCUjbhKxaqMpW9G1wc-ehWeQXZ6xNM3hZrYbGdPIhdPzYg>
X-ME-Received: <xmr:J18marDvi7uRUzIiwHaPiJkfDYP7J9SA0ybTfvGnaD92unLNayBF4JaGJFSXpPO3V9obTL-7SndaeEsIcJOFFV9PzJNu-LvJe6qtFqxntA>
X-ME-Proxy-Cause: dmFkZTFx1bCSbcq9VNmT4W9f1ZGPp6Z6v0RpbZK0gHHO0xIxVekfIYi7qoxi6lDK6h7hXL
    kqBdk1BpMB1wjBt1Xq8CgpghJ9wVeH9qCpscQXv+gIfB+oP0n4k392+dkXewCUQLY5VATe
    lkt8vNwWfYkR36ABEPRxGEa2hQMNsnGD4hgDYN6mCg19ZVykn7/xuKe4wfN7d/Tb66MUze
    /Qdglrog/tKMOESIKo1YZoLTZ6PzULsLu5iy3nJVgbp8PuemEA2RHO7T7c5Zogwz8mVXOO
    /HZIpWbVAAobPmltMX2TAilokmmsScaNpx0qMitsHzRBuJ4l277MOj2sahfAnWihg/geXy
    iRII/l3PswqP8pHKDFsZiGSu8Skhvm+yPERsRxTvDMBedXlcdIDU53aOOvMKWMHon3IIYQ
    UEP88oyVYtBCqdnRM/iZG2CdzdSSnxs8eJwfputM9A9Xa/nnkWmn0C0xP2U3z+R5yf/myH
    NdYy/KlyhwK9jP3h2QozztVbY3byhYYoz/GzFsAIRwGA701VwekIdXotoKQ2N4n8jBCP6k
    /Tge+sZTggyKOP+NvS8uYvzQu13hTfcyrt1EGVxp+Yxkwd1XoyuaN3Lwt4MwZO23driNHN
    bvnVk0hBWRuMAzhHixmnOip0kxhEUFElnNaJJPaCziFsfXxuSB/Qfd+EqV6w
X-ME-Proxy: <xmx:J18masdMXbk69A6IZFs60fAgjD1T5NHyThZxkNZExqBQYQ-KXOFoRA>
    <xmx:J18malnxMCeoobSmAidRDcNF19d7D-UH7NuUABpGFlQ8rbjI_0kqvg>
    <xmx:J18majG9hlOjTDskwZho5WJJu34_X-cUPzlYQ8fFsVxypVgAi57Tdg>
    <xmx:J18mat5vyHBRGAtpwmFLnk_uR7ptutofrxz6DCgDOKXaf8HHlp5xtA>
    <xmx:KF8mahD0iv4JSFZGaOobBJ3PkaamArX-SqghMUCD3ErPj6kQx6yT5MNn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:20:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 161739b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:20:20 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:20:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: gitster@pobox.com, git@vger.kernel.org, asedeno@mit.edu,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v2] compat/posix.h: enable UNUSED warning messages for
 Clang
Message-ID: <aiZfIc8k-9Et25g6@pks.im>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
 <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <aiKnqlI7WdcskDAs@pks.im>
 <aiK4BR86cuq5bmCe@four.local>
 <aiLNqQgiQPlviB5X@pks.im>
 <aiLxCWp8Bv-KQoLf@four.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLxCWp8Bv-KQoLf@four.local>

On Fri, Jun 05, 2026 at 05:53:45PM +0200, Dominik Loidolt wrote:
> On Fri, Jun 05, 2026 at 03:22:49PM +0200, Patrick Steinhardt wrote:
> > I was wondering about that, too. The question that I have is whether
> > there's any particular reason why the check was written that way. So in
> > the best case we'd do some digging into the history to figure out why
> > this looks the way it looks like.
> 
> I think the current bit-shift style introduced by 89c855ed3c (git-compat-util.h:
> implement a different ARRAY_SIZE macro for for safely deriving the size of
> array, 2015-04-30) was inherited from glibc [0].
> 
> I found that NetBSD [1] has long used the more explicit comparison form instead
> of the bit-shift style, and other BSDs seem to do the same. So there is at
> least established precedent for writing the version check that way. :-)
> 
> I see no obvious reason to prefer the bit-shift style today.

Thanks for digging!

I don't really see a reason to keep the bitshift style, either. It could
make a difference if it was ever evaluated at runtime, as we would
evaluate the arguments multiple times with youur version. But all of the
instances we have are evaluated at compile time anwyay, so that doesn't
matter much to us.

I'll leave it up to you whether you want to send another iteration of
this patch series that also adapts the preexisting callsite to use the
new style.

Thanks!

Patrick
