Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F030B50F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770677975; cv=none; b=NSbKqeSmHpOicmSbWj8+Ods2JMzYrSeU+rCzHk0qc2GfQ4M4aqfKcSwyCjrY4cdmIXRUvtUJHm0Qb9byTdOhmTv2ISETgk+Wbi17lCLQCr1d0JxqOoNyqENRgoAwYOfpsceUFXY5T5WmvhsjfO2bU9hsf8LilZG0B5uU1wCBXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770677975; c=relaxed/simple;
	bh=dPq9U5F/O8YhMIsiHHGV+snkC1miHME2P2PFVpCIlm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sH/YnHm9E4yYJgZe2SipLBEwdul1ccNJWr9FR7UyWoFnJD+pTr9j0PIwcJtnbxXxpcFLPheW4sCzp63gzmAQk/b+M0J3LLFTgk23vMkHqQcBb8b9h991qpGlbbZAhdr+0p6OAKuFoPCp+PW/j05PpEi/dGpAzpQsd/9lgoKdwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IbCjamyU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFWyG2HR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IbCjamyU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFWyG2HR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1976CEC0551;
	Mon,  9 Feb 2026 17:59:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 17:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770677973; x=1770764373; bh=5JJ+M2rZs7
	2JTWP0Bww2NS/Qnb1/yDbPDjY4xnGD72c=; b=IbCjamyUK75AkwEEmAn0af86Q7
	X5AInp2LntxmWsl4hMKV1JS47/IzGfKj4eAmxHiH5zPMJ4MnAfbBDHNrl0MOcYRP
	rWNy46OJ4QzawdyszjWWJxyRskQHTga+YgZjCWhBRfHtkLvLD9GJd6FvE/SFPTaD
	L4v8F4ERjox7Y0trm2g2HnJiLvxVo4uuE6qtjwb6vkbGEnrfDGwcJzVR3rQTOSkm
	r51WXLYbfnU8xbP+MRn9kB5+avKVLNkz8bgGxRzBYL8mcu2wyG0+ly4hBj0Jh5pU
	VTHS+NrGCol0oKSZGVQYMnE+w158Bj58JXBiW/+P6LKVLLOKbAcKZrFv2Kgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770677973; x=1770764373; bh=5JJ+M2rZs72JTWP0Bww2NS/Qnb1/yDbPDjY
	4xnGD72c=; b=MFWyG2HRAu8GU90ph1POU1Cdxw727MvcjXn28CZmp0SEO8VG5pc
	/oAhjUyBBgqFwlf7BLKt2XPzn1AaW0DASlez0vQbURsJtjRRaJ4pcFRXSN9rcKPC
	8AodsF3vZoXnYRXEBjBSqUfESWYimramQTi8W2/tNhyDlwTPulJUF7uRWSz0pBF1
	xDtGrjg0ixobT5jlEZwEwvrI6BipVz5AOVhd/s16brMOGN5GK8k16C0xkf0kMXd1
	85XZMH0T7hxoN+OPXLN1c7nEUB6nlHOKw+9YSxVTuVdkgx+EIq6dJ0/DbM1dOUH9
	4amHidXHFVekFA/3MBX/zEmBQbPVof12ang==
X-ME-Sender: <xms:1GaKaSVj3Swi67H0hSt4aRi3oEyPP-o7N_1vM9Aalg93XXehdUFSpA>
    <xme:1GaKaRp2561RtmNZNDtJSYIrcs6Q6dST0VlFXAHfW4zP1P970LOHlUJZ-DXpFaNA0
    8nHvvG-GLgZ_qQnbHnGhQwQYxALuH5PKyLty1h_tkc6cOlYYhuciiQ>
X-ME-Received: <xmr:1GaKaRB9vsfqPTG-aZyCdUtRsg9R0NQ_kClr7J0vvkyWwneOofDZyD5ZbugjofY4a-eko1LMfcxgrmm4QdHXR6bR11Ip3bWE5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleektdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopegt
    rghlvghsthihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtohepmhgrthhhvghush
    drthgrvhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhuughgvgdrphgrtghkhhgr
    mhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhrhehrsehsuhhrhehrrdhnvghtpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:1GaKaVgXOjRLniK0_1Rf2lYXWEFmpyFA8sjpJennQvVEkQOkK8Dbag>
    <xmx:1GaKaXZpldaS-S7F44epq8C3Ra3i8Fhac4BlwunRKiC8NP8l82zW9g>
    <xmx:1GaKaen7l-l4wf9x_wv55oHOPbQqAzhiSo5Q6bHMn9ay8aOAfSF-Jg>
    <xmx:1GaKaVhaUNTU7Qu_UX84cCBdOQVuBi1tOA4RG6cLB18W39OjwkiwnA>
    <xmx:1WaKadCiLJMjoKtwgw9L6nwDdeewiWJZPjH_ZnLKKugAF8UiYwAkuubO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 17:59:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Matthias Beyer <mail@beyermatthias.de>,  Christoph Anton Mitterer
 <calestyo@scientia.org>,  Matheus Tavares <matheus.tavb@gmail.com>,  Chris
 Packham <judge.packham@gmail.com>,  Jakob Haufe <sur5r@sur5r.net>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] doc: add caveat about roundtripping format-patch
In-Reply-To: <V2_format-patch_caveats.34b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 9 Feb 2026
	23:37:05 +0100")
References: <format-patch_caveats.281@msgid.xyz>
	<V2_format-patch_caveats.34b@msgid.xyz>
Date: Mon, 09 Feb 2026 14:59:31 -0800
Message-ID: <xmqqikc534mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
> new file mode 100644
> index 00000000000..c666d709742
> --- /dev/null
> +++ b/Documentation/format-patch-caveats.adoc
> @@ -0,0 +1,36 @@
> +Patches produced by linkgit:git-format-patch[1] are inline. This means
> +that the output from that command can lead to a different commit message
> +when applied with linkgit:git-am[1]. It can also mean that the patch
> +that is applied is not the same as the one that was generated, or that
> +the patch application fails outright.
> +ifdef::git-am[]
> +See the <<discussion,DISCUSSION>> section above for the syntactic rules.
> +endif::git-am[]

It is news to me that adjective "inline" has such a meaning.

Whenever I see somebody writes "X. This means Y", I try to see if it
makes the result easier to understand to more people by just saying
"Y" without mentioning X, and to me, this is such an occasion.  I'd
rather see that sentence, plus "This means", taken away.
