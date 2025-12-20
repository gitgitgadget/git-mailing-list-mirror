Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C71F461D
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766211074; cv=none; b=RqmrRsqV6t62fOcY1cms64x6S5a0JNw2hMco05oWOB9i76lPcQr5EmQ6Lhu4of2bcQ6NZ8youKOb2M6EibqrcFfK7+P/d6MXGN6zHgA78Xkn+R4C5po4XqWI5uoEDyDI9iyUZ+FYR1M5qa9+AnLC8kVmp7/uuP0wWf3w/194QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766211074; c=relaxed/simple;
	bh=HbezG3U49rRP3MRPODNS8mvL04yyBdFTDq/ybph6c3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbbYLO75fqj60nx5/ufFjNVIsYsm60TIX0pgwDWesCPYifZax0qtSK+FguWV9Iop5pHGdpWSUWxPaU6sgF7BKhyP/K7VGTYq3DCB+FOdWRWSXdY/zFxjrbx6EbS6VbZSs1KMnvYPkWAxyQC+oiF/Bqt+9BlH4TOAcwvL6yAfQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ObMxPrRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRDgZ4ke; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ObMxPrRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRDgZ4ke"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F428EC0070;
	Sat, 20 Dec 2025 01:11:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 20 Dec 2025 01:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766211071; x=1766297471; bh=eTuNDKysK0
	dxYN3zY+5NljTyaIjomb0/vOHqURUoPKQ=; b=ObMxPrRCzL5zYtI6Ndc59NvXR6
	qAIyTGuw4nmj9yUrnEvzqqsMd16j1RZ121YFurElBcBGvtLNDedGuGKQmBw+2gQi
	EuARFsLXkAcNudce7W6QG4s928WObvO0VD34S7Tm5Je46ndE+Lxvp9uw7+H2MmFG
	Bk7hr5dsgiKvoEvJpaF+N+MpWp4AHg787Ndl4ujJlY3yjKsT5iRfy6Pz22Ap7dP0
	BxRhAVCLDxjF/etPfiZuGemKEOskXLYA7mVRr7ujPFjI9BK8qLHJovEROK42/ui9
	wuQngNANT6O0BhTmcH76j+HDhi/31vLpd++AMMANqfiXiAcZ3s+iHIEmM44Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766211071; x=1766297471; bh=eTuNDKysK0dxYN3zY+5NljTyaIjomb0/vOH
	qURUoPKQ=; b=FRDgZ4kecC6a5ZwCnIxVQg+SGIsdu5ncxRW70O3pmICMHzcg5A0
	ulKIk0L98LTXgyoTitSlQ/e3upOW7ZtMv82LGCUGyjiTgbTOv/Xzr7Zo9NnP7KVh
	HzFhjUaeDGo95e2H2kxHGd8qcD/zxnsUmfT15kpiPckODZiWtzorCJq4g9xcQvlt
	j2nurMZhV+An9AWn5VhvFWWK++1Ks4uZvKn/7Ay4dEXNd/c6vE66gui2m6YTm8eZ
	lz9Tr3fTvfGlB6FqwvzcAQ3FtSWWdv+mMB3+zE+/b0Kv5EE/g98cYtquYSXevlhe
	qA4rlBRboQiflIX96Oz8Cc63k+kGOTlHFlw==
X-ME-Sender: <xms:_z1Gab4rjDPQjO7d3kdu5CouCZSoA3HmZIY0neaUIH0FXubsnhUm3w>
    <xme:_z1GaXw6UBR-4OcbZvFMY_a6VCPxFAeMxtY7sNCm57bUgJg-ZY74tf3kKxFeMOX_D
    ojCPrhZ659ppvgBnoWaQHOxMGrPAneNO_PvBVcJiqL8y4BfS8L94A>
X-ME-Received: <xmr:_z1GaazhFtDzEaKDWeqLQRCVouk5rNH5-oEgkZAeCaQtgK0kYHjUXHVTgXu1A2Se_bCqSHueaA7sKv1v8iPMC9GKbUKVZHkPvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghmrd
    gsohhsthhotghksehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:_z1GaXzIr-B7vCSymIsJR0aoLJfC9bDPeY4ZOzw1fQOuoGi0xHx6fA>
    <xmx:_z1GacaBXSjfzeUOoUQ2tYF-oUYU1yrESPa00r-F9gAuThL73LXK6Q>
    <xmx:_z1GaQV_7IyDZtGm_blvUo7c8M2Xr_ujyHhSOcWA4JKvlJoRDQj3LA>
    <xmx:_z1GaSjbpT99BP0kkYIPT78MhFRsT8fL8we7vKSQIu3JZPJQ2rQ_mA>
    <xmx:_z1GadbvBV9FCt7oFk6oLotpKvCliVtjhWt4LV9oXovEEFHNiJX6B-Y3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 01:11:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Sam
 Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH v2 2/2] worktree: use 'prune' instead of 'expire' in
 help text
In-Reply-To: <ff4732b72a0d8c97c668167308039918362ffb9c.1766168169.git.gitgitgadget@gmail.com>
	(Sam Bostock via GitGitGadget's message of "Fri, 19 Dec 2025 18:16:09
	+0000")
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
	<ff4732b72a0d8c97c668167308039918362ffb9c.1766168169.git.gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 15:11:09 +0900
Message-ID: <xmqqms3du1he.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sam Bostock <sam.bostock@shopify.com>
>
> Use 'prune' instead of 'expire' when describing the --expire option's
> effect on missing worktrees, since the terminology is clearer.
>
> Signed-off-by: Sam Bostock <sam@sambostock.ca>
> ---
>  Documentation/git-worktree.adoc | 2 +-
>  builtin/worktree.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Does this v2 use exactly the same commit from v1 as [1/2] and add
this [2/2] as if you are saying "oops, the previous one missed
something we should have updated but forgot/failed to do so; here is
an improvement?"

Don't.  Unless the change you deliberately made as a follow-up
improvement is logically separate and significant, that is.

Thanks.
