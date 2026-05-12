Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB5383304
	for <git@vger.kernel.org>; Tue, 12 May 2026 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558472; cv=none; b=jGLgSktnvKIrbt0dFdiFRQ7uCuKJoWdSsRE0U/fgk3IFUq3jI9gAEy4U4+DMzsarX5IhlzsFfF8XzmsyAWCA2Xg1GcMFujf7iEHfWQqnMw9MCb6k71jyZA9P980slSXbbzdRT23zlbAT3phnX+3eQE4ZRHksVQjl2dgN74pzAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558472; c=relaxed/simple;
	bh=I+2Ll2rmAhc7w0ACKReJ8kFhxHBR+WmCiK65PmXbxo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLwoVRroet/hm3yEr2geYWpvdp114gBFgu9XurGR5zkLVgyHhaA1N3ZthjGQ7vcTaLOha0BV67Bhr76LqRoYXZt7sYrR9bYgqz8LLY4tU8Onnq0GPmAbPJWNRfdStGjweORq9eYwOb8MdCLiyHwHW6icjPRI4b+u7CacRXHh2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S6qxHgtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDh/yLsd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6qxHgtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDh/yLsd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9359F7A0139;
	Tue, 12 May 2026 00:01:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 00:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778558470; x=1778644870; bh=4LWbzaoo9e
	Y3dbR9qvRzYI7U0J75nwplTkVrDuAjGpc=; b=S6qxHgtWzVFtYaXRrr/XX/BfRw
	et16DDDoVbfguvoCgI32tOebr280iLKvZRTFCERoTdmsho/AQE4p8LcHhNLSugXq
	K/17vy6KLwPNz1EpQps/1uRvei4swDKrt0nct2V/xmQonb71LavmYoXrDV0ssqut
	kT/Z6GLUXfio/acyIvgiWDTrAF8A0GPEfjSEMMbxlebywwvwWvxUy8ks1dlvxcEG
	MszCIN+RZ6tqpmxWnt9QZdXTeeNpH/QOiGc9+xltOHk0dl7vsRWDDQlUT5/Kws50
	tp8zpYdkKJJ1OschuqtTsiPwSzTdDBh4kcb/ZDKrzRImMxf2uF5x/1ErypaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778558470; x=1778644870; bh=4LWbzaoo9eY3dbR9qvRzYI7U0J75nwplTkV
	rDuAjGpc=; b=LDh/yLsdDAHtn3Cl1o2mfiyOF+PYq2y3ygwE6bzUsFUiay4FPGI
	MmoFnL9gkJc7EIPmQR3M+NGqTuQMEXUuuol53xtbJW6JIf11vQivbNZgi+vzeM/W
	Up/X+VcRGlxt+coy6+dLG8usVxvCF8VsFooMi/yUsIeQQ+R+41dts5vH4jbMRfXz
	Z2M1eH5iTDvxa/jxVRh+k77vH+8nlm/SkWynyMm94rvM8pxfNwsCuL6b12kgkAHr
	U7j7x+cQAXeu/HRKCcAoNZQJ5xW2VMvNa9lIkYTlF8xPZ8agggS/0YqSdlYa3fdH
	OyekOCDqw+W40fx/8UFO54fa361rS3znlTA==
X-ME-Sender: <xms:BqYCapdf70c8P69gsvAhrPvkrhX7mCCLSyKGDgC996NFMUcfmJJpNw>
    <xme:BqYCauMdMCXqp7dKOsVUzZA5zeXmXGZS5L5zLXnNar3jwVbRxOb7CAF_4Wt_4GyEj
    Y33oYD8Q_DmjOHyEnPVXweVZC2uSC8YBHoZh7jsud3_6C8OUStp0Q>
X-ME-Received: <xmr:BqYCani5hOVEAvFTybfHL3EhBNZ_9kFEcNGEbBjk02rxAuuoqC_6ALSUvQdDLYUfzkwvaxV61N1bX85YC0A9agUqhhIJGl4ABQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveellefhgfdugfetgfeuteegvdffvefgveetgfetheegkefhfeeuveeigffh
    geeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehmmhhonh
    htrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:BqYCah3W5NuzXWrEvz-xPHtxCex6M_4QJmWefNlBIRYdlc6Kvz9yyQ>
    <xmx:BqYCahhuym4IQl7oU7m33W6dOewBNwtmpXmxZSXDgR8iCzfiJ1zC-g>
    <xmx:BqYCahe-0Ke-qwguBaTlmFfzSDPy10muS2guoeXOm4cwm5TcYKDeww>
    <xmx:BqYCakmtyLUE2QDkzqPWEZMnQIQlqI2C-hbdc7YtP4WAlTyrTxCjfQ>
    <xmx:BqYCarBlSftakd0jCmGhMBVCMQfyuOpvpJFcNMAS-bpxYU6L28ZLnrr4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 00:01:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, "Michael Montalbo via GitGitGadget"
 <gitgitgadget@gmail.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 0/3] line-log: integrate -L with the standard log output
 pipeline
In-Reply-To: <pull.2094.git.1777349126.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Tue, 28 Apr 2026 04:05:23
	+0000")
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 13:01:08 +0900
Message-ID: <xmqqfr3xp98b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since its introduction, git log -L has short-circuited from
> log_tree_commit() into its own output function, bypassing log_tree_diff()
> and log_tree_diff_flush(). This skips no_free save/restore,
> always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
> --find-object) and --diff-filter cannot suppress commits whose pairs are all
> filtered out, because show_log() runs before diffcore_std().
>
> This series restructures the flow so that -L goes through the same
> log_tree_diff() -> log_tree_diff_flush() path as normal single-parent and
> merge diffs, then uses that to enable several non-patch diff formats.

This unfortunately saw no reviews and

  https://lore.kernel.org/git/pull.2094.git.1777349126.gitgitgadget@gmail.com/

does not show the previous rouns so I am assuming nobody is
interested in the topic?  

Or are people more busily writing their own patches than reviewing
others' patches?  Unfortunately that is not sustainable.




> Patch 1: revision: move -L setup before output_format-to-diff derivation
>
> Preparatory reorder in setup_revisions(). The -L block sets a default
> DIFF_FORMAT_PATCH when no format is requested; move it before the derivation
> of revs->diff from output_format so the default is visible to that check. No
> behavior change on its own.
>
> Patch 2: line-log: integrate -L output with the standard log-tree pipeline
>
> Rename line_log_print() to line_log_queue_pairs(), stripping it down to only
> queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
> diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
> suppression, and aligns the commit/diff separator with the rest of log
> output. Also rejects --full-diff, which is meaningless when filepairs are
> pre-computed.
>
> Patch 3: line-log: allow non-patch diff formats with -L
>
> Expand the allowlist to accept --raw, --name-only, --name-status, and
> --summary. These only read filepair metadata already set by the line-log
> machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
> remain blocked because they call compute_diffstat() on full blob content and
> would show whole-file statistics rather than range-scoped ones.
>
> Michael Montalbo (3):
>   revision: move -L setup before output_format-to-diff derivation
>   line-log: integrate -L output with the standard log-tree pipeline
>   line-log: allow non-patch diff formats with -L
>
>  Documentation/line-range-options.adoc         | 10 +-
>  line-log.c                                    | 30 ++----
>  line-log.h                                    |  2 +-
>  log-tree.c                                    |  9 +-
>  revision.c                                    | 25 +++--
>  t/t4211-line-log.sh                           | 99 ++++++++++++++++---
>  t/t4211/sha1/expect.parallel-change-f-to-main |  1 -
>  .../sha256/expect.parallel-change-f-to-main   |  1 -
>  8 files changed, 120 insertions(+), 57 deletions(-)
>
>
> base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2Fmmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmontalbo/mm/line-log-use-log-tree-diff-flush-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2094
