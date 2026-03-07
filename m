Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727541B4156
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846942; cv=none; b=GajU0DjqIGD5ShCo6Q8kPAwUeXNea7e1nab0YUM6qR0rp5M4y8RvctDZuB30koKLMe9flG50cPpshXTRGaH3IU8L/1llVRqTpLd2S0mso+Ln1HofD3Sdib1gNiME40hGgBOZZBes+n1Pwa3Ar1/YZ763vR3xlNeyjfPR3qefesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846942; c=relaxed/simple;
	bh=ttRK42Bf2hRKBfoL2uQYXIn67/nwaqNPPD5rOQN0MlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ruCZz0qEvI2XvDOqWWNgIwbqH2nP3fRoBOXkRRavKUvc45tiN2xxhxKCL/7Br93YQlBb14Ce+k6J714wNEmlR2vOYW39SEhBlKEHhF5CtneGjTzCsbmO6hofLwHJ3h1W4XSM0v1GaHBANS6p7CLLIhuzxf/oMiXIJr7q+h8Ri4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FF4QFnyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bo3onS5R; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FF4QFnyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bo3onS5R"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B286CEC00AE;
	Fri,  6 Mar 2026 20:29:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 06 Mar 2026 20:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772846940; x=1772933340; bh=eDeq3YjPsA
	/Q+gkfhE2M+kyO1XR+KVeBQ/c2Ux7xGXc=; b=FF4QFnyTKTpmqxrtcwrVjzxcS3
	gTEK4girGGwxBra04nY7PbUIy5UEekJmbxnl7rZySugfftX9wN8QNzhxei72Ffya
	4pLOZyv+y7S3kli5shO+dgY8svm0KqoOwpezRUe8fWBlJjwgH34l28EUCQytIjQT
	aH9lPcVnlYqjsXa4z3yX1N497zEzyzPyasiTXqwhBsDlY2vgRxXj6rz7j+Ajmcb7
	/BPWmlfzbA5VGSwiCgqbK2Oak2Kfrg2WZuvfcAvII+BX+3kD2Xeq0fxKBCmyBOM8
	Bqr5Jihfzs94PiknCrPOGnGdXFvI7/DjfNT2qgHwGpJ1o9GCUx4mPp+ZvnKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772846940; x=1772933340; bh=eDeq3YjPsA/Q+gkfhE2M+kyO1XR+KVeBQ/c
	2Ux7xGXc=; b=bo3onS5RkNW6uIl81vnW/VEBBUNI04Twv7pTCBFi6+m0AVM110Z
	2Ud4UUqsWMfwm5FQfHr10ag1K3ybUYIBXIlCul27GdRh8Uy08mlwpbbaqT/DLswy
	bavCjoBVXtUNV1iupHopCHAq0z/NRSHYwCOAftjoLAw3YsOARdLoxZ2jJf44KD34
	YUYFzavGNsE5O2svbRz/tMWMGKHatA7ulR3fdIttcTi0BUBPlSmtvjPlCj6dp4k5
	aaon2tqKha79CyMtJkzNCk7rTWMmiBYCcakiHm6CYuQqkwsTQTn6qa8gUKCygYx/
	tvs58Kqk3mqdimRhcJo1cxK79nwQgllnKSg==
X-ME-Sender: <xms:XH-raY1a3TrtmAjwsFGD_Brpu7l9f9FhAFznYBH85nYr32WnTRT6Tg>
    <xme:XH-raVocSuKfbcSuMh-33aNP3I66NUu_bX_lO2KLzRHT-t61F3nXGTGDRgzJJtudJ
    rN7CwEbHvnyraYrGBnRXWYZeTtEPGdpVBe8juP5NjQmiBwNStkTAw>
X-ME-Received: <xmr:XH-raUjDHKWoENkqV2XrjWuCWlhbiGqhHDpV7rhuEZm2kvbaF85fpEq9gIVgV9JhUIYGQeMKdwat9RjfYM0c1rZnGwjWe6xkow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtrhesth
    hhohhmrghsrhgrshhtrdgthhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XH-raR-Lnqg3giE4795duFyny4IctbkgA8CDL655HvyWdTcm6FC6TA>
    <xmx:XH-raQVGk-CWGlA6QKZVyz1ykcU4DlSDKrBtQZnMBcM_54M2-Nl8Yw>
    <xmx:XH-raVAE2-PBdvut-MHIJ21YWaXBGKZvzGhgN8-mZZBcPHCyqvX4dw>
    <xmx:XH-raVGy5-wrzX_WW1TglDzTdKovwsrJFGFzNMpVgd-45rEfDCzkpw>
    <xmx:XH-raeYmqKsuXFFOzjQU-UwZMzbSJXH0e-NQxY_1iFUfOruRXx6is4VQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 20:28:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
    Thomas Rast <tr@thomasrast.ch>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] line-log: route -L output through the standard diff
 pipeline
In-Reply-To: <pull.2065.git.1772845338.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Sat, 07 Mar 2026 01:02:14
	+0000")
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 17:28:58 -0800
Message-ID: <xmqqcy1gv351.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> git log -L has bypassed the standard diff pipeline since its introduction,
> using dump_diff_hacky() to hand-roll diff output. A NEEDSWORK comment has
> acknowledged this from the start. This series removes dump_diff_hacky() and
> routes -L output through builtin_diff() / fn_out_consume(), so that diff
> formatting options like --word-diff, --color-moved, -w, and pickaxe options
> (-S, -G) work with -L.

Exciting.

> User-visible output change: -L output now includes index lines, new file
> mode headers, and funcname context in @@ headers that were previously
> missing. Tools parsing -L output may need to handle these additional lines.
>
> Known limitations not addressed in this series:
>
>  * line_log_print() still calls show_log() and diff_flush() directly,
>    bypassing log_tree_diff_flush(). The early return in log_tree_commit()
>    (and its associated NEEDSWORK about no_free not being restored) is
>    pre-existing. Restructuring -L to flow through log_tree_diff_flush() is a
>    larger change that would affect separator and header logic; it is left
>    for a follow-up.

OK.  Previously all the output routines were hand-rolled, but this
reduces the extent of deviation---as long as we are moving in the
right direction, it is a good idea to find a good place to stop and
leave the rest for later.

>  * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
>    unimplemented for -L.

It would not hurt if these are omitted.

> Michael Montalbo (4): line-log: fix crash when combined with pickaxe options
> line-log: route -L output through the standard diff pipeline t4211: add
> tests for -L with standard diff options doc: note that -L supports patch
> formatting and pickaxe options

I am not sure what this bloc is, but it looks like a reflowed
version of the list of commits below?

> Michael Montalbo (4):
>   line-log: fix crash when combined with pickaxe options
>   line-log: route -L output through the standard diff pipeline
>   t4211: add tests for -L with standard diff options
>   doc: note that -L supports patch formatting and pickaxe options

Let me throw in a handful of names found in the output of "git
shortlog --no-merges -s -n line-log.[ch]" on the Cc: line to solicit
help.
.

