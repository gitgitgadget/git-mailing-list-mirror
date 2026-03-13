Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE03CFF59
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433096; cv=none; b=Ek0AOoW2nbd+ZIdLS7ed9nP8UczuuGSi/MlpVovOQaZm7REt89KblTibhsc+X6UOLZOpuWFwTz8RbNom1F33i79CAQqhAv87irn6SfyePm4b3R2B24nyuYJDXmAtA9owkCpWHjY7QY3uAxwRa/JfzNvX2yY7qzB5TvF0RXbznOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433096; c=relaxed/simple;
	bh=wbPNdaUfyJxskPdmvP/blEGZuatsth/ecuiRciSMmow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WV9H4tqQAVtgBU32pGFRJOXxh7nn2raZz3Fqt5hMRjVJroeeeQoOmYRujAulyx4pyb8AUjlD/bDV7LKNIc5FHzPtxSOECnUtLOhy766GmBx7pb3AYKPRpLR7e/f5I6cfuLdvm47Ss9U/NMqtHV/4pn7s+bCCXTxUhtOR4e6Fw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iypzq/uV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0F7yRu+f; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iypzq/uV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0F7yRu+f"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EE0121D0016D;
	Fri, 13 Mar 2026 16:18:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 16:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773433093; x=1773519493; bh=lgQ6AJDJIs
	SzZL2OGlZg3SOlJ8Ua+fdUJTPyvFCkJeA=; b=iypzq/uV319MI7N59eFDtqVjtU
	4XXwVKuJSnW6B/tIq4tlZAy45KQPTdcAih/2rxJwqGE/XHN0tt+CDroCcJl96Fec
	EBqgjxLOhwVJf3mynf4pijMRN4v3xt5MIR6gOtGMdjW+GgXvse3/K4fgUU+nUC2N
	bdCUxR69enk7AWgfbfc8Zx+mpm46sVTsn600Hdk/jm+Cr6QgEa6QSJSreuGUGggn
	uXCKeuQR1it5zRowLeduaG5wP+6B88E+Cp/CVghuj62eY0ib2LF/wsj3emdCWjtH
	3fDd6dtxte/37pkx5G0u9y54a7eU4swZC++iPp69TrROyzKNfP+RwEXJSAGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773433093; x=1773519493; bh=lgQ6AJDJIsSzZL2OGlZg3SOlJ8Ua+fdUJTP
	yvFCkJeA=; b=0F7yRu+f1I/eD1PQoKkRk9VerMb/+QBi6DbwZbYR/61iRhd7c/I
	JuJ5LfdxD7W7Ie0K6prv2zqx2hsc4HkjHFpI3K8Id/0F4VvP5LVzLI9M5qvWUXwh
	NWSKun0IltqINA50lgcDhsXI8AieFflcGp+VpEV5gEp/Ech3nlHT+lpT3+38DxP3
	NAi/2TqtzD7v6tAvyhS58y/lXqhDVUxWTSPYFv1Xw5vJoUee6wnwGwzNdQ2XnVJw
	bNQqO+qQKXuw5BxupoX4KZ+3LzZTazsVOXKz9gm/ghdODp9DXSH0o8AuAdGr21qr
	ROAZxzALxcgc5/ZA6J1ih02C5yu3OuPA9Bg==
X-ME-Sender: <xms:BXG0aR2TavkHPXESejMaE6PEFmRgnFFqk-2YJjLt-vUpWjeqEIN8lw>
    <xme:BXG0afFxdxpC0WXPEVKuqb6FAiFmpVQ5PMuDGhcRC4-V0u7WGpv5F-F8sDisHDBFA
    aGtHfniMURDIPTB7bvSq5GrTS1BQUEH3p-x-A2a970xZx_xjA6n2g>
X-ME-Received: <xmr:BXG0aW4XUAus6AJbY72HjDJpXC5tJgRaV3vD5KNGtL3UK8W3pY5jeDefRvWF0t8GJf7mP5si8SDdHUcuFfe6rrNN_MtnmCQrbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehm
    rghlohhnrdguvghvpdhrtghpthhtoheprghhrghmsghrrghhmhgrshhmihdvfeehjeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BXG0advbrpwi7OmyiIaBuncr24oogmBAmCgpw2zMO7fucU3WIW-TEw>
    <xmx:BXG0af6THxVe4KPkjau4fBLKeDCdkvvTuDXNiCwQ1jDa-V3DDmOsIA>
    <xmx:BXG0aQWFJl6VRVwo8EU2S5HVzu8G4Ws78y371iKGo54HtpT2ingWmA>
    <xmx:BXG0aZ80cDBvJpgP6WUeoYEe3FjJaakZpWu60s-L9XwaiEq_yXc3Rg>
    <xmx:BXG0abpV7OKKtrR3Pu1CUU0xVSW6FCDUWI5LLT0ay41TB6mAywyYM1tN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 16:18:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: aum2357 <ahambrahmasmi2357@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH GSOC] diff: use conventional comparison order
In-Reply-To: <9afe48e3-8348-4e2c-8e5f-bbdc3b2951f8@malon.dev> (Tian Yuchen's
	message of "Sat, 14 Mar 2026 01:59:28 +0800")
References: <20260313140440.564201-1-ahambrahmasmi2357@gmail.com>
	<9afe48e3-8348-4e2c-8e5f-bbdc3b2951f8@malon.dev>
Date: Fri, 13 Mar 2026 13:18:11 -0700
Message-ID: <xmqqldfv4h6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> I guess this syntax is probably intended to prevent the compiler from 
> not reporting an error when someone accidentally types '='.

You guessed wrong.  See CodingGuidelines.
