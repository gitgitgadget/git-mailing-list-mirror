Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82438354AE7
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743527; cv=none; b=XP7INdjtlW00DzztbrEyJbnY0JZdAkZgXuBJrK2EDCYrii91SG8iqEUBh3p8hUU8Q6CniS9ipyRGhhtAkEoGPe7LYR50hxGHH93cBMiK+nzyc3KTpzd64B3gE5vEOK0rQ2sfw4jFwdwnovwwlRJr8jdmx8O3bgmewRaQMTftaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743527; c=relaxed/simple;
	bh=hTBxcU9Nd/1rOYqHY17Co8kjRgNeLjyH/jI3Nxlwc2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YRKkZXQZec7IhDxU50TK/R8Z2TK+X59+qqSAcYMdjqIPawJCeey6OQrTTNJnfOBtCml+b8Hia49sZ/vUqkhTXx+iCJNjxRLHBkaTIcSenBxrMFUwpwbW11glDfMEysSrvGwQBkpRS3EMrRQQKYO1H/kLCbaBf9lz4H2rWlAhpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rx6SL1g4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itkYWCxk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rx6SL1g4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itkYWCxk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 76E5A1D00107;
	Fri, 17 Oct 2025 19:25:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 19:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760743524; x=1760829924; bh=CeKasx/87+
	LPdU1iyjhUpa7pzsx2MrW0NNOzYY7j848=; b=Rx6SL1g4xb0hjwvd5QO0E5rkI9
	WuFWJh43+O7yv/F19vS7qqU59lst9+GH5T5WJqatC0tA+2yl/0JMROBte/HAZub0
	yeQRrUM/bop7wSrwvpdP6EzFiGvgcnc8RvaIJT9Jn+RSZkk0qZ4+8uQUa5cYW/Vz
	A/ihKKstlSjBrxv5W9WJ+eYHbHWjQKYD2CLNGs+mm8gjNYFw2CcLDI9LMHhZX2cp
	BDXDzlxT0jqWA3ERnCZzpjol8dXW+NydDQ3tc0vGAYrnlW5fnBxPPNNIME+emx2w
	33x6eZtxINd9Xxg2L1aIHS+VGz+3Nx1dlwvqZsFZx+NNG5tkli/S3Qvvws4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760743524; x=1760829924; bh=CeKasx/87+LPdU1iyjhUpa7pzsx2MrW0NNO
	zYY7j848=; b=itkYWCxkJolxGsfbq5vJQv6qs1s+1ETf4Z1RhxVfZAuZ9Bv6Awt
	6nBDyHWctTHx9t3JH2N+Sn1R08eOb00bqRZnsyjL7QVIEMZESEY7r2MEVEn7qs5S
	Rcm9Y/9uhDSa/zJzX31xSsEg+RBxo3iNyiK7qnFpNs/JhXqYDxv5vXuT554evZpP
	uMn5TGvj9PeI0RAFwZWy+2nPIU5t9uX9NCvQCI3FddAjC6NHqZqQ9a9P0dTgi6dI
	ihNnqApvQJcecZccmfJJlsubrwhYAoNY+85LfelbvDIshuw2dxhuMgubp0fJ+rrS
	LrPxlY9jyW6UuRMRO3kfMbB8Y1jHItuDHWg==
X-ME-Sender: <xms:ZNDyaGAs7NF3r7xJCmqiMgtrlj-ZqbLZS0vE4yfugYJD3Y78AoqMXQ>
    <xme:ZNDyaHjlGx0wAAzqZWf5Uewn9KwKtCN61U40VuVotkDSrwTBhDJ_LJZOVez-C1GE_
    xxptvZEel5pIJ7bnW5Dw8rnsSvsTOKmS5P7z6yAqWdmOtXuVISqdhg>
X-ME-Received: <xmr:ZNDyaOmRlH0rzpbPl3yW1qswn3hG63BohGlhAZEaykPfI6uTilewmsGU7QiKNTAxT11RtpjGqKQBqOC77lNTtUrOPK9MhTXpCbRX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:ZNDyaDqERV0EA6ruYK9Wd-BVEGcDI_JFoBapkrb1UV1EvbXE50tL1g>
    <xmx:ZNDyaHGeHgqWQ3tYV_fOiYtiufBjjz3fl5ncCiQvc0tBl881GgxgjA>
    <xmx:ZNDyaPxJJS4USRqlLJE8O6PpS9hmBgzIrDb21cIW3mGIaA9erD50ZQ>
    <xmx:ZNDyaMr7k2qE2A1ibKXT1Ob3xfliGz6T2k_iQffnhL5QFWobK2koFA>
    <xmx:ZNDyaGHVYPPmfncXlFyZnwuFmgRae-AIpgw-wdDQEcpPuE6B77eQzj7J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 19:25:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 4/4] doc: git-reset: clarify `git reset <pathspec>`
In-Reply-To: <0be166483f547de866744917e6cb19eed13a8088.1760731558.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 17 Oct 2025 20:05:58
	+0000")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<0be166483f547de866744917e6cb19eed13a8088.1760731558.git.gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 16:25:22 -0700
Message-ID: <xmqqa51pxg9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`git reset` only modifies the index: use linkgit:git-restore[1] instead
> +if you'd like to also update the file in your working directory.

I cannot judge if it is clear enough with the above sentence that we
are only talking about "the other forms", but if that is the case
and it is clear we are not talking about the mode where the command
repoints HEAD to another commit, the above is a good piece of advice.

If not, perhaps

    When specified what paths to modify, `git reset` updates only
    the index (without updating the HEAD or working tree files).  If
    you want to update the files as well as the index entries, use
    git-restore.

may be a way to clarify the distinction between two modes.

>  `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
> -	Interactively select hunks in the difference between the index
> -	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
> -	in reverse to the index.
> +	Interactively select changes from the difference between the index
> +	and the specified commit or tree (which defaults to `HEAD`).
> +	The chosen changes are unstaged.
>  +
>  This means that `git reset -p` is the opposite of `git add -p`, i.e.
> -you can use it to selectively reset hunks. See the "Interactive Mode"
> -section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
> +you can use it to selectively unstage changes. See the "Interactive Mode"
> +section of linkgit:git-add[1] to learn how to use the `--patch` option.

I do not see a good reason why we avoid saying the noun "patch",
especially when we see it in the option.  If we were allowed to say
"patch" here, "changes from the difference between ..." can be
rephrased to "parts of the patch that makes the index match the
specified commit", which may be simpler.

Also "unstaged" is only true when <tree-ish> is "HEAD".  If you are
grabbing the contents recorded in a different commit and shoving
them into the index, that is not "unstaging" at all.  Rather, if you
are planning to make a commit out of the index after doing so, that
is rather "staging" a change!  While the verb "to (un)stage" may
have been a useful tool to explain the act of updating index entries
to describe its effect relative to what is in HEAD, in this
particular case, it is probably more confusing than illuninating to
use it.


