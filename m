Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF2374E57
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442325; cv=none; b=iwuChiTNg4yRNewACL83GEnVPq9pclsKILDpqIQ0DpHVBUOXoK0b/qvXUe1twL1eAWViPAKGwa9fcgXNl6NzymMtV49BGOQLByj+pMevkPmYb8rFc2VSgwZLnUZQip7eMjidgpj0vuvIs9R+tHaq8XKI4blfIMZN5VqDzLKgsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442325; c=relaxed/simple;
	bh=dSEjt1ex5A5Sk05Pg8c22dUb9NXNxX2WPzCNaQb2/b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aTT6kGUiSQnPA8EkQWwboRh6lzy232WWWQtrE7uaKy2MUW7JLVjzy1RpUlOs733PKvkfD/VvgItzzz7OawRh+B7VU3kndTSkwpFSFQFnrhfGki3RJxMs/wMvy8g82dcf/VInAhDRMuKSdgVeuySocZlwytEOvhhd3C+hDk9uOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JGkXPUHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w7Lhrqh/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JGkXPUHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w7Lhrqh/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B1AD1D0000F;
	Fri, 13 Mar 2026 18:52:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 18:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773442323; x=1773528723; bh=YnHXKLTxzD
	4vWzq+XRIHKBLdeLJ1UAKBReZkklxDGE0=; b=JGkXPUHC8IXZtb6w4Onf1ZkFfa
	oue5JWm5UlFv/6dmpCLxL/ea9skrVKPap1OTqXisZWyFDEZtZO85JV4f85VLRq62
	GNwQuT8AKK9eHd0nT5t2SXdmSF96avENA58dDmLfgCHzGQ7E90WCt2ewYUI0e+7r
	t+aDu79UtcHkMKmWEf9C0utrSvUqbSRwYqLTapy1ixH83c29DfziPB4hFXZ+oplU
	4CZ/ChjuqhI9zGRoktnCHSYwwg4vwTdxQS3mQEg3N2lUDbU+uN6NSyeQ03LdJDFA
	AFr1nLBoUGCzCmC1Dz9NAfjbXev8Y0thS7lvqB1h7YlamzWawUuOCrZ1LDGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773442323; x=1773528723; bh=YnHXKLTxzD4vWzq+XRIHKBLdeLJ1UAKBReZ
	kklxDGE0=; b=w7Lhrqh/weJNAhqgbnHMKfCw6pcCO++MiWNDgQe9kcUWnqJz4dk
	ixLgsYQ9m2rhpVIPc0ro45zGDE4qNHikdkbeZf+okoBO6qxzkhLbO3cd+Va+EkBs
	GhDvFUhwFkwAfUlwdN75iAmyEBcI0hmP331vy3ujMLD3mlCahvO5bGJpcWRQL5PW
	lQHiYMYv5HbMHVspxnnOInTr7+J3qzBneD26ktm5A0v8IjE1NNzA43LkQx1rgdUj
	jg9zpBS6qKzpSHPhwkyESSVSHFj2SbCCnvAcSg5m5Z+rwHEp2RoET0Q5MNE1CAiR
	hBN2DFFwGwnMcI/5K1SZTEcNEqmAbK16LCQ==
X-ME-Sender: <xms:EZW0aT-WasofgLzRiKGyJ4UsXbVOOA2_scIa6LqKZBkVdZogF8TQ2Q>
    <xme:EZW0aZzyv2hJOIe3XtH9-jTr4RQiL9Dv3NMfuhV3zitotg8KMLD4R1ShG0v5GTAWe
    Fk0dsF0gzHDRBJHv7dE1FCCGLCSEM7uSeBXe78zOQaoj6g6npXA_jE>
X-ME-Received: <xmr:EZW0aQ7QXHGzv0fsl_g28x8T86anBms6lInm0E-RDyNfw_gecxqEzJZJiQC1r7RBkZXelWwKQT_D6hetpOKdOoV8_WXyBTIGIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnheshhgvuhhsvghlrdgvuhdprh
    gtphhtthhopehgvghorhhgvgesmhgrihhlrdguihgvthhrihgthhdrphhusgdprhgtphht
    thhopehlihhsthesvgifohhrmhdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrshhkodhgihhtsehhohifughoihdrlhgrnhgupd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EZW0aQ8lwiZoX7AQ3wx5tFtXRMShx9Pd6k11JyhEzb5PBMY5sXMI3w>
    <xmx:EZW0aVr_Va3UNYyaDNg-7lOqEgzD4bfLvfrZQHGXIryQFpWv-PYdtw>
    <xmx:EZW0aRqz6fgHK0eyfF4LjYIMQnr0-Ai3Ja4IkhojxURe4ka0lLHeAQ>
    <xmx:EZW0aY0socJqSW92wtXdTG7EMrulu8pLPGQPvCVfhxRRcSgYkG3LcQ>
    <xmx:E5W0aezix8e8bhjugPiRqOhulhjCaGjUcmXUWAQ70kbzaoNdAzBcWhYB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 18:52:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Heusel <christian@heusel.eu>,  george@mail.dietrich.pub,
  Christian Hesse <list@eworm.de>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	(Colin Stagner's message of "Thu, 05 Mar 2026 17:55:46 -0600")
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
Date: Fri, 13 Mar 2026 15:51:59 -0700
Message-ID: <xmqqldfv1gxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> * cs/subtree-split-recursion: when processing large history
>   graphs on Debian or Ubuntu, "git subtree" can die with a
>   "recursion depth reached" error. Reduce recursion.
>
> On Debian's POSIX sh, shell recursion is artificially limited
> to 1000 calls. You can check if your sh has limited recursion
> with:
>
>     #!/bin/sh
>     recurse() {
>         r=$(( r + 1 ))
>         test "$r" -le 1000 || { echo OK; exit; }
>         recurse
>     } && r=0 && recurse
>
> Depending on the history graph, subtree split can recurse deeply
> enough to encounter this limit. Rewrite the rejoin-deepening
> algorithm to reduce recursive calls.
>
> ---
> Changes in v2:
> - Rebase on master

We have seen two iterations of this series without anybody
commenting on it.  Is it a sign that the topic, or possibly "git
subtree" itself, is of interest to nobody?  Or is it that it is so
well done that nobody had any comment on it?

I don't use "git subtree" myself, and I do not know of anybody who
will scream at me if I break it by merging an unreviewed patch, so I
can merge it without worrying too much about fallout personally, but
that is a tad irresponsible as the maintainer ;-)

So...?  Any volunteers among those who have a higher stake in the
program than I do (which admittedly is not a high bar to cross)?

Thanks.

