Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94612045AD
	for <git@vger.kernel.org>; Fri, 22 May 2026 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414777; cv=none; b=s5B5gto8X7O/2Z/3IfUTlASCa+YqkRIgWTWjAmPMVfG82b9QuZie577CDiro07uCrUVNP3rTGVRQinDD9oBSDUbXFXMX48uy0LTATguNGsZW9gO/HMApLqI5YZqKJE5rZQKN7OhSNhSWux1mh4Oi2LwmOijuXVtdd1IUeKrxZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414777; c=relaxed/simple;
	bh=Tn2khax3xi6u78FWNYOLHZSfq6KMYydq4JWSDLudd3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rz3jBP5xDdyyiOzRQRRs+6/R99+IG/E4eLiLvx/Xh2w5Xiusj4vivFnyAiy+rir9KgwNZun01coI4bf7YOrmPelcy6Pe4deVi4WyNGZk1N8ui5neZrvAR2F011/GIBFPUgltW2TWZhcHkhfW6930r+CGtf4nsGllnm6gFvh2SEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vHaPbRxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9YvPf0Z; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vHaPbRxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9YvPf0Z"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88A017A007B;
	Thu, 21 May 2026 21:52:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 21:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779414774; x=1779501174; bh=t8IRYDCUSd
	DIXPoNQwsaxJIa9aGwTZnR6qaudIFqlQw=; b=vHaPbRxXON9P3wyVbLjUvHHN5c
	abUGTG0Pv/mnZjo3WGZ2eqC4IFTOkmhk9E5k2YaDTLEFeYwtNFTK/9fr1BctzT1V
	eibDuWvCdU0az/FIU9rnkmpfq9zNqm4zZkf8hHhDkvmMHlLOqOfyDCwvCJUP4RmE
	fl2Kl6Hfr1pZ3jfEnyrW7GA8ab/Td4t/0QWHD54a2xUTPuoMpfC/IobIxFIoHSES
	83D3vnt6TFLA37qSe/Z1E0ygY9t+Ka9asKFLWEVXnSOUV2rNyXPmUtyrS9TzmxFc
	33xfbwCp2wdT8PXPSW+72p4aUryBm8Bu/dZ2+bc5KPD0ee+fqd2ntsSdTKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779414774; x=1779501174; bh=t8IRYDCUSdDIXPoNQwsaxJIa9aGwTZnR6qa
	udIFqlQw=; b=H9YvPf0ZEMexOl3WzMqsgZj/qRd+4Hme8GLnQr6jZbThNW5JzoC
	rmF4nDoZAAaAvOYvq/+5CBhBmr/i+Wcv0RyOmsBTuazuMYGe+BCqwuu47Hl8GpSk
	c7plzSW8ecHGivC4vk6hu20+zVjEOeX4uOE1ImIZNnyMQTHrM4RZtgvrdRB9fKoC
	n/V+leP2M+/cXGFCTUypjhTxVQcZuIAfmOKHyKjrGqBhmfDvuzBRysIJbEq2qdjn
	lJpmc8KtSDqVugcySyserghULtzmpJRGmyDfHzx9uojqwPUDTYn+nFO+CT+gh89W
	4CQ+GsJ4gHmMNPGblyezWCrYLAfjcPRStVA==
X-ME-Sender: <xms:9rYParvkX3Oea5sJhOj3ldE0KM4eT0IGXqyAf47jqQOLD5GZuRjHHA>
    <xme:9rYPautphkxxx3lelDzMZyjNIn52FJuQ23_89c2-expHtX4WT-HvTk7g8WiMoISC7
    bCQ5wPyqoFx83r37zaTZDCYnewhU_qqaK4MdwDXgmJp_JffHkU>
X-ME-Received: <xmr:9rYPahAXTLJPpFkl16oE2JXPasmUL29VB-GiEoe96FLOaL-MQs0zozWBI283YVJ5gA9IK2W2TSrPtISLEiYlfIUpQGgwQ6QL9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgugh
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:9rYPagOgjfibWtgSF1CLMUgUDK-NCECBJiKrYL_pHyIzRqJxIy0iFQ>
    <xmx:9rYPaqyniHbWN_RZGJoSt_r5L0k9BLdpaAmvJY2p-O85Bp7wCgIK9A>
    <xmx:9rYPagVMsUuoDi8kr-y7dc4ahy8wA6kqJ2ziyEimTq4Uo3VDD9eaQw>
    <xmx:9rYPasM3QGNidxujex4xW-tSjmNVOgKIQNFdmBfCBHNraeFn0JS6KA>
    <xmx:9rYPat4uFUVZV8sSTIGHe5EtD4vjYMEUzG3qDurjncqtzUw58eZeIMS7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 21:52:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 1/4] branch: add --forked <branch>
In-Reply-To: <f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 21 May 2026
	22:40:01 +0000")
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 10:52:52 +0900
Message-ID: <xmqq33zkxlaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1572a4f9ef..1e24c95a69 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -28,6 +28,7 @@
>  #include "help.h"
>  #include "advice.h"
>  #include "commit-reach.h"
> +#include "wildmatch.h"
>  
>  static const char * const builtin_branch_usage[] = {
>  	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
> @@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
>  	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>  	N_("git branch [<options>] [-r | -a] [--points-at]"),
>  	N_("git branch [<options>] [-r | -a] [--format]"),
> +	N_("git branch [<options>] --forked <branch>..."),
>  	NULL
>  };
>  
> @@ -191,7 +193,8 @@ static int branch_merged(int kind, const char *name,
>  
>  static int check_branch_commit(const char *branchname, const char *refname,
>  			       const struct object_id *oid, struct commit *head_rev,
> -			       int kinds, int force)
> +			       int kinds, int force, int warn_only,
> +			       int *n_not_merged)
>  {
>  	struct commit *rev = lookup_commit_reference(the_repository, oid);
>  	if (!force && !rev) {
> @@ -199,10 +202,18 @@ static int check_branch_commit(const char *branchname, const char *refname,
>  		return -1;
>  	}
>  	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
> -		error(_("the branch '%s' is not fully merged"), branchname);
> -		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> -				  _("If you are sure you want to delete it, "
> -				  "run 'git branch -D %s'"), branchname);
> +		if (warn_only) {
> +			warning(_("the branch '%s' is not fully merged"),
> +				branchname);
> +		} else {
> +			error(_("the branch '%s' is not fully merged"),
> +			      branchname);
> +			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> +					  _("If you are sure you want to delete it, "
> +					  "run 'git branch -D %s'"), branchname);
> +		}
> +		if (n_not_merged)
> +			(*n_not_merged)++;
>  		return -1;
>  	}
>  	return 0;

This function originally was to see if "git branch -d <derived>" is
allowed to remove it by calling branch_merged(), which uses the
upstream association of <derived>, falling back to head_rev.  For
our purpose of "--forked" check, we are not deleting, so existing
calls to error() and the phrasing used in its messages that talks
about deletion are not appropriate.  Hence we introduce the
warn_only mode to just state the fact the branch is not fully merged
to its upstream.

It is inherited from the original code, and it is outside the scope
of this series, but after the dust settles, we may want to consider
saying what other branch this branch is expected to be merged to
(i.e. "not fully merged to %s").

It is unclear how n_not_merged would be useful.  Wouldn't the caller
be capable to count the failure returns from this function?

> @@ -218,7 +229,7 @@ static void delete_branch_config(const char *branchname)
>  }
>  
>  static int delete_branches(int argc, const char **argv, int force, int kinds,
> -			   int quiet)
> +			   int quiet, int warn_only, int *n_not_merged)

It is strange to see any need to touch delete_branches() when the
only thing you are adding is the "--forked" option.  For that
matter, the change to check_branch_commit() is also suspect.

In short, this does a lot more than necessary to add "--forked".
Why such a split in the series?

> +static void parse_forked_args(int argc, const char **argv,
> +			      struct string_list *upstream_patterns)
> +{
> +	int i;
> +
> +	for (i = 0; i < argc; i++) {
> +		const char *arg = argv[i];
> +		struct object_id oid;
> +		char *full_ref = NULL;
> +		const char *short_ref;
> +
> +		if (has_glob_specials(arg)) {
> +			string_list_insert(upstream_patterns, arg);
> +			continue;
> +		}
> +
> +		if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
> +				  &full_ref, 0) == 1 &&
> +		    (skip_prefix(full_ref, "refs/heads/", &short_ref) ||
> +		     skip_prefix(full_ref, "refs/remotes/", &short_ref))) {
> +			string_list_insert(upstream_patterns, short_ref);
> +			free(full_ref);
> +			continue;
> +		}
> +		free(full_ref);
> +
> +		die(_("'%s' is not a valid branch or pattern"), arg);
> +	}
> +}

This one does look like very much relevant to "--forked".

> +struct forked_cb {
> +	const struct string_list *upstream_patterns;
> +	struct string_list *out;
> +};

So does this.

> +static int collect_forked_branch(const struct reference *ref, void *cb_data)
> +{
> +	struct forked_cb *cb = cb_data;
> +	struct branch *branch;
> +	const char *upstream, *short_upstream;
> +	const struct string_list_item *item;
> +
> +	if (ref->flags & REF_ISSYMREF)
> +		return 0;
> +	branch = branch_get(ref->name);
> +	if (!branch)
> +		return 0;
> +	upstream = branch_get_upstream(branch, NULL);
> +	if (!upstream)
> +		return 0;
> +	short_upstream = upstream;
> +	(void)(skip_prefix(short_upstream, "refs/heads/", &short_upstream) ||
> +	       skip_prefix(short_upstream, "refs/remotes/", &short_upstream));
> +
> +	for_each_string_list_item(item, cb->upstream_patterns)

Sholdn't each element of upstream_patterns remember if it is
suitable for wildmatch or not when it gets parsed in the earlier
function we saw, so that this loop can refrain from calling
wildmatch() for non-wildcard elements?

> +		if (!wildmatch(item->string, short_upstream, WM_PATHNAME)) {
> +			string_list_append(cb->out, ref->name)->util =
> +				xstrdup(upstream);
> +			return 0;
> +		}
> +	return 0;
> +}
> +
> +static void collect_forked_set(int argc, const char **argv,
> +			       struct string_list *out)
> +{
> +	struct string_list upstream_patterns = STRING_LIST_INIT_DUP;
> +	struct forked_cb cb = {
> +		.upstream_patterns = &upstream_patterns,
> +		.out = out,
> +	};
> +
> +	parse_forked_args(argc, argv, &upstream_patterns);
> +
> +	refs_for_each_branch_ref(get_main_ref_store(the_repository),
> +				 collect_forked_branch, &cb);
> +
> +	string_list_clear(&upstream_patterns, 0);
> +}
> +
> +static int list_forked_branches(int argc, const char **argv)
> +{
> +	struct string_list out = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +
> +	if (!argc)
> +		die(_("--forked requires at least one <branch>"));
> +
> +	collect_forked_set(argc, argv, &out);
> +	for_each_string_list_item(item, &out)
> +		puts(item->string);
> +
> +	string_list_clear(&out, 1);
> +	return 0;
> +}

Up to point the changes are very much appropriate for adding the
"--forked" option.

> @@ -714,6 +822,7 @@ int cmd_branch(int argc,
>  	/* possible actions */
>  	int delete = 0, rename = 0, copy = 0, list = 0,
>  	    unset_upstream = 0, show_current = 0, edit_description = 0;
> +	int forked = 0;
>  	const char *new_upstream = NULL;
>  	int noncreate_actions = 0;
>  	/* possible options */
> @@ -767,6 +876,8 @@ int cmd_branch(int argc,
>  		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
>  		OPT_BOOL(0, "edit-description", &edit_description,
>  			 N_("edit the description for the branch")),
> +		OPT_BOOL(0, "forked", &forked,
> +			N_("list local branches whose upstream matches the given <branch>...")),
>  		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>  		OPT_MERGED(&filter, N_("print only branches that are merged")),
>  		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> @@ -811,7 +922,7 @@ int cmd_branch(int argc,
>  			     0);
>  
>  	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
> -	    !show_current && !unset_upstream && argc == 0)
> +	    !show_current && !unset_upstream && !forked && argc == 0)
>  		list = 1;
>  
>  	if (filter.with_commit || filter.no_commit ||
> @@ -820,7 +931,7 @@ int cmd_branch(int argc,
>  
>  	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
>  			    !!show_current + !!list + !!edit_description +
> -			    !!unset_upstream;
> +			    !!unset_upstream + !!forked;
>  	if (noncreate_actions > 1)
>  		usage_with_options(builtin_branch_usage, options);
>  
> @@ -858,7 +969,11 @@ int cmd_branch(int argc,
>  	if (delete) {
>  		if (!argc)
>  			die(_("branch name required"));
> -		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
> +		ret = delete_branches(argc, argv, delete > 1, filter.kind,
> +				      quiet, 0, NULL);
> +		goto out;

This does not belong to "--forked" as far as I can tell.

> +	} else if (forked) {
> +		ret = list_forked_branches(argc, argv);
>  		goto out;
>  	} else if (show_current) {
>  		print_current_branch_name();
