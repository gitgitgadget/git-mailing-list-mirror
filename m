Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21428EC
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 00:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731285439; cv=none; b=c5hsU7rMBayluv3nwSW1Plg6ZNW1B2nqwfcYb0GqzxBNuxjbhJkV9Bzx7I4e0PWcIr9F5DJI35fXwkndlPYFPQstyXGCIhVW3oc7BfD7pAuT7/si7I5f8W3tvdr1D0ekGijstCqnCnbNdz0yWjgyr3E991orFbudwi+pZyj2vZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731285439; c=relaxed/simple;
	bh=d7K+CFpJpQ0lYttbmcpCRJ/cr3Wg2I5gUpgkmuC4ipw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L2Vo7IOzB7pXJXWnxBS6yGMniqGJoIBEujqhqTTP9VvGrOghWG5MPWO/yppE3riITg9S4Qcbbu+2Van4l7lPAHk5XRxGNijhwDQWOIHf+DjJbDzG7Udg9VDLp/1zrQQnj/d8V24Ja3DsKQIqwcfoiRuWO57SHbODnM10adeCTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ED9SIZGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIEmFiSR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ED9SIZGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIEmFiSR"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 589CA11400A1;
	Sun, 10 Nov 2024 19:37:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 10 Nov 2024 19:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731285436; x=1731371836; bh=eFZRQa8DoA
	G/W+jZnohuKFbIlYyfOTiyRNCJiDUxj08=; b=ED9SIZGK7vPvePAnCUYiF9n4O0
	4q5PzylYnrl9UwbJtHBkNrpGHGKCIH5VWFze6u8dWN3hkycWGMS94xiv9qIH0JnS
	MVZpn5MHE8o4O+IstPtNQ27RHt5JGCY+UWDoHENSRpoaaWLGiva/KiAkOfYyR+NW
	WFPRnZ8Uqe2lm0BkZJ7HAijW2Yfv5InY6b++5zF/pHpEbAvWOn706Wz3i3IeDhvx
	DaY0RQoE4+jzyUrR3W88w6+5jo+t0Skw3cObkDCiW/BCAxgAn+yO0nMafq0dmRVv
	4Ry5koKqNxZm5VtkkbZl3V4NT7CC1WQOYa/U50jsrQvXutkUMiTjigRw7W+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731285436; x=1731371836; bh=eFZRQa8DoAG/W+jZnohuKFbIlYyfOTiyRNC
	JiDUxj08=; b=fIEmFiSRCA1zJg+lZaeTzJcbP44tVENZvQ4tWfcgwxhYUj05qb7
	O/HRrq1xJ4aRhQBmsP3ytAVJRv5dqftgOsBBP4RvkHNJmBIMGvwXNpX6Wm/32D2/
	9IY83DGGPKol7gCz/CMdxjRFu3YBku7yt/1B93DlBLJgwmZ3vCFiczoiyZXdOh0H
	uczZp65IWvq4hal0jJ/JQJhk69eZRM7IBe/5pQXE4Gp5vDpgqjAsO8SwHntRVb0y
	MRwq7XgBhCeHEQl8rzrIibmZtBn6TgNrPzYLMjGZ60a7zkdQVMjOpW2hwIVyywED
	z5KjhyAiYs6m49if7/iVbRS/jBCdQhA9xnw==
X-ME-Sender: <xms:vFExZ3jnHXgKDAm4GJjX43TIDgm7X-6b5-CHx_0wvKbrqY4OkJ7czg>
    <xme:vFExZ0B6R70-TT8TJ9trZaCPb8nMzxQqJ0VDLBbs0jSfgNAHNLcNnRDMuE4tKKRcT
    q_WP69TmAwoV63u_g>
X-ME-Received: <xmr:vFExZ3HlpPnVHxQM8Mf6eU-7MMxcSp8KBTm5sNrgujgnG2IiuaZO-CaiW_AFzVZli2I7Yxk0mwKmWjU0NkpWpsGOuUaUzlQJE2MJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vFExZ0SjaDidSbpYcfbdRLi3MWqlf-yGYJUE1fginnIZHdge8CQBsg>
    <xmx:vFExZ0xgML6e_knQEOCcZR9WUFaveUD0RaLCOTaDlG82vqu6eQeGkg>
    <xmx:vFExZ67kE6CI4wO52UROG3NO3OGWjkS-52BKhQxTYHgpMsSVdPytUA>
    <xmx:vFExZ5xD8i6SdhgV2GwAfxMtgEhd9Obd5pbp71STF7piP43Xdd6lgw>
    <xmx:vFExZ7kaNEk29Z6XkzvaLFe6P1fbW4iBI2lUu30aQQxpkQv3GdnpHB4n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 19:37:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs
 in the analysis
In-Reply-To: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 08 Nov 2024 13:43:03
	+0000")
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
	<pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 09:37:14 +0900
Message-ID: <xmqqv7wuk3lx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>      * Disallowed the no-arg --diff-merges option (because --diff-merges
>        requires an argument).

Yup, I was happy to see it in the range-diff output, because I was
wondering where the optarg came from in the initial submission.

> +--diff-merges=<format>::
> +	Instead of ignoring merge commits, generate diffs for them using the
> +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
> +	and include them in the comparison.
> ++
> +Note: In the common case, the `first-parent` mode will be the most natural one
> +to use, as it is consistent with the idea that a merge is kind of a "meta
> +patch", comprising all the merged commits' patches into a single one.

I'll let you and Elijah figure out the best phrasing around here,
including whether we recommend only first-parent or give other
options.

For me personally, I find that use of `first-parent` here is
consistent with the mindset of those users who prefer to read "git
log --first-parent -p", and to a smaller degree, those who use
squash merges.  To them, a merge is merely bringing in lots of
changes into the mainline as a single unit, and other than that
these lots of changes are broken out for finer grained inspection
if/when they wanted to, they prefer to treat the changes brought in
by merges just like a single-parent commit.  And from that point of
view, (1) reordering the changes inside the side branch is
immaterial for the purpose of talking about the result, the net
effect the merged topic makes to the mainline, and (2) dropping or
adding new changes to the side branch is treated just like a newer
iteration of a single parent commit having fewer or more changes.
So it is very natural that first-parent helps to make the world view
very simplistic, and more readable range-diff is all about how you
can present the two iterations in a simple and flattened form.

There _may_ need a tweak of the matching algorithm to allow the
"same" merge on both sides to match, even if they diverge a lot,
though.  A range-diff that pairs a merge in the previous iteration
with a single patch in the updated iteration may be hard to read.
