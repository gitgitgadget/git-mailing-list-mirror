Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5527718
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493486; cv=none; b=r3OO82zYQ82hYQNwBtMEpEIvEy6eDURTNq2T7soYGPe2dfCxHrIRWeSTEZwq+2mgf1JCFLP3zPe8T6YY5IBMBPcUf/RxU+N9pTxiIw77fiMA9iDG5bSNNMlP+9n++/+kVawFOc4GENvUBC0btcF6CiJY5JQpg+n5MhVXIO37VwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493486; c=relaxed/simple;
	bh=n0ZKhwECHq/D69TjTt1FNPESC0Rlsk33+m00EycRlc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiHWR9LD47CadtSDUeBjX8TGCJngnASMZyslo5jmxDUlFLnoBchUy7OrQyTuFoN+dcCcuUZUwNjMbFY+EZbSbUpF4CHrnpmwNG4XTOe+zMNUOz9sjZuiI7qgKCayAF6BaV85/1TxGsDLk5n1Z5BH99t4XtMB8FgFpznpN0Nv8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=arPaAHXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjUYi+JX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="arPaAHXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjUYi+JX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A2A34114037A;
	Mon,  9 Jun 2025 14:24:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 09 Jun 2025 14:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749493482; x=1749579882; bh=4i4czgztKL
	6ya8RLOSKvhKRPv5MruROH+yBBchLkceo=; b=arPaAHXXB1x176YWbkAKjgdZuY
	ddpWkQ5dXvqRzqHUKDfTAMQoiVNg+wj6ZFAxW2oRBbX17mSfpok0kJygUPBBNBAR
	FRURcJ4ss9ZjNxgIcuXGZRpJRfTptqdnk14oyXATsP4VeKy+iYQyxp5hsyEfkSXW
	wXsFhxcFErMZ0mWnEdhA3+cn81kNhbaFQWrcmFrg1D7XkJYo4hGhgNllCu6XIYp7
	AuMIN8poIwgo5Utl0Mxv5jtEn5y9bTuJ3r/bcuwQU8Q+TPTGF4S1YjH5zvodTGI8
	4r91L9CchEtEMdeKOVNH5CEH/M6FwKNnisV4lKMVNIyDYgusTH5OQZQXzyqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749493482; x=1749579882; bh=4i4czgztKL6ya8RLOSKvhKRPv5MruROH+yB
	BchLkceo=; b=XjUYi+JX1mSO1SOulgqn0dOF5UzBXss8lU4PpceL+FQd51XVMiB
	/8rJRRqwc3jEbscZY/9W3A4piEn0jhsLEp8BZOF4Zr3kj98Cwj5Z9ZJmza1kV0cG
	BYuZAowXsR/wEHX5RN8NxANsSfRZqP8uH7pLI/y4nUu66+JD72FjR3zjFGI/063s
	qgjSEV3Up2B+tPhRrdYxy4K79FgzLbkFHBMi2rwqu4a2Im0dNIXd59JB9F2fVngf
	947NgMAjr7O/xwQYIChosPF6UAzuBPNTnQpPlFimG6ywsaEBVpULqNaQHB3R6FRS
	MGCZJgs0kwnZoT9x5bvWk+MkUVOzbxPcSzw==
X-ME-Sender: <xms:6SZHaFdcyxD2zeqI2Za2-O22Rmh88C0LqHE6dzgQQXs50QtbnJQ6ow>
    <xme:6SZHaDOXtrUV6yqCgnmi7DvROc2Rw1RYcjnqJE7AI9uopP6K8NMEHC4ZbG87JI4H9
    bOqm5CF9354rDKAbg>
X-ME-Received: <xmr:6SZHaOiK-v6kB_-PixMCw2JVYfNJJunmg0a4DO--__ffAUPg6CBb3yr-g50cfGKZIPEF7EOtMl7NVpo8qf8ceDxu7aHlI6m_n7PI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6iZHaO8APSz7-j6qdV0M65EGlRLsTDA1CW3AFM24mEmVFRYg_VTZFw>
    <xmx:6iZHaBvkZ_9jX50_uFyn0lcuakHxxipqy_9eO3fteBrk5CNPwTDc1A>
    <xmx:6iZHaNH99kl5R9Z2fxINWX_afIsta2mXunA6goXraDYJwjc5F14cag>
    <xmx:6iZHaINpfRPGinm-3yyJsqmdLkfAn4sIcaXtTyFfn9ivzhhIgsFDvQ>
    <xmx:6iZHaElFsGkVngEBES9GluquvXNCKmo6EiLsNtESJX7c3_ObIhMGYuwp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:24:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH] test-lib: add missing prerequisites for Darwin
In-Reply-To: <33de9e5d-24c8-47cf-b858-6d55d26803b0@ramsayjones.plus.com>
	(Ramsay Jones's message of "Mon, 9 Jun 2025 18:13:38 +0100")
References: <33de9e5d-24c8-47cf-b858-6d55d26803b0@ramsayjones.plus.com>
Date: Mon, 09 Jun 2025 11:24:40 -0700
Message-ID: <xmqq8qm0srh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> commit d3d8c601fd ("t7815: fix unexpectedly passing test on macOS",
> 2025-06-02) added a MACOS prerequisite by adding a 'Darwin' case
> label to the 'OS-specific' case statement. However, this commit
> forgot to set several prerequisites which appear in the 'default'
> case label, in addition to the new MACOS prerequisite. This causes
> several tests, which macOS should pass, being skipped.
>
> In order to run all applicable tests on macOS, add the missing
> prerequisites to the 'Darwin' case.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio, Patrick,
>
> I was looking at something else when I noticed this ... but I can't test
> this, since I don't have access to a macOS system (indeed I can't confirm
> that is actually a problem, but lots of tests should be being skipped! ;) ).
>
> I initially deleted the 'Darwin' case and set the MACOS prerequisite after
> the case statement - which may be a better solution. dunno.
>
> I marked this RFC because I can't test this. Hint, Hint ...
>
> Note, commit d3d8c601fd is only in next. If this is not going to be
> part of the release, then this (or something similar) could be squashed
> into it when the next branch is re-wound.
>
> Thanks.

I do not have access to a macOS system either, but the change in
this patch seems like a very safe and sane thing to do; it will
bring us back to the state before that problematic commit with
respect to these three prerequisites.

Let me queue it on top of ps/meson-tap-parse topic.

Thanks.

>  t/test-lib.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9ffcae0472..51370a201c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1647,6 +1647,9 @@ uname_s=$(uname -s)
>  case $uname_s in
>  Darwin)
>  	test_set_prereq MACOS
> +	test_set_prereq POSIXPERM
> +	test_set_prereq BSLASHPSPEC
> +	test_set_prereq EXECKEEPSPID
>  	;;
>  *MINGW*)
>  	# Windows has its own (incompatible) sort and find
