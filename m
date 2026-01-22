Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12B39570F
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116297; cv=none; b=N3hTOtqTKa7jDliiRZpupBj5IURX9quCQ9QnE0HLHwC6Bf5hC/equANhL/h9BLxA7Te5QxFUV1TuURLZbbiVZf4GMlQrerKvu0Vg6Yfa9kXla49FvvCTZnwNCblIARhmqjQglVURZ7p/b6MC0vYUEZWQbQy/ReFL8fYOuyUH5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116297; c=relaxed/simple;
	bh=e10EeM16BS94X26f0bjkpj2N6TwTtxZAmB7h1pfpOw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnswgSiMIhcL7p+LOyIcQ9aP+JzeNl93Jqp9NWE868C/ceqI8BISF+wpMlNQVZv9y79O4NpZv4l28PwZTjE0pv5hFGJLB3RTOxa5c2heZJSvFavLOEo/fpoL9Vpg2rDMpESVtAkhcOds+Xd1jArL0gjfbF+oOZtjNx9cHK7iBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rkp3RH1Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRECrSUg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rkp3RH1Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRECrSUg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E463EC0C51;
	Thu, 22 Jan 2026 16:11:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 22 Jan 2026 16:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769116287;
	 x=1769202687; bh=BSrAnIDNlNNJ3ds+3YN2aR6WK/5v+jmNoSaMJpi8rWk=; b=
	Rkp3RH1QUwH6tIi3HkS8oiKTRPSz3wkuiOKoJVxBChlzXZEOoyHt0fRycRuAj+MW
	TGypXgHmOhd7c9sn3oStgvS51kSJyF8qiNgeZRL52Giatvw8/5kbFN22Gssz1AXI
	PcHSSDT8G5rNcixafhrpCDKF7C6s9rpoKm7DGL95qUXVjdbmBFXPyw0akAgol7Bp
	3oVJVCIR/4Xq165w/LxfMl3j7wJEs3SSpfAKfuq3Hu5QH8PBOMNSaRaWvSYJvRnR
	WNmXYslxm/Vp3x20UaW5fpByr47oDJEq9kHTEe5AA8iPdcqeOc4YGA41RegZitWv
	GbwKcnRlBtxoVbAZPi0C3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769116287; x=
	1769202687; bh=BSrAnIDNlNNJ3ds+3YN2aR6WK/5v+jmNoSaMJpi8rWk=; b=a
	RECrSUgraBHDe4s+7Y4QvAFTsfOXa4VVyDtsEzxHgv2PnlAekj9cSwNjaTlt8Tdt
	pBH7oXDM94ORi3Z6XO9JlB5GTrWIPoRtkFCCVgAEWHybaESijq8BxL1mN7iEkSG1
	KYUqSAW+1g5Gw+9W0o7UmQe0lBp7orrJUfP6dHa2iubpLlx52vzYjg+UTBGZTNTc
	vY+OVignT62UhLMieCtRHKlIaxM/pW59X9bGsaOT+VeQ3715DjwHee/X+pUYpOc3
	H65NlAR7ZILRzoZ7PaIAxZtXA2/pNsE81xbSFjJIckDII1xUsv3BOxTImRLsnTkr
	svuZIs3DBfG+5w+32oflg==
X-ME-Sender: <xms:f5JyaeuKQUYvUsNrIMbfdl4nu6t00ejub4m4mEfyim6sSAM3UYYEJA>
    <xme:f5JyaacIigpnd2gE9xo4eFpos4H6_6Hpdg0u8CJHtgkfdHdlw-8lAKklyL4-J1OPB
    133jt0j4bqzuS_-i1nRKj266HwW3lSYOcmXsqjzpc0bDezVCD7iVg>
X-ME-Received: <xmr:f5JyaezGabqA8amMgU7LiR4vdlrNUu6x52KOwwdK1hn--KN8D1raQIUeQvvFs9H6L98_zpeUhTP37toNxkH8epaJcZN4pMNueKBlYxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:f5JyaYHIcUq974HXQCkAVtCBfamqoB5_JvajTD9gcY3NsWs8TV3pbg>
    <xmx:f5Jyaax6w06h1Aleb4U6Eu12p2zlsgrXO0ELZR0oMTvFwHuTGRqpgQ>
    <xmx:f5JyaRsRmLaomUUTaNxX22Y2JCD4w-G_XKJdKqMVEjH-SwWJ_9b61w>
    <xmx:f5Jyaf2d7BTeb_r_knpOglqL6OeECg9sLcc2kiIMWAhN_hux-z-Hnw>
    <xmx:f5JyaSRMBh4mtLv51NDIRQkkz2T1kovNrUSu-eHd49Bv0LH4HYTDub_C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 16:11:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260122205632.80273-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 22 Jan 2026 21:56:32 +0100")
References: <xmqq5x8tmlj7.fsf@gitster.g>
	<20260122205632.80273-1-haraldnordgren@gmail.com>
Date: Thu, 22 Jan 2026 13:11:25 -0800
Message-ID: <xmqqwm19l5du.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> For example, writing "v2.52.0" there to see how far we came since
>> the last release would become impossible if we always force prepend
>> "refs/remotes/".  I wonder if we can reuse already existing DWIMmery
>> that uses refs.c::ref_rev_parse_rules[], which should allow such use
>> case, while still allowing you to write "origin/master"?
>
> Sounds like a follow-up rather of doing now, right? 🤗
>
> Since the inteface won't change, just adding more functionality a new
> feature, we should be able to fix this behind the scenes later.

Disambiguation will make it harder or impossible to add such an
enhancement later, though.

When the user says "git log origin" or "git show origin/main",
refs.c::ref_rev_parse_rules[] is applied and turns these into
refs/refs/remotes/origin/HEAD or refs/remotes/origin/main, but as
you can see in refs.c::ref_rev_parse_rules[], these are at
relatively low precedence order.  Your version has refs/remotes/ as
the first (and only) choice, so if a user has refs/heads/origin/main
and refs/remotes/origin/main at the same time, "git show
origin/main" would use the former.  With the implementation of this
round, "[status] compareBranches = origin/main" would pick
refs/remotes/origin/main and nothing else first, and then would
start behaving differently once such an enhancement to use the
standard DWIMmery rules is introduced, which may appear to be an
unnecessary regression to end-users.

So, no, I wouldn't recommend it as a follow-up.  We should decide to
do so now or declare that we would never do so.

