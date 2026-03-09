Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF4392C35
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099828; cv=none; b=fDhQW08H768kzvm+X7qh9J3QkScwX5S6kDMcMQLmDExcIXYF5B7W1xyfMTMIhL8YBoKVgvnrIqH5fXJxZUx1HH4l+njBspXBgF9hL4/FKJGdIpAApWDVixkP5ah6P+84mK8L4V6oipE+R4ChuBaJOeX/P15ZZVfX01euWLzbb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099828; c=relaxed/simple;
	bh=2ltkZcq6qDAZHScaUFsJ701vaLhu57eT+hDe30E66z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bYPI4ZQo8LU/2+kcJVJ/xCSmmNPhYya6W/9wl4FQHRjerGlH5XJzsMi3nVy9moGVv0K88BR0OPXjSYJEv2eALR1rs6+xvWYZSTBeDXg/gVFuuCvDXQMIG7t1BaoJj0hwbXA60GYTz3RbkShb1jk0w5fnUwL2fGBEgYCThxkeQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GR9aJ1Q9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gikNyilh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GR9aJ1Q9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gikNyilh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A4DD14001B4;
	Mon,  9 Mar 2026 19:43:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 19:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773099826; x=1773186226; bh=zRJMeDYSqq
	tMPMvzW1xyHJlq+65+OxsGU61KHkewjas=; b=GR9aJ1Q94dju7MaD9Pk54qj+L2
	92zge0JIxZbx94Ddtu88fmzLYvPhVU4SmXuSCXZaHM/swuB1MdGRt8gdq17Fu22t
	2dZeHSqIUYxZDWfHi9kccMKYKpYDjyC31FEsfij9EgmqTFZKynVquRoYP4pG5zzz
	TpUI3mtw4OyByzGN392GUbsrIQJNo21AVPUY4Bx+1XHj6qWjrt6Jz8X4YPiZXd/Z
	7FCaEUATSBKwA36TOy5s+1MWP4mgdUDR95e2n8s7NtQkfncr4/TgMyyJsz6E422I
	RfeWbEb+DJaruuyN6gecURW8uR1jRUEEH3s9vL23OuYvFu96evh4iQVEBVsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773099826; x=1773186226; bh=zRJMeDYSqqtMPMvzW1xyHJlq+65+OxsGU61
	KHkewjas=; b=gikNyilhYV6YroFFqKbFU7jke9GKpva/ayOkG/sKY2rkxqldPGq
	lyenOLg/DV4EihMehzfK4VVQz85IVNqXRgpciie3pL7XpTiVIBDlsd0Yp4AIAm9X
	wnAUAWrI8Ae5rbUgJ05rSKdNCxLe/W2cPQ1jO2KQYHZ4HwfJozXI4trcXgb56lBB
	CnBTuxRAWUpED6Mj78pIYurVkn44XRL/9S92qWpDd+AtdrUT93X7iOaqRr0p4EUX
	YHDttjVuHGC7bF8Jeb3PnxuRlOmn6em0NjTivBvBBKvN9zl+r3JIM3tH4kNVJ7iM
	aDl+smq1M7nGIwOI7nJVUoPXEYOOukCJulA==
X-ME-Sender: <xms:MluvaZUSw8zYMxsliWRLf7bt3YfTAhT4gz0iXvIaHPhSloMuWfJlhQ>
    <xme:MluvaRC_7noqdFYrgyBlqCwI6HZAlfCj5ZkwlhLH4ifYX6Fe3FAWX0mITsT8AOB-I
    ITucMOIqqHCjUVYxNhLOuyXbEN2Ndcy5q8lBU46VOZN90YPF9fSSQ>
X-ME-Received: <xmr:MluvaSzCjQ7KvUJ9zQg-HHXfY8iof9NM0mG6bPiZlSGqOv0UuwY8pBC_OHJi3mdD1_JXj36ZyCu5vsGITwCqoKf_OKdQAl-Xhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MluvaWC4KaBJ1fJgX5td-xuDHt_nYEIeYolIQU-gj72I3t1UVA12_Q>
    <xmx:MluvaXY8S1CQKPXpGLcUQKGTYyrt4G4sX5Sd-0F2sDOvOSe-Fwfo-A>
    <xmx:MluvaWhDtOMXQxbrB7ItKdwChogoltL360XUqC-sE2tEJfnX7Ff57g>
    <xmx:MluvaR4tA6p9F1Fm22xuLuQo6b24t2gNWzqlOTnFYqzIzEaizDQuNw>
    <xmx:MluvaUselkaIDws-4FPm4QTIn9yaKTun9kNSXc-praYVqS_sw7mDU61I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:43:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] apply.c: fix -p argument parsing
In-Reply-To: <20260309232700.553168-1-mroik@delayed.space> (Mirko Faina's
	message of "Tue, 10 Mar 2026 00:26:58 +0100")
References: <20260309232700.553168-1-mroik@delayed.space>
Date: Mon, 09 Mar 2026 16:43:44 -0700
Message-ID: <xmqqv7f4zhzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> "git apply" has an option -p that takes an integer as its argument.
> Unfortunately the function apply_option_parse_p() in charge of parsing
> this argument uses atoi() to convert from string to integer, which
> allows a non-digit after the number (e.g. "1q") to be silently ignored.
> As a consequence, an argument that does not begin with a digit silently
> becomes a zero. Despite this command working fine when a non-positive
> argument is passed, it might be useful for the end user to know that
> their input contains non-digits that might've been unintended.
>
> Replace atoi() with strtol_i() to catch malformed inputs.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
> Unlike [1], this argument doesn't overwrite an argument initialized to a
> default value. Instead state->p_value_known is used instead to see if
> the p_value should be used.

The change to the code looks OK.

I do not think we want to spend a test number with a file only to
host just a single small test, though.  Can't we roll it into an
existing test script instead?

Thanks.

>
> [1] https://lore.kernel.org/git/xmqq5y181fx0.fsf_-_@gitster.g/
>
>  apply.c               |  3 ++-
>  t/meson.build         |  1 +
>  t/t4142-apply-args.sh | 31 +++++++++++++++++++++++++++++++
>  t/t4142/patch         | 16 ++++++++++++++++
>  4 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100755 t/t4142-apply-args.sh
>  create mode 100644 t/t4142/patch
>
> diff --git a/apply.c b/apply.c
> index b6dd1066a0..b6c9e40700 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4981,7 +4981,8 @@ static int apply_option_parse_p(const struct option *opt,
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	state->p_value = atoi(arg);
> +	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
> +		die("<num> has to be non negative an integer");
>  	state->p_value_known = 1;
>  	return 0;
>  }
> diff --git a/t/meson.build b/t/meson.build
> index 106c68df3d..d26df707cb 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -547,6 +547,7 @@ integration_tests = [
>    't4139-apply-escape.sh',
>    't4140-apply-ita.sh',
>    't4141-apply-too-large.sh',
> +  't4142-apply-args.sh',
>    't4150-am.sh',
>    't4151-am-abort.sh',
>    't4152-am-subjects.sh',
> diff --git a/t/t4142-apply-args.sh b/t/t4142-apply-args.sh
> new file mode 100755
> index 0000000000..6fe73289f2
> --- /dev/null
> +++ b/t/t4142-apply-args.sh
> @@ -0,0 +1,31 @@
> +#!/bin/bash
> +
> +test_description='git apply test for various malformed arguments
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git commit --allow-empty -m "Initial commit"
> +'
> +
> +test_expect_success 'git apply -p 1 patch' '
> +	test_when_finished "rm -rf result t" &&
> +	git apply -p 1 $TEST_DIRECTORY/t4142/patch &&
> +	ls -l >result &&
> +	test_line_count = 3 result
> +'
> +
> +test_expect_success 'git apply -p malformed patch' '
> +	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4142/patch
> +'
> +
> +test_expect_success 'git apply -p 2q patch' '
> +	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4142/patch
> +'
> +
> +test_expect_success 'git apply -p -1 patch' '
> +	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4142/patch
> +'
> +
> +test_done
> diff --git a/t/t4142/patch b/t/t4142/patch
> new file mode 100644
> index 0000000000..c4511bb708
> --- /dev/null
> +++ b/t/t4142/patch
> @@ -0,0 +1,16 @@
> +From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
> +From: Mroik <mroik@delayed.space>
> +Date: Mon, 9 Mar 2026 23:25:00 +0100
> +Subject: [PATCH] Test
> +
> +---
> + t/test/test | 0
> + 1 file changed, 0 insertions(+), 0 deletions(-)
> + create mode 100644 t/test/test
> +
> +diff --git a/t/test/test b/t/test/test
> +new file mode 100644
> +index 0000000000..e69de29bb2
> +-- 
> +2.53.0.851.ga537e3e6e9
> +
