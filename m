Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6392222DE
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478450; cv=none; b=uRfTJL1xJLL2FZwY5k/RMIyS7TNXOqR4souFztnxrOsGg98ugifrWbwRbto7sJ/TmQHxkulyO6Q8+5DYZuimt0iTSZ06ImkkoEqVqxqIGC4w8OA5gjOJi0tB7Mrlfpylo2eV55ebisGfbJobnOo0JKmkVpR4jBURr8DPTVTmyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478450; c=relaxed/simple;
	bh=ssas904GmyQy8puTlHFgDrvzHKSAXT5uqxVJUndyBl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bs9wEinNylA7uMMuJ/7HBi/LUyeYWkyc71JbA0gXtNnBTVnVnDIsJVSGFy7E1+f60TUyfGRKnVrEtT9FVw9nkUo979hl+ZJbCN2bh/1JAJc0yzI0nvGrEdtPlMttJGd4JasYtMMFso3e4SDd+6BRYuAosQwJv4BomCjIiO0MiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qtvIR6Vv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeZsiRvk; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qtvIR6Vv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeZsiRvk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 14F3E114017F;
	Thu, 13 Feb 2025 15:27:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 13 Feb 2025 15:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739478446; x=1739564846; bh=uHZqn8sYJa
	daTbqkF92BukO0aNn+CBXrCvlSKgS2MB4=; b=qtvIR6Vvz4J8MlTXagbX5KixxK
	lt8R8PZjHyq31L60RtP9GDpnwDzBkrs/7WmLpnSm6BYBlU4nwSl8zBtpLIxcqrxU
	XqL8BgV5fAFi0ca4hfy4q9aopynVs58XAFn1D7QgOsC9Fl2CJ43M4sO1YxlNwXHr
	K07s1ISWd/NX6w75TRiVHu2lh38rRt6TikvE+YNtu4ySWbhLKlkHVxvLkog8afLb
	c/xynpWX3oSXi9QL6oZ+CK2lEuE696FVvXk6xInQq/qTzTgAUvruf+HyFVarWYCw
	2//4qTrMbBLl3ZMCUkgUiD0ag5w5L8O7pHSxlTaQgkqkCZLA8xj/dsNj2X+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739478446; x=1739564846; bh=uHZqn8sYJadaTbqkF92BukO0aNn+CBXrCvl
	SKgS2MB4=; b=ZeZsiRvkZYtAvvHsR8YpYuU8DRnlnDfciqZsDf49uWu60CP7PnG
	Wwpa8gA1/k9C7XB8RLbPZbgzl1rkFqvdU2EwArIkcsrQ+tNZYeyEc2tytX5udwSr
	yZNDp0sRUocPDc2zQu5plJUU2NY/X4LLj6bQdko20lp4FirdJKzdSV9dBBkY+sxf
	hkGSFruB8PkrP2lFYj7DF07NKrAh450Uw3bp6519uqkUs9v8NW3Hx/Dg62ZmZt2h
	auoI8xsdxtEXFEVDmM34UDgCGZHBzC2nl3SC6JT/p6Cjo/d6G5XtCfY+A1EExTpV
	FBxv9UIuo42V2M/mkHnwkxGMiUcJTPtF9Mw==
X-ME-Sender: <xms:rlWuZ2aJnjkmd2GkYfKdjrvOKHdsaQmdASAke1624Pp88yxZbDJQfA>
    <xme:rlWuZ5ZA8F05lTySl3OHHxPXfhXqpTqjDwNdDrm5uwMg8gKLG6m8QS_eApgspzfnr
    imnTo7sd8x3rpG0HA>
X-ME-Received: <xmr:rlWuZw-c-m6Dy8hhDaXqQ5EVkMz7W5hizJJW_-wxTqOOCq00AVAWU1yDpQA7O9hJ_nZwvbUPpW5ZnhDNDqpESOKvgCyYj8o1Zdk4AB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmih
    hrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rlWuZ4pYoY2wdQCfahoNr0UDIOCj1DKz4lQS2-D-396pXbG5qLws-A>
    <xmx:rlWuZxpzuspz6l6mMEwvgqthT8ViscU0Zayc1Oup3-52i0Y16P6WrA>
    <xmx:rlWuZ2T6qv2vakQP4HciISGszZKnimjWF7aA7V3omv7VUJZXRIM_7Q>
    <xmx:rlWuZxoGkJ149uyysKakwReKyn0zrW-HGlKkSjwFVRjVks3o67izUA>
    <xmx:rlWuZyl-DiAJLqqmwwchcVjFbCu3VAonGKPZo3ouC7tkN7godrlEVKpK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 15:27:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] doc: use 'title' consistently
In-Reply-To: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com>
	(M. Hickford via GitGitGadget's message of "Thu, 13 Feb 2025 20:05:18
	+0000")
References: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com>
Date: Thu, 13 Feb 2025 12:27:25 -0800
Message-ID: <xmqq5xldoaj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> The first line of a commit message is variously called 'title' or
> 'subject'.
>
> Prefer 'title' unless discussing email.

We do use them interchangeably, but I agree that 'title' is a more
generic term than 'subject'.  There are a few other commands that
we may want to pay attenion to.

 - "git log --help" talks about "--oneline" and "--pretty=oneline",
   and they refer to "<title-line>", so we are good there.

 - "git shortlog" also says it groups the commits by author and
   title.

 - "git rebase --help" talks about "(commit) subject" when it
   discusses what appears in the todo-file, without referring to
   "title" at all.

We may want to update "git rebase" documentation to match what
happens in this patch at the same time, especially because it is its
interactive mode that "git rebase --help" uses "subject" to refer to
each commit's title.

Will queue.  Thanks.


> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     doc: use 'title' consistently
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1893%2Fhickford%2Ftitle-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1893/hickford/title-v1
> Pull-Request: https://github.com/git/git/pull/1893
>
>  Documentation/git-commit.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 602e2f1200b..70a5e4a181c 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -98,8 +98,8 @@ OPTIONS
>  	replaces the log message of _<commit>_ with its own log message
>  	but makes no changes to the content of _<commit>_.
>  +
> -The commit created by plain `--fixup=<commit>` has a subject
> -composed of "fixup!" followed by the subject line from _<commit>_,
> +The commit created by plain `--fixup=<commit>` has a title
> +composed of "fixup!" followed by the title of _<commit>_,
>  and is recognized specially by `git rebase --autosquash`. The `-m`
>  option may be used to supplement the log message of the created
>  commit, but the additional commentary will be thrown away once the
> @@ -107,7 +107,7 @@ commit, but the additional commentary will be thrown away once the
>  `git rebase --autosquash`.
>  +
>  The commit created by `--fixup=amend:<commit>` is similar but its
> -subject is instead prefixed with "amend!". The log message of
> +title is instead prefixed with "amend!". The log message of
>  _<commit>_ is copied into the log message of the "amend!" commit and
>  opened in an editor so it can be refined. When `git rebase
>  --autosquash` squashes the "amend!" commit into _<commit>_, the
> @@ -128,7 +128,7 @@ See linkgit:git-rebase[1] for details.
>  
>  `--squash=<commit>`::
>  	Construct a commit message for use with `git rebase --autosquash`.
> -	The commit message subject line is taken from the specified
> +	The commit message title is taken from the specified
>  	commit with a prefix of "squash! ".  Can be used with additional
>  	commit message options (`-m`/`-c`/`-C`/`-F`). See
>  	linkgit:git-rebase[1] for details.
>
> base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
