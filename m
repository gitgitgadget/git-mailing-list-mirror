Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C061BBBDD
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808463; cv=none; b=Rciu6O0tU4FIitftLYx2bUR6sMXO7+35e8hPhDr7cYxlOh8IF5BeOIsP51yO1qMz/Ge/yWBlF4XtuJBTY92c17Ky54PMFim+yKGXGmS12UvXNzqfbCmZKFzrWc5sqVQFMISzED/3EX1x213CUuR7jGoaTn7ihSFrPr97AvCzmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808463; c=relaxed/simple;
	bh=o+geW4KyiLu/leuqG5QJAMacLq9aUEuv6O40Vy4oAow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9TyUa8+Vw7iqJQBGxQxehTcmSqQAlCrzjIgvXV9YX9JZKgmPw2+hmL1z0UxKyLFvwvhi2tDOitScrKYjVGZoeSs9y0xnS3/sg0l3TWpY/CofiokVvjX53qIVNF2B1doFOzrsVG1ozJbWqDLgIvN3HeuwCOp/U6xjsk8Ntxozpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AmWtfB7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=erJlLFTZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AmWtfB7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="erJlLFTZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5881813810CA;
	Tue,  1 Oct 2024 14:47:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 14:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727808460; x=1727894860; bh=Uq+ChXAUNc
	H33D24q6YZzKAQx1pTmuAWsQ3hIibf5/M=; b=AmWtfB7t1P2Z4hy6mWkpxKieLG
	oUURzduur8Vs2+23GFWsOitv+QCLm01GCJrQn/JH8IIPVysd0rX1aJM5iA0RGhor
	QBuBgExwotsNItz3RJKjXYuqpEmd5HxhD++v4dbSQH/unBGFKa9DHpkG7c4ec7MD
	Br6cVF/XP+l6JzHh6anJ3T06HykIJjZaPw/jUcsPXk143SbE9y3U23DnrGqy4ur5
	CO3zTt3L0jagOOHQGrI0XXm+1wHc6lwMZMUQR8Sde13SMa+ecIayzoDwBF/Ve+Nd
	i1g6yKB/3q8X2aiPxycO4BmsOkjeR3XWr8Z4tS/dUKO+AwLYKZk4j8V2ChkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727808460; x=1727894860; bh=Uq+ChXAUNcH33D24q6YZzKAQx1pT
	muAWsQ3hIibf5/M=; b=erJlLFTZuMgptiOe4C+sX9hCkOpNWjC+YZWVFruG/KkQ
	DzRNXUBKcOO/yYoNuszzxTSTLBdxVzyKFIDJ8ZRduEiCMj9XUd1s6/zEOmruUgRP
	ORsdqjYe3HEE4OkICkW85wtnu29HexMNvcdyTNBmHH9kt22BNHPE3rqSoSuFGuBX
	89Fr9bmzYrTuKREAj13fazbmX2wWxFxpIPwiie42jPJ2lw0Qcg8BfhndMvXotxG7
	NqINlJLKAZVKa+efL9YmMye4zVg1cN3X77ixuALKOlb7QHraxrIV6FOZIRlak1wK
	eliMKOX3K66upsT2I5lFOjr2qL4HmeHRegofWimhAw==
X-ME-Sender: <xms:y0P8ZmQ-TNSbx9CYyFDNr4djOCwrP4munDSlNsz_g1w4tMAQR7d16w>
    <xme:y0P8ZryEqmhiLfgqKcgD5gEXZfB091DMg63c-LmV_cajHzdGxfJgB_8Ss4yqObR86
    9qeTftnp_SOyFK2gw>
X-ME-Received: <xmr:y0P8Zj3EiyD5X4clBj1CrDyJatXNk0gXZo5gXQ2vwOEJ_zxxIoLMKthr9iPWbYWIhH1vvKpPgk2byPpFNJVuoB38wpZL3_2z88GGctc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:y0P8ZiDI8IA4qbsF7WglvIIe1bvKs7LCxq-6C6sVsIOqIgCQSlWIeg>
    <xmx:y0P8Zvi5FbTiVoaEi42_qjGHtlcPTQzLwRiLnOykyP1q4FqmGJmRRg>
    <xmx:y0P8Zuqa2zM1QLioEXVoALCrMwFl9C0vNweLE8Da-f7fy9DXCjwNTw>
    <xmx:y0P8ZijDBJBrvYS5TGF6kG8P8B5qi2tTRClLD_mwoXcaHqJMIzpE9A>
    <xmx:zEP8ZgU2WF7REdcVh_WRBKwUgTcekFMmL2ygu4cP69PwvbGHEugSFjBY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 14:47:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  John Cai <johncai86@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <ZvvLbXskyA4V0gM3@pks.im> (Patrick Steinhardt's message of "Tue,
	1 Oct 2024 12:14:12 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<20240910163000.1985723-4-christian.couder@gmail.com>
	<ZvpZy9XMpLI0DQQg@pks.im>
	<CAP8UFD3+YVE+pgGtSP6gDDN9=-0acuJCnDamWjeCX-g5aqTp3g@mail.gmail.com>
	<ZvvLbXskyA4V0gM3@pks.im>
Date: Tue, 01 Oct 2024 11:47:37 -0700
Message-ID: <xmqqr08zwth2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Now I'm not against advertising a name and storing it in our config when
> we create the additional remote, for example by storing it as a separate
> key "remote.<generated>.promisor-name". But the name of the remote
> itself should not be controlled by the server, but should instead be
> generated by the client.

Thanks.  In an earlier round of the review, I noticed that the
remote side gives each promisor remote it suggests a name, but I
failed to realize that it is used without any say from the user at
the receiving end in the local repository---which is horrible.

The remote end wants to keep referring to a promisor remote in such
a way that both sides can understand when the same promisor remote
is referred to in the future, and I am OK for the protocol to allow
the remote to give a name to a promisor remote.  Such a name needs
to be kept separate from the name the end-user locally uses to refer
to the promisor remote (if they follow the suggestion given over the
protocol).  Do we need some mapping mechanism to do so?  A name N
the remote A gave to another remote B has to keep referring to
the remote we know as B today, even if we rename B to C.

Thanks.
