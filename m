Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64452F88
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786093; cv=none; b=A9u5kNOQ/jNIRHbvup3E6bu20kbpkQYlCGtAGoYCZiedleapj4V7FKF/juHvkWZOiuJZkJjA2s7Y78rnJawUd6yRzyV1GT4CtowkmEwFV2n2M4caAfsc1vKIfcFRRumqAH+8jy4HWEPtyXzdiEI4Q0XnpSEp/mVj7GWRBUvBfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786093; c=relaxed/simple;
	bh=6KftPvpxdQqQtff0GhK+4L+NXjycfXIqk59S70gLK1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O07XpHHYIrqUngmCdER0EtAm2jJ2IKkhqqv91IkR+N+qJ+iAw/p+HsgLAKStFP9vulLnJwioqmWRJtX3fX6VrlpQQTu2NSl6159A5bonc6XfnzM8KpLAaqLUrvwL+mgSkGV2kOYtq1tAHK0aPjtt3MsJwXw4zOOfStW43xK46qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hEo6412l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzV2un/I; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hEo6412l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzV2un/I"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DBE9B1D000AE;
	Thu, 17 Jul 2025 17:01:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 17 Jul 2025 17:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752786089; x=1752872489; bh=kEHIIn+0AP
	v835UbtTqsnfEStRHkWZ6yZZ1HzR3zcjc=; b=hEo6412lNZfqf7GFPmwU131O+o
	zKgHPqfZw3YsxPKGZQuQakfy4kWbkKv/gMg6K7MXKupXuvWxXGNz1gZjPOwbtzCw
	O0WQlrC1HA0i5fJ7LM242OSHfVLApJZwOx/XGYg02Wvu8mekdJ5odulP+kAhgQuj
	+qqPw4PtQ/dZzWxfbRz9KO9S0qSzQzD1Zlk6EqKIC23vRjqiwKEwaqfCCQTa90Bu
	94ZDTTha1MLkkNoScUmlpTXT0LCqRJ1w+y1/TRhCXBbAZZAD1P/VbQmLy+zwPYJo
	w6SZUTzgPlL3jRax2Gl6cnOnWve93a8Jc3R//l1y671jGOIwgqasFBqI0U9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752786089; x=1752872489; bh=kEHIIn+0APv835UbtTqsnfEStRHkWZ6yZZ1
	HzR3zcjc=; b=LzV2un/IZY4UIfbcsX2tRv7yFZfnqDeW38PBavwTGZhJzCYDIKf
	inRFAzdyOVNVAfHF4+SBJGUy9Ie7ZoIwpIivOChr1Gum5tpicOeEwMXs8UD8H/73
	D7Ta4kpHRczttX9YrCh5GUkZdrEdkRPcnVWIT4bsLyNonky+60ZZRHMgBCUtKpzs
	dNQlHd8yL2K7xA2ftzfY+WimTjBy+9qRJAO2Gomj6/L+C+LtZwHEc7f4qo2CnoZD
	7IL8wM28gt8NXPcG5zFk9tMuQ/NAAmI6yxTP4/AvIBYx5dRNQxYsKHz3/3gxpOQ+
	sSbenO8IeSecr194XAYNXaL9//qim8z5yCw==
X-ME-Sender: <xms:qWR5aNXQ-UZQ94lN-HAb-LeSIIaIbYR4M5uEbpvGdqwZPuJluF3Meg>
    <xme:qWR5aKcdd2vF-4Q1-CChsHqscy_DyUtfbtXm5n9r5t4fXp0VB9Hna0vqitZxR_i3V
    Hl9UpiE4pkjhOhBBg>
X-ME-Received: <xmr:qWR5aJJf3Puq03MgapSrk_7lvytqwA8fOEZ4WofV0vSj8c88C77UrBBj0PLqRc-yxw8x1gf4ylYIx2TzIWCU6_xvcltcPu5A9M0094k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qWR5aPwMynJU-MvZKiDdqVx7aCL1Oo29uRbSEnKP97QSQW9DPecE8w>
    <xmx:qWR5aHulo_mmeTbspKYM7Xb4f89cp9Y8DDyn50QosQsOFHP_GIYrww>
    <xmx:qWR5aKDzxFEYskZBnSX1xRc2aeSlSAJvhvRzVCveHBJGFLF9m0JKCQ>
    <xmx:qWR5aBFiCZOL4FnvTVq7eo2dGch6bpRUFVfne69OLitBl73zApQEaA>
    <xmx:qWR5aMtlwFLbxlafOG1So44vINm0B8lqCz1SoIMTHJVshE6Xmm-vIH9t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 17:01:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com,
  karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [GSoC][RFC PATCH v2 2/2] t: add test for git refs list subcommand
In-Reply-To: <20250717075009.26262-3-meetsoni3017@gmail.com> (Meet Soni's
	message of "Thu, 17 Jul 2025 13:20:09 +0530")
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
	<20250717075009.26262-1-meetsoni3017@gmail.com>
	<20250717075009.26262-3-meetsoni3017@gmail.com>
Date: Thu, 17 Jul 2025 14:01:27 -0700
Message-ID: <xmqqbjpi5y6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> +. ./test-lib.sh
> +
> +GIT_REFS_LIST_CMD='refs list'
> +. "$TEST_DIRECTORY"/t6300-for-each-ref.sh
> ...
> -	git for-each-ref refs/tags/fourth-signed \
> +	git ${GIT_REFS_LIST_CMD} refs/tags/fourth-signed \

I know where your bias comes from ;-) but if this were

> -	git for-each-ref refs/tags/fourth-signed \
> +	$git_for_each_ref refs/tags/fourth-signed \

it would have been easier to read the resulting test, as
t6300-for-each-ref is and has been primarily about "git
for-each-ref" command, and the new test script that overrides

    git_for_each_ref="git refs list"

before including t6300 would be a good demonstration that the new
"git ref list" command can stand in as its replacement.

> +GIT_REFS_LIST_CMD='refs list'
> +. "$TEST_DIRECTORY"/t6300-for-each-ref.sh
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index ce9af79ab1..74a030371c 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -5,7 +5,9 @@
>  
>  test_description='for-each-ref test'
>  
> -. ./test-lib.sh
> +. "${TEST_DIRECTORY:-.}/test-lib.sh"

This is probably wrong.

Nobody promises that including test-lib.sh is and will forever be
idempotent.  While this patch may not give t6300 a serious
regression right now, I am not sure what future subtle breakage we
are looking at for t1461.

Probably this should model itself after how 8752d11d (git-blame: Use
the same tests for git-blame as for git-annotate, 2006-03-05) moved
a lot from existing t8001 to annotate-tests and so that they can be
shared with new t8002.

Thanks.
