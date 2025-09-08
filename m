Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFF20B22
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757305057; cv=none; b=qB2pKgjRgL+SA/ug3hcAuh6uihBGupRGLqjD1/H0sHz7SpCcU4scdCwZh88Pmc3DJKbErmBJa8m4SvFtkkVZbyXiUgpn7V3cO2PIbw0gunHZsACFwaBx7m8NNadSwvZPslGrFT1D60tS0qq7zyiaXiycVIgE/+ceuQHmADxGAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757305057; c=relaxed/simple;
	bh=J0e9Rmx/HBjkKusEUspjoNPXb48GdDdrcxIoq5WMmno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ogOOelmw8FpoKKqcmqY6wZ1ZLJ/xNYCYLM6T3VnJ3cEiNbFD96XNE9P102Q4NzdAfo36tJJR6QvsMN+LRA0v7zSkOwWPu9746WMLOK4bLNmdtPxGdbYY9vXXf4secX/1LVQrfuIgq0/4kdMl8R44yXg3LvkW+d61Kz973dGIHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wp3mfbye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bfnqDguF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wp3mfbye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bfnqDguF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A964140008E;
	Mon,  8 Sep 2025 00:17:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 00:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757305054;
	 x=1757391454; bh=yD27AXUwPTWi+I8cuALDpGvqjIC1i6pu5EYrBl6xI6s=; b=
	wp3mfbyeM5lWasCMtcOYyazv9xQ0QY9xbck8PQyOm3iRLJ0S8ri87oCW7LuhysMe
	DNiBv8lSHDFHq2vGL1KJVTvboBlkq/6DLhLvgXrGejf6SacLxemRhYpsUSDXL/sP
	V5LqtJVrgvAQi7fcpfoQ9kG4NKmPbVr61WwzZNR7AITT1q0iJJnH+KvqHOakVYSZ
	3bK9myShbf541BcfNEeBr87ig4EyE/qWgCkcFVY1jn48F8G61Fg2EV+r/rawNwuL
	tcZbse+AuT88sbZjCfi8aPl5AuPpVcsvsdzfFMd+ooir99WVsNhlwlxI9kUewPgY
	waK0lcvIZXqEIbyIWugHRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757305054; x=
	1757391454; bh=yD27AXUwPTWi+I8cuALDpGvqjIC1i6pu5EYrBl6xI6s=; b=b
	fnqDguFkZXcTZDXJOoKfLXznnTC1RmTxid0mdCgyDJ2Vvm3N1m9OmkTCO3S9Rf9W
	cSdsO4nGx4YBj87yphLvSNz5XLMibqwA5nxam5U5U1UJ68Ia8deGizYXYxFEVpEN
	xtnn4jHOnahEcvY1R7ZYDOmKDEJP7HFeO9yBSR6D6Ao+Ssbd0eEurX/1MJBNW/Nv
	s5CWaBahopT0psSwiN9AZv3Ru5e/HKrSDJowHOMS4+swRZm5AAVtFF1lwt1gktX1
	UfVdhJHgxMIvD0OJXxdgw5kstqABBeyFA5P6lbfC9zXG6996ac5h0iSdummuxi6G
	og0+iwgELiKsdh5yBhR5Q==
X-ME-Sender: <xms:3li-aCXhuXZns5I4XtLGAVfFwhyh8IJ-r88YCyUCyQLbL1kTWWE4jg>
    <xme:3li-aB0jBmblhvajBeABZu3QW9mlIgAjzU0pfPv-iGtfK-POx81wncAfsm7gTvOJl
    yLsvg_y53v_Dz9sPw>
X-ME-Received: <xmr:3li-aP2Er2FFxZe86HBYQtSbxyfwTKQgkcAucgHiyKaptHaTnguHACGd3uVdsFlW_YCUmKr7utAX9JIK5xAyPfmdfTX5pcJ8QlxzVg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3li-aE9p1LJey8NZppj_GKFvp4QaxB4qCz662pOnPaiUlX8he5xvAw>
    <xmx:3li-aM1Rc5xt0wFidJXL_1pvzAg3HY_va6ZFol3PZv7uwI0zkvzqEQ>
    <xmx:3li-aB8MZ9XQjrutOir42Y8OOScYI_x0yjnww_6knnHXFh251exUFg>
    <xmx:3li-aMvDhuNA0lhAM_5KGvNmW-cMcA_PV2KtjC7vtcMW2fzxPvgA9Q>
    <xmx:3li-aEFNDZ971t1hC4krccUeHVHQcWC5U9yqbJ2tBX1X6usMj434C4ij>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 00:17:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] object-name: declare pointer type of
 extend_abbrev_len()'s 2nd parameter
In-Reply-To: <81d10b44-5b3a-42af-acf4-ae76f2fee298@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 7 Sep 2025 18:22:18 +0200")
References: <e0bc9a67-faa9-4218-a55a-c7d53c15cfce@web.de>
	<xmqqv7ly6kup.fsf@gitster.g>
	<81d10b44-5b3a-42af-acf4-ae76f2fee298@web.de>
Date: Sun, 07 Sep 2025 21:17:33 -0700
Message-ID: <xmqqh5xdzig2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> I can see the appeal, even though (or because) it's kinda half a step
> back as it keeps the original local variable, in a better place.
>
> We could _lunge_ forward and add type checks to allow the compiler to
> tell us whether the pointers' journey through the void is safe.  The
> trick below is simple enough, but requires bespoke macros AFAICS.

Once there is even a single step of callback interface where the
callback parameter has to be a generic "void *", we have to cast
down to the concrete "struct min_abbrev_data *" either explicitly
or implicitly anyway, so it does not really make that much of a
difference (and that is why I said "we obviously do not have to").

Thanks.
