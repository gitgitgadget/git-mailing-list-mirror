Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4363E1686
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540794; cv=none; b=EmrBTYlfN/HUob+zXZuRIdYsriDGTyZLt5wGaHHi5o8s1GVZXaNUG/oVyilciHWx7ckiPIWYGZ0zKVoOZ/4MM29v26Kb5FE59ivISOs2tRUfUAXVVGqxBpUpdbjjrrlEBxYG8JxogxM4fENhWa575EATbYUao7hUcpO3rk3gaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540794; c=relaxed/simple;
	bh=Yembep+Ox6HXrOP2YxMl6NbljScBSk63cvwW1j2xNFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDvVafRwpAAIYxNrcufYlDCH9BLplUylLqpBhd8EfglJw0CDeeyW8wtap47UzNYNBobHhKkeQ1BmezUdusZMIooVf/hwWJTRRqQMbL9msox2um9OwZnhoiY7yMAFQOusYj++EAKeO/H0ruS9a6Ek3GHGBBZ0CMY8fwyCi7CRC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jysuKO1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0Eygq9h; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jysuKO1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0Eygq9h"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B7551D00140;
	Wed,  8 Jul 2026 15:59:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 15:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783540792; x=1783627192; bh=URCzcw+Gzz
	/gKIPR6asKlcZ0bYeVD59J4GLIyEbIdw4=; b=jysuKO1p2RzxpUPI4IRFtS0Q14
	mbhpNIjp6kytxZj5cC8sNwS/5OCp9aMN0+Vwf5HKTDl71+WUijW2HybRvTaX2dFi
	KnMME3ymgr9105dt69mu/6WHRR0SVP/NBkETykQCN9V4Ef9vzCULZCYiK5o3gU/N
	cXMomhdihGKE7L2sfdAwtj3XeQCU8DWL93RW1QQPWRP5FT+geZmWqA1DktBJHMrL
	3oNCW26MsG7w16YIq4levhXOqPZjmkHeM5CdxGTgOs7KWaX7RifWbe2Ud+p/hV/H
	n3/C0JB57d+MR7t2FvA8Xu31XiHInBS37VtRMkbxCLNIHmanIV9Nuw6tgsTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783540792; x=1783627192; bh=URCzcw+Gzz/gKIPR6asKlcZ0bYeVD59J4GL
	IyEbIdw4=; b=b0Eygq9hkNDmPFPJRaN9+bM3/yNSdO23VYSj1URwuZ2quMhiHtJ
	Kz/Z6MHlNwjFwrA/4N/NtcF7FvfB6+5MPCEttDPACShJHiPX97gySWAbNRIOMNEV
	JE4l7T/n89aQoPLKbq2/yhjVre/GrchNVvRO3oi5TegCkMZxgMXY1dZBlELgLQ8p
	ge+vN640NmkLeKUSoxory436EAaYoWE0YY0UbpvLP7rZnjnePaCff1G1oenCIgVJ
	0ae9WNB15ZrkNISukhVMPkSgJZFqANnQYL2Tpi/P2HuVVAZLz+KZHGYUpZ9yHR1t
	ZCk1nj82ap8bGGpKfkz2Fe3QkBjdAz/92vw==
X-ME-Sender: <xms:OKxOapLGOy4KbU5QJrSKr6Aqu9S2foxxmieUDLrHhUGxdluo8ty1xQ>
    <xme:OKxOasJ4oXE_Th77TdsZ3ggZD17qgQ3OUu54woQf7ihej-JZR48BOnfLW7wS-CR4v
    GSKKXZPa3KyiHcmH7ZLx635kFAy0fWm8t4FD22EEK3DKNmjyMgQPw>
X-ME-Received: <xmr:OKxOamvEAHEamfp8saoAAGRWnA51FCyvYyPbNziBw19pvLDdkhQnf3w3oxTiO8G5eUPalgZlnbiFFEnfRdYuc-sk46aSsqhGnTQ0dKQ>
X-ME-Proxy-Cause: dmFkZTEfMHTm3ms4Kufm8vO4bYagL2nANLGQDav7066X/8NYvRaUHFp2K342mymv7g8EZy
    xk6xWDQ3vpVh06FXIVgH6lgmhBxrE1DPo1eTGEcF/zU7zf67z8bxMtmyIzK46iFTGEa+jY
    of5wIUFWd6Urf9LcloPeSae4z1qR6Tl3xSIIXFifJE+i2mDbfaHNu+rqEoDXoXRwIqHg7j
    pjSnkBwPaLxoCvRM7mmxsbJExuIEE9FFEFfcy4mDUhv5VxDmSPZq8Uudx1y0q+YV6Cw3N8
    K+rjoGbZDtj1O/sLQhMN8ghTQChgJh6t3YzNbMqWiMp3mbP6jhm5JTO9mGAZifEDoL5jpT
    VGSeq5x5J8pq6moVhlE641C4sfP0/iyJqoDt8dq56z/2+XRJ61uOaOIIotCxlUsymrkJ6t
    TYaXFWG1R5uRBNjOM3o8DkCxvTl4La5kbaLiCAdtZofHeK0OTJ/ciBUjh2COasP51Qw0qW
    I3u+r2n2dy8xcsxUvwlSRs7nLwtKtlk9z9cUKM6aZcV4OLsBl59UfuA0Di6C4HNPWAXoJx
    RjXgQW8f+dO8Kv+Q/d3/u86waM//rFw6qbBOpOsscXfRpRDSwV59Dbpa//YeTzPIroELSE
    wPCPbtGoD15mtLZVEnDSnMETzKvsrxGOEW090xAYRyDYyNXpnyHFrRYSMxiQ
X-ME-Proxy: <xmx:OKxOapTRj4ORaJg_kkpU_H61e8FvMDuJax9kr5LgJ9GMrkqMFiMEgQ>
    <xmx:OKxOasNpOHSDIMsTpCrphSBpV1zzhtoaHx86uAStvtB6wA2430pzAQ>
    <xmx:OKxOauaHZBOL9cnJWm9HoKMzk4FvLVL7SVhH_Svqo8TuXgUL9Ln3Pw>
    <xmx:OKxOamyU2dcwpSCZAOlNfOY9c3eeNy6QPtsuFUtQ1J8wFc8h4UZN3A>
    <xmx:OKxOamN-Uk3oMJ5dkbp-f5TTkKq13tHm-FTRy8TO4m1gQnctixWJkXet>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 15:59:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 3/3] t/README: document writing concurrency-safe helpers
In-Reply-To: <771d264d2999a780e0c93e64bb4451a05214ab75.1783479584.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Wed, 08 Jul 2026
	02:59:43 +0000")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<771d264d2999a780e0c93e64bb4451a05214ab75.1783479584.git.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 12:59:50 -0700
Message-ID: <xmqqh5m9tfpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> The apply-one-time-script.sh and http-429.sh fixes addressed the same
> underlying problem: a test helper assuming it has exclusive access to a
> file when the web server can run it for several requests at once. The
> atomic idioms that avoid this are not specific to CGI or to HTTP, so
> document them generally, alongside the other guidance for writing tests,
> and leave a pointer from the lib-httpd helper list rather than a local
> comment. The note covers the anti-pattern (a "test -f" then a separate
> act) and the two safe operations (mkdir to elect a winner, rename to
> consume a one-shot marker), citing Git's own lockfile machinery and
> make_symlink() as precedent.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  t/README       | 32 ++++++++++++++++++++++++++++++++
>  t/lib-httpd.sh |  3 +++
>  2 files changed, 35 insertions(+)

Thanks for a nice finishing touch.



> diff --git a/t/README b/t/README
> index 085921be4b..a9d425f392 100644
> --- a/t/README
> +++ b/t/README
> @@ -854,6 +854,38 @@ from the test harness library.  At the end of the script, call
>  'test_done'.
>  
>  
> +Writing concurrency-safe helpers
> +--------------------------------
> +
> +Some test code runs concurrently: a test may background work with '&',
> +and the helper scripts installed for the web server (in t/lib-httpd) are
> +run once per request, so the same script can execute for several
> +requests at once.  Such code cannot assume it has exclusive access to a
> +file.
> +
> +When exactly one of several concurrent processes needs to "win" a
> +decision, a single atomic filesystem operation can make it, rather than
> +a check followed by a separate action.  A "test -f X" then "touch X"
> +(or "rm X") races: two processes can both pass the check before either
> +acts.  Two atomic operations avoid this:
> +
> + - "mkdir dir", which fails if the directory already exists, so that
> +   exactly one caller wins, electing a first or only request (see
> +   t/lib-httpd/http-429.sh).
> +
> + - "mv src dst" (rename), which fails if the source is gone, so that
> +   exactly one caller consumes it, claiming a planted one-shot marker
> +   (see t/lib-httpd/apply-one-time-script.sh).
> +
> +A "$$" suffix on per-request scratch files keeps concurrent invocations
> +from clobbering each other's fixed-name files.
> +
> +This is a standard shell locking idiom, and the same reasoning behind
> +Git's own lockfile machinery, which creates its lock with O_CREAT|O_EXCL,
> +and make_symlink() in t/test-lib.sh, which uses an mkdir lock: an atomic
> +operation whose failure indicates that another process got there first.
> +
> +
>  Test harness library
>  --------------------
>  
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index fc646447d5..d64f9c8c2d 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -159,6 +159,9 @@ prepare_httpd() {
>  	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
>  	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
>  	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
> +	# The web server can run any of these CGI scripts for two requests at
> +	# once; a helper that keeps state between requests must do so with an
> +	# atomic operation. See "Writing concurrency-safe helpers" in t/README.
>  	install_script incomplete-length-upload-pack-v2-http.sh
>  	install_script incomplete-body-upload-pack-v2-http.sh
>  	install_script error-no-report.sh
