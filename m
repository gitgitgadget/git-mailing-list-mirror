Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B213B7A3
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898550; cv=none; b=IoT/aeQp66ujcfNyctLxM9T4ZIxYKoHx9FABE3pkpHB8s86Br+0zbXviG24ofQeE5RQb1fC3iY5VWSDZrS0GNaFfEyayeg5dpsfDYT7VTP1QhV559Gy/9b+PP+kswyVzwH+AnkkI2RH1ACMtKm8ocSgaD7JSa4tM/jb6qtS5ul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898550; c=relaxed/simple;
	bh=Kp4OylC8CnXManP/QHdSl3dGDGblEvhVl5oFyv/izJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPH8TtxX/vs0Laby733JI68fpZIHx5CTmZMtpPQ0fInQ1XoMudu6ZDiHECq42uk6a6SqEv9kTo6HrwQ6RNH4ThVVR1nUX+MZ97egnTez4hqbUK6++QAg6q9ggwlz38N0dfMhBaTjihWh09Sn+Qx0tXP64UJf5sDj9Mivve+UTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ieDbGShe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jVqzM6lF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ieDbGShe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVqzM6lF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 36F381D00143;
	Tue, 11 Nov 2025 17:02:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 11 Nov 2025 17:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762898547; x=1762984947; bh=sCwosqOgMI
	UDVlp8RJ35zMmwwEfUA6a9buJmZ2ojf30=; b=ieDbGSheEVJa3kBOmdR5Hr3gS/
	IutEYOF66YjS5vAALBIta/+X0JdBFlE7W3axdQEcshfTnlFm/FEgeBeK4xkKfK3s
	2NNnin3gOmOi8ELyTrAGvGRHznwpO3MucTDMEtU9APIM+Ihr06kQIpB+xAGW3nOy
	jYbF20lm0GcNu4/zkNpy5Pgv+wtEEl/k/yKHPBrjsFz/5Wd3/CzM3wygWQw0+nuk
	CC3lcWJ94dhIimSxp+dSdi3AC+YtSOvqWouMusdru9ifr+DVt40WKPhyk+vUx2Gd
	AyFZg49BZpjX6N2iamDTXy8PPFU8VW4sTC8ekGWk5dzRFSS/aYxOhaxq7K3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762898547; x=1762984947; bh=sCwosqOgMIUDVlp8RJ35zMmwwEfUA6a9buJ
	mZ2ojf30=; b=jVqzM6lFKYxcb763O9EVtJ+jFpiVsiGaKZ3c6IY/Np/McYm1AF5
	AMVAQ+q52eGguhJdTkJV0WcvfX002PWZbOe9f/0AUSCW99IUuWBBJIkmmEHg8riw
	l9T19/AUqOrCqkO94G96BkLubEscmF0BoL3cP4FYiBAzySqf+de2nRhUiKfIvln3
	LV8H55cDv1DgBSPA9nh4u/d/bleQPkp1Uw7nFtOOcDyFCM6Iy/+9AznYUA0yHbJs
	EpuVZlGNRctMZuqJ3EB6mlL/1sIndfU9lj8aWoOLwVkGDulr/uY1pfpvr/XhUzmk
	AmK1+IjN/jdohXzpyta+DpdpZT9jL/Y1W9A==
X-ME-Sender: <xms:crITaYPsub8P-uSJ7jTeNhXCdGjptbkl3gTB989Q2UNdP8x51WhZsQ>
    <xme:crITaWZdPQHU0DiAmAJLHoVO73X3JWCcOQXFs8qvkK9xtSrNmvemUM9zSmVZS_CIC
    XSLfsnwEelcJb56Xg6yoUsByjdYe_3WSzSf6IQAGRLtfYbfb9SoqA>
X-ME-Received: <xmr:crITacpwkGuE9avzxFcXM1kbj_liU8d8k_kdgDdQFodwjogoPI13Nm-RyzzdaweNLwMuTp1feMeojTpQtFRAk3auyyHN9W5458D_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:crITaaYF2KB6ZwHOL3X8z5q7TfAiVmzWN2zsmEzpgldf6tZnMr41dQ>
    <xmx:crITaUQHdyS94NUmRTK7llpfe_72MUoOnE4pOg6Bv4xc7h3U0lE__A>
    <xmx:crITaR6xdizd__n2VacmRvoO8x4Npsv2dIiKos6T69-j3qDAeIw6EQ>
    <xmx:crITaZxnJUtriGXWgFBszkzVPFOtxnY8GpquOO0I2Weao_R0-JYVEg>
    <xmx:c7ITaXIvU0O5ULt9LX4YU8sjd1RV5Tm3DVFgl-ecO3mtjlkwWU_2OPtq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 17:02:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] .gitattributes: remove misspelled no-op whitespace
 attribute
In-Reply-To: <20251111213910.GB4053071@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Nov 2025 16:39:10 -0500")
References: <xmqqv7jgwgxb.fsf@gitster.g>
	<20251111213910.GB4053071@coredump.intra.peff.net>
Date: Tue, 11 Nov 2025 14:02:25 -0800
Message-ID: <xmqqseekut1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Nov 11, 2025 at 10:41:20AM -0800, Junio C Hamano wrote:
>
>> We could either remove "!indent", or spell it "-indent".  The
>> immediate effect would be the same.  It would only start to make a
>> difference when/if we enable indent-with-non-tab by default in
>> future versions of Git.
>> 
>> Let's take the former option to remove "!indent" from the list.  We
>> would feel the effect first-hand ourselves before anybody else if we
>> ever decide to change the built-in default whitespace rules, which
>> would be hidden from us if we decide to rewrite it to "-indent"
>> instead.
>
> Perfectly explained, and the result makes sense.
>
> I don't know that this patch particularly needed review, but maybe it is
> nice for you to know that somebody really is out there reading them. ;)

It is mostly a principle thing.  I want to see that every non-merge
changes authored by me is treated just like patches authored by
others.

Another reason for me to send these patches out is so that I have a
copy of the patch on the lore archive, with message-ID, so that "git
log --notes=amlog" would work for my changes the same way as anybody
else's.
