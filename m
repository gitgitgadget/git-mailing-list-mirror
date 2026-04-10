Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE51CF8B
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837707; cv=none; b=Vr5bL/oZEOyJ58sjObwncgg/ZguGOCyrQU1DR1usVeOGdnR7tmEIJM8FfXsvpunc59MVbUwW7p7kQusXuGsvkhr8L75fDRyEMR6jo2BY+CtM6OsQJOieEVOZ7YaQa/svrEKJLoEhzVQzwD9STYYJgOcwegutiSdgvDoOxz8mz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837707; c=relaxed/simple;
	bh=t8lfUEo5koLCEByKRkJW0noGwabJ/xY77HD5qaE4DgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ub/bCgkhlDSl9iVesZZXn728Ez3Bs6T3wCZSLoek6cU7mkMhGozZRq2FJw1jH/D6Sh2q2vM4uksnMIgEBHAibFLNBza8+yaCvuTlMbczxx+wwa5fHWPqBWPnmDvT2fJSLugETjdFze/TAubVRFhK4OtKmxOlZJsn2867e5VJcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u2CA62lb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VGxilJC4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u2CA62lb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VGxilJC4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DC961400173;
	Fri, 10 Apr 2026 12:15:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 12:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775837705; x=1775924105; bh=32QLYlDE2j
	Cezr5WvK/N9l/52HG8h7YKgnF1pMhrYt0=; b=u2CA62lbtuL89tYq2MTmk7OaeB
	nArabdck4ojaZeAtolRukDeJfO5pMyacPrSnR6mRz1a04P5ruPEOQWT90cg781Th
	Y+GZ7lJ0LorvN4OH1Dbq+6/GWyuQbZphNByN//QU++5JDR23cL0Vv2QBEkJdbIUy
	SO1EomRZCwBPPLHrn2arE8fePq5F1hZ0JVcGz+WMNLAeh3RzwD7k+EFIUe337+xA
	gNMcUTm5V4w8Z6VoPHkZmlgGYHl5/aGP2++EDL/0iwFXTFsYTmrW1v/YXQSbj3+C
	N2tH3SBKjHXqJVy/1XH3z7Yc6SchTNXvrZ4Tarih3rvNbYBsP/3c90F9mJJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775837705; x=1775924105; bh=32QLYlDE2jCezr5WvK/N9l/52HG8h7YKgnF
	1pMhrYt0=; b=VGxilJC4p+d2ALIZ3gx21drHRmkrLzpQ+oHBzH5KQImGy125cMK
	4nUQ2IVtBmRRhyg3ki/EdQoZ3N5Onv+c8Yhaw846q4p6axqrnqDrkbGnqTkM3jKZ
	XGVawGSMqrNuVA8jbJonJyHE/i+dFAtC6DwPC1YYuaysaH6Vjm2Qp8sgqCSbopOv
	E3dq3mbXX++sI622SJg6jkgzOx5LCRPFKqL+bvSTCud+p5CFh+BZsgm5+NMX/G6X
	qX+FBMrDuAKAn+JuelgmENzrU1MkdblTTOd6M8SbzjWLniLleGSiANy7TaR6L1X5
	+YTT416uavb4iBLU8VslOySgjaTqFtpCd6Q==
X-ME-Sender: <xms:CSLZaaeZNXZwAjuYM5C1u4fH8wV_WbToM6rzYAGP6KjH1sg-PaIBxg>
    <xme:CSLZabFc_w-CdfjwjEgFZJ4t9JIMIfYJISoTQ6eyH-90A1gfxdc25Fh6qiIKORDzZ
    G-IaGMXVkFhC6zvJ2qxlf6XgrF1w5E1-ilXUx2d3fJsAW3CV9G6fA>
X-ME-Received: <xmr:CSLZaT0QQNGmtbzTILXpx1WSgM9W7NhZW0fbAYccUx77Tzv9sN3xTtfuMImT44FKfo0mgWh34tPysTn2d_HZ9DFd8k6OmOwfUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CSLZaTniugpCfbxJfyJaGEarGMw-l95XJyM0_Tqu01y4Q_B5V9m8wA>
    <xmx:CSLZaT9Fc6h-mfGgT3palnV2V5ppcN9NaYKmI0EXOS3y9V_xJa22Fw>
    <xmx:CSLZaYpvW8UEgTQ56skNFFGB9iaqTIL3nTsV7g1Wj0mStqX2nLwe8Q>
    <xmx:CSLZacnBlQNmLt7ka_Gim4xe8PJzt67QwDbj1rMy5uDkp7aATNG3TA>
    <xmx:CSLZaa3lm09pBXszNqypF8ZlIAW6mites3zVYJSUuGbPMI7Qd9v72vwi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:15:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 1/4] stash: add --ours-label, --theirs-label,
 --base-label for apply
In-Reply-To: <0d1c7bf2-6404-4779-a0d6-6db592510a04@gmail.com> (Phillip Wood's
	message of "Fri, 10 Apr 2026 16:39:14 +0100")
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<8fcf3778205d4742a56ed2e4c3b97defa21a1538.1775762235.git.gitgitgadget@gmail.com>
	<0d1c7bf2-6404-4779-a0d6-6db592510a04@gmail.com>
Date: Fri, 10 Apr 2026 09:15:02 -0700
Message-ID: <xmqqik9ypzax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +test_expect_success 'apply with empty conflict labels' '
>
> Why do we want to support empty labels rather than making them an error?

Why not?

There are applications that do not require, and prefer to have more
stable output that will not be affected by UI updates to improve
human-user experience.  Even though rerere database is not populated
with the facility this patch implements, we can see in

    $ grep -C2 -e '^\([<=>]\)\1\{6,\}$' .git/rr-cache/*/preimage*

how having labels make the output more noisy, and more importantly,
will make it misleading given how rerere is designed to work,
treating the same merge conflicts in both directions equivalents.
It is not a huge stretch of imagination that our users will find
similar needs, I would imagine.
