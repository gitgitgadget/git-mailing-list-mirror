Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94892E174A
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797326; cv=none; b=lTlf5VZ646RjAw4FVJhPYueJhPfZmrzsztUWZI1G/cG6HlKxW4BgwYz751pH8vrl7zEYmp/t6/6mnHEi40NoG1XnR3eZLf1ll8vrWjhR6yvJrTBxA8UpOFFMTkwTHmM45pHe/HPeu5X9X5NJHEtNB4vFnvdTTZrtVHyJL8Lrd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797326; c=relaxed/simple;
	bh=EEQENN3wqmdpzOkDAoi5pTc7I8aC13OqDuOg3Mrm9X8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lG5Q2iuezIplLzuNW2X6Kxl8xtMUbpCRNAHXisx/Bk0eFOrvDC6YwO9Vtx/attqiokLuZgAJph/yo7VTw8ICtwObz/25pLC8yTuV/ima/SxAiGfs/GuGF5oVZDKFEwLGztnz9LRlfU8pXX7D0ok30pb4mvTo+00/XolaG/fbHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CVHIyQLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HM4qCS7U; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVHIyQLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HM4qCS7U"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EF5A01D00173;
	Thu, 21 Aug 2025 13:28:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 13:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755797323; x=1755883723; bh=EEQENN3wqm
	dpzOkDAoi5pTc7I8aC13OqDuOg3Mrm9X8=; b=CVHIyQLW3lRphkZHCaVzx9QUmp
	NqbLnTT8nZ0I1P6ya4t/WJPctZHBjHVKv/1+t6s7wVa1bqsPE3YekZ/v5iGo7GkO
	U7Z2A7xeC+herSSpn1pPDLNtheyxzZTb4+r6kS/znL50g+FPzipKNKSL55kSldgO
	uc3Lh8zyQHwIB896t2eHSswfMr9fFy8tjkHlLvCfHrDrhymgBifBSNZE1mdEHeRF
	NyyoC+uzeGhRujGsUL45VA0xOEBVGNo9S9opQfIUZKwAEase/haUXCTfEm5dTe72
	Dob5F+rYOSD3mqC3a1VFDYtykJ67TdU5laMTEIvRnnMt7kMPPLkNqQWyeU8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755797323; x=1755883723; bh=EEQENN3wqmdpzOkDAoi5pTc7I8aC13OqDuO
	g3Mrm9X8=; b=HM4qCS7UJzl7O4vdCWiHTOpR582VtrPiuco2HztYqWwXmmdu/qn
	qj0kLpqDa1GWHxMpqNFvH6ZqHIu8EjZUdHmF8G1F3jR7t8kjeaD1KSmIKU35JYYZ
	ONprseOAmylAi5iVynxc7lYVd/L61mDys8ozTT8QEZGS6EY+T5u4wnMuAd9lNojb
	Ign6q2dIvhF+jT9FxwKySCLr0/UydgNxoHGAHYrWZobhZgLijGyj3m/0N4Aogrvd
	CG5pnYD/828/h0RrRbUIqxUXDqviaOrVbdXzMbCmB+Bc2HmOsMrN0hAlq37Oho3d
	MDIRx64gspMoUtUUfAgpD1UcOWzuefmXkjA==
X-ME-Sender: <xms:S1enaPGJrhkj8phKbD6jkxjqWFmTVheYZlg9a7G23Su84u5yYpGZeQ>
    <xme:S1enaH3UfYq27boJEd_-3JnZ2X97Vzpe2xmxUaqjQTI6tdWKmIEGHm3tQpi8opC0C
    2NJak9iZL798bjbAQ>
X-ME-Received: <xmr:S1enaHnxWNOFoIvk8zdmFoRimeX010q3WBmsTZPBt93kMvnXZw_hUGv5aA2w-Ibh_OPqtLPbsrbSsPmVGTzT61Z5Wm3rKR4YfH3yqLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedukeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S1enaH9Dc6QJ3Z2lcEf0TJkJylLIGJTG9r3TS3gO1RhrjOYX_dZA7g>
    <xmx:S1enaMowyPKrmws6Y21z427gCKBxPhmwzm7Eye011Ne92OVTSbgH1Q>
    <xmx:S1enaAmKg7fk6f2d6KuRFcbl92Rn8cloSt4Sl1_QUj3hgo52DafSQg>
    <xmx:S1enaDgdw1bc1KtnWOKvNm9R_VA8rN8eGJa3b0e1MS6p_QYy_gALfQ>
    <xmx:S1enaLU5SlpHW2RNyDRlNYT7pQtgftEUx1B7UOiexuOBb2XrNdny82L8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 13:28:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
In-Reply-To: <65E661E9-B926-4EC1-B0EC-CDE2CD1557E5@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 21 Aug 2025 10:29:19 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250820144247.79197-2-lucasseikioshiro@gmail.com>
	<aKb1BjPfmjBvHrm0@pks.im>
	<65E661E9-B926-4EC1-B0EC-CDE2CD1557E5@gmail.com>
Date: Thu, 21 Aug 2025 10:28:42 -0700
Message-ID: <xmqq4iu037p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> But I don't have any strong opinion about that. I'm open to suggestions.

Don't ask for suggestions before consulting CodingGuidelines,
perhaps?
