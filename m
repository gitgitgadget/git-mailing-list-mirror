Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD822522A
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371910; cv=none; b=VBT+fVabHnHUOUrKLnwAScB23bvch035dkNKbPMyrWn79NmqecMbPhQKzFS2avsAsxPzZIXZUzOvDxVeDGG4k8a3Sg8gQPCH6t8vhOgyZeqmnQXoDakR2VXoXdyDNcRgg1rBge/yOj1t9fCbl1yys//d0Z02SF4dCwyWw/iBVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371910; c=relaxed/simple;
	bh=LqSf0N5aIUiVJPqc5Uo7FqYTNXpc0MgcsUU+HwgTXG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PmDf/wtxfoFXWELRTSy3WhnI7ZGmt0QFfRIfrz/81DToYEAjHbWLIAasm+EiAR360qIqEeraMTZg8/7TvzwQN33FHTTiP2h+WICoOnzLOyHt50FNQNyBJBAzsHIeZ8rbu99T75Fz9vqP7KONpXBpt3KuheiC8r0s+5dH30NtYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U2S2i7kS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPC8RlWL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U2S2i7kS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPC8RlWL"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E64BE138064E;
	Mon, 11 Nov 2024 19:38:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 19:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731371906;
	 x=1731458306; bh=3DnUNN/my+v+UsATrbgNM+IwWifuPmRRvrJ6C8PE+Go=; b=
	U2S2i7kSIU3nAH9yC2bPLs0oOEuxmKCLTJj2MOT6q3JFSHfrUiZKPA/DrRdVmKu4
	EiDfLhCKtTqg7W/mtIQpWVvNMse8vDBvIfN5tQBaCfpr9zojxVatJ49DlV7UqU2f
	9YO9754T+ePFtWyca7fkqm/uGLCTvxgxOlbNsXnZxv79zXVroqRJAVIXWPqSlupZ
	/CNJcldF6sTR/e7ZSJNmgji0HqOsiS8arL54vdMFrscGAnYGQeHqs6n9wIH8yCto
	fSEvbiyPCodgOc1Vtbqm7NIrG5iDxbd2aT/Web15+he9SMB2F4wUj6EJCMQXFDuU
	k0Se9XogakmvgwXkbwqpDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731371906; x=
	1731458306; bh=3DnUNN/my+v+UsATrbgNM+IwWifuPmRRvrJ6C8PE+Go=; b=l
	PC8RlWLYpawL/s71YwflrpLMbFlBswikQre47x/4LoQiVdTniTqL2w1gbVElw2RK
	Se1vjJCvzfNz+m6mtlc6Cy1uzO6cAslMs014aIhdgewEygixf6itqGzVq+a08Lpd
	9807fpEsi1tmKcKkCZPqxq3aYMMnK0Nysd/nnOMPuXavjHFUDcBB9G589qXiwWRZ
	nOEufYK9FvShVq8fuo8JbgML02cIHaTKbOa/hyP6YrdKmKoR+QMXUzmKjAdK2t3t
	BxGiFTZoMEd01rFhMHthSc/b6Sdlt7IG0BFJ9n8jFSSohnlWG5aGXx0ekhL9Dh1R
	XY89XcfEU7JCPao5vxeBg==
X-ME-Sender: <xms:gqMyZ-9qbYudH8CjZJzhjF1oyzzygTnmQJaeeS8uZxL4LXTbLm0OQw>
    <xme:gqMyZ-td88lXx5KicMuXHM_MbbTZtQ00440P9ZyuUEY2KRuYA8W7C-eapvg25ZJSH
    yMYaAwtnQxxCWK02A>
X-ME-Received: <xmr:gqMyZ0B3BPlVaG9FZHQnPFftNzl2OW1KfhBKLP_Pa_1HVYKNWSDBBmkHVg-rrOEIwT6M6zNkXVsy7VGifSB2qxU3zd1i-Zrgsb_6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gqMyZ2ey7b2iKQ1AxFHSyQ3u2oKUcOCRF8hHYLSNCB1sLoL5ehyRQQ>
    <xmx:gqMyZzNEtXE_LpN9x3GXleVNdf42bbP8Txk-UnXBVKs5M4S-keMqiQ>
    <xmx:gqMyZwl4Xt-jmYqIQ-HyyUe10YPe8s8aR6Wi6TVbgQepSZcfoxwumQ>
    <xmx:gqMyZ1vD-uMFrMDJXWX0nYZlmcyXF59zeU-TWrC3S-jpEgBC77OrkA>
    <xmx:gqMyZ4pCwThHFRhBWvy_qJJYRjW5Zd9Q1kIzZvdiCFwZweTv4wX3fhIT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 19:38:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] doc: git-add.txt: convert to new style convention
In-Reply-To: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Mon, 11 Nov 2024 18:14:50
	+0000")
References: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
Date: Tue, 12 Nov 2024 09:38:25 +0900
Message-ID: <xmqqserx8ewu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>     doc: git-add.txt: convert to new style convention

This does slightly more than converting to new style, though,
doesn't it?  Is it so annoying to see a link that points at the same
page you are reading right now to warrant duplicating some docs with
conditional inclusion?

> +`add.ignoreErrors`::
> +`add.ignore-errors` (deprecated)::
> +	Tells `git add` to continue adding files when some files cannot be
> +	added due to indexing errors.
> +ifdef::git-add[]
> +	Equivalent to the `--ignore-errors` option.
> +endif::git-add[]
> +ifndef::git-add[]
> +	Equivalent to the `--ignore-errors` option of linkgit:git-add[1].
> +endif::git-add[]

>  SYNOPSIS
>  --------
> -[verse]
> -'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
> -	  [--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
> -	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
> -	  [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> -	  [--] [<pathspec>...]
> +[synopsis]
> +git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
> +	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
> +	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
> +	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> +	[--] [<pathspec>...]

Not having to worry about `mark-up` _rules_ in the synopsis section
is very nice ;-)

