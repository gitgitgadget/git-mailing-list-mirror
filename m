Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222DF4FB
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376625; cv=none; b=sFvNfDUZrDQjJ5+kK7w2RFkAFC1Hjxelbq1osPNdFZQje4CAXfNsUpKAULWnC8Kqd8d9SNv87FIAcs46LwUjNEfwigKrzYBCIwTYw7SSv/+3hP7nQqFhOC9BEzIK98XnwvHF/6fwCqdaJvWHf6XUjzZm1jSTC7cDJO1P4tVUyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376625; c=relaxed/simple;
	bh=2BqD2wdo6jdvMobflqvhuMkieQbYhrk2PCGO+8Lxq4g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbJ9kGg5k9wDI+2R2OGs6QYM+RtOWN0KbfB2niZENItdxsI0d+Q8gQCAl4F5IfOv3vIvn2Ru1P3q6MnKhx5LEl30k8gR9q/5ntHEuKh8JqnqcxfpyvcVUtgT7qAHEaFK4rfpyl5hC1yxQ5F1sFnwulXJk56b/pkSuyLDaBBAZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E55E2j2a; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E55E2j2a"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 125142B2AF;
	Wed, 26 Jun 2024 00:37:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2BqD2wdo6jdvMobflqvhuMkieQbYhrk2PCGO+8
	Lxq4g=; b=E55E2j2awY7PPPtZcKotIzFnEZ+gwLDI+uAZfbi8UNdxUk/xPRyNuo
	3N96AOCuKpJPuFtUmsw+RKSR10pZHQXnl2susD44ZxyWCAbSLhmcgGVFwKbMcqZ/
	rQ1RkuBmjElrbmfo73nCE9JRkWHd0zfQKmTtspDjFhLBaxeID90r8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD1E62B2AE;
	Wed, 26 Jun 2024 00:37:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11C622B2AD;
	Wed, 26 Jun 2024 00:37:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #08; Mon, 24)
In-Reply-To: <xmqqbk3pakol.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	24 Jun 2024 18:13:46 -0700")
References: <xmqqbk3pakol.fsf@gitster.g>
Date: Tue, 25 Jun 2024 21:37:00 -0700
Message-ID: <xmqq4j9g8glv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB73D0F2-3375-11EF-8C60-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with an URL
> to a message that raises issues but they are no means exhaustive.

We seem to have too many topics in flight that haven't received
adequate reviews.  Can contributors divert effort to come up with
new patches and topics to reviewing patches already in flight?

Here is a summary of topics that are still marked as "Needs review"
in the draft of the next issue of "What's cooking report".

Needs review.
 - tb/incremental-midx-part-1                                   06-07         #19
 source: <cover.1717715060.git.me@ttaylorr.com>
 - cp/unit-test-reftable-tree                                   06-13          #5
 source: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 - cp/unit-test-reftable-pq                                     06-14          #7
 source: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 - vd/mktree                                                    06-20         #17
 source: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
 - en/ort-inner-merge-error-fix                                 06-20          #7
 source: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 - jc/patch-id                                                  06-21          #5
 source: <20240621231826.3280338-1-gitster@pobox.com>

There are a few topics that are marked as "Expecting a reroll", but
I do not expect they will see an immediate action from their authors
if I repeated them here, so I won't do that X-<.  Instead, I'll mark
the older ones among them as "Will discard".

Thanks.
