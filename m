Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD528B415
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717852; cv=none; b=LJs62Qx6fPk9mFQHTQ6CWz5PZHA//AzNiAQKBEt4qypsV+J8aFzT7WoIg/wEVK0E1FYFBe1tY5ocLLjVwqhU7j2sPa6CFzYwSNNXgOxBAz4k5+8IIBW1MzlxU23jA8sXDXWHZxaE1g6mtCitYtAiJFSvSQRGDw6c6fExoYxfevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717852; c=relaxed/simple;
	bh=6mEGyZDT3/fUh2CnztS55jVukHWprHOu8N5a/wmkBUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WswlihQbJNxOoj+KKC83niU2RZbUhnOgljTbVFqUWEXjcIJDZt58Y5Mx8zsWEJhyzFIe/ziaU95HwhBOKPD4PBrLMJMoXhHhJjAL3XbcxvuTcZF7i27DfnHGhJys5mVLtd4bYoD1eHK8gQ+EDBBWSakaxiFdZHhQr/tTB701Vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GCjcTKwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7nVf1WF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GCjcTKwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7nVf1WF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BB1D81D00153;
	Fri, 17 Oct 2025 12:17:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 12:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760717848; x=1760804248; bh=AilSraUJqr
	WdUbr3qIzyG42RaZ9QJtSR2l1YSIB5bjk=; b=GCjcTKwc/uaKfka9RsnXMLFab1
	vBLoSHzCJzCLu9gMcZeUInZIiKS2Y04ycsmUd6rrnAskQ/Srip3vCW3NCbEueqnQ
	rJVyvHYmoQbUBxehjXLXsBbLOPPvgSXHLrnf11JJOqd4wZFHk7HUDP5x5T9/bXPV
	3yUtiY3uJ9UtGZM8uEAfXd4kyq2CtkPMwr1AjBJ7b6dpByvjHp2cK21zRoYa+opU
	Il/igGDulro5gHnTpsporw+XXGesAw5dVUZqSx7KbHAwwNpH7+Xidf9Korke/FD0
	QE2lmXblwJF9InHKh6Ri4bLZffGlyc2WmuBZszOUVhSANQvNb6zupco4BoyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760717848; x=1760804248; bh=AilSraUJqrWdUbr3qIzyG42RaZ9QJtSR2l1
	YSIB5bjk=; b=J7nVf1WFl0JOtqPsbLeUUJY8sw8rSQUxpsQDe3SSRuYVT27oUDv
	DP9ORoJXmJJUs5blZNQHwZCW1oqbuawvQ75JSyOZ7lpI3TivzVmhnZgcOz99pIVH
	6y1uwBK0kEdaLmhtrE9gMCmua+X+7RLvjYgIqPfhkUrM85u0UXC+KBT3UfStcpOW
	v5s9VV15X2quMJJnGQaYJ/WvcQFiDmXl+G0w1sRwyUViErmY8jyCXS7qdCNGKxAQ
	8szK8YqnxDhXr2P2eb6gSz5k7WSRLOf27tbVCFC3KVYOiRUeU7iYEteq7OUJg0x6
	Bl8cNY27T8uMVuLRtspzpRruE1UoURNzJpw==
X-ME-Sender: <xms:F2zyaBIO5hZlJbg2xc6fZhA_si9lnDmunTaZp15SrxMJ752YtKKXOA>
    <xme:F2zyaGGDLAmGn7w7RjruoHIpg_7o4CUNluNzJYYyu7DkdLGKJnAq2SVzbcVqTa5Vf
    fmhFxpdt_xiElAffmld8AYSxByTmuFOSp53QpZXWDO8_vUMWjw3dg>
X-ME-Received: <xmr:F2zyaFReond2EhupvAXWX7JCO01cQp5Ul8uA74eHBGEIlCHvkps4EpaHbfDqdh-bYC1KQI6hjLBy7LikNUEPJ2ZgBzOr3lt1RRrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmh
    grihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F2zyaCfjwpV7_4c7y7sgeZPltZtSB30AssaagRnYGNmQPe3PDdei_Q>
    <xmx:F2zyaEocx16FV0Ucve5qzzXsqSBv5q8WStSIzhJbraCXAg3avq4p1w>
    <xmx:F2zyaD_3VmJJH6JNU0pgAb2XnTn07dzSGkCLArGJIcAZpm4iOe78hg>
    <xmx:F2zyaAevs_eG5vZ7g4InA_Ga0xT5osEiix2mky-oWCGxLCtzUS-zlA>
    <xmx:GGzyaN6ErDIgk86hMhRXCe7q3f0e6kDvwKOphJ4TGxNM-KVq0BOeVdNK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 12:17:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>,
  Lidong Yan <yldhome2d2@gmail.com>
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com> (Lidong
	Yan via GitGitGadget's message of "Fri, 17 Oct 2025 03:17:29 +0000")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 09:17:25 -0700
Message-ID: <xmqqh5vx1p0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <yldhome2d2@gmail.com>
>
> In dry run mode, diff_flush_patch() should not produce any output.
> However, in commit b55e6d36eb (diff: ensure consistent diff behavior
> with ignore options, 2025-08-08), only the output during the
> comparison of two file contents was suppressed. For file deletions
> or mode changes, diff_flush_patch() still produces output. In
> run_extern_diff(), set quiet to true if in dry run mode. In
> emit_diff_symbol_from_struct(), directly return if in dry run mode.

The above makes it sound as if the dry-run mode was an inherent part
of the diff machinery that existed even before b55e6d36 came, and
b55e6d36 somehow broke it.  But that is not what you are telling us,
I think.

You may know what the "dry-run" mode is, but others don't.  You
should tell the backstory a bit better to help them.  I am guessing
that this patch is to fix a breakage introduced when the dry-run
mode is added in b55e6d36 (diff: ensure consistent diff behavior
with ignore options, 2025-08-08)?   If so, I would expect an
explanation like ...

    Earlier, b55e6d36 (diff: ensure consistent diff behavior with
    ignore options, 2025-08-08) introduced "dry-run" mode to the
    diff machinery so that content based diff filtering (like
    ignoring space changes or those that match -I<regex>) can first
    try to produce a patch without emitting any output to see if
    under the given diff filtering condition we would get any output
    lines, and a new helper function diff_flush_patch_quietly() was
    introduced to use the mode to see an individual filepair needs
    to be shown.

    However, the solution was not complete.  IN SUCH AND SUCH CASES,
    THIS BAD THING HAPPENED BECAUSE WE OVERLOOKED THIS AND THAT
    CONDITION, AND AS A RESULT, DRY-RUN MODE WAS NOT QUIET.

    To fix this, DO THIS AND THAT.  THIS WOULD AFFECT ONLY SUCH AND
    SUCH CASES WITHOUT AFFECTING OTHER CODE PATHS LIKE DOING X AND Y.

... is given to help readers understand what we wanted to do in the
earlier commit, what we failed to do there and why, and what we can
do at this point to clean up the mess without making further
damange.

> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> ---
>     diff: stop output garbled message in dry run mode
>     
>     In dry run mode, diff_flush_patch() should not produce any output.
>     However, in commit b55e6d36eb (diff: ensure consistent diff behavior
>     with ignore options, 2025-08-08), only the output during the comparison
>     of two file contents was suppressed. For file deletions or mode changes,
>     diff_flush_patch() still produces output. In run_extern_diff(), set
>     quiet to true if in dry run mode. In emit_diff_symbol_from_struct(),
>     directly return if in dry run mode.

The "below three-dash" space is a place to explain what does not
have to be a part of the resulting commit but would help those who
are reading the mailing list and reviewing.  Repeating the same
thing as the proposed log message does not help readers.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 55a06eadb3..25fa452656 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -661,6 +661,27 @@ test_expect_success 'diff -I<regex>: ignore matching file' '
>  	test_grep ! "file1" actual
>  '
>  
> +test_expect_success 'diff -I<regex>: ignore all content changes' '
> +	test_when_finished "git rm -f file1 file2" &&
> +	: >file1 &&
> +	git add file1 &&
> +	: >file2 &&
> +	git add file2 &&
> +
> +	rm -f file1 file2 &&
> +	mkdir file2 &&
> +	test_diff_no_content_changes () {
> +		git diff $1 --ignore-blank-lines -I".*" >actual &&
> +		test_line_count = 2 actual &&
> +		test_grep "file1" actual &&
> +		test_grep "file2" actual &&
> +		test_grep ! "diff --git" actual
> +	} &&
> +	test_diff_no_content_changes "--raw" &&
> +	test_diff_no_content_changes "--name-only" &&
> +	test_diff_no_content_changes "--name-status"
> +'

Test that exercises "git diff -I<regex>" is in line with what the
original b55e6d36eb wanted to address, but given that we saw a
recent regression report like [*], I would have liked to see "git
diff --quiet" in the test as well.

Thanks.


[Reference]

 * https://lore.kernel.org/git/CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com/

