Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF13AFD1E
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378698; cv=none; b=uM+KwcCugJyrQFXVvQJ6O4g/ERxbr6MoWf7Q7NyEWIZHsoFCmX/TZg9TonK4tVp4uIlEtC50bdxnEHTjeX9Zp+LvwhHC3BRNzA25Od7D+cRj55BzvcEd2CdjO+FfQJ7ZkApYiP6XMqoJv0LQwaKvaTWr06TQ0Lyte1/S4kjMlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378698; c=relaxed/simple;
	bh=wjoQyWwDAli60Y7JletRAgD2+n7NhDy2hKckwNolbjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZRhItq8+fCtf0j9Hj/PZ506n+XnYMAlOTL9SEey7SYUAg4CfA9XYzOe9HyMCm6H684gtDBRPknquQfBU7zhRVTgHq+ki0Qh3cBMA8iWWgwg8rhWzPtcm98JK8rG6KGWKwKStrqgWoWXaG2HcRk78dTIEjtBpGG367dRhY28u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PBHJcxRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XfSlljTQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PBHJcxRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfSlljTQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96E8F7A00E1;
	Wed,  2 Sep 2026 15:51:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 15:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788378693; x=1788465093; bh=6BUxYwFQir
	1RduMWWGXmL/XIXuHUpkWXruFdQ1pbLI0=; b=PBHJcxRuwyF6suie2NuHpygOgm
	0Q2UXawuV1scMpE90Gkg6uXyNk+gAIjO+O4fEqFTJHicB97osL1iazXNcyL4IYtH
	pvJAJ+OuxTDm/cjp4dKUkAq+0KSAJwuQpaM/1//0O0RTky8Nl7076uslEyKQN4So
	j8xLpsphs1DIPur8EoSLVnKaujW5jGRzBMZ3jmN+qyLDkPdyBK2PxSB/rcGeYOZ0
	ZZBnQe8uoH7WYrvLfjRd/J1CN4CbTQ8p3l3FCWRfJsSr95A50ztAEjsLtd/32J38
	h/kLbZYcFiuftMkXxZ1c+m8iSqNG860rieNMJ5q1Swd4TbufyiC1bvSGH3jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788378693; x=1788465093; bh=6BUxYwFQir1RduMWWGXmL/XIXuHUpkWXruF
	dQ1pbLI0=; b=XfSlljTQdY3UPOd2SpRmE+53ptwWuMciDuijxavrlMGkPN+DV0d
	GRcf/cBcJGfpLZCfLGyz4I2eBw57O2UlWUr12YTCW8wmVF+m2TZ4NKrGsyGJ3dOv
	MUBEC4BxomcA3PGHce1Ykb3jyWGvYzCrNdR3erR3kqlSmlmK1EPmvYvJZ2QmPbjL
	LcXhGQqKfZmO1S+FCXxm2aqAW0AluTdvp292jauq4N5246VrYq3aJoWI/lN9P254
	LcCNSKukKYT4qIxPQfljelJ/pqRIXpSB6xptmYWsZ69VLjHeXihEfeW3hUvPZzjj
	SynB3uc3JT0q0mshHyZACXkX0SpNFgvgYiQ==
X-ME-Sender: <xms:RX6Yapq18k8OxQ8Dw1uiIQUk2JZDToQjt0Y-4MHSgzjyAoX0JxaZLQ>
    <xme:RX6YaiiVpCqqFUdw9K1bEY0XDOIEy5fwoZXaKm6UwnU_N_9K8J9Z5ECAJrDmT6Us0
    tR_csW8dMeBKg1Zl37fj6uCGWIsoi5sUk79TUOidxRvg69RgKUP>
X-ME-Received: <xmr:RX6YaugECNpYYfhyLLevROlJL_HhHEg7TTFMl5ZCTVimSegd9i1pymllNDN92EFcJJ6ISx_AoII-5rr489Kfd92tVB1N1Ap5lA>
X-ME-Proxy-Cause: dmFkZTF9xYGVwqUG+lXw1HXtf6YNnIOGPXWkb9HZjFw5+XIhffgaubiZmlo05W7sD4q73N
    xnM2NoUiUEYRn5np93cAlWLKmoxJfGr6OGBkkTs3pfrbCnDSoWQlDJXXa7iYs3pQ/Um6bv
    Zrb66dmieCpbqh+uzkXS+xXaHO/15hy3HdvMcX2ij5d4IAv3vjVmYa+jo+rpCgPQQbdvR5
    CyGZPWXnazbIzCCwnp4C/OWPU3uym91zHXZFWpG5dj2IswmS/Sdsgk7hdeBX8cY0OLtdsX
    x9VO/z6j76WcR6Ht1NzPsf+hSYiTGf39HXv9bndtYG2AfJUpu19/FGI/X+MQRpu8tbFkWh
    AUnvf+kBwiFbRUVaGMC40E59P9osYr9ui39KQEco7/fmVQsXdqqJSkys9SshYb4yPE2cEz
    cBEMmJkytXbe1F400O8eiOonp2P1PlM5BRYb4JnQA0BWB+E4UBlQePP/c6dNzdvdSOD/x1
    ObWl3iabBjGnz/0toawNLKs2m3jUqlBAfACFVJINeEElI/2cI5wNIhc0Fo5KLGcdebWm5I
    6/uje+HCta+8GGQMhPmtVbHDQvWURcra5gANZBM3WR36HU3CSKqh5r/CNtRlbZoiZYZNlA
    ZEinX4b8NtjC0fgcwl77tomlrDPVveMbhhztkqmV4Blr6troATgTeJgmVN6Q
X-ME-Proxy: <xmx:RX6YagixU0UJ8AviTLiQ-2DIpkuAk3L07gfiSWk84dSgfogsFFfaGA>
    <xmx:RX6YamJNJQ68hIyNlghwPUllHchj2rBXHb21aEGLtCsFUecjcqEOag>
    <xmx:RX6YanFYvN8zuvoNdEQx6jbBqFbSwxAqQeKz_B6wHq0fo75GvAYyIA>
    <xmx:RX6YaiR2DFdVCLdn-FRJzrw0z2_vbU8WuIzV8U71luPddvd4MXlTOg>
    <xmx:RX6YajytjiWrnIytHRGa9-mGTsROusCeEc2ZD1Q1FSpMyTP2xHXk1ldK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:51:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
In-Reply-To: <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 02 Sep 2026
	18:29:02 +0000")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
	<ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 12:51:31 -0700
Message-ID: <xmqqwlt3h1oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git stash apply", "pop" and "branch" exit with status 1 both when
> applying the stash entry resulted in conflicts and when they fail for
> other reasons, so callers cannot tell the two apart.
>
> Follow the convention of "git merge-tree" and the merge strategies,
> which exit with status 1 to indicate conflicts and with a different
> non-zero status for errors: those subcommands now exit with status 1
> only when applying the stash entry resulted in conflicts, in which
> case the stash entry is left in place, and exit with status 128, the
> status die() uses, when they fail for other reasons.  Document the
> exit statuses.
>
> cmd_stash() used to collapse the return values of the subcommand
> implementations to a boolean.  It now maps negative values, which
> signal a failure, to 128 and passes everything else through as-is.
> The only implementations that return a positive value are "apply",
> "pop" and "branch", which return the value of do_apply_stash():
> "apply" returns it directly, and "pop" and "branch" drop the stash
> entry, via do_drop_stash(), which always returns 0, only when the
> application succeeded.  The positive value is always 1, as
> do_apply_stash() only returns a positive value when the three-way
> merge was unclean.
>
> Make the convention explicit by introducing enum stash_apply_result
> with the values STASH_APPLY_CLEAN, STASH_APPLY_CONFLICT and
> STASH_APPLY_ERROR, and use it for the in-process autostash helpers,
> too.  They spawn "git stash apply" and can now tell conflicts apart
> from other failures, e.g. a crash or death by signal of the child,
> which map to exit statuses above 1.  Since we know the stash entry
> was saved, tell users so in the error message instead of leaving them
> wondering what happened to their stashed changes.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

The above is on the overly verbose side.  The first two paragraphs
give enough discussion and the remainder mostly repeats with small
details sprinkled in, which can probably be shortened to 1/4 of the
amount of text, but it is OK.

> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index 50bb89f483..fc6a9a008c 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -426,6 +426,15 @@ include::includes/cmd-config-section-all.adoc[]
>  :git-stash: 1
>  include::config/stash.adoc[]
>  
> +EXIT STATUS
> +-----------
> +
> +The `git stash` subcommands exit with status 0 on success.  The
> +subcommands that apply a stash entry, i.e. `apply`, `pop` and `branch`,
> +exit with status 1 when applying the stash entry resulted in conflicts,
> +in which case the stash entry is left in place, and with a non-zero
> +status other than 1 when they fail for other reasons.
> +

Great.

> +static enum stash_apply_result do_apply_stash(const char *prefix,
> +					      struct stash_info *info,
> +					      int index, int quiet,
> +					      const char *label_ours,
> +					      const char *label_theirs,
> +					      const char *label_base)
>  {
>  	int clean, ret;
>  	int has_index = index;
> @@ -717,8 +720,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  
>  	/*
>  	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
> -	 * merge was clean, and nonzero if the merge was unclean or encountered
> -	 * an error.
> +	 * merge was clean, and 1 if the merge was unclean or a negative value
> +	 * if it encountered an error.
>  	 */
>  	ret = clean >= 0 ? !clean : clean;

OK.

> +	if (fn) {
> +		ret = fn(argc, argv, prefix, repo);
> +
> +		/*
> +		 * The subcommand implementations return 0 on success, a
> +		 * negative value on failure, and STASH_APPLY_CONFLICT
> +		 * when applying a stash entry resulted in conflicts.
> +		 * Map failures to 128, the status die() uses, so that
> +		 * exit status 1 unambiguously indicates conflicts.
> +		 */
> +		if (ret < 0)
> +			return 128;
> +		return ret;
> +	} else if (!argc)
>  		return !!push_stash_unassumed(0, NULL, prefix, repo);

Style.  Once one of "if", "else if" and "else" cascade gains
{braches}, others should do so as well.

> +static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
> +							int attempt_apply,
> +							const char *label_ours,
> +							const char *label_theirs,
> +							const char *label_base,
> +							const char *stash_msg)
>  {
>  	struct child_process child = CHILD_PROCESS_INIT;
> -	int ret = 0;
> +	enum stash_apply_result ret = STASH_APPLY_CLEAN;
>  
>  	if (attempt_apply) {
>  		child.git_cmd = 1;
> @@ -4816,9 +4819,11 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>  			strvec_pushf(&child.args, "--label-base=%s", label_base);
>  		strvec_push(&child.args, stash_oid);
>  		ret = run_command(&child);
> +		if (ret > 1)
> +			ret = STASH_APPLY_ERROR;

This kind of code that assigns any random "int" that is returned by
run_command() to "enum ret" that has much narrower valid value range
and then makes corrections annoys me a bit.

One way to do this cleanly might be to make a small helper function
do_stash_apply(), and use it like so:

	if (attempt_apply)
		ret = do_stash_apply(stash_oid, label_ours, label_theirs,
				     label_base);

The implementation of do_stash_apply() would be like what you have
in "if (attempt_apply) {...}" block, perhaps like:

	static enum stash_apply_result do_stash_apply(const char *stash_oid,
						      const char *label_ours,
						      const char *label_theirs,
						      const char *label_base)
	{
		struct child_process child = CHILD_PROCESS_INIT;

		child.git_cmd = 1;
		...
                strvec_push(&child.args, stash_oid);
                switch (run_command(&child)) {
		case 0: return STASH_APPLY_CLEAN;
		case 1: return STASH_APPLY_CONFLICT;
		default: return STASH_APPLY_ERROR;
		}
	}

> -	if (attempt_apply && !ret)
> +	if (attempt_apply && ret == STASH_APPLY_CLEAN)
>  		fprintf(stderr, _("Applied autostash.\n"));
>  	else {
>  		struct child_process store = CHILD_PROCESS_INIT;

Good, and the rest of this function is good.
