Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED11E47B7
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951929; cv=none; b=FP4BiH5SdPVRM1Ur8EdNteAg44J4RBwgKo33BpjpLB3kupGgLQnybtQoT7Hx+uWfJijBmiNaFSucNx1DRfPGvPec+yHW1tCl5obfRGjU6w6cwQX86oe9ijkC1M8pHd8KYEGc8iqpQL3FFM6NnCQWZpzkFkQLD98Jg8kA7Nfmlqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951929; c=relaxed/simple;
	bh=4Lww5tc1EXLYUd2yzLBRIHRIo6v5uETHIaB0rMIuFPE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m+bw+LvXJkVv1Qa9OP+rr6NSpODhRmVoYP5Wj7WKrbkStz4mrTNrN9ADhcWWjDjjQVy9C7mMBDHUGbZnG37ahuyB+65d7FpqHEu2Iylr5GI82wadOK0BIx+yBA3W6c0+k2r5aVrhw4frO1tQ0yZOnOt1iXvz4QrQgXhxePeS2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lCwwA6oo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hu2y6XAv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lCwwA6oo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hu2y6XAv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 61F1A1D00031;
	Wed,  8 Oct 2025 15:32:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 15:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759951926;
	 x=1760038326; bh=4Lww5tc1EXLYUd2yzLBRIHRIo6v5uETHIaB0rMIuFPE=; b=
	lCwwA6ooo+L0uS4e6yEW9lc6rTDR8dFfoteR1yPxFghlaxjWDQ6zRT9ai5qt6B0K
	35a1yj3BhmxM9SCombFemE43QSQEZ/fLZyY8B13NqDZ9LpmLd+Dp1QpYqp4wD0df
	L3RWbcXJk/z5Q2EQoRC+JuMjuD0TeEO55PP21T7LvYjUCfRYfa4/S6vPmhSK88/2
	s4ebygBQU0YVIQhlxPdw8MPnPlyUcXXZwb60m4j46W9M2scYYPEuf2nvv55c6z/I
	+FLNns/f94r0ukCDS0OHCHV/cVGyWtSE9vvoaKR0WdeY7txww8YPYvgxrbjZ//zQ
	yBaSTm711I/VJvQQ9ysmpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759951926; x=1760038326; bh=4
	Lww5tc1EXLYUd2yzLBRIHRIo6v5uETHIaB0rMIuFPE=; b=Hu2y6XAvJRvvt0HOs
	ZeE5coG8rPPHwaYV3+jAySj1IO82bcEUHqWXVMzLRCAe4sdKLfy1MN1NcPsG4b9z
	e5mmKL1NJtMSC7oHwqyNDC00KzwqcCDjwq24M817c8VM+91KhjpBtdxQ1mFW0+fV
	jzzoup8MBbrNFQk0Wp1CDeLVnULQWdYzvaL2cwT+meh5Je6d/oSuwFR/o2tuXsi6
	tPlrYPVokM5V/3mntfkpa8c5iiZXCuMUcdiU0wlvLysYxYgW30sptNxfpC1cYsL3
	hAuauYF/knrFWjxvpDW4Cx+szRl13Bs1tyiPMyv52gYrh8qbPV8W6YYG2LTLp8VT
	6liAQ==
X-ME-Sender: <xms:NbzmaPU0I8KosOT601h3j8BHDZVnCskiau_tYfhfVYoNCjTQK9NRGcw>
    <xme:NbzmaCZ-_G2KWAnM06eIQBrc1jey4druin6SxlbQR1HTeRSfDhFgIXWcjWFDuqnuN
    aiAFOHOcReFSCmpyyRyH7ShGNxWHxI2ybJuNdfqU-OdJSZz1Oe7ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnihgtkhhgihgrmhhpihgvthhrohesiigvrhhovgihvghsrdgtoh
    hm
X-ME-Proxy: <xmx:NbzmaGDDqGuKC3ep7RnjPontvNDWkVbUotHlsiBQkTlvfM7bU093ow>
    <xmx:NbzmaOe4vfrwyilOQd56pRSC0NR1IL5KZvi1DBt3LZY9PThaFYLAIA>
    <xmx:NbzmaBLCoeeUrGjOfdS1SRDE6wETwWkbcyevm5DBSandsZIvkPwcNg>
    <xmx:NbzmaBe5axY3fl6Sm_1mLBmjxi5LrwhJb-GHSM004EltyR4WX55arQ>
    <xmx:NrzmaPIpKUQ3c-ZXhXdpjMbaQ-opBw2nGoDVXaJ0UqOalrGK1pC2Ayxr>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D90951EA0062; Wed,  8 Oct 2025 15:32:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1nV81MDJ4tB
Date: Wed, 08 Oct 2025 21:31:37 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Nick Giampietro" <nickgiampietro@zeroeyes.com>, git@vger.kernel.org
Message-Id: <725e8ab3-415b-4345-8a6a-57f7ae5474e7@app.fastmail.com>
In-Reply-To: 
 <CAEVYKFcj8kGRAxawwCLLTNiewNUMuFQnZt3-sGPG=kA-AY-6nQ@mail.gmail.com>
References: 
 <CAEVYKFcj8kGRAxawwCLLTNiewNUMuFQnZt3-sGPG=kA-AY-6nQ@mail.gmail.com>
Subject: Re: Subject: Git console output told me to email you about "git whatchanged"
 so I am.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025, at 21:28, Nick Giampietro wrote:
> I use git whatchanged regularly, please do not remove it.

This command is being removed because git-log(1) supplanted it over 12
years ago. Both commands use the same machinery, just with different
defaults.

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).
