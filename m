Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC739936E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149697; cv=none; b=Jg+/0denEKR3dPIorvmlZL4M/SI9mYBHNPstAEDs+6VeZg8j+V+gU7nyWRrwVP2ZRTjI3QzAEQ0ymfweZmCoHfUmOSiCOsHOEUWzyh83aZ3/cs/YypQd4xuuHzO4Veo6XjV4oozvxfAz4IVycybOD9z4QZ/MC/juEaV0He9/RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149697; c=relaxed/simple;
	bh=HOo5cST5q3smRi/xz7qAwO4a1BvscdyHYBMQ4ix/L68=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Juzn4hm46tZwy0v2UgVdU8JTYydGdH9oiikDhFJ7s/UnL9DKopJDYE10cjC+c09nFvUmDf4kIbAibqes6cb5wyLDRuI3m5BqVJhDkL24s3sazMZRWtu14MQYtMYJRnlx6/Gjc7NCe7C4Xvr5jMLggZtZR1E2dWb8A+yvwW7NHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RGjQ/lrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uB/LAHCB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RGjQ/lrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uB/LAHCB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EC6F1D000FF;
	Tue, 10 Mar 2026 09:34:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 09:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149694;
	 x=1773236094; bh=5b1s1+3Hcmgk1Sjz19IIdwGt1GvWPtIIpwyRC6Bgcqs=; b=
	RGjQ/lrbKPHVk2hLrXq0GHTFZMJAVW6NnhqGCsndvxXW69r9u0D+Y2CSe1xTPfP0
	v0CHT3pod5WWol5wNT5IsJ9wXfvWGHMLayCIS+pnt+SaCS2XJ5J6uNYXB5igpGgO
	M/IVy9R0OFXRnMlXF+m0Z9b+B4xH33m++ujqJGD5eO1eKt0vS4k2PxbwEwyWl1Jg
	afyQXoLABLAgqVmVtYXaIx3TrMucpXOb4OqlOrjKkaMvzvOEtxZpeKNKxMeHFNkN
	UTrXGQag2I5ZE+UE6YtRZywY/2GqqZBshk94MVaFF/gRCCqfZys0Vul7KeeBYtD1
	mOo6W/aDU5rD3Eo8z7Ln5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149694; x=
	1773236094; bh=5b1s1+3Hcmgk1Sjz19IIdwGt1GvWPtIIpwyRC6Bgcqs=; b=u
	B/LAHCB7bkvpuHdkKnBKiYZv8iQAgkx2PEc483tNQrupv6h7odS3WQbTEaTbVy8p
	ojSDJOaLL5qbVxUaIuAQLUFHyw7M9S8D6IbEHcBo8P+8YWoxOf4Y0iBvFXrl+EpU
	SJKFErZ7IkPpdHgdq5Xw/GMv+D0tDmYTHj8vMVWzfAqY5UT1DYBYuKjWYld87oVx
	lhV46giIfWeqQQMVFVuHzAJQSqTI5x04ZZ8819aQGNoMyzIuOl4AtxL3CGIbNbi2
	hekvddaCn/l7+wKI0nl7Y53eC5Lk8Do2deC2d4kqcolnqD5ImvCX3iU5twnaJ9r8
	mKPDZprc81QZhLtU2SIkA==
X-ME-Sender: <xms:_R2waSLl35f6VKGc3oCtfUjFLGfhzd1qci2hb2V0p6yREl54lOJeqtU>
    <xme:_R2waU_vF2Wjgh5pbr-y4mAs8oGv5Cg2KcHL24tScbU0eWY_wMU04SJUII_8Hmpc4
    GnnFN3Xj2eZI3q3OckipS__ceFak00W3GXs_0ffiihfwCv1PnwTwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunh
    gvlhhmrdhorhhgrdhukhdprhgtphhtthhopehmsehgihhtrdhsthhrohhvrgdrughkpdhr
    tghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntg
    grihekieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_R2waY71_OqYXSj6ImkuXmZArLSeGsBhiSlAVnnBe8IoN0jqEEQ7MQ>
    <xmx:_R2waccB7geOnbiAYY1fSqFwwEjoACYF5Uv8q-rpuFd6IHq4FOXyBA>
    <xmx:_R2wabFggfJJv75Lby0xRBX0c8mfHsXnl49uY2TIJEfeWhlULi9WKQ>
    <xmx:_R2wadTmrSw_C2grzOuWwxVp-YEZXypuShjkWG_nWiKtr3ClBLMgrw>
    <xmx:_h2wae5wD2eZOJPDE8DwFgF3geT-j-OfPTPEhi_SubhJjPS1UkfTjnGH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C561D1EA006B; Tue, 10 Mar 2026 09:34:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Adl1l9tAOWUZ
Date: Tue, 10 Mar 2026 14:34:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mathias Rav" <m@git.strova.dk>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <c4781432-57f1-4b2f-a52d-aa0d5cc2b406@app.fastmail.com>
In-Reply-To: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
Subject: Re: [PATCH] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 10, 2026, at 12:46, Mathias Rav wrote:
> The `--object-id` option was added in commit e1068f0ad4
> ("merge-file: add an option to process object IDs", 2023-11-01)

Using `git show -s --pretty=reference <commit>` for mentioning commits
is recommended (SubmittingPatches).

> together with a call to setup_git_directory() to avoid crashing
> when run outside a repository.
>
> However, the call to setup_git_directory() is redundant when run inside
> a repository, as merge-file runs with RUN_SETUP_GENTLY, so the
> repository has already been set up. The redundant call is harmless when
> worktrees are not used, but when run inside a worktree, the
> repo_set_gitdir() function ends up being called twice.
>
> Calling repo_set_gitdir() used to be silently accepted, but commit
> 2816b748e5 ("odb: handle changing a repository's commondir", 2025-11-19)
> changed this to a BUG in repository.c with the error message:
> "cannot reinitialize an already-initialized object directory".
>
> Guard the call to setup_git_directory() behind a repo pointer check,
> to ensure that we continue to give the correct "not a git repo" error
> whilst avoiding the BUG when running inside a worktree.
>
> Signed-off-by: Mathias Rav <m@git.strova.dk>
> ---
>  builtin/merge-file.c  | 4 ++--
>  t/t6403-merge-file.sh | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 46775d0c79..a8768c6e0c 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
>  int cmd_merge_file(int argc,
>  		   const char **argv,
>  		   const char *prefix,
> -		   struct repository *repo UNUSED)
> +		   struct repository *repo)
>  {
>  	const char *names[3] = { 0 };
>  	mmfile_t mmfs[3] = { 0 };
> @@ -110,7 +110,7 @@ int cmd_merge_file(int argc,
>  			return error_errno("failed to redirect stderr to /dev/null");
>  	}
>
> -	if (object_id)
> +	if (object_id && !repo)
>  		setup_git_directory();
>
>  	for (i = 0; i < 3; i++) {
> diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
> index 06ab4d7aed..60cc43775f 100755
> --- a/t/t6403-merge-file.sh
> +++ b/t/t6403-merge-file.sh
> @@ -506,6 +506,15 @@ test_expect_success '--object-id fails without
> repository' '
>  	grep "not a git repository" err
>  '
>
> +test_expect_success 'run inside worktree with --object-id' '
> +	empty="$(test_oid empty_blob)" &&
> +	git worktree add work &&
> +	(cd work && git merge-file --object-id $empty $empty $empty) >actual
> &&
> +	git worktree remove work &&
> +	git merge-file --object-id $empty $empty $empty >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_expect_success 'merging C files with "myers" diff algorithm
> creates some spurious conflicts' '
>  	cat >expect.c <<-\EOF &&
>  	int g(size_t u)
> --
> 2.53.0
