Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45622187332
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994230; cv=none; b=PiGjwsp6Zu43SXTLQa6zobGvwLzSNz6TjYkdDXhgd8woNFqNyU3WvPsaJyTP95d89nxyAQLraQi2vliS3rxpUphgZcmIs1nBjZpXhdngwZ2kDv9oZ/c+cP0lHuTLjmqaGNIdImOm5VX6RbXFVwU/1Huw/aopNBIfZgrpfsB7810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994230; c=relaxed/simple;
	bh=pa0Gv38jKbMF9LdPU7dFnb+dLQ0KitfWQ5rKGUE9HdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUB5YD1u71VV26byxtCe0rXhms872wWNun5YT7j6TdlI/HmZvI1ZHpGY5BZnKt+o97goAISFvsxRCV/LRFlMshT+/bGKViEgPs7wtmceKU0XH7A2rfRKUBKQEnIzDRyMS3oG63nQzkjvRi7RIUDzlqpzqesoenLxb8SGmLkbJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mkUrmNJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDSmme5E; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mkUrmNJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDSmme5E"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F78D1380B43;
	Mon, 27 Jan 2025 11:10:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jan 2025 11:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737994227;
	 x=1738080627; bh=pa0Gv38jKbMF9LdPU7dFnb+dLQ0KitfWQ5rKGUE9HdA=; b=
	mkUrmNJZs8x37OvPmwRsn5QH8GcvVM3uUwCiClJOJ7Gd6nn36WQDvMBwrB8bZSeh
	4nSRssm31uPxBAgs49D1DfasIZhu5vttIbrMo1EkPB8o8FK22FPFIyVB/t0T0jan
	UuVtcTft0KizuBqcxi5S41ZBs2B45sHYiQ/p0QKXtQlose5UTvnith/RNzZErKTQ
	pAcYxspXa1OfFUXwObarj0txRVwTWhTzYMdHPNYBvOK6YZD3Y6Jo9QxnTQv+Fw57
	RJbfw3RkYIkWw/hJaTk0k1YKbU55vvr1D4bZHQKKeyZwYU0T+lt1rGZvtu1XWbDV
	MxfErJfxPt51lSd8lj5fhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737994227; x=
	1738080627; bh=pa0Gv38jKbMF9LdPU7dFnb+dLQ0KitfWQ5rKGUE9HdA=; b=N
	DSmme5EOs/8gW8hXCWZSWQzQox0C7SKmSHXwO6g8+jpi0FPBrGqz53HjcpaSCc24
	37hDuxxRRfI8n3s11oKnV2chxN5TUOIyc1q1yHSdBhGAFBd5JFxYsKjnUznyDi5c
	2h7IlE9rO0q9t/Hl1J42jCMRoNx21AQHq03Qqx6Qu+wTRwItpqmfF6F1flZ8yj+Q
	9tBPArY0/3L07pxvq5/4rN0EukcVk5bc8TXyN78hi7HxOgzOGcjTEK9VmYWm8KK5
	pvrPtRvgMzmf4gv/z0gYaRxISa00QmD9QeZg7K7IHH2W3Ridep4hppoquJOO2E//
	z7lxlNxXsvQv5NhVKDtew==
X-ME-Sender: <xms:8q-XZ682tIHtZFtnSdLa20w7trgtDilyQv9d0bi2FcRffTeiEERzNg>
    <xme:8q-XZ6ueJpY2fHwPcifUl_hrKaQ4zd8ahR8uxuas6uLdMIyGNSnT61nwreoCCYNBf
    Rm4TWVPyuv4Qc0Y6A>
X-ME-Received: <xmr:8q-XZwCJAyj0O1T6wsQiR2wyE8vplTqaO0f0FA1WwRLniEPGmJrQ771l4VUg7lk__C2Tr_6mtWT_CkkY8SwK2TG2wBRtwFY32G8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtoheptggrphhighdotghqgeelhhgutggpkeepmhhrhhhhjhguthhn
    higpkhhqoheifihgiehnrhelkehrshgsnhgphiigmhgsrhhqiehkrgesmhgrihhlrdhgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8q-XZyfBescch2gA-tJqwR0FMphK1JPLdcIzCFjpx76IxBW0Y67gqA>
    <xmx:8q-XZ_MLBVdY6cOkar4RhBzr2XSKKxDVlDL-rpAlJRHPoAfIl5gUTg>
    <xmx:8q-XZ8kEzdQsYDNW95mMC37OPz6Ssja55q6mINfjP9AaqPJ42OzJpw>
    <xmx:8q-XZxsxgfeJqWNhdiqC_BjrC_LrLjBBS4oMCe2FPpZCwZokS-DDkw>
    <xmx:86-XZ6cp8WSz2kRPT1YTh0HS9orXkcqClxOjbQUorjESYmgYsa3Wdd_y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 11:10:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com,
  git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  =?utf-8?Q?S=C3=B6ren?= Krecker
 <soekkle@freenet.de>
Subject: Re: [PATCH v3 1/4] add-patch: Fix type conversion warnings from msvc
In-Reply-To: <Z5c1EIXi7nsB2kJe@pks.im> (Patrick Steinhardt's message of "Mon,
	27 Jan 2025 08:26:08 +0100")
References: <20250126125638.3089-1-soekkle@freenet.de>
	<20250126125638.3089-2-soekkle@freenet.de> <Z5c1EIXi7nsB2kJe@pks.im>
Date: Mon, 27 Jan 2025 08:10:24 -0800
Message-ID: <xmqq1pwow83z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> Note: the word after the subject's subsystem should start with a
> lower-case letter.
>
> On Sun, Jan 26, 2025 at 01:56:35PM +0100, Sören Krecker wrote:
>> Fix some compiler warnings from msvc in add-patch.c for value truncation
>> form 64 bit to 32 bit integers. Change unsigned long to size_t for
>> correct variable size on linux and windows.
>> Add macro str_to_size_t for converting a string to size_t.
>
> There shouldn't be a need for this macro, we already have `strtoumax()`.
> And in case the platform doesn't provide it we know to provide our own
> implementation.

Thanks for a detailed review; I'll omit them as I agree with all you
said there.

If I pretend for a while that moving from ulong to size_t is a good
change for line numbers and line counts in the first place, that is.

In other words, I agree with all the improvements your comments
suggest to the _implementation_.

Thanks.
