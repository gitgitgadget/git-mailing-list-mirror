Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70729463
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266251; cv=none; b=b6UrhxbQ4fNhp500uSDHspivJWKQeBThl4U9PglnhZdVsjAqDeBwaxPCr3pJxIPp5CCSRchIKo5XjbtDtENAdjPMaClLoUbnJZU0+1nTCxtU5m3q7jA7X/oscV0qDyTSoMP16UAZznxDVaj/EGC2/q1chXPy5ECmaj0klDfCzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266251; c=relaxed/simple;
	bh=eepgeG2arGPPPSh6pe93568A8kjl+49daTv8gYU7iks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBO1bOC9IsvCHQS1N2/pPuIyrIT/wu+pnAnbKsn5euvvgQM6T9+g/pr77E7DeKt2xteCsL8z00vIpl4yXcq5cRQ3fQ0KUl83f0xhQ19Ow6uxIkJmg/DWt6NouNUSOyuwdL9CxbA5Dezm4Eh6QcSD0+wIaN30eLd7spXcgBTIZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fv1s+IDC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nshb8Bpe; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fv1s+IDC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nshb8Bpe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D98907A007C;
	Thu, 23 Oct 2025 20:37:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 20:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761266247; x=1761352647; bh=HFtGI2rEVz
	TX2lNJCC8xPP+6CuWHHShFGKTfW1ToNHU=; b=Fv1s+IDCPhFv15xusJ8hfWlCCV
	8Q3FsC4merBPNKmloMJ+8Rq7cQ3CjBWCsXPuMzIpmpFzeuv/B0JFgS+0AUieBDQT
	JkS41oBxCzFGaCDIfTO0zJZj4OyxMXr8evylwtuk/LmUGXvJ9FwsPfQfNZj5jRck
	Eb3W8CbzAMNxRluQfQCHyynASf65hIzQvWvWHcbDpC6WE9F17GNg+kSIwgkmrXLF
	upaKywuFvW4wdUfgHuGA9Mr5ysi5DZ1vd1JYT5xVsL/IuiV8hDoLvOsfA+ZmIiTq
	ApiaMZrKg+GuieEQD2aSK8jit2A+WKZ9K1kFeCvIZ2OkiBoUtw6+sQ8j/Wbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761266247; x=1761352647; bh=HFtGI2rEVzTX2lNJCC8xPP+6CuWHHShFGKT
	fW1ToNHU=; b=nshb8BpewQdP38iQE1ZVDsS9dVpV4n/TZIMg/Au13GEQHrRhHoa
	5tPKETobkqyV35KPrfnZInjdhQy9nEgw+0PWd1wC1XVaWfUzzO0gL+pSaXOXBYk2
	Ip4gqreVPApc4kFwrSP1hHwDATMqCxi4qD+8817sEYzPET+Os63HP3P+b6D6hFiD
	qHCiqdOYdBgVvNYyAKqWnS/dV1AkYl/XVE7lSTCQDihbs77iCAeC3CPHtF3Rz+Xw
	380aOucsXVmUS6uUFqNPP6fguQvZtXb0n2un0dKOkTO/PTVktL8Rc5jM1A6zlqyr
	sdljtztXYJth4XkNVR9KfiSCKmWVSeVEEmg==
X-ME-Sender: <xms:Rsr6aCemaiexQ3BgJ3QjKP35u2Whhy0HYvoX9vnUFF18Z7jqsRivOw>
    <xme:Rsr6aLTDDCalKgr0EsTnTMmTKK3PjQHVR6eWXtZR8eCLvoPu_TwuYaydmMGqIaZaR
    0TczAzBQp86b0o2adwJsISuIo6-fgVRWF7thUcuzwxS5RZB3X0e>
X-ME-Received: <xmr:Rsr6aJvJv8DAb1sUN-swW0pmPuZcefArUj5zTfiFtOsNVOs6PQjFAOWyCiBTvHPM4gO1_4ISTV7nten2RunI87xV1Ioi94ohs2_u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Rsr6aMc2lxprai6aKWkIgOsekppt9wIrK_c5Ff1oj667j6pV4MCoyQ>
    <xmx:Rsr6aDarS2fKipTqvDXs108FqXif2LZdmPsL7qwNxyEXtthk8InRWA>
    <xmx:Rsr6aOZnioErPPuAtDA8SMOPv5DAn-1m5Jh_hfmdMxLusmIh1dvtpQ>
    <xmx:Rsr6aIIxEkApROhnESybtz5u8XRHbhRbcw8NfaC4aM6b9T_TbmneqA>
    <xmx:R8r6aPeysRr9g0WcnAVcVSe7O2I_NwMNLWnbazEx5WsjTCvr_lcIiCi8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 20:37:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
In-Reply-To: <aPrByfpOkQ7biyEI@nand.local> (Taylor Blau's message of "Thu, 23
	Oct 2025 20:01:13 -0400")
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
	<20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
	<xmqqy0p4uoqc.fsf@gitster.g> <aPgkwnq87UeusC6v@nand.local>
	<xmqqecqv1trk.fsf@gitster.g> <aPrByfpOkQ7biyEI@nand.local>
Date: Thu, 23 Oct 2025 17:37:25 -0700
Message-ID: <xmqqtszpqgmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 21, 2025 at 08:48:31PM -0700, Junio C Hamano wrote:
>> > Practically speaking that's probably OK, since we are unlikely to have
>> > so many active paths anyway (or if we did, we'd likely have other
>> > problems to deal with ;-)), but it is gross nonetheless.
>>
>> The case path_idx() returns -1 is an error case, not "there are too
>> many paths we are following" case.  I do not see what relevance the
>> number of active paths has here.
>
> I just meant that we are unlikely to ever have so many active paths at
> once that (size_t)-1 would actually have a valid entry, or IOW that
> active_paths_nr is smaller than 2^32-1.

So?  If path_idx() needed to signal an error, it will return (size_t)-1,
but as the compiler correctly caught, the code as written, i.e.

	k = path_idx(...);
	if (0 <= k) {
		/* did not error so we can safely use k */
		...
	}
 
is outright buggy. I do not see why it is "practically speaking
that's probably OK".  It certainly does not matter if the number we
will receive in 'k' in the success case is expected to be
small---the problem is only for an error case.

