Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109D38DD3
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738261400; cv=none; b=g1bXMRlrxnzrORbqGSyM29EAV0ak9QF2AtAfJXfTcFkxYTFCanxKRuRGA1+upb7Z+HrcGa0aC/JM1vL5KY1aPmt+qU3LZQMytsJi48jNr4cOl70p5VSCOFTWFoIRez9Zfwro6f4rvFH2sUrZKI8xqumVZfUbUxGhzvFw38UFFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738261400; c=relaxed/simple;
	bh=JBNWphy6V/B+eU1AlPgMj2lJMh+Id/qPXitwTn3nWv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLxPLL2AIUXlXK30HgouZDTPoAoMkXGvha1K6E3xKzNyilBqH6wkgagUCt4SZ+i3DA8YuJ6svSXjrhmaCFwm1+0rHTiN+L7n3sV/EIaAY82OtAs3xo6G0EtkWBxsWHUXNb0j3sdZA0XZgVUw95fbTK0GoGFxTRd7esf+B/TMuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SaOyOcfX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fbph/u01; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SaOyOcfX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fbph/u01"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA0C311400DC;
	Thu, 30 Jan 2025 13:23:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jan 2025 13:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738261397; x=1738347797; bh=yZ50XbK7Q2
	0qGQiFvEl0FEOb51GAqTzpFV1NlaH0Km8=; b=SaOyOcfXl26GkynIvJYX2EeMDm
	zSxZrDk3O1cZ+fpvOSM0o2c0ImDr4ZjQlPc8R+2X3p2tBPI30kJIJEynZp8xm4mB
	B7cDwoJSJDkl12khJH2Ovhju7z62jsrj756n0JKYQ1FAPf0WpmdyPfUI20jpGyFG
	7+uAdSfYhYbZ9ot/WgfgcKLLGtu9qqHQvCwYTzaXkxSbTvEQdBkC5EBy51FoL8Lt
	UpPPFN6zy+kg9JqSl8dxTupJ/bYi56Dm1YggE1ejpydH8tP8wso+5XAgEnyu7lHH
	7K9o0eHtkVsyTX5ucsDcYE/Uhv4oZJW2/QV/42Vd6E4MmFF4ZcKYTWW3H4KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738261397; x=1738347797; bh=yZ50XbK7Q20qGQiFvEl0FEOb51GAqTzpFV1
	NlaH0Km8=; b=Fbph/u015uWJuSl4NK2P6ukcUOmVOe2EBvivuP9ambpQcThFjQA
	HdEx0CnwF9BwZoCEdlLevWuOMgXJsZs/tvY6YDoFcv1fBa0bQcdA6LqDWS28tl59
	xKYZZkVwWmZ/XCdE91rO7x9n+pFladhQoyiygAS+nVQu0csuk02EuWq2jE6Lh5Jv
	Mstk6rcjXd1dNwlT+mcG+eTjJQdLatbiy4koeSFNAfHZ+sq8NzlAGzDPMHnv538A
	t5LYRtnfrsfoDR8BAQxYIL3PVUYPDBEZ/KCxlPMKvkTGe+LkTL8ekYH8luzi9/5S
	6l3aPSSlYeBUtr3BMWu2whjgUK/EzJ0uZlw==
X-ME-Sender: <xms:lcObZwLkeyvBEotPWuZbQqB36BrOkzpdWfImvU6zFylVfkLykIvZCw>
    <xme:lcObZwL9ZwgtOafUwBk4WyGBvZ6Kx2qYEGuoloXQ-zny0dpyFoIVwXmFM77tpmxGE
    u64cTEUblQjjYQmeA>
X-ME-Received: <xmr:lcObZwvezvJsy5Vu9zf4XewPRgunCejPUQs_JlP90ejuvYHId54fKLUKTDhC5e8zJdZ9vpODQnqt6sBkYJW1cd3MW4JoI9EYGKWD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lcObZ9bYmb51EM-8MOVZZG8NNYfztTZSCMqvV5fiFFWAaEAZqyoVNw>
    <xmx:lcObZ3Zb3RX9d7u2c43wj1wsRjlfNCH6jKaDct-llQ8g1yv4yl6K-g>
    <xmx:lcObZ5CRGlW7QJHE3o8LgJnYywutoNqjUQOD7_bYOCwZinPX90-HnQ>
    <xmx:lcObZ9brdJ6WVGvTZ0YIvqn0o9n1LrC9aaYrSocnOUjTMeR7uZwoDQ>
    <xmx:lcObZ8NNkr6cpvgBNx0cGbRednssG5PrqMukGWG_txtei5yDiZVk6NBn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 13:23:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
In-Reply-To: <Z5r6-52eBgT4TUYG@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 30 Jan 2025 12:07:23 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r6-52eBgT4TUYG@ArchLinux>
Date: Thu, 30 Jan 2025 10:23:15 -0800
Message-ID: <xmqqplk4duuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> It might seems that the method one is much easier than method two.
> However, method one has a significant drawback. When we have checked the
> file mode using "lstat", we will need to read the file content, there is
> a possibility that when finishing reading the file content to the
> memory, the file could be changed into a symlink and we cannot notice.

To me, the above sounds like saying:

    The user can run 'git refs verify' and it may declare that refs
    are all good, and then somebody else can come in and turn the
    packed-refs file into a bad one, but the user will not notice
    the mischeif until the check is run the next time.

It is just the time that somebody else comes in becomes a bit
earlier than the time the 'git refs verify' command finishes, and
there is no fundamental difference.

> With method two, we could get the "fd" firstly. Even if the file is
> changed into a symlink, we could still operate the "fd" in the memory
> which is consistent across the checking which avoids race condition.

The end result is the same with the lstat(2) approach, isn't it,
though?.  'git refs verify' may say "I opened the file without
following symlink and checked the contents, which turned out to be
perfectly fine".  But because that somebody else came in just after
the command did nofollow-open and swapped the packed-refs file, the
repository has a packed-refs file that is not a regular file after
the command returns success.  So I am not sure if I am following
your argument to favor the latter over the former.  What am I
missing?

As long as both approaches are equally portable, I do not think it
matters which one we pick from correctness point of view, and we can
pick the one that is easier to use to implement the feature.

On a platform without O_NOFOLLOW, open_nofollow() falls back to the
lstat and open, so your "open_nofollow() is better than lstat() and
open()" argument does not portably work, though.

> Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
> the user if "packed-refs" is not a regular file.

Good.  Say "regular file" on the commit title, too, and it would be
perfect.

> -static int packed_fsck(struct ref_store *ref_store UNUSED,
> -		       struct fsck_options *o UNUSED,
> +static int packed_fsck(struct ref_store *ref_store,
> +		       struct fsck_options *o,
>  		       struct worktree *wt)
>  {
> +	struct packed_ref_store *refs = packed_downcast(ref_store,
> +							REF_STORE_READ, "fsck");
> +	int ret = 0;
> +	int fd;
>  
>  	if (!is_main_worktree(wt))
> -		return 0;
> +		goto cleanup;
>  
> -	return 0;
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
> +
> +	fd = open_nofollow(refs->path, O_RDONLY);
> +	if (fd < 0) {
> +		/*
> +		 * If the packed-refs file doesn't exist, there's nothing
> +		 * to check.
> +		 */
> +		if (errno == ENOENT)
> +			goto cleanup;
> +
> +		if (errno == ELOOP) {
> +			struct fsck_ref_report report = { 0 };
> +			report.path = "packed-refs";
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_BAD_REF_FILETYPE,
> +					      "not a regular file");
> +			goto cleanup;
> +		}
> +
> +		ret = error_errno(_("unable to open %s"), refs->path);
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	return ret;
>  }

Looking good.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index cf7a202d0d..42c8d4ca1e 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -617,4 +617,26 @@ test_expect_success 'ref content checks should work with worktrees' '
>  	)
>  '
>  
> +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +		git branch branch-1 &&
> +		git branch branch-2 &&
> +		git branch branch-3 &&
> +		git pack-refs --all &&
> +
> +		mv .git/packed-refs .git/packed-refs-back &&
> +		ln -sf packed-refs-bak .git/packed-refs &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: packed-refs: badRefFiletype: not a regular file
> +		EOF
> +		rm .git/packed-refs &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_done

OK.  I notice that the previous step did not have any new test
associated with it.  Perhaps we can corrupt "HEAD" *and* replace
packed-refs file with a symbolic link (or do some other damage
to the refs) and make sure both breakages are reported?

It does not have to be done in this step, and certainly not as a
part of this single test this step adds, but we'd want it tested
somewhere.

Thanks.
