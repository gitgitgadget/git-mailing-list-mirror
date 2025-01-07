Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A941A83E1
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291466; cv=none; b=cz/5SU2laa6hLTzfYkihGoSL8g1iqi53YnuH0MvfQclltvOT6PaxitvuDmMxBaXq8CwamajorRdSOeLnYQLs9WKpY8EQAlDAYPyPxPDMdp32ay7uXufzYV5WQEt6JvhSOYixjMntFbeUdEwkaCDT/XuHfqA3lxioGYuCseO+7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291466; c=relaxed/simple;
	bh=5X/mjojQ5amMqYLWwkayTepua2EJmeNO9ACqCYOFrZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOHOigRGqAsVezg8QNlUaRjK1jEQWXySHP1nYHaggS/WadbFWNL7WOmk5M3yffl+SzKapRPX0bHi3HITH46tbp76bvhqDJWTHbscQqL/dgRe2CJFQTynmNXbfnCnD20w3DkgU2K5USWpUwbPn5cmVWqlSvLMM67V8OYHiSxrd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4nfYioG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uitk1wyG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4nfYioG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uitk1wyG"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61A2B11401D0;
	Tue,  7 Jan 2025 18:11:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jan 2025 18:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736291463; x=1736377863; bh=1mYYHMfgWF
	afT1Xk6w3NuR7F58K57v0WA2sQrTS6kow=; b=D4nfYioGKVeO7cebA+Fr0nSgEM
	kuanrBbEvzK7g+oQOE4/PRuXG02+FXfrbGNE0nwIJIg9ALlLGsfXHJa5t5gd9RRl
	r9i4qTMrU0gYeBCztqBymqdToE+YsNBfTU16vJSQlq8kVMHSoIeklJfQl72I8r9Z
	6CC610G17kwxqWOT+OqpiicMenkhczI0l5McYepMEwg456RQCkS7Vm885PWS02Rj
	7MMFy3XhXILG5zo/QWx228AYDOHrpGkGR9cx0F8V/2zxiwcudd1dXCmQRepkA5kW
	P1pHdQth2omNivdTvmLBCJ986EXVEeKG2EOcifpBiEanhMYNqCe89CbWtlrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736291463; x=1736377863; bh=1mYYHMfgWFafT1Xk6w3NuR7F58K57v0WA2s
	QrTS6kow=; b=uitk1wyGmSXHZBl7GItFNfikWYxl7W3+A2CA39xtYo9XRwjmRZ1
	BSyinLSFA6/e5QaHt/9mNaXReOEuEdDqlSPC811o5+HDT+EIpc0jeB/1jbGhMEOK
	ymvFB/ZcCDtkSgiVA6cccYx84nZRQIMO8il1zlEXycfM1EdkBlspS7hlmVcRHe59
	JV2SwPavPJfa+ott2tnTECGDoyJxqk4JDTSulbqfj1Stry+elixuN7eSHbI+a3HQ
	nFB+U8NNGwNpOtTeEE5In4C1n5JzlbIa/JpERaE364y44MuVn6RHOVLwYD0aCh4S
	rRVrb63RcxARtSVRBFllSkjZ7L7Jz8TEIhw==
X-ME-Sender: <xms:h7R9Z8l2tB1xkvWSzHCWkvngtOMsAMCT33lUYNEOE-ATGDl3CwDZRA>
    <xme:h7R9Z71F0d91kK9ghkfAlvWvAx3Gf6MyYjdshmKn6ZB2W0cxNa1qhmHoYHI5-vZS9
    P44n2IsrIIgWatniQ>
X-ME-Received: <xmr:h7R9Z6rXXniAsyMDfidrAbhHzIKhKZy0VzuC_H1SktsXGvypVk_8VIDMd76LZSXKY3xgfmwBOCKZ7kQl1YTHMOEOqpcF0Y38Jy-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhthhgvfihhuh
    hghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h7R9Z4n7v_fvZpHrZpEnvh2FyM28-91rRAEHNpwZcD47JhhGMGrhnw>
    <xmx:h7R9Z63zSuXcvsndRKrGRy2l9O_9HnYMH6jyoLWEH9FtM2X_3bWW0A>
    <xmx:h7R9Z_vKOSLKQgiza8aX9_jlZOLVuFXSgxkdOu6oHA6re_ek0ILgeA>
    <xmx:h7R9Z2WA-roqrJVABI-YmEAANhHBi6t2_0FmTKWEeuNyukWra7xJdw>
    <xmx:h7R9Z_x0dG9v_kLDMwQzLWVJTrTR_rWUXVSO-gCgBJI38i0sKqWkBiSN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 18:11:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] docs: fix typesetting of merge driver placeholders
In-Reply-To: <20250107212421.7yyvuzw4uqxnqv7t@archP14s> (Matthew Hughes's
	message of "Tue, 7 Jan 2025 21:24:21 +0000")
References: <20250107212421.7yyvuzw4uqxnqv7t@archP14s>
Date: Tue, 07 Jan 2025 15:11:01 -0800
Message-ID: <xmqqed1eqkxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Hughes <matthewhughes934@gmail.com> writes:

> Following the `CodingGuidlines`, since these placeholders are literal
> they should be typeset verbatim, so fix some that aren't.
>
> Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
> ---
>  Documentation/gitattributes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yup, especially the %P placeholder uses the backquote/literal
mark-up already in a few lines above, this is an obviously right
thing to do.

Will queue.  Thanks.

>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index e6150595af..5d12b78549 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1166,7 +1166,7 @@ internal merge and the final merge.
>  The merge driver can learn the pathname in which the merged result
>  will be stored via placeholder `%P`. The conflict labels to be used
>  for the common ancestor, local head and other head can be passed by
> -using '%S', '%X' and '%Y` respectively.
> +using `%S`, `%X` and `%Y` respectively.
>  
>  `conflict-marker-size`
>  ^^^^^^^^^^^^^^^^^^^^^^
>
> base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
