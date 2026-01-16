Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE832FA2A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589222; cv=none; b=NrTJujjA8j8orL5PdUTeSqlFxBmRu8rYHPcP5B1XI1myL9bErKmPpTqn6mLJ50L1HNraDIXnblLocqLNt20zT0z2mBfAgiehZpWzEkHED/u/uI8h/vAyYXtBUTbJIJPJGJgos4qFdIjmxdr7H9IcAOu2i9HQYccmCSuzH4P9xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589222; c=relaxed/simple;
	bh=nMVq1yiJMuPf7a3py25NhZDnHgD40xS/1ultgQ+esl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lGpE46MZXLKzg+wFy8qrWGEhJB6rOu8nEdQ29FHX+q3uUvUr+ZwHjYact0mprh0uLpk2+Vb2GwhgdSDbUKOYM6TXagJhPrFmq/O+DV+BqV6n8b3rlIMLjZKFwGumW4WJVwUQuvFxAMv4AQeMOK9zAhIbca7+vGHOFHzHkpd3w/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=j7za7oXe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="j7za7oXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768589218; x=1769194018;
	i=johannes.schindelin@gmx.de;
	bh=/TG/DcG2SRLfbwjfPUcqf3IsG/4cBS0eVk0JwZSV8Sg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j7za7oXeTL7bkmJeNpPdqzZ5tRcay7FP0YEnigq77W9HTxsj2Hu0sOtS/i9gsyi6
	 wTVPGA/5iu5lQsUS6NsNmqRpva03ZoCRHaLuny4Hl7dP7uzhfDxTTcNi2JOXKrwK7
	 Z6j9cWc+nXxPxFRLCyFsYURleeIsHJMALCJ0uPAHTCq2WpdC8oDVWR7gK4ISP3Bfj
	 FVDk0xezag0d4prRpYYRfkLgQp9uW0FaO0+rzo9al7zeDTt/CKxc+WU8iNSXIZEOy
	 SwserfsEDjwqzXZ28HDrvycqEpqf6L7tXRTsgyuqAr2wlCxYDMsrEqB1aL0GrARdX
	 Bx7B3XV+efeNBbZemQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1vYb6S2oQY-00DLJc; Fri, 16
 Jan 2026 19:46:58 +0100
Date: Fri, 16 Jan 2026 19:46:56 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Ondrej Pohorelsky <opohorel@redhat.com>, Patrick Steinhardt <ps@pks.im>, 
    Jeff King <peff@peff.net>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <xmqq3445bn33.fsf@gitster.g>
Message-ID: <bdd25bce-e69a-bc42-b7aa-a171a9cbce02@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com> <aWD2x154F5f-c3pL@pks.im> <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net> <xmqqa4yeblsx.fsf@gitster.g> <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de> <aWnekt4ESo0bKpOT@pks.im> <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com> <xmqq3445bn33.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bF4m865iylAWGBlBxb++DaDW20jINTtCfUKFcdRhVexo8b9tD1T
 oZJOC39LEl7ICn28WY2RK83sEfM+ypzMET18wNjTuBb1Us2VUteElJhmgBnFfpnGK076hcD
 0PF85bpqy3K/LuWPbTHhCIEAbm8SNY54isTcomhd3de5DxD/0Fu1HLFrSwM3Y47QYJ/hLrn
 72x9jXwFjhZmXH3cY4Cew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2CX4upPQCSA=;1pOaNV4lxDMcqEgCYE75nO2U1hz
 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
 kO6PrTru0InkUyb6AFDYqM9n2XIo4
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 16 Jan 2026, Junio C Hamano wrote:

> Ondrej Pohorelsky <opohorel@redhat.com> writes:
>=20
> > Hi, I just want to weight in from the downstream maintainer POV.
> > We've been carrying the patches Johannes has created in Fedora, CentOS
> > and RHEL for at least half a year now.
> > The only change I did is to make the new behavior opt-in by default
> > and give the RHEL customers a release note explaining it.
>=20
> Thanks for your great input.

Well, I have another great input: Git for Windows (and as a consequence,
Microsoft Git) has been shipping with the original version of these
patches for over a year now. There has been not a single report that the
behavior (safe by default) has caused any problem whatsoever. Not one.

> FWIW, I do not think anybody around here is against "opt-in with a note"
> approach at all.

Does what I say not count? Additionally, I think you misinterpreted
Patrick's reply, who pointed out that Git should be safe by default (i.e.
"opt-out").

Let me state quite clearly that even that unfortunate phrasing of an
"opt-in vs opt-out" needs to be reconsidered: It makes it sound as if it
was a choice of all vs nothing. But that's far from the truth!

This patch series not only introduces support for sanitizing the sideband
channel, as should have been the practice from the get-go to make Git
safe. It introduces several levels of sanitizing. And by default, it
passes through the ANSI color sequences, the very thing that was pointed
out as an existing use case.

If you can point me to an existing, legitimate use case where this would
not satisfy both users who wish to be safe as well as the oft-mentioned
existing use cases that play games with the sideband, I am happy to
discuss it further.

> > I think the patches proposed are making sense, and they should be
> > merged. Even having them as opt-in is better than not having them
> > merged at all.
>=20
> I do not think anybody disagrees with this sentiment.  Back when the
> patches originally was discussed on the public list here, nobody was
> against adding it as an _optional_ feature to filter some byte
> sequences out of the end-user's data stream, and the review comments
> that led to the topic marked to be "expecting a reroll", if I recall
> correctly, were all about "why would we make this on by default?"
> Peff's message that reignited the topic this time around is also
> about the same.

Let me challenge you on that. Let me ask you why, when it is a well-known
best practice to santizie untrusted bytes before sending them to a
terminal, Git should do the opposite by default?

Unless I am completely misunderstanding you and by "opt-in", you mean to
opt into the unsafe behavior to pass through all the control characters
without filtering?

> We are still hearing from Dscho that he cannot think of a scenario
> where making this mandatory with opt-out would break existing
> legitimate setup people may have (I am paraphrasing [*]), but I
> think that is aiming in the wrong direction.  It does not matter if
> you consider the approach your users take is "broken by design"; as
> long as it works for them in their (limited) settings, it is a valid
> arrangement to send arbitrary byte sequence over the sideband even
> it happens to include ANSI escapes and other "curiosities".  We have
> in no position to unilaterally break them, telling them that we left
> a way open for them to disable.  That is not how to deliver features.

If this were a feature that is nice to have, I would agree with you that
it is not how to deliver features.

In this instance, we are talking about security, though. ANSI control
sequences have been used to execute successful attacks. If Git allows
remote servers to mislead users to think that Git is asking for their
input, it is unsafe by default. And that's what this patch series tries to
fix. Not by asking users who wish to be safe to read the release notes and
configure a setting. But by having a safe default in the first place.

Ciao,
Johannes

> I strongly suspect that the reason why you made "The only
> change---opt-in by default" is from the same reasoning as above.  Do
> not break end-users' set-up.  As long as it works for them, it is
> not "broken by design" to them, and it is irresponsible to break
> their set-up.
>=20
> But an opt-in way to filter suspicious byte sequences is a good
> thing, as such a mechanism did not exist before.
>=20
> So in short, yes, everybody around here agrees with you that the
> feature as an opt-in is a great addition.
>=20
> [Footnote]
>=20
>  * Here is from <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
>    without my paraphrasing.
>=20
>    """Can you help me understand how these existing use cases (which
>    are not actually in wide-spread use) aren't broken by design, given
>    that they have no chance to ensure that their ANSI sequences go to
>    an actual terminal that can understand those sequences?"""
>=20
>=20
