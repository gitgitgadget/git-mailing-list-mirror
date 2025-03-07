Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFD218827
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348239; cv=none; b=iX3BjDjrrO2HMucpMMmsBN1/iuZ9uTykODSSqnrsudoNoIQztvVU0GAMjNNhwC63TtM68NzT9f7EqBYdFj/TjzOop5JB8dYm2HRRVLeHJ9Z6Dnvc252bTnFo7HJs+1jzd1Dc95gCtWSsEGnaWaPtZsTlQOE6RJIOgtIoUKbPiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348239; c=relaxed/simple;
	bh=K8s2uC9mX0WSLr8T/IlEmsm2a4i3rJeWO2EBxeTDZkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6PJh0eIs03PKhb3YuRbN2dDKgodTZXOF/x7wY5rwmkazXKBjuHA4whEJ7KWFpC/xDpD9wJFbJtWzknZ2z27mi6pLIAC+DaR5n3mI28KbNYvnwpml2/68QhfhxuG1sxNQDBvtXJX75LthkuuR+vrJftB7QjMsefYO0Ylhrq7J60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aRQbDpQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=go7aMg0D; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aRQbDpQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="go7aMg0D"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF8A711401D0;
	Fri,  7 Mar 2025 06:50:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Fri, 07 Mar 2025 06:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741348235; x=1741434635; bh=rWIrr/SV11
	gO8QVgYkRptrGsktQ9PX22xi3LfCvtKds=; b=aRQbDpQk7a6gwAdAbJt2w4se23
	As7kYvX75rQMFYz1ItKiraE21+M6HKcadnapfrbm8y8TlPZEUac9OeKVWIrICB57
	SZUFUi6jVihTpybr+shHXwiRwQyF5bWqdTcgt971sEZzvfPzeHhIhQ15AEjcwsVf
	UO8LS44N5vWPskt7r4m7kSsK8RyI+zzHmY4ZNG6dDnlcc1YwbE5YsuYZ/LUlq1PJ
	QJEkmPrPwa1yvgLRY9UIPROCv0A4DiqfwKBk4M/JiBiVjwfcNkPiayZAuF777BhJ
	37TkoSDN1xCYDQRZekNdX2TJrNP6920O4FTluZsEJgmLbESVwHsW2uA3ej8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741348235; x=1741434635; bh=rWIrr/SV11gO8QVgYkRptrGsktQ9PX22xi3
	LfCvtKds=; b=go7aMg0DIG3TuICkuHmLbbyXQUHVpWWIce7rS/iUQjQMP4nqlXn
	59QmMJwuSBbQNzflkjT6HVflhoHtskS57qN2/Rd1pJyFFQgl5VARN7HKyNeIApIi
	ql18/gKN2qq9wmwdrnN7ggq+Q8FX6+pCYx6xfWdI6bFKmYS8eGE3AoISI1cjzA8P
	0TOpysFArEPjrRffKjkkGTkjkmXHOMxzU7PTANyrS5gJ3owe5IeSypbJBA38xUgq
	JsljGyM7zeV8QSGBZY4RT5s5U6wtmR+Gn0oYF79xLTqaf1T55iSR4XUDJUsrckgh
	AeNnsxUlTCmy2COJKuchsZ+tAvG5MDvCcBw==
X-ME-Sender: <xms:i93KZ-KbyZTAerkm9RQJT9ZATc1bSUh6zrp9xmvpr-AHTPyLTQ3lcA>
    <xme:i93KZ2KHMnTCBWw186HtQdixuj7jWfHf4EwSVZ8F4bpSUsCj1dYsgmDmjo-3Glx7r
    UXbtkUIKlwPaWGf_w>
X-ME-Received: <xmr:i93KZ-sI3qCZ5YmAvI28fdcHmArVf5-p6ijM4mBW4elx0lUQZmVJ9dT9bwMxzld4dnn8nz1ar6Yu4p283hf577bnP09xsbhcq_3OR0VZYwyX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i93KZzZaFEIg3_Lf6-GvE4qsdK2VhPAeVKZRW0r-PIsFdFjayPUr1g>
    <xmx:i93KZ1axwqWGyz21tixIIWVs8FFvLFhnj4O8V5dApAYE9BUWlpOOxA>
    <xmx:i93KZ_BhZw-ElPu1-VmeItAfc_v7xisTBppTEI2nYpphnmNatFOE_g>
    <xmx:i93KZ7bk30xfnihV8x9NcKQk8ezJFJ6-hm5vSLl1w7A49_F9X_RqKw>
    <xmx:i93KZ0lTdhLtnBsOks-AUUs9MxUcY25xympz6T3v1Ev4ndoNNYIp0vPj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 06:50:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c27e92b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 11:50:32 +0000 (UTC)
Date: Fri, 7 Mar 2025 12:50:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
Message-ID: <Z8rdg90kxmKHHbyh@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>

On Fri, Mar 07, 2025 at 12:17:26PM +0100, Karthik Nayak wrote:
> Add a new 'drop' subcommand to git-reflog that allows users to delete
> the entire reflog for a specified reference. Include a '--all' flag to
> enable dropping all reflogs in a repository.
> 
> While 'git-reflog(1)' currently allows users to expire reflogs and
> delete individual entries, it lacks functionality to completely remove
> reflogs for specific references. This becomes problematic in
> repositories where reflogs are not needed but continue to accumulate
> entries despite setting 'core.logAllRefUpdates=false'.

I think the order of the two paragraphs should be switched: we tend to
first explain the problem before explaining how to address it.

> While here, remove an erranous newline in the file.

I suspet this should either be "extraneous" or "erroneous"? I cannot
quite tell which of both it shuld be :)

> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-reflog.adoc |  6 +++++
>  builtin/reflog.c              | 58 ++++++++++++++++++++++++++++++++++++++++++-
>  t/t1410-reflog.sh             | 55 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index a929c52982..4ecee297de 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -17,6 +17,7 @@ SYNOPSIS
>  'git reflog delete' [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>  'git reflog exists' <ref>
> +'git reflog drop' [--all | <refs>...]

Should we put the command next to `delete`?

>  DESCRIPTION
>  -----------
> @@ -57,6 +58,11 @@ The "exists" subcommand checks whether a ref has a reflog.  It exits
>  with zero status if the reflog exists, and non-zero status if it does
>  not.
>  
> +The "drop" subcommand removes the reflog for the specified references.
> +In contrast, "expire" can be used to prune all entries from a reflog,
> +but the reflog itself will still exist for that reference. To fully
> +remove the reflog for specific references, use the "drop" subcommand.

The last sentence feels like pointless duplication to me. We should
likely also point out how it is different from "delete". How about:

    The "drop" subcommand completely removes the reflog for the
    specified references. This is in contrast to "expire" and "delete",
    both of which can be used to delete reflog entries, but not the
    reflog itself.

It might also be useful to add a comment to "delete" to say that it
deletes entries, but not the reflog.

>  OPTIONS
>  -------
>  
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index f92258f6b6..232602c1a6 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -27,6 +27,9 @@
>  #define BUILTIN_REFLOG_EXISTS_USAGE \
>  	N_("git reflog exists <ref>")
>  
> +#define BUILTIN_REFLOG_DROP_USAGE \
> +	N_("git reflog drop [--all | <refs>...]")
> +
>  static const char *const reflog_show_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	NULL,
> @@ -52,12 +55,18 @@ static const char *const reflog_exists_usage[] = {
>  	NULL,
>  };
>  
> +static const char *const reflog_drop_usage[] = {
> +	BUILTIN_REFLOG_DROP_USAGE,
> +	NULL,
> +};
> +
>  static const char *const reflog_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	BUILTIN_REFLOG_LIST_USAGE,
>  	BUILTIN_REFLOG_EXPIRE_USAGE,
>  	BUILTIN_REFLOG_DELETE_USAGE,
>  	BUILTIN_REFLOG_EXISTS_USAGE,
> +	BUILTIN_REFLOG_DROP_USAGE,
>  	NULL
>  };
>  
> @@ -447,10 +456,56 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>  				   refname);
>  }
>  
> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	int i, ret, do_all;
> +	const struct option options[] = {
> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
> +		OPT_END()
> +	};
> +
> +	do_all = ret = 0;

Can't we initiailize the variables directly when declaring them?

> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
> +
> +	if (do_all) {

`do_all` and `argc > 0` should be mutually exclusive from my point of
view, as the combination does not make any sense. We should likely die
if we see both to be non-zero. Similarly, I think we should abort on
`!do_all && !argc`.

> +		struct worktree_reflogs collected = {
> +			.reflogs = STRING_LIST_INIT_DUP,
> +		};
> +		struct string_list_item *item;
> +		struct worktree **worktrees, **p;

Would it be useful to point out in the docs that we also prune logs of
worktrees?

> +		worktrees = get_worktrees();
> +		for (p = worktrees; *p; p++) {
> +			collected.worktree = *p;
> +			refs_for_each_reflog(get_worktree_ref_store(*p),
> +					     collect_reflog, &collected);
> +		}
> +		free_worktrees(worktrees);
> +
> +		for_each_string_list_item(item, &collected.reflogs)
> +			ret |= refs_delete_reflog(get_main_ref_store(repo),
> +						     item->string);
> +		string_list_clear(&collected.reflogs, 0);
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		char *ref;
> +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
> +			ret |= error(_("%s points nowhere!"), argv[i]);
> +			continue;
> +		}

Is there a particular reason why we have to double check that the reflog
that we just enumerated really exists? It feels rather unnecessary to
me.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 388fdf9ae5..b6e44ce6b9 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -551,4 +551,59 @@ test_expect_success 'reflog with invalid object ID can be listed' '
>  	)
>  '
>  
> +test_expect_success 'reflog drop non-existent ref' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog exists refs/heads/non-existent &&
> +		test_must_fail git reflog drop refs/heads/non-existent

Do we want to check the error message of the latter command?

Patrick
