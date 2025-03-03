Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBD20E313
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019580; cv=none; b=XXQLKBMRxWNIYw8EieoRPtmWLKYCdoycsitCg09N+alBOy4ItDf96KcDAgUq4xgGK6XIHEISCqlJvNBhpAOnGCgf6XpjDU79dr5F9JiSivsFLX505UM9ELjPLLq/C7GtHSvoAzPFFcaiVeW/XpG6U0v3jssT7avjI6XvhyeJ07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019580; c=relaxed/simple;
	bh=2lswjifUMwyKb5a6jsRLixtMZC5a6ZWjTaDdpPsJ0Po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbN5/XXWqEmX4Pe285X7ZgWNN6k3/HKfNVVrPs77kzpCH98HabUB36lo/NvWAS5ct3u51gVm5xl8ofKwHTdT5dZDjFwiEmrLjV3L248aPyOYhmDhtEXfS5ACb25IWh8CuatZF8ng7LBHrIqa8hv4V/rDtHyQuio2leXcb7scMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qPfVEOgm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RtOnk5qx; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qPfVEOgm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RtOnk5qx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EF3BE1140197;
	Mon,  3 Mar 2025 11:32:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 11:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741019577; x=1741105977; bh=OtdNP1TfGb
	tTtkIgssivxHDjC3QjY21dbNUtHGd8Ph0=; b=qPfVEOgmA+fJdPYShViUjN1Fl6
	3upD3OGFjTrGdiczzxL8YN8hoX+SmdN9pVFDXo0qgVJwSFzutuqZmhyyZig/B1zM
	zarFTJfH5gPpSSWWKhsHLDaTuCQ8itYE9YXkJkAv0d+2ZtiE4GfyUoSR/bLuuy2e
	pg7icK/SnjnogV2cE9p7ZwIZRUQ+UlQf/8QGxmHfWCIWUkMRiJitmmJx+5hKUeCF
	7MHGxMEVhET+kwsU652BREknzqY6iQ2ELLLpu1KCuDliKBmOxZLVWv016RIDgyFP
	RR+oZC2XkecKJslPtqzMku5r8C1g/JYfpyorBRsxshVut8aoTE4XgSA8bswg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741019577; x=1741105977; bh=OtdNP1TfGbtTtkIgssivxHDjC3QjY21dbNU
	tHGd8Ph0=; b=RtOnk5qxxD03nitfMeQrAQ6+iN6hKyyOvpcZUHefD4Cf/i3hAkE
	6W5CYAJQ4nZATC8vJmbItBoxmtX3in32GWc/IWRshWcFDcnaM3QXqsSDkuXa2YHH
	bMpCodTA4zwV3plHsNthsW+Vd7OiXobwdaAaAcpJEZ25C3YX1ctp4QvdlyBMHLf6
	tApZpPgFumsCS88l3CI55aNw/eAWKOcF0xIT2/CT/ABQQB22tL6KidiTTxWzaDnj
	dgUXkgKn/ETMUVhbOJJHcqVNBcGwFFCbDW0DdXe5BRLm1wVYrOOdxhSOel8wP2HK
	9bgdCn0pfuxdOlui2s1db38rBHSEQ5zObLQ==
X-ME-Sender: <xms:udnFZ5OqoueboC1xnt3FkVgxIWpGLxTsRK-vLgonaWjNdfZktS-snA>
    <xme:udnFZ7_O_MbrXHTlHpxIkV-NmJ60if9xNNPUXjPCtleRIBt2A4N4oQCmat2c4oqC3
    APc-ZSxiD0cnaWIgw>
X-ME-Received: <xmr:udnFZ4T51wxlDh-1rqc9KY184qTUHx9cOgW4y7Q0473UlK_3rlGbGFNUtnDLrO3FzjWf82Eu_pFsGyQuPynkez1ZVILKkb0YFkFB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:udnFZ1tBtUQuMUmP2yka3p_NrHM7eB2cPHqpg45sH5GwwWD4uNch-w>
    <xmx:udnFZxdaDID_P0tm6kzAneO-hb7uAp8C2QdnfEqRlqbFBW2kSr8mXA>
    <xmx:udnFZx2iTR4Rwa1eRQHmZeHWN53wl-GGEqNvv2luqxQ1I8Ig5Nb3zQ>
    <xmx:udnFZ9-lDbLY_Uuh_FbM3OEhzJ2jWm7IR1ZN0wzdbjjXUzYjD9WPuw>
    <xmx:udnFZ45x9DyIb_mvANPor3PiESZEhEg6oe32fGLuLfBvMkIVT0zoi-Hv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:32:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: Re* [PATCH v2] BreakingChanges: early adopter option
In-Reply-To: <Z8WE0SK5QS4aVyYr@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Mar 2025 11:30:41 +0100")
References: <xmqq7cb77810.fsf@gitster.g> <xmqq1q0mcnt8.fsf@gitster.g>
	<Zw9ppbrFqVN5S50J@pks.im> <ZxA5OWL1AuQxA/NC@nand.local>
	<xmqqv7su2d3e.fsf_-_@gitster.g> <Z8WE0SK5QS4aVyYr@pks.im>
Date: Mon, 03 Mar 2025 08:32:55 -0800
Message-ID: <xmqq34fuxefc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  Proposed changes and removals only include items which are "ready" to be done.
>>  In other words, this is not supposed to be a wishlist of features that should
>
> Thanks, the change look sensible to me.

Thanks.
