Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494964502A
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699829; cv=none; b=s4ORGFhRGrZJANvm3qK6pCX/S3Do/zlxs87JI1g8ofl0isYZ1dJGd4ihaSxFq5uaLJbdgJQLUQa/cAYsgecZ79NYZ6RDvo3yGjGz0G+dAaBhBUr2cBkgcXTEXk7MSS3L3cH98geJMBMAFq1TYnb3Y9xJkPFe8zE87znPKfjlsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699829; c=relaxed/simple;
	bh=nwL1YH6eqRTPrgiLyJZ+dClBtD65CtYX/ERD3vlhNaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tUijPZGKnoLxjQU293dpxbRrrR5RhnL30XVITBhIKeB60o4zxAOOn+VNIOfVnOobMVTpD7izoYTQDRvpK/cNyHCCYO87GHQKsSMh9/Ws0cOG/awcZT/ousIJmpYFmT2UK9tT2PjCyZ4gRtnWQa/CEiXZXDDzRYhgeGRweHWmF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kehjxyp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSQR4l2e; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kehjxyp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSQR4l2e"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 677E31D0003A;
	Sun,  5 Oct 2025 17:30:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 05 Oct 2025 17:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759699826;
	 x=1759786226; bh=Mf8lQwYaiC+JQgnDP0tZKe08f976nWgJCyIAlsGjfdo=; b=
	Kehjxyp6f4zJo58x1Dgc9EZgIoiPPqC/GTcoFCu6QaC0qN8ouE1gCrdtIIaZANkr
	PiSHobVyzoLqL9a5kRi8BVKQ36Wv6uPS+Ag0E6YS+izSXkJjbk3bHcEaRb1Hc7Lj
	LBsOlHm/RWDnLZtTKOjaOSihWMiTtZqv088nejaOoWUlVGgSMfhYp3sFt8j7mE7g
	deqX6DnJXO/p523Oon75QD2FutfkwT4bSLOQmIUCh7E9S+VdFqP4GrU2qIkVIrvo
	gwYl3zg02KFrylq1b/gphHYaA2SAWMUN1hghKFfHeF/xtmwXKMW0wqHzZPnnkCE/
	RkBrsS7bjYy9+bmPCs4NHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759699826; x=
	1759786226; bh=Mf8lQwYaiC+JQgnDP0tZKe08f976nWgJCyIAlsGjfdo=; b=d
	SQR4l2e1Q6hBbYS6xezhWYQaBJ1Vwf7/+wsdQYZ7M7PvD4i2ilqnFtnYkG4z/l8C
	MqIjB/fYIZWBjdeobNl1MvJ9EaIv62GN0a/hhYmBM+jxy6D6+OQK+qIaOzX6ciK0
	AyFJ0UudWpzJs17Q2uk6Lp/wRLEQqC5Pr7ABMY6tyU7Kv7O++Arw1Qqdn7bUz8vL
	4FBKCcHXc7VxdPY3vgwtWdPFLCKouMGXiQLITq5lKXoyeBOn2CM7teYPnapY/FfW
	ZN9868m2MKGIndDcBGyiRbM3WbhY6FMAzH2ZhAGgKdI3JiaeTYkW0mHgY2OWjncK
	9QAcvNC3ANQqHxDqAiP9A==
X-ME-Sender: <xms:cePiaEVJschkHN9gc_Ik4OhMbEl7qZfLtRuHfNRE1gs6mye0IsrC6g>
    <xme:cePiaFvtAVKQ7GaJg4HqWbR8T2TJ9NjDAZuuVbf7Rk4Niht0nC14WDIjirPL49WU3
    2XaUnvGoeEXKDLgwrxvYrQdS5B9xJR4x-0i-6vLFXlqSBlPV5xr-Q>
X-ME-Received: <xmr:cePiaHYr8mNUXpCtQx5sMxFS9D6KhENkOArBvC0kbuvqYSYaYb1t5V8kL3hqCB0Vj6hZ7qrqshp21qGxcJJdWnGVYp8mIvZuaCRf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdifihhnughlsehu
    khhrrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cePiaEXNKdxnF-R9RedTQ_ye3GSc6aUM7Ax7SbZ2YwQ752EUc_O6Ug>
    <xmx:cePiaMSlRVV4vBnmSV7sWa0foWmv4hsU-OY-2Q6vTAO-ezf_DRz_pA>
    <xmx:cePiaCMHCfPjO2k-bwBI4zUGUc2gixCzj5sN6gifb3ilE06d9oPPJQ>
    <xmx:cePiaKTrcmkFgKUZYIjZEyRllotqF4qIQKXUMRSXtlfT9VTskijlag>
    <xmx:cuPiaFJoyS_8B_QIvLVbNhuRrwYCjn41pY13IDtccRAt3YC26hIq4yea>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 17:30:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "Windl, Ulrich"
 <u.windl@ukr.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/5] add-patch: improve help for options j, J, k, and K
In-Reply-To: <75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 5 Oct 2025 17:55:10 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
	<75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
Date: Sun, 05 Oct 2025 14:30:23 -0700
Message-ID: <xmqqbjmlrq8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> The options j, J, k, and K don't affect the status of the current hunk.
> They just go to a different one.  This is true whether the current hunk
> is undecided or not.  Avoid misunderstanding by no longer mentioning
> the current hunk explicitly in their help texts.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  Documentation/git-add.adoc | 8 ++++----
>  add-patch.c                | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index ad629c46c5..3266ccf105 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -342,10 +342,10 @@ patch::
>         d - do not stage this hunk or any of the later hunks in the file
>         g - select a hunk to go to
>         / - search for a hunk matching the given regex
> -       j - leave this hunk undecided, see next undecided hunk
> -       J - leave this hunk undecided, see next hunk
> -       k - leave this hunk undecided, see previous undecided hunk
> -       K - leave this hunk undecided, see previous hunk
> +       j - go to the next undecided hunk
> +       J - go to the next hunk
> +       k - go to the previous undecided hunk
> +       K - go to the previous hunk

These obviously make sense, but I wonder if y/n should also say that
they not just make a decision on the current hunk, but after doing
so they move you forward (and if so, that may fall within the theme
of this step, which is to improve the help text on options).

