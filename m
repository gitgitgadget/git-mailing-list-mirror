Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6283335B155
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962308; cv=none; b=uZ3lCsfsaqnndYvsVI6eIbH0y06ImT05KKW9Bi0IxfqCyPMYS3CHIlXLHXAF2h+va8h2xYO8SZi77hzum+KENeyto1h71ug/boMzwi7awFVB/w4aPBe9XmWB/a1nwBpUUckRy5LQJHqw9XWWPw55ug8hPmvaa4f7395bWiPiUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962308; c=relaxed/simple;
	bh=k3sibM3p8Cfq+0PbXjC3uaeLz2Dqg6pJv/K81AySU6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYVGI4//mCpJcMVMoQV5aA9eZKtX39MhD5Vr9nE5HBX1Dxl0zVJYAWdMnTmkm5t6zGjlnyP6G4PtienT47XCY4qdjtOGnHEZj5+tf5BN//R0QsdcQt/sSBoF46kmx0MlARxiMK3dQyWmFW6KhvIbGmZBZiR3vma/DoET5RZFxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zrvm+DwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mczua4OC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zrvm+DwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mczua4OC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 435617A013F;
	Fri,  9 Jan 2026 07:38:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 07:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767962306; x=1768048706; bh=vh+VzFaRNr
	G8ujbaiSpL4o22d2EN1h67iayMrsFja54=; b=Zrvm+DwY/uwfReTlnZpGcSeoRn
	y2EcyT1Oy+vWpgvnOYsMaqfwZJ06MdMSaTIB1JhHS7WhM+SQQE0xZ6nKDhiTnQsC
	0Zo0boIis6ANUoawgKiJfJE5s9XA3Ml1jWP+USmOd9BUklfN8Qq8GTVMP6YZUIrK
	o1c2sOKdsCsZF5zv9LxhU4Tl0FKZ5aqIys3MyfbqormlhooiOM8VETOmDtSKu5qs
	SEvM+yRBXydTOXYNsEiSlYSVJoSHuhRUhmrhIW7DlcyeMm2LO3XgBZOAfxyIy/1d
	QGRr1UXr+D7a+CHq7Vb2JtYf7LShSjPVuDJ6LIlw2qv4ffks5ElJGbfMabgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767962306; x=1768048706; bh=vh+VzFaRNrG8ujbaiSpL4o22d2EN1h67iay
	MrsFja54=; b=Mczua4OC14Eg8GhmT30ocG77HsSw/vDClo8V+MtmnpwulA4J3Sh
	RKeyfkm1attTi66Y9pw+CY0XYM4f4Rh8hbSv7rbjI+VQSxun+CWXwWng32rlcgwA
	RH09qT8T9EAxzJ0Cro3JyalkDGYzGCYomTjIjvjnTtgk8pBnQFoOsIBj1jhr7omF
	SR+dVPTmfB+vpFXn4LA6pC8qhuPzl7ilW6FoncDqZEWF8XDPN5LCF1ZAn0h971Ec
	qZkrG4lVuP5745uSGgK5nJ3fZaOPI+TA6Js4sna2YLePVZulCyBJjKhaULQ1BMEN
	Sm8lrlRm3FbJdgBcNR3OoGcJw5bpIaKDBZw==
X-ME-Sender: <xms:wfZgaflmTbhDf9yP_K8HntKcbi4BaeRkU6AQ-7j0zzrC1xQAr4-BqQ>
    <xme:wfZgaVGS0t0PRQ7wEdYz8FPxaSeBEE61iQZKcSTW7KIl2PsLpG_KTB5RVPGDtgA3w
    pI4H26jPbJVatdRKBsculFZxpAs26n1xod2gUFtKvDVT5RhtnVM9Sg>
X-ME-Received: <xmr:wfZgaX7uDK7C0EXacLMlvDuEzQlKwSJZT1xxTDwnky5xZ4bMNmhYVciZ7O1TzUhCpNZq_dBi_knbrNJDF2a2rVw5lZLD5hNCoYeg2AlaTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhm
    ieekkhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wfZgadktnmh4Q7gQH4lgy4AyN54EE2YfkuxnruRk3JHWWlBGTFJ9aA>
    <xmx:wfZgacpPS2KvPy0Zxud994bnmHJ3ICvqdd2kCr0UOzdpjHmdS-aoFQ>
    <xmx:wfZgacvURZDm6LhVImQI5wDudtHlQj3eDhxivlOhyghZguLJpLgPAQ>
    <xmx:wfZgaRFY6NNODJi4VzL8g79YsezW_FZpxaA2GyyIrPiP772AjtwHaQ>
    <xmx:wvZgab1oCLa1wMPHh5aU17A0HAoqmxF5FVyR5HN8FQdkD7-Ag8cqZKxK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:38:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42aa09cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:38:23 +0000 (UTC)
Date: Fri, 9 Jan 2026 13:38:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] sideband: introduce an "escape hatch" to allow
 control characters
Message-ID: <aWD2vOwzmuiWdd_m@pks.im>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com>

On Wed, Dec 17, 2025 at 02:23:40PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The preceding commit fixed the vulnerability whereas sideband messages
> (that are under the control of the remote server) could contain ANSI
> escape sequences that would be sent to the terminal verbatim.
> 
> However, this fix may not be desirable under all circumstances, e.g.
> when remote servers deliberately add coloring to their messages to
> increase their urgency.
> 
> To help with those use cases, give users a way to opt-out of the
> protections: `sideband.allowControlCharacters`.

I wonder whether this is a bit too broad. The only escape sequences that
I can see a valid use case for are color codes. So wouldn't it make
sense to discern color escape sequences from all other escape sequences
and allow users to only enable colors without also enabling all the
other, potentially more dangerous ones?

Edit: aha, you address this concern in the next commit. Nice :)

Patrick
