Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDD1FDA9E
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601154; cv=none; b=VRc9eWLD6ZlqxeR1lhIUgJFLwnrTLjpQxZAXfKu4S4hqV02n3OmN0fXvwuJGvJBr5fLB9lPIgtZN6ffUi3S38hkOngn2DQuthLID0BvhhYAwQiM7wCYFWSQKEAgWDQxZjWY7NEQW/3mOMQuKYHwDQaTvser5BkxluJjQEIMxJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601154; c=relaxed/simple;
	bh=G/eDE7JnVm/QPI8ywcZSobYLOe2Ha0kkrynKjNatLss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUhaZEIDQkPb651ln31jafm34H0tIuFfDTlbkz1/PHFjqdKdpZsf5JpO2XqYMBnIv2xm17ipvfExn9aSBjZp4pCauWWIFjRoHETfX9rB1SyhU/hvkx+78OgdftVmulwsmaiOKtmSmeZc/NkE/vMfd5bd8ZrgFPGUTs9qKf5j25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E7eLA51p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZUSO6hu; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E7eLA51p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZUSO6hu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 657FF1D00285;
	Tue, 15 Jul 2025 13:39:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 13:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752601150; x=1752687550; bh=fUuWBtdAIO
	6c+5en0aTN/NHiZvn26EyMjgVJoVE2P38=; b=E7eLA51p2Iezk6tksPmq/8Q6tu
	EXu0EXEQHGdfukrB1caHP+h12fzJcKnAf6CiSAjxUhFggnQIOir7BmWWAYsPTVbG
	hIyrdA6J3UTD1zkT+btky09LbkhsmuI2UdIGiWNuLVL8XM8Jf/sZuwWggORhSuB8
	9y4AIUEaDWoDPYzB4tnCvRZ2/q4PDM1Ha7t4G029OjC7v3GBqdUnnoc0JCjzy60l
	3zEIRfQh7I2zhbmHLq4xmiIJA17VcyvUAeysSEQ4TOlORsnKodYoOmA2cJd696jq
	GPknTgdrYReXnErJmR+ChxJ5R+Y9D6Wz4PAdXF5kPwJWk701ah15kckQCh6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752601150; x=1752687550; bh=fUuWBtdAIO6c+5en0aTN/NHiZvn26EyMjgV
	JoVE2P38=; b=NZUSO6hun+wLHpLl7lfmo8fvQk4JO2gM1dD+HTLnPHrBmlmR6Y5
	qwEWIGFKUi7qW+TaBP2+Oup9AN4I6ugVArLjdNbcezjUJWELOYGnCJZRf5uAYqa4
	1ZVBoVcHDUfb+WKelaUyEAvBPkIXoq0ffme7axGzhi5xgPBhI54qlaEifAxoY4Zq
	cK5J3F95JbvgeCX/hOPnNVwF3YuZiK2NhC8D4IXZFrF8Gj2Ks380ow6sEiJ4DDA8
	7Kvz/jhTAOUPQ2l64PT8UaO8bHgUYCWFQpgMcJHuEMcYGGTbHm+VWLu9kQ7Kjv4x
	iOse82aIxAIuJoUpP9pYJkbfU7i0pRKFliA==
X-ME-Sender: <xms:PpJ2aMBCSz9RhTmEaxrrgo_BWSTGG09yC58hB4kiaFAfDiowuW4SyA>
    <xme:PpJ2aBz0gc5N4tbp1awh1ucWTygeZ_3VYVIjXwTt7d7Bekd60K4OrnBMy9hr2HzxS
    5-Ge9JWqLCWg8uy-Q>
X-ME-Received: <xmr:PpJ2aJCbQOn3eaaXKLRBMDYib_ozraaFKVo6UckSto8HixzN0tZ4bedKqood-GunB250t-MNiOTKs1qyeETVWSobyAsYx14bPloYjIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PpJ2aOYXZw9itJ-Fh6Vpr7AT6v1JQKNrb151W-5uG9oBOZ5Kr2isrQ>
    <xmx:PpJ2aBhS97TQEG1hYXyolIWsDG8ZcPAhLcJz3_j66SmmR8Er4ytWJQ>
    <xmx:PpJ2aA6OAi2fYqh3vIzyeRqQK7aeWcM7cF8P21SbwyEk6wXAUhJC1Q>
    <xmx:PpJ2aI7QzfEb2kzURV3enp9Xom3WMdPS5EUnfDcDm_KYIigbn1Z2qQ>
    <xmx:PpJ2aC-xE5Gx8dPo06lXR9O19hPh_l4QsyscIXJXN8taok4lj36W5EOv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 13:39:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #04; Mon, 14)
In-Reply-To: <CAOLa=ZTtgQqMZLNL0jLfVMWaSgn7-APt_NYVpJTj4zz54kXH-A@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 15 Jul 2025 06:29:35 -0500")
References: <xmqqa556sddb.fsf@gitster.g>
	<CAOLa=ZTtgQqMZLNL0jLfVMWaSgn7-APt_NYVpJTj4zz54kXH-A@mail.gmail.com>
Date: Tue, 15 Jul 2025 10:39:08 -0700
Message-ID: <xmqqa555icar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * kn/for-each-ref-skip (2025-07-11) 4 commits
>>  - for-each-ref: introduce a '--start-after' option
>>  - refs: selectively set prefix in the seek functions
>>  - ref-cache: remove unused function 'find_ref_entry()'
>>  - refs: expose `ref_iterator` via 'refs.h'
>>
>>  "git for-each-ref" learns "--skip-until" option to help
>>  applications that want to page its output.
>>
>>  Will merge to 'next'.
>>  cf. <CAP8UFD06KKF0A0WjBSw77A7fKp_pGJGVyw-OPd8-X92h=RSF+w@mail.gmail.com>
>>  source: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
>>
>
> Christian left some comments, so I've pushed a new version here.

Thanks, will take a look.
