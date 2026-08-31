Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335737C923
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211145; cv=none; b=YXXsVKdBqwMhkgtuOei/nAqdDTsBSVP/WFel2XGZA+vUyOwwZ0eKQC31UVQxksRVhJBO3WOtbNuE6JzGY0YcyyYFVlfr49NyMzUY3WAkv8HaFUboT7BfvlurQdpXUcuRXue2f1pDmyuQv1eGPHZQiB3WEwdn1W0pewYqRfxPlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211145; c=relaxed/simple;
	bh=fKbi5ngUnu0bW2bkpL/d91c/B917izyK1i/akza4Ncc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nv07Qx9GJnI/VEq/DbX2ZsWgE+dUayp9w/tvDj2xWhBl+oKwIVYc3kQr/M+DvJ6YyRHplwod0yrU97mBvjreqvshUz3xodMsXfwLQPmORS8BOQ+1ySTRH45Pd6wmWnhs64SD9X+zLXEfsRt0qQhLqoVSsf6ClY/0R2TJJwg6cYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dvUg1pPa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYJAhtYw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dvUg1pPa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYJAhtYw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66B977A01AB;
	Mon, 31 Aug 2026 17:19:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 31 Aug 2026 17:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788211142; x=1788297542; bh=kdIBx7OmBb
	7fmNnxF64HCVBzkmwJRqp2azY7K87nMAA=; b=dvUg1pPakhEo15+5you2WMKP5U
	/lY1e8XZEiD2BB2wr8+NyPrHPzZ06VsgdWZiByQySKWW0zPw0rOn2ZD4+Bvgfclg
	ndNvCP5E90mxrzKi31bEn3OuFGBBxpIXjgIKvk5lyoR8auEsoV0+RjjYPmuTCqLQ
	ye0Ndhg0+TLbXp/7UsMPp7RtUZSxXWhIEUAcjAEZUI3XGS7ZA0bZfNIDfnkAJ//4
	kMhYi1HZ9AYUSBKnM2Q8ZSaUGNcpUkgR6f5epuUwANTp/Drka1IH7lIOxwRpj4fF
	flMhisVgIDMm3abNUbRNP8/7kbS74rzi9c9bgPIWwUi7XEHibxG+65f3LKsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788211142; x=1788297542; bh=kdIBx7OmBb7fmNnxF64HCVBzkmwJRqp2azY
	7K87nMAA=; b=lYJAhtYwDM78CWpJ2MTORtbuWubupr1CODip3Iys6fJE0AhEcK0
	cg3P02xZNwIdFj1j7vYu2GwHTGwf9osNRqbbN5ivJjh/cnu9/xJLNRdBUnFDTPlQ
	8oqPlO8PrEPIdGGiK0wtP4/ya1RxuZ4AcLZy/a3AJzd6xILbz0aXPWA20VZU/9OU
	pQPDiX63Gr+dgmZhPIwStm4WRYA/s0PM/I5kP5CEGZk4romId+le6uhkvVMhg+Hn
	vr2NHapmlysFSUU9Y4l4NzDHNnUGuRSEBUickHMF/foP88RCp9Wyo0rNfCjV4eo5
	dOc6xbVUubZ9ENzYyWlMH6s6QdBRcKxdjfA==
X-ME-Sender: <xms:xu-Vav9rj02vG8kn6VYuJNx2h6W5-ZiT-LDQN1XyO0imPmxhAgk3Qw>
    <xme:xu-VavZWnYl8ZG90zVpAMf5x4g6E4A8wHH7tfvGfN2mHwyX5PLjiIKj3evdLfdswL
    o-kLsCb_tb9MCSDa0CV8EypXTqlQtWpTDN4JP3VuJMr5bxOt4-HvSI>
X-ME-Received: <xmr:xu-Vam1lqrumcE3v-85qrh5kkD1T87Ld_-A19A-UCwl817RRa4nBgIWpFBrc5cH_nAtp7b3Ijdysc88l3om8jVHUB0auTv3JQg>
X-ME-Proxy-Cause: dmFkZTGDlhKecgF849XuG9ldkkiFFglkuU+IG6UakApSS7gAKsyka4JUQwptUgWGoENT7B
    fRr0aXesr4IY2QHmwjgYHmuLKjsOejCq15VoDIGIu9T2ZWTiuqorGYs8gzRy4rotwh71qT
    qKgbBVOZGqUQcdfFzIR5nE3Dt/W0B41jlV1LL/XToTD9VNJJgxQ3M1kgE23DOjXW6P1izE
    xptvVwemoTpxj/PsGQ+/v1nB77UF4lghzqjC8H3px7LNyGzw0Inu75LIgibIcKcV+0R42T
    Pt+xzS10J7/MJFNwfLuY8/qGRq3sw0ioKZqCaLBcTusCDQrEi6sqB4oG6sHgbhFZW2D/KL
    94RDH7y5fABKRMyMHkhiCi/0zYsvKbDxOr+lyLH7/ud5xh+Ml/CQGq3r8LeI53gQEbA5V7
    J0PMsm21qrGhyRlBA9qPZukM0v2hyqueV2nv7YwOWnzYOMI7jUNgcFGBW98qmWzoqklcJb
    0h3tf+ZwXQ2MRfghE7B0p9C19XkXCVuUldyuBo1lwCMkH25f+acKHbxNyVQOduts4w0tPO
    9716cuMSA0xGc5m1lsVA1qP4vDjqNkt+vCV2FkyP3e6VIdkm9q3GZV8Jy8FkoN4HVu0z+h
    cTfK54bYtuBp+WXnen2hEw2nXlaMQ5Guad15fHNcvWSecwD0U/kWR89/a5sA
X-ME-Proxy: <xmx:xu-VaiaNFunL3UvzGE0-mIIWZ4-QaaPWZdbFQKHLmPetscWrInMqmA>
    <xmx:xu-VamIM6PpTPyepysOg9Fk1YQVLCinxRwVSbcYQizfYeeMW2jlXeg>
    <xmx:xu-VapFwdUUcZRKYp3HNOrnNP9TtHUQg31f6q-PPQMCz1alKmks-Ig>
    <xmx:xu-Valuq16dgxpbxw9JDF0IMDBgEBKa44ZcvHAqfLireQFkZ3210XQ>
    <xmx:xu-Vak6qVe_1w3jBUJL5DoZEUqNNjb226mbkSVd6HT4QiKQNcol1kee4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 17:19:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Gusted <gusted@codeberg.org>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/6] last-modified: use the pathspec's Bloom key to
 pre-filter commits
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
	(Toon Claes's message of "Mon, 31 Aug 2026 17:18:40 +0200")
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
	<20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
Date: Mon, 31 Aug 2026 14:19:00 -0700
Message-ID: <xmqqmru2ugxn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Similar timings are seen across a few other repositories (like GitLab's
> monolith gitlab-org/gitlab).
>
> [1]: https://lore.kernel.org/git/17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org/
> [2]: https://codeberg.org/ziglang/zig
>
> ---
> Changes in v3:
> - Add trace2 "bloom_queries" and use it in test to verify top-level
>   wildcard behavior.
> - Link to v2: https://patch.msgid.link/20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com

Merged to 'seen', pushed the result out, and saw this:

  https://github.com/git/git/actions/runs/33429987759/job/99612809093#step:10:1391

It seems that it is reproducible locally with the variable settings
stolen from ci/run-build-and-tests.sh, i.e.,

    $ bash
    sh-5.3$ export OPENSSL_SHA1_UNSAFE=YesPlease
    sh-5.3$ export GIT_TEST_SPLIT_INDEX=yes
    sh-5.3$ export GIT_TEST_FULL_IN_PACK_ARRAY=true
    sh-5.3$ export GIT_TEST_OE_SIZE=10
    sh-5.3$ export GIT_TEST_OE_DELTA_SIZE=5
    sh-5.3$ export GIT_TEST_COMMIT_GRAPH=1
    sh-5.3$ export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
    sh-5.3$ export GIT_TEST_MULTI_PACK_INDEX=1
    sh-5.3$ export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
    sh-5.3$ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
    sh-5.3$ export GIT_TEST_NO_WRITE_REV_INDEX=1
    sh-5.3$ export GIT_TEST_CHECKOUT_WORKERS=2
    sh-5.3$ export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
    sh-5.3$ make T='t8020*' test

and it does reproduce when the topic is tested standalone (I've kept
the base that I have used to queue the previous iteration,
41365c2a9b The 4th batch for Git 2.56).

Ejected out of 'seen' for now.
