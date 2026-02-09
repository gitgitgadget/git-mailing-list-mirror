Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D038170B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654872; cv=none; b=pluMW5XQUVSPG8/gVOT3+NlHZjWRLsh2acSbFz2rm8ccSUSH4uyyN116oEsTw7EsEVhd6LFmRSWjad3NaAzYOHJMgyQFQ1zLqJRVpI9r++HWw/QWFoXjSGvQn0NtMcdhUhU48oJAbwv95lAkKc8Ljt19ipSDp3q83x0hRMmA8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654872; c=relaxed/simple;
	bh=X0+GAa6S29i1lOi+vB4rBwpPWk6tK5XflZaLtAWKKF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8HvP4or8CVgnYUf5XxPL4iTnJ7tsOmGiPCGr8h142dAI/NEZFQ98bgO8JKlGYfy6ytHZKo6EpBl+hf8uAi3iQvzqJcYGJYp7OZb1ziX9nMRJWNqeSf0v/CT4bTms1zlryj0yHuGnunuXZuchuZbKWECLcEjsENaJb/C1tCyKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OWgQeodE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOUHH7aX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OWgQeodE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOUHH7aX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 221F17A0227;
	Mon,  9 Feb 2026 11:34:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770654871; x=1770741271; bh=YGx0/XsvMY
	Mp85CmCY7eIeq33/04qvaNgHdnRypYeEY=; b=OWgQeodEPBbaDgg1LFse2ph6ga
	M49aHDgVAQEXYhvpif3wE842oESgHPrQxkEGD8xVas2IZbXXaGXfp06zEF6d64Qs
	xPpXvvtMSvJbWd/DkNg0CQLYmANXoyUyzVsmvA2VKRYvBD9yjJd5mCwEa/B6aXaf
	kEu5IEb79rSSDCeiLtRv69yn47t8JPOdNoMIooNgZLvcGNDNi3VwdknicxOhvzs8
	8UfvKLTf1CgasQ7xT98NjXLWmJzAusGaOx3PZj7KAugbfXsdtz0JnOiiCZfLqVez
	+MiV3bXbQFMr1ygwY7SXfJyAyrpgXK2M3gK3hCUJ5894AarHc7Tk62nvaSIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770654871; x=1770741271; bh=YGx0/XsvMYMp85CmCY7eIeq33/04qvaNgHd
	nRypYeEY=; b=IOUHH7aX88Wg7hy7XYtt9QTO2gzBfBK9lYFRIEHFxJ5S4bn0xcw
	IegpVih/yIX0xVR7GauzRI7IHca/NzN/Lq8K//k2y0MqW6HxfFIxuj50LXYNcUfm
	aBxED15vM1LzF2e7O38UtTFZ0NPXDNxyvv+s2/58kPIkw1vG0w5lVioMtS7ULuNd
	rq/Co0hqRIWdLBM3OQS8+xq3B1FSGKNjfw5mCWFv/Tt3JaWpDcf23NMRU+TH9CEn
	ZJiyN+5ns5xBC8Vo2mhq3saVoeALoRYGkkfSjpUY/Nv+bEIWYkxWOBO9i8fFBVs+
	sdhrZu+zeaJ9J80NZxjT4dlLelBYDZTnfHw==
X-ME-Sender: <xms:lwyKaQZWQhvu82UDiYNxAO03C2kL9zStX9OFjZqEvCaPTylkdjdEsg>
    <xme:lwyKaSbFPhmGfgPii2Gu59O9M9teIFXZaDkni5SxIYChXbIwsSCRKdkL_O_mu23oX
    6zV-u_b2IhA8MRY9EOwJC4UM2OAwA-vCnkvkigi9gfx4GKG0LBlGTM>
X-ME-Received: <xmr:lwyKaf8izEVUrfCL0x1Eg9Y95ldlbCryAkFTn8aPzby8rMGDbiZxxjXcIysp-mKXR77JTG_s0Xm9iFYkR_dCYfxUrsbv9Tbeb0P3Y9sFDPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lwyKaZgOkF2jAGZm0fYehooEDGPpG9YALIBcXXqm8Q0L8IoClZ-NHg>
    <xmx:lwyKaXf80zRdEqeuNsuJZHK0CAt0I1KJallIemz1vjsUFn3Hy9jfqQ>
    <xmx:lwyKaYq2XzFReKi1s_ZTrqzzrk-82UnzDEOfi_iTTrGMIj4pVMBR9w>
    <xmx:lwyKaUDI435pHoFsmIVdlN5yWlF4x-q_CXnoFoQwNxnQUfIwhHpbLA>
    <xmx:lwyKaU-CHB2jhKDlVG45xuO4QqDeguDu8811ifzSGJcduuwfQgh4riV4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 11:34:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d4d2e68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 16:34:30 +0000 (UTC)
Date: Mon, 9 Feb 2026 17:34:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v5 3/4] refs: allow reference location in refstorage
 config
Message-ID: <aYoMk5HmpSyN1azt@pks.im>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com>

On Mon, Feb 09, 2026 at 04:58:20PM +0100, Karthik Nayak wrote:
> The 'extensions.refStorage' config is used to specify the reference
> backend for a given repository. Both the 'files' and 'reftable' backends
> utilize the $GIT_DIR as the reference folder by default in
> `get_main_ref_store()`.
> 
> Since the reference backends are pluggable, this means that they could
> work with out-of-tree reference directories too. Extend the 'refStorage'
> config to also support taking an URI input, where users can specify the
> reference backend and the location.
> 
> Add the required changes to obtain and propagate this value to the
> individual backends also add the necessary documentation and tests.

This reads as if this should have been two sentences.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index fbdaf2eb2e..94480be5c4 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -425,6 +425,39 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
>  	return run_command(&cp);
>  }
>  
> +/*
> + * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.

s/worktress/worktrees/

> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> new file mode 100755
> index 0000000000..9c777b79f3
> --- /dev/null
> +++ b/t/t1423-ref-backend.sh
> @@ -0,0 +1,159 @@
> +#!/bin/sh
> +
> +test_description='Test reference backend URIs'
> +
> +. ./test-lib.sh
> +
> +# Run a git command with the provided reference storage. Reset the backend
> +# post running the command.
> +# Usage: run_with_uri <repo> <backend> <uri> <cmd>
> +#   <repo> is the relative path to the repo to run the command in.
> +#   <backend> is the original ref storage of the repo.
> +#   <uri> is the new URI to be set for the ref storage.
> +#   <cmd> is the git subcommand to be run in the repository.
> +run_with_uri() {
> +	repo=$1 &&
> +	backend=$2 &&
> +	uri=$3 &&
> +	cmd=$4 &&
> +
> +	git -C "$repo" config set core.repositoryformatversion 1
> +	git -C "$repo" config set extensions.refStorage "$uri" &&
> +	git -C "$repo" $cmd &&
> +	git -C "$repo" config set extensions.refStorage "$backend"
> +}
> +
> +# Test a repository with a given reference storage by running and comparing
> +# 'git refs list' before and after setting the new reference backend. If
> +# err_msg is set, expect the command to fail and grep for the provided err_msg.
> +# Usage: run_with_uri <repo> <backend> <uri> <cmd>
> +#   <repo> is the relative path to the repo to run the command in.
> +#   <backend> is the original ref storage of the repo.
> +#   <uri> is the new URI to be set for the ref storage.
> +#   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
> +test_refs_backend() {
> +	repo=$1 &&
> +	backend=$2 &&
> +	uri=$3 &&
> +	err_msg=$4 &&
> +
> +	git -C "$repo" config set core.repositoryformatversion 1 &&
> +	if test -n "$err_msg";
> +	then
> +		git -C "$repo" config set extensions.refStorage "$uri" &&
> +		test_must_fail git -C "$repo" refs list 2>err &&
> +		test_grep "$err_msg" err
> +	else
> +		git -C "$repo" refs list >expect &&
> +		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
> +		test_cmp expect actual
> +	fi
> +}
> +
> +test_expect_success 'URI is invalid' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_refs_backend repo files "reftable@/home/reftable" \
> +		"invalid value for ${SQ}extensions.refstorage${SQ}"
> +'
> +
> +test_expect_success 'URI ends with colon' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_refs_backend repo files "reftable:" \
> +		"invalid value for ${SQ}extensions.refstorage${SQ}"
> +'
> +
> +test_expect_success 'unknown reference backend' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_refs_backend repo files "db://.git" \
> +		"invalid value for ${SQ}extensions.refstorage${SQ}"
> +'
> +
> +ref_formats="files reftable"
> +for from_format in $ref_formats
> +do
> +
> +for to_format in $ref_formats
> +do
> +	if test "$from_format" = "$to_format"
> +	then
> +		continue
> +	fi
> +
> +
> +	for dir in "$(pwd)/repo/.git" "./"

As "./" is a relative directory I expect it to be resolved relative to
"$GIT_DIR", right? Also, I don't see any tests that create the ref
directory outside of the repository. Should we maybe add one?

> +	do
> +
> +		test_expect_success "$read from $to_format backend, $dir dir" '
> +			test_when_finished "rm -rf repo" &&
> +			git init --ref-format=$from_format repo &&
> +			(
> +				cd repo &&
> +				test_commit 1 &&
> +				test_commit 2 &&
> +				test_commit 3 &&
> +
> +				git refs migrate --dry-run --ref-format=$to_format >out &&

Okay, we do the migration, but with "--dry-run". This should result in a
temporary staging directory, which is in fact somewhat interesting given
that "to_format" can now contain a payload. I assume it wouldn't have an
impact if such a payload was set here?

> +				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&

Hm. I have no idea what this is doing :)

> +				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
> +			)
> +		'

In general I think it would be sensible to also have a couple tests here
that exercise specific formats directly. Like:

  - Are the files created in the right spots for the files and reftable
    backend with a specific backend?

  - Does `git refs migrate` know to write the files into the correct
    location in case "--dry-run" wasn't passed?

  - Does git-init(1) and git-clone(1) initialize the refstore in a
    different location as expected?

  - Does creating a worktree work?

Patrick
