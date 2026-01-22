Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E1354AFB
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113104; cv=none; b=CmYsrnkU2+1S/JZ690XKtJCx5XcbxGMUuaNuaiS49gBdrAJw9sJP5+2/Q+D8H/AQXU0Giyiyhkjiq61/ZEt0n77S2cyo2dO9No/Y+dKdY1BsXamKF1QaZ+sFhzgQG4X9pOUQcdOhdUjB6tUvbz4UAHXr4omlRyZnUSDKF1aJZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113104; c=relaxed/simple;
	bh=nt/NXgudQ82SzuTkAjxwDDCy7vibMs583iPxNBYh6wM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4zeMxLz1HB87eYtxN75D8bfQu/3WLVZDJnOey6ZyTp5w129CmFzKb7lSCAnwB9as9wz+PiwaDjwt9+pFiVeaQCXIdTJuc+Jeu85B8T9GxZgXgVnDJNTlxyUD/JUd4n2c0a4prbZskE1bdemDfZSknY+Fa6hD1/QZM15P6wuDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q8YgV+Wa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9sFlem5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8YgV+Wa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9sFlem5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C8443EC09EE;
	Thu, 22 Jan 2026 15:18:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 22 Jan 2026 15:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769113095;
	 x=1769199495; bh=ef4mFP6JiStodbb5RJsF4tRrP57oY3diFDiS9JF0YZI=; b=
	q8YgV+WaYrfEa+7H7yq6QU0TFDD5/7expCWmoI10zQ40G684CS72ZgEoF/H7D4O5
	b1qpqsSzgfUH/8UayWMOxGLvqV3kjC+ghaKpP3t9jMEA0QPVfoWK/UTZE2minyU5
	JlqZPHFuir+L3lCASCYPKcHBxRifAto4NR/m6knLfG46bpGIFSbnbP0tzuUBciuq
	gIwduVBwd5J50WMK3piAGCRDfHn3EyPCxo0VCVkdzyj8p2EnNm5WTbSMZy+0lMTA
	YPunE4qcYKSmPMuZoTgolBmEtW5QIFDTxII7u30R2NUiPQokT6McpvuWjJPB/z2i
	T3f7TY06XFrIQqCLc3oAUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769113095; x=
	1769199495; bh=ef4mFP6JiStodbb5RJsF4tRrP57oY3diFDiS9JF0YZI=; b=A
	9sFlem5vX2Gx32QT6ewkKeM6cRkhM6T8Vml22DiwiE9BIeXzLiDRbuzfIhlexwS8
	WaH6z8zJ2GJk3PY0eEiHZ9ndL0TNBRHwNj2SdTdReaGr3FQpmqY6gE3eN0U6pJXH
	NwgV3UK+mHDpd7J5/lwy4LACYQb5edn3Y9cZJ+LYbMbCnGvEUfSt5E36vNwEBeIc
	WL8f0XI5aULU2gTlYnO+CmWDqdvEWtgOvhWNDFYfRJvklQ7Mmw+OfXH9ZaFkTA7V
	cDa79q45v25DrsLCugAXxKHyabNcAomgQHF4EdENvFgMbaG8JP+Babkyb+tc3qG4
	EFak6bPOok06tF5Pxln6w==
X-ME-Sender: <xms:B4Zyab44dSI5WNEMLkOu0U3UaB3eSD17MMpiuVdjeyfwk3eIcFMn1A>
    <xme:B4ZyaXzDOCtpjDDpVxy-d3ZrRPIM_LaBQxov-b1-jH2YYt5rczWs9B7p6mbQ7sRvC
    FiuhZOxJqzEXQ-0jG00AiuSMNm5h8_W5cz9pMrCAukOU5WktpbRJCQ>
X-ME-Received: <xmr:B4Zyaaw2L8iRIxOUAbcMrVOlZd1uI9j2wwzATWk8KPSb39k835pycN1Vha30faDplk0dwwvHS5wuePJudoTrWeRtdQcsWAtebIlIK88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:B4ZyaXz5abtyOK0Epfa6EOnZHVpdNJKZdZp97T42PKeMpgydvu4_qg>
    <xmx:B4ZyacZeqr2EEIKz_qF4yHSOnZMUhW1SFFOTzTv-d9QryGbaKWz6IQ>
    <xmx:B4ZyaQWYNOkUSiTHvX-Sy5h7pri3KN2omOOWntVTKMaP85UGRS3n5w>
    <xmx:B4ZyaSiAzlwBm8NSUH76P82fJUT4EOmOQ3ficFEX4LFkupbDX77rrA>
    <xmx:B4ZyaQT6sD6zIvx9uRdri4LP4uZjmgfOKm-QyA6QEG5FCWhu4IyrLgYd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 15:18:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v27 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260122192238.76368-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 22 Jan 2026 20:22:38 +0100")
References: <20260122190751.GA2098026@coredump.intra.peff.net>
	<20260122192238.76368-1-haraldnordgren@gmail.com>
Date: Thu, 22 Jan 2026 12:18:14 -0800
Message-ID: <xmqqcy31mmex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Using a string list like this is quadratic. It probably doesn't matter
>> too much here since we wouldn't expect the list of configured branches
>> to be very long, though. But a strset is probably the better tool, like
>> the diff below (note that its "add" can be used as a single operation to
>> insert and check).
>> 
>> I don't know if it's worth re-rolling for this or not. I doubt anybody
>> would hit it in practice, but I'd be more concerned about people
>> auditing for accidentally-quadratic uses of string_list and stumbling
>> upon it.
>
> Sounds like a good change. Very nice to have insert-and-check as a single
> operation!
>
> I'll update it after passing CI on GitHub -- I'm running CI from two
> separate GitHub pull requests, because one has your memory leak fix on top
> to allow the leak tests to not fail. 🤗

Thanks.  I think we are getting to the finish line with this topic,
finally ;-)
