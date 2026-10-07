Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACE39E185
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413045; cv=none; b=GIpwADI1BvJtsgME385ac6KorBBt6aLWzcTMmUHnL0pz9C2m8A6mV2FyWq8k4MaJdKH26yvJR/3UJXVeEJ8pGd66A0qgAk5NIXiqozqlFcbbf+d4Pr5mQIJwRp2oQRq9eek162IW+vJ+crttq1283K4PLEEZCl0LFfegRIebXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413045; c=relaxed/simple;
	bh=7H0yjDY7XwJfThOEes8o/du50qtVJa5u2Pmv+PvVMnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hY5edm9uFUTrHSQ+3axcUChXPwyzv4fDxKLrpLmEUMtAh4GYVyiotgjKRYggoTergWf9WhUNLfzq7Gr5y8TIoacKqG7ny9KLYaupi1n8LwB+pRjCy3/ZZVE43FPZxnz+dEMg6VyK0dqycgRB0/Nda9XzjKK75s+qOAp5Z48AHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N9yhnQi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VGPP1DjZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N9yhnQi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VGPP1DjZ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7284E1D000D6
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:44:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 07 Oct 2026 18:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791413043; x=1791499443; bh=TXMVkO3y7H
	BejtV+6+xB/PxyUIPYFKnB2kEZIddVsio=; b=N9yhnQi8lq1I3fCX6IVX50ntU+
	qZzRY6DruKGZRtQuJe3xQlvbmVIylpoHk2z9ne4NJ0xUJjlEKNmjAgDK/hqKgXr+
	oy9ab8pbMCEemxsEn+tvpyWPpRTgDIMSBTjfRGu/FwOR+sPuj2u+PgnsuFHl+tUI
	2iYHCtWh3verQgOcHZ8NIGsqhy/DPEgphPADKzqpSD8fSDpr2fiYPjNzgdGcJTHJ
	I+7ZXnZwqGjgO4kLSbeXEZsAmwZUuxcucd3IOLffSst2vRQ8Sng3u/7H1wA7729e
	3/MmTyEjVpwy+y6wpxniWTiu8eaTyfGkRyhTjCzf5cNjKB+TRqBey93Gsdwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791413043; x=1791499443; bh=TXMVkO3y7HBejtV+6+xB/PxyUIPYFKnB2kE
	ZIddVsio=; b=VGPP1DjZ7t8Gq114CF5hBnxzu3+/bmeMOjW6dkAaaB9UkrZtoGX
	pDdg+qQlzfonVoe2mtf2oxAuet6tFE7+553mEtAM13IyDq1eDV46UIEB5Ryc5gnt
	RjzS1NM1WAiMedQfPH2nN44QJQNzv3ttP9W1zsEtsYJNO6u9C14u4O7CRBWAiUOx
	IiocQS8H73V4MI3BVkkv9V0BlRm8TfsOiecfS1eiiDRLeezj+cifAUHnFOX2/mt9
	bDthB23GvH7OpyMTmikzYbiz+onh2TUWZHLyPrOVNvvHxXFouEdFsfx6ruQ6zwgw
	yLalwvNJ0GYNm6CCpP7ZwgtHp9XsiF33eaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791413043; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fIDPOSgHAYHBwnmOPFtautEIUSADrYPZEzJ0OigENKAEqzf
	Xi7bbevMd/xTXAgF7sNIcKFtvf711STaqFj3eUAWFwbVq/w/ZI/tivl2XEiXALOw
	F/dT3nKPIraBdiBm/UDaZnrztJriMvMsYdOqL/CjQHA3h2oVeLjxx23wofRWDz5C
	H7CLh95Zo78KNyddKmc3P9dVAn6GAKqzc2ak9FE0a57ZGCD9PssL7ZrBN9xIeoms
	5htDyigwMVggegjWCe4N+UlxqQ2Dk3NxRA7wOz3UOPPaLJ9Iw6e1/FwxSAQ8XlXp
	16f3wbK3dREEYyHCXut9YHrZBAIYYULOQGGt6YA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hE0OlOrZjvk4ZvxTJ/mTqQZmYxGfgYYOC5cnztHyylk=:7H0yjDY7XwJfThOEes8o/du50qtVJa5u2Pmv+PvVMnk=;
X-ME-Sender: <xms:MsvGatga72tbat8Beq9mVMN0sRLH15XZYHT-tD0-Wi3GIoAU1rq15g>
    <xme:MsvGapd13odmFTepGWqc63jEKLvDQ2mppMWTRGsRmmssvx4ox_833fddtxlcXN9XW
    BgwrvQj-gY7iVjaZRZKRxsZSCDYSObKJeyIapEG5WIQv0SWKqBgpdc>
X-ME-Received: <xmr:MsvGaqfDD0VJlbjqlB4_e4N9FSZez-OQhHXQ1LzCmUpD7wZhdTbPKW8vEebck2rZupsUQS3KfzjG6qGB2d1-KOMvDzzsdUXVgfRd>
X-ME-Proxy-Cause: dmFkZTEg+aOd+jawbsXo/q4IkZIVjf58xdUJbJ1U4gEbyoonNGtVCng6vxmFanaZ5MZgrq
    adf58zeim1/zlVtQ4tyb5cy/7kTbN1w5FteWn/BlcJLRT+XY7O6vYGGFy7BEr/jFbkRo6t
    aAF79vg+uTQT/HM7no+cjnuL+AjNFbYkmt49G16QKDaUN/ieoMOUmaykEbd5nGkJjn023L
    sA0cg80k0rJO1vzzyPy+oerANjPN7SU6WG6d56jdROlKLmTTMSsWxiLztjYqHtNtXTHQik
    xl518i0q+9Mpn3JawwrgdqlJlKXxPJ9AgZADe/SSXhq1Hp2EAlIUntU3s5IuH3KNOvBNTO
    dSWfMBzQRXD9Fq8B6czUJQ2QFIY2fG0TIVNtoKPaM9T9FY2nJ3DsOnU3rBmSuULGZKu8t/
    Iw0NxFzhsP9e4rEb0n25m0oFOdiEL0ndRdYX838+17+GYaqW4cXqmvjqbSGwgWXdURn+6t
    nOzKZy2goaV/1nQ3EkaFPgZvaPW0r+/Sdq4hrwsinH1P/rsve7WPnctkRAQNpd62ZxXNqW
    wqgYgpcWvi0cs9GY9VciA+b3SnwMNNOM8Az2WL0m76jsw4+rd92FSSnoiRnLg0HC51Oaz1
    ddQlaO7gpBOKyOYVYQBdnICj8+nLCtjpOq/QT7dgGU+UW7g2smEaAORPKi4A
X-ME-Proxy: <xmx:M8vGar_bPKrCHEs_QgW-YsQoJ-9Au_b0lcdJro7VZQEAMAz3evp4sQ>
    <xmx:M8vGaumlzMkhxw2Prt_J-G6u0hM5gT15s1YjRln-qnSf--uEHiy7RQ>
    <xmx:M8vGal97j9TcAI5j2d5sq6890l_b5aQr1-WwXMQUdqZJxEaBRoTHxg>
    <xmx:M8vGaknrVfW6trGcnO_LEk4fnaNtcX4dq2m38OTS2enI80tW6mIdPg>
    <xmx:M8vGakGXjvvPzFOY0Qi4mO6eM8J3-vBQtXHM69NFuAYCoGvVEJb4o5vs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 18:44:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI assistance
In-Reply-To: <20261007142954.31761-2-scott@gitbutler.net> (Scott Chacon's
	message of "Wed, 7 Oct 2026 16:29:54 +0200")
References: <20261007142954.31761-1-scott@gitbutler.net>
	<20261007142954.31761-2-scott@gitbutler.net>
Date: Wed, 07 Oct 2026 15:44:01 -0700
Message-ID: <xmqqcxtl3zda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Scott Chacon <scott@gitbutler.net> writes:

> As an example, an OpenAI model was used to help me research, compare and
> craft the appropriate legal language for this policy change to help us
> match the modern, legally reviewed approaches now taken by peer GPL
> projects such as the Linux kernel [1].
>
> [1] https://docs.kernel.org/process/coding-assistants.html

That makes it sound as if this is just as legally sound as what the
kernel project uses.  However, the only assurance we get (unless you
are willing to act as our lawyer, and I do not know if you are one)
is that an OpenAI model produced plausible-sounding utterances.

Indeed, the proposed text seems to instruct developers and reviewers
to do quite different things from the rules I see in the above URL.
Note that in the following, I will be playing devil's advocate for
much of the time, so please accept my apologies in advance if I
sound too skeptical.

> +AI tools may be used to help prepare contributions, including code,
> +tests, documentation, and commit messages. AI assistance does not by
> +itself disqualify a contribution. The same requirements for correctness,
> +maintainability, licensing, and review apply regardless of the tools
> +used.
> +
> +You are responsible for the entire contribution. Before submitting it,
> +review and understand the changes, check factual claims, and perform
> +the testing appropriate to the change. Be prepared to explain your
> +decisions and respond to review comments. Do not pass unreviewed tool
> +output on to reviewers, including in commit messages or mailing list
> +replies. Keep explanations concise and relevant to the change.

It looks, at least to me, that there is not much that can be
meaningfully enforced by reviewers and followed by contributors in
the above text.  It seems to be little more than "the world would be
a wonderful place if everybody behaved this way."

A violation of "concise and relevant" seems to be the recent trend
of much AI-generated slop, so it may be a good suggestion to give
today.  But would we need to update it once the trend of text
generated by AI tools becomes "concise and relevant" nonsense that
merely sounds plausible?  What if an "AI-assisted" contributor lacks
common sense to tell between plausible-sounding nonsense and a
well-written description?  What if reviewers get too many such
"contributions" and cannot allocate enough review bandwidth to sift
good contributions from plausible-sounding nonsense?

> +The <<dco,Developer's Certificate of Origin>> applies unchanged. Only a
> +human can make that certification; an AI tool cannot sign off on your
> +behalf. Consider the origin and licensing of generated material,
> +including any third-party material it reproduces, and comply with
> +applicable license and attribution requirements. A tool's assurance
> +that its output is original or compatible with our license is not a
> +substitute for checking those requirements. If you cannot certify the
> +DCO for a contribution, do not submit it.

Again, this is a good aspiration to have, but I doubt that anyone
can practically certify that the output of an LLM is devoid of
content borrowed from problematic sources under the rule the text
above gives.  Would it not be more useful to help contributors by
defining what not to do more clearly?  Our current text says as much
more directly: you cannot practically certify, so do not send in
AI-generated slop, period.

> +Disclose substantial AI assistance in each affected commit with an
> +`Assisted-by:` trailer naming the tool and, when available, its model
> +or version. For example:
> +
> +....
> +	Assisted-by: ExampleTool version 1.2
> +....

I thought the kernel guidelines instructed us to say only "LLM"
these days, to avoid giving free advertising.  On the other hand,
they ask contributors to also list non-LLM tools, like coccinelle
and clang-tidy, that were used in their machine-assisted
contributions.  I am undecided on the merit of specifying the
exact model and version, but listing non-LLM tools alongside
materials for independent reproduction looks like a good idea.

> +Maintainers may request more explanation, testing, or information about
> +provenance, and may decline contributions they cannot confidently
> +assess.

The text of the kernel guidelines appears to give maintainers more
latitude (cf. https://docs.kernel.org/process/generated-content.html).
They can treat it just like any other contribution, reject it
outright, or choose any approach in between.  The proposed text above
does not account for cases where reviewers simply lack the bandwidth
to even think about what explanation and proof to request, and it
makes it sound as if declining a submission in such a case an unfair
rejection.


