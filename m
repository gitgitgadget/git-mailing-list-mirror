Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450A33D6F0
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512206; cv=none; b=YZYnFgVqg7LGPQcdaxUs/pT+l8FckOf+3hCWaHRdY+tvSIG3MvTFYiA4+oWt4L3HwWKymrDxDe/pzHrannl+/HihQWi8OnFa3SctxmwpG5qOeuE+XsYfx6glYhQEViXCW2X7RlsBQ6FjuH0PFZkTvuQEyWZxe1cb7e0wA9wIqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512206; c=relaxed/simple;
	bh=FED0dB8gG4UTBe48hzMTvwcETUvHh+XfDxQvS6tt31M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHepDkRrLgYDH/C/EopaenoU/rq1hxTbmxNPmidaN6O78ejp94tDxexiyPdxo1QcpeqGifvsU6TuiFeZXuhHrOx9V+TCcfi8S+KjcDJvcsCVDPoSvvMLyLrlKo4efr9xrmkh1E7p4kXz3/8rxWgNf+D+MhmtOHhsIygb/ImuI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N08LOaEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCkMZdQJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N08LOaEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCkMZdQJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CF834EC0182;
	Fri, 31 Jul 2026 11:36:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 11:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785512203; x=1785598603; bh=x+fmtP5ADT
	K/qhtuFxDlmFwZDUtWJHH4wA7ufDamruU=; b=N08LOaEV0J63uFsbMsfsvuSrwZ
	6Ke7SUHTkVG8+LunqSbfxpL8unMJnj2Vt5LSaRYRBSifZXD9g4MVUpUcxqSyu2l3
	bpkE6AR5umvorKyiSDIxHMb4YYbu2CZnRXG8Y7yk/ZndQojQ5mdfbq+tnGJswBzE
	AXt1uJ27cegODdJVYz28V4gPJj0KmS6PUuwn/+FPzB2nrpzqz/b9E6DOd2mvFT/b
	tbGoQZBzbEwl2Hju5Cq+3C4e2hu8w30n6mIBdIjkfdQttGfnpl5EdWTnjwEGQVdV
	4DsKD+dk1jVfFMs2NFtGpCuoJcv6OGIAtC5BUEFsFwn23jYMjaXDXJpN7yoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785512203; x=1785598603; bh=x+fmtP5ADTK/qhtuFxDlmFwZDUtWJHH4wA7
	ufDamruU=; b=bCkMZdQJJKq1C7tJXr28tUrm8thrsNcDVh10oFRGm8Iq8rmF2w9
	oUeV4wjOh0vUfQ0lmhNeuBn+Ri3JTJngBVeFq7KO1w7pe8TZIoH15jzoJRxXzl93
	z2lHIicMa+YwyVyJWmBW26ATJ08ScN0orkZ5+VoZMDa2ksGJbfipXm0y8jgXKgpM
	S8YwhZz4TcP3DfMpQ8Yhf8EVPMOUemy+Bqud+9sKe7oXYjxJ+INjOvcziR33iT2u
	+8+wfRGBAuWLQVWBQTo+HubcFBoL4c1wXwUpz4EJ4bFlRBMAVtrHTZmllIoP4FLF
	Tih0FdscVlCahZZQ39bU+jAHN4rOXvocahA==
X-ME-Sender: <xms:C8FsaprqeqqJWKvfMtxQxGyNOAaODNkuqiSJp14gu-8897QgjYjgrg>
    <xme:C8FsaigmQfJiS8leSzA9WSrZecFZ8sF0Ba1kGcPmiH2MjL6xViEAQjDkEsXTJ6QLU
    uutXNqmmPQ64ix5F7HuuExJDr3sulYw-jThrblfxDg1c0hjNUs4>
X-ME-Received: <xmr:C8FsaujB9y3Rc0yRFEHxRH5sjRw_UQ3_mK31K0F0tzz88E7EceFsU3VlGYivF_5ToSf7oP6zVpAfQJEQChIGPMqqk9DLz2pVnA>
X-ME-Proxy-Cause: dmFkZTEYtcMLxRH1DV8yIiLPwP3tgxJqRHQDHEq6yME0Yu7kF8C/ej/+K8LZ5FY6MrVrbE
    6VmAfJRdRNeFfNOlTflsZ2+40p2b+7AWbzW1E9R8LiXQYshaSk8MgclswBhYanNLjGkVSx
    thMlrdyJ76Dwod2xdO3Y30mHudJ5tmqllDhIfE8fXOTnKmZsU3T65SrGRYDmAnyLevv6xs
    8PDlBpBIStG9HUmIekohiFR5eDdknATWe6z38ljs4n0Hcf38F6taFrBPd0p7mTYFRYv8vm
    rW5IYue73Qs/cobwNffUs4ZpT9HxtgFOLuRmMaeNGTGIX3kawZYTHpFZvsFbVa8UHmAlNZ
    Y6PtV1Z5b9r8EVhcDIFJfL2fsEpvHfFcic4WJA4xATqLyCS9+DsLiARKPwktGFdtB2vcy5
    AnLDi5/S50TFa0p2qFl6Z1TVJhZn8aJnYuv/uG3gMQdLqU2PvYpYcbbL97Ypn7Jv6L/0fy
    QAbTMRsBBdo45kT7IxiREk3hSb+arzvxNr2YSBbyBp4Lhz1zGYMsg9jsADToLJDgpminYB
    59hLcopgVuC5V2mzO+KV65gr37Vliej/PQuJmoDxrQIdD0uB+GsnIqMG4cOA52tEH/q9QD
    aAQYhxCuUDgab85HzXgIikDhZr5FyGl2DY3aIhLNRJ4GcLKjtqeYjhuEzECg
X-ME-Proxy: <xmx:C8FsaggqNaKWq0hdhB-uZtS1l3ALLAncJlH8pxl7qMVBLhvs_aZBQQ>
    <xmx:C8FsamLS27gEVtqNgh2Z2bfG54dk2vAzfqpQVuWXYoRvasjVbU16kA>
    <xmx:C8FsanH58Ca2RLJyAv0dBb73MuICsG-bUgCI_830o2K9uLQ-3h2KUQ>
    <xmx:C8FsaiQDG10qxkKA52lMKPp4RXRYJB1qwAKfpU4V0sEmMZSuUDE41A>
    <xmx:C8FsalzLxjtZywQdE1ISsyk2si4Q19AdandW3JA2kZ904kD2Z00qLvl6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 11:36:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  <git@vger.kernel.org>,
  "Harald Nordgren" <haraldnordgren@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
In-Reply-To: <DKCJF4116DLD.3B078238N2B12@lfurio.us> (Matt Hunter's message of
	"Fri, 31 Jul 2026 02:20:23 -0400")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g> <DKCJF4116DLD.3B078238N2B12@lfurio.us>
Date: Fri, 31 Jul 2026 08:36:42 -0700
Message-ID: <xmqq8q6rdvcl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matt Hunter" <m@lfurio.us> writes:

> Sorry for any hassle - though I don't expect you "blame" reviewers for
> this sort of thing.  It's a lot harder to demonstrate correctness than
> point out some potential problem.

Yes, I agree that giving positive reviews is a lot harder to do.

