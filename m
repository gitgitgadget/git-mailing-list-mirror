Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D334AB1E
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475923; cv=none; b=YloKmlxFF3NOujzl0ANcrEcOIm9mC7D9z+UzFxzxZ36fq8/BEuVA5TeTaxgqi/f5zc2xETSiU3IC9yylWAUfBO3H1u0HSBDmZLObgGJhOmgxOtW2UIDnLEFod+t1MUMhEeAKuakt+5zq8E8rQm6o9FMzOJBRlOlQNwL8t8Ep2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475923; c=relaxed/simple;
	bh=3WqJ/I3nmqH8BO5TxBJpp+Nyl1nrIM9ljATyYJZqvOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHTO6rxB9KyfeD/B7bxXB58mgLwZpllakfw3deq9djBw11HIo2rxzSElVUXGHxB4OPl+O3jG1hEkEfyZluH9D3uHRJUl80IDMDh4VaLdzZfZa5ahutVKqRmRKoNmHJmFyg3BdgdZfJdPQ7mbcFZmG2LrxWO33l7dB1JChkJpnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F83vF+GL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v/lR7gh+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F83vF+GL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/lR7gh+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A90F14002B7;
	Wed, 25 Mar 2026 17:58:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 17:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774475921; x=1774562321; bh=UcP2JnotSZ
	k22GulymJ0bb2i+2tD2LDNImAOlxoYDBk=; b=F83vF+GL/rfRzZ/Y+Bb2MHvsNj
	xSwd7Tgv1W8zllujht+7ClRpyDjRRd2+UChH11ew1qrWWR6ORj/BX4FjQXOEapJq
	L0SJdWnyX8dremNnyp8qODPfP47747aBm6oGchDUV2HiRmCDJqPWftqtRGmu7zYT
	sBq/f8V6w24RNmpazJQWYvXkQkYPQ7EqrkAzlFGtKZamdfvSoKJWpTsrQIbAGs8f
	znbEPIkbfFmUh5TVmL+G+kN/9Hyw8g5wt99EuctQ0OEsMp+vQIRfeF+5pCuoyZzO
	4vFJ+C2MHPrpyeCrV8ElFFvrn1d6CDuR/b+Nz1bUT0DM6Lyy/D+qbMCF+/4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774475921; x=1774562321; bh=UcP2JnotSZk22GulymJ0bb2i+2tD2LDNImA
	OlxoYDBk=; b=v/lR7gh+BH4AMWM+sfQ4mFhJ/9fFUy9zOAaNcTX8gWRS6fxfAwa
	EPuI407kOnGKja5qsupbPAdlgVXJLPouKGT0SrT6wm/8igpvnXZesgfeF1l7wg+F
	E48DTWoO29Wa16RgYJxp4AesUTgJ+BlG0Ja6aVJc8a2yY6arWNPF6Hynbjxi5K3k
	lSsKn+x7m9rJrCP6bcHh4+S4aMVH5VMNK+U1nzG1Q4zsVXVkzBRJsWOqtURMlaCw
	0kbmvCH5crMD0CghM0UhsLxRiEHUpLAXM5qSEgGxxw9jnU4NEJHUZZCorXVesEIw
	j/tfaq2zoG6WNri8CdRChkd3zvGKjzAOwNg==
X-ME-Sender: <xms:kFrEaU0GoDDdvPqtXlj4nXSH24jks8ywkaQATGcMOnDm9Iz61nRBZA>
    <xme:kFrEaRq9e0EnLO3GEUfiHDK8HdAnxeI-NCpHkkN1nA5BRzdOsvbH8BMvIPpTlvr27
    NL0V-OEhEf7If12vgVwrJYc-F68g3AmTUlUsZtACYpKiDmzCQ>
X-ME-Received: <xmr:kFrEaQi1qnToOUzc3VSARWkGwaD8q40U76w0dJk7n7L7g0APsk0Wlpl-VT-jPmP1Xq_tFVZ9Dw4UrT5NcN0U29Zi7LduiQNkHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:kFrEad_5QOzUI0O4_8rT2zBcuuGVgQrMt5_kMc_1rzOlz9QMStjAng>
    <xmx:kFrEacXtPDUuxVq8-3cTGzxTTWWcUsvzJg0Ay0z4hJm2XnlZqDJ5aQ>
    <xmx:kFrEaRDxzYG1TtvzEcpcL1XOKeMZB58CtiyAgqwLtM_yCchWb3oA5g>
    <xmx:kFrEaREACy-aaHXx7W3bb1tvWGNYZXUgq3QIXqI0dzZIzG_7wOEHxA>
    <xmx:kVrEaXqGYKzwe56DS6D2tzfZlT8cRtnwLeSrK3klyXVfAvVvQEJaK8WA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 17:58:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 5/5] xdiff/xdl_cleanup_records: use unambiguous types
In-Reply-To: <a52787f0194bf9f7d1e0abe024c423b8d93754fc.1774473065.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Wed, 25 Mar 2026
	21:11:05 +0000")
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<a52787f0194bf9f7d1e0abe024c423b8d93754fc.1774473065.git.gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 14:58:39 -0700
Message-ID: <xmqqldffsh9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Change the parameters of xdl_clean_mmatch() and the local variables
> i, nm in xdl_cleanup_records() to use unambiguous types. Best viewed
> with --color-words.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index dd595cf8a1..39e48ad33a 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -197,8 +197,8 @@ void xdl_free_env(xdfenv_t *xe) {
>  }
>  
>  
> -static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
> -	long r, rdis0, rpdis0, rdis1, rpdis1;
> +static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
> +	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
>  
>  	/*
>  	 * Limits the window that is examined during the similar-lines
> @@ -268,8 +268,8 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
>   * might be potentially discarded if they appear in a run of discardable.
>   */
>  static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> -	long i, nm;
> -	size_t mlim1, mlim2;
> +	ptrdiff_t i;
> +	size_t nm, mlim1, mlim2;

Looking good.  Moving away from platform native "long" and to types
that have more specific meaning makes sense.

>  	xdlclass_t *rcrec;
>  	uint8_t *action1 = NULL, *action2 = NULL;
>  	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> @@ -303,7 +303,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>  		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>  		rcrec = cf->rcrecs[mph1];
> -		nm = rcrec ? rcrec->len2 : 0;
> +		nm = rcrec ? (size_t)rcrec->len2 : 0;
>  		if (nm == 0)
>  			action1[i] = DISCARD;
>  		else if (nm < mlim1)
> @@ -315,7 +315,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>  		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>  		rcrec = cf->rcrecs[mph2];
> -		nm = rcrec ? rcrec->len1 : 0;
> +		nm = rcrec ? (size_t)rcrec->len1 : 0;
>  		if (nm == 0)
>  			action2[i] = DISCARD;
>  		else if (nm < mlim2)
