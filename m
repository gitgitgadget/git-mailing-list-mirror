Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C23C3437
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697561; cv=none; b=Zvxxh8iHbkkFlYcl/1cSf+E4tIedFRFDv64voIfCiindnLwRhV+MzanTyKlqZF6U95R6MXS8dUVoL07UEeh2MoOEsNG4nvgr/oIK4I98WHye3lX6VifpeA4MDundDLX4+Ult/MVVc4CgsCc+GiTO7JDwvRBQ+rIMgztX/h7Aa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697561; c=relaxed/simple;
	bh=4zaOhs44iWSioflpWgRVkU7q2pIKm15MLPQW4BjcCDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tDbrOUueJi/K2KV677iYyep50kpoyNRdl+zCLPeAmNoMleOtZKWfDnwZeo5XYktOUxdou9OABihu/qYvj1cVjRVjPBPzreMUCWai81UMHa8a6CdY85kSM4ejLWCBMjCP25S/iS56U7pyD4XTbFikBRVZjlF9P9KPrwuCN8LHK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zg9PO7f0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FY6EtgNs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zg9PO7f0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FY6EtgNs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DEBA7A01F0;
	Tue, 29 Sep 2026 11:59:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790697559;
	 x=1790783959; bh=DE2g9e9adPtEYC4SOZCync+inEq9TG6Mpn/n0eS7fcw=; b=
	Zg9PO7f09Sa4hsoWHmFPv9PuE0tBD+Ky26y5lZvMRYhX4z7htSlqQ11ypTIguDuq
	vKR6f0oMYekcxQ1tsl2wxWh/vXUJqULRxf9kcuHxb2YJP7r2Bsb9yDAK2nnvfyMn
	qzQoYnGQbOnMEDWk2/xC2I4cXqQ84Y5P2GOWErYc7j3aD+C7fsD89Vg4NJD0volL
	yyjJxiWsAkbKMoAYYPPpS+9LxmHeg/DyPRVQWGv40RqLykhbCHqiF3eNsRMkYJud
	rSrsiKHYVPFJ2tfZhsAIb587qfQr7Q9mZ/bIl5FianCODAkmIg6RJY8IKdUSiSr2
	qE7feA8Pr/9ltjv2qZaxuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790697559; x=
	1790783959; bh=DE2g9e9adPtEYC4SOZCync+inEq9TG6Mpn/n0eS7fcw=; b=F
	Y6EtgNszwnFMSx5kbKrnGTQoHLK+b6oK7ggj040lw0naQRJ7DYcz0KYnMSXFebjK
	WObjOQaSdRdNl3MQ2/sDSeP1+eErc1JRlauivvEZS0uYnA+TbdBTTdu6qMR8wG8z
	bCD6kJbE2inumHbsXAA304SRstW4rdSkz/lA8wbX5yNMD+Yvi7/oWDpeL+3XHKAI
	JewYq47xTfECJQW3P1eu/H69Hunz4yP+OX2eu5TeHU2DVmZwOU6un9SByjxoJ9sJ
	6ABjzhapA5pXSW/iArgl4fbjscaT5/N9YBgowikS/5Ia/nya7IJAf580MLNl3jZf
	0t5EcavX67muUntKXMAlw==
X-ME-Sender: <xms:VuC7ajdWmKU2Y-ZaD2R4C5B-FvNBj7gKLErHbiykWgo-PIBmFdqTbg>
    <xme:VuC7ap6NtRpBaS6nnFmlxQb9JV5FmueoHzU9UwoigSRRHljALM2bUwtq9pQZC8ewb
    Oi5cQd9nk9ZsfIpT70b419ZaZ7ROG0E0ptKHqtx3w1Tm0PbL-4uILM>
X-ME-Received: <xmr:VuC7aqsU5lXaR32qe_3Sew2kUk4fMV9tzss9YRVR32SP-7uJla4Pe4E4ScR-rkblYK_LAWrfQsfdFwVim0dw_Fl46hg0-Cd5pMHz>
X-ME-Proxy-Cause: dmFkZTFaoxNuIGeJDP4SuESghCjMfVdPNrMuJBZj07Qhfgfd0slgZEJUygs8O85SY/mDTp
    A2GcHf3z9GBA5ndPxWFQgEu6BI1yy2kgOCwH9V9XrgF6YfawAhZgUgPbLRvTv8LN1DBqru
    toqZvaeQ6/Hm5ZmrRYmYjwCz7nudOHRpw3F9iFvxrwjno/DN5A3LSA6Zcbi9pPFbHAwRFT
    nv7LpzOAw+SIA22LGlIyrChsp7bRMkjx8+cSclJ9VSu+WubGG+V5d+GyYgRHd3WkK4j/ch
    nEzplS+dzqGzIFEimB3NKqw1saXX9dprovfE1RdrxOjOClp2t78vbjj3ssg1J6MkprO3or
    QmtNHfAnDz09iZEouIMoxK0pdaaEr2LlSG2W105HH9rYGxG33aAn6YAV++PULe9OFKxVGa
    cC6CuOYjGKnFyAFpmTVYLLt4wN7wpDSyCWOkf1wn5ljQmZO6ZCIYPKPiRAGdYhG6T6rK8b
    B+h73rhcoITBE85WSGL2EDIZfm7DnfJI/or0XPRejzDyHNg7Z+81sA4LZbYy1qwNVQ5Q/F
    lidtSnfx2LQ9+CaLpyjNr8bqJ4RxLQ81IKz7pC7r4/XF0RW7HJZiwmTaR6OXO0bfIzGdWr
    8eG1kQgkvx/VMfWwlP/lWDtschFV5kVQxEaOyoGzwWjSCsGmjLIKSieExxgQ
X-ME-Proxy: <xmx:VuC7apjOefP6vKN-Ipp-w2LNJipl_Z31X291DEaM_UHHNRfdkshdsw>
    <xmx:VuC7alric9KpXUogR9olMY31pTxFJHi3AtiqQq9PsHH0f0lBZOHOkA>
    <xmx:VuC7ams3Ff66vFdZps2d4I7knezMemeFZyl3uM55EchN04SErlXL2A>
    <xmx:VuC7aoZ4A7NsPL_DWfTSpCt5sjOf5vQBjWA1pIWPOco8jml6dKDPSA>
    <xmx:V-C7ajZGSoYMIYdEDaaCngL0rkuJn_CRnAWkIb5l5RXCfeZJcPeQUFFD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 11:59:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Thomas
 Bachem via GitGitGadget <gitgitgadget@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] t5520: don't expire reflogs where it matters
In-Reply-To: <CALnO6CDMTHw9EqvvD5_s7WhFVhukr936ddhuJwdOhdJGdwmrRA@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 29 Sep 2026 07:48:08 -0400")
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
	<89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com>
	<CALnO6CDMTHw9EqvvD5_s7WhFVhukr936ddhuJwdOhdJGdwmrRA@mail.gmail.com>
Date: Tue, 29 Sep 2026 08:59:16 -0700
Message-ID: <xmqqse2shwvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> >    t5520: don't expire reflogs where it matters
>> >
>> >    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
>> >    bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
>> >    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/
>>
>> Junio, if it’s simpler for you this way: I’ll just pick this patch into my series rather than wait for it to appear in seen and recreate my topic on master + it.
>
> I've confirmed this changes fixes the test interaction between our two topics.

Wonderful.  Thanks for a prompt confirmation.
