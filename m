Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B8223323
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438085; cv=none; b=Y6Y8jsxzYz8TrNHPtNoM9B9XnaWgryAOkR97uRexwBQRxSk24OPGytlgbr9ueRC2Q9YHgQVyrq3CUsTb4TuUoLBZKkIbdsTocFBRatMG+jzfZaKEa8Gv6e+HGCerj8KFitBbUNWKM96eKZ7nIB8/H0ly72v89M6vzBASlqmpbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438085; c=relaxed/simple;
	bh=zhnpHprVo2vDUIhxe+yYAgUwBJlkin0NrTEkIUDbpJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3oF3Gx3ejQG0Dq4vsHUN99T9Ol5JdjPF7nDX0e7itZlu36aYEqV3DAKnzLAlrwQLwEvmK7u/HeY2h3ZpMzD1aG2RqOV9aczy+bfWq8KKeyqBMzA/s3sUX4ONrtYp5x6d6DbhNArR6qHnGs/dLJM8eW2jeSU5y3zii6bfb/+XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=adVKSg7w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tKsv4r+f; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="adVKSg7w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tKsv4r+f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3097F7A0129;
	Fri, 13 Mar 2026 17:41:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 17:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773438083; x=1773524483; bh=ax3vwz0jjt
	OrF19faBtq2DbqZfhvyseYQQPy0wEcsmw=; b=adVKSg7wzme5LhBtLF38Xee4iZ
	+fcqyTrtGMOtIcqYSIdqj4C0/rMhKXACK+k/481G7OPS2ET70SmG55iZ8/79s21c
	E3dQcSukDIggimfTyihbwNpxUwItyrmZmnuhYT74EQLkwj8yM5/B0mHzotGrqHji
	uzLfFjuoFv64Q141E5wabCu0/FF7TvicOHz5PZhPRUnh5E7DSFfggkfSqIHW+l7E
	mxyr4whq5keqGT/i27KpWdivF5YuAl4mWhUz4islzU89aqfqNqfCBJe/I4E4uPut
	rpVAM92xJayMmBNx+t8nkQrGmmZpjxJzSe86blrcqdaoxmCkRTiktDkvQZ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773438083; x=1773524483; bh=ax3vwz0jjtOrF19faBtq2DbqZfhvyseYQQP
	y0wEcsmw=; b=tKsv4r+fGVduF0iZQ0Om+e5QR3nZ0ogIDVeJ8ejEWLUnCG7uUoz
	y5FRC6pKWjQfKLhlHcukQRSxk0Kqw2w7wy/+rq64ro6lFbRQPpEjVoJQmuTWFpDJ
	6Jl0QEwsmmI/qkbA4nDa5XL7hlZADVOh8pTEw49w1tblNu71bVGCTWQBi5ltwpe4
	LZVnbd7kqSaUxFz9W+hE1nwvtMSixueSXDV71vc81EzBkETw4jyaS3YIs4h7iPAn
	8bUi/kQVZzew3uG7I5bhDCKl1MnPQCozhoclimpkfSNtR5IWD2UPCq+3I4eNF5+P
	m5oW8R70Litl8oGBtijdW2wqAzrem6qEFqw==
X-ME-Sender: <xms:goS0aUhE9OuhO5rNBmh5Qmo0kGkKro1xMKVQ21er-kUaV_eorIk8wA>
    <xme:goS0aUe6iwDrVhcuzEQg_PAjEStIGSHPRS0YJmwmeUfjQTl08ntN6kFojLlkchWdW
    xa7cXFTKmvEeNHK8Emd7aCR69I_ecpFE9Po-lqMFz6v-cVtMU5_1tI>
X-ME-Received: <xmr:goS0aZcizESqwTqOTLFE7azCc0PIJIHLQ-Vd7DedAm5M7Z0y7-tWyHa1WLWDBjDY2fwjSDdN3p8KWA_3SXl2R8CJiz73Yankpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:goS0ae_n_G_S_FskyAYvNR70qa2rHVNusIl8GYVofMCtG2Sv8KHRaA>
    <xmx:goS0aVn2xGPmD4mpAWHyWOjwLwp9CECFkH5w4HZdOFwyUz0KmJSOvg>
    <xmx:goS0aQ9bzsLqnMWPq0jyiwJwe-WwQuo2XgvGclOQuQWob55Qj9JBIg>
    <xmx:goS0aTlJU7lGTtYVyiKqfne4g5b5UxdUQ2xh-soL3rykwyhObtk7Ew>
    <xmx:g4S0aUdjJzyFOonDiPpvbQclOKSNqruYvg8ikJnp-IbhBCjdo04AmUqa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 17:41:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] worktree add: stop reading ".git/HEAD"
In-Reply-To: <ae2a368e7e783bfe9dd038bbb2e986e6d8540900.1773411586.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 13 Mar 2026 14:19:49 +0000")
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
	<ae2a368e7e783bfe9dd038bbb2e986e6d8540900.1773411586.git.phillip.wood@dunelm.org.uk>
Date: Fri, 13 Mar 2026 14:41:20 -0700
Message-ID: <xmqqjyvf2yrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The function can_use_local_refs() prints a warning if there are no local
> branches and HEAD is invalid or points to an unborn branch. As part of
> the warning it prints the contents of ".git/HEAD". In a repository using
> the reftable backend HEAD is not stored in the filesystem so reading
> that file is pointless. In a repository using the files backend it is
> unclear how useful printing it is - it would be better to diagnose the
> problem for the user. For now, simplify the warning by not printing
> the file contents and adjust the relevant test case accordingly. Also
> fixup the test case to use test_grep so that anyone trying to debug a
> test failure in the future is not met by a wall of silence.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/worktree.c      | 21 ++-------------------
>  t/t2400-worktree-add.sh | 28 ++++++++++++----------------
>  2 files changed, 14 insertions(+), 35 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index bc2d0d645ba..70410b53df3 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -692,25 +692,8 @@ static int can_use_local_refs(const struct add_opts *opts)
>  	if (refs_head_ref(get_main_ref_store(the_repository), first_valid_ref, NULL)) {
>  		return 1;
>  	} else if (refs_for_each_branch_ref(get_main_ref_store(the_repository), first_valid_ref, NULL)) {
> -		if (!opts->quiet) {
> -			struct strbuf path = STRBUF_INIT;
> -			struct strbuf contents = STRBUF_INIT;
> -			char *wt_gitdir = get_worktree_git_dir(NULL);
> -
> -			strbuf_add_real_path(&path, wt_gitdir);
> -			strbuf_addstr(&path, "/HEAD");
> -			strbuf_read_file(&contents, path.buf, 64);
> -			strbuf_stripspace(&contents, NULL);
> -			strbuf_strip_suffix(&contents, "\n");
> -
> -			warning(_("HEAD points to an invalid (or orphaned) reference.\n"
> -				  "HEAD path: '%s'\n"
> -				  "HEAD contents: '%s'"),
> -				  path.buf, contents.buf);
> -			strbuf_release(&path);
> -			strbuf_release(&contents);
> -			free(wt_gitdir);
> -		}
> +		if (!opts->quiet)
> +				warning(_("HEAD points to an invalid (or orphaned) reference.\n"));

This is indented one level too deep, it seems.

Other than that, I fully agree with the reasoning of the removal
explained in the proposed log message, and the updated test to use
test_grep does look much better.

We seem to use "[ a = b ]" instead of "test a = b" in this test
file, unlike everybody else, which I didn't notice before.  Of
course, this series has no need to touch them; it is just a tangent
I happened to have noticed.

Thanks.

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 023e1301c8e..58b4445cc44 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -987,7 +987,7 @@ test_dwim_orphan () {
>  				then
>  					test_must_be_empty actual
>  				else
> -					grep "$info_text" actual
> +					test_grep "$info_text" actual
>  				fi
>  			elif [ "$outcome" = "no_infer" ]
>  			then
> @@ -996,39 +996,35 @@ test_dwim_orphan () {
>  				then
>  					test_must_be_empty actual
>  				else
> -					! grep "$info_text" actual
> +					test_grep ! "$info_text" actual
>  				fi
>  			elif [ "$outcome" = "fetch_error" ]
>  			then
>  				test_must_fail git $dashc_args worktree add $args 2>actual &&
> -				grep "$fetch_error_text" actual
> +				test_grep "$fetch_error_text" actual
>  			elif [ "$outcome" = "fatal_orphan_bad_combo" ]
>  			then
>  				test_must_fail git $dashc_args worktree add $args 2>actual &&
>  				if [ $use_quiet -eq 1 ]
>  				then
> -					! grep "$info_text" actual
> +					test_grep ! "$info_text" actual
>  				else
> -					grep "$info_text" actual
> +					test_grep "$info_text" actual
>  				fi &&
> -				grep "$bad_combo_regex" actual
> +				test_grep "$bad_combo_regex" actual
>  			elif [ "$outcome" = "warn_bad_head" ]
>  			then
>  				test_must_fail git $dashc_args worktree add $args 2>actual &&
>  				if [ $use_quiet -eq 1 ]
>  				then
> -					grep "$invalid_ref_regex" actual &&
> -					! grep "$orphan_hint" actual
> +					test_grep "$invalid_ref_regex" actual &&
> +					test_grep ! "$orphan_hint" actual
>  				else
> -					headpath=$(git $dashc_args rev-parse --path-format=absolute --git-path HEAD) &&
> -					headcontents=$(cat "$headpath") &&
> -					grep "HEAD points to an invalid (or orphaned) reference" actual &&
> -					grep "HEAD path: .$headpath." actual &&
> -					grep "HEAD contents: .$headcontents." actual &&
> -					grep "$orphan_hint" actual &&
> -					! grep "$info_text" actual
> +					test_grep "HEAD points to an invalid (or orphaned) reference" actual &&
> +					test_grep "$orphan_hint" actual &&
> +					test_grep ! "$info_text" actual
>  				fi &&
> -				grep "$invalid_ref_regex" actual
> +				test_grep "$invalid_ref_regex" actual
>  			else
>  				# Unreachable
>  				false
