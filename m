Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884830FF1D
	for <git@vger.kernel.org>; Tue, 19 May 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160279; cv=none; b=mMJEueG6EQziqzQk2iTrKtADQ8a1bGljb8KceJU0yf9qkVK+Ve5ACISvoNs3Pyg7HAuUz/PJQe6qyQEi+qMmbbjXSoC8NOULiFR3CBipznUZEMb51St1AgR2e1vxYQEDQLQCVwAoSdnneEEJGVLyT12qcRusamV6aHHjlOajKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160279; c=relaxed/simple;
	bh=R6g9yHLLNxH0n82V6zN4XBNq2xCeBw7sNuG0X/Wstxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZHst9i8ayKD9qSBOdLpqsCAsy4jVZWrELBxcXekOFNNY/OKPApZD7kvdLA4NXnKoDMrbN/0coiHDAFCIvFWALycBDYf0ypTlMIC6AYav3hcLMm4NJ0a4jh+5LPqdHfJK/26/5RchSihQNgJyxyWtmCXy7oMKo4en3BxFqSvNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YCoPsb71; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EM9jTw7u; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YCoPsb71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EM9jTw7u"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4867BEC007C;
	Mon, 18 May 2026 23:11:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 18 May 2026 23:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779160277; x=1779246677; bh=U6k6pEkZM3
	BD1MuFqYV28tgUzO+7q488X2CxZJhg5qg=; b=YCoPsb71xAhmU4Cq94g7BO/cWY
	5Mq7b/mlClwflygdsNm8VuhlKsfMF0QmuKuFSPuqSMMUcNwG5HQOm+/BEhPGv45s
	8Q+0S7EoCZgg4CHwQJiOLS6ras9JOgjsSHjimk5XftoNoqi/5GxBHxWQXAEe+GGT
	Fen+lYHFwHyUVZNIIcNrUMbj8+Ps/6BKEA6rYBteZSBrBHLMIYw3zRiMUxikj5it
	3BM38/sMQErnZTm4rAEviL84VUWyqV9B/LpOIEC2eHBnBvFqCzuSUCkcN77Uu4G0
	oPXFAfm4mJZoiEAvwv1/bG6JOVhH8mHipIQWsCKmpgFT+be9tLU+1d37aQVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779160277; x=1779246677; bh=U6k6pEkZM3BD1MuFqYV28tgUzO+7q488X2C
	xZJhg5qg=; b=EM9jTw7uEOqyf2lcqzozH+s0ZWymWpIVk6Trlba1Qb9HOf+iVXA
	PBYgIAdKfmlnuYss6f11WLNICaDXKPep9SrxwmMCZsRi68Me92sGzAKT3NZ0U4cZ
	aNlHK9Qhhzl20EH8YpLzLVY/nFoSo5BrHXdecVdASelCWcr4de/RJ1oaHfxBnieJ
	CI0erhiEd1c/VDx42aP+C/dYKdzw5icdgZi1C9JPg7Su6cZX9/1E2zUV5BTI9pSG
	F37cAXkvCPmUMaxIX/W2qJJf7+AoZLvDvdGJ2/mtwdDlo7Ny+r6cSdy2pOkAoc5o
	vJdTgjHwqRTfSbYWR6SHXas5dwdSwQ1zPYg==
X-ME-Sender: <xms:1dQLatTWUy6Ms6H1gVEoorHA8RaIxA5rxpcdrEL09PcgiBOi8k_Sbg>
    <xme:1dQLaqcxlucVd-QnTtTiv7JkLB4BXRpb75W4OTxM12RXO8DFCn03QSoFXZFMOZdOA
    K1VNIz5RYrR5BqUvAMqWbTbWmdcaSKYcP0y07Ctibjoksd1Nw4vCWs>
X-ME-Received: <xmr:1dQLasqIRmxiX_UvCXD7IvkNb-UHq-reJ3asEIcLLnwIcswcCiUwn8jK4r4-svwgHIQx3LD9ImZtxvOF3nima7nn2wp2dk0HLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomh
    dprhgtphhtthhopehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepvhhinhgtvghnthesvhhinhgtudejrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1dQLar8pE6P9Y_0BrF7G9m2LgPoDuLUEemZQnDPIlTEAF8iV97cXWw>
    <xmx:1dQLaocvNCtwqPmBwUQKrQrQpJEenwnQyXjzNEJOX56-F_MbBIkBpQ>
    <xmx:1dQLalKlj7kNKzQLUKp4qqH3b5WdIfewmMNAV2qhxFebEw8oXOuFzA>
    <xmx:1dQLaoiGUaJThM6W6WnOt86MttTiT53OsOnb8boqZgBvsTskeB-NgA>
    <xmx:1dQLamXYD1QTtDaS9VgpE1OwgOxMFibTkyho7G6ifMWjQ6hyja3QJI6K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 23:11:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  vincent@vinc17.net,  git@vger.kernel.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
In-Reply-To: <CAPx1Gvd_FqnsjCkpAA5uy7aDz9oQnWx7WTvKk-kLWemkqF9PsQ@mail.gmail.com>
	(Chris Torek's message of "Mon, 18 May 2026 19:31:35 -0700")
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
	<xmqq8q9migqk.fsf@gitster.g>
	<CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
	<89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org>
	<CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
	<CAPx1Gvd_FqnsjCkpAA5uy7aDz9oQnWx7WTvKk-kLWemkqF9PsQ@mail.gmail.com>
Date: Tue, 19 May 2026 12:11:15 +0900
Message-ID: <xmqqo6ic8564.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Torek <chris.torek@gmail.com> writes:

> Call it an "implementation note" (or, if you like, a "practical
> consideration"?).
> Something along these lines might work...
>
>   Implementation Note
>
>   The --word-diff option currently operates by taking the same
>   line by line diff that you get without the option, then massaging
>   the result into a word-by-word difference. This may cause an
>   unnecessarily-larger diff than you would see with a more-clever
>   implementation. If and when Git acquires a more-clever
>   implementation, the output may change. Note that this is
>   similar to the --diff-algorithm option, which may change the
>   output.
>
>   Regardless of which algorithm is used, _any_ diff simply shows
>   _a_ way to achieve some particular change. It's impossible for
>   any algorithm to tell whether someone deleted two lines and
>   then put one back exactly as it appeared earlier, saving the
>   resulting text, vs deleting a single line, for instance. Only a
>   keystroke-by-keystroke logger would be able to tell what the
>   human operator actually typed into some editor. Git does
>   not have that information, and having it is not desired.
>
> Chris

I understand your frustration in the second paragraph ;-) but let's
not go there.  The first paragraph is excellent.  It gives readers a
clear enough explanation to understand what is happening and stop
complaining where there is nothing to complain about (which is
already hinted by the "Note that" at the end).

