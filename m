Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB77ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 04:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiH3ECw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 00:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3ECt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 00:02:49 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB267B1F0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:02:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g21so7582479qka.5
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=XD8w9Owjn0JaJzeZopfv1By+L5m/6Dd3RmvRB1mvjNw=;
        b=ZKzRrPOAYRceQsw34LavwsLqBAHg5ajMmKyD3eJq5r88HeTsIGAusMXTtdd62qcnD7
         Mm+ty0CCjxnvroY6oorMXV0JcS7AXGk5K7KKhRpcwN2QRVFAMJz/cil+ytpdMRobh2We
         ppeQ+99cx1y5Cv5eBIY497yvh7w22LKgru70W3Yq07U+ajlxqbtbwo1ookTEbgHmFEii
         rxn+sYVYcvkbQuQPdWtUMWqJWtusxRdFhxKmRft+2pyoa3YP1VnTL8EuMv4WVe2iWdz0
         IEbQbSElk2h7VEfnNXBvyelkdg6+de/Mn0puCEAVMym567uvjc6rQnfDvdsQn1Jh763V
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=XD8w9Owjn0JaJzeZopfv1By+L5m/6Dd3RmvRB1mvjNw=;
        b=5FpCCZmQ4UcfG34wdmO/qKv8Qa+74zfx5OuZ5KoJO+O5TeRfitKcdrfp55VLU/zkZj
         8JT8FLkE/qFQwX+ZYz7YRkx+/lCGzLu5GSgLTfYUxsWI1sB2bopNOzK7nfs9U8O0K8mw
         /YZnuY/sLUHZShatxW+AUohWPgSX17eRIlx488obtzCCs6qRLSvXYHND6ff1EyV46gNW
         70RJu/4fYkqEgibT5Lhk8WT2HyxewIfKwy0+3ii9FfYCwsj/DNccLaurNYsUkC9CPcGo
         lEYs03PbdSUKBFYqtrTb55axRQZwUPNakximXEHMg18xWimMCNtqRQ/e4/GGsFtMyyXq
         bAvg==
X-Gm-Message-State: ACgBeo1M3/uIU8s33UOf9e9qc4vbiy0SR93QXGFI1Fe7bhVdPZp3aY0H
        6F+DlD5aVyWRaDOoEXhaSmo=
X-Google-Smtp-Source: AA6agR5CasaZ7HnNvtrcDlz4gtXhsTjjlZEIZkxr/uf3+piagxxOc6UCAfxZ6UQ3UuA2mgAt2oKMPw==
X-Received: by 2002:a37:6cc:0:b0:6bc:6b03:45ca with SMTP id 195-20020a3706cc000000b006bc6b0345camr10480513qkg.429.1661832166087;
        Mon, 29 Aug 2022 21:02:46 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bl8-20020a05620a1a8800b006bbdcb3fff7sm6776086qkb.69.2022.08.29.21.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 21:02:45 -0700 (PDT)
Subject: Re: [PATCH 1/6] clone: teach --detach option
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
 <936e237c716bddf3a5889829e0c907e881736336.1661806456.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <62ae295e-64ea-eaaf-646f-030e7b9028a3@gmail.com>
Date:   Tue, 30 Aug 2022 00:02:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <936e237c716bddf3a5889829e0c907e881736336.1661806456.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-08-29 à 16:54, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> Teach "git clone" the "--detach" option, which leaves the cloned repo in
> detached HEAD (like "git checkout --detach"). If the clone is not bare,
> the remote's HEAD branch is also not created (bare clones always copy
> all remote branches directly to local branches, so the branch is still
> created in the bare case).

At first reading I thought you meant the 'origin/HEAD' symref, which is 
not the case here. I think something like this would maybe be clearer:

If the clone is not bare, skip the creation of a local branch corresponding to 
the branch pointed to by the remote's HEAD symref (bare clones...
to local branches, so that branch ...

(OK this is very verbose but in my opinion it's clearer.)

> This is especially useful in the "submodule.propagateBranches" workflow,
> where the submodule branch names match the superproject's branch names,
> so it makes no sense to name the branches after the submodule's remote's
> branches.

We are just skipping the creation of a single branch here, so it's unclear 
to me which other branches are being talked about in this last paragraph.
All remote-tracking branches are unaffected by this flag, no?

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  Documentation/git-clone.txt |  7 ++++++-
>  builtin/clone.c             | 12 +++++++++---
>  t/t5601-clone.sh            | 22 ++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 632bd1348ea..a3af90824b6 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
>  	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
>  	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
>  	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
> -	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
> +	  [--filter=<filter> [--also-filter-submodules] [--detach]] [--] <repository>
>  	  [<directory>]
>  
>  DESCRIPTION
> @@ -210,6 +210,11 @@ objects from the source repository into a pack in the cloned repository.
>  	`--branch` can also take tags and detaches the HEAD at that commit
>  	in the resulting repository.
>  
> +--detach::
> +	If the cloned repository's HEAD points to a branch, point the newly
> +	created HEAD to the branch's commit instead of the branch itself. In a
> +	non-bare repository, the branch will not be created.

Again, I think the wording could be improved, maybe something along those lines:

If the cloned repository's HEAD points to a branch, detach the newly created HEAD
at the commit at the tip of that branch. Additionnally, in a non-bare repository,
skip creating a corresponding local branch.

> +
>  -u <upload-pack>::
>  --upload-pack <upload-pack>::
>  	When given, and the repository to clone from is accessed
> diff --git a/builtin/clone.c b/builtin/clone.c
> index c4ff4643ecd..1bc1807360e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -77,6 +77,7 @@ static int option_filter_submodules = -1;    /* unspecified */
>  static int config_filter_submodules = -1;    /* unspecified */
>  static struct string_list server_options = STRING_LIST_INIT_NODUP;
>  static int option_remote_submodules;
> +static int option_detach;
>  
>  static int recurse_submodules_cb(const struct option *opt,
>  				 const char *arg, int unset)
> @@ -160,6 +161,8 @@ static struct option builtin_clone_options[] = {
>  		    N_("any cloned submodules will use their remote-tracking branch")),
>  	OPT_BOOL(0, "sparse", &option_sparse_checkout,
>  		    N_("initialize sparse-checkout file to include only files at root")),
> +	OPT_BOOL(0, "detach", &option_detach,
> +		 N_("detach HEAD and don't create branch")),

maybe "don't create any local branch" ?

>  	OPT_END()
>  };
>  
> @@ -607,10 +610,12 @@ static void update_remote_refs(const struct ref *refs,
>  }
>  
>  static void update_head(const struct ref *our, const struct ref *remote,
> -			const char *unborn, const char *msg)
> +			const char *unborn, int should_detach,
> +			const char *msg)
>  {
>  	const char *head;
> -	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
> +	if (our && !should_detach &&
> +	    skip_prefix(our->name, "refs/heads/", &head)) {
>  		/* Local default branch link */
>  		if (create_symref("HEAD", our->name, NULL) < 0)
>  			die(_("unable to update HEAD"));

OK, so the addition of that condition means that if --detach was given, we now
go into the 'else if (our)' branch, as long as 'our' is non-null, which means
that the remote's HEAD points to a branch or we gave --branch. This makes sense.
If the remote's HEAD does not point to a branch and we did not give --branch,
then we go into 'else if (remote)', as before. 

> @@ -1339,7 +1344,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			   branch_top.buf, reflog_msg.buf, transport,
>  			   !is_local);
>  
> -	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
> +	update_head(our_head_points_at, remote_head, unborn_head,
> +		    option_detach, reflog_msg.buf);
>  
>  	/*
>  	 * We want to show progress for recursive submodule clones iff
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index cf3be0584f4..1e7e5143a76 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -333,6 +333,28 @@ test_expect_success 'clone checking out a tag' '
>  	test_cmp fetch.expected fetch.actual
>  '
>  
> +test_expect_success '--detach detaches and does not create branch' '
> +	test_when_finished "rm -fr dst" &&
> +	git clone --detach src dst &&
> +	(
> +		cd dst &&
> +		test_must_fail git rev-parse main &&
> +		test_must_fail git symbolic-ref HEAD &&
> +		test_cmp_rev HEAD refs/remotes/origin/HEAD
> +	)
> +'
> +
> +test_expect_success '--detach with --bare detaches but creates branch' '
> +	test_when_finished "rm -fr dst" &&
> +	git clone --bare --detach src dst &&
> +	(
> +		cd dst &&
> +		git rev-parse main &&
> +		test_must_fail git symbolic-ref HEAD &&
> +		test_cmp_rev HEAD refs/heads/main
> +	)
> +'
> +

Tests look good.
