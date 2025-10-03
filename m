Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFA1C84BD
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511271; cv=none; b=UhOh99m105ZHX+/ODz84+a2dpqzyfjXsm3sC1GZY3d3Ct0U+ShgAy2dv/THVCTycdKoM8M+j6x5zrkDwhYItR/1QInqFuED2LyjYn6reHKtTJAwiUfTu4yfykTPOFddo+Upu/yefMu8kDNUx8ylbwSubvkGVl+HA38PTNn0Pxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511271; c=relaxed/simple;
	bh=x9DMP55DcqaBivn5bw9JZdYg1WMxXByiM9ERBP1bTFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHg+FulTp+41sadPMi/UOahSfCdIXnGOya9L8d7d+/5gZ7BWexSlAjvsD4tQ+KXchgtOLLypUBQDSGaq9nT81olUEJmZCkm6KIsvUEVBZ0nPHdO0CNuivQckxVOdrsAEGjjD8JFOQ58ZVBBGiaNgHRixmFCJszHhije+8m5h/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M1XQubGZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p8ShBEOD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M1XQubGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8ShBEOD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16BFA1400127;
	Fri,  3 Oct 2025 13:07:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 03 Oct 2025 13:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759511269; x=1759597669; bh=x9DMP55Dcq
	aBivn5bw9JZdYg1WMxXByiM9ERBP1bTFQ=; b=M1XQubGZ21MHnLWaWrQsBOaAsK
	jBJCSue+2v3IzzARsKOiTM3NkSWQDOgFB8gP/EkNJpiQlhKqpeCuKvXYfuhe2cuH
	0xqhQ71uLVJJpKLc7pG/NGmvUipO4XbE7bgn+oG/c5GbYUgbWO1F0CmwyaSi2qno
	DykLCMq2TLvoWam1gkYI5ZWss5vz1k/ET18IpgzPjihGzd2FLyS0IAsSwcYP2aqg
	3nF59jvolPBCnWGkAM/1UR/T/vsR4FAOJStlWTLVTWfVG9KngGpbb8od9fMrJSmc
	ezrPb+4JWvd6orCzmH4JFBoAzRMYah/9HzFmik4Q5BVJj6u4HiufqWhyQ1sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759511269; x=1759597669; bh=x9DMP55DcqaBivn5bw9JZdYg1WMxXByiM9E
	RBP1bTFQ=; b=p8ShBEODQmupJAP4j2s21NgYrgpRucgyk+H29SwuzSKqmSCapX4
	oUff1LqJLVPstLkcxzpFAoNo/L4cB1tZvoeKGLDh0kM/5/cs5lQmPYi3RpvCoJO5
	WBn0C38o2ZVo7cOxMJuDjQ0bpYbWwSqydMfamNaAMUcAB/ysOin4M2HnTpymBfdV
	5xs7tLJyVSsJA/jNe15Zqqrk0rs93Yn6Vku4lEisVQqR43oS2bUw+IfR7/05NoXh
	+HNwOxLzJYq97h3ywXbxEaNXkPSLsTnXWTO3m79Tb4GQ1jmMR1BJVQvltM3SSvyS
	V0amCLz/E3hT7PssDKlj4OIUDNxD00+Jf/w==
X-ME-Sender: <xms:5ALgaMbFEEVk4H-PD7VvhYWgzmVPiaO70G7uh4cr4ExBI5v6ZABauA>
    <xme:5ALgaObZiuOrzRY3OLQgT-hvvXlceyklatEvLVexLxV1r32SDWOvU32amWMIdEql2
    T9WAW68GOgd7v5xb_cqvllHrUQbdZStQPf7EYgWbYuF9YzT6kwgtA>
X-ME-Received: <xmr:5ALgaL941WOYxo-aePqUMCnNM-8L70QZWPDPsnWqN5B9quQTO5P2PG2dZW3fVH4iOhnR_Rb_qQs5DKcPYIjJIwIPNEXiiUw2X50V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:5ALgaFgRlBdk7QdfBYliaAddLVW0O-iaskMRFYGHTEVtmt_Dt5tECQ>
    <xmx:5ALgaDeoAQzJPYgVGM9mzs-SridySQHHR0To2RJDhl_64kPod6p9bw>
    <xmx:5ALgaEpXIK3vmVepCjgSkOEt3x_wbzGxCubX6CCx0D__yWvaKcbMug>
    <xmx:5ALgaAC6VPFOgjaLf0UskISg-cDRr9cYddaFa9kmgOmnJeW7BGiP-Q>
    <xmx:5QLgaEhExbjn2Q9yKClhEs5jNC9GjS9O18JSVn3WNP9_5j3AsrVokdro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 13:07:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/9] docs: improve ambiguous areas of pack format
 documentation
In-Reply-To: <20251002223855.1022847-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 2 Oct 2025 22:38:50 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-5-sandals@crustytoothpaste.net>
Date: Fri, 03 Oct 2025 10:07:47 -0700
Message-ID: <xmqqv7kvud5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +=== Object encoding
> +
> +Unlike loose objects, packed objects do not have a prefix containing the type,
> +size, and a NUL byte. These are not necessary because they can be determined by
> +the n-byte type and length that prefixes the data and so they are omitted from
> +the compressed and deltified data.
> +
> +The computation of the object ID still uses this prefix, however.

"however" -> "by reconstructing it from the type/length data as
needed"?

Other than that, the new text reads very well.

Thanks.
