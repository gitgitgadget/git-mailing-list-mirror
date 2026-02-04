Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798A33F394
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224267; cv=none; b=gbiWAURpv/01wM+Ub0o/Pq1VZ+9wjg2+98Wf0/RAqc0a4PJ02QJyhefXBdcsWg0zft/cJ2dIxDiWis/91btf7HxVLnj1SVtlenjyVzylvRCFsn3y2dpEi6vIeQGGyyf/DgmzMWZ1vcwPaTwXqMKUIiHe5+MhMeL0L7x39g+YRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224267; c=relaxed/simple;
	bh=gWdqK/hJWsAikKhNijujL+XsqQ7sql8kOFEKYD/AXhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+T5z0eONfQwwWE0EMQI7IUUM9WuKTck0CzY6NZP/tKNeZMkeEKOLtlzKWkNaBhflRbkXqDuKIlE5mPy8Bhse/QiSnE/kmq7Z3Kv9C7rnx7MaLRZY9I/EuaNkQyPv3zVaScG+JkEytiJTnS81AqvIArqesIfRVrXH3xJLoQlGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es95l0SO; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es95l0SO"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b885e8c6700so1171289966b.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770224265; x=1770829065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c8NOV/Q5KkTkdZkASIWDgd9WVYItNlZotCtpH62BqQI=;
        b=es95l0SOyZtTij9Q/OGJjRTs1Tjz3qQkqVa+ZR7ICydO34kAes/oj8FUV3CzVpDWH1
         VlSrMjeYNI5cpro7USU79Jfd08o7BcrMmiRHORewQuOG/JVenmErCnD18bMD5VgMSaYI
         781Y7FN8jidFyXdvgrSJjSEeTDuoqjUc8NbS5Z/KMHrTad58cA82d1HYsCdT//ag8KAt
         wtHME/kfZzqUeL+TQahljLJOxpB1V9FyM2SK+f5kdNrMVg5bCZ0URm5bApLwLt9yY2UD
         l+1fgEIQl+KJUcVseVeq1Dl2uDsML1T3qJ6bztv0PN2fxiIy/4TDTBc8bxZfJ0XjdZ0k
         QPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224265; x=1770829065;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8NOV/Q5KkTkdZkASIWDgd9WVYItNlZotCtpH62BqQI=;
        b=TU/Hkfzx9/pzhDj/l1GLrkPCTCF5mHzCov8x4u1mSlnn6ftoztkHaDkR31ASFvxC2q
         35sGn/yTbHCWGD+Siki4dJoYeHfhf6oceoWo88/PDWqzdaLlRcoxtZyXnvIAEzhsqVqt
         ayfKnibCdbGo1SeAtSWXCGjReNPT3EJsuBWTHmTnT24/kwrISnBjEGR+DL2inueqAcjl
         oSiz2ftx00I/PgaqnGXWaLUDDBInhoNKKs/SMD8panaTaF5zXpSuz5YG8uOK8GuFILFP
         HIr3rp3JauFR0+MGh44fKJUYAs8qdCkBKt5vF6+erAAi70O/xiMs+Oib+EK7kWHxQyIS
         bvvA==
X-Forwarded-Encrypted: i=1; AJvYcCVzPHFsbtXT9W2jQnodmGt6gr5e865YfYB/zvi5gFzfxy5uGXzFS/KT0qfvCG4dTvQSpfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9h97csKLkLbdHoaMCC8uw6CsvBVxphQdiifJ3tK8rYj58jcU
	RDXjmNVjBf3aTetD3OxURutdQM5VHK9mH1CVqziZX7ppv9IYnhU5736j
X-Gm-Gg: AZuq6aLLuu1+bXDTuhUJWBU6pztjZl9GkdwyQa9jKl87C2Ll2ZNqk9aGb/xiJcVMj1U
	zizYx5XRu0lDw1S/mh02UcVm/+7dsOjSytJVcdcvVzOmW+W6Ypk3pt+0soFuSTqx9F1BGo7MAZJ
	dqM1z5uSsfMpjbGZZeWzEn/hnDU70Dgv4u4HFnbOROuf+4v+ln+xaG6wFv/LoDoGviQAuKek1bO
	g0BC+YaEpEsOYZJCH8ILEsYTys+TpyKPe+sN8VLqlhGv+7cbMijbRg3Mz6AesqO2pbEMQOjfG16
	v+EnX71D7zRqi6IOYhXNOzFjMxSv5blCzsXNL++P25vtRT+DfgBI9KEQfu/HuHW8ALb9DPpeFbi
	+uPIPqazV8b91zKtr0VD9W1Cy802x7SQrQfa/DUpYUPJ1Drvdi602HZHbzV5/96t72853XnMCPl
	VYF2L/bzBAc5jJmTsYGgaDDHyGTxqa78SJV8tkye2ojuh/iTYb3yxRp7w8VpxHfg0ANQ==
X-Received: by 2002:a17:907:ea7:b0:b80:5ae7:5d94 with SMTP id a640c23a62f3a-b8e9f10a7acmr234876066b.7.1770224264533;
        Wed, 04 Feb 2026 08:57:44 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fd10f2asm139306966b.23.2026.02.04.08.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:57:44 -0800 (PST)
Message-ID: <71b88eca-54b4-49f3-8802-69ff479f1f9c@gmail.com>
Date: Wed, 4 Feb 2026 16:57:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 0/3] store repo specific config values in new
 `struct repo_config_values`
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com
References: <cover.1769256839.git.belkid98@gmail.com>
 <cover.1770127568.git.belkid98@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1770127568.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olamide

This version looks pretty good. I've left a couple of suggestions, but 
the changes since v4 look good.

Thanks

Phillip

On 03/02/2026 15:42, Olamide Caleb Bello wrote:
> Hi Git Community,
> Over the course of my ongoing internship, which focused on moving repo specific
> global variables in environment.h into local scope, I have attempted to move some
> variables into the struct repo-settings.
> However there has been some design concerns as regards the use of
> `prepare_repo_settings()` with respect to when and where to call the
> function, and also the change in behaviours when the variable is lazily
> loaded as discussed in [1] and [2].
> 
> After different deliberations, Phillip Wood proposed creating a new config
> struct [3], adding it to the repository struct and passing the repo struct to
> `git_default_config()` to store parsed repo specific config values per repo.
> This ensures the current behaviours will be retained.
> 
> I have experimented with this approach for some values and I would
> appreciate feedbacks about this approach before we can move forward
> and use it for more variables related to `git_default_config()`.
> 
> For now, the parsed value is stored in `the_repository` in
> `git_default_*_config()` and further efforts to pass the repository
> parameter to `git_default_config()` as the callback parameter will
> be looked into later on.
> The link to the CI tests can be see in [4] and [5]
> in the CI, some BUGs were gotten as a result of double initialization
> 
> 1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
> 2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
> 3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com
> 4. https://github.com/git/git/actions/runs/21633462506/job/62352191148?pr=2166
> 5. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2303203992
> 
> Changes in v6:
> ==============
> - Added a new accessor function 'repo_config_values()' which ensures we detect
>    if a repository has been initialized already
> - Changed the member name to 'config_values_private_' to indicate this member
>    is private
> - Modified commit message of patch 1 to reflect these changes
> 
> Olamide Caleb Bello (3):
>    environment: stop storing `core.attributesFile` globally
>    environment: stop using core.sparseCheckout globally
>    environment: move "branch.autoSetupMerge" into `struct
>      repo_config_values`
> 
>   attr.c                      |  7 ++++---
>   branch.h                    |  2 --
>   builtin/backfill.c          |  3 ++-
>   builtin/branch.c            |  3 ++-
>   builtin/checkout.c          |  3 ++-
>   builtin/clone.c             |  3 ++-
>   builtin/grep.c              |  2 +-
>   builtin/mv.c                |  3 ++-
>   builtin/push.c              |  3 ++-
>   builtin/sparse-checkout.c   | 31 ++++++++++++++++++++-----------
>   builtin/submodule--helper.c |  3 ++-
>   builtin/worktree.c          |  3 ++-
>   dir.c                       |  3 ++-
>   environment.c               | 28 ++++++++++++++++++----------
>   environment.h               | 17 +++++++++++++++--
>   repository.c                | 12 ++++++++++++
>   repository.h                |  7 +++++++
>   sparse-index.c              |  6 ++++--
>   unpack-trees.c              |  3 ++-
>   wt-status.c                 |  4 +++-
>   20 files changed, 104 insertions(+), 42 deletions(-)
> 
>   Range diff versus v5:
>   =====================
> 
>   1:  d28850bcdb ! 1:  7e3082125d environment: stop storing `core.attributesFile` globally
>      @@ Commit message
> 
>           Create a new struct `repo_config_values` to hold this value and
>           other repository dependent values parsed by `git_default_config()`.
>      -    For now the value can be accessed via the_repository in
>      -    `git_default_config()`.
>           This will ensure the current behaviour remains the same while also
>           enabling the libification of Git.
> 
>      +    An accessor function 'repo_config_values()' is created and used to access
>      +    the new struct member of the repository struct.
>      +    This is to ensure that we detect if the struct repository has been
>      +    initialized and also prevent double initialization of the repository.
>      +
>           It is important to note that `git_default_config()` is a wrapper to other
>           `git_default_*_config()` functions such as `git_default_core_config()`.
>           Therefore to access and modify this global variable,
>      @@ Commit message
>           Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>           Mentored-by: Christian Couder <christian.couder@gmail.com>
>           Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>      +    Helped-by: Junio C Hamano <gitster@pobox.com>
>           Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> 
>        ## attr.c ##
>      @@ attr.c: const char *git_attr_system_file(void)
>        {
>       -	if (!git_attributes_file)
>       -		git_attributes_file = xdg_config_home("attributes");
>      -+	struct repo_config_values *cfg = &the_repository->config_values;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>       +	if (!cfg->attributes_file)
>       +		cfg->attributes_file = xdg_config_home("attributes");
> 
>      @@ environment.c: static enum fsync_component parse_fsync_components(const char *va
>        static int git_default_core_config(const char *var, const char *value,
>        				   const struct config_context *ctx, void *cb)
>        {
>      -+	struct repo_config_values *cfg = &the_repository->config_values;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>       +
>        	/* This needs a better name */
>        	if (!strcmp(var, "core.filemode")) {
>      @@ environment.h: extern const char * const local_repo_env[];
> 
>        struct strvec;
> 
>      ++struct repository;
>       +struct repo_config_values {
>       +	/* section "core" config values */
>       +	char *attributes_file;
>       +};
>      ++
>      ++struct repo_config_values *repo_config_values(struct repository *repo);
>       +
>        /*
>         * Wrapper of getenv() that returns a strdup value. This value is kept
>      @@ environment.h: extern int assume_unchanged;
>        extern unsigned long pack_size_limit_cfg;
> 
>        ## repository.c ##
>      -@@ repository.c: void initialize_repository(struct repository *repo)
>      +@@ repository.c: static void set_default_hash_algo(struct repository *repo)
>      + 	repo_set_hash_algo(repo, algo);
>      + }
>      +
>      ++struct repo_config_values *repo_config_values(struct repository *repo)
>      ++{
>      ++	if(!repo->initialized)
>      ++		BUG("config values from uninitialized repository");
>      ++	return &repo->config_values_private_;
>      ++}
>      ++
>      + void initialize_repository(struct repository *repo)
>      + {
>      ++	if (repo->initialized)
>      ++		BUG("repository initialized already");
>      ++	repo->initialized = true;
>      ++
>      + 	repo->remote_state = remote_state_new();
>      + 	repo->parsed_objects = parsed_object_pool_new(repo);
>        	ALLOC_ARRAY(repo->index, 1);
>        	index_state_init(repo->index, repo);
>        	repo->check_deprecated_config = true;
>      -+	repo_config_values_init(&repo->config_values);
>      ++	repo_config_values_init(repo_config_values(repo));
> 
>        	/*
>        	 * When a command runs inside a repository, it learns what
>      @@ repository.h: struct repository {
>        	const struct git_hash_algo *compat_hash_algo;
> 
>       +	/* Repository's config values parsed by git_default_config() */
>      -+	struct repo_config_values config_values;
>      ++	struct repo_config_values config_values_private_;
>       +
>        	/* Repository's reference storage format, as serialized on disk. */
>        	enum ref_storage_format ref_storage_format;
> 
>      +@@ repository.h: struct repository {
>      +
>      + 	/* Should repo_config() check for deprecated settings */
>      + 	bool check_deprecated_config;
>      ++
>      ++	/* Has this repository instance been initialized? */
>      ++	bool initialized;
>      + };
>      +
>      + #ifdef USE_THE_REPOSITORY_VARIABLE
> 2:  5e56e1cc41 ! 2:  8645b4f595 environment: stop using core.sparseCheckout globally
>      @@ Commit message
>           Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> 
>        ## builtin/backfill.c ##
>      +@@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>      + 			 N_("Restrict the missing objects to the current sparse-checkout")),
>      + 		OPT_END(),
>      + 	};
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	show_usage_with_options_if_asked(argc, argv,
>      + 					 builtin_backfill_usage, options);
>       @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>        	repo_config(repo, git_default_config, NULL);
> 
>        	if (ctx.sparse < 0)
>       -		ctx.sparse = core_apply_sparse_checkout;
>      -+		ctx.sparse = the_repository->config_values.apply_sparse_checkout;
>      ++		ctx.sparse = cfg->apply_sparse_checkout;
> 
>        	result = do_backfill(&ctx);
>        	backfill_context_clear(&ctx);
> 
>        ## builtin/clone.c ##
>       @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
>      + {
>      + 	struct child_process cmd = CHILD_PROCESS_INIT;
>      + 	int result = 0;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      + 	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
>      +
>      + 	/*
>        	 * We must apply the setting in the current process
>        	 * for the later checkout to use the sparse-checkout file.
>        	 */
>       -	core_apply_sparse_checkout = 1;
>      -+	the_repository->config_values.apply_sparse_checkout = 1;
>      ++	cfg->apply_sparse_checkout = 1;
> 
>        	cmd.git_cmd = 1;
>        	if (run_command(&cmd)) {
>      @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
>        	 *	of these submodules are expanded unexpectedly.
>        	 *
>       -	 * 2. "core_apply_sparse_checkout"
>      -+	 * 2. "config_values.apply_sparse_checkout"
>      ++	 * 2. "config_values_private_.apply_sparse_checkout"
>        	 *	When running `grep` in the superproject, this setting is
>        	 *	populated using the superproject's configs. However, once
>        	 *	initialized, this config is globally accessible and is read by
> 
>        ## builtin/mv.c ##
>      +@@ builtin/mv.c: int cmd_mv(int argc,
>      + 	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
>      + 	struct strbuf pathbuf = STRBUF_INIT;
>      + 	int ret;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	repo_config(the_repository, git_default_config, NULL);
>      +
>       @@ builtin/mv.c: int cmd_mv(int argc,
>        		rename_index_entry_at(the_repository->index, pos, dst);
> 
>        		if (ignore_sparse &&
>       -		    core_apply_sparse_checkout &&
>      -+		    the_repository->config_values.apply_sparse_checkout &&
>      ++		    cfg->apply_sparse_checkout &&
>        		    core_sparse_checkout_cone) {
>        			/*
>        			 * NEEDSWORK: we are *not* paying attention to
> 
>        ## builtin/sparse-checkout.c ##
>       @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>      + 	struct pattern_list pl;
>      + 	char *sparse_filename;
>        	int res;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>        	setup_work_tree();
>       -	if (!core_apply_sparse_checkout)
>      -+	if (!the_repository->config_values.apply_sparse_checkout)
>      ++	if (!cfg->apply_sparse_checkout)
>        		die(_("this worktree is not sparse"));
> 
>        	argc = parse_options(argc, argv, prefix,
>       @@ builtin/sparse-checkout.c: static int set_config(struct repository *repo,
>      + }
> 
>        static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      ++
>        	/* If not specified, use previous definition of cone mode */
>       -	if (*cone_mode == -1 && core_apply_sparse_checkout)
>      -+	if (*cone_mode == -1 && the_repository->config_values.apply_sparse_checkout)
>      ++	if (*cone_mode == -1 && cfg->apply_sparse_checkout)
>        		*cone_mode = core_sparse_checkout_cone;
> 
>        	/* Set cone/non-cone mode appropriately */
>       -	core_apply_sparse_checkout = 1;
>      -+	the_repository->config_values.apply_sparse_checkout = 1;
>      ++	cfg->apply_sparse_checkout = 1;
>        	if (*cone_mode == 1 || *cone_mode == -1) {
>        		core_sparse_checkout_cone = 1;
>        		return MODE_CONE_PATTERNS;
>      -@@ builtin/sparse-checkout.c: static int update_modes(struct repository *repo, int *cone_mode, int *sparse_ind
>      +@@ builtin/sparse-checkout.c: static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
>      + static int update_modes(struct repository *repo, int *cone_mode, int *sparse_index)
>      + {
>        	int mode, record_mode;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>        	/* Determine if we need to record the mode; ensure sparse checkout on */
>       -	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
>      -+	record_mode = (*cone_mode != -1) ||
>      -+		      !the_repository->config_values.apply_sparse_checkout;
>      ++	record_mode = (*cone_mode != -1) || !cfg->apply_sparse_checkout;
> 
>        	mode = update_cone_mode(cone_mode);
>        	if (record_mode && set_config(repo, mode))
>      +@@ builtin/sparse-checkout.c: static int modify_pattern_list(struct repository *repo,
>      + 	int result;
>      + 	int changed_config = 0;
>      + 	struct pattern_list *pl = xcalloc(1, sizeof(*pl));
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	switch (m) {
>      + 	case ADD:
>       @@ builtin/sparse-checkout.c: static int modify_pattern_list(struct repository *repo,
>        		break;
>        	}
> 
>       -	if (!core_apply_sparse_checkout) {
>      -+	if (!the_repository->config_values.apply_sparse_checkout) {
>      ++	if (!cfg->apply_sparse_checkout) {
>        		set_config(repo, MODE_ALL_PATTERNS);
>       -		core_apply_sparse_checkout = 1;
>      -+		the_repository->config_values.apply_sparse_checkout = 1;
>      ++		cfg->apply_sparse_checkout = 1;
>        		changed_config = 1;
>        	}
> 
>       @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
>      + 	};
>      + 	struct strvec patterns = STRVEC_INIT;
>        	int ret;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>        	setup_work_tree();
>       -	if (!core_apply_sparse_checkout)
>      -+	if (!the_repository->config_values.apply_sparse_checkout)
>      ++	if (!cfg->apply_sparse_checkout)
>        		die(_("no sparse-checkout to add to"));
> 
>        	repo_read_index(repo);
>       @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const char **argv,
>      + 			 N_("toggle the use of a sparse index")),
>      + 		OPT_END(),
>        	};
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>        	setup_work_tree();
>       -	if (!core_apply_sparse_checkout)
>      -+	if (!the_repository->config_values.apply_sparse_checkout)
>      ++	if (!cfg->apply_sparse_checkout)
>        		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
> 
>        	reapply_opts.cone_mode = -1;
>      +@@ builtin/sparse-checkout.c: static int sparse_checkout_clean(int argc, const char **argv,
>      + 	size_t worktree_len;
>      + 	int force = 0, dry_run = 0, verbose = 0;
>      + 	int require_force = 1;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	struct option builtin_sparse_checkout_clean_options[] = {
>      + 		OPT__DRY_RUN(&dry_run, N_("dry run")),
>       @@ builtin/sparse-checkout.c: static int sparse_checkout_clean(int argc, const char **argv,
>        	};
> 
>        	setup_work_tree();
>       -	if (!core_apply_sparse_checkout)
>      -+	if (!the_repository->config_values.apply_sparse_checkout)
>      ++	if (!cfg->apply_sparse_checkout)
>        		die(_("must be in a sparse-checkout to clean directories"));
>        	if (!core_sparse_checkout_cone)
>        		die(_("must be in a cone-mode sparse-checkout to clean directories"));
>       @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const char **argv,
>      + 		OPT_END(),
>      + 	};
>        	struct pattern_list pl;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>        	/*
>       -	 * We do not exit early if !core_apply_sparse_checkout; due to the
>      @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
>        	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
>        	pl.use_cone_patterns = 0;
>       -	core_apply_sparse_checkout = 1;
>      -+	the_repository->config_values.apply_sparse_checkout = 1;
>      ++	cfg->apply_sparse_checkout = 1;
> 
>        	add_pattern("/*", empty_base, 0, &pl, 0);
> 
> 
>        ## builtin/worktree.c ##
>      +@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
>      + 	struct strbuf sb_name = STRBUF_INIT;
>      + 	struct worktree **worktrees, *wt = NULL;
>      + 	struct ref_store *wt_refs;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	worktrees = get_worktrees();
>      + 	check_candidate_path(path, opts->force, worktrees, "add");
>       @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
>        	 * If the current worktree has sparse-checkout enabled, then copy
>        	 * the sparse-checkout patterns from the current worktree.
>        	 */
>       -	if (core_apply_sparse_checkout)
>      -+	if (the_repository->config_values.apply_sparse_checkout)
>      ++	if (cfg->apply_sparse_checkout)
>        		copy_sparse_checkout(sb_repo.buf);
> 
>        	/*
>      @@ dir.c: enum pattern_match_result path_matches_pattern_list(
>        int init_sparse_checkout_patterns(struct index_state *istate)
>        {
>       -	if (!core_apply_sparse_checkout)
>      -+	if (!the_repository->config_values.apply_sparse_checkout)
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      ++	if (!cfg->apply_sparse_checkout)
>        		return 1;
>        	if (istate->sparse_checkout_patterns)
>        		return 0;
>      @@ environment.c: int git_default_config(const char *var, const char *value,
>        }
> 
>        ## environment.h ##
>      -@@ environment.h: struct strvec;
>      +@@ environment.h: struct repository;
>        struct repo_config_values {
>        	/* section "core" config values */
>        	char *attributes_file;
>       +	int apply_sparse_checkout;
>        };
> 
>      - /*
>      + struct repo_config_values *repo_config_values(struct repository *repo);
>       @@ environment.h: extern int precomposed_unicode;
>        extern int protect_hfs;
>        extern int protect_ntfs;
>      @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
>        int is_sparse_index_allowed(struct index_state *istate, int flags)
>        {
>       -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
>      -+	struct repo_config_values *cfg = &the_repository->config_values;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>       +	if (!cfg->apply_sparse_checkout || !core_sparse_checkout_cone)
>        		return 0;
> 
>      @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct i
>        void clear_skip_worktree_from_present_files(struct index_state *istate)
>        {
>       -	if (!core_apply_sparse_checkout ||
>      -+	struct repo_config_values *cfg = &the_repository->config_values;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>       +	if (!cfg->apply_sparse_checkout ||
>        	    sparse_expect_files_outside_of_patterns)
>        		return;
> 
> 
>        ## unpack-trees.c ##
>      +@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>      + 	struct pattern_list pl;
>      + 	int free_pattern_list = 0;
>      + 	struct dir_struct dir = DIR_INIT;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	if (o->reset == UNPACK_RESET_INVALID)
>      + 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
>       @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>        	if (o->prefix)
>        		update_sparsity_for_prefix(o->prefix, o->src_index);
> 
>       -	if (!core_apply_sparse_checkout || !o->update)
>      -+	if (!the_repository->config_values.apply_sparse_checkout || !o->update)
>      ++	if (!cfg->apply_sparse_checkout || !o->update)
>        		o->skip_sparse_checkout = 1;
>        	if (!o->skip_sparse_checkout) {
>        		memset(&pl, 0, sizeof(pl));
> 
>        ## wt-status.c ##
>       @@ wt-status.c: static void wt_status_check_sparse_checkout(struct repository *r,
>      + {
>        	int skip_worktree = 0;
>        	int i;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>       -	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
>      -+	if (!the_repository->config_values.apply_sparse_checkout ||
>      ++	if (!cfg->apply_sparse_checkout ||
>       +	    r->index->cache_nr == 0) {
>        		/*
>        		 * Don't compute percentage of checked out files if we
> 3:  e7f37bac87 ! 3:  60451b93a5 environment: move "branch.autoSetupMerge" into `struct repo_config_values`
>      @@ branch.h: enum branch_track {
>        /**
> 
>        ## builtin/branch.c ##
>      +@@ builtin/branch.c: int cmd_branch(int argc,
>      + 	static struct ref_sorting *sorting;
>      + 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>      + 	struct ref_format format = REF_FORMAT_INIT;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      + 	int ret;
>      +
>      + 	struct option options[] = {
>       @@ builtin/branch.c: int cmd_branch(int argc,
>        	if (!sorting_options.nr)
>        		string_list_append(&sorting_options, "refname");
> 
>       -	track = git_branch_track;
>      -+	track = the_repository->config_values.branch_track;
>      ++	track = cfg->branch_track;
> 
>        	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
>        				   0, &head_oid, NULL);
> 
>        ## builtin/checkout.c ##
>      +@@ builtin/checkout.c: static void die_if_switching_to_a_branch_in_use(struct checkout_opts *opts,
>      + static int checkout_branch(struct checkout_opts *opts,
>      + 			   struct branch_info *new_branch_info)
>      + {
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      + 	int noop_switch = (!new_branch_info->name &&
>      + 			   !opts->new_branch &&
>      + 			   !opts->force_detach);
>       @@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
>        		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
>        			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
>        	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
>       -		opts->track = git_branch_track;
>      -+		opts->track = the_repository->config_values.branch_track;
>      ++		opts->track = cfg->branch_track;
> 
>        	if (new_branch_info->name && !new_branch_info->commit)
>        		die(_("Cannot switch branch to a non-commit '%s'"),
> 
>        ## builtin/push.c ##
>      +@@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
>      + 	const char *advice_pushdefault_maybe = "";
>      + 	const char *advice_automergesimple_maybe = "";
>      + 	const char *short_upstream = branch->merge[0]->src;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>      +
>      + 	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
>      +
>       @@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
>        		advice_pushdefault_maybe = _("\n"
>        				 "To choose either option permanently, "
>        				 "see push.default in 'git help config'.\n");
>       -	if (git_branch_track != BRANCH_TRACK_SIMPLE)
>      -+	if (the_repository->config_values.branch_track != BRANCH_TRACK_SIMPLE)
>      ++	if (cfg->branch_track != BRANCH_TRACK_SIMPLE)
>        		advice_automergesimple_maybe = _("\n"
>        				 "To avoid automatically configuring "
>        				 "an upstream branch when its name\n"
> 
>        ## builtin/submodule--helper.c ##
>       @@ builtin/submodule--helper.c: static int module_create_branch(int argc, const char **argv, const char *prefix,
>      + 		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
>      + 		NULL
>        	};
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
> 
>        	repo_config(the_repository, git_default_config, NULL);
>       -	track = git_branch_track;
>      -+	track = the_repository->config_values.branch_track;
>      ++	track = cfg->branch_track;
>        	argc = parse_options(argc, argv, prefix, options, usage, 0);
> 
>        	if (argc != 3)
>      @@ environment.c: static int git_default_i18n_config(const char *var, const char *v
> 
>        static int git_default_branch_config(const char *var, const char *value)
>        {
>      -+	struct repo_config_values *cfg = &the_repository->config_values;
>      ++	struct repo_config_values *cfg = repo_config_values(the_repository);
>       +
>        	if (!strcmp(var, "branch.autosetupmerge")) {
>        		if (value && !strcmp(value, "always")) {
>      @@ environment.h: struct repo_config_values {
>       +	enum branch_track branch_track;
>        };
> 
>      - /*
>      + struct repo_config_values *repo_config_values(struct repository *repo);
> 
> 

