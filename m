Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B51A08DB
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252397; cv=none; b=e6bY52KIHmll2i9f8cg6SMgenD16wJ0gPAL1Yj9yvldtna2+vEKMx+iU15SZLPJYmMx2ihTlY1/iegcdNl7ZqRCHnfJW+8xQsEys/ieR9kNFnsuTXwXhsa5sZ3kaNUuDzAQudN9eoMixsebTOHDjzPqQhRBwfXE2wY1v7T8kp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252397; c=relaxed/simple;
	bh=0D+TV1dMelrsVIlwLRTxpcMgJQdrBLt8iW15JFDGaEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H4Vtmu8mw4HhYfZEj+17SAoCrKk5M68QZIV0d+f+nbOxIiFMoifiF3Bfe/vaXne0JPtyI2pVRvCSSGvaJxLo8OY0EE8H3Dgf0gNY/anARS1oFmzr862JyiJjmWqSHWRQhJvN2DN+z4ckIG/65V3pKHqRj34NAXaNtuOJShip4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pqby1V+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCrE5NsG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pqby1V+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCrE5NsG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAFBD1400238;
	Fri, 11 Jul 2025 12:46:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 12:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752252394; x=1752338794; bh=0D+TV1dMel
	rsVIlwLRTxpcMgJQdrBLt8iW15JFDGaEs=; b=Pqby1V+9wP0bDqOLSSlOrKY9tU
	EJyqMVMswOrwlgM53vF7cSTD3iP4QZyJ9G/da/oPoxn2crWfUh8/kGcZDRMZ3mau
	JLxytChsgQPRkogqCNHy2cL1kl2dfxG7IKgq8Zxpou/42OCO0UFihs4Rp4sHdvYW
	fcCnADLL6XFH/LhkMbXaScBxO4eaXaiAZjvi0xc+4Wtmu8M5ippJNFRcq0/zACa1
	IbLAR83rKMQ+ZuOtzJQaB7iljtroXn8AeziDo2zsCC33l8STQG95xJGDqeiH1AnE
	Ik3d0asqULmqG7PruoY5nTY1XmREkM/EGKHK8aVwmCHNcJ5ndWY+7//3f03g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752252394; x=1752338794; bh=0D+TV1dMelrsVIlwLRTxpcMgJQdrBLt8iW1
	5JFDGaEs=; b=YCrE5NsG2blgqOeeoNuI7YL9db8KtRSLLIkt5M3jzwzACj4BIlO
	f0m3NW5Q2NE7ZPqxNG2gOeprkT42EyuIYRNMo0v/pV7QYk01Mno21vT13GJYpdw3
	lNuff41VqBM1yA52mGoP2a5GZ8cLg/pEIJjNfhFO1n4bm8icys5T4tT5oGGvLRJ9
	nDXmTJtPjJG5RloGyU8xZjXJSq/W3fxX15nL+KJ4W8BvyyI90E0ObXLoHZ3VWZD0
	OLrW+wPsp68oNsOWqFyCFaJqYow5ilsmGtcP3ltPDdAI6fHoGsA4ZP3dvVGcBYBY
	WgYEuvGtYr3oL1FD8WfQvutalvu677KCmIA==
X-ME-Sender: <xms:6j9xaB21WRdzdcT54ZPR24VAZ3aTIA6Bk8n4MT0QodkdjqOMnY6kYg>
    <xme:6j9xaAiGae-noAfDQp_aKt4zlr065Y-xFx1DPFSbhhb7m2NeWneUt3aH_TUWWpVvD
    DEb8AuBROXsPzMoQQ>
X-ME-Received: <xmr:6j9xaCWxpiGqAcgHbz2b-Tin9ZpDbHcKJiiXiAAwJ29SL3ekVpii8qqfqZadIuki1XyAnRcqDNKHn0XKte_NYHjKJ9qfEY7FkFXrIQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvg
    drtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:6j9xaPV5suErxcNwC2h55V1O-if9oqAEjHwVXsCZZSbGM62PIZbvKw>
    <xmx:6j9xaCgqnOXetuKAleHuNqXQYvI-WgjXTCym0feFhJkcezfPrH0Yrg>
    <xmx:6j9xaKZZRqzyZSFd6ZK6E637P7R4zSXRGQ4I5eYeSe7SskisR2M3JA>
    <xmx:6j9xaPpTVSbtb2JKQPVaBrmpw4amumgB9dU1ylHVlwBFMKWDE0t0AQ>
    <xmx:6j9xaNO1u-brrQBa0UdbuON11M1M9qN-ZiYsDYgVRub3Y1qtu0QXtkdv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 12:46:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Collin Funk <collin.funk1@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [External] Re: [PATCH 0/1] Filter C and POSIX out of
 Accept-Language
In-Reply-To: <CAG1j3zGn5fS=_Oftu7bBmWsoMc-aCa84AtDXdfxgL8QFEkp+yA@mail.gmail.com>
	(Han Young's message of "Fri, 11 Jul 2025 10:49:03 +0800")
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
	<xmqqfrf34qdb.fsf@gitster.g>
	<aHBH0nRLPxBg2HAj@fruit.crustytoothpaste.net>
	<m1h5zjk4pv.fsf@gmail.com>
	<CAG1j3zGn5fS=_Oftu7bBmWsoMc-aCa84AtDXdfxgL8QFEkp+yA@mail.gmail.com>
Date: Fri, 11 Jul 2025 09:46:32 -0700
Message-ID: <xmqq5xfy3cbb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

>> But as you mentioned converting them would require a database of all
>> tags...
>
> Hardcoding all the locale names in the code should be fine, I guess?

That is exactly the "database" we do not want to have to maintain,
so not fine.

> Though the problem of filtering out locales unsupported by glibc is more
> troublesome.
