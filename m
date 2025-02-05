Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A7A32
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760942; cv=none; b=hkdyYKCar0Y8jTaBRZlrMGTtNudu4CTXO0nSsIcaszZFECWjDSxPQJeVi2KDijXCR1K9mkWCQuvMhhP+ahoUY0Tz6DPXr4jHkHUreHQF5LxN/G9b/GeprtXWixLUT4apYcrIkyuOBGhoF66OgC/b0nzTnhmbSKAC/VsCk5DYyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760942; c=relaxed/simple;
	bh=IOtABrcicqFDdi22uqDDCCblt48R3WJronW9SrmGRkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZpritWAAs4fImbQdqvST/6HNLGTYslNDbXgTOyV8SwclprxhCfTgCEBeXQpPss1qmSSW3OnIGTp5cVwY6OOdkEgdf4glQhiSsZMoocC00ApoqJzpjW1Lq1/e9F4hJydAFGdisuUJi2trRu66asWpRsFNwmnZYDk1XCn+6rsTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z1Fzlczw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xYO3/YC3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z1Fzlczw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xYO3/YC3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A49E725401A2;
	Wed,  5 Feb 2025 08:08:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 05 Feb 2025 08:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738760939; x=1738847339; bh=IOtABrcicq
	FDdi22uqDDCCblt48R3WJronW9SrmGRkQ=; b=Z1Fzlczwv8E0ZPGhSr/xmvm+Ze
	LNQcBpMos40bG8A9AgFYSGeAn/yRUMTDxNtgAS9c4zz8ILukhcd8GpwkEk8j8MK9
	hnNtjdRMGKS3hp27fKjUcTc4ASPG2nmw7ZlLyk2UorGCEPt5Nkqw6hW5b8mF5c6B
	8+H2FVbdwaEmZKiFzKQUyOgldHA8rXywxxH7rfxOEOkMEqUB6xHWTgeYFRqg+ApN
	IAg4uCd0Z6eZa/qJl4UdrPeOurS/i+W47flVGL3XH/H9rrQ41crsEd/y7TTkstlF
	ReDFP1wjrbSAQq0WfrP5qFW39ZIlwGTmFyZGo+h6GZ6a52/tZKMSzXcKqEmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738760939; x=1738847339; bh=IOtABrcicqFDdi22uqDDCCblt48R3WJronW
	9SrmGRkQ=; b=xYO3/YC3AiKaiFW8MSkWbw5cY7OZwfUYVEOs1WAQ+Q+i9BFZlbw
	d7G1DH4qCJLHIFouvvhcNBCYab5FrEJlp+Ry+JY0ArCFkNrnZIgo+ezldFo5gz/8
	ZXif0dD0jB+afhPJdSaCr7N2WjUigLrDlPT95zYgyuMMI3rFugJ8mvIov9Iyw9C2
	bifz/U3wo79iugO7tOSmtl4Nli1z4RudVVSJWKwVHO0Zlh4N6uIruQwnyTDCX4tF
	A6QYNq4G2vjJduc12cKxGZQWA3D86B9Afa8xKXdr7kwQaa/aMlfAT3cO7lOHCfgH
	NEVLaoG2AM4ChltJ3DE5baInC4NBFGEqDJw==
X-ME-Sender: <xms:62KjZw4lBoZlqyoGHK_Siud8nT9nH3mxkgCiQn4njSaaO8Bb42wMKQ>
    <xme:62KjZx53xioBwZiAhthr3d9aDHCFis7nQJi2FyaAqhAfhR5j6BALsKmGNYVSPUDkW
    6C_VL0les0fcvHt1w>
X-ME-Received: <xmr:62KjZ_cDjlDueDWab3BwzFBur21goIYGszW07RRtD1-nHMHXl9zrzqAB_4AYoELKTnlX6sh6fL6f0SxqCUN6Oa_5sLW8aPQOUDgF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihhvghnrhhivgdvgeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphht
    thhopehfvghlihhpvgdrtghonhhtrhgvrhgrshesghhmrghilhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:62KjZ1IGnwJC_LJwFgvrZKBZXo-uR1Z9JcsPdhesNxFcD_wXiv2DfQ>
    <xmx:62KjZ0IhPynFpQbPdObPNYAZCQWKzvSY7S1msnEdybNa3XB62Q1GZA>
    <xmx:62KjZ2wRga1XeN361SxTKNiCc0lNthzJ5RX75LqdY-NQEiXTG7s5AQ>
    <xmx:62KjZ4IEyf-avFvW1og7-F_3DqaMWwZj3yWPOTy0NMTGVTgGYL4g2A>
    <xmx:62KjZz_YsTOFJmNr1dDS5jqNqm6y-oHlsnCdfMFa70ibt_UbsvhZd80V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 08:08:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Alex Henrie <alexhenrie24@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Felipe
 Contreras
 <felipe.contreras@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
In-Reply-To: <20250205030642.95252-1-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Tue, 4 Feb 2025 22:06:28 -0500")
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
Date: Wed, 05 Feb 2025 05:08:57 -0800
Message-ID: <xmqqbjvgr11y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> When running "git pull" with the following configuration options, we
> fail to merge divergent branches:
>
> - pull.ff=only
> - pull.rebase (unset)
> - branch.<current_branch>.rebase=true
>
> Yet it seems that the user intended to make rebase the default for the
> current branch while using --ff-only for non-rebase pulls. Since this
> case appears uncovered by existing tests, changing the behavior here
> might be safe: it makes what was an error into a successful rebase.

Hmph, to me it looks more like with pull.ff, the user, no matter
what other variables say and which mode between merge and rebase a
pull consolidates the histories, wanted to make sure they will never
accept anything other than fast-forwarding of the history, because
the end-user expects that they will pull only after they push out
everything, i.e., the expectation is that the other side is a strict
fast-forward or the user wants to examine the situation before
making further damage to the local history.

With that understanding, I am not sure "even though pull.ff tells
us to stop unless the other side is a descendant of our history, if
we are rebasing, it is OK if they have something we have never seen"
is a good thing to do.

So, I dunno.
