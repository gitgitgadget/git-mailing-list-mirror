Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DAC433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9F5601FA
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhJXSdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhJXSdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 14:33:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB91C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 11:30:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so7215285wrv.9
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bU87RMlyrMIIwsQI1Y/huY6d7iZX1hMBZvy7pBOFqGc=;
        b=fFbIn3J7W2wnpNr1nxrTINMT2k3q4wg8xyMACvTzgihcWPg3Vwm3blgR7FcX0IP+xR
         AzFYMgiM3euo22D460ANCUoMizk0vdZ/ymo4LXzAQCAhLOPMFDY0CYmyhs9Vtbw69VF8
         PGZrfHfu3SJ9W0mPZV5cD/846/fomoTw0bJkz23ySb6LvDQE7VRRF0OZtcnl6SR9szxw
         TqMSS9gIQ1YVZoiJ1oFTXg1U+dGu/y3Gd9AYvjyV0IJj6FEjkjX+QLeXfdiKD5TNY8hc
         aQTaM8T8R0OhQI8ssir6W7/SsAc9JgvgJmxm7wyWNVuZ3y3Fm6OaK3R638LwYfY5QV2C
         yxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bU87RMlyrMIIwsQI1Y/huY6d7iZX1hMBZvy7pBOFqGc=;
        b=aknFjrMNmvO49XlECnH5GcuSkycjuS0ZLCN3QEP/lHtU6ChRfeHiV4MTg9qETnMPDk
         8yVwsO9qa/uIhcZdoavi2Q1h68WLHo/1jjAu2Ddl3H3jxdN8FkGi81CUUUdYwFy7gSY6
         LK5FvTgVybtCl1i2zS4cuFcnWyHAjaGU0WkfWtwQlFhyoFpDVZtRDL+gVYmyTxSTNfgw
         5kgj/J4CtVFSajk9F2WGoOLyu2xTT3+WU4B8XKkt1Qp2JAA60M9z/dZOfs/Vd9/73x3Z
         2Fr75MPyIYO2ePn19bHLMyseerxjMEblNH1nsXDo9tVsn44tlP8eYmh0+C8fv2mCrBIz
         E7hw==
X-Gm-Message-State: AOAM532h9aMm8ngYFIY/KkwGdbWjhBbGDcd7+jAWqjFf2q2nEQW8TIoh
        inbRl5vIDxti4tQLmwaxOFM=
X-Google-Smtp-Source: ABdhPJygK1y085ztsIWJqEN0oTpO1sbErecVSlkNkfEt3G/sKsjThREBEyWvUp+oV5u8OGhyRSBRrg==
X-Received: by 2002:a05:6000:24a:: with SMTP id m10mr16983991wrz.378.1635100248167;
        Sun, 24 Oct 2021 11:30:48 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id w7sm7959356wrm.64.2021.10.24.11.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 11:30:47 -0700 (PDT)
Message-ID: <5ea4bf80-6dfb-5124-3082-c54844e11832@gmail.com>
Date:   Sun, 24 Oct 2021 19:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] checkout: fix "branch info" memory leaks
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Wong <e@80x24.org>
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
 <patch-v2-1.1-e2a166a9733-20211021T201541Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v2-1.1-e2a166a9733-20211021T201541Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/10/2021 21:16, Ævar Arnfjörð Bjarmason wrote:
> The "checkout" command is one of the main sources of leaks in the test
> suite, let's fix the common ones by not leaking from the "struct
> branch_info".
> 
> Doing this is rather straightforward, albeit verbose, we need to
> xstrdup() constant strings going into the struct, and free() the ones
> we clobber as we go along.
> 
> This also means that we can delete previous partial leak fixes in this
> area, i.e. the "path_to_free" accounting added by 96ec7b1e708 (Convert
> resolve_ref+xstrdup to new resolve_refdup function, 2011-12-13).
> 
> There was some discussion about whether "we should retain the "const
> char *" here and cast at free() time, or have it be a "char *". Since
> this is not a public API with any sort of API boundary let's use
> "char *", as is already being done for the "refname" member of the
> same struct.

I think it makes sense to consistently use "char *", the range diff 
looks good to me

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> Range-diff against v1:
> 1:  9b17170b794 ! 1:  e2a166a9733 checkout: fix "branch info" memory leaks
>      @@ Commit message
>           area, i.e. the "path_to_free" accounting added by 96ec7b1e708 (Convert
>           resolve_ref+xstrdup to new resolve_refdup function, 2011-12-13).
>       
>      +    There was some discussion about whether "we should retain the "const
>      +    char *" here and cast at free() time, or have it be a "char *". Since
>      +    this is not a public API with any sort of API boundary let's use
>      +    "char *", as is already being done for the "refname" member of the
>      +    same struct.
>      +
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## builtin/checkout.c ##
>      +@@ builtin/checkout.c: struct checkout_opts {
>      + };
>      +
>      + struct branch_info {
>      +-	const char *name; /* The short name used */
>      +-	const char *path; /* The full name of a real branch */
>      ++	char *name; /* The short name used */
>      ++	char *path; /* The full name of a real branch */
>      + 	struct commit *commit; /* The named commit */
>      + 	char *refname; /* The full name of the ref being checked out. */
>      + 	struct object_id oid; /* The object ID of the commit being checked out. */
>       @@ builtin/checkout.c: struct branch_info {
>        	char *checkout;
>        };
>      @@ builtin/checkout.c: struct branch_info {
>       +{
>       +	if (!info)
>       +		return;
>      -+	free((char *)info->name);
>      -+	free((char *)info->path);
>      ++	free(info->name);
>      ++	free(info->path);
>       +	free(info->refname);
>       +	free(info->checkout);
>       +}
>      @@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
>        	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
>       -	if (strcmp(buf.buf, branch->name))
>       +	if (strcmp(buf.buf, branch->name)) {
>      -+		free((char *)branch->name);
>      ++		free(branch->name);
>        		branch->name = xstrdup(buf.buf);
>       +	}
>        	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
>      @@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opt
>        				      opts->quiet,
>        				      opts->track);
>       -		new_branch_info->name = opts->new_branch;
>      -+		free((char *)new_branch_info->name);
>      ++		free(new_branch_info->name);
>       +		free(new_branch_info->refname);
>       +		new_branch_info->name = xstrdup(opts->new_branch);
>        		setup_branch_path(new_branch_info);
>      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>        		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
>       -	if (!(flag & REF_ISSYMREF))
>       +	if (!(flag & REF_ISSYMREF)) {
>      -+		free((char *)old_branch_info.path);
>      ++		free(old_branch_info.path);
>        		old_branch_info.path = NULL;
>       +	}
>        
>      @@ builtin/checkout.c: static void setup_new_branch_info_and_source_tree(
>        	setup_branch_path(new_branch_info);
>        
>        	if (!check_refname_format(new_branch_info->path, 0) &&
>      + 	    !read_ref(new_branch_info->path, &branch_rev))
>      + 		oidcpy(rev, &branch_rev);
>      + 	else {
>      +-		free((char *)new_branch_info->path);
>      ++		free(new_branch_info->path);
>      + 		new_branch_info->path = NULL; /* not an existing branch */
>      + 	}
>      +
>       @@ builtin/checkout.c: static char cb_option = 'b';
>        
>        static int checkout_main(int argc, const char **argv, const char *prefix,
> 
>   builtin/checkout.c                | 82 ++++++++++++++++++++-----------
>   t/t1005-read-tree-reset.sh        |  1 +
>   t/t1406-submodule-ref-store.sh    |  1 +
>   t/t2008-checkout-subdir.sh        |  1 +
>   t/t2014-checkout-switch.sh        |  2 +
>   t/t2026-checkout-pathspec-file.sh |  1 +
>   t/t9102-git-svn-deep-rmdir.sh     |  2 +
>   7 files changed, 62 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cbf73b8c9f6..96a02d223a2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -91,8 +91,8 @@ struct checkout_opts {
>   };
>   
>   struct branch_info {
> -	const char *name; /* The short name used */
> -	const char *path; /* The full name of a real branch */
> +	char *name; /* The short name used */
> +	char *path; /* The full name of a real branch */
>   	struct commit *commit; /* The named commit */
>   	char *refname; /* The full name of the ref being checked out. */
>   	struct object_id oid; /* The object ID of the commit being checked out. */
> @@ -103,6 +103,16 @@ struct branch_info {
>   	char *checkout;
>   };
>   
> +static void branch_info_release(struct branch_info *info)
> +{
> +	if (!info)
> +		return;
> +	free(info->name);
> +	free(info->path);
> +	free(info->refname);
> +	free(info->checkout);
> +}
> +
>   static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
>   			      int changed)
>   {
> @@ -688,8 +698,10 @@ static void setup_branch_path(struct branch_info *branch)
>   		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
>   
>   	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
> -	if (strcmp(buf.buf, branch->name))
> +	if (strcmp(buf.buf, branch->name)) {
> +		free(branch->name);
>   		branch->name = xstrdup(buf.buf);
> +	}
>   	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
>   	branch->path = strbuf_detach(&buf, NULL);
>   }
> @@ -894,7 +906,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>   				      opts->new_branch_log,
>   				      opts->quiet,
>   				      opts->track);
> -		new_branch_info->name = opts->new_branch;
> +		free(new_branch_info->name);
> +		free(new_branch_info->refname);
> +		new_branch_info->name = xstrdup(opts->new_branch);
>   		setup_branch_path(new_branch_info);
>   	}
>   
> @@ -1062,8 +1076,7 @@ static int switch_branches(const struct checkout_opts *opts,
>   			   struct branch_info *new_branch_info)
>   {
>   	int ret = 0;
> -	struct branch_info old_branch_info;
> -	void *path_to_free;
> +	struct branch_info old_branch_info = { 0 };
>   	struct object_id rev;
>   	int flag, writeout_error = 0;
>   	int do_merge = 1;
> @@ -1071,25 +1084,32 @@ static int switch_branches(const struct checkout_opts *opts,
>   	trace2_cmd_mode("branch");
>   
>   	memset(&old_branch_info, 0, sizeof(old_branch_info));
> -	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
> +	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
>   	if (old_branch_info.path)
>   		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
> -	if (!(flag & REF_ISSYMREF))
> +	if (!(flag & REF_ISSYMREF)) {
> +		free(old_branch_info.path);
>   		old_branch_info.path = NULL;
> +	}
>   
> -	if (old_branch_info.path)
> -		skip_prefix(old_branch_info.path, "refs/heads/", &old_branch_info.name);
> +	if (old_branch_info.path) {
> +		const char *p;
> +		if (skip_prefix(old_branch_info.path, "refs/heads/", &p))
> +			old_branch_info.name = xstrdup(p);
> +		else
> +			BUG("Should be able to skip with %s!", old_branch_info.path);
> +	}
>   
>   	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
>   		if (new_branch_info->name)
>   			BUG("'switch --orphan' should never accept a commit as starting point");
>   		new_branch_info->commit = NULL;
> -		new_branch_info->name = "(empty)";
> +		new_branch_info->name = xstrdup("(empty)");
>   		do_merge = 1;
>   	}
>   
>   	if (!new_branch_info->name) {
> -		new_branch_info->name = "HEAD";
> +		new_branch_info->name = xstrdup("HEAD");
>   		new_branch_info->commit = old_branch_info.commit;
>   		if (!new_branch_info->commit)
>   			die(_("You are on a branch yet to be born"));
> @@ -1102,7 +1122,7 @@ static int switch_branches(const struct checkout_opts *opts,
>   	if (do_merge) {
>   		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>   		if (ret) {
> -			free(path_to_free);
> +			branch_info_release(&old_branch_info);
>   			return ret;
>   		}
>   	}
> @@ -1113,7 +1133,8 @@ static int switch_branches(const struct checkout_opts *opts,
>   	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>   
>   	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
> -	free(path_to_free);
> +	branch_info_release(&old_branch_info);
> +
>   	return ret || writeout_error;
>   }
>   
> @@ -1145,14 +1166,14 @@ static void setup_new_branch_info_and_source_tree(
>   	struct tree **source_tree = &opts->source_tree;
>   	struct object_id branch_rev;
>   
> -	new_branch_info->name = arg;
> +	new_branch_info->name = xstrdup(arg);
>   	setup_branch_path(new_branch_info);
>   
>   	if (!check_refname_format(new_branch_info->path, 0) &&
>   	    !read_ref(new_branch_info->path, &branch_rev))
>   		oidcpy(rev, &branch_rev);
>   	else {
> -		free((char *)new_branch_info->path);
> +		free(new_branch_info->path);
>   		new_branch_info->path = NULL; /* not an existing branch */
>   	}
>   
> @@ -1574,12 +1595,11 @@ static char cb_option = 'b';
>   
>   static int checkout_main(int argc, const char **argv, const char *prefix,
>   			 struct checkout_opts *opts, struct option *options,
> -			 const char * const usagestr[])
> +			 const char * const usagestr[],
> +			 struct branch_info *new_branch_info)
>   {
> -	struct branch_info new_branch_info;
>   	int parseopt_flags = 0;
>   
> -	memset(&new_branch_info, 0, sizeof(new_branch_info));
>   	opts->overwrite_ignore = 1;
>   	opts->prefix = prefix;
>   	opts->show_progress = -1;
> @@ -1688,7 +1708,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   			opts->track == BRANCH_TRACK_UNSPECIFIED &&
>   			!opts->new_branch;
>   		int n = parse_branchname_arg(argc, argv, dwim_ok,
> -					     &new_branch_info, opts, &rev);
> +					     new_branch_info, opts, &rev);
>   		argv += n;
>   		argc -= n;
>   	} else if (!opts->accept_ref && opts->from_treeish) {
> @@ -1697,7 +1717,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   		if (get_oid_mb(opts->from_treeish, &rev))
>   			die(_("could not resolve %s"), opts->from_treeish);
>   
> -		setup_new_branch_info_and_source_tree(&new_branch_info,
> +		setup_new_branch_info_and_source_tree(new_branch_info,
>   						      opts, &rev,
>   						      opts->from_treeish);
>   
> @@ -1717,7 +1737,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   		 * Try to give more helpful suggestion.
>   		 * new_branch && argc > 1 will be caught later.
>   		 */
> -		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
> +		if (opts->new_branch && argc == 1 && !new_branch_info->commit)
>   			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
>   				argv[0], opts->new_branch);
>   
> @@ -1766,11 +1786,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   		strbuf_release(&buf);
>   	}
>   
> -	UNLEAK(opts);
>   	if (opts->patch_mode || opts->pathspec.nr)
> -		return checkout_paths(opts, &new_branch_info);
> +		return checkout_paths(opts, new_branch_info);
>   	else
> -		return checkout_branch(opts, &new_branch_info);
> +		return checkout_branch(opts, new_branch_info);
>   }
>   
>   int cmd_checkout(int argc, const char **argv, const char *prefix)
> @@ -1789,6 +1808,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>   		OPT_END()
>   	};
>   	int ret;
> +	struct branch_info new_branch_info = { 0 };
>   
>   	memset(&opts, 0, sizeof(opts));
>   	opts.dwim_new_local_branch = 1;
> @@ -1819,7 +1839,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>   	options = add_checkout_path_options(&opts, options);
>   
>   	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, checkout_usage);
> +			    options, checkout_usage, &new_branch_info);
> +	branch_info_release(&new_branch_info);
> +	clear_pathspec(&opts.pathspec);
>   	FREE_AND_NULL(options);
>   	return ret;
>   }
> @@ -1840,6 +1862,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>   		OPT_END()
>   	};
>   	int ret;
> +	struct branch_info new_branch_info = { 0 };
>   
>   	memset(&opts, 0, sizeof(opts));
>   	opts.dwim_new_local_branch = 1;
> @@ -1859,7 +1882,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>   	cb_option = 'c';
>   
>   	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, switch_branch_usage);
> +			    options, switch_branch_usage, &new_branch_info);
> +	branch_info_release(&new_branch_info);
>   	FREE_AND_NULL(options);
>   	return ret;
>   }
> @@ -1881,6 +1905,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>   		OPT_END()
>   	};
>   	int ret;
> +	struct branch_info new_branch_info = { 0 };
>   
>   	memset(&opts, 0, sizeof(opts));
>   	opts.accept_ref = 0;
> @@ -1896,7 +1921,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>   	options = add_checkout_path_options(&opts, options);
>   
>   	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, restore_usage);
> +			    options, restore_usage, &new_branch_info);
> +	branch_info_release(&new_branch_info);
>   	FREE_AND_NULL(options);
>   	return ret;
>   }
> diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
> index 83b09e13106..12e30d77d09 100755
> --- a/t/t1005-read-tree-reset.sh
> +++ b/t/t1005-read-tree-reset.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='read-tree -u --reset'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-read-tree.sh
>   
> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
> index 0a87058971e..3c19edcf30b 100755
> --- a/t/t1406-submodule-ref-store.sh
> +++ b/t/t1406-submodule-ref-store.sh
> @@ -5,6 +5,7 @@ test_description='test submodule ref store api'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   RUN="test-tool ref-store submodule:sub"
> diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
> index eadb9434ae7..8a518a44ea2 100755
> --- a/t/t2008-checkout-subdir.sh
> +++ b/t/t2008-checkout-subdir.sh
> @@ -4,6 +4,7 @@
>   
>   test_description='git checkout from subdirectories'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t2014-checkout-switch.sh b/t/t2014-checkout-switch.sh
> index ccfb1471135..c138bdde4fe 100755
> --- a/t/t2014-checkout-switch.sh
> +++ b/t/t2014-checkout-switch.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='Peter MacMillan'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
> index 43d31d79485..9db11f86dd6 100755
> --- a/t/t2026-checkout-pathspec-file.sh
> +++ b/t/t2026-checkout-pathspec-file.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='checkout --pathspec-from-file'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_tick
> diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
> index 66cd51102c8..7b2049caa0c 100755
> --- a/t/t9102-git-svn-deep-rmdir.sh
> +++ b/t/t9102-git-svn-deep-rmdir.sh
> @@ -1,5 +1,7 @@
>   #!/bin/sh
>   test_description='git svn rmdir'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize repo' '
> 
