Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C83FE5
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750565484; cv=none; b=sMBLF4X4VWsBG3hgRI2FEsef53EEojLMEfs4D5FZA/hJnQyj7SEuFpoXP+PSVzv4DhYUwDOoJeCQJnV9Iw9g4jdiHRCqVUGqwtrmxlcbcBf4TN/4C/BB0SITnqsOFjKrFzOQyX2xg67BGaS0WxeZrUHkmmQ43g/UJ65BugcwH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750565484; c=relaxed/simple;
	bh=FCna+h68BFatP+hX/7ugbgddA/8UY8Jyhly2Z2UgOLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KqV8b4dz/MQSdE/ZztSWNlRCeUIEug6qmoSB3jFGE/w4VyS7tKm85TwJaB6TnTKusAxyCJGU4S2sWNCWwgPKdWHxHtM0zchlWDX8dUVe50QK+4zj/3zVhjfgBf5uYiDSbj2RtdeHItlPlrr5Uy0I5TNPspp7FA8Mzw7SESG6NWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Td1tsRxQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qvckvvz2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Td1tsRxQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qvckvvz2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EB8325400FA;
	Sun, 22 Jun 2025 00:11:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 22 Jun 2025 00:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750565480; x=1750651880; bh=7Xaw4Xm7ge
	jzq87tVhFkZS8pcPQ3FBxKDl0KXLjbIkY=; b=Td1tsRxQayYT/ThQpiYEd8zyoP
	kGTuJu6gj03t/vFdetvIOgmfPE/Gx3ehYyYAzQk26MLWBqsUKBvmFJNPALXv9udU
	owMeo4ZlbFs/sk0y0bIkqxQalPtqncTnm2E7v2GlST9rHAek370Nxf91OkaHDl6j
	eHNio8doe8eNP7KQBggE4/NwWsgMEbeFvyKPGzlx7hJnukQReNKOPPac/HzSyHsf
	RZ+obQ12ib8WxG0DN0gr05cWiPV9dTsv2k8laaQxJvKvqlc1xe3YnUSoeroWAtbu
	6XKaQ0WEZy8l0B6bw/gkE0rgWv2/9Nj/q/gw4TN9X2k82XSVIaRGXOMCYv5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750565480; x=1750651880; bh=7Xaw4Xm7gejzq87tVhFkZS8pcPQ3FBxKDl0
	KXLjbIkY=; b=qvckvvz20Npw0wDOyhqw9W2CyQv0l7J8k6R03NZ5gw3W2GXJrml
	szlm5MBfZTWPUIJeYwOJxejH9K0O36hrREY9NiEjtq9DWv12Blmtyj13jVjhMRR8
	fPtwODn2ewxyIJVh5hi1D+KwmGK37Dk/1uOq7pfpPVxS0lA4bxMi6ZN2v/hD3C9D
	IC+m/OFTQJVlLTy3ZD/YIAWj6OqGh3Fs2iAtacFngNaWtVi6xXWH6UAA0M2FuoYp
	PmDvpzDETBXy3o0Hqu/nHeB+oBvXj5lago2eUTRBfkFojOtjCuI5TSqO69GgQeYM
	9cILWMEaPDRuA/HVHGCh916kpG2gbGGzRWg==
X-ME-Sender: <xms:Z4JXaBe8KPxvXAh97Ow_fGOsZzGT-la-uyzXaOXZoObd5POST7e7fw>
    <xme:Z4JXaPPbfpUxN9RFgi5VhIAmm1RrQGE6dus1R5frv35ya8_1CVtOFmqJA43MxQm8P
    u35RmKMjBi08mSicg>
X-ME-Received: <xmr:Z4JXaKhQBBY-iZDn61jOj1wHRyrVbHLnuOdra0tlca7KvOGEies4ivvEtck7yX4TsgvpJkbHZl-EEGJ9YxMUgjm1JVqbp8FeQl03W0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddufedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Z4JXaK-zEJA-hOpMKJ4TguSlAeo9COjp09bTZCCpfPQv7MRuYxJs1Q>
    <xmx:Z4JXaNt_I_ydpPVioGeBMZXGUitQTyUyL5JxT9kMouNOShrkgdtqsw>
    <xmx:Z4JXaJHOxojQSKb5ujm3Zi-khixyTyocYkDVVJjRX7svhICljzK12Q>
    <xmx:Z4JXaEPLhXjApalWMJzspBIe3S2f2JDKq36VycF2ytqvxbIB8KUQnQ>
    <xmx:aIJXaNM3ttgMfwwdIFaC3PadG1ttg1c_xmzzr4E4RqrFkEonL2WdMiAf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 00:11:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Karthik Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <20250621050743.GA3007684@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 21 Jun 2025 01:07:43 -0400")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
	<xmqqfrfv8dr3.fsf@gitster.g>
	<CAP8UFD27tQ3uhQW5zkPfFZSF=3FGEmi-rBYu3A_zZ8oNbUiNag@mail.gmail.com>
	<20250621050743.GA3007684@coredump.intra.peff.net>
Date: Sat, 21 Jun 2025 21:11:17 -0700
Message-ID: <xmqqfrfs8lga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> My ideal workflow would probably be taking a pass with:
>
>   git rebase -x 'git clang-format --style=file -p HEAD^ || git commit --no-edit --amend -a'
>
> is a better match.  That command is a bit of a mouthful, but we
> could perhaps roll it into a script or a Makefile target.

The "-p" option does sound like a good thing.  Taking the tool's
suggestion wholesale without human judgement would be better than
taking what a human developer typed as-is only for somebody totally
new to the language and to the project.  For more experienced
developers, I would trust human judgement a lot more than I trust
the tool's suggestion, and "-p" may be a good escape hatch.

> The current "make
> style" only looks at uncommitted changes in the working tree (and of
> course isn't interactive).

Yes, that makes it much less useful than it could be.

> The big pain I see in this (or any other workflow) is getting bugged
> about suggestions you've rejected. In an ideal world we'd tune
> .clang-format so that all of its suggestions are good, but I don't think
> we're there yet. ;)

Me neither.
