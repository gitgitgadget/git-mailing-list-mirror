Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F735CBAA
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895149; cv=none; b=mg90qJCTqcH3jrymILrkuuOUeJNt91MN6X9kMtb3ekb2oTPOrdarV3ar1BiyzoRXV/qtxjvhylD068asiyvbVLqnedotE0dP2dcOFWjcKQtgFyC2yq8poZguzUp8KNV1lrkO0LPexYapUfoJD+zbgOJQoLsMKJlXUNP74lMnkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895149; c=relaxed/simple;
	bh=PfyFzZizIXAU+aOqYZLgmgCCjhhAp+ROa0Ls/f0KJaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BxHXkZdUqHG/5k9pKCnYt1k95A/kJB5MxaFSEA28xK5jw6q/D0eCduhWcB7yrObQoyvlczSoLI9Qy/GhFGyYNDPpzg5Tc3Q8jbBpo9S6qRgwKkLBwUs5PEzXUsEyMeCgH9DFA4h+Q9cTlGoP3daQ4KMYbpohgQyOgMfJIXnVZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=izB3CrcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EX8kdpU/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="izB3CrcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EX8kdpU/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A4DD7A0100;
	Tue, 11 Nov 2025 16:05:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 16:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762895145; x=1762981545; bh=TcudRawjLp
	IvPByRPl4EYRT2zJTcOuLr1mgtSGfMqiM=; b=izB3CrcPTz/5SYpvepkGtIAqVl
	iVUeGhthMeVSuAf2wnKB5gZvfFvI+wIt235n+rf95G0gDex4zAE+vf7sCwEQsxjg
	xISwEMrv3VnSZdO8pWy5EVG9QqN/RKFMeZrJW+6NdNdQlaMUf63NSo7qicLIJXGw
	XqdY8H7nGqVMlZyniPcSV+l7gomBj6CvH2jamuWN9UZz4mYdu+RHUDfeLTtFv+0W
	6zXNlAjFotinsIXLZuSCn9X3Q3fO1n7Tdv1bXxqkioIJrwR0UmaVHPD52EjgxQcc
	nASopBSLgO0MNDqNkSLsOYd3lhia4EhV2zBfgIfLGNgi+cmPyPhrOtVCOHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762895145; x=1762981545; bh=TcudRawjLpIvPByRPl4EYRT2zJTcOuLr1mg
	tSGfMqiM=; b=EX8kdpU/Yga540c1Sr+zsoiwYFjfgKVCjU7QtVwW06or3yLIU+F
	izNjSAPrkVbAxru4c2dUxZnhuEtKPfnuMaWWCiBU9P1r/M5UVnDv8sgFBVOqFHGb
	ZF1KOrHtnnZmK8oZm7B5IyyMaEAGSo2ykNzJx4xKRT7ixHxS+95KrHRUOg98IGVB
	9jX3BlJYA9gbIJFhhmOyFNrODZlh3KzPR1mjJAiVqJlM7gftBxpS0PCzGiYrI3gJ
	z2LBJnPC8pLp0kcWzBdCIHv/0fNR5B5BbGU2Z90EqrVwKY4EkhKPz3PITgnde+HE
	xTDxGb/+Kxax9ocVmiVyqfqb1ElsuCy/tFA==
X-ME-Sender: <xms:KKUTaZPzHCpFuhWCeg1ulk5TfV-gyJsKQYnyJsmOOmRDGUH7Aq5dTQ>
    <xme:KKUTabDCFoWDUkYYLx7t03DlIWe0xKA-TRWB7yoS6dM1IZ5uYHtkdQpOMQwo3-4hl
    PNioMFV_z3SrgcxZD9ImuJOIbhKkO_gjEYXBNlITkKk02BkycauESk>
X-ME-Received: <xmr:KKUTaefCZ8sodRYPYtxkIieUMaGY3FgceUlY_4QrNRKESXQUtVC6mC5Slyzxra4faw_qkM3zmAIov3mJHvCMHZ2Uew6cbZ_S1mnV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KKUTaSOkJkicZQ2WJLII-Y_vbMmsVMeWCJ0IYSLnj5Duliet4doQHQ>
    <xmx:KKUTaWLjbUKq9aojGFEDHOwhZY9GYFIWIND_W2VNVXQpt_DMHejxew>
    <xmx:KKUTaaLaI34tTSKdnrmkBfXM9O5DKcXLAxfY2TOcgXrfTp-DX9p5yA>
    <xmx:KKUTaY7zzHfZyC0-nlv7f7FcwHyyBdd8vRQlXd5QQc7EHKTkjVBosQ>
    <xmx:KaUTaYuXlXPzTxfayLCbxrq_XmNWCp7somr9lApaaTiydAXdxxGgWEv1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 16:05:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 01/10] doc: define unambiguous type mappings across C
 and Rust
In-Reply-To: <e5d084d340e874be52e7c3b056ada15ab5557877.1762890152.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Tue, 11 Nov 2025
	19:42:23 +0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<e5d084d340e874be52e7c3b056ada15ab5557877.1762890152.git.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 13:05:43 -0800
Message-ID: <xmqq1pm4wa8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/technical/unambiguous-types.adoc b/Documentation/technical/unambiguous-types.adoc
> new file mode 100644
> index 0000000000..6bca39209b
> --- /dev/null
> +++ b/Documentation/technical/unambiguous-types.adoc
> @@ -0,0 +1,239 @@
> += Unambiguous types
> +
> +Most of these mappings are obvious, but there are some nuances and gotchas with
> +Rust FFI (Foreign Function Interface).
> +
> +This document defines clear, one-to-one mappings between primitive types in C,
> +Rust (and possible other languages in the future). Its purpose is to eliminate
> +ambiguity in type widths, signedness, and binary representation across
> +platforms and languages.

This is a laudable goal.  It does a lot more than "to eliminate
ambiguity" at least in some sections.  The section on character
types I already commented on, for example, is full of good points to
list the concerns that developers need to be aware of and careful
about.

> +== Enum types
> +Rust enum types should not be used as FFI types. Rust enum types are more like
> +C union types than C enum's. For something like:
> +
> +```
> +#[repr(C, u8)]
> +enum Fruit {
> +    Apple,
> +    Banana,
> +    Cherry,
> +}
> +```
> +
> +It's easy enough to make sure the Rust enum matches what C would expect, but a
> +more complex type like.
> +
> +```
> +enum HashResult {
> +    SHA1([u8; 20]),
> +    SHA256([u8; 32]),
> +}
> +```
> +
> +The Rust compiler has to add a discriminant to the enum to distinguish between
> +the variants. The width, location, and values for that discriminant is up to
> +the Rust compiler and is not ABI stable.

Good example, as we already do use this one, if I am not mistaken
;-)
