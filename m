Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7C1F03D8
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477449; cv=none; b=E0SBYFj1x71PJYim7PzG7DY60ig+TXh2h++P3UysdWSV5WnbyC9D7cMp921rIoOjaPkUIdIlMXh/GQF+cDiCcRsZTblTjEpG+boU/7Gqe6KTGdpfQGrxj94mJiAei6dFCyyL2/GL1j1Gqh2hkI7ZbgA/3wUO7quq3nkXCenudeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477449; c=relaxed/simple;
	bh=CfujBqdCAdXuSl86rVoRWDBlnOdtPRYlzKN5lsVSsUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TjsR08/DsbfbpVBP9huG8iukoB7KwXZnC0M/1QQum5eNuCJKqb1xudSQeSGD+p5dIXXNHUD9BG5oNplwixi1nfB+CoA1xMR62hmx6JJ/wFeRGtrzVfWOus9CUwmNpgRmNgADC6UJDQlNX1rjKZRB0mNT2oZnNV42+JMxs7vb1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QsvH0EvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdtgHpGs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QsvH0EvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdtgHpGs"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 672FE1140089;
	Tue, 21 Jan 2025 11:37:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 21 Jan 2025 11:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737477446; x=1737563846; bh=E41jIvix26
	+9x1lTchnQM5ske1pWZ2V/PQU0VQu2FTY=; b=QsvH0EvQ2GTI3A2BOAcn3fmfbx
	2xLQzMmMN9SrMpo5jp9ALfiPTuvSFPZQiytuUp7fsL/7s2fP6hf3C6PL+My0eqOm
	6Szk9hdDK1UGhHvgQIAI4nOw3NGa4AEpHShojLuAcx9Rj3LqyZZVEvIATsieY9D8
	CMp2uBhiD9QbdmlER6lrQl2HSqqjM8hnpZM2VhG/saHZHUDsTU0RqItWcdEp/uZK
	rhregBa/2jO6GPGPB/0F5i2BxRsqk7Wq7g7mEhLMIBf9ea5jFjSwlAZaoFTIiKH4
	iMVn6E2mn2rMTN860dQFk/1feX/kQHeP/NEL4euOoN1cHvK/ns+7Ti6vOKVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737477446; x=1737563846; bh=E41jIvix26+9x1lTchnQM5ske1pWZ2V/PQU
	0VQu2FTY=; b=MdtgHpGsjB4RrX3rC43Xr4hFytuhb2aBYS+lZ6PaDMb2pDa+gJ6
	joAJ3ruTEj3Ic0qvT1i6uXYjkC8GqoHBOBeQJgWlo3P0ya76Wc8q3hoaFqigzudR
	aMak0ZGx5gIe4UDvOpkpFo2BHoRt70LFW+2nEzR+y9dyqtRDx67WNhKyddGE1NgV
	vD9b8mnrV13n/6cqvwJgPUXIGgLeyirilgppZjHW9UAvVJTL8yvt4Sg6MNm79Onf
	1H40D6T0to/98yL5RJqTAtG3tPv/FhRVB0ZaF9yN2kNAA1gAM8gATdbWbWOr1/J0
	cs9W1HRGtPhC1AHNngmpWNGxS+eIuxldw1g==
X-ME-Sender: <xms:Rs2PZ0ju3sZ0Kz_a0_AGFq-IHipfrctvAv-1tR1hjPgQkg-_sr3Mcw>
    <xme:Rs2PZ9BAVlmeFYKRdkd8_TH0YZzK_okibaAFv7DGv0x3StV-yHcPS4FDAHCsxJZlX
    GnqXQwxPVmJPJEKFQ>
X-ME-Received: <xmr:Rs2PZ8HQFJ962F-fntFIilt1DlR14tCm88RpIFWe1k0xHjaqG1x98AUZ4O_Pg4oPj4D2cfYC1oOsGheQlI24dE_k9dPp4G9yGczS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehkohgrtghhrghnsehprhhothhonhhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Rs2PZ1S0OYQvlJ7pSLvbOsIe8brxnErrichfE8jKzuqLjBLGSthAFA>
    <xmx:Rs2PZxwESXYZKvTVYRk_fyo8TD22JS5xNu8JgGtMn2yGlmcbwPZePg>
    <xmx:Rs2PZz6EfolHI4qe0w_hovW_SNnEhZd5KeeHgiHFHYiqkOP_Yb_knQ>
    <xmx:Rs2PZ-yTc1W-ycLjNqjzcaJfcV54nrXH4YNNWIVtRzUW-Wbqr4MmSQ>
    <xmx:Rs2PZzs00xalYSUASIwcVtfyQBH1kER5cT0KxPVVYXH6z15p0Jf_q6vf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 11:37:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Koakuma <koachan@protonmail.com>
Cc: Jeff King <peff@peff.net>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] git crashes with a SIGBUS on sparc64 during pull
In-Reply-To: <OZMxBc6aAmluYw1_O-0ML1kM7cHNUEuFuhQwX-jurD482L-tjh65TOSWSq-hRzVXvQ2Bnz5SRqzWphewMPH_j-KKSdRtI-f_aNCeIkDLVSI=@protonmail.com>
	(Koakuma's message of "Mon, 20 Jan 2025 15:20:35 +0000")
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>
	<20250117121121.GA2356599@coredump.intra.peff.net>
	<20250117125207.GB2356599@coredump.intra.peff.net>
	<nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com>
	<20250119131224.GA1541095@coredump.intra.peff.net>
	<OZMxBc6aAmluYw1_O-0ML1kM7cHNUEuFuhQwX-jurD482L-tjh65TOSWSq-hRzVXvQ2Bnz5SRqzWphewMPH_j-KKSdRtI-f_aNCeIkDLVSI=@protonmail.com>
Date: Tue, 21 Jan 2025 08:37:24 -0800
Message-ID: <xmqqed0w2ke3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koakuma <koachan@protonmail.com> writes:

> Jeff King <peff@peff.net> wrote:
>> Here's a v2 which fixes the reading side, as well. I think this should
>> let you get through a full run of unpack-objects, but please confirm. :)
>> ...
>
> Okay, just tested the patchset here.
> Both the testcase from upthread and actual pulls seem to work well now,
> without any crashes happening.
> Thanks a lot!

Thanks, both.  Will queue.
