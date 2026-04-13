Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0A318BB3
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099195; cv=none; b=mgI6mNpdhJZNLJ51Tj6o6vgNsJpF4htY22lYjSgdFmqSnorHyYvC2Gr1dsKSlX7wXrwHAfUxfks9llRPqWpF0sjhnXCnzJthHoqBzOwbd9BgZlx4vDblccESyHozL3O5tXAEtYZ2XAYzufkVd6GUS1g5+PnLEbdfYxrig6vt/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099195; c=relaxed/simple;
	bh=iKvMD1sxXMW8TWTXyU/CSevkF0U9t3O0vgOnvzdb5T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6/2PU8YKhM1ModPkCzvm5cIyjGKKj+YHgSSkVCEPoL0IcyHU0d1Rz+Nc+qCArfPlKYKbSJ83OydnHhyB9QWVqH+QzR+Y64OnVUk0n9oRNcLLmw+KARGVzkFck3mNpLu4ruW8rLL2IggvjMwRwmE4wr96gm3p2LoqNjkBJRBJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AD4U2zrx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dYEUmbLw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AD4U2zrx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYEUmbLw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94D5F7A01B0;
	Mon, 13 Apr 2026 12:53:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 12:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776099193; x=1776185593; bh=o0B+CGB80w
	zl1htOyIREly+dFE34lHhWxynSiQ2fStA=; b=AD4U2zrxAuP+CMlVCZjZkDWgS3
	IfHnQQCTfzXXsr0nt2quZSn/2hnF13pogLNIe2z4WKcIjAireEiRSDos1nDesSyx
	Svp/3Ijd9IJpwZcwwMXLUmQSLpyyAoJ1ZjYW4IDatLdfqxB2OS553A8J6kXmodTW
	RycyioO/lcp3rOEkLGsxhdJRimwIY46Da4SsDcbpBQWzcBmmvdkfaX98iRarkVw7
	OH8FZDnsHEIlQLafUKkATg1ORZyXeQJZsmRJlU6pzma/Gx+BnSj9E2YnIKp9JADo
	MIxB8n6xslu6CM+t9Yz0voIVgVY1HYfIl4CBr3M5dGCig8+cdg28XY/Wj1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776099193; x=1776185593; bh=o0B+CGB80wzl1htOyIREly+dFE34lHhWxyn
	SiQ2fStA=; b=dYEUmbLwCRRvBznPQU43OU/PGGhX6ujdVtBz141An4zoJpx5J/I
	RSvyhLzTup+y5kJMCmA1SMD5JLgTN+sV8zkabZ4equKdjtk3cOlkjQU5nFjqTkim
	jSMjVDgyS2XhIsHzKgO0ovT/mApASUhHxSHSLSWtbZYEPkikbdkAPLbiDHa6Zo+0
	2NBZ0/HJ2pjQeJRIXreXn8jKQi8KEtqxuERgLzYlCpEsI+sh2qDp3cXgC36A1Iwc
	RTYntOmBhHoblpzeo9Sl3/cjM3nIzTvEHeimicqSvqRsCeRui+R1a7vTBFe7dOK5
	FUtsP8hBzIuJVoekgtC2ofGSaoGxU3+65Tg==
X-ME-Sender: <xms:eB_daeomS6E3n1zzsAFLU8NjG2ZFE5cc2kS3TIEOhS4ACAxf8YjlGg>
    <xme:eB_daUHFf69uthrkIAt3YEVM0GQ8GZXwpc3JrzX1HJDtxDEjD4jSJ6rCBMWN8hFEP
    fp3dELLnWJpBXitl0bF3-JjkhvYeKUNawh3hKlWgvKIx6pizf2OEg>
X-ME-Received: <xmr:eB_daQlrCe89YXHsap531pQc7LdOHQUOvFviTgb9g8weVqWjoa_7z1Ezxlh34tAFpgUlyA9c0pnLLwKaK1ryNiaMxnA6ZapVrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:eB_daXksQ6AqPC6vQNh38o36QzGNkoHHcKEF21fYdLDzlBKieWenCA>
    <xmx:eB_daRshfO4a2gzWeuyAPORC9WR2WVyppiG9l4opZazrtUP-8RMRFA>
    <xmx:eB_daanbDQqY-Ck0hj1U2r-gQUjsLYUAg8z7tf_wIr0r_yPZayCU9w>
    <xmx:eB_dactm3zZQ1ahjtvvLgn3RrGDlDlOeOEZ0R6Eb2V4eJYUMuAfpUg>
    <xmx:eR_dacPnM_bWmhWtTWvDfAsDcplVLjPTISCWOLvtlvJyX2arMcCx0mUj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:53:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/12] t: prepare `stop_git_daemon ()` for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-3-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:24 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-3-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 09:53:11 -0700
Message-ID: <xmqq8qaqkdjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have a couple of calls to `stop_git_daemon ()` outside of specific
> test cases that will kill a backgrounded git-daemon(1) process and
> expect the process with a specific error code. While these function
> calls do end up killing git-daemon(1), the error handling we have in
> those contexts is basically ineffective. So while we expect the process
> to exit with a specific error code, we will just continue with any error
> in case it doesn't.
>
> This will change once we enable `set -e` in a subsequent commit. There's
> two issues though that will make this _always_ fail:
>
>   - Our call to `wait` is expected to fail, but because it's not part of
>     a condition it will cause us to bail out immediately with `set -e`.
>
>   - We try to kill git-daemon(1) a second time via the pidfile. We can
>     generally expect that this is the same PID though as we had in the
>     "GIT_DAEMON_PID" environment variable, and thus it's more likely
>     than not that we have already killed it, and the call to kill will
>     fail.
>
> Prepare for this change by making the call to `wait` part of a condition
> and by silencing failures of the second call to `kill`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/lib-git-daemon.sh | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

The same comment as [02/12] applies to the early part.

Ignoring the exit status from "kill" in case that the daemon has
already exited with " || :" totally makes sense.

> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index e62569222b..91bcdd0bf7 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -85,14 +85,21 @@ stop_git_daemon() {
>  
>  	# kill git-daemon child of git
>  	say >&3 "Stopping git daemon ..."
> +
>  	kill "$GIT_DAEMON_PID"
> -	wait "$GIT_DAEMON_PID" >&3 2>&4
> -	ret=$?
> +	if wait "$GIT_DAEMON_PID" >&3 2>&4
> +	then
> +		ret=0
> +	else
> +		ret=$?
> +	fi
> +
>  	if ! test_match_signal 15 $ret
>  	then
>  		error "git daemon exited with status: $ret"
>  	fi
> -	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
> +
> +	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
>  	GIT_DAEMON_PID=
>  	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
>  }
