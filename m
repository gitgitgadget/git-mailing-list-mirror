Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBD3D8918
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671978; cv=none; b=G0fLvGMdqXmixH7Q3Pw0lbC1ewKjA9GpcC3vWYLQBCcodBkCbGJSrdvuuUR26MyGjebAb/lllDkk5utdrUz2SXdWY9QDQh7JuBXRzRfs5L28e/M2q+HHyuihySfvKj2ePkQxBDyONvO6dXOJr67Sl4jW6M6xxXljBFJ7xVSV9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671978; c=relaxed/simple;
	bh=tdUSur+c5xsAsWZiIQvnQ1cFzTFD9GDLuo3p7LkufeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NbLxd3a1oo7R2ynzcYfeHEjfRtLy4jarGPhW6EwbVuoIdSnLnfhl/BmfEpU/pGwb7fzrxXv8rwndEyJ3wWUsE/vBryuP7ygvTnEGtIsj3tnqYbWlo5H5V/leJjit9lDeqj3xYvE8LWFoe75Uq7uZv85BZJ2ud/SSOTSMeKwXr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bskwJV3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEWlQOwJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bskwJV3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEWlQOwJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4B84140015D;
	Wed,  8 Apr 2026 14:12:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 14:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775671976; x=1775758376; bh=Qx0o3lUk25
	QndvEF2+zGUTAtERLuauNUr+xbAN3oEoo=; b=bskwJV3Jectj4zsM84UP4BF5i5
	putYljifl2PkLhCjProSjB82QT62/qHQNOtMzzIhXfdjA2iFZ+RT56VXAPPysGET
	etYvO1SEm/iiBdbiCSHVMAuJ0QV9i8comaBvrDxuODCKC4jxOyixDdUlSGo6hIxX
	Bc1pPqE0KiKPKhROP3QQs5bM8rXKAtrFUVY+IGUHFyZOy8tQqcAS+MurGPjXCLF0
	PJQdbZm+a+TPl/r+0vBax18y5u56CpkCo8XtaOg1dea4/64ewduUaKiVonlOVek0
	SkknmZSjFsf+oYe4wsl7WcvnkggH0lyUtECBHMzlnedYg6BZNHXTNENNO2Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775671976; x=1775758376; bh=Qx0o3lUk25QndvEF2+zGUTAtERLuauNUr+x
	bAN3oEoo=; b=hEWlQOwJuZ7W8evMVxVWL1x2v3atQxFTs+r4XDEI+2XetUpW9FF
	7xibzrImfagES0o0nMvLvq9XZ99ylwdj8+podIU1VWN3VGgnSxZohIhmg64WCDOa
	uJl7KdcU7VVCb/J78tt5hwN8Cuppxqu9LuvD4u01mA4315Vcr+nU3ze1jDDYU7HS
	N/loGzV+hxMGLn0C1PgZKIwLaDs/KQPUz87eqAPmsswqtttm19gScKVGPzsGcBzf
	vy5Am+EVQGfYgbuADllvpAOwea1IFn7ONvssWazGf2/kQhuEeZy4FCfXRX0UTteP
	WvcHU8Td/DhjDfgR1UaIAnlpylw5qL0N2cg==
X-ME-Sender: <xms:qJrWaetZsk17xjlZhBBlpyTSRk7oyO0lHLOsqBdqNT4h65CKnXCV3g>
    <xme:qJrWaacrjGPO3qlzW2Kzz6p_Tc9QnERavUosNW1TjQCmCrNrKmXMIu3rJhp9iU6C7
    KnZWMiHjksxTRMnsJN7aE3B2AQCkgYTFCwHwe7qJuVAfwV-6ggN5w>
X-ME-Received: <xmr:qJrWaeytxM8KpXJA4PovNlxHCY6RsYayF7wVMNhzcDbwVAFy55En68bU5nEz00NkBCQ8-zHkgf2167_bJZEXa9P67hxCsojLZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qJrWaYEjsAGNrWHHzFTBwDS_CN7XbhgcDOo-nBamEdI3jqxv8CPNxg>
    <xmx:qJrWaaw5Ej4MXDmGryb-cCmMbR3F24Gwvwd2Ok-7OOdNlb-mz-uJLg>
    <xmx:qJrWaRtkuW45alMtoNW2t49KRRFJtpHugexauLU9HYiO3I0DSoAGLg>
    <xmx:qJrWaf30ru8OwpmvQFPXlCg1-UwJcWTvAg9JO5vPInYQ0zKBlI2pnQ>
    <xmx:qJrWaXzVNXOfpWjC1f5U67q2YKhzIU5Erjm1Q5EsHxvhwvSlRaFmZIrb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:12:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
In-Reply-To: <20260408173949.GB2850002@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 8 Apr 2026 13:39:49 -0400")
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
	<20260408041716.GA1324339@coredump.intra.peff.net>
	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
	<20260408173949.GB2850002@coredump.intra.peff.net>
Date: Wed, 08 Apr 2026 11:12:54 -0700
Message-ID: <xmqq4illz5g9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Apr 08, 2026 at 12:25:47PM -0400, rsbecker@nexbridge.com wrote:
>
>> This is also impacting t5608 and t7700. Anywhere where writev() is
>> used, seemingly. We went through MAX_IO_SIZE issues years ago, instead
>> of using ssize_t as a basis of how big communication is. I think
>> writev() is not valid. It worked on Lunix, but had issues elsewhere.
>> This broke the compat layer.
>
> I wondered briefly if the problem could be that we're violating
> MAX_IO_SIZE here, as our use of writev() does not respect it at all. But
> the only spot that uses it is feeding pkt-line packets, which max out at
> 64k. So unless your MAX_IO_SIZE is smaller than that, I doubt that is
> the problem.

Good point.  The original did not use write(2) directly but used
write_or_die(), that is write_in_full(), that loops over xwrite(),
so it would have worked even with a lot lower MAX_IO_SIZE limit.

According to man7.org, writev() is allowed to transfer fewer bytes
than requested, so our use of writev() may have to be a bit more
careful, though.
