Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38951E1A3B
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460876; cv=none; b=XaeP1CJQ31i4TFa9omY4drPayKQzyuY0wpdwVqS412ecqvboyOvN+3q7UXGdjyiHzyP1k+eXb5rlydem3FASWdqhahfnlCyj4bGqKVAWBJErvTyqJl5U6u3+5IIjeKFZPqZkedNgo31Mh0xp77MaLNbkNFkUWHa4ZbqNqRQezfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460876; c=relaxed/simple;
	bh=F3R27cDYVmdNPiMCFwsJfJRjF96gQNjqesAGDHDnroM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbtlYQFvm01r1EPzpsx5z5qHl8DOsmX9WsGnqM3vaGXdhxJ5mOeykqaaEkq8JU9+dQE+kRxBOILn+AY4HkgtGXHUerCZ9kG0vtB+/8UsnfeSsQJq4+bTEPZn9nuXQTeO69F13v6zoD/yNBdEk8YKDyVfh13nSEYgUbhOhqAzRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h4TCGa1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQH4gm4j; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h4TCGa1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQH4gm4j"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E26121D00070;
	Wed,  6 Aug 2025 02:14:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 02:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754460872; x=1754547272; bh=1cEsZgISCY
	Np7My1xCmo8YEZ1fXSV+esgBsUa8oCla0=; b=h4TCGa1mUqXC+Rvv+AVA74sQBE
	On9ZAwwcleyw6yPPN28gWjg1QwRmBkp2RzXyejUXITKf2hQ0y6q1p0sQEGcFHWrS
	nXWl5eu552FNvjyB2Y9rU5xqYkBeg5orjRmrR+qWT/4fQevfrBDIDLXdkHEA2uQx
	RWgzm1QPp9mYu9rAKT1fOrKpdKocxp65cts22zAltDheWB9EwbY5FgKrB6pM+HsZ
	deJzK7DMkz1gwJvPJCr+x+O+2kx0IcTCgaCmkaBuIUA39KU+cWqtibuiJg9cew7P
	CnPKgC9Y8nsWg8sJ3OdSm+4hn51nURIVtFPfgwfvkcxGCK+TutYk7laK3x6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754460872; x=1754547272; bh=1cEsZgISCYNp7My1xCmo8YEZ1fXSV+esgBs
	Ua8oCla0=; b=jQH4gm4jOCNXjP2lqmfLMBXn5Kg1jNOOXehkc5HAsPYEVOZ14gN
	5VoKuWo/r6u123JwCC36aZRLjRsxH1b2ELTmhcLWzUNZqu4nSNRW7MV8LNFtHMOs
	Emw9f2GVRhJfFmf6dVC0PpgkNwTm3X+Hu87VYguwZm7OjZk2jF/KZkUV+CEaSVWl
	10Ft1dSUzIie2t4S50N8eJhBPQO6xRlw/iEvBLJaBZo1CkTwIilfNjBdWvZtw7we
	vmuDQq9GnWFFy28l+tel6MfUQcYyqeNSOHVljdF0mpOosmfYpaBAhhod2Uj4m8VU
	hnG+xBoDSeizEYjpox2Gbt+UsLblAOzvSSg==
X-ME-Sender: <xms:yPKSaA3ANKcl-Bp2ycGpnKW34azEdi4-qmKNB_tFpBqY4gR-x17WSQ>
    <xme:yPKSaOV7exxp-xtqPsAsiUYUoRpi1TAhJJWFFvNaqjzTmbd31nY17uV2xYXRMGDFq
    E3UsmIWPYKB6hHLCQ>
X-ME-Received: <xmr:yPKSaCUCysfy6DLGCETjND1zFrlkaAlPHo9ND7YsRu-2mSJ7GAyoJpeuT_wfb8B7JaeIwAWg7IG3sGEQ9gmsVJ2DELUA1ZVme_5Xyg7ofQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlihhurdguvghnth
    honhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:yPKSaFejbQmsqTOVFPuYm87dFHJxEwSVIhUzGP_6mVXd0SqzdMhlbw>
    <xmx:yPKSaDU3NJV4r1kHGsz_Crgio3fhyZCv2YX58YWbGu-Eiu9QZL-ihA>
    <xmx:yPKSaGcphLkTzlaeFJJ7P3sQMx-KJ1SvfbSQiM8GanibFMiZ_7aQpA>
    <xmx:yPKSaHPrmprXjukZMcJVaVdC5het8beBBSwsTSw7jRHmlVvegRsCDQ>
    <xmx:yPKSaAREMuUBug6JZ_DYrNoyQCN_hU0d1_Rz5ZNr64v1gKt5K7vsi6lO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 02:14:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 197c5f95 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 06:14:30 +0000 (UTC)
Date: Wed, 6 Aug 2025 08:14:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <aJLywm9xWQQUADH1@pks.im>
References: <cover.1754375026.git.liu.denton@gmail.com>
 <cover.1754455931.git.liu.denton@gmail.com>
 <938dfb8d4e37ef962c811d6e0f32122a2522deb5.1754455931.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938dfb8d4e37ef962c811d6e0f32122a2522deb5.1754455931.git.liu.denton@gmail.com>

On Tue, Aug 05, 2025 at 09:53:42PM -0700, Denton Liu wrote:
> diff --git a/remote.c b/remote.c
> index e965f022f1..465e0ea0eb 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1218,8 +1218,8 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
>  			 "'%s:refs/tags/%s'?"),
>  		       matched_src_name, dst_value);
>  	} else {
> -		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
> -		    matched_src_name, type);
> +		advise(_("The <src> part of the refspec ('%s') is an object ID that doesn't exist.\n"),
> +		       matched_src_name);
>  	}
>  }

This reads a lot better, thanks. We could arguably convert the
if-else-chain into a switch to make all of this read a bit better, but
that is a subjective style change and definitely not something that you
have to do as part of this series.

Regarding the logic this looks sensible to me. We have already handled
all valid object types in the cases leading up to this final `else`, so
we can be sure that we weren't able to look up the object. And warning
about that case feels reasonable.

One thing I wondered is whether it's okay to not die anymore via
`BUG()`. The other error cases already don't die though, so this ought
to be fine. Going up the callchain shows that we do bubble up the error
as expected until we end up in `match_push_refs()`. There's multiple
callers of that function, and all except one perform error handling for
it.

The only exception is git-remote(1) in `get_push_ref_states()`, where it
gets executed via `git remote show $remote_name`. As far as I understand
we would end up not showing any references that are broken, and we would
print the above advise. Which I think is reasonable.

So all of this looks good to me, thanks!

Patrick
