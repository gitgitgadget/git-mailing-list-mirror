Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CF192B88
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921097; cv=none; b=cURbTOvHMlOmSPeRxlr5rB7Nq/FMP9lhvm6dSXo1DTb3ZwIrVjxDL1PDz8x2u1BNUyJ7N5670FUUqaRKAHWwCjKbhOxjZsqPOv3s39v4IpM2Z8Zv9Aa9YcawNAskGyyGoBJt6EctKCq59i3/3//fV3f8xOBiucm0fbzVVIdVBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921097; c=relaxed/simple;
	bh=Xhr02zTwuBNm+IcEy2LcCOaH8/5XPbSqwIF5kUjx+Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcC0Puj2TJOZthCHQh29pu78YsJCuQyI6QIk0bLM9ePku5EZeuIWMAXu/yRlCRBFgkSVovWu2cYEUcqiIDygZuZ5iLcn9GU5riQbhnrLjqZLFTvBzYV+yihfKGv1aG3ed4ywPH2rt1OyFzJppKgND3ChP4c6/SEgBYb+8rUe2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z47B7B1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDVz0eR3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z47B7B1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDVz0eR3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 444F1114009E;
	Fri,  3 Jan 2025 11:18:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jan 2025 11:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735921094; x=1736007494; bh=jksg899PCd
	D5UnOy6BiGkoBEESVX1LvG+tCld9aRcgw=; b=z47B7B1+LTGXHPql1WHHPaQ+Ci
	WZzSKHLA7Pg5di7NK4oxTsR2pPjf3xiG/e+UedA450//QpKyBMqRCdO9Yp4n8/qF
	K0UdO+st82kBuIqtKznqPTPvwE7n8O12SolTAA/pVbZyk+sYcH8R7OfDCglf6Cbp
	VkJX0OXfi9JZOPNOAkfAta/VklEyLSz/mNzEz1iVoVu3ZskmtrBb68m5jYW9pPnc
	C5CCBuiNX40oGSNMrfX4bRsGwwF5aPaC98F7I+X8HNFATktOR+g75xwvaJ+Loo99
	qZA2T7pDOZT3eetE3YhaQcxkFjuJuyTbhmEGwaFyaEUts3b7txso0PmoWxEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735921094; x=1736007494; bh=jksg899PCdD5UnOy6BiGkoBEESVX1LvG+tC
	ld9aRcgw=; b=fDVz0eR35cTG2+j+n5HJqIyEmnQWImuBupS1SiHY2/brV//9wFJ
	YPIF0frZe3mmGNQWrIbjh8JQGIN5yOteZedTtYPq9Zir6GrnAjBj3gSuKKsoi4Iy
	Cn/JpKK1Xe2sHrx9K2NT/pkt3rI/AecbzwForrTijpLil6Cv6j+BziZK7Q5fvf6N
	TTSvgS828LxY5SBSoIFukfAruqQesZm1xw9XlBYNNYyJdMbDb/w+HtUzw/KkEPEz
	xqBHUhfkRYBiX9a5+eT0yH83VaNTSdt04SILJUY0RlomPU82gaoFDUhIGOMqptjm
	wuRUuyFKt6GBendNWFHSoDAD34JSgd231KQ==
X-ME-Sender: <xms:xQ14Z3JMgov6MMShdHEubxN7TJ3n5rNlsBcCCYZIRfb2KkF-DGNkjQ>
    <xme:xQ14Z7IUNxQ0lfJIMG7kHJS7jEBlhy_SRY4DRbKKtYCO7A5k0cSWAkgU0ERPde9dC
    RHqYNfEIdZj9i7dpg>
X-ME-Received: <xmr:xQ14Z_sThH8BBG_USG4TYwgxfVVSjVxDTSMifblWFFn8UsEr_b1FKSBBjVJlaFIIGW1V3C34q62eikNtWaLwWWEOeKxJw243Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:xQ14ZwZwd0_yHj4gQmoj79rQ1K2ZtuHHnVAHgzC3Ys2FBPQCXc6t4A>
    <xmx:xQ14Z-baS9pgkBNJIK976wc-5JEm1cy_PCWFsv_OehAgp6xwatZArw>
    <xmx:xQ14Z0B05dlWdXd4DFBFwmd7gOjg4zG_bj-4B0xCQn3J5O_B3aBgwQ>
    <xmx:xQ14Z8aQwQpm6OswJGXPfUdkGQ-uJe3JJHKh5MqOC_A_1wnlbMt9YA>
    <xmx:xg14Z1UybteIH9CKW-OXpR2BAcOrGU0bq-BpyuGZwacjYlWGuQXCsns9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 11:18:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
In-Reply-To: <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
	(Patrick Steinhardt's message of "Fri, 03 Jan 2025 09:19:55 +0100")
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
	<20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
Date: Fri, 03 Jan 2025 08:18:12 -0800
Message-ID: <xmqqo70nswfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In a preceding commit, we have adapted `check_collision()` to ignore
> the case where either of the colliding files vanishes. This should be
> safe in general when we assume that the contents of these two files were
> the same. But the check is all about detecting collisions, so that
> assumption may be too optimistic.
>
> Adapt the code to retry linking the object into place when we see that
> the destination file has racily vanished. This should generally succeed
> as we have just observed that the destination file does not exist
> anymore, except in the very unlikely event that it gets recreated by
> another concurrent process again.

OK.  

The way the new code is structured, we are set to infinitely retry
as long as our link() fails with EEXIST yet check_collision() finds
that the destination is missing.  It makes me somewhat uneasy, but
such a condition needs an actively racing attacker that can perfectly
time the creation and the removal of the destination, so it would
probably be OK if this code lacks "we retry only once and fail"
safety valve.

> Furthermore, stop treating `ENOENT` specially for the source file. It
> shouldn't happen that the source vanishes as we're using a fresh
> temporary file for it, so if it does vanish it indicates an actual
> error.

Makes sense.

> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Will queue.
