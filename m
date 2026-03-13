Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140A381AF
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385660; cv=none; b=DIKOV/LjACngAxvNnxV/Ju6c6DqgMFSrVz16rduEtdtILB/vccTTqqn8l7wu8pVQtrM94Bb0Y/UD8FHMnHydVWAgGiOUSbFF9Ve6CLYo4AhJxFQH9BSL8ecLBhYnLh/77egWr+W4ggSwIS4j52w11hpYlJzk4Q17ULINp4OsJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385660; c=relaxed/simple;
	bh=q4AWLFndzrY4KHaOTFL23Vne6PD6IQBjTBDhmwSMhrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPmljquKLMEcekqEY6WTPj6NtlXO3g10NGqs1OPos0282HQrG4pNQGY0DT/SzTY1kWV5hJ1cf7hcQfQ6zxmPuBKEq4bUBAzVB1GK37WIPDaTIX6DPuHOB07TjTSt6KAGoW3xrJfxPtlzr3Jn5B4J62/OI+0nAnBdJmkofcrJNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BZ0HnSmn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YuDVa27z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BZ0HnSmn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YuDVa27z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CE321D0011C;
	Fri, 13 Mar 2026 03:07:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 03:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773385658; x=1773472058; bh=rkGT/3jtWw
	25LwyqxXSnwLhfUiAEujQDsCZ9erWa0JA=; b=BZ0HnSmneDO96whQnicrBn8M6L
	f6EhN3Tn8lPH7y59LNrTs/lqDb1Kuq8joOR/s/4UMwBAgv3PjgfK6f/CW32zGgbj
	Ix8LzPxyIl8LqpzgvBJQ5nm0oUNLTHX77npAJdlciWSArUXek8NNshftV1qQfe6B
	w0VfGfv4yeWNOUHmvAYKzSX6JAfd5hioJkuJ8wn3fWkaw9kTSeEsIJ/Znyj3b4s6
	TRlnltMIOH9fR4sIuo1TcSiwhTSyzQ2DqG9I1ZYJv8SSu0DyP3Gp5VlpnN8TbQnr
	l1CTj41rBKfpJ2yW6Vo1EMrjE5a+rEJ8YamhgbL+UEo4Gwxqr8GZuUqwbzcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773385658; x=1773472058; bh=rkGT/3jtWw25LwyqxXSnwLhfUiAEujQDsCZ
	9erWa0JA=; b=YuDVa27zJASLxPoBdLFSUJdisbiWI6TSTELrw/eItHhVF/Wi9jE
	lK6V7TkC/nuU680upeRn49f5ZR+N5rqaRQZ0sp6Q2sDsbKipdllBxvSfnrAX5T8e
	ROWSHGsNwI+i3Pqq516YM1qthkGm3Xo15RDDprTAilcxcCHvnV36nYeF7NBwGPlH
	TtGENNoNjjQkS42Si0CwF5kwp7HOaO5ox+rcVtCXbS87JjFgFcOqvXO50Mxcy6/E
	D6scleIn7VlzdqAM7pdrNYBTlHtQEer71r7xIoike1mJOT7NgCuT7bPtEnST9zi1
	HCGUXvweJVSuiiH/0bskPJWUofXoPdf4Vog==
X-ME-Sender: <xms:urezacX-8aEOWWYbaiT52Mtg1RpUhZYkfRxGzhwUjP9qyVVxXw7bFw>
    <xme:urezaXdety0zuDfoaeExfAF8Oy7QFwxki3wxmKAQOwQDZ2RQaBXE7XDjVGR7goYa4
    LD8WnciXNS6tVp-pY9T14C8hF8Rql5FghKAJFkSwirvtvq-uDpeng>
X-ME-Received: <xmr:urezaYu1uCAK51nUkMvo9VNeonlCpN7Z5Rap9PtLdDG3XChRfeJgGojPB_VuZBQVyFUq3QkUXzAHrHJHxuQ7Y8tA1DzYTj92eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephi
    gthhhinhdrghhithesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:urezaW9YhU1VaPEeNPJGcFXS0aBDsl-Guqmev5XSjAThjzsD8FD-IQ>
    <xmx:urezaT0epMyTPGXMsa7HdY3KaD_BxULXgroyEdo1tDrw8u24haCppg>
    <xmx:urezabAHRF8DGrVUWMPNRalriCh7Ezfy62K_h_or-Z8fkiW70FKkmA>
    <xmx:urezafetWLtBnhu_7NHbKREAPBnf-xwQ5Pbi6IC8WzPdX_ynUm-xOg>
    <xmx:urezaWP7zQdcYG-Sjl56ZdvfZ5zPyG4Wc7ABDzBkpB6xFa4z_yFraXhp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 03:07:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Yee
 Cheng Chin <ychin.git@gmail.com>
Subject: Re: [PATCH v2] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <pull.2120.v2.git.git.1772463265865.gitgitgadget@gmail.com> (Yee
	Cheng Chin via GitGitGadget's message of "Mon, 02 Mar 2026 14:54:25
	+0000")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
	<pull.2120.v2.git.git.1772463265865.gitgitgadget@gmail.com>
Date: Fri, 13 Mar 2026 00:07:36 -0700
Message-ID: <xmqqikb08ax3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yee Cheng Chin <ychin.git@gmail.com>
>
> After a diff algorithm has been run, the compaction phase
> (xdl_change_compact()) shifts and merges change groups to produce a
> cleaner output. However, this shifting could create a new matched group
> where both sides now have matching lines. This results in a
> wrong-looking diff output which contains redundant lines that are the
> same on both files.
>
> Fix this by detecting this situation, and re-diff the texts on each side
> to find similar lines, using the fall-back Myer's diff. Only do this for
> histogram diff as it's the only algorithm where this is relevant. Below
> contains an example, and more details.
> ...
> This issue is rare in a normal repository. Below is a table of
> repositories (`git log --no-merges -p --histogram -1000`), showing how
> many times a re-diff was done and how many times it resulted in finding
> matching lines (therefore addressing this issue) with the fix. In
> general it is fewer than 1% of diff's that exhibit this offending
> behavior:
>
> | Repo (1k commits)  | Re-diff | Found matching lines |
> |--------------------|---------|----------------------|
> | llvm-project       |  45     | 11                   |
> | vim                | 110     |  9                   |
> | git                |  18     |  2                   |
> | WebKit             | 168     |  1                   |
> | ripgrep            |  22     |  1                   |
> | cpython            |  32     |  0                   |
> | vscode             |  13     |  0                   |
>
> Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
> ---

Thanks for the updated patch, and sorry for nobody responding to the
patch for over a week.

The detailed explanation of the issue and the inclusion of the
repository analysis results are very helpful; they clearly show that
while this is a rare edge case, it significantly improves the
quality of histogram diffs when it does occur.

 - The removal of go_orig is correct since g and go are kept in sync 
   throughout the slide loops.

 - Clearing the algorithm mask while preserving other flags ensures that 
   user-provided options like --ignore-all-space are correctly applied 
   during the re-diff.

 - While ignore_regex and anchors are not passed to the sub-diff, they 
   aren't currently available to xdl_change_compact anyway. Given that 
   compaction happens before regex filtering in the main pipeline, this
   is OK, I guess.

Let me mark the topic for 'next'.

