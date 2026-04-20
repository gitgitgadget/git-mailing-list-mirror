Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C73ACA7A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708929; cv=none; b=mYBAzfxPFERCZ//CXAykK3WvtBSByr4olysiZ5LyOVdIWrOxcCrV5e+lE/t4f59HMsP3kg420rQ7F2x/ty6d5/ZJu6FuSSKCnFGzEMpUZr+GDPA7MEmk8HbXZGiDBFf4/2qvNtxni4p77rDIkwJZjaasrAZenGpJB/y1Kygh9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708929; c=relaxed/simple;
	bh=mO4oYPovSEbzxlwwa1yZzixHbqbrk0i57zA1K1myxTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=id8N9YM3khtbyx2JmiKGlgpJWNQ1qjc1wrieVTcdwmStdjDfvhNH4+fUdaylquzhfCorU1fMKDhluzEzjrF82XrgApudzh82P8G+8aPDS2mB/ZAI/Xi1hfOPwJ2MKJYJhvmpb8wggVUueCwGsnULTR7y3J0PuoEBypDLg+FrhBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zFowi1Tl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmbuMlX+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zFowi1Tl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmbuMlX+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FD071D000A1;
	Mon, 20 Apr 2026 14:15:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 14:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776708926; x=1776795326; bh=fUYMW4Nj68
	PXqx/z06L3txWWFiRukID0gAqZHSJzi9M=; b=zFowi1Tlgy28QzZzf8yLCNivZO
	q0Ge7U6fNCSZhCrj/zfTOg2mMIfkhCM7SZQvQKDe1I4OeF/b5vIzwmzktuyaENXl
	Y3P6J4dXUS4GUDNU8DUJT828G9CtdO/H9889SYWp+XYyx72FsSfIR+3LLD6gIfky
	nM3vAX8YRMoqPzTxA1c7p2rRQiM9hzSVvVCnyu27S1WFyjmtCCqjwmEzSO2fMhqH
	xLv4zVqnjqN98221+weA6LAGcelJPB/Gu+DcucG0hSa9igFkn6CLzJwv00vburu7
	6gwqiTsDZ+JdYe5PsamSQbqx0Vj/e/eV8mSx/p9PnjWFR+zC/xhH/AC0sgGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776708926; x=1776795326; bh=fUYMW4Nj68PXqx/z06L3txWWFiRukID0gAq
	ZHSJzi9M=; b=AmbuMlX+8vRParw2k7yCYVFXKIOmH0DrJs16L2DfQOMhuaxtGHW
	GqEjwV8CefUJC/Xes8iWvW1bhSGuxYP5ooVtA8QD/s7kp+k6275qX6T4Wf2AKHAP
	zUVIaZxpC8gukPLfM+8E2lb6esHg1pOEipfvSXEoa1RePjFq9loLAtK9mwBNAZOU
	lR6QezYnsWSYBiwvF4g71S45MKrJXQRC13jrlFGhRl+IH/BIAdhQXH8QI/PFPQJi
	/ZgNryddqm4PjItz6GCO/FJQYcbI8BnsjLVt9DlQ9rLFl67rRWc2RCOKRh51HKMp
	YoPsDqQT/u+i04EjZO1YC6NWjte4m8huhHw==
X-ME-Sender: <xms:PW3mab3DxlrzZgvjqQOedeld57W5wi_R8VO9Unx2i-d_tuA_MRYCAQ>
    <xme:PW3maRgdi0Qu_SIkA_fekIEue6G8A3NepuugumQEjq44bxGCoIUrrrLZjlDfMdLrw
    H1RpeAldu2tH1S01bIqSi8vMwERKPbY7ZjRdyn_88G0e7ORPjcqcpE>
X-ME-Received: <xmr:PW3maZT7_AEcOGthX-aNMjNlVMesaOCBEly8pWk6qIoNc6JwAauAGcTVWApSg6wx6oJEUo2bUYqd0oLjFTuVPStDf_NpfA2qlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PW3maaiZ-E9pgXt2lmxH30M1oY9w715IneUViNMwcHUzR5ku1Fm8Rw>
    <xmx:PW3maR7YJyiFmkmZ3W61XML9f2Q1dk8NkERAcEgTLDgupxI9IiY3Ww>
    <xmx:PW3mafB5Wy_lEWeQpkv5ieMzjUiqLavT5bnUNjn4KEQ24I32k7wKgg>
    <xmx:PW3maQaVk1CfTZXH0m1U1fKev2tICoBP5J4H94seAM6bT3kXIsKeLQ>
    <xmx:Pm3maVgVv4znWHgmDJKLJ3UCNXebdI8kXBL2MXvVTN47Ja6fuiwCypO7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 14:15:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs/files: skip lock files during consistency checks
In-Reply-To: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
	(Karthik Nayak's message of "Mon, 20 Apr 2026 16:03:14 +0200")
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
Date: Mon, 20 Apr 2026 11:15:24 -0700
Message-ID: <xmqqtst5pkg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Running consistency checks on the files reference backend involves
> iterating over all the existing files in the 'refs/' directory and
> running all `files_fsck_ref()` on each of them.
>
> Unfortunately this also includes the '*.lock' files created by the files
> backend. While the `files_fsck_refs_name()` check was skipping over such
> lock files, all other checks still continue to validate them.
>
> Avoid this situation by moving the check for lock files to a layer above
> and skipping all checks when encountering such a file.

Saying "all other checks" when there is only one other check is
highly confusing, even though it may not be telling any lies.
files_fsck_ref() calls files_fsck_refs_name() and
files_fsck_refs_content(), so this change moves the test from the
former to a higher level caller so that files_fsck_ref() itself
won't be called, the net result is that files_fsck_refs_content)( is
not called on these *.lock files.

And this does not explain why only one of the callers of
files_fsck_ref() is the best place to add this "*.lock files are
exempt" knowledge to, compared to (presumably at the beginning of)
files_fsck_ref() itself.  If we do not anticipate that we will ever
gain new caller to the function and the only meaningful caller that
needs this protection is files_fsck_refs_dir(), then the choice may
be justifiable, but if we check at the beginning of the callee, we
do not have to rely on such an assuption, do we?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c     | 22 +++++++++++-----------
>  t/t0602-reffiles-fsck.sh | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+), 11 deletions(-)

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index b3b0c25f84..f1bdfbe88e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3864,22 +3864,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
>  				struct fsck_options *o,
>  				const char *refname,
> -				const char *path,
> +				const char *path UNUSED,
>  				int mode UNUSED)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *filename;
>  	int ret = 0;
>  
> -	filename = basename((char *) path);
> -
> -	/*
> -	 * Ignore the files ending with ".lock" as they may be lock files
> -	 * However, do not allow bare ".lock" files.
> -	 */
> -	if (filename[0] != '.' && ends_with(filename, ".lock"))
> -		goto cleanup;
> -
>  	if (is_root_ref(refname))
>  		goto cleanup;
>  
> @@ -3939,6 +3929,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  	struct strbuf refname = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct dir_iterator *iter;
> +	const char *filename;
>  	int iter_status;
>  	int ret = 0;
>  
> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  			strbuf_addf(&refname, "worktrees/%s/", wt->id);
>  		strbuf_addf(&refname, "refs/%s", iter->relative_path);
>  
> +		filename = basename((char *) iter->path.buf);
> +
> +		/*
> +		 * Ignore the files ending with ".lock" as they may be lock files
> +		 * However, do not allow bare ".lock" files.
> +		 */
> +		if (filename[0] != '.' && ends_with(filename, ".lock"))
> +			continue;
> +
>  		if (files_fsck_ref(ref_store, o, refname.buf,
>  				   iter->path.buf, iter->st.st_mode) < 0)
>  			ret = -1;
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 3c1f553b81..fc67bee161 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -87,6 +87,27 @@ test_expect_success 'ref name should be checked' '
>  	)
>  '
>  
> +test_expect_success 'lock files should be ignored' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +		git checkout -b branch-1 &&
> +
> +		touch .git/refs/heads/branch-1.lock &&
> +		git refs verify 2>err &&
> +		test_must_be_empty err &&
> +
> +		echo "foobar" >.git/refs/heads/branch-2 &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/branch-2: badRefContent: foobar
> +		EOF
> +		test_cmp expect err
> +	)
> +'
> +
>  test_expect_success 'ref name check should be adapted into fsck messages' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
