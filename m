Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D33311C37
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389801; cv=none; b=p1vGrjtVOK0J2AmJGZFeVr/1oKRTApft/C5LO86xiWc3N1Xm8o8xIezVsswzJ8LzcwfqOdD6zBEYbewd1Qlo9z0biAtoPe1UmnnX+iz9FJfl8E2BHxXMFsAIEMxyboaU1TV7ImU0qyEZhRTymB9L0vxhfwtOqoTvtAaFwPr5xb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389801; c=relaxed/simple;
	bh=4sdCeETrhG/ffjZkIIUbfq+YcYIMcfU0igJuRstPAfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVgHB/p433NFGxRLwo0abbaTHxBQsSG8V8Pm4npqF/iSW8qf8+tQJu29O6uUzv4rY0FH9qVddH/PzwE5Xmo2LISo8XVVbM/5JaLUrRQqcEy4R1HfRgsuBxmmBk7OQSF2AnWbBq/fBHaI5wkCIMwv1HMz9+Y6kBDTvxJbI/YoZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jfve5PuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QApQ+qbR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jfve5PuC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QApQ+qbR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C92414000B6;
	Sat, 20 Sep 2025 13:36:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 20 Sep 2025 13:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758389798; x=1758476198; bh=/M9WO8eicY
	tS4lkk2ega9tA3QnzJDECvANhpx5dqds8=; b=Jfve5PuC/be+Isq6hyOz5xmwUV
	6nA5032j6Y2Jh65oPT3ucJRmu3nQX5+ZZfAnnS+rzwNhXiVuklGDzqh3YEyScOPs
	no3FH5Hgr4mGje2UcYXysZJpRZYrkzbXzoj0hbjRgVPWVs6JuuR3xTSi5B0lDTNl
	Ep4UW/BIhxBec8SYz6yiUOjXWXdcsREP3fJ/KroU+71Mk0VPFvlLcl+NZwu0665I
	TzRTU3QwL02E2vq6Va6UpUge/skDgjXn7Q54h49N6SPwYWm2RxKo+Mzepx+LS1/w
	EtDmuMouaxJ5u2pNtk8VngF3ki1E/PHvFCbwuM2R8nM2cwQw2kRwltFRxiIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758389798; x=1758476198; bh=/M9WO8eicYtS4lkk2ega9tA3QnzJDECvANh
	px5dqds8=; b=QApQ+qbRSx5XPvxhjvdYm4yPEYnTiCIRxdRUIHqQjpuzYkjx4eF
	u0aAM1USGEuxP4GD7QOiFe3cxGE19Jihq+UlIKULsAfSPKFdgzl2gOSvQwMc+rzC
	TmqOitKaEyQSNGHarwBjOpj9Dy1pAfUxn7wg4ME+3BtEt3xEctaxagaTYcbiRzxE
	SBxzcEPOGQUDJK3besoVxzLdjTGpau8roBXRb6zNCFu5PwjnPWktfiHXBostaRG0
	5yagtRCSjHmJ8WgPh2bB+zB+cv7jmn2U/Cy3nz1SvuXgH+fW73IsLI0fv0jacZC/
	JM6h4QzhVtTdnd5QtNRSVs3XhK6AwgWJJbA==
X-ME-Sender: <xms:JubOaOmVjljWsIEV5_YFYOu2lZj8K4v_NICMe8DXrbFt2U6alVooCg>
    <xme:JubOaDYGdfvOZRQ_OQZHup3SmL2BKwuTrR3SvdBq_Gjd15Ox9Zuak2yBF7Oxp6m53
    nNplGUvuE3PGapLAw>
X-ME-Received: <xmr:JubOaDGX31B8L90lHGLdOstOcIjWJK1vsG9BUoRMX1TnfH17LLlbMsxEMcEQk1CeW_4hA5SljbOd33xp-DfKLY9ZMBNBWBeGk0_L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JubOaEI66ncRdwEWBXrTK7TQj-VGiKf2gcQkQZRRnrphjI9gS40H1A>
    <xmx:JubOaON5N8KS799oCSR0_ToYgR1w_uWylt9fIMrdfhelh8laHU12Lw>
    <xmx:JubOaEkzPzQR1t7IEprkDCuP9iO6eQOfqtIEci25xTsFQLp81xl_GQ>
    <xmx:JubOaC5nsSrmWY1jJdjlfhyHc5JLwzZOQ_afFKH2c02L9tESBuH_2w>
    <xmx:JubOaPEnlErGc5qsc_pfYs1H45RwHIILFs32xdvqrOe7Tp-mprd6A5WO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 13:36:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 02/10] xdiff: delete local variables and
 initialize/free xdfile_t directly
In-Reply-To: <b79157e64f0950d25a23c50a8ea83cfddf67ddf5.1758294992.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 19 Sep 2025
	15:16:24 +0000")
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<b79157e64f0950d25a23c50a8ea83cfddf67ddf5.1758294992.git.gitgitgadget@gmail.com>
Date: Sat, 20 Sep 2025 10:36:36 -0700
Message-ID: <xmqqcy7lxbyz.fsf@gitster.g>
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
> These local variables are essentially a hand-rolled additional
> implementation of xdl_free_ctx() inlined into xdl_prepare_ctx(). Modify
> the code to use the existing xdl_free_ctx() function so there aren't
> two ways to free such variables.

Sensible.

> +static void xdl_free_ctx(xdfile_t *xdf)
> +{
> +	xdl_free(xdf->rhash);
> +	xdl_free(xdf->rindex);
> +	xdl_free(xdf->rchg - 1);
> +	xdl_free(xdf->ha);
> +	xdl_free(xdf->recs);
> +	xdl_cha_free(&xdf->rcha);
> +}

And I like the attention to the detail of where the opening brace is
in the "moved" existing function ;-).

>  abort:
> -	xdl_free(ha);
> -	xdl_free(rindex);
> -	xdl_free(rchg);
> -	xdl_free(rhash);
> -	xdl_free(recs);
> -	xdl_cha_free(&xdf->rcha);

Upon an error, the original and the updated would behave a bit
differently here, as the original would not have touched xdf, other
than its rcha member, so the caller _could_ make use of the original
contents in the structure after seeing an error return.  With the
new code, that is no longer possible.

Its only caller is xdl_prepare_env(), and its caller is
xdl_do_diff(), both of which passes the xdfenv_t *xe given by their
callers.  There are four callers of xdl_do_diff():

 xdl_fall_back_diff() in xdiff/xutils.c
 xdl_merge() and xdl_refine_conflicts() in xdiff/xmerge.c
 xdl_diff() in xdiff/xdiffi.c

and all of them seem to pass an uninitialized piece of memory as
xdfenv_t *xe down the callchain, so this behaviour change does not
make any difference.

> +	xdl_free_ctx(xdf);

And the code certainly is safer as we know we have one place to look
at when we added a member that holds resources to xdfile_t.

> -static void xdl_free_ctx(xdfile_t *xdf) {

We know clearing/freeing side is fine, but what about initializing
side?

>  static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
>  			   xdlclassifier_t *cf, xdfile_t *xdf) {
> +	long bsize;
>  	unsigned long hav;
>  	char const *blk, *cur, *top, *prev;
>  	xrecord_t *crec;
>  
> +	xdf->ha = NULL;
> +	xdf->rindex = NULL;
> +	xdf->rchg = NULL;
> +	xdf->rhash = NULL;
> +	xdf->recs = NULL;

It turns out that this is the only place that initializes xdfile_t
in xdiff/ API, so we are covered on both ends.  xdiff/xprepare.c is
the only place we need to look at if we ever want to futz with
xdfile_t members, and with this change, we know there aren't two
ways to free things in it (there weren't two ways to initialize,
either, even before this patch).

Nice.
