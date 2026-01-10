Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737B23B615
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066492; cv=none; b=OIXFEcxdGdmM9udsqXGU7qb/vrn1nEc+YzzJjrcTRA5EErDiAXWKMKxPf5bndatDT/K6pIcWtLfVma63G5y+LoLLCrJbQhK3UocQLDb96cx4pgknO8GUYP+acbYFzYc5Vm7NdtI5ZyyNQZgaG6Av9NkGg2q/i3TrlgUETQk2v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066492; c=relaxed/simple;
	bh=21Kd9DEFij+e9Yqjf76Ogh5wFTK8GaxDEIWwsJc3x8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j02n4DYFUgioj/LnhHAi1EkdKscwSEX7L58WhdJiUsJZJDg0rZw7nsvpquVtIYBlJYyWFF3YKNC4P3rm7P5uuZm6fqQilhIkSk9OrykAYEFob668WoML5O/GgHt+LwhxmAGbLbUP5Xji0XWz+z4stkSEq+JtDUxrvE7z9fjLR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CmZxtZtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nx5ccYUO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CmZxtZtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nx5ccYUO"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B12A1EC00FA;
	Sat, 10 Jan 2026 12:34:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sat, 10 Jan 2026 12:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768066489; x=1768152889; bh=21Kd9DEFij
	+e9Yqjf76Ogh5wFTK8GaxDEIWwsJc3x8E=; b=CmZxtZtZlVTiN1m8jMrsYV2Mt0
	tiAT1i1TaCojHlBEOC7SYStkwIgk/zHjkhcP8lmnRIiSNhwRbNRd+4Ay+1udQZV2
	eG56KIPtEMvBqJWefJYnf1U4RqbkmLhh5iy2lev2dYnWsRUaIh+ou7z3eFg96Rf3
	KC5Nhe/ZE7VlqVqtnJ5NuVx0Qc2hxoiaHYcf7ZdIAOS//I/PODTWBsXdXxZJ19Mi
	h0bwa8o6ZpsrPEGkUpPDSP1f7zb/xXSQ1Dk/M0ZUvJOl1sE20pjRF23p2XESmhvU
	yVf7lWG/FcV1bY9Fsf9S5+7UosvXYcc8jeoJutLxR7+olfYrLHt3U7hof/9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768066489; x=1768152889; bh=21Kd9DEFij+e9Yqjf76Ogh5wFTK8GaxDEIW
	wsJc3x8E=; b=Nx5ccYUOTX0yBH72982jtyrGVrSRpeS2dKNUbh6orzyMXwn/4em
	bpILqqAEzwsgOPCtGeSfP3mHEF3wd4E39EbAMOLR/3EYpFhQCqNHOKmcW1059fmM
	lOwpo9c8Jr5TR+8TWV6TAFUsGYo8Zp2Sah+BNUrM7ifMomyedDIUZif+S7rPHyMa
	mv5YUOw7CgC9mOebloErwCuGCa0RWxfXx0CitvyP/qOPuqdlQIlZezk7+bdocx+q
	lyxhlWDdUI4HzAcQCifhDst2U+7LEsXEHC/mNWuy6lDYe8IR4BNv/Z6u40MnHjxz
	3Q2J69hsUK2lLowmAhJTRcovSMItoooathQ==
X-ME-Sender: <xms:uY1iaS3dZrCikKLSBUi3Mm4qql_yQ90VojZjnDlMISxu9y81yQ3MOA>
    <xme:uY1iacFaLdWWnzLUPlA9aWPOjvSe0KoRWEERwxGNOqVCoTfT9CSbvUiZ1pcbJ3SwS
    W55L1aN1L745WXx1a_AWtcNufb4i0sNGznhplZCNuxC50L4MORJ458>
X-ME-Received: <xmr:uY1iaf4Xr_klIibei_J2O2QoElUP4DZl2GBR1HEcmAKSIDHQ1Kdoafcgx47-r_ZeUbPX5YZy-Jx4_IJvY5WfTRZnlMXc0YZYLfVlg1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uY1iaSt5Y9qtDnhB0XT6e9EP9YW9_eussPAyOjNo1oyujDTgdMD_pA>
    <xmx:uY1iaQ5vHAY8HcX3GVKxgV7o-nm-rFffRZo0bIwynz0eI2LIC2opnQ>
    <xmx:uY1iadUqYPnxjAUVTFa9WQn0h4n9IvwEd-Onfm887FVOMYFi1XrLJA>
    <xmx:uY1iaS-utE5Z5r0k9TmWTwaNz_JOii640iRVBg_okVQswE-RxzG8uw>
    <xmx:uY1iabbnYkp91SB3ReY4BXXHHduew2tsCzIyroIe1zq8OQN6aG0g1kyq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 12:34:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
In-Reply-To: <20260110111431.27230-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sat, 10 Jan 2026 12:14:31 +0100")
References: <xmqqbjj2tdu0.fsf@gitster.g>
	<20260110111431.27230-1-haraldnordgren@gmail.com>
Date: Sat, 10 Jan 2026 09:34:48 -0800
Message-ID: <xmqq7btps75z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> This is not a new issue introduced by this series, but it is curious
>> there is "ours + theirs" there #leftoverbits.
>>
>> It is part of ngetext() aka Q_() call, used this way:
>
> Agreed, I thought about this one too. Will update it!

Please do so as a separate patch, not mix it into a patch that does
something else.

I do not think we mind even if it is left outside the current topic
we are discussing, if it distracts the main theme of the topic.
