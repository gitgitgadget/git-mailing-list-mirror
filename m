Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD05293B4C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804508; cv=none; b=ZZRncfCn1Ss12kEzvgG5HB4Xpny860z0Dfvq34j36TR0/SQCC4/Bt38hiGSYM/TqJnpOPpxvydxIGw6ypfI/D38OBz+NQ/H3f8TKD1qUM8PMaNgURfaR4e/x6NVR0sKscTtrAfr0nEk4j0fMEHAmqwEWMZkSM/3TGnPCH6Isp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804508; c=relaxed/simple;
	bh=FnFk5vxHUiI1xAAsYsxC19R1ZfKImu9ZRv3lauw3w4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtRA0afy0S7tumdAKGdtvH4Ejkbtrzoy2z/oNF848SYXXNB8QCOXlq2Qzhalc2v70g+y2ddOtYnd7/wufbu6oIvsQwAlqMMmGJEaqnTTXg/Oh6d80nFQgQAVzWm+X3dwiqdniB3fKgjUFuRTB4B5KI404/4fH5L5zofwlnBDuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ks3G9PcG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B7siG6F1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ks3G9PcG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B7siG6F1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 984341D0014A;
	Tue, 29 Jul 2025 11:55:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 11:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753804505; x=1753890905; bh=bmyGg3YaCm
	TbeATzRNi81ejFhH6wvaLEWcOXHiqr+Bg=; b=ks3G9PcGuPfP5DpeTc2fBMEX4C
	ZXQxJempIAFhM7G//On66jHHbnbmSvPE3W6pnW6CahotXfeQQVHSMxN7BA9jQPVN
	g9XH228LdzkQgLPi9e9JrDftkAuSiPnyhyFQ96Bry563GbtbEi/ZK5Eay8Q1a4iE
	zdbxsj4+V+OHBy5P0TvTezftWDdRH84Jp94cxhwAbV1TStUKUc/JNY1OhU9rYn/4
	/hw7jwtJkdG0Q5NrGotWAa6yayjo0pZ+9AsT8oL0aCJDfvVDR4HpNzeIUW3vBPNV
	DAYf98OkS0xhhc1t3s8KvVjCZUz65Ptv1SzQHRAtnCYtXmT3ReB3ZlqEk7Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753804505; x=1753890905; bh=bmyGg3YaCmTbeATzRNi81ejFhH6wvaLEWcO
	XHiqr+Bg=; b=B7siG6F1zWy30H/00RGZeDhfnxcvSVuaCVhJHA4eo4s4R1+4u7/
	PjAwn8MdchKlDhKVJFOIA8DsC5d9ceJrxh7A3kgNNBG5ykSpRGqJKAozMJl0d7Kb
	QMnSX2BKJRarOixqiQ9vz4SMyPjtIKdtIJOfR8yB2xwMzwSbMU73M+fHBG34KWOT
	yJPmd8l3M5sA4ZUkn/XLxxXxQyZcBf3Ah29HRm45zDSM+kCnFjzE7wEMoKol26+j
	qtO7KrLeedTYTl6O/QYYPoVjN5+sfs9nuudw8su6lbGSDoVa144XJrZGh7VzFQa+
	gwVIm8viw+6OKL8MI5y67BTTGX5JqGGEX6w==
X-ME-Sender: <xms:2e6IaOTUDNZwxU4RrHLvTAGXxo3JROI00xRnO5TSpkW161sWSa6dSw>
    <xme:2e6IaAs7eDjXNGg7TaGTS25tcB03DxedrAPtt1sL1eDKKMyfNX0ivqw6sU4FYWG4q
    -er_ThBrOuyrqQJQQ>
X-ME-Received: <xmr:2e6IaHcjSn0P-rddFZU13HpAcgwu-EJGN7YGgiawKcaI01Zpq1mQ0dyLDQ9ki0bYxc66ljkGQ2cO1uLQGsApOjzg1_1XAb_t_1FgR14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgv
    ohhnmhhitghhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2e6IaCaSYABpzFOApvOuvkEZpfufNnK4C2tPQDLCSfaq4u3s82TvDw>
    <xmx:2e6IaBZcLHyDTFycTYcYAmO4doPvIiPpVEJelEbrUwd3hLrQ4PHHUQ>
    <xmx:2e6IaPJJqjSepsIJ0ry2ztgL8en3BNB-KBZh-PdSR_yQ89Iv1QFU5Q>
    <xmx:2e6IaFvIvKQ_IvPELSGERV0ETBBwK0p_BSbCQx-dWkCwvvEZcKKvxw>
    <xmx:2e6IaMQ6CLgZCgOoYOntVGMztWTiMPyifSJr0p3yvmHpJDdv1B6i8wI6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 11:55:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH v5 0/4] Better support for customising context lines in
 --patch commands
In-Reply-To: <ec7481b5-5244-4a76-962f-d3bed9e4172a@gmail.com> (Phillip Wood's
	message of "Tue, 29 Jul 2025 16:21:03 +0100")
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
	<pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
	<ec7481b5-5244-4a76-962f-d3bed9e4172a@gmail.com>
Date: Tue, 29 Jul 2025 08:55:03 -0700
Message-ID: <xmqqy0s7ouug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Leon
>
> The range-diff below looks good to me. Thanks for working on this
>
> Phillip

Yeah, the new one matches the previous one plus your fixes to the
tests, which I agree with fully.

Will queue.  Let's mark the topic for 'next'.

Thanks, both of you.

