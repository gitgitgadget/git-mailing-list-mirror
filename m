Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1617E4
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554504; cv=none; b=ULIDKFmZVvzfwTdxsM1StMlPCsBxWwHTsrqiOzerDvJTcNtmod50aUbtTpfIkkdUEYgCRDAeBqxB4EkyFBF8o6PhvF+7ARrDhEbw3vknYX4LsnenF8L47ADJA+dNG/WcGVO/fzKyIUX1X/r4XcbMQYC1N6Q4d4EVVr5yfc8SdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554504; c=relaxed/simple;
	bh=4gNdZbWw/7z1f/cuoCpfPhcRcsiarvoYgVPgfuCtoAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dS9yIv7Nh66tgmuWhFKg407JvxlGNqzxEzsiVo+ZkfnWWREuJ3k6lw5zG1MYKxTh8s4fORfNueV6CDIAmRa6v0JiY9vlwf4HA6fQYdQBsUPlqiMWcRcR3xinUegytSZ23A1v1yLl/CND2JPhPW6yU5rhbv0oRxA7zZv+QS4A+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0UOnvY2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSt8uD/Q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0UOnvY2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSt8uD/Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E6671140144;
	Fri, 10 Jan 2025 19:15:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jan 2025 19:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736554501; x=1736640901; bh=Hubumdp9x4
	+cRCTNqUiWx6UCWbe3Ij3MJJdwtuOxmII=; b=0UOnvY2VevPdQYWrxPRjoUvh5X
	efp7cGv7TmxbTdNT5QeFILukWAMjMMwnuR03C9YTougghiGu8IUmrr5S7HhaL3zt
	lb1t8uwALyeun+qhgO3k0svwIbo+ylhgl1Ep1TRPT9hlJc7z+1xXyEaPcXfLRewU
	IQ3Oz/Nxy1YZTUPeeqsfZdhsksMN8qYWC+ez3FZjsQ5WbNk6iwdV4EpGXlkSRaKu
	WzHd61DC1spCSUR6vlbvNvzKTbTf39DDATR88JJwdMMCQKtGnyLI7kScEOdwzoj8
	NuMCo/gSUfaoIAMSXsCwyLzrSs4SdBNhwI6Ff99YfDu9E6W+e9bZFoqWiYUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736554501; x=1736640901; bh=Hubumdp9x4+cRCTNqUiWx6UCWbe3Ij3MJJd
	wtuOxmII=; b=GSt8uD/Q7PpZwIIdka1Q/rsQOMCfW+v16djCTo+RlmYc6tVuZQt
	mP5spY4Z+3z35W9CMyRc12YS45evo4QxEPwVxM9Ss71f/XWMD6CCCMpNUBtHymgT
	WaETtBI3tfIQbc7qOb7f/eok+5S2B+Q1EnRAURkey5einfjHDFiwx+bUglpdqEFM
	0Q1EwUNcWvNbA32pTCClreZxmqgY15pHzAVL3RPKQn9mXCjsRwQdgI4Rvb3/+yp/
	JhGQ/DJYlvtFtPwBRiJz94IzKkiGZwR9CIT3BFx9jNLwlEubeq9EXLfqFnonrDWB
	v6Ob0W6LtRmKeJVBoTos240XW9Qc5zQo34w==
X-ME-Sender: <xms:BLiBZ7cUrSwabAVFQ3eSCSkHmHeT2n4PT9Cfl1i8Ku2N4EE2kQavrw>
    <xme:BLiBZxNY-JjrTJZWnDCR-W9XltfYNOfWt8-7BuWFXhOoOA14LUGuQsMSK9jGo5-kw
    g4aJx6b1hsrb5f2nw>
X-ME-Received: <xmr:BLiBZ0jqwuORBs69FGZsNt_KtHVbN_SbCAOXEmX02Zvnt5AHjFN7ovmDjOO3sbxBcM9MJ1X1bGy2k3Rf5VPdgpTO59ZtSrbr4OBZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BLiBZ8_cvccBQLvaoZ9rBBtq1exKPMDRY7fTV-O_j053L9xcOUi-1w>
    <xmx:BLiBZ3vCUO1Apd2-gOMs6GY9HZNnGtd-JS-ZrW9mwTtLlr9ktf_cwg>
    <xmx:BLiBZ7HsZw7jw_ay7As-exEMSeVsbSqw-fe7MsH0C9WO2jGr63crIw>
    <xmx:BLiBZ-NesKQld-O4x70MRCLBywxkBfVEmsvvfFVx6XJM8V5x1qA8JA>
    <xmx:BbiBZ7gVdWDxKJE8xVm_ClQBBD92qQP-rG3eBhnzLBO78JvZy_XX5WJU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 19:15:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com> (Taylor Blau's message of
	"Wed, 8 Jan 2025 14:14:29 -0500")
References: <cover.1732130001.git.me@ttaylorr.com>
	<cover.1736363652.git.me@ttaylorr.com>
Date: Fri, 10 Jan 2025 16:14:58 -0800
Message-ID: <xmqq4j26cikd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> (This series is rebased on 'master', which is 14650065b7
> (RelNotes/2.48.0: fix typos etc., 2025-01-07) at the time of writing).

The previous round was based on
<cover.1730833506.git.me@ttaylorr.com> which became
'tb/unsafe-hash-test', but this round is based on a recent 'master'
that does not yet contain it?  Does it mean that the 2-patch series
the previous round of this series was based on is no longer needed?

Thanks.
