Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430A334C28
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464256; cv=none; b=ZiEhoP/TIhDk0fSomu47YhUmzpVnH7DySo67BTaoxCmqSSCE/eNI9gArwV6x+k0rJtH/Dbu+DJSrGL7zpihy4GYECEdI3ws47aQ6bzeKDgrM8zrNYUtCPGWm8gKN6YdxXJm5xwML+IYsDHaZ7PyVhaOf1hmAvqLpEQAK0k6/zxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464256; c=relaxed/simple;
	bh=kVRIZvRymxqCklBbQvXO4+SRtP6k2gIuqLxsn9GBoBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWfQiptyZlgvfkBf2v+cvL4vjE1MoJDAaRBTZzrYk/mPTpZsMLLK17boYrTTHN5rpfRr2yWPdrfuNdtSXLSSe/HZ3p14tQ9MDH+x4G3hQZcOku4hRQl5Ea4q89oSwr66D9gHL8CFJTSF4w0FFbgLSNgtlKWAsSRvzgNhBBw9fP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SeBFhgBP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sCSdjKfo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SeBFhgBP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCSdjKfo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 91B51EC024C;
	Wed, 25 Mar 2026 14:44:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 14:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774464254; x=1774550654; bh=1frHIfoo2+
	JT00GOaWVcxnh3uiJhmdSNC9eI5dIV9Zs=; b=SeBFhgBPTkjqLGPnqIwlfY1db/
	3TzzLHf8U7BTVSpq/PNMnb4bHEWwJmT098ja+VdCdQ/kArC/It481jQCqv2rT3dr
	1166WTJZTx3ypkd+/2qj+/qteo3eLj8eaWn9ZQFbquZKtthW0PJc+FI/IrGYU2XQ
	jHHj0Mx6GtI/gnt9yIBqEaR53tpIRm/odh66bndO38nX47ZCXSR6q3WUVQdsrpFv
	oLuttRNX8IqHf6g/wtbyIQ5PD7T++6tF8y/5Zcdi3Gd5XyB+VUwDzaIk+wSZtxAx
	kearh0hj39muLYnOm1HQ79+O0vEXraJ/ahpC+nxJrEPYQ7irqTAdBMIqzhlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774464254; x=1774550654; bh=1frHIfoo2+JT00GOaWVcxnh3uiJhmdSNC9e
	I5dIV9Zs=; b=sCSdjKfoNyPscZhhLwNmmfnJA1svkg336HlpAaw+GpgP/GSJQzh
	2YNzLzz+v+SNJcVlaY0bLXGx6ABxP2V/4ObDcRausJdPNaiKKcSSyGFnmP1RG4Ue
	BamPo6eU2PrY1H2Tj17S7ykrG6gh5sijSfMA9ra3eQvOqdLC73bPA22pnMJIeELn
	au6YwnWHFGOEVhZmC2P4J02ynHcYuqUJeXvOgppqD+Zd5axUD9ezMExiJenn5ryB
	HYQMJzH/Uw2cnc3knU5+45S3gb0MKsw26ISLlKgdF8T5CIEn8I/WH2JCPK6eIr7H
	VYwdYS+rZkdh6Xsm8rmHdBevtReO65y5Z2w==
X-ME-Sender: <xms:_izEaXQwu8PMIrMZRvtTva0mXgEDEn9D6fgYsVo8A_1D1Y1gaRH4BQ>
    <xme:_izEaSFJGat83_1cNaXzg7XKQbN2miFLbpqHaw7c-lwysnMZYKy1nzWavdyC0MIz9
    mIVMOE9JRWybBdA_3RwRRINesX3ZfQbgWbE9bDMn0yRexufhdV0Gw>
X-ME-Received: <xmr:_izEaUGYWQBbSOjPNYV_Mg6Noqzmw6EPc3LTzwEuWvzZp6DVGVQlgC-RxNm6PkBVPQnVL89gXa-HivdK9UbpR7ZjgqwZMOQs-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrg
    efudesghhmrghilhdrtghomhdprhgtphhtthhopeihvggvtghhvghnghdrtghhihhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_izEaYRYDO4xiTiVNTUL_g0EycviGHJ2_RmwrwmvrLOaX0ZAv3n_gA>
    <xmx:_izEadK-gJLQenpqP6LXJtzb8mtIXJcSkY6wjHWcSNJp_Vs6lGMPGQ>
    <xmx:_izEabbvpxAdkb7wDWXMEAzCgdKZ0gPTY4zzh3Go30GcRsC95OFLTQ>
    <xmx:_izEaX9w6rNQC56aVEIeSLiRzqJJiCLIUZ2-vuj_bAoQaEY3OI3TAw>
    <xmx:_izEaWJLsxhgQ-Fx62hSxUeECLj1uz1-gH57PlDFWkTJSJEt6uKjK2W4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 14:44:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Siddharth
 Asthana <siddharthasthana31@gmail.com>,  Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH v2 3/3] replay: allow to specify a ref with option --ref
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-3-553038702c9c@iotcl.com>
	(Toon Claes's message of "Wed, 25 Mar 2026 16:59:31 +0100")
References: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
	<20260325-toon-replay-arbitrary-ref-v2-3-553038702c9c@iotcl.com>
Date: Wed, 25 Mar 2026 11:44:13 -0700
Message-ID: <xmqqwlyzu4ua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> When option '--onto' is passed to git-replay(1), the command will update
> refs from the <revision-range> passed to the command. When using option
> '--advance' or '--revert', the argument of that option is a ref that
> will be updated.
>
> To enable users to specify which ref to update, add option '--ref'. When
> using option '--ref', the refs described above are left untouched and
> instead the argument of this option is updated instead.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-replay.adoc | 21 +++++++++++++-
>  builtin/replay.c              |  8 +++++-
>  replay.c                      | 33 +++++++++++++++++-----
>  replay.h                      |  7 +++++
>  t/t3650-replay-basics.sh      | 66 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 126 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index 7e749a0477..5952ecb50d 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
> -			     [--ref-action=<mode>] <revision-range>
> +			     [--ref=<branch>] [--ref-action=<mode>] <revision-range>
>  
>  DESCRIPTION
>  -----------
> @@ -66,6 +66,15 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
>  	Update all branches that point at commits in
>  	<revision-range>. Requires `--onto`.
>  
> +--ref=<branch>::

As this thing takes a full refname (e.g., "--ref=refsheads/mybranch"
in the example in hunk ll.197,+16), we probably want

    --ref=<ref>::

instead.

In the modern documentation style, this should be `--ref=<ref>`::
but let's consistently use traditional style and leave the clean-up
until the dust settles and when the command becomes more quiescent.

> @@ -188,6 +197,16 @@ NOTE: For reverting an entire merge request as a single commit (rather than
>  commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
>  which can avoid unnecessary merge conflicts.
>  
> +To replay onto a specific commit while updating a different reference:
> +
> +------------
> +$ git replay --onto=112233 --ref=refs/heads/mybranch aabbcc..ddeeff
> +------------
> +
> +This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
> +`refs/heads/mybranch` to point at the result. This can be useful when you want
> +to use bare commit IDs instead of branch names.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/replay.c b/builtin/replay.c
> index a5f81b67d4..876026549e 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -84,7 +84,7 @@ int cmd_replay(int argc,
>  	const char *const replay_usage[] = {
>  		N_("(EXPERIMENTAL!) git replay "
>  		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
> -		   "[--ref-action=<mode>] <revision-range>"),
> +		   "[--ref=<branch>] [--ref-action=<mode>] <revision-range>"),

Ditto.

>  		NULL
>  	};
>  	struct option replay_options[] = {
> @@ -102,6 +102,10 @@ int cmd_replay(int argc,
>  			     N_("branch"),
>  			     N_("revert commits onto given branch"),
>  			     PARSE_OPT_NONEG),
> +		OPT_STRING_F(0, "ref", &opts.ref,
> +			     N_("branch"),
> +			     N_("reference to update with result"),
> +			     PARSE_OPT_NONEG),

Ditto.

> diff --git a/replay.c b/replay.c
> index 199066f6b3..63cec56d48 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -348,6 +348,8 @@ int replay_revisions(struct rev_info *revs,
>  	bool detached_head;
>  	char *advance;
>  	char *revert;
> +	const char *ref;
> +	struct object_id old_oid;
>  	enum replay_mode mode = REPLAY_MODE_PICK;
>  	int ret;
>  
> @@ -358,6 +360,27 @@ int replay_revisions(struct rev_info *revs,
>  	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
>  			   &detached_head, &advance, &revert, &onto, &update_refs);
>  
> +	if (opts->ref) {
> +		struct object_id oid;
> +
> +		if (update_refs && strset_get_size(update_refs) > 1) {
> +			ret = error(_("'--ref' cannot be used with multiple revision ranges"));
> +			goto out;
> +		}
> +		if (check_refname_format(opts->ref, 0) || !starts_with(opts->ref, "refs/")) {

Can we do something about this overly long line?

> +			ret = error(_("'%s' is not a valid refname"), opts->ref);
> +			goto out;
> +		}
> +		ref = opts->ref;
> +		if (!refs_read_ref(get_main_ref_store(revs->repo), opts->ref, &oid))
> +			oidcpy(&old_oid, &oid);
> +		else
> +			oidclr(&old_oid, revs->repo->hash_algo);
> +	} else {
> +		ref = advance ? advance : revert;
> +		oidcpy(&old_oid, &onto->object.oid);
> +	}
> +
>  	/* FIXME: Should allow replaying commits with the first as a root commit */
>  
>  	if (prepare_revision_walk(revs) < 0) {
> @@ -393,7 +416,7 @@ int replay_revisions(struct rev_info *revs,
>  		kh_value(replayed_commits, pos) = last_commit;
>  
>  		/* Update any necessary branches */
> -		if (advance || revert)
> +		if (ref)
>  			continue;

Nice.

> @@ -427,13 +450,9 @@ int replay_revisions(struct rev_info *revs,
>  		goto out;
>  	}
>  
> -	/* In --advance or --revert mode, update the target ref */
> -	if (advance || revert) {
> -		const char *ref = advance ? advance : revert;
> -		replay_result_queue_update(out, ref,
> -					   &onto->object.oid,
> +	if (ref)
> +		replay_result_queue_update(out, ref, &old_oid,
>  					   &last_commit->object.oid);

Nice, too.

