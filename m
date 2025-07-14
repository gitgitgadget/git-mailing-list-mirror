Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16C19047A
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503221; cv=none; b=qjn0Nbk23j9mPcWmMmOMnyOBavWquw6fTfLmO3gVfY430oevGKS2FhuF62tVLoPyGwL69pWDfJkBDan7BWEIvsaFMuqbUi+z1mXO76bRk/HW/Myp3deIKUKmqSNhBCsHDOBRGtbnOO+F7JjeXgjT3SAQxE1hq3Itp5GY3IlyMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503221; c=relaxed/simple;
	bh=ulrsI8N0z+UZ/sO+TU+7sAuQMrOiP2vVGZItUjZHuZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AaAqH9Ubk5FnyqHTVgdK8hMvlV7FAwqzjGc52GEN7Lv/r1hXOkEEd3JRgp+ubLPnvf2a0ganWdo5VC5bofsV2uD2JY1TEMcrsfJGoIenvowuw0dybSIM1e8DQlUc1gwS4aXeEgdHC2QsfDOQQnkGerOMYph+dbQkSWzOOQLPljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QjaV7Mch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTfPRcxr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QjaV7Mch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTfPRcxr"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC3F614003B5;
	Mon, 14 Jul 2025 10:26:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 14 Jul 2025 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752503217; x=1752589617; bh=7t6MTf8HFl
	A5/HNpPUt6Xi+Qp37kyn/MaMnhM9yds8E=; b=QjaV7MchEj7JqPBv4incy1iR8V
	xWpp51Prdo5MEeGOQJYVIY23tGYUjYnIlu/86ZC60tb71ppkOKlv7HdMa1obddx3
	iiE23dJ9CLdXO2JOcXwrf5EVumcBAJR/GOHQCFT5h8P90REKZ2ltY4/+ZAB400BP
	iH4mnLF0RhPtSVBor4l7KyHNdNn51dDs7PyFdVsuvoDNJDnN/KOV4p7RfgdUvGrc
	40iVoK6cHo8yuXdTKqImX9XZPraMHvyO9UoRHW8OGENeVD/Ae8tqEwh33Wo+ovcz
	d69ntJISAVW5F8kjBGaQbTcia+rWVUDilnhvOP8Fc3rjWpwnBU2Osz/08T3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752503217; x=1752589617; bh=7t6MTf8HFlA5/HNpPUt6Xi+Qp37kyn/MaMn
	hM9yds8E=; b=JTfPRcxrfGtIiYym2qdY/UCeQHYB3I66eb3VWpJ5DKvfFjM22LR
	y4LqerqQajEFYFAhDHtHCYGydM6bNiZx1oBGmXwEoyGe0FqB3t5u2Ot8vnJ35TFn
	g5b22p1l8I7EvsjoqlCwgzMV0sm4xh2DdJX9gtLvCH9Dt4ss2/4SJHzlF8NrwxSD
	ftnZIkYPM/fgBJKhRyE+Q732bB6wItHV8nn44j1hFKWl9fC6Zb5+xZE+nxuLVTFr
	rQznRFBZh4oPE4vs5BllLNjnRhtMYO/06hWknqVrZk5J5JFyfuccV0Z8QfeH9+Ly
	mkr5x68Np6gi9JoLWLgI5LtqNez68AH9w6g==
X-ME-Sender: <xms:sRN1aCtEelU6RS6IPve3-VI0kUzZm3gv-Io7WR30YSTUUIRS01qb_g>
    <xme:sRN1aKuwb5REVzV5EjtvyqwIbGOcGyWHNAhcYZrTNJ7ptMiKzat-NzwZR3y7VWrqA
    stnWM2ansOuCOtZ0g>
X-ME-Received: <xmr:sRN1aHNetpzCTP9FG58LGf7DueGNgFyS7tM80tk6obT9N_jzTWnBe96dGt8eEmEAerHmIE5fMGtmULkTIQL8rOwC1AFYbjAUxegN7t0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sRN1aI0E58jrp_AJMGe10foAazDDBRLj0sF7xuvK0UUv8IdyLZkdrA>
    <xmx:sRN1aDMfAZvc6aM5hntne_RD_QNplbIpdoHtcV8Ke3QY24JSlWyKFw>
    <xmx:sRN1aI0kWWxE6RvQivFSS-jjo4yUegYJ73FaP7te8f_7dBNfTYr-ew>
    <xmx:sRN1aKH-9ZOe-7FwNNbppmuYG7euAx1Eim8vdw7-S_umGC_ENxBdcw>
    <xmx:sRN1aPWI3Bn90u87Hv9QmegWvMKloq4H4qcW-Us0x1kqo96WiAkjc6FK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 10:26:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] strbuf: add compound literal test balloon
In-Reply-To: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 14 Jul 2025 14:27:37 +0100")
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
Date: Mon, 14 Jul 2025 07:26:55 -0700
Message-ID: <xmqqa556x2z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> A C99 compound literal creates an unnamed object whose value is given by
> an initializer list. This allows us to simplify code where we cannot use
> a designated initalizer because the values of some members of the object
> need to be calculated first. For example this code from builtin/rebase.c
>
> 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> 	struct reset_head_opts ropts = { 0 };
> 	int ret;
>
> 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
> 		    opts->reflog_action,
> 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
> 		    opts->reflog_action, opts->head_name);
> 	ropts.branch = opts->head_name;
> 	ropts.flags = RESET_HEAD_REFS_ONLY;
> 	ropts.branch_msg = branch_reflog.buf;
> 	ropts.head_msg = head_reflog.buf;
> 	ret = reset_head(the_repository, &ropts);
>
> can be be simplified to
>
> 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> 	int ret;
>
> 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
> 		    opts->reflog_action,
> 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
> 		    opts->reflog_action, opts->head_name);
>         ret = reset_head(the_repository, &(struct reset_head_opts) {
>                 .branch = opts->head_name,
>         	.flags = RESET_HEAD_REFS_ONLY,
>         	.branch_msg = branch_reflog.buf,
>         	.head_msg = head_reflog.buf,
>         });
>
> The result is more readable as one can see the value of each member
> of the object being passed to the function at the call site rather
> than building the object piecemeal in the preceding lines.

Hmph, is it simpler, I have to wonder, in other words, I doubt you
simplified the code.

One thing the above rewrite did is to make it clear to readers that
the struct instance is used just once and then immediately got
discarded.  As long as the object that gets passed this way does not
hold resources that need to be discarded itself (in other words,
does not require a call to reset_head_opts_release()), it makes the
code easier to follow.

But once the struct gains members that need to be released, I am not
sure if this construct does not make it harder to spot leaks.
Somebody who adds a member to _release() to the struct presumably
audits and find all places that need to call _release(), but among
them they find this place---now what?  They need to first convert it
to the old fashioned way and then call _release() after the
reset_head() call returns, I guess.

I am not arguing against all uses of literals---I am just
anticipating future fallouts of encouraging overuse of this pattern,
and preparing what we would say when somebody adds a new use to
inappropriate places.  Simple cases like the initialier should be
fine.

>  strbuf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index f30fdc69843..c93c1208c93 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -68,8 +68,7 @@ char strbuf_slopbuf[1];
>  
>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
> -	struct strbuf blank = STRBUF_INIT;
> -	memcpy(sb, &blank, sizeof(*sb));

We should mark this clearly as a weather-balloon so that people do
not copy and paste it to elsewhere not just yet, shouldn't we?  If
it proliferates everywhere and then later we discover that some
vintage of compiler on a platform we still care about miscompiles
the construct, we want to keep it simpler to revert.

> +	*sb = (struct strbuf) STRBUF_INIT;
>  	if (hint)
>  		strbuf_grow(sb, hint);
>  }

Other than that, thanks for taking an initiative.
