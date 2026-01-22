Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451C824BD
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084985; cv=none; b=lOVPxSIG8dSbSOGXNQuRk+sS3kxtp40ltPemnhzQhbY7QEMOJRsta7UnXTuvLXcRTcTXQ+ii/MZOfsjImCJukA42Y5AQgpfrRjnTe+rHX0HZMBzkZTzZYx2OT3m77wIJzFfEO293+Kt2yNoN0vc/nWSywWd0dfKRQZLoC9R1rnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084985; c=relaxed/simple;
	bh=Dqr0Q/sk/sVkNb+sDBdZsHIeTBWDNFj6KpV/CRy5qZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hANcyNbGLQTeYhmngdZWXb4XuwjsqLDFBG6NUaQaZfnWRq2pUAiwU6bfr2046DZSnZvWlaLpOkFs7hrSGbqZWhfPDaaG3C3GsocE8UtkdedXKShn53edkmUhZtrPwaL/5MBfXd4JNwWYIl5wfU7IRFhBht2ibTK+sRXXP1JGsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=llmIVTsj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="llmIVTsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769084959; x=1769689759;
	i=johannes.schindelin@gmx.de;
	bh=wwpskCiW7A/xqax7y2uv4oKkTAscFFNpZzn6fKacj/k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=llmIVTsjTT+cZCUxeT72nNNW/wDVyjORgQjMw7/mJLwu6bS5wgE1npDTVHimiMdK
	 g6e2PUHokp0+3q5rqbehAwPPEjvRJjdK0yezFRx+PowQ3eFWv/OCqus/6agcMjxL3
	 R1fNgrRgz60BaEpLCQiEXpRQpq+UqbqcXIqrHMDV521fkOh9lZ51IH9uuZblSQnjX
	 o4wWS3iRdYodmNz+oO/0VSUoE4YYz6v/B0d8VtyA8lYt1drxOOGb8icxKcXoeJUtQ
	 pArhNlhuSfVCVkBdah1yeBkX61w1voSziJS4oxtW3+NjiABg/8uFKhktgz85S+wpw
	 10Nn3vUSBE9f6NhwFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.108]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1vgwvn3pMH-0058lG; Thu, 22
 Jan 2026 13:29:18 +0100
Date: Thu, 22 Jan 2026 13:29:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Patrick Steinhardt <ps@pks.im>, Ondrej Pohorelsky <opohorel@redhat.com>, 
    Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <xmqqa4y81ag8.fsf@gitster.g>
Message-ID: <a51f9433-e82f-bc2c-5fc4-f8ae95a859f8@gmx.de>
References: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com> <aWD2x154F5f-c3pL@pks.im> <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net> <20260115211448.GF1053259@coredump.intra.peff.net> <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de> <aWnekt4ESo0bKpOT@pks.im> <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com> <xmqq3445bn33.fsf@gitster.g> <aW3bSYCIPMhJT1mf@pks.im> <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
 <xmqqa4y81ag8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P008PrnfhTqdLrEdqMYr0Yd/7PaFErNmxlOw/SZHg7Vk9UvVkPn
 NJrIqirlmgQEkKEMhSvYmKW6Mm59/wtrw6PYaqpI75LO5t+7YLpsSb55Ma74yJHqUq9Dxhu
 pOb/CluiTb3n7KMC6n39yfybK11R8FWHKII/K65iHRJJQch9OjoEmdw8J19AjMsLQMvA4t3
 pzGfMWhAsYngNA58VSzeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fOfySGU+JOI=;b23Ir/7J0/bjO+cBHaYnTEr6WCf
 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

Hi Junio,

I disagree with making sideband sanitization opt-in or weakening it based
on a "trusted remote" heuristic. In this context, emitting untrusted bytes
to a terminal without proper sanitization is a security-relevant bug;
safe-by-default should be the baseline.

On Tue, 20 Jan 2026, Junio C Hamano wrote:

> [...] forcing this filtering on everybody [...]  unless it is enabled by
> default. [...]

If the goal is to mitigate terminal escape injection from
remote-controlled output, then shipping it disabled by default does not
mitigate the default case. Most users will not discover or enable a
hardening knob until after an incident.

> Two levels of defaults [...]  trusted daily remotes vs new remotes.
> [...]

I don't think we can safely infer "trusted enough to write to my terminal"
from "I fetch from there often". A previously-trusted remote can be
compromised, after all. Which means that a trust-based default is a
foot-gun: it creates a path where users believe they're protected while
the program is intentionally passing through attacker-controlled escape
sequences.

Besides, allowing "colorful output from their hooks" _is already allowed
by default_ in the proposed patch series. The config variable
`sideband.allowControlCharacters` isn't an "all or nothing" setting, after
all.

> [...] you shouldn't have to manually configure "I accept colors from
> them". [...]

Color is already a narrowly-scoped exception. Cursor movement / erase
sequences are in a different category because they can rewrite prior
output and hide what actually happened. If we want to allow them, it
should remain explicit opt-in on the client, not something we enable
automatically based on repository state.

If the argument is "setting `sideband.allowControlCharacters` to `color`
by default breaks common workflows on established remotes",
can you point to a concrete repro (hook snippet + terminal + escape
sequences relied on) or a public example? Without that, I don't think we
should bias the default toward pass-through of higher-risk sequences.

Absent such evidence, the best way to proceed is to keep sanitization
enabled by default for sideband output (modulo color), with the clearly
documented escape hatch for users who knowingly want additional sequences.
If there is a strong need for per-remote behavior, there is
`sideband.<url>.allowControlCharacters`, as per v3), i.e. users _do_ have
that option _after_ stating that they trust that particular remote not to
wreak havoc with their terminal.

Also keep in mind that this patch series' scope is the sideband channel;
The fact that SSH-based transports patch through `stderr` (completely
side-stepping sideband) is out of scope.

Ciao,
Johannes

P.S.: Junio: if we continue to discuss "opt-in"/"opt-out", I think we
need to be more explicit about which behavior we mean. We now have multiple
levels in `sideband.allowControlCharacters` (default allows color;
`cursor`, `erase`, `false` and `true` allow more fine-grained levels).

If the proposal is "full pass-through of all control characters is
opt-in", or "full sanitizing of all control characters is opt-in", I
whole-heartedly agree: That is already opt-in via setting
`sideband.allowControlCharacters` to `false` or `true`, respectively.

If the proposal is "keep the historical behavior (verbatim sideband
payload, no sanitization) as the default, and make sanitization opt-in", I
am firmly opposed: This makes the sideband payload remote-controlled; A
security hardening that is off by default will not protect the default
user population.

Can you confirm which of these two meanings you intend when you say
"opt-in" here? Once that's clarified, we can discuss whether the default
should remain at "color-only" (today's default) with explicit opt-in for
riskier sequences, or whether you're arguing for no filtering at all by
default.
