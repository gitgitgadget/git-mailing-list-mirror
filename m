Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA00237164
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927647; cv=none; b=tH1lXfIOc3UKCXphLkj7nKImLg+eufO2qN0jYFSXchBBQfiApuT5KBBUDvAvx/ueh6EjeyhPlin1dzJpTr9aA7pc4QgZrkk+yQYpHtBN/ObSlMiN/zixPip1Ikxf3wmjzXEvHWvgJC7mQJ78TIrfIiGo3JYHlqGzTVZOmDPkEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927647; c=relaxed/simple;
	bh=hq881p13E5gI/fadQF7obu6pVSZJpy9vDGPYyaRnbLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UYm1FIS+QzcvSTSMSVlb8mhI5mvfAXIB3QFI3Joottg0wlTN4QxFpU/q8AxP9HxReutEDyVAKuV3IGb/jMMT+hv0noxVY7AZaTcVWrnoGPqgd5Ryf7yQuqaC35ZTFehsQMG7/PI5gxAzHRUYsg2w1FX7DFKu+ycSgayXi3SDvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F0a3E8bA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0PfHtQ3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F0a3E8bA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0PfHtQ3"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22F1F1400200;
	Mon,  7 Jul 2025 18:34:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 07 Jul 2025 18:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751927645; x=1752014045; bh=xrt4E+iS3H
	RQ2SX9h95isi5gi9cXEjehDGDxJCAIwTI=; b=F0a3E8bAshpn27HpHtVvWcIsdD
	LEGXdXBq1aOZtE8vCYcOzVgg+vFORhf3HUTuR6948MEDhnTYUn3PZLKudL7MebjF
	L99TmFCM2XPbCJ5cs9ykdl+MSnoktnZsS12hGCKPC9OEaC0PYRUvFENRoYKuBUBg
	v8iG8H2yfcc+TbP3S41QzpGtrvHgC3bMnu9J3Ecsai4faZ5mJHoHMuNYiYxF0IGa
	fK9U9Zrf5hgcya1/moux9+klHzttNWiLUZksDyJZ2n+MRSXDwS9NQbGIa9Qamhj/
	OwVR93sT7afL7wvjsWyaGBJBDkwpPlFKaoZVVArtyhoi2n7ThpTucdE8ljRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751927645; x=1752014045; bh=xrt4E+iS3HRQ2SX9h95isi5gi9cXEjehDGD
	xJCAIwTI=; b=E0PfHtQ3DwWyyJiHBo+/2+RzP4Bw9Hp6mqmwyvyIOjL6kgduoH+
	KRrKvPtbLHAjAclj48YyTfMuQfIMT0tIt+EOK+/uXNDBPQ5yPaLcvYcMybzyfbAS
	ajUlvylSA5NfKH8Q9su2HiJIXc9JzzW7xpIIuR3SQMMFGYTnFmuCCwZ9jXCyL4bo
	eXIYz9EzDZ4c/+D2c+m7RYMDan1Lz4UBL1peIq/jfvcGxGv8Ce9L8Veb4hneYy43
	7vWK3wH4gkQjag1GeCjQi3MYbtSPE1a0aGreZJflb2+PiBlLpLX7AuiYA21Ezf51
	1BG/OuueZ9OdsBKpxgku+qIeiPcysulRDuA==
X-ME-Sender: <xms:XEtsaNtmFs8L-ueIGDvlQJGv_GHP2E_6wpvljGvgSa-3zRcLNgvRGw>
    <xme:XEtsaJuVVD1h60gIeP_6C7s7qm17VIkYLJZpFQscHV5f26AG7sR6XipCyk5vol8yY
    Dwh7JWXitugtcL0NQ>
X-ME-Received: <xmr:XEtsaKN4G1m52egzBLj1ScyuS3KyCmUd9SjZM2MqdJBCg3e94PnSqzbFLNsc40uhtEPzmGGitKxazCGfgebw5Tlyzy4Dn8KWit0YCbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XEtsaP1KupnwATOJnnVTHU-1PQeA1AaJOnNKfL-0ehYGCaU_voYwyA>
    <xmx:XEtsaOO8fmXOu09TQYUxmhfQ8WBYihdIw52_EV5NA89-9OS8CuN8XA>
    <xmx:XEtsaH1owX3zNLKDc57P9yCRGDbe-FYih46PcigkTn6wtXx3aGIUIQ>
    <xmx:XEtsaNGLpGvODfeVZnKSwsnCBpyiWNgyazCbTP6LZ9qLWLCN_ieOnw>
    <xmx:XUtsaOX5BiH2FFgpqVVWsyrYMS5LGixdDE5gyvFQPjaaTJU97biloCui>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:34:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: Re: [PATCH v8 0/2] Avoid submodule overwritten and skip redundant
 active entries
In-Reply-To: <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 8 Jun 2025 08:57:03 +0530")
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
	<20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 07 Jul 2025 15:34:03 -0700
Message-ID: <xmqq4ivn3a1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The first patch i.e. prevent overwriting .gitmodules entry on path reuse
> is exactly the same 
>
> The second patch however i.e. 
> skip redundant active entries when pattern covers path
> has changed logic 
> with the helper function being code maintainance because 
> of the duplicated logic. I've tried to wrap it as much as 
> possible to it's own core need without having to change it
> unless the core way of submodules addition and active status
> itself changes.
>
> The CI was tested in which 
> the only compiler error I found was 
> osx-gcc
> Which I suppose is already addressed,
> apart from this all of the other tests 
> ran successfully which includes the 
> t7413 (prvious 9) and the new one.
>
>
> K Jayatheerth (2):
>   submodule: prevent overwriting .gitmodules entry on path reuse
>   submodule: skip redundant active entries when pattern covers path

Haven't seen any comment from others on this topic for quite a
while.  How does this one look to those who do use submodules (I am
not one of them)?

Thanks.
