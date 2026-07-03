Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAE2FE0F
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112227; cv=none; b=G9jKxuOzn0rei4wk1tTXYuY96wYS8MR/QHoa+rl/TVyiiySBCflsrbhGAbtQf1BG2HGi0SvvoljjeSFtjVTY7Z506hf4o3iETID90ACN3ULPsWKzuhhfT6wkYzZgyiEVTuq8Z9UxYLdCRzi95iXB59BTa6OlmLKc+5Qx5YxSHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112227; c=relaxed/simple;
	bh=TVHjHOQdfcPlem6yJavbSni/oYQTM8WFupaXpl9hi54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iKCPj13n+z+ylA6kl38Uq5WIKjDH9cMBP0QoiW/uxlpjJ0DVW+dzG6vrhmXmegpuI4v67bF9HYkg5yDtjS9WP2AX2F3/9y4rf1qAOd0jODn5iOHlcLNl4iOFoplhIKzyncbgBXcligKSrZUPKyloFeaFCg2hQsS0mdmagDNgHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UL0Bxona; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJr9w2V9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UL0Bxona";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJr9w2V9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C60167A00C3;
	Fri,  3 Jul 2026 16:57:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 16:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783112225;
	 x=1783198625; bh=vFGFV2RXdPQccg9f5FH8m1FUF6hCe6KMn1eYU9taBuk=; b=
	UL0BxonaO6zns20vVDLw5afxD77AsRB3r7vnfGd3zvcNRo3RfSlxh2Mi3lzbY86I
	JXTXJ7DFf0srlpWyusLutkiWgkgOTh0AvAF1q/E14S6TkBtWbZCTDrUjj/6mWClr
	uD8tWFbBu2nREkAm2GbkI1709twTX/B3D2IiONqz7iDnVIhPbIQiRvkHEclzlaNk
	6wB3rFE35zYsP8DjBRSzbPDUmTUDds6PThWcprbp8WITueo89RBWuAX7Qfw1wMjq
	piJy9B+5gbs7bMqsEjMEUiXCcyzhtoUI2oxRjQd7pJveFeXqfRckRjtCtPiN+Fhu
	J7o7qYXl5I5Umxw4kKud5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783112225; x=
	1783198625; bh=vFGFV2RXdPQccg9f5FH8m1FUF6hCe6KMn1eYU9taBuk=; b=V
	Jr9w2V9t7WiPqCbFis1TRQliOu1s9T3UJaZFfpWqgAx1pTSSnnYXAJj5pr0z5t9v
	Vl6KUsiVS/mkUkODafu7L+pOyr56r+CkF7dbkmWu/32iKLPbqcVTQnKe20nJNMaD
	tS+UluB8B9drmfRqRqrZYgD7gtkgE6/Nes/5iGNNG4RGIkaBxjlmgxX1k3xc/c4o
	ZlqHCHlkYnrlFBt3B6LAKh4gt+QEhKOqaxj7y6CtxgyRkpwGEGxiH3L4vIIM26jk
	VWvee2iCJLcc75oVnDTFMHaPmCJJzY4WoAKLRNT92VsGCg7FOMb4HFJjI+lO73aL
	9atzJfzTeXr0bUkh6eb3w==
X-ME-Sender: <xms:ISJIatijQx1VShhysJO4Y8wfLBzFbtW3BjBPb91lOl3Jrs1Xq0CrWw>
    <xme:ISJIao65TbHfDuUEm2-XZpTPETw1eE7MiyCJS4Hko6Bv495JxPMMhCcK422hBcmbq
    QzFdWPlPSYnftzo0dDILnQQROuc5zeUIHsKKdxY5reC-ndfyBEG>
X-ME-Received: <xmr:ISJIalYoyCi0FiGbxIEdenrFepyJAyybQrvWeYq6dtXpAQXq-cVCtuuClO8J5h77QyjXGsBzx-4z-_JkWdkyKgZGaKPjMzxZpy7OiwA>
X-ME-Proxy-Cause: dmFkZTEOCiEKxfVmHXPFfUijRsERiAGSbQeiBmbscp45HjTzY+/WWvVTP7KUBRs0rc2iwc
    IIWUP+yUKPqWOtLIDQMl/YmzFaVK0FEc4WLH/VLkjsgIsLYfnTfiHfqjYO4Qhq95GgGO8o
    0J8kqF1GTBLLjSPmpJZkKXrn6DFFuBfVJd/DRUtJECnlpAnSTkJFtfGQIo/BJFbABnbGJn
    Q0ylBKUBYT690mbhdOvbCG0v15xRTY9SznHJymHiSY5RKXrxr/NjlXsxu0J9OAjZf0Ffad
    RwNMCwbuVQ1zRgYM8S5ILmssq9/iiO+uks9+aTqZTnomHfl/HwcYmxpFY8G7Lv4AZT5tIa
    DxSJwC8aTmAoC1aZnGtj4t+1SN6pKRQQKElyb32g6oFU+amlhzn5X6ZPvx5CJASOyPFfv9
    5g4V7KWvuZF1Z5GhDlfcdRoBHY2/XBJup2TueoukImOmsDMCnFgQWoprPvlAo8NN/xIAN7
    KxevmPqhHvHgWpBUJdLfr2pbLnsvyWQJWOBv4vbodpm+brXaLlvEcXJDShERk9RXowqZ2F
    rF/HqYP7SQ8yWPQ25MNREr8Yp37MaxVmBvX1UIEOiHasGnfmI24XIXnUC4Zz88TMUI36a/
    TdbhYE1rTnf01V9+ii2Rc1fcJ+bfoBnCVR9+NKE6mwJAu+Sn4exBnpuepc5A
X-ME-Proxy: <xmx:ISJIat6aX3q9OV9suNRqrs7tkYbyr7d_YfEXXaobcO0u4LnJkpPuMQ>
    <xmx:ISJIaoAhln2DlfQL_N4hj_oY-qysgbtcp7kgaRizhv3IObcY-KU7ig>
    <xmx:ISJIajedAUFZ3FnS2FSaejtWOpZam_KTIC-5MyLMUjTVBWlShLhfmQ>
    <xmx:ISJIanKi3Bdc15z40wj0HJMQwXKqjRniKtC7G8HI9iasznLTgRbv8A>
    <xmx:ISJIashgcJZdWkpeAsJRdrIQdFU8pNOOTWWgehFO9xOYkaaXnxCid4l0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:57:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <20260702-toon-git-replay-drop-merges-v6-3-78a07cdd0382@iotcl.com>
	(Toon Claes's message of "Thu, 02 Jul 2026 19:58:45 +0200")
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
	<20260702-toon-git-replay-drop-merges-v6-3-78a07cdd0382@iotcl.com>
Date: Fri, 03 Jul 2026 13:57:03 -0700
Message-ID: <xmqqbjcnhjvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toon Claes <toon@iotcl.com> writes:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ...
> Linearizing is a distinct operation, and flattening merge commits is
> just one aspect of that. Recreating merges would be a separate mode, so
> rather than mirror git-rebase(1)'s `--rebase-merges[=<mode>]` interface,
> git-replay(1) uses its own `--linearize` option.
>
> Co-authored-by: Toon Claes <toon@iotcl.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-replay.adoc |  21 ++++++-
>  builtin/replay.c              |   6 +-
>  replay.c                      |  54 ++++++++++------
>  replay.h                      |   5 ++
>  t/t3650-replay-basics.sh      | 140 +++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 203 insertions(+), 23 deletions(-)

With such an extensive change in behaviour, I wonder if Dscho is
still responsible for latent bugs in this round of implementation
and documentation, or should you take the responsibility over?

> +--linearize::
> +	In this mode, each replayed commit is stacked on top of the
> +	previously replayed one, so all replayed commits are flattened into
> +	a single linear history.
> ++
> +When a merge commit is encountered, the behavior of git-rebase(1)'s
> +option `--no-rebase-merges` is imitated. All commits in the range
> +reachable from the merge commit are replayed into a linear history, and
> +the merge commit itself is dropped. A ref that pointed to a merge commit
> +is updated to the merge's last replayed ancestor.
> ++
> +This flattens the `<revision-range>` as a whole. When multiple revision
> +ranges are given they are stacked on top of each other into one linear
> +history. Each of their refs is updated to point to its position in that
> +history. To linearize ranges separately, replay them in separate `git
> +replay` invocations.

OK, very much understandable.

> +This option is incompatible with `--revert`.

Definitely it is OK to leave it outside the scope, but I am not sure
if reverting a group of commits that happens to be "closed" and
happens to contain merges, is inherently incompatible with
flattening.  If you have

    ----O--A
         \  \
          B--M--C

and you want to revert what happened while the history advanced from
O to M, I would naïvely expect that I can arrive at

    ----O--A
         \  \
          B--M--C-B'-A'

by linearly applying the inverse of A and B (in either order).

If it is an inherent limitation, then the sentence may want "because
..." at the end.  Otherwise, it would make more sense to strike the
sentence from the main text, and have BUGS (or LIMITATIONS) section
at the end of the page, perhaps?
