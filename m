Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D1233D9E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340760; cv=none; b=dQ0dSWuCqAFUAMX5AW5K7mrcB2VyduVnXcahOgfHIfChN6rNMgluRm6ToeunBdihpr7YxICs1TdM915zj2TBgR0xis7ZbSJzPaqcYGwgUDd9c0Bvablh/BBHPAZoLhwQrFhpxbUWiSMuV+Blr2gUVS/EgYd5SFhrSbBXj7zIEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340760; c=relaxed/simple;
	bh=U34Nw2O1dq66YkpsynwlZk2ZOETpsObK7TniQ1qw5ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqU0GNpXLa8++5bnIqs1Hf581crHa9iJl4skgP0StAKSH3SbK3GQxZL4AjkBjBAdWvPXvdf7uLxvzQ2ZG5zdd729vXgJw3t9ooosFhuPrDGgfNWau294jeIp6YCM6occN7qYFzegy76xCFGOJslprWYOffh6+0w4lbz16GWaMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cyNQGC/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRAnKPkM; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cyNQGC/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRAnKPkM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DFFA7A0279;
	Mon, 27 Apr 2026 21:45:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 21:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340758; x=1777427158; bh=Up59A+fWwm
	Hib3mD29kAU8h5asblo4lFHUeay9K3Kt0=; b=cyNQGC/2xMq5TLO0aXovgaLq2i
	hjIn9Aasj7t+xfHSHO2dCM6JVCRjpSCpjHyqhOuY/49h5Wp9nhr2Z4RCXu/hyvXi
	uwIwFQGGxUMY0j+ZFlG4hoXhZcFj3kN2R+ZtkM0nbtK7R3hG4/vMFRDW97KvlaEP
	BPvkqFumCFw2iJdEG2MOeVuo919xeODEdmF6BOc+caYOxcjeW7eGkF7iFzAF98cW
	m10C0rPovtWpNQJo7a3cGEiCFb7cApjuS0c+ReCJoCx4W95Ptt23zd7OjCKFFffp
	uOVE1AWCAO8w6hogmtrl7Fnqnr5DUefHQNRqV56fDnv4TnXxg+iiTEn79U4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340758; x=1777427158; bh=Up59A+fWwmHib3mD29kAU8h5asblo4lFHUe
	ay9K3Kt0=; b=pRAnKPkMqJYZaoM4IHh/0zeNLOKUFwn/XCwtfC7N8KfK/csMPWY
	EokgTd2GjSreQN9vLGJg7CJCVyUb4x6Ulm++Y1CSOIe4a/pOB2C4XthlRDv97VHB
	LpTw2XG5nv21w3OfUtR83B+y8YctSNk9UP457p0F3ioej3+1oz7aEI8HEEWYO0RP
	T7AJPSrtj420KQXrrxpK1y7GLPgaNwy3a5XDFI5/uyBMWe9YavOCoqMGt5T9iaYH
	paxt92pks2REOp1ss97zfAis8ZmFIMm32YS8d9ZdwIAZL1OAqDu0s7gvZdqr7iT/
	HjxzTCambkqGNd7jCUgXBQOCPkuhvCHQgVg==
X-ME-Sender: <xms:VRHwaY-yqOPcly2o89meuVdDC8wJomWunYQvwCmVusfxfhlYfgr_mg>
    <xme:VRHwafx7favU2iwPIoNuES1sKPf2N2OIFeuW__E6PXo9zgwH0b4dN2R0XOLu8doTZ
    rSoeencH9QITVuDEs1ymatw-xidlYopyWaDJpfs0eLJ1obt9VW7jw>
X-ME-Received: <xmr:VRHwaUPwril_VWlyZ-EnW3E4wZFig1OxQ5wbXZqyYaLc2DAYgOik7zVM3NWOfjy0mqnYfSErnMtjU5O7xkyI-RJVyiT4mvEwDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhnrdgu
    vghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VRHwaU-cBfgcFkiuOG3_ZQnz8AqsHybmYrKu1Wag26heJUtI8pUpxg>
    <xmx:VRHwaR4W5WfU8z_Rd89yaiRAWSX5Ox7LquqByZE8q54lpQ__VIvQrQ>
    <xmx:VRHwaa5cyVZLEjjeaHiDK3fqTdT9sAlRmGrZ83NXUSzRzw0D2SX46A>
    <xmx:VRHwaaoaLLR7_ZFZfRu1JTX68QEDdR-gad2F_iOQvP0gjiPFcuk9og>
    <xmx:VhHwaWFAeXl2IyedesB5Df5rSTgk9mGlBlbSoWvmAnFniKnrB6VjeI_k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:45:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 1/2] revision.c: implement --reverse=before for walks
In-Reply-To: <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
	(Mirko Faina's message of "Mon, 27 Apr 2026 02:24:57 +0200")
References: <cover.1776984666.git.mroik@delayed.space>
	<cover.1777249165.git.mroik@delayed.space>
	<4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
Date: Tue, 28 Apr 2026 10:45:56 +0900
Message-ID: <xmqqv7db26y3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> +	} else if (skip_prefix(arg, "--reverse=", &optarg)) {
> +		if (!strcmp(optarg, "after"))
> +			revs->reverse = REVERSE_AFTER;
> +		else if(!strcmp(optarg, "before"))

Style: missing SP after "else if".
