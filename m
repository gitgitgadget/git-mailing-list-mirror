Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789519C553
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013654; cv=none; b=kG+kiwfzvqrieVz0Y09pngsAMmI0PY58arK7vspjLsgZXB/M8ES2mYc9jhbNGdE5jUR59vtPtco2zjReQx3oCtfkR+kr3Alwv56sxU++qCSuqxiz2jZ1SuDvDIArHJJ/jxyWvCnHCfeU3Sk0wQqgoov76ZK8CBhFlXWWYotFN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013654; c=relaxed/simple;
	bh=rnZHHkwcPzpyNnYZCJUFCkOuAXMj2+IFmyCDnPquLus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3yMxsEgOER3DyI++dUA8Is2si5MwarWYNHkW8gJnQhXZ0flKtuEdkgdEC1Kew/sq+XwTwihLZwESHMK1rA+Jj9RKcbjWM7RVkMYAnz+4usGJL2qqqvAF4ZA7eL5RczAtPlj58HzRC3fUxmeg75XDBsqavucsSfXjIRGqlLBpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLeXwY0o; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLeXwY0o"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C09411401D2;
	Tue, 19 Nov 2024 05:54:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 19 Nov 2024 05:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732013651; x=1732100051; bh=rXT4+bl9eqTrJkumNf1pEki8TMVBbAbkRTo
	juC77TLI=; b=WLeXwY0oKgaJR2xW4XOlxWF/VcLMqFSoh4pixbWFbeYWxiPyaQJ
	1koQ/KZB8GGpHyKLSO51m6P5bf+OcP6+pL93GUBLUG00OUBQHdqcb2fIu/st4/kG
	UHVdYoxgYWPZrqqm/nw9FBvVRIBORzjdnpl+IEPxmH0TtVRmQOleaVMDg7sPF1Bp
	c4XIeaB97o/UHf7DbfKmHpqdDSVgHImasftKFwhV+ZFGmkIucYTyAt9hdpEzDOKg
	oSzPx4vy4hI137p5r3fBwIUz6K9vg9vDBaDCVcvvyBWQDEfPV7AHn1xR42AUDz5Y
	GriME3jFtttwLu3b4DAZh+MCEtumqqGykEw==
X-ME-Sender: <xms:Um48Zzpdg2JepB3nlVMVD9ck1HFZK_IH45VOuVZjdKsqG6L-CKiPMQ>
    <xme:Um48Z9rpHn2AdMIMq80xMqet5uzeO_Kbxf_5vovif0lBKlQy6aVW_UERpifhBT5LU
    a45e48U9WnS5ryztA>
X-ME-Received: <xmr:Um48ZwPGm6QaFdXPQNJ35AgmpLUI5HTwesOalVJrDuAdNT3mNowNY_WnAuPR-qeXD8210Xk1DJaLvLb1V4FOGTyEHnzELo5Y5K7->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Um48Z25t4XP8TCjSgpCZEYvlZXnWHl-w7i7aswygiuUJiDJLnDTVTA>
    <xmx:Um48Zy4w-GCNVZuHYSH4gJmTf-bnOyomJFH_iD7FDuGpg0bIGse97g>
    <xmx:Um48Z-hzRBSEOyIFu_GM7_uJRk-n5cEDv-KE0aRYJvg5NT_sNegQtg>
    <xmx:Um48Z05bxZ3-RRzCZhkrHTuZGP1egAO9IBN3pYj-0PC5zY668W6RLg>
    <xmx:U248Z7HFBCIE_BYcizEYsPUi4_BMbuCqW0OWPT78AhrOwaGps1yEvxBd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 05:54:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v13 5/9] remote set-head: better output for --auto
In-Reply-To: <D5Q32ODJM8P5.6VQ08LDQHPXS@ferdinandy.com> (Bence Ferdinandy's
	message of "Tue, 19 Nov 2024 11:29:34 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-6-bence@ferdinandy.com>
	<xmqqldxgez4l.fsf@gitster.g>
	<D5Q32ODJM8P5.6VQ08LDQHPXS@ferdinandy.com>
Date: Tue, 19 Nov 2024 19:54:09 +0900
Message-ID: <xmqqiksjcx4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> No, it is not, but it's also a mistake. It should be `updateres == 1`.
> refs_update_symref_extended outputs -1 for "not a symref" and 1 for any other
> error currently. Before I touched the code it was 1 for any error, so I left
> that as is. So we want to error out on set_head if we get a 1 and continue if
> we get 0 or -1 (and handle the difference in the report_set_head_auto).
>
> Thanks for noticing, I'll get that fixed in v14.

It is good that somebody noticed it (and it may have happened to be
me), but if it is a "mistake" as you said, I wonder why none of your
tests caught it.  Do we have a gap in test coverage?

Thanks.
