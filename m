Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1825771
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783901228; cv=none; b=r6r+xiFoiD/rv9rjO+ay1rfKISPdSYVRav9S6brAn5lJyZjraTY/0qXiQ2J97WMSfm0hZ/A6fnqcYK+24tCFHLoyLwcOc6+lhwXL9NYTnNP5eKGzttAgdCwvjIVmic0BsBnaZ/f//33TnKTFG0/JXVwFSPZwJ3C1mGJiGTEVS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783901228; c=relaxed/simple;
	bh=yQ/4Vzm9rY4ya4K1FttqMY1WLXSYB7aOMVcFJu7CE40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLbvOJCsgdGQSFOnYKOXiM7lrOur6cfswXNxVn72DRUawFFKiNX0kdtMlLKpKn1maeD2s4wYsO4wV7xGl9Gx6pWtCPyyeU/4al3ZN+W30q5IitVG9KxSRShQ8dv83O4z9aM/1OePYJFQBjWxICSeCLDfEdL42EDJnN8iZFgGv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v0fdLWZ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHC0h4dd; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v0fdLWZ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHC0h4dd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57EA47A0049;
	Sun, 12 Jul 2026 20:07:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 12 Jul 2026 20:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783901226; x=1783987626; bh=yo4VZY87Ph
	GF/jahU/+fMFXrWQaEkbX69RYuSfDR8RQ=; b=v0fdLWZ4ShKS+Krn4Mx2AP0paz
	sD0iZoegLNEaSn2Hpfiov9d/iPbENDNcE50KquHdwJXd6rR4NYtA7qC8HKaVJJh1
	VqCGvI062ePSPb0KRwBki1CNnmywkRCbI5ycs98ROE1gXUyEUXe3qcl+N6B4eh+E
	ZoZGFhLU9meFz2qxJpSRIrSZg/5No5bmmv0mOovcG84fcIPgTIHTM5q6ogphu5M7
	ubQCIq398QL4Vwv/lYvxH/OjG+a1BQL5Gd1qEW5V9gkDN/Y5hmvRmhGNADnAVqbJ
	eNGl1pqs+BYEYhaISTItG3EV+hly2jOaSYK2Wisswim3+YB1UfS1vVqrkpgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783901226; x=1783987626; bh=yo4VZY87PhGF/jahU/+fMFXrWQaEkbX69RY
	uSfDR8RQ=; b=CHC0h4ddZLOowzYoS/ThgbRSuwUULnWj1Mp1IRYucQnpbw0/Y0x
	f0lamTK33MtGER3irVzYSI9DZCUDeQfrhd8d8SecoBJQb12H2pOrCS2POretdwL2
	7iwhcs804KgtnRySviV1hocM9ryrLjGC+I8HxLCegTsDqHs+nyWmhyfbQ9T2takG
	x+Uy5Gka9+YTlbDlIEh5ZxED2H6oMrXpZ4h1JMbvBpa5OPNgbpKDQNTs/jdcvOnD
	2UvyDJoJj+B9msxsTaOPGhGIJ3u7c3P7RVC8uEOCcL8pqfcAIwXQveAokcHhHhtr
	wdUQsKuJcusXSY/zhweW6VAydzZSejKbgFw==
X-ME-Sender: <xms:KixUak07H9MplgaJ2avNWbRqQTY4INE9nRUIvhKbDG2U6CRhOWaRwA>
    <xme:KixUamhlYRZn3z6iC1J8qdR42Drez2NopeMXwc2TYr1OXqabc_zK5ipBX9W27HLqC
    qTEY3GhcsJMRq1YaqwHZEu2JekNndYe1f7nSnVU6Vodiro6Ghy5SA>
X-ME-Received: <xmr:KixUaqSl8ehFj5-MPPk3g_X-ycZe_p48Cf9wMP-JRgbYcxWkd5Lo5zwEky2Ib0leAoawe3CFo54BAiOclnSR9SZY5_VsawYolGWfTAc>
X-ME-Proxy-Cause: dmFkZTEdV7/RaBVtlcuXJH0XNnDmQscPw8wZ4tN84XYgSU+FT2Rqkgm1R1NkHaYJgPtTt5
    zlF1cmAO+B2ZPdMAK/BZEiYXpLDo0iQOOF2Zm71+1zslHCuWVXTOr/HpjKt9c2HPCZLnA4
    YFfMT9JA4S2ypOU9FWHrF3s71qTe6d3HNc2pclzlEbpL5eqyLUFqjGOkeXQQk9LfT/no/z
    lJIOGffXZr5+kGKLNo4aYOBaCWGuZCgphhvGrBYfMst0NFS82yccXnDZvw8Og9y+/yHiJ6
    yVcaB7+AQCW0JDIMdE1rxrlAe6oalnSyA7ohrOyRzBDFu7vibg5OHys4cBbvIzEGokVeDo
    lKjdnrkeW2ntfrMUKGwJnUrwiyA1VWSil9PHlvVmNAoquK6Wn8fTZqp4QUThg6I6A3ORIq
    4bC1++LFm0ijvDjMRUGnF8A7AhSR1ptcXskR4sBN46SPPv4SCYtYbAok6iyNQme5/FWMPf
    N2DQpC6eFmbZ5nXNM+JLcw843zFwp7H4aCD3Lhf9f9Vchxcg4MWmF8YKD8YapKOnNPyPwO
    5rm5WWAgD/5xLahDq3g6pXjqrQC0wHTDRiQ1kDWNeHlrZGRmF3zqLs/w18TE/xyUvCkZhl
    UdvGP8r9lBJG34VRe7Ry2Hu1kgJ0iSzy5VS1ISMKUDH310+ZSQERqYLzXFSg
X-ME-Proxy: <xmx:KixUanhirx34wrB9u2OTt23l6UTIcwUgrayswXLO2mk2cjmlT0S1Cg>
    <xmx:KixUaq44JndnC0GNvRWX3Q0jCwnoaPAHrBBWsa7Lxgvk8zfHBReEIA>
    <xmx:KixUakD3K0GlOAiVICrN7YScuo63pz8ZbOHz9Blm0R5ulc5rSZ9KAQ>
    <xmx:KixUahbQrhwVPg4b2yIfZozfHoE_ntkOL5lUGtl8XAjkUnY6P_ltsw>
    <xmx:KixUaqjh1JOXUcp8tWWwVyPl1T5QbOALCAnC7prMLe0U3aIe9QYpSPD9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 20:07:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
In-Reply-To: <CAC2QwmL05MbVS=jtk7ARj6jJUT461Ws7BcYqUAUrywvDDXjJqg@mail.gmail.com>
	(Michael Montalbo's message of "Sun, 12 Jul 2026 13:26:43 -0700")
References: <20260711192650.2417665-1-gitster@pobox.com>
	<20260711192650.2417665-2-gitster@pobox.com>
	<CAC2QwmL05MbVS=jtk7ARj6jJUT461Ws7BcYqUAUrywvDDXjJqg@mail.gmail.com>
Date: Sun, 12 Jul 2026 17:07:04 -0700
Message-ID: <xmqqcxwr3g7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> I think collapsing the "Formatting and Style Guidelines" section with
> the above would be clearer than having a separate section.

Thanks for pointing it out; I tend to agree.

Before rerolling the series in entirety, here is what I have in my
editor buffer right now, after attempting to move the formatting and
styles into the main description.

I haven't checked if the formatting works as AsciiDoc yet, though.

--- >8 ---
[[meaningful-message]]
==== Structure of a Commit Message

1. Title:
   The first line of the commit log message is the title that lets
   readers of `git log --oneline` quickly understand what area the
   commit touches and what problem it addresses.

   - Keep it short (50 characters is the soft limit).
   - Skip the full stop at the end.
   - Prefix the subject with the modified area followed by a colon
     and a space (e.g., "area: subject").  The area is typically a
     filename or identifier (e.g., `doc:`, `transport:`, `t5601:`).
     Run `git log --no-merges` on target files to see conventions.
   - Do not capitalize the first word after the "area:" prefix
     unless there is a specific reason (e.g., `HEAD` is always in
     uppercase).  For example, use "doc: clarify...", not "doc:
     Clarify...".

2. Body:
   A well-structured commit message body typically follows a
   three-part flow: Observation, Solution Design, and
   Implementation.

   - Leave a blank line between the title and the body.
   - Wrap lines in the body of the commit log message to around 70
     columns.
   - The body of the log message must be self-contained.  Do not
     rely on external URLs (including mailing list archives) as the
     sole explanation.  Summarize the relevant points of external
     material so that readers can understand the change with the log
     message alone.

[[present-tense]]
3. Observation (The Status Quo):
   Explain the problem you are solving with your change by
   describing what is wrong with the current code *without* your
   change.

   - As this part is always about the current state by convention,
     words like "currently" are unnecessary.
   - Write this problem statement in the present tense (e.g., "The
     code does X when given input Y", not "The code did X").

4. Solution Design (The Approach):
   Explain the approach you took, justify how it solves the problem,
   and describe why you chose the particular design over other
   alternatives.

   - Focus on describing _why_, not _how_ (e.g., "The code does X
     when given input Y, but it should do Z _because_...").
   - If your change only addresses a subset of a larger problem
     (e.g., it handles directories but not files because ...),
     explain this limitation.  This helps future developers
     understand the boundaries of your work and whether it can be
     safely extended.
   - If your change resolves design or viability concerns raised by
     the community during prior review rounds, ensure the message
     records the resolution, explaining why the chosen approach was
     accepted over alternatives.

[[imperative-mood]]
5. Implementation (The Execution):
   Finally, describe how the changes are implemented.

   - Write this in the imperative mood (e.g., "Make xyzzy do frotz",
     not "This patch makes xyzzy do..." or "I changed xyzzy..."), as
     if you are instructing an agent to make changes to the
     codebase.
   - You do not have to repeat everything readers can discern from
     the patch text.  Highlight the key points in your
     implementation.
