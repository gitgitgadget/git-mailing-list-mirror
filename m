Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28013B5AE
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788114; cv=none; b=SZijeuMJmxeOiAmcy2MhgE9iFYQVwaYyUROMgEIq1uXQEI7BIG6/mhCZp8NVaHE9qrOKUNRb5WiXTiPIDgFYJkC23nPSaKvUEopuqb3AEdPWdRQ5SeWYFBb4vDExhpvm82jP2xazz2zNtSQ4eqJObxV5bU721ZqFq+xt9Zsd828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788114; c=relaxed/simple;
	bh=7VLEOozb3TEQATjBvaLYmHTBM6usfYOOFN6k367hJFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFIWQyw+6nsa/BfbMLVHG2PICmv8i2ps+LKIT3+yEiiCU8cT+V0W2KCV5J7j7dr5E7Cjhh1Y50oomUAvGuvmQeO7v9RRRVB34gavvPycVbxouBlj8ZwLvQQzwTzmbXOh8eiC+4k9BEesNVJr5CDDvFz5WP9viEh26rUAOjVk54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a6Mjje1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=majpcgXK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a6Mjje1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="majpcgXK"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD770140015E;
	Mon,  6 Oct 2025 18:01:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 06 Oct 2025 18:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759788111;
	 x=1759874511; bh=J2F2aIcq+r+3y8pG7pj3N8COk9m/6o91GlHmoXO3F3o=; b=
	a6Mjje1oaiB2ptoa7Pv7/oso3V0jU30ilO7UuM7PZM9PbujmQehJw+1ughmwKvuT
	cZqYSfTwwR9JqPwXK8jD9gTZ9i/9R+usyuBuiExUebwbbsdye/BISjacxadxYAu+
	nBbZlBitkcVbeKeDr3n8P2v5M+os7LsZs+Qhjj5QF6DUdhuX2E5Fi2BodOaArP57
	+JzwSevqkya/yFa/f8Awzw7gjxDwtZCNJKxapV9EWQQIAaqp/cwKbr8PZlU4I005
	GgSw+SW/L3Cvy/bAjYbiapVfg4f42RcNILMdxM71bM8J97Ij1YP5rseB9x47jhnP
	EqX3QRqJ3Dvub1bVOGdnfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759788111; x=
	1759874511; bh=J2F2aIcq+r+3y8pG7pj3N8COk9m/6o91GlHmoXO3F3o=; b=m
	ajpcgXK4laNuKr4yVweLBCdvCyg3iLuo1veTSuTDg1Im1OYrnkqjQOk+ATugcn1j
	yUkKCARCKtx9x2yehORHyq7kk9zdFQozB1Q7Gq39CDB7Xi9pNEcITR/uu1nCGrbI
	xhF5TTfJaE9PUoa3JQAkFJuMI5eYyiOa45YxzSXHsVfudDRNGv//7tJBtJOofg4V
	DsQ+aYrRNHKCwlv3YZbAUzV+/0xG3PiCBFVRiAb7QvYhcZ76wcm8bixEx9qKM2k3
	i8dHxnRhRbYE8MtPuFXoOcDVjKrYS7vMxhQX1Bh2N0a8p7iriovvdQeaeyryOkQj
	GsGD1Tgi637Hd679jL9gQ==
X-ME-Sender: <xms:TjzkaI8IvCgKxFeUxI7-_cNDZLB5npnO5-s4PgoT_iH8a0DWGIUeng>
    <xme:TjzkaCNJNbNE5S4uVCLb6u94pHlKWgQfvsMKxS3op_DsJ3GaUvxHoWZWJ3Xku0pQ7
    mdkbVzhZ9eC8Izqx7C4oTEEBjqFCnZqbP2tJW3jcUyvJmjFJqqILVI>
X-ME-Received: <xmr:TjzkaOFSvyiAADqtDbOn0erCMSP9quI6XQM0n5ajB3_wrjsh8WvmtP2MsTvfx_fBYQGZexYKRjEdPh77PBdUPp2BVNL3Nr0Ag6EW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdifihhnughlsehu
    khhrrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TjzkaITJVMc4qZfDB--qVH2-IVg60Tq7moBYf934olMkKAJuVWl02Q>
    <xmx:TjzkaDutD6CtsPlAwE3eqM1hKh4Sub0mialAfw0SRJ1sPDVHpb9bFg>
    <xmx:TjzkaIIFJRDzpIKms6bO-I2IUIYXoLUTuG-D6v8JS0Su1NgDbDIqPQ>
    <xmx:TjzkaAl_UTu2e-YqQOdJUTzkKoqW5jAfVqQNrqzmsKcFyWpgLuitFw>
    <xmx:TzzkaAlc-gPz9-4x3eDr4mwId6IHaCuIMaBYSmIVISPAsIpt6TTchzF2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 18:01:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "Windl, Ulrich"
 <u.windl@ukr.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/6] add-patch: roll over to next undecided hunk
In-Reply-To: <4f4e5627-0804-4194-98ae-3345c992862d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 6 Oct 2025 22:05:25 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
	<xmqq4isbq59z.fsf@gitster.g>
	<4f4e5627-0804-4194-98ae-3345c992862d@web.de>
Date: Mon, 06 Oct 2025 15:01:48 -0700
Message-ID: <xmqqecrfofjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 10/6/25 8:00 PM, Junio C Hamano wrote:
>> René Scharfe <l.s.r@web.de> writes:
>> 
>>> Changes since v1:
>>> - added patch 5 for a and d
>>> - made error messages direction-neutral
>>> - removed stray "only" from commit message of patch 2
>>>
>>>   add-patch: improve help for options j, J, k, and K
>>>   add-patch: document that option J rolls over
>>>   add-patch: let options y, n, j, and e roll over to next undecided
>>>   add-patch: let options k and K roll over like j and J
>>>   add-patch: let options a and d roll over like y and n
>>>   add-patch: reset "permitted" at loop start
>> 
>> Will queue.  Should we mark it for 'next'?
>
> Oh, already?  Fine with me.

Was just double-checking if there are things you wanted to imrpove.

Thanks.
