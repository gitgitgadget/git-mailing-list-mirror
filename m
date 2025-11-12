Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FF2D662F
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973786; cv=none; b=aoCwA4iyo2HV71W0u9dQVh5xPtsy80pe70Twzlp0PXQmICaFBhl81igbilxLdFr9rE3+7RjiR9J0R/X+fnioACynt++pXwn70oBcEOkKx/w6APy0iWGAfGP6psB9ISGJWbfjWQnlROaUvYFM2LaS4k4Eh4lGCqB3awsPoNTp0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973786; c=relaxed/simple;
	bh=4HQQgjTnolah8WlFyiFnn39kycJ22t9w3bBnm9nujVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=InyhBWIfLGYHfYeGLay/hhi31YUfahTNQZCZDvSCPXdRqk/jrFkBcVGbzYduyxZEcyurL12AKBG5HSV6g1PNIbsVY6tCq2YBTkIcaG7WYcyTxayYh1KMopV5B1uFVBlkbggpUzxGR+evGHIZ7qCSGdrqK0k9kLQ+yQhQfVdChmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JKmizkAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qLBAFBwm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JKmizkAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qLBAFBwm"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EF67B1D00133;
	Wed, 12 Nov 2025 13:56:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 12 Nov 2025 13:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762973781; x=1763060181; bh=XqAu5GuwvG
	NLSntfYkE+Y3fSpP87Qv8Zndk0A/gqBs0=; b=JKmizkABMdrrbbBdmu9UYTwN1Y
	ta2h8Jy/nByAYM/IKgUqfBFRVc4mZXmxdm9FKrzGmpgRkvjrdhSPKk12qGgdAv9A
	hUeWKsOI41+7Br3WxWSFSdXpiZnHdFKI7dfdb9581pDU8Z9YZWji4FBoi+FQNJNm
	c9DvWnxvAhgV721pxpu6FYjiHN4EZT6pDbf3F0YcTrNqjv0jwFuBaxY32EcHAvqA
	jFgX0IBl3jOqXIS2meyl/O2Hc9hLIah8y+T9yNFx201JgFBv6mid0veonqPCFZT6
	R9RXA8fr4wwkV5oC95NxVzuxit013mtnufdyjw0dutOCZWfxvK6U2cNdtcww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762973781; x=1763060181; bh=XqAu5GuwvGNLSntfYkE+Y3fSpP87Qv8Zndk
	0A/gqBs0=; b=qLBAFBwmskaUnaZyWrfLp4Uxd+ABNBjmYIkbUeSfIRISBBbibCb
	f9GZAsNwgza6J8/nQadKdDloiLY5yucCVsBBrFnoaoOIxIzp4Zdc8EFM67078tPw
	B7bLJbgL1iBIOlqE5gtZzhPrv9fUMw8AX7CeWZG0V5SLvWItQ5VczjOdSHZfVgdY
	jL+mRBYjaVqz/LMhjEnfpnCYCdu3Jx/Ka/7RwlnDqZGfUTB1+4Omo2bwRR3POdZW
	6Ik0te7oqeFWaTkukWFC4pJMzv3huglHqtqmS/oon++o89VBLXUeF2lmoL/Xv5ST
	QuaCpqIiop5G/VdpdZLXOTJ10B3ZsHZs9AA==
X-ME-Sender: <xms:VdgUaRRhMUa69_lwlSt7aCnqn8VF2Lxyf2r57XLjUYnwe2gizebXJQ>
    <xme:VdgUaZ1IF6X7DaaYvtGT7ePqisO5GIS6AfYVJCn4hZxsQ1Oj3IlVMv4uQttF6XYSC
    Quc0jRigOvQHV7k_4JHQvLcCE16eLUdY47-6_vB8So4dzpWppwL>
X-ME-Received: <xmr:VdgUadC2b-AePGYIKE2Old3eX3SrN139xu_jT295Fu36LAyOZaHSQNCPItaeoVGvzXZEzdF8dj18YM6qQBwuufGY3cXi5h4gI5aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htoheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VdgUaVjUeEoAkq8WtjwOCSh53FNwobPG8LLNyTVEenFkfWJXsVh71w>
    <xmx:VdgUafMHmH0C2lICO1zmn8ICczHVkEWnPgHHsP3LDMqjg2_HTxs4Dw>
    <xmx:VdgUaV-ym_-SZH1EFipK_MnO1YcHGmscRaBPlKtdoowlM_iY5u3qOQ>
    <xmx:VdgUaQed4wv_q7kLbzHoFpsG8aK_bVVApdJZW6B9IVfL8DctB_1qbg>
    <xmx:VdgUaZUjfiw932vEI1F3IVEaGlbZQO4XscmGhewH-ty_GHkAzUVmD6xp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 13:56:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH v3] commit: add --committer option
In-Reply-To: <pull.1997.v3.git.1762966535495.gitgitgadget@gmail.com> (ZheNing
	Hu via GitGitGadget's message of "Wed, 12 Nov 2025 16:55:35 +0000")
References: <pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com>
	<pull.1997.v3.git.1762966535495.gitgitgadget@gmail.com>
Date: Wed, 12 Nov 2025 10:56:19 -0800
Message-ID: <xmqqfrajqdv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`--committer=<committer>`::
> +	Override the committer for the commit. Specify an explicit committer using the

Isn't "set" or "use" more appropirate verb to use here?

We already take the committer identity from multiple plases, like
user.{name,email}, or GIT_COMMITTER_{NAME,EMAIL} configuration, and
with the patch we also take it from a command line option, with the
usual precedence order (i.e., command line trumps environment which
trumps configuration).

> -static void determine_author_info(struct strbuf *author_ident)
> +static void determine_identity(struct strbuf *ident_str, int is_author)

"is_author" does not sound grammatical for this case; if you are
giving an ident of an unknown kind to this function and supplying
another parameter to let it know which kind, "is_author" may make
sense, but not here.

As you will convert it into WANT_{AUTHOR,COMMITTER}_IDENT before
using anyway, why not let the caller use the "enum want_ident" to
tell this function what to do?

>  {
>  	char *name, *email, *date;
> -	struct ident_split author;
> -
> -	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
> -	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
> -	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
> -
> -	if (author_message) {
> -		struct ident_split ident;
> +	struct ident_split ident;
> +	const char *env_name = is_author ? "GIT_AUTHOR_NAME" : "GIT_COMMITTER_NAME";
> +	const char *env_email = is_author ? "GIT_AUTHOR_EMAIL" : "GIT_COMMITTER_EMAIL";
> +	const char *env_date = is_author ? "GIT_AUTHOR_DATE" : "GIT_COMMITTER_DATE";
> +	const char *force_ident = is_author ? force_author : force_committer;
> +	const char *param_name = is_author ? "--author" : "--committer";
> +	int ident_flag = is_author ? WANT_AUTHOR_IDENT : WANT_COMMITTER_IDENT;
> +
> +	name = xstrdup_or_null(getenv(env_name));
> +	email = xstrdup_or_null(getenv(env_email));
> +	date = xstrdup_or_null(getenv(env_date));
> +
> +	if (is_author && author_message) {
> +		struct ident_split msg_ident;
>  		size_t len;
>  		const char *a;
>  
>  		a = find_commit_header(author_message_buffer, "author", &len);
>  		if (!a)
>  			die(_("commit '%s' lacks author header"), author_message);
> -		if (split_ident_line(&ident, a, len) < 0)
> +		if (split_ident_line(&msg_ident, a, len) < 0)
>  			die(_("commit '%s' has malformed author line"), author_message);
>  
> -		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
> -		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
> +		set_ident_var(&name, xmemdupz(msg_ident.name_begin, msg_ident.name_end - msg_ident.name_begin));
> +		set_ident_var(&email, xmemdupz(msg_ident.mail_begin, msg_ident.mail_end - msg_ident.mail_begin));
>  
> -		if (ident.date_begin) {
> +		if (msg_ident.date_begin) {
>  			struct strbuf date_buf = STRBUF_INIT;
>  			strbuf_addch(&date_buf, '@');
> -			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
> +			strbuf_add(&date_buf, msg_ident.date_begin, msg_ident.date_end - msg_ident.date_begin);
>  			strbuf_addch(&date_buf, ' ');
> -			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
> +			strbuf_add(&date_buf, msg_ident.tz_begin, msg_ident.tz_end - msg_ident.tz_begin);
>  			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
>  		}
>  	}

The helper tries to be generic between both kinds of ident, but we
still need conditional that says "this part of the function is only
when we are looking for author", which is rather unsatisfactory.

Also why do we need this much patch noise, only because you renamed
one variable?  I wonder if it would make it cleaner to move the body
of this if() {} statement into a separate helper function, leaving
only

	if (whose_ident == WANT_AUTHOR_IDENT)
		set_author_from_message(&name, &email, &date);

or something simple here?
