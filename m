Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328F6F2F2
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068186; cv=none; b=Hlvao3f5Ll57aVZzZyHhTTIfCIiIr4Kp+AfsutujHfISn1J4aDZik5j9qtwAxFN+NeYJumI7AtvoXNW5ZE84KrpEdGlHiMNa40/L0aYmIAVSRDJGsk96voioqsx3rSeI99CpAPOPiFc47NIAz5Tg8eBSTffuvKi2uVcbTfs+zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068186; c=relaxed/simple;
	bh=19fjQEQqWd0H19G1IxlrzXkqXDyVc4tkLjU8iTcHbks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqxZntFlip1MfLSYjRy6rPSm34v8KVweDB3K1Y6dxuwgmDm86vtYFYZ6rC4d0Feqa2j5ekJLOw2aKbOBjzVEhwSU2x8fcxuY8a0GEOd3rtcOAAQi3zvWsy/ofxproUyV3vvFRoJkAVlYshd7E8UwEU+GGBUR5YcmExpRc558LCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ISWxdSTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMaDgO0o; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ISWxdSTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMaDgO0o"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 783961D0161B;
	Fri,  1 Aug 2025 13:09:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 01 Aug 2025 13:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754068183; x=1754154583; bh=kPO/v26vO/
	FES86G75LLS0e6IL/3DHymSnteDh606m8=; b=ISWxdSTZUNQ+rGw7y4t9eoWzTZ
	eR0qmVdgo0Ize84BZe4qI5Q9h0GmR2HRpcdJdnCeHG0KC5dPl4l356QFNVcMLl3W
	ZgEYAIMXs7S6Kyg7rwztobATytPLFfmg0RHllKblCoaUgaCACcFuaRiVBXBcu+JW
	9/l7I+7kvRb6gSPZgJNGyf0GV0qBHx1LVLAzJWAin3IT32SdbZKHrT36NNwEZyaz
	lO6op3m0jJDu6F+TH4CExGeZ6ZW9v3S2I7YlxUnEMAu9wS2Q623QZXWIf+Hu5V+y
	8jxnz4PV55nHQMK639+cEpptiZ3hhVJAMiOlPOi31A+sVzQCi6hC9BlEb+lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754068183; x=1754154583; bh=kPO/v26vO/FES86G75LLS0e6IL/3DHymSnt
	eDh606m8=; b=fMaDgO0oKoE/MoN2LTEg/gWE15hg0/52ODppxD1IITH7YzF7LvA
	9iPX1jKeBFv1aQuIHoPWlBN5SCiXYAgydNYKFKAPwTXTad9xgsWxws5Gp452BJLd
	Jnb9r7+WtDIAGfEWwRjAuCwotw+/1XQ0tb/giIMk/PZjAYW5fu8qATa6+nrBCU9j
	NDn8LSchnKDmwMTavJjb8AoZYY+kFjxtwixBITR3DBYDYl5OOTEGZdowZramFfS1
	k5JQiMj8/fpLW5Dsxoy6m9jzHrp3J6N8dRrF9OC9MxSk4/TYAmBLbY0VDByGbEfX
	rI+b6pdZglhXGlzpDpszLO/tSbsOVQWdMpQ==
X-ME-Sender: <xms:1vSMaN0nDF55VXvWP2Q7cTye6Ifyttltl7W8nPCNm4KYfembHMBnxw>
    <xme:1vSMaPy_X9CMoWzhrK5rCZ4t1weycO_SaBFfqg_DB56IWFtxJDBtGGjbpsbqD2OOa
    X1N5B3lqN597HR3_A>
X-ME-Received: <xmr:1vSMaKUnBnRsaOFgm5RETmDikWFiY3dDKOg8x_g-tFr_yepDMwOTAtk6dWgyQIxWMFNdGMt6FC4RWTd9lvCmvuSBHfS7Mk7vS4eR3c8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1_SMaD_3duyHYSUey-BRL9HkYHd-Dh_yrFB8inkCc1luutoBZKYkZw>
    <xmx:1_SMaFtX4Plx-GJeVCLkFUJXpMMJZpSsVbcaKvCcr_IfguuL1bEAsw>
    <xmx:1_SMaL1cpfhCmX0TJGYL9676Bl-wwoRhBinecBiTUcijJ5LgMxQwIw>
    <xmx:1_SMaCRbaJa2trPEb5k3-4GQM72jhsOEeHfTBIf_bVEO0R4OWOrLaw>
    <xmx:1_SMaMOrU5EpvTqQ_8CBZMwJJBwLKgA9y02B1RTSp_JjaO8yzM8F2-zu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 13:09:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <87ms8jui3p.fsf@iotcl.com> (Toon Claes's message of "Fri, 01 Aug
	2025 18:22:50 +0200")
References: <20250716133206.1787549-1-toon@iotcl.com>
	<20250730175510.987383-2-toon@iotcl.com> <aIsQWcHf82ipHoWf@pks.im>
	<87ms8jui3p.fsf@iotcl.com>
Date: Fri, 01 Aug 2025 10:09:41 -0700
Message-ID: <xmqq34abm0iy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>>> +-t::
>>
>> -t, --tree-in-recursive::
>
> Sure!

Clarify *what* you do to trees in recursive by giving a verb, e.g.

    --show-trees-in-recursive

perhaps?
