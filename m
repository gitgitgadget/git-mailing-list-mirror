Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64216FBF
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670451; cv=none; b=UMvJfjzswYLI2g3RW8yFLox7A83POIFOQUCEgB0BvNKYtRL6+epggcb1WdpZJj48C4b3wGmRrW7MHqp9HsnpCC2LsxQYOUAa8ogZTRdyRN1Sdk7zrlAInvV6JQ2xb5/aIsUVIuF20UJH51j6Q6nq2h5xgZcbnjwS8IhuXSFrJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670451; c=relaxed/simple;
	bh=2OZ+jx4Ph1ZEMpFTOdrDUYNA9TF2GdZ2RsnHDBBCAK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9EkehYYA+Q2OiHcmebq54ZNUAAD0f7OTLPa358OEceXCrlo34/3PeH9SwBZ9sIQZS06Ftd3urNaf6Kjj9hd8/qPzEF3ZovSC6+L/DRkRlxLf3m0WPZ9VOQfqIq+8wcZ52IkQdGipkzwfgwOhqkjlWCbPHiDKif318L+DjgTYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oj3LzozC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bfj567xk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oj3LzozC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bfj567xk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D919413800DE;
	Wed, 11 Jun 2025 15:34:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Jun 2025 15:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749670447;
	 x=1749756847; bh=nSIKt4JzTQH1FJ9Dm3g834K1rfLlXGgGTSsh34kM7Vs=; b=
	oj3LzozCoKyNz6jJnKZSn/yvKSov4h67l4P3dOAhbFtSXKaMeveIdFnA0v2mXAxy
	gYD6jPqLAhBDT/saGSKmtWtgL+KdzAMp2wD/xt455h9/P220w2wnWgQEWXItSEop
	IJJENXOcI8E7kSIHA7n6KzYwNdDvJc96GUMBNwbA6gpUPEIrH8UZAwMj6iaXL8Im
	aF1DVLJmMWJrk6apdJkvpLbfjYsEJo2YEDG39FXIR6eyQOjIz9WDS6bRmE4eYuE4
	bXskVYIIQitAkSid716bDH+2QrJE21UYa/Y7V9xVTZB+lqMw5vOljJcVGf4DLiFq
	c3dX8k1LTOVdr07kntUN9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749670447; x=
	1749756847; bh=nSIKt4JzTQH1FJ9Dm3g834K1rfLlXGgGTSsh34kM7Vs=; b=B
	fj567xk2wFahLl+kpkT25eptjjjBvStm1HvAJFso3CsoBKmmWbsHVUxk0ugCbPXT
	CEHlr6o9WZrKxhQ1aR5c8o/D2nt97+vaBNGrA8I3RQoRzbqNCU5MWFoj7+0opdoL
	UTt/ubA7RAIIu1ZJItb8kCdBDxAiStrqHp13K7ZI/hZeo9LOsgmaloAfpST8mEOg
	ZqpZ8fmagObRdIMmOa1EjYnfQBf+21kDLHGptBPohEVpGzwFVpl8Qhv0EClNC8pN
	PZXeYpB1r/jg/IMF4/njNW9QzAmx1nWfkH4IHDYIJyoLjzbod4oxQD5Vykww3lK3
	jBANLpvv6kUpjDNYusWnA==
X-ME-Sender: <xms:L9pJaEfzM1pWVoJx0qMvROS1Qby2Hz4W6Jre_tox2KIvxSLA1ckixQ>
    <xme:L9pJaGN7GjR3pVJ1D5b_DHjW5XD8dywNoV35susyL-nizd6pJk2Rik6fBwvgxj6TL
    ZUWd1SeWhDT_uD8RA>
X-ME-Received: <xmr:L9pJaFjTxYrschXVMShR4i8gJz9_ozhCgYIS_nVTrMKL2XuQu7nVXkjXCwCV4ZVYC3MOb8VvKAKaUJypnPE4rbn4XRhRqXa-2lhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:L9pJaJ94Hzzmp8XJbJf6-xE70bfzjARVnvl9-G80h9i9y4UURVBsgA>
    <xmx:L9pJaAv6nDBpNUXlrveHY6OLrIXeIxeUvDh-HpydqSTO8jk5Mjjzbw>
    <xmx:L9pJaAH1hkimof3CEgQZsdXXL79zfZqt0SF_uw5QmfMnTTIwUEZ7hA>
    <xmx:L9pJaPPIHk8c2niqYURmnyNdo64JDFUIOqvTTW1CS4soeGhl7rA0WA>
    <xmx:L9pJaH9BkcJQWBymqEtd6BQISwkP7ANQB5hP3YqkkrQr7WKVRORC62J1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 15:34:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] RelNotes/2.50.0: fix typos & other improvements
In-Reply-To: <d809e4bfdad2bedff66acaad81b3ea2290ae20ac.1749663244.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 11 Jun 2025
	19:35:24 +0200")
References: <d809e4bfdad2bedff66acaad81b3ea2290ae20ac.1749663244.git.code@khaugsbakk.name>
Date: Wed, 11 Jun 2025 12:34:05 -0700
Message-ID: <xmqq34c6hy36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> • Replace with phrases that are more standard (“all-or-nothing”
>   instead of “-none”)
> • Add coordinating words that make it less likely for you to trip
>   over the sentence (“*that* "gc" can do”)
> • Use “SMTP” instead of both SMTP and smtp
> • Don’t mention `git fsck --reference` since the previous release
>   was not affected by this minor bug.  Also say “errored out” since
>   the git-refs(1) bug was there in v2.48.0 as well
> • Use the more widespread “linked” instead of “secondary worktree”
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/RelNotes/2.50.0.adoc | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Thanks.

>
> diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/2.50.0.adoc
> index 99acf814875..2a1463644b4 100644
> --- a/Documentation/RelNotes/2.50.0.adoc
> +++ b/Documentation/RelNotes/2.50.0.adoc
> @@ -36,7 +36,7 @@ UI, Workflows & Features
>   * Auth-related (and unrelated) error handling in send-email has been
>     made more robust.
>  
> - * Updating multiple references have only been possible in all-or-none
> + * Updating multiple references have only been possible in an all-or-nothing
>     fashion with transactions, but it can be more efficient to batch
>     multiple updates even when some of them are allowed to fail in a
>     best-effort manner.  A new "best effort batches of updates" mode
> @@ -53,7 +53,7 @@ UI, Workflows & Features
>  
>   * The build procedure installs bash (but not zsh) completion script.
>  
> - * send-email has been updated to work better with Outlook's smtp server.
> + * send-email has been updated to work better with Outlook's SMTP server.
>  
>   * "git diff --minimal" used to give non-minimal output when its
>     optimization kicked in, which has been disabled.
> @@ -62,7 +62,7 @@ UI, Workflows & Features
>     delta chains from forming in a corner case even when there is no
>     such cycle.
>  
> - * Make repository clean-up tasks "gc" can do available to "git
> + * Make repository clean-up tasks that "gc" can do available to "git
>     maintenance" front-end.
>  
>   * Bundle-URI feature did not use refs recorded in the bundle other
> @@ -188,7 +188,7 @@ Performance, Internal Implementation, Development Support etc.
>     been dropped.
>  
>   * The code path to access the "packed-refs" file while "fsck" is
> -   taught to mmap the file, instead of reading the whole file in the
> +   taught to mmap the file, instead of reading the whole file into
>     memory.
>  
>   * Assorted fixes for issues found with CodeQL.
> @@ -391,14 +391,13 @@ Fixes since v2.49
>     reverse failed to give the mode bits of the path "removed" by the
>     patch to the file it creates, which has been corrected.
>  
> - * "git verify-refs" (and hence "git fsck --reference") started
> -   erroring out in a repository in which secondary worktrees were
> -   prepared with Git 2.43 or lower.
> + * "git verify-refs" errored out in a repository in which
> +   linked worktrees were prepared with Git 2.43 or lower.
>     (merge d5b3c38b8a sj/ref-contents-check-fix later to maint).
>  
> - * Update total_ram() functrion on BSD variants.
> + * Update total_ram() function on BSD variants.
>  
> - * Update online_cpus() functrion on BSD variants.
> + * Update online_cpus() function on BSD variants.
>  
>   * Other code cleanup, docfix, build fix, etc.
>     (merge 227c4f33a0 ja/doc-block-delimiter-markup-fix later to maint).
>
> base-commit: 4c0e625c091d4c648cec7319bafaed3cc81658e5
