Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854530748C
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780386; cv=none; b=qDLQxJzMIAyQGf+XaVLbk4uIC4hFFgsBK4ewE5piSzwSu9WrdVtl8pSTN+rsrEULqp7L7XmNw/xd0VsDjQqoaR6fzOG1JEId+xCqw8QAoNseWgtwPK/r98rwE3YtrW5JZEPPXXBizre5Cb7VKEFwOXpKsuDs5pVxKzfIfsGs8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780386; c=relaxed/simple;
	bh=drxN1aQLF+yjo3Gq4KWz+XKj3h5zrCj/r1Odwta5D4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N8lbAUYt0PxBTMaslhYYAjkCZZAQeRNgHJmKkYVZT73YCe02ShX1Qg4H5LG6qnDnVg5DTlpBxvZSkVxKZBRHOWMyyf9HKPIT2uP9PZ8pi7IGyQrz7mwY8CQdPncQsesJQ3LLoddCMMoUKO5eg1YnDM0IJ5VMzjesXihQYyDAk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q/QjR/zR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9w4o1Zh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/QjR/zR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9w4o1Zh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DB377A00B2;
	Tue, 24 Jun 2025 11:53:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 24 Jun 2025 11:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750780381; x=1750866781; bh=akigDqYUnc
	JvfFq9S+Q+mFePVgzZ0IeSFoi8rg5Ui5A=; b=Q/QjR/zRhOiVLpr4t3kc8FI/GP
	cpPjhGt3CNlDZC7t8IsxA1oEVejQA6w0JUk8alIpY993jZJCX87P1T3gap1kbxGf
	JA+Bd5bl0RH1IQHs7lz7NgSV2l1rcXHuk+VYSWmcQnbBPEgqWsGcPgKMaj8mLqiC
	qnqipV+7B5gpy2Xdnm+53ynA4HWgmxWKt7sBG2Vd43avclUWwKTxmHDaFAR+dk8n
	8Np8RTh/kFp0V/HuyP0Ruga+0g+fLPTBRTFih8v9D4yMQMuloqtX2PrAiPBScB+l
	yEkBDoUYUp0+ZCS/2HWbZRCQ2+8at4N7c/ZQJPbShiO/bxRZYojTxY8ScnTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750780381; x=1750866781; bh=akigDqYUncJvfFq9S+Q+mFePVgzZ0IeSFoi
	8rg5Ui5A=; b=X9w4o1ZhMgxT1i+wxxmdMuckI+PEJNy0l4LJpTBmFcOp6oYl9qQ
	My2OfmDLMP/4V+8g6EzuQZDZYK/NEMj6wQ0Wl7bXIuN5zCV5rqR2VgZcLR/D5jwD
	P/Whp/2IPORKiPDmM6wpiap9qBWgM9d/1sBTK7xiZY4jsg3z2y8tYNvphevZ/gQZ
	xajJXuENNT7AMD8njDSCVAvpmLSnMa4hRRfJMmXVelQl7J0mfupO2JhPhYsl3H/N
	5q6EYnp/SxdrkQQehFaItQzK/8k7bqTZMtF0H0pAL+0vDTiCCBDVnVLY48aGdxt4
	E5qEKdrzGKkSexl3pR/SfV3aVjtkQ5OUu5g==
X-ME-Sender: <xms:3claaJXhUebBiGmqY3YML-ivpU5yj3lviReA1R-20bGrP-3AjDQwhg>
    <xme:3claaJkG2xRVaOgNW6F_JS-rJn4k0N3xArIjG2GDdPLElAk02WIydtqCAQFeLKWCZ
    pKUPkz0RDpuMyDwaw>
X-ME-Received: <xmr:3claaFadm2NILq-Ckv1VwYUDEnmXdZXB0MabMSavcnaXDkE3-VSIZ7Y26l0-exUw8AtzC4lXOB2BfLuMD8PNZOESxR_Q7c_ZWSyJ8x4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3claaMWtyBzpl1p41fvQqNmd4KzCUAIfC7zODBDzA16nXMTZDmNinw>
    <xmx:3claaDm_cNFZlzvw4cnQhh-Mm8_W2a0TZKt3sAohpYFBqOsFDwo6PQ>
    <xmx:3claaJc9QbD6EphJGDEZmwU5-r0auZpq7hgMAUPkEHwudLLAgjjaRw>
    <xmx:3claaNF07tTX94QmqZfXv_xw2uYVDXDSK04-I6_jicVtIAUiihEsJg>
    <xmx:3claaCrZOlukGz_FX03knYYqBQL_JTeIc9SQrfNPQHuv7Pb90dty9gQU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 11:53:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v6 1/9] pack-objects: use standard option
 incompatibility functions
In-Reply-To: <8e7b2dacc77623ada5ee938de7a610ae15f49d8e.1750717921.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 23 Jun 2025 18:32:10 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1750717921.git.me@ttaylorr.com>
	<8e7b2dacc77623ada5ee938de7a610ae15f49d8e.1750717921.git.me@ttaylorr.com>
Date: Tue, 24 Jun 2025 08:52:59 -0700
Message-ID: <xmqqldph16hw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> @@ -5050,13 +5051,14 @@ int cmd_pack_objects(int argc,
>  	if (!pack_to_stdout && thin)
>  		die(_("--thin cannot be used to build an indexable pack"));
>  
> -	if (keep_unreachable && unpack_unreachable)
> -		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
> +	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
> +				  unpack_unreachable, "--unpack-unreachable");
>  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
>  		unpack_unreachable_expiration = 0;
>  
> -	if (stdin_packs && filter_options.choice)
> -		die(_("cannot use --filter with --stdin-packs"));
> +	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
> +				  filter_options.choice, "--filter");
> +
>  

We do not need two blank lines here, do we?

> @@ -5064,8 +5066,8 @@ int cmd_pack_objects(int argc,
>  	if (cruft) {
>  		if (use_internal_rev_list)
>  			die(_("cannot use internal rev list with --cruft"));
> -		if (stdin_packs)
> -			die(_("cannot use --stdin-packs with --cruft"));
> +		die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
> +					  cruft, "--cruft");
>  	}
>  
>  	/*
> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> index b48c0cbe8f..8fd07deb8d 100755
> --- a/t/t5331-pack-objects-stdin.sh
> +++ b/t/t5331-pack-objects-stdin.sh
> @@ -64,7 +64,7 @@ test_expect_success '--stdin-packs is incompatible with --filter' '
>  		cd stdin-packs &&
>  		test_must_fail git pack-objects --stdin-packs --stdout \
>  			--filter=blob:none </dev/null 2>err &&
> -		test_grep "cannot use --filter with --stdin-packs" err
> +		test_grep "options .--stdin-packs. and .--filter. cannot be used together" err

OK.
