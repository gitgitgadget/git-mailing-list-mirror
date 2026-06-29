Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0CD1A238F
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767775; cv=none; b=oJw19W8j0Iuc8aWAXqrNjK8EVLb4Bt/laoAgCypDMyiHa8UgboAsbsArNEfqk4Xnn458GVV6bT1AmXlXIhJDvZQYb6FpEAB5VdPYgvzXlnPZuKkOmq/CBfI4OfRbE8Vg+/eI3jvz3F8iiyfZLZMv3leZV4Opm1pLUuK9pdi+5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767775; c=relaxed/simple;
	bh=c6IJWpi1MFZLdUVI+3ms5eRvIZlWwMtfzfzx3vH8Onc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SoMOPgB5CTeZf6zWBU515uNNHxEJ254WlNb+a+8PH98IS3eTslWnAXNQ1kr6xcYXWMAV6efnfHTG52BQLka+5+mJn9kW9mp155Vls5HxFGCe+IzVMPYF5bYTqoq+jUCG4RBkjUOOuCCpntu5ngSIDdrteHYEs7oDF//obMHAsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WYS5pAkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auoGzro2; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WYS5pAkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auoGzro2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CBE91D0011F;
	Mon, 29 Jun 2026 17:16:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 17:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782767773; x=1782854173; bh=dkvD5YLkgZ
	K1ejiyYBngrjHhCrJfj92waa6S2J+Dl1c=; b=WYS5pAkkh33Hhe9eyf4yUFyfMp
	UD76at8MuJujUbETpdLrOooM8aVZbHCuoy88ZkTo70gYbYWNJR5cIKj7oeNiQvXU
	n1Lls4S+SqnfS/gUTQh2BECqiTMtgdjfjINhLLaragqik6jdAuJidB6f1PO/tVy1
	Txhjuyu/W3bwkRaa+maWNsA2YLUDdrl66GakwW3XSFe+5oJ6stdRMQHYurYmcj71
	1RNT4RxnIgSV6Nui/XdC44nc+wr/UH49/Q5fOgSqMG6K5rKgcP9JHdzIpFOJ4fR3
	Ci0/5GiccIIBocsrNj18S2ji5tvnr381puAvw1voOjrVf1dX4SYce83mkuOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782767773; x=1782854173; bh=dkvD5YLkgZK1ejiyYBngrjHhCrJfj92waa6
	S2J+Dl1c=; b=auoGzro2OEzRqcPDNMiy50HqDf0YcVxrMwA9jP5RaOW37rzZSYO
	gV0k1clSIyYXThDcEPmybGQafgKiwFyI1mq+gIBMbuvz0ESgqdj/80WD1+YD+FQX
	weMt/ZV7qE4n38bRg/RfUI7WMZbJfSOYxLCikrgLv4ZYzfoAnka3VCbpIfNjbhpR
	6fV/9mSDCrMlPSMzRv1uLxKQuP1V7VVJORVLN1Gns/UsDJAN6KD2tUzjq3CIbSNE
	PuK60Sa53GSLGVj+kCUNzJWWO8Dpi2JEY9E2/TGjsENwORuYm8xb2FixDo4mV2jP
	pSlDW5BtA8ydP5/tHzQAZ5qSKnCephJphXg==
X-ME-Sender: <xms:nOBCakHREwl_967xQOWwI0F0sDWMNZImyH7ErfWwPHCJh0BORNfK0g>
    <xme:nOBCakNliQzlEPn903AV8FxAXSX0EQFKP0IIZFkxtTs3SB0E3fsGrQUKTsufDsNos
    CSqbfl_ilD8cnHgy6EkBHGF1LWGBAOQd4Fd-pkFkeITD8f_96-A9Zs>
X-ME-Received: <xmr:nOBCamfiUN6Lx1wfQJCuhWicJ7fydFmjasqmjFmKyjSHw83wEjJP3NJ-wfRq2Ni_RlgjI1au8S90yQ2Ez05r8cMOdo9jbL605MXvX24>
X-ME-Proxy-Cause: dmFkZTE3WejCpjcnk9x380SwAN3YluFT+rCRBTEFiGW/GFLkkHHUV2cV4nhDnGU85kjzSp
    RW+COtBx0sf4g/NmC0O+gLs2FM28H4izzBzZWJ9oK5I0+jzL2+kAcP2Y2UsMvfVz7FUp0W
    Yt+b6Asf2Puf0J/rWHTQo8nTDqTG1n+7OE0vY/djVeb0l8r9HwrTX0NbG20hIuMyunYHXm
    XEpn7y/A5gAY9kimVEaAVhdL5RThYdsOjeYoPB0fBIt3oh86uZDNYLKcmoIsPc+PNVCNU/
    UwfRVLIPy3HqO4hnNjIU2ap1gtCxPYzQR4va9ylm1LdrtwVatUfqNrFvGVMcTfAjmejcjv
    9ujUa+cH17ATio1+2ZTQWNw2CFcOkOLF2MVydN1kL7yhdQMGR7hBlNPkAFxufE6dsLrFVz
    oe/0Dr9GJYMjGTaInMtGYp/+3YAyohXxHu+aP48/wM07t6AjFFkpZhNpbhS9ghOXr+qF/q
    n0X/mjBbVxWzbu8YbWl3naIy729NA3XE8WGeGEjsjhHsqXVDFyxZt4Yd6N2AA8+zNwnHA0
    y0R0Q5NtBMMyUwYUZjBQSWmeiV5KwYlKC7JgG8I+z+7dqD4Snx4SS/vDzNPNmJaW1jAF0W
    +Rek4ATojJvZKhqD/PyQECT7Vntx+3BoccmGB52NYq+tBC1Xo7OeXVLoaaoA
X-ME-Proxy: <xmx:nOBCahsabuL7Ca1jLAo-kbvMOHF2BgYUTxihPpuSacpwdg0RnNTVpQ>
    <xmx:nOBCankcTwR0a9L0BcUX4MOP3QUUTrphhGV_fHWFTbXUSkP33JAtoA>
    <xmx:nOBCajwvzBrrH3pnGVECE6rHKGzpOsv-7FBIy05BzqHTfMl50OSPEw>
    <xmx:nOBCapNM6cRZ_8ku8NN23wsLWIhJtyKfs6-5dty6Ea2SH95x6hDxsA>
    <xmx:neBCavSFdpgL3eyudkrMwitMxJVRT1-HaH32Yfmnv6SG2D_Gc_RHjWTS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 17:16:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Kristofer Karlsson via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
In-Reply-To: <CAL71e4MYNiScZjTwkApjDAjRh2LM0_SP59h5HCTywV-Pua03tw@mail.gmail.com>
	(Kristofer Karlsson's message of "Sun, 7 Jun 2026 14:07:21 +0200")
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
	<pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
	<90270818-c52b-4611-8da2-6cee20628fc2@web.de>
	<CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
	<CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
	<1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
	<CAL71e4MYNiScZjTwkApjDAjRh2LM0_SP59h5HCTywV-Pua03tw@mail.gmail.com>
Date: Mon, 29 Jun 2026 14:16:11 -0700
Message-ID: <xmqqv7b1t5d0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> Now I am thinking it would be easier to reason about this if the other
> patch lands first, since the cascade change becomes simpler to evaluate
> when replace is already gone and only the unfused paths remain.

Sorry, I should have noticed this message and responded earlier.
Let's make sure that the "other patch" is ready then and merge it
down.

Since June 8th, nothing seemed to have happened to the thread for
the "other patch".

  https://lore.kernel.org/git/pull.2140.v4.git.1780945851.gitgitgadget@gmail.com/

Is everybody happy with these two patches?

Thanks.
