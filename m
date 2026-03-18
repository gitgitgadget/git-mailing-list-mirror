Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877D264A9D
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863158; cv=none; b=s5Vl2b+TFY+Zhb1cWb9J1PAUBgNdWmsHPMdKoo+1Cd1qy+Jh3eBGbtoJCqd3OUBJtmNqSesTNOnyk9uFzec9GZ6Ma7RqB2EYdA9UKWK0I45NuVX8KLwarfBfufUf+clRH9S4nQcSR/zrkkYjt9j7JF4FAyVfkjPGBDNnJPP5S/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863158; c=relaxed/simple;
	bh=kmEqwRxiAFtIlNEcAsUrXLW6q8jpLtTvaY/eBUhJXxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JBC0gDkhAyBax+OoNjcfc5KnvTBmQYk1GY+n+ockbIJF9o8DU5mi4WH19aioUOjLixY2+6i2ffurEkXJY9l1lXg3PIEt4xBMLuIesVUOwE0+/m27PvOT9WnRZEqbw0IL0aHEQBZTu8H/NtdlMG01k5P6OMGt/iXoM2TaOIeATzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OadNiuUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1v9a8WG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OadNiuUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1v9a8WG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C01C7A00E8;
	Wed, 18 Mar 2026 15:45:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 15:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773863156; x=1773949556; bh=4tMeMYu5yL
	Py5XRLyVYn5EWqYqYZRfJaX/9qSm2lk/I=; b=OadNiuUf9upjB8XjNv3Whj+vkV
	zrNIlQwhYqWbkxThlhdrWDOqFpzEBeKfdBpE494iiEIpfcxHFK2zGzkznn0kHCW/
	8qGPqrLwpsxEtTegiUslBusbXNHCizMKsn+e0GqVyJ6QZXFebX7SVUCb9LJ6ybsB
	5j0I6A0RaDNiRI0pH8tpvYnh8DsL4YstuLOD9HMp6ZAmDxUAObYRA06lRsGa40VW
	MRyeWsvOB4V7PeOsbN+MTSOIk43OaRTOFZN+NuX9IK8jfnZfn72ZvUPn/MxWLz2N
	G8xHWhOJDYcLvkpWNUttdkPCMcOkvcg5H2H8crG2COLIuHun/x0okUu8qRVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773863156; x=1773949556; bh=4tMeMYu5yLPy5XRLyVYn5EWqYqYZRfJaX/9
	qSm2lk/I=; b=a1v9a8WGhWJh9Mv3bT03Uz7oTJxZuU5+xMnlN8m2MmQxoqcvoto
	SX5Tu2CA17zsU4kFfqwW9BICkrrbmMxmm7qxJsrMx00lcBuFCmvoeVE8eP/wd/D3
	2I1OR3vprWSyxMtMPoR1zB5qaNKTRVpPWZibUUzuZN27lyX4m49WXbvNPalxai9b
	AKF7oaMEr5rPwg1fwkR9lfkIxQz6SjzrH/nfDDFtU+72/wHeEGDXHYyeZKjG/4mL
	ZcHPn93htLZw0pSbd1Eb2aTEAZ0JEsE2Ps5UyhO4Fo5yr6MrS8lIBoNgU0SCtpFy
	uE/gOHAjESWNmbrvckwmcsnNHJYkhgIvapQ==
X-ME-Sender: <xms:9AC7abycuOeMtXvLFDVX0otENmq2-eifEPMSH2pdgZTLt5oAeMhcog>
    <xme:9AC7aZQbvuSkenzm3wOYV_96xHTe9-NcOqsiqX0Vh-zdcfweHCB2vwFMibXDY74Dr
    Mul9zbNKmdU1I98I7YLSBsQl9UBN06CPbsc_aqfruHLdvJ8RHZ_2qU>
X-ME-Received: <xmr:9AC7aQIf6YkqPeNvQwbTN9Gokv4j9Dvo3O3LsvBSrP6nVjIIOrr_kb3eILy1mVpB2_GqTKx-RrFy43UmYexZzuPCg6tGVHQF5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmsehgihhtrdhsthhrohhvrgdrughkpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhnhgtrg
    hikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9AC7aYUQaD4TNkeK2B5RrJEmX4kvPvG8TbJhoCrY3p-yOCt31zdZDA>
    <xmx:9AC7acRIPSuXKHGCi0GJj212ZeOaM3I2iTZPf810lC1iXQbYuC4hrA>
    <xmx:9AC7aYCZoOdD_SJMVlf504_xYULFlJeH0jHQRD3XZDj8JHoWCfpaag>
    <xmx:9AC7aTKfmGJKdnRmfytzCyFbLwz5ny5UAPbarLt_Y3UlKFVZn28isg>
    <xmx:9AC7aSO6uIqSf33XO7EtpKX1Q-hDmYZhLNzZ1hXmnZtY19WYB3ZuvAbN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 15:45:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mathias Rav" <m@git.strova.dk>
Cc: git@vger.kernel.org,  "Phillip Wood" <phillip.wood@dunelm.org.uk>,
  "John Cai" <johncai86@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  "Patrick Steinhardt" <ps@pks.im>,  "Karthik Nayak"
 <karthik.188@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a
 worktree
In-Reply-To: <94dd3222-42bc-42af-8d97-5bd471a86fcd@app.fastmail.com> (Mathias
	Rav's message of "Wed, 18 Mar 2026 19:16:06 +0000")
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
	<abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
	<c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
	<94dd3222-42bc-42af-8d97-5bd471a86fcd@app.fastmail.com>
Date: Wed, 18 Mar 2026 12:45:54 -0700
Message-ID: <xmqqy0joq5u5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mathias Rav" <m@git.strova.dk> writes:

> On Wed, Mar 11, 2026, at 6:44 AM, Mathias Rav wrote:
>> Thanks Karthik, Patrick, Kristoffer and Junio for your feedback.
>> I've incorporated the sum of it all in this PATCH v2:
>> 
>> - Check !repo before object_id and add a comment
>> - Use term "linked worktree" instead of just "worktree" throughout
>> - Use git -C instead of a subshell in test
>> - Remove gitk's quotes from the commit references in the commit message
>
> I'm unsure of the process from here for a small bugfix like this.
> I believe I followed the SubmittingPatches document
> by sending a PATCH v2 with To: Junio, Cc: list and others.
> Do I need to do anything else to see this patch eventually land in Junio's tree?

Pinging like this was absolutely the right thing to do in this case,
as the patch fell through the cracks.  Will apply (assuming that
everybody involved in the review is now happy with this iteration).

Thanks.
