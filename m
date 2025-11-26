Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EF30504A
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176258; cv=none; b=G/QUSfcXjbi0ocbIuViu8N1oHir+WNjC4MnMhBzRqQy5m4y29L3rUa5o1J9N/y9MM/I3KQw7gW00Nu8mI1Pe/gbfgoozpKnT61tHb3cfx9KvDGqHm46QISbhaSOhMFhvMGu94qkgN5+T67tmf6VmfS/jC713DSJH/22kJBvdFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176258; c=relaxed/simple;
	bh=k4LmR/jdVs/JyHjROo/npt5BRZeEdFMKIcXKdbC2bo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMearOUO1Vq7+MdWkw2fRvwO0TKZy68icv2uKvuLEohVdPoTYGZsqM77baTU5d5plWbVWLbVujerWux/IPi3xIKq1rsmFtnkkNrKnSwCm17jF43HaL6B9ulqiZFkSEBg60NvmvdC1Dn6BT5MaTrjDPv7wfZ+VXWoVeQxBSK4Hn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XBlseRh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5K+soYJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XBlseRh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5K+soYJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B183EC0462;
	Wed, 26 Nov 2025 11:57:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Nov 2025 11:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764176255; x=1764262655; bh=BxASLklI30
	8FN2Bqdj28XveiN5330OwG3VslS5WXl88=; b=XBlseRh6vBb4XyOm4D+vGmqhMY
	C64fjP1qf+XYw6sSAN9vDq1EqWH27Jftcdgglr3HmKK4akZvxTrCwNUfqLpviS47
	E7iFs3OZm3G9gtzth5XnMqMV/ImILAgPvPcH7jKEzMgVSVguo0XwnpmTxQXHeWzd
	11KLFpSiMSGn0M8C05x1Sb594uIeiPc0bn3nnlsdZ+pQCl7i8jFjmXN4X/EP+AUW
	CZoHAnfqQbZe5ve9kK0L8cFka3lT7j9viIuVVaWl/M6FV30ur6XPEzyBrdCPqbA7
	i8RTIRFjxcosW+wN+kY9OleRV+WXew2WFFBESSbTOU1A+c21C5vFfk4QX+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764176255; x=1764262655; bh=BxASLklI308FN2Bqdj28XveiN5330OwG3Vs
	lS5WXl88=; b=b5K+soYJeyvxMWSi9kCLzqpOQbSdquvvqQXVt/9AE3om7UjfPY/
	ZwmoNIRx7z1zTjADIDwpBKS2VJteFNTL45uzzHtPSa5vnzHRH76OBsJpXHPcpAAc
	4uK1LXOdyVaJ4bEO1LQO6pOhQrf/Xcc15H0ut8WSDe4/TUWKviZ3qmknpmuOSFEX
	ZfOQ9AWIyEajFYYMoUh6xbXjlShsl+dRgpY8zNmXlwEijL1OsyaT67UdrYzDscJP
	Bx4NZ0WUR6Lmu6uJjr2WKIFzWTcJAUnwhta92w3Z8T5F+CeCQhbjhCEBl+c5ST52
	l/OTaHuk4vbCxBVM0McVLy0j4i/GXyu6OyA==
X-ME-Sender: <xms:fjEnaRiu1MDewOJkDY1T2II1rqd_mABi4w63AHPupxZ28Qh3Wvu_UA>
    <xme:fjEnaden6S7RFAzumS53GNO0IWiQVejm7nfr4sG1S6jpJ4gzP76QNuverZ00b1FKs
    3yAKtsPdmc7KjUbM8EmF16Om4WPJIR-oBQT3dCQM7ln2GRDPescuw>
X-ME-Received: <xmr:fjEnaeeo-UbSyCPWW-toF2t8WJ6IBQ5DgNmF79OXPX7KD6clDxLOImdxrr_PbwnnCy6mp9w7pxLaOx8x-YAYqxI0ubTSIQQYKBjS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fzEnaf_3ynXRVDMpE8IlEhL4Ae755l2bFQm5ujrzxBhaN0s8xGlhdw>
    <xmx:fzEnaSktsK1l-D2Koa9ZaPG72s2rhXthyrUVZyzyfy9nuAi_0MvMng>
    <xmx:fzEnaZ-R83a8eIjgnlCuqpxbVDA7xayl-7BPEiWURVfq_UrUlaN26w>
    <xmx:fzEnaYnk8Ahrq0wC9VWUe_0gTEkDc6UNtxbA2x66lzg9sq71Ppql9w>
    <xmx:fzEnaYFVc3XgEWN1QckFd4212D32DNmk2ldtXXBv630SRhPjLmrF-U8G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 11:57:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] last-modified: handle and document NUL termination
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
	(Toon Claes's message of "Wed, 26 Nov 2025 07:09:43 +0100")
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
	<20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
Date: Wed, 26 Nov 2025 08:57:33 -0800
Message-ID: <xmqq3460pw8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> When option `-z` is provided to git-last-modified(1), each line is
> separated with a NUL instead of a newline. Document this properly and
> handle parsing of the option in the builtin itself.

I think documenting does make sense, but it is not clear from the
description why it is better to handle the option in the builtin
itself, instead of letting the setup_revisions() take care of it.

Is it because after the command lets setup_revisions() to parse out
the revision range, the command does not really let the revision
machinery drive diffs and let it output anything (hence, even though
rev.diffopt.line_termination is set from the command line, the calling
builtin is the only one that pays attention, and the revision machinery
and the diff machinery called from there does not pay attention to it?

And assuming that this new division of labor between the revision
machinery and the subcommand makes sense (it needs to be explained
better), the updated code does make sense to me.

But it looks suboptimal.  See below.

> +#define LAST_MODIFIED_INIT { \
> +	.line_termination = '\n', \
> +}

You have to introduce such a non-zero initialization, only because
you pretend to accept _any_ byte here, and use it as the line
termination character.  If you were porting Git to ancient Macintosh,
you could set this to '\r' and it would follow their text file
convention there ;-)

But ...

>  struct last_modified_entry {
>  	struct hashmap_entry hashent;
>  	struct object_id oid;
> @@ -55,6 +59,7 @@ struct last_modified {
>  	struct rev_info rev;
>  	bool recursive;
>  	bool show_trees;
> +	int line_termination;
>  
>  	const char **all_paths;
>  	size_t all_paths_nr;
> @@ -165,7 +170,7 @@ static void last_modified_emit(struct last_modified *lm,
>  		putchar('^');
>  	printf("%s\t", oid_to_hex(&commit->object.oid));
>  
> -	if (lm->rev.diffopt.line_termination)
> +	if (lm->line_termination)
>  		write_name_quoted(path, stdout, '\n');
>  	else
>  		printf("%s%c", path, '\0');

... you use hardcoded '\n' here, without allowing the value of
line_termination to affect the termination character.

This is way suboptimal.  Instead, would it work if you add

	bool null_termination;

to the last_modified structure, and do

	if (!lm->null_termination)
		write_name_quoted(path, stdout, '\n');
	else
		printf("%s%c", path, '\0');

here?   Then

> @@ -507,10 +512,10 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  		      struct repository *repo)
>  {
>  	int ret;
> -	struct last_modified lm = { 0 };
> +	struct last_modified lm = LAST_MODIFIED_INIT;

You do not need this change, and

>  	const char * const last_modified_usage[] = {
> -		N_("git last-modified [--recursive] [--show-trees] "
> +		N_("git last-modified [--recursive] [--show-trees] [-z] "
>  		   "[<revision-range>] [[--] <path>...]"),
>  		NULL
>  	};
> @@ -520,6 +525,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  			 N_("recurse into subtrees")),
>  		OPT_BOOL('t', "show-trees", &lm.show_trees,
>  			 N_("show tree entries when recursing into subtrees")),
> +		OPT_SET_INT('z', NULL, &lm.line_termination,
> +			N_("lines are separated with NUL character"), '\0'),

This will become OPT_BOOL() to set the &lm.null_termination.

>  		OPT_END()
>  	};
