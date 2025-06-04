Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3128F51A
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040363; cv=none; b=AoL7CD5e4lZmjxOjdGuxDnmOn7UrA9z4FmMj3nQWXHUy5QPTIri4kh9zJXRZO2hE/yauWtZl3KP1Mbg/pRApbEjZz1ckiTG5/EGOl8CLkXfN6Yb7FVY+dBmg9eiTtHGSPC1vabljeQXYVpafMRogHMRobTB9eolSMr46IaF6TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040363; c=relaxed/simple;
	bh=yK+jqEK3EaYh750Lm5U0n2i+vHVoSRJ0Wlob/momoq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4lOdkI969BVVmwBN5Lu6cdQ3ygDEdYrEb246HMh1PuyH7SYVLIwsalqm3JDeE7p/njBnhSqpz6Jx2dUiBVdJVSqJEEQR62jU41/C9tEo6Awc+2SVuTZsxVQE9kwMxeEJfj6tuygqzQJEcRWwgA6ZNNv/rn/SBqvDhIQCl5Il9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jq/PVs1X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpXinTbd; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jq/PVs1X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpXinTbd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 317A713804D9;
	Wed,  4 Jun 2025 08:32:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 04 Jun 2025 08:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749040360; x=1749126760; bh=K9trtx4ae3
	mFdbTQjrWoG3gAXG07+xSv7Ntcrb//UCA=; b=Jq/PVs1X/HqqMybHGveGuRKaCj
	DJCyCV5vI1uuSgWKSI+eYq7vzJME1RGlZfJvVQAI8HUM67fwXWlwivftHobiQlBa
	7/19OaBiHUajSRE4MSCvC6XA6Om5Oi0M2NiNtCW3IAJxAhCUXTeuRJCcnFHZ0FjT
	SQG/mg+MTjkGRpRrrLTSQO06xF18DWAH5UpZ5gpXLlsf3b1a4h5iU9+uuRkmEk8f
	nox93on0vkGDpUE96bfqmrU0YpdunhkXa4sCYDAfl8n0YAdxkJlVKFHtJBCW4EAd
	L+uwEaDLrnK2n1480/jN4hb+CmNnhsuLNVSFF9vUx3grLF+NFZSkA+rAS1Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749040360; x=1749126760; bh=K9trtx4ae3mFdbTQjrWoG3gAXG07+xSv7Nt
	crb//UCA=; b=EpXinTbdw5Kw1PwK3SaXxPO0EnYbkNaIDNOBqJWmdXrt0tIl076
	5vGcOFJqNasB6C8nNbqyMgsgL2TbA2jDCB8zbal+dhCRCrS+HIV0bmnZm6dBQv11
	MrLI3UD+TIBX8fsb6kw4ttXoK7GCIkACZM8uQgRo2iw9DOJYiRy488d+9DAexk9y
	QBE/lui2Qwf6fSPodGYzXNXLfVBvEGzFIqKixaQTfNsxpC3xsZxi6WDf3Im1xepq
	GacvyBvrW58RM8WIKo0mSgvtbARBjTZDIu7W6G1BDz0axwZOXWMngHVZPtFmCr1D
	7ymB+7irZOy+YefzWT33eBnHeDlaKTxo77Q==
X-ME-Sender: <xms:5zxAaBreZkBPrgRsKPXHKRANdvNZ4SWW7CyNnvxpSdGrKE83jSVPaQ>
    <xme:5zxAaDoJRmuR4Gbt72x-I-V70YjNzsGL11Nu8u_RRGaalMHwEtEja70xTi4c5LwBT
    ZAVC14KYxyzS3m6Bg>
X-ME-Received: <xmr:5zxAaONh9F1o9Mge6SkNyLORj9i-f5NbHUCEaEPVaEVDEfMcQewJ7m7ny_KhyDZin5Np2Q_KMD56hEEZIJ9Xw9Oi8PkcTzNMEnfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughith
    ihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrggtohgsrdgvrdhk
    vghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhooh
    htrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5zxAaM4LJ-2ChLr6u0I03cuj9EwvbalAJ_m3RrPDvfdZXXMnAUVSVQ>
    <xmx:5zxAaA7fZtBvXJa6dP-bRW-wEghx6RcwNs_wNCW-ywmLW39aYntcQg>
    <xmx:5zxAaEgpAm6hhRCm3LI4JeevwSv9FRmxKoIFsOUD4aZeHofA6iRezA>
    <xmx:5zxAaC7V_7jc0ymGhoDrnkdlKxZZUfK4KqrxA4SEtYPeU-_hsH3wWA>
    <xmx:6DxAaBwmaG9pihSEiN8NrClWxh1Q4cZsv97KiGboUhURh9sK73afSoq6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 08:32:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Jeff King <peff@peff.net>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Zi Yao <ziyao@disroot.org>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 2/2] send-email: show the new message id assigned by
 outlook in the logs
In-Reply-To: <PN0PR01MB9588AF2A370D8A1F50745C97B866A@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 29 May 2025 21:48:46 +0530")
References: <cover.1748529954.git.gargaditya08@live.com>
	<caf46596a709df7205495b75da569baef2c7c9a2.1748529954.git.gargaditya08@live.com>
	<xmqq5xhjmmno.fsf@gitster.g>
	<PN0PR01MB9588AF2A370D8A1F50745C97B866A@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 04 Jun 2025 05:32:37 -0700
Message-ID: <xmqq8qm7g00q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>> We do not say "This patch does X" or "I do Y" when describing a
>> change.  Rather, you give an order to somebody who is modifying the
>> codebase to "make it so".  Something like ...
>> ...
> Ok. Want me to send another revision, or we good for now?

As the codebase will be frozen during the rc period, I am not in a
hurry.  But submitting hopefully a small and final reroll would be a
good way to conclude the cycle.

Thanks.
