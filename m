Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC827586E
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576873; cv=none; b=KD1dyDdmO/REBHiLSwnBt0T7cAcuk9T0ehpl6VNMOq3hSPws7WRYi0yJsEuFmou/O5YwO6yWqHy33xcka1C+4AE3qInfM0+mFnTJ1qXdUk40RlZ3gW7wama3wuWjvhOeiPjt9pjlKe7smNOTxG/ZzeI+ZqzseXL/wNylm1mEVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576873; c=relaxed/simple;
	bh=2WZO1Z7MTRM9qGHNyCh67LX+HViAKV+7LdJvbnUSago=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KtDGCcFu8UtklN9s+ATgY+sHiRZnJWaiwiPfmVCL3G9Qe61UDis/AGrFp/q2yUXRetPxUTzWD88tgLkegNhHlClcIe3t3AB+YpR9wcrtqr+T8hVs1AqH/WXmjkYZUpqJbQjLtZX0AxTcJ/f+FbgmWqZ1D+/U2MHLgNiFo0jzCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ARZXVHhy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+MOD0ui; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARZXVHhy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+MOD0ui"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 69EB61D0000A;
	Fri, 16 Jan 2026 10:21:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 10:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768576867; x=1768663267; bh=nNXt/m9bo4
	PAzDW2/YWU9yDCxuBdFpBnNyHUsHaRisA=; b=ARZXVHhy16C5/AiRlWAbmQYW0+
	BvKBVyTOhwv9LeWngG+y7+MC1eKGhD1YQyjE7PYiGLkPToGGLP3nnh7SakfwEs7U
	X/O9M2Pq3+aPx2VkVGq2L1dai609w+XM53H0tZmPkkeMrZ7nZ2D/XCcQEStZ76iK
	sZ4MXHjUMI+IWObRnkMZOeUuEV+b0VUhbry4gmkm467SXY3WyWmiLMUt1EufE/f1
	oRm2CrP2G0IHSx2IIK1GPuIq3gm+x+bqCKge9KCEsMxCRuzAEHTw69gx7mxJ8mKj
	+DZl1iFA1OqGwmNWuMJFgRODtyeZfDObGg4yPMLv38/jTfCJBAkLyEUNFL5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768576867; x=1768663267; bh=nNXt/m9bo4PAzDW2/YWU9yDCxuBdFpBnNyH
	UsHaRisA=; b=p+MOD0uiEIAIE3Ln1g1EzwOIzc5hbsaZL/9ZgnB4qp8mfHpW9/i
	De7Mj7JuJnjGAwktIsNfVK1/h1Q5Akj0WMO2+Ct8PwmU/WuU9K0hGHwRNPeShpau
	42WCyPcH1pex+L5K8HoYwc9RnvcAhm7lAFYpOog54OzRyObCwnGY5TY8Ed/ymFD3
	kgpAnK/SaP1DYoG7IKeqCNHiFJpaxFs+2RjhcYG/8PaBD+uipv/1dbp0+mlgBdgi
	k1TDUU+xLHJY/RJx6MF6wj7ZYYefP0x2idH4Wm0/aSHEXO0bp8e6ZVeRSm0TPxaF
	W/RsA2+92gqwky796X0uLganURQE1N5GKIQ==
X-ME-Sender: <xms:YldqadR4Em1lVxTVVXHLI9PngDOrWkBNT-rUp3rq_Wdr6skzaK8veA>
    <xme:YldqaTXRp7yGq9U5SidjRLqtFSyJnHm1X27sFawXZQOt0JLS2poeoBDKoLrdpCUSL
    tpO8Y6Ero2Q_T_pz2RyiTZMnF_HBpuW-xWg9SWfiM5untFtV3VlxSo>
X-ME-Received: <xmr:YldqaXTq6190NeeiLUa8yJvDZix4dG7ppc3Gz5PJnzKJlV8UKextUyxOdHIWguOrLQLKWBG9iqoU3Ik_VXB9lymzcVPIhpz-IyknBNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrg
    gssehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:Yldqab0MfLeDDwbjeiTWkq6vIJNjZnCn93aMUZeCCKi1rqo3yoqFkg>
    <xmx:YldqaXcSnZNVNgjBG9B3BJI8wkJGD4AhVr1LsK-YXXbO_4Q4b6-2fg>
    <xmx:YldqaTM-LglJth9vT12z0w62hv__hPUX5DBfkX6m6y8Z3e_QxKtjOw>
    <xmx:YldqabW2VpmZQ0AqO9nm9Cb-ALzG55sNxfBV6fYpPipYlSLhC7ObIQ>
    <xmx:Y1dqac-_XVRXdXbxOSy4YVPnNP2dIeKYQBXyw6Mu09nfAalaNZ6J_0Jb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 10:21:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ondrej Pohorelsky <opohorel@redhat.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Jeff King <peff@peff.net>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
	(Ondrej Pohorelsky's message of "Fri, 16 Jan 2026 13:12:57 +0100")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<xmqqa4yeblsx.fsf@gitster.g>
	<c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
	<aWnekt4ESo0bKpOT@pks.im>
	<CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
Date: Fri, 16 Jan 2026 07:21:04 -0800
Message-ID: <xmqq3445bn33.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ondrej Pohorelsky <opohorel@redhat.com> writes:

> Hi, I just want to weight in from the downstream maintainer POV.
> We've been carrying the patches Johannes has created in Fedora, CentOS
> and RHEL for at least half a year now.
> The only change I did is to make the new behavior opt-in by default
> and give the RHEL customers a release note explaining it.

Thanks for your great input.  FWIW, I do not think anybody around
here is against "opt-in with a note" approach at all.

> I think the patches proposed are making sense, and they should be
> merged. Even having them as opt-in is better than not having them
> merged at all.

I do not think anybody disagrees with this sentiment.  Back when the
patches originally was discussed on the public list here, nobody was
against adding it as an _optional_ feature to filter some byte
sequences out of the end-user's data stream, and the review comments
that led to the topic marked to be "expecting a reroll", if I recall
correctly, were all about "why would we make this on by default?"
Peff's message that reignited the topic this time around is also
about the same.

We are still hearing from Dscho that he cannot think of a scenario
where making this mandatory with opt-out would break existing
legitimate setup people may have (I am paraphrasing [*]), but I
think that is aiming in the wrong direction.  It does not matter if
you consider the approach your users take is "broken by design"; as
long as it works for them in their (limited) settings, it is a valid
arrangement to send arbitrary byte sequence over the sideband even
it happens to include ANSI escapes and other "curiosities".  We have
in no position to unilaterally break them, telling them that we left
a way open for them to disable.  That is not how to deliver features.

I strongly suspect that the reason why you made "The only
change---opt-in by default" is from the same reasoning as above.  Do
not break end-users' set-up.  As long as it works for them, it is
not "broken by design" to them, and it is irresponsible to break
their set-up.

But an opt-in way to filter suspicious byte sequences is a good
thing, as such a mechanism did not exist before.

So in short, yes, everybody around here agrees with you that the
feature as an opt-in is a great addition.


[Footnote]

 * Here is from <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
   without my paraphrasing.

   """Can you help me understand how these existing use cases (which
   are not actually in wide-spread use) aren't broken by design, given
   that they have no chance to ensure that their ANSI sequences go to
   an actual terminal that can understand those sequences?"""

