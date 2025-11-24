Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F233507B
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025793; cv=none; b=Xasp1sv1oLOPkjCQbJNXnb+51NKasjF1WXvUDXogV+iCldPbS5iZpNfUI6/ntqYbMxVoib3+R5H4nY8b/vzgV8sPSORramNm/43ukUop+T+HEy1bX4/xnKqoSZmqBHbyeF+rtLOMS0r33EIOolu1OtWeq6JPAoYPfrfcfYxaU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025793; c=relaxed/simple;
	bh=hrVHTM9WiiACnNdB2eiMIfsrFUCRmjrvM4F/7961z1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayo1gtmF2vJx1SUDNKkilZtW4v1+fd9Y5MEC4wXKaW6PnyUiNnUyUNByMSdN2faiURbmqNhU7xIAV1qvGLljZIyaFBNClEW4UpFennYIh0sMLrvuo2ISvBw/QM4VIVhkhMNNLkw0G4A7LhXYOEi76h2e/rWOrKDSrWLz/7Nf3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IZGdFvlI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhnTuqLL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IZGdFvlI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhnTuqLL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AD0414002A5;
	Mon, 24 Nov 2025 18:09:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 24 Nov 2025 18:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764025789; x=1764112189; bh=3pBJlv/C7S
	vbFjy5c9yuRso5Km5LyjCwUfAKhPE/66I=; b=IZGdFvlItAy/A7JLKjUXS4FrGZ
	chGxwHNWB32+xp63oiRD4JaKeKlPL+CagV8UEcJaTnBFxXouxtJdJeONgcPAoChd
	OHVI9TPqVnO3zhKJxEU4h0Jb6wRa/gfgDJcs7iwtdIrhD1Tbz5RlcBnb9P/M8/N+
	w5Zre4zc3uU1gwGn0hvezIK6FkUZsCA7JtYFUcgwwy0q8e1Bd0A0OJ83de9WjcUr
	JwvECkYJWTf17nV8f5wNR6pmcvzODX+wRHxnLCrjOngIUz9h/7RvdV/jbG2TgR6J
	sk7xnJVR6fQi6SoQYKAK4PMQhUztlaTE9ZyUCHX0XLHBY8n9vpNQVdL5ayZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764025789; x=1764112189; bh=3pBJlv/C7SvbFjy5c9yuRso5Km5LyjCwUfA
	KhPE/66I=; b=bhnTuqLLaQSzhDxbBHNFkkItBhGq0ZVnyVNhu/A+24YwRuFnEfX
	necCFKSWDVOcGxgRJ6Xx/FDkVWEzQ+SoKgPFT1f+TChRk31cYzXW6/uT5lYbOA3z
	zcSLicAbEe9cr5nc1zKTBQs5O+EngYXQXJyJxcwoUPtcEwn61gawf/8m6jWqScuU
	IvLPcA77rk1FXXYPv3zVlzem3fhKyHH7tkFF2lqOKfNNANYRMiw4XkIDNBJea8ke
	0B1KdwU2c29/lsNSBtAZATdai3ONadogQWqOIi+b0hSRlRL8Wz0qIn3V+mu8UO2W
	/9MUDvFMWsWBgd8np2G90pqf9NhjfyAmZag==
X-ME-Sender: <xms:veUkaTyxFbCPfYLerRZvCkNOIz595Yva30BVBQfb6n_M3Z0Rg4P6_g>
    <xme:veUkadhiluDr33WOXgYl4LhwVRNOzBcRyvBSVfWogve7r7LJTZfGEfj55quxBEfhu
    zr7gws6q7MHuwUv7B3jwpuaQsoLeOw0Ev5kot1x4GOl782VXptD>
X-ME-Received: <xmr:veUkafkBOhe8CFvb4KJpQazN_gJiKEyGGoyaD_ig8sMZM9gOuH-abddhMvEETpsxOdzCARmJ20hrrmEEdevmBH74xpNJuP8FqH13>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:veUkaTj7s0_xFt1V-hwmXFN2UnsMWcnppBrtA76pG0a_vlIEgvW6Dg>
    <xmx:veUkaT0bqxIzkro4LnsEEMbneH374hju-io_1ni9ozfNpGd-1g7xKA>
    <xmx:veUkacLG3AHVyvF_ho4RKw3F_2zAjUzoiloSD4OxOcTCUR38Hoxnow>
    <xmx:veUkaTxIRRB_8Viqmm5POK7LU0u553AhFxaS5QC54vTzxh074qPz-Q>
    <xmx:veUkaag5ZmIBXLXTLZwlMOLnr_256gJwKgp70nA4bqFj3HEXc4vEnNEu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 18:09:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  correctmost <cmlists@sent.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
In-Reply-To: <20251124223023.GA2051672@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Nov 2025 17:30:23 -0500")
References: <20251118091127.GA4175601@coredump.intra.peff.net>
	<20251118091218.GD529192@coredump.intra.peff.net>
	<ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
	<xmqqtsylz2xh.fsf@gitster.g>
	<20251124223023.GA2051672@coredump.intra.peff.net>
Date: Mon, 24 Nov 2025 15:09:47 -0800
Message-ID: <xmqqms4buix0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Looking over what you wrote below, it seems pretty reasonable to me.
> What do you consider unfinished in it?

Two things I am unhappy about are that (1) parsing the digit
sequence that represents abs(x) into unsigned int while catching
wraparound and (2) checking if 'val' that has abs(x) would fit in a
signed int when 'negate' is applied.  For both of them, there ought
to be a better way to write, and perhaps there may be a clean way to
do both at the same time that is easier reason about.

> Another option is to scrap this approach entirely, and copy up until the
> trailing newline into a separate buffer, NUL-terminate it, and parse
> from that buffer. That feels a little dirty to me, but I suspect it is
> pretty performant in practice, and it pushes all of the complexity back
> onto strtol().
>
> Another variant of that is: parse up to the trailing newline, making
> sure it's there, and then leave the rest of the code as-is. We know that
> strtol() will do the right thing in that case, but it does mean we
> cannot use ASan's strict_string_checks (it would still yield a false
> positive, because it does not know we've checked for the newline).

Or perhaps introduce cache-tree-version-2 index extension.  If there
are other things we may want to fix while we are at it, that would
be a better way to spend our engineering resource, but I offhand do
not know of anything gravely lacking there that we may want to fix
(there are little things like how the pathnames are sorted that I
regret the way it was implemented, but that does not motivate me
enough).


