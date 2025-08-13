Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA79269CE5
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099215; cv=none; b=WUUbH3Nhiv6JXHjpn7Xp3FBpccp33/UfsBgnyFVsDZAEu+sPiVfgpObyAimRFoP15ahlxIgmdJlNi+DRLak5d4UYBwsSpx5uOzNu0tVZs7PQtWADxGziXfk7FO5PQ8wmRc02KMXCK8hNvrQfxLmqCLKBiBlrY0Kr/4URvE0RPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099215; c=relaxed/simple;
	bh=3W1nkFNs73E0WYb/rtFcIYktIPtET8GSMraoG5u0qaw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lXbMRGTJnhMJn40kMZClT7NXOLxaDsoKXi4OKa3N3BkgAm7T1IMVsBuUms0Tr3W1LF8X6U4+DnGWGlZcUDeXjRedWs9vblGfrvpEmdevieT7QLBt5kHC8fs7xWmYwJEnX+niKFwciJjo3fEpfOGcu/PgNGdnQLwRskDiB/OEmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=J4+sWYyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xa7IKrvz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="J4+sWYyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xa7IKrvz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE7F214000D1;
	Wed, 13 Aug 2025 11:33:32 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755099212;
	 x=1755185612; bh=E46lLCNtYkj2eRbx8gb+bcgLOIdIQexgsRoQ4jYTDPM=; b=
	J4+sWYyu63nPBB5j9d30EGii6qGIsqNRghY3wI82C1fpUtoE+SUUZk/yMV9HXUqk
	0KjgftPfEVht9FyF7Y7Aw+Bm17ZqqOm1tbs7fxixsH8IW/UGYwiEd4I2fx8wvHiU
	mwjemrIzQcaH3CNS3f0mfFoxhn/2TgBBOuAJl3MX5jJQ3+ho4Xy+ozp3qubdptUR
	KP4i47y6XSsIxZli817LHMrWuLOpkc4HVAgDbYhJvK4njBOODIncTeca+DpSToXr
	XVSuWmI9GxkeKFgN4hj+qZqXCxULyJbKDbZ1r/tt39ZfLnVdAYKsDq6cHnd6jLAK
	9Z4LGU2qbtJo1A6T9i3l7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755099212; x=
	1755185612; bh=E46lLCNtYkj2eRbx8gb+bcgLOIdIQexgsRoQ4jYTDPM=; b=X
	a7IKrvzZANMeJJkaXNcJyqwTR0LJGmmubriqedSwtW4D+8DjgswvPwCzpubigb8g
	1eCXpb0pkjdH/Yx7Fgj7C2iZ9dmwbeW3eIrjbakHKcoANW4Jk07yq0Vbulku2rzD
	+m6luXdCDtAo/lJXcXe6Vw42Vf9jofxWiORHbTr6OEY7rIqo4iNDX+mYGcwoPywW
	FKIZAE9X2ijCFBl+lKU2yaTUUDfOc1MKnM+6C0xBW01soHPaDUHETWZZ2mRxNfAs
	eKQcky3rm6HIjyUrXCnNKpjRRp4myHDw1WGJn0AK9pc4T74gF/+r/fT5rjeKNhuY
	Qo3mFykeXBCxV3cQkRDxA==
X-ME-Sender: <xms:TLCcaLEnitpBubcKDbamzyO3IWgKIjYYGTXB8F5TzsppJAyzgVR8Kw>
    <xme:TLCcaIUInok2u6EU0sEi9AAAhDbKV1sNEgc0SzSNxO0H3qjwwLoLTvm16IIA8Ry97
    sb1JvPp496i2E5ZgZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TLCcaHPhibXWdzyZ8qhRe0YR5L26aLX3aipkDiEYGfyt8pvTUdX-EQ>
    <xmx:TLCcaJXGTsq9C5Xtl0iRXQfDYJJbMhx9HvqGLL5HUhqDA1SJ-Kht6w>
    <xmx:TLCcaL1vHjAPfiKeFDhWeDCG82ZcBuA2uUPDTxT_93aJAfVsmX1H8A>
    <xmx:TLCcaHo92ahvyNBETnBDHbP-TdwqOeVPxTGXbgAs-7_V9jx-i97TsQ>
    <xmx:TLCcaGeOCqRLH_NHdic4EGP5GANsDPRoBXzEqZmV4RSbXls7H4Pjg-Gi>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 27BF27840B0; Wed, 13 Aug 2025 11:33:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2b652b8f7554bba9
Date: Wed, 13 Aug 2025 11:33:11 -0400
From: "Julia Evans" <julia@jvns.ca>
To: phillip.wood@dunelm.org.uk, "Julia Evans" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
In-Reply-To: <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
 <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> The use case for --reapply-cherry-picks is mostly that it is faster to 
> try picking a commit and then drop it if it results in a empty change 
> than it is to do the patch-id comparisons to avoid picking the commit in 
> the first place. This is especially true on partial clones where the 
> cherry-pick detection is really slow.

That makes sense, thank you!

> I'm happy to leave it out but I 
> wonder if we should drop the references to --fork-point and --root as 
> well given they're also both pretty niche. I'd also be very happy to go 
> with Junio's suggestion to replace steps 1 & 2 with a general 
> description that does not mention 'git log' at all.

I like the idea of leaving out `--fork-point` and `--root`.

Now that I know the use case for `--reapply-cherry-picks`: what I like about
leaving in the `git log` description is that I think it makes it easier for
folks to build a mental model of why a `git rebase` might  be slow: there's a
"fast step" (the `git log` step) and a "slow step" (the `git patch-id` step).
Then even if we don't mention `--reapply-cherry-picks` in this section, a user
could infer that there might be a way to speed up the "slow step", and find the
`--reapply-cherry-picks` option to speed it up. Maybe we could mention that the
`git patch-id` step can be slow in some cases.

(also I might have misunderstood the "fast step" and the "slow step" thing,
I'd be interested to know if so)
