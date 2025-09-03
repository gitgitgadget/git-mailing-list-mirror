Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFF2EBB8B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935000; cv=none; b=rBA2Opgf84yozeXqrK7Qw+1JXwpv+bT7Jfr41LEjiR3HZQgbMzHZXrFcV2xt9VlmEjlorNcqIFDSBQwdXc0oezAIoxiuUaumKpBKGbQ7JUh249V21t80g0XY8by+J6Luk2+Vz/ftgPjFVBSiSZTOLgR0FkL7q5EvG2bFXDrFV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935000; c=relaxed/simple;
	bh=q67vjLOuqDyrhp7QlQU90fzHHA6S3YmEgOC2qAcg+d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJd38A30sF5AODUttn4K8abkQ87aNxRBKw4cY1I0URzV87BpVjO/ovtbvP/RWrfTalPn/eLBo9314ANG5gTTZCeX3rtBIexpVakGhv/nmfTQUGqnvvU2BJkTHT/9Vl6VbELKR3XsvxsTSSJN9X+/M1oeUB9GMJ6jGjZ6gg41Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6niFTZT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g50a49mJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6niFTZT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g50a49mJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FEABEC0505;
	Wed,  3 Sep 2025 17:29:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 17:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756934998; x=1757021398; bh=FrX5h17fc0
	saJIzvWI/i0onTu4+bBJy+xEEnUOFLNmI=; b=C6niFTZT2AV69cxU+pW/vUJb+f
	GC1G9iSAyZPTm6xfPs9c8CyypxnKe1APMbP+AYFKVJ3gvTOseEgpN6Fj8hNWd2SN
	Ywh9OhnUQRstKgHjzOWa6vqkBZ6xPpzhh987KcIHbHz3mVp8myKfVm431uJRB2k4
	Mh2ILpyeoAdQaRA2UYIPJj050QY6QcGgfowNhlx0KBMTTakan2u9UTLU8fKymHBj
	zwyrWT9In6EZXu1Zs6LvFuMX460ifo3mBAOlO7oImO7Vs0EH5M6a8maN0+tSn6JU
	p6c9Lf3qBd7Qw+xtGh5Brk1SCWqXJBoZVf53XJ7fqz9qw8dIgZJF0RwY4vUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756934998; x=1757021398; bh=FrX5h17fc0saJIzvWI/i0onTu4+bBJy+xEE
	nUOFLNmI=; b=g50a49mJiI67ZnvqbYrtFHfTsGuKVPjR7rpUPXCvoZaqvGFjG3g
	PeNwKBHxU51wdVTM5YiqPFBoFMfoEn+TCeyZ6dWZ+q4m/iA8Sbh2WTdWYr5x+bxu
	TAOt1e9Vu6L5k+G/s6KzGzVD8choPVXqgiU2tm7TYmYvYxkE+upLd2t2IC5rm2CW
	MVn77btvP2rJLpmEwPLh0r57ii3Jx/z5LxsTziRsitHQS7oZv9FZ36mZNgb/mClp
	J3yczzLyfC0VnYvDSO45TbebavmU5Z338aoF62faygFzfQnXE7s9mCC4sxLOsxI7
	5kbIyJeDh6DASF3ndSL+tpM53ndpAB7y6pA==
X-ME-Sender: <xms:VbO4aGWs4w9X1jF_zkiGAAhBpES3GYIE4qVyuuf_th1TxRehLoYIXA>
    <xme:VbO4aOG3AXf5P27p8_t4ngH5Y6eVtkjIEv19aMHDyi_Zed-ln3-sPd_rvwZfEneK2
    BynvWeMI7e1YGpAHQ>
X-ME-Received: <xmr:VbO4aA2b_F1h1bG5F2Z7ze3Uf-W3X6XNv3g5iFJkh0oNboKBaBzOkTnqWrog3DzzYX-Fcivn0pOT8NDUtAV7WxUu0oonHeIlXH0EUDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvh
    hnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VbO4aINv7WK4We3-0mpQRbLEMinQJtx3Um1xusdBharHUwYv7frQ8Q>
    <xmx:VbO4aH6GCNwV23jyUqnc6ft3EdK4bjnx9EExfOjksk5PTMWllzm1ew>
    <xmx:VbO4aK2_1-5SeupidiSsuVLiPtnD1k6626t0PcMRCTl4PIRcfYUr4A>
    <xmx:VbO4aAxM_zikBacLBaNvLdu9ittfHmw5rTBL9N-GTavrtGv1gu-fpg>
    <xmx:VrO4aLkSLvBfZV5ZXdigZONFiUNm_YsaCVipS3xPNMUkEVUDHMdwa7NS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 17:29:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 6/6] doc: git-checkout: clarify restoring files section
In-Reply-To: <90fe48cfe37852b9e245aa0f7b45383f9b879199.1756918202.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 03 Sep 2025 16:50:02
	+0000")
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<90fe48cfe37852b9e245aa0f7b45383f9b879199.1756918202.git.gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 14:29:56 -0700
Message-ID: <xmqqecsndy23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	Overwrite both the index and the working tree with the
> -	contents at the _<tree-ish>_ for the files that match the pathspec.
> +	Replace the specified files and/or directories with the version from
> +	the given commit or tree and stage the files' contents.

Hmph.  I agree that there is no reason to stress that you are not
required to use a commit here (hence not much point in saying
tree-ish).  I do not think avoiding "index" (which is not even a
jargon; it is the official name of the thing) is necessarily a good
idea, given that ...

> +For example, `git checkout main file.txt` will replace `file.txt`
> +with the version from `main`.
>  
>  `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...`::
>  `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
>  
> -	Overwrite working tree with the contents in the index for the files
> -	that match the pathspec.
> +	Discard any unstaged changes to the specified files and/or directories.
> +	This works by copying the file from the index to your working directory.
> +	For example, `git checkout file.txt` will replace `file.txt` with either
> +	the staged version of `file.txt` (if there is one) or the version from the
> +	current commit.

... we'd have to say "from the index to your working tree files"
here.  In contrast, the earlier one is "from the commit to the index
and to your working tree files", and explaining it as such may make
the similarity & differences stand out more clearly.

Also, I personally find it easier to follow if you did
"directories. This works by copying" -> "directories, by copying".
It comes from the same "think again when you find that you are
saying 'it means that' and such" principle.

> +This will fail if the file has a merge conflict and you haven't yet run
> +`git add file.txt` (or something equivalent) to mark it as resolved.
> +You can use `-f` to ignore the unmerged files instead of failing, use
> +`--ours` or `--theirs` to replace them with the version from a specific
> +side of the merge, or use `-m` to replace them with the original
> +conflicted merge result.

OK.
