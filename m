Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E92F2903
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014135; cv=none; b=VznXEt7d9fGhwcw7FP15780piQYothmCyqGNx/0gI/gdbSq08XZSgk7y3iZJjKVPhLDPt7XyQUbwhi4dyIdbqlyf5oCjeVWSf8fvsrZoH3RPVwjwsIUfPm3srcHlxpepC0nchosNRE9IhdbYYharlf0v5yqgx6S9bpoUBO+YI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014135; c=relaxed/simple;
	bh=Ojap79N2sUVsRuPyjacPd44yEA2161r5kwWoyVOkhlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MN0rC1zFrWL/C/wq8B2gOBcRXhov90jN9+idKCi5uOG50tTB+YWWbPypNDNaX7UdLzyzPGZFfCBjRi96s8RvxtUZII2wttluYT3Ideh/0ACKbBaL9bvApAhC7Y4MGLaBAZmBhcwlM/H/DAZPBnL7jCW7NHUGxjhjzIWzwyBIqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xk8cqzwt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZaMbablE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xk8cqzwt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaMbablE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 53D9BEC00DB;
	Tue, 12 Aug 2025 11:55:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 12 Aug 2025 11:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755014132; x=1755100532; bh=RBsQrWkorX
	cgqv5p/qQln6W0oOKRMFFNLlzO47eIY4w=; b=Xk8cqzwtwDatmeZL3YTYlWeilJ
	hTbWKY06PQL3sonayzRuAsmNa2VedvSsvIkS+HIkkZL+dSxWM19bYWfUk/pLaS5R
	TH3ByhVV4Nyg7Ceu0qmbTQgo55T7fMZvR3Vu0oX39CvB+bmnltsxZrSYNSy/dLo1
	H+o5R6l0Lzw2YqkSgwTBXtIg+i/LEEFbpQNUk8N4926JE4fMO2+qiFpf1r8ACnmy
	CUSXwOpgGTJKMchTEF8Gd57in8M/q0jgMDC4XaRdhheQawzJWOa8CmbOvmXV4JP3
	cUlkIn327CSY/qGuGGUT787W+0NODpeFapFeo7U3P//6CUHVzQPvBFsNiK5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755014132; x=1755100532; bh=RBsQrWkorXcgqv5p/qQln6W0oOKRMFFNLlz
	O47eIY4w=; b=ZaMbablE+6sa0gUjZzN9CaFtA4ZnKNuKtxWuv9UrZOOuj/rpyNu
	i84bGIoiBx1ExlC8IwMNza57dLcRm4fS1Rn8TIYxTdDcZNeYKwomAUBCMyQ748Wm
	d7qRuCTs+QMCOT1JuH1zSAiZ1RteDL51zmft9a39ukdZJobeS/2S6s0RG2dtj7Mq
	tJyCOhzB+SJGz1pPhMJoEEVgsgCq72YhE0U8xyeuMKIn89U9t18c73Cg5CBb3N/4
	BvLaG3uURjc9hgkJzRhPchAmo3djKvuCMZsmKvkPfK5J8pbnaGi+pDQRNcMN4np6
	8UMXYzP9Hqko3lrxWnddLqneGmY/QecolbA==
X-ME-Sender: <xms:9GObaA-Z4a4Afln1-EwN8X3JLY8nFaOeDV2ueNcTpGPHdZUCImhErw>
    <xme:9GObaDSzT6_Du8Mn0X6APtfRpbqccR9UB7xUBRVv-310Mlwxr-hjYRB-HDcFQMMNu
    eRyDbUBnVDa7YKaRA>
X-ME-Received: <xmr:9GObaCkTAGXBb6CZuP6He5f0NOG7D_on86P4gr6MFOyz1RBCw4Ev2U1w8pCYFRe-3ZyQwlHsUyLMLja6z-xluoKB5WjX2rgtTJ-P4Wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvqdhkqdhnuhhtsehhohhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:9GObaDQ0TPeFrlW6EBn7xt96o3Ny5gaV729-tYyxfv2fjWlyQPBFzQ>
    <xmx:9GObaANA30ipom75fiQHCidbUWfWUIZELLykna5-4SMZZlBToRRkxg>
    <xmx:9GObaMUGQL9_1LT47IjvAXAaxrg9es0lRMvdcKCEf4_aGweL2mibRg>
    <xmx:9GObaHfGICMEYbYEPLcin2ZzLTXIC42bhFvhze6TfNmDgpjjn5N6Kw>
    <xmx:9GObaGEWZgGgHRKKIC-xS0k2pRu_EI-4l_-nlj2MzYp4Z41UHi1_A8bF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 11:55:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Knut Harald Ryager <e-k-nut@hotmail.com>
Subject: Re: [PATCH v3] docs: remove stray bracket from git-clone synopsis
In-Reply-To: <pull.2023.v3.git.git.1754949872593.gitgitgadget@gmail.com> (Knut
	Harald Ryager via GitGitGadget's message of "Mon, 11 Aug 2025 22:04:32
	+0000")
References: <pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
	<pull.2023.v3.git.git.1754949872593.gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 08:55:29 -0700
Message-ID: <xmqqms84v8jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Knut Harald Ryager <e-k-nut@hotmail.com>
>
> Remove the extra and incorrect closing bracket, so that the line reads:
>
>     [--filter=<filter> [--also-filter-submodules]]
>
> instead of
>
>     [--filter=<filter>] [--also-filter-submodules]]
>
> Note: Both filter options were grouped when --also-filter-submodules
> was added by commit f05da2b4. The extra bracket was added
> later by commit 76880f05.
>
> Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
> ---

Thanks.  Let me rewrite the proposed log message thusly:

--- >8 ---
Subject: docs: remove stray bracket from git-clone synopsis

The synopsis section has an extra closing bracket, like this:

    [--filter=<filter>] [--also-filter-submodules]]

The extra one is not the one at the end of this line; it is the one
after "...=<filter>".

The "--also-filter-submodules" option was added by f05da2b4 (clone,
submodule: pass partial clone filters to submodules, 2022-02-04).
Because it makes sense only when used with the "--filter=<filter>"
option, these two options are enclosed in a pair of brackets.  The
extra one was added by 76880f05 (doc: git-clone: apply new
documentation formatting guidelines, 2024-03-29) by mistake.

Remove the extra and incorrect closing bracket, so that the line
reads:

    [--filter=<filter> [--also-filter-submodules]]

Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
