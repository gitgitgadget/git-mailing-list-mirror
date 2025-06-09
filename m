Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977A2580D7
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478107; cv=none; b=RWoMlcsfNLH7Ahp3nP/c64LF2cmt1rM+a9oSbup85WgPJkHWI0mVcZmT50+kbvuPjuD1qx8okXEBLl/k1k5kL9aakCeLLe3SJP+MihK/bofbgQ69YEjiLekexFAUTNRaK2rI4haKWl8f09D8Ruy10YEidfsARGwvnFnO49chj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478107; c=relaxed/simple;
	bh=sQpKi8hGpds2XIBe+ORxRG/9QD3iTsbAEPuysZwYQno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bO3ceOWkB7R3k8i/OihvMZ3wnwDmp9GTtcum2bkXwFR25VF25IM8KeOuhONX9FMhitp8TqlF1qUQwcTj1kBuf54+cSBsh1LDG2n1QI6VYbGWlR7W81OYhkEM+3zNh/MgO7wvVZJ3Ajrjyx7bsVDXV3fBJRIqB93wU9lY1pUYGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nGaXfjfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnolXx+4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nGaXfjfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnolXx+4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A95CF13804F6;
	Mon,  9 Jun 2025 10:08:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 10:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749478103; x=1749564503; bh=KYOa9HM++c
	xnpLuZgxuHtcb/7pVXG1qhSuIM5Bup+dQ=; b=nGaXfjfoUjraCoTA4KSWgRgc+J
	4nELDZvLoLCRvBiU7uUkPjdKCHqnK78eG1zs5pa0MecKCCrjaQi78kRbI+gxPPwn
	zp/LTmj1+PjesbqZhkUsoUiZtEX8iOmRLqV9NFMzalPDZWRT6tFX90EQaq3lqnIe
	ss8PN/kCdfkZTVkRHP+uYwUOunDdESp//4us+V6nnGlzrEgBQeYszy7HXudR5UaW
	oXBs0k1KulxPr16lKx1GB9VZuamwriJ1GoS/YuBKRqjPxajYD8yRCTi27/ggQsKP
	G3N8J5h0ff3ea79sYdzl0639Knh3bHxihFseUsm5lotiHT3t2XF3NnYVX+3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749478103; x=1749564503; bh=KYOa9HM++cxnpLuZgxuHtcb/7pVXG1qhSuI
	M5Bup+dQ=; b=BnolXx+4d9MQpoMd1GW++17diKS3ZjvbLP5iHD7JihCUIyCOwM3
	WIWLDXvysiaLurHa8XHAgUvV0wf1zPy61y/Hb8InyBGAdI3gy5Cf0ZTqcbr/n5JA
	Nw8vku0FZsblAj0nkMuwUf8v9ov+ekX3vjxnGw4iw+SYniWrAULnf+Af6H9v6zyx
	l+19LoW47jrMxnTEWq6ODG4+msiAiV3c/Dz1UlpsebGn879bMsMSG0QQA7kByLe9
	HblNPIONsYeEJcbApQQJVLugoi1N+h4Q0qfMSV2rJon0D3dy1Ao9vUYeeDScQP0V
	BlQTKDsj/Xybu+w8uUEnOsmAnApPY5PhX9Q==
X-ME-Sender: <xms:1-pGaBXcSizhCmHxvrZxuLWI7ytCVP2kSaj2zawsVYCPEWkXiGJKOw>
    <xme:1-pGaBmv7H687M50a0iBPFt8oUEWzU8HpfP7Ac5p-FEA1dXN7dZKo2cEvFeOCjlMc
    slVhexuudGYohgdOA>
X-ME-Received: <xmr:1-pGaNZbg8BFZCQ-hIxGBk6aIdEaWmSYcjBZDLTdt5Rc6TOwKllBdD9eDMhBYIkEKZmT0evDymS4nuo_8tyHclzb6t4uFWU0nMDP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelgedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitg
    hkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1-pGaEXKm35yJrrbMA2rnaUsc8MlykcXxuozWkblYto3Royvxk6h0g>
    <xmx:1-pGaLnh7mnBqPzjnqLTS4m_sGTEduWTdrJyg4OvVJjRr5kx-nnt0g>
    <xmx:1-pGaBfu9L6-ao8tCOGqJh0kYnofzGgc2DZeOkOfZRneedGDYgR_QQ>
    <xmx:1-pGaFGbAz5a4Cip40UTSUODhQwC-E0Bk5BoVQ9Jy9fj7eFx2ztrqg>
    <xmx:1-pGaBSUB3FGXJCiExnqbleQ1JyE_13TnSxy4FpAJcT6Bppz3RYOokot>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 10:08:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
In-Reply-To: <CAGJzqsksmQmY4o-_7DoPFK8VP-h59ANUjroVv2+++ZG3gDBdUA@mail.gmail.com>
	(M. Hickford's message of "Sat, 7 Jun 2025 08:00:00 +0100")
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
	<CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
	<xmqqtt4u86x2.fsf@gitster.g>
	<CAGJzqsksmQmY4o-_7DoPFK8VP-h59ANUjroVv2+++ZG3gDBdUA@mail.gmail.com>
Date: Mon, 09 Jun 2025 07:08:21 -0700
Message-ID: <xmqqtt4puhwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> Interesting, thank you.
>
> Suppose my network connection is intermittent. While the machine is
> online, `git fetch --prefetch` runs successfully. Later I am offline.
> How can I complete the fetch?

I _think_ that it uses "git fetch --prefetch" to store what is
usually stored at refs/$R to refs/prefetch/$R (so your
remote-tracking branch refs/remotes/origin/frotz is stored at
refs/prefetch/remotes/origin/frotz instead), so I would presume that
it should be the matter of doing something silly like this:

    $ git fetch . 'refs/prefetch/remotes/origin/*:refs/remotes/origin/*'

