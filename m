Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE1494DF
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764544; cv=none; b=O+iaTYpxl5cAPGhO3JrEDBtFb6BQxIDSWOyuVGemHFXCIz+t+Y7PArHyohYzVXhb1nG6eahgwI9DvUPYp28nAgWojqG4RCEFvtZymq904yzoCAq+KIf4aRwoCYd7e0+3/7V4aSapdvahYO1bNJTkMW8YgKh6ODtBKaoPBbMYxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764544; c=relaxed/simple;
	bh=0NIW5rPwzljWeEIhRCRann+TPCowa5hU3fcZPT2kTlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXdc+UNfB8SNcf2TbxKtnFEoXNhajLFtGdc87Exy/ke/Mvd97GVpSUu1DDSWmFtBkyfEUFF9NMWvXh24Z0c0ENkhe+LUoKY8VPHP9FBw1Qr6w5aNN76d1aqbEqROJfPnTcydKzblkHhebZC8yS91vDhaUp8QNscRapqD3tMGgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rgMNnuDn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDI5vMbz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgMNnuDn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDI5vMbz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BA05011400E6;
	Wed,  5 Feb 2025 09:08:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 09:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738764539; x=1738850939; bh=cXAd9Kahua
	fJz0Vurbx2aGuy2s3l59fDG2Wbk2eC8D0=; b=rgMNnuDnZUMSOfXMXFflpywkS1
	3EnTTT18GCypRzD8Rejl2AewJ/631eNVgzX5p72934MOzoTifgnSGSYkg9C8TZh4
	glnQECs+9gmFRL0J5CJvI0a0dn1ZycRZ/Qjqx26KUf0bGiFW3wfr9hZ+jbXRfn8m
	ieJUGdttQDjSeqg1w8zy7hHY70LZSdSkcyPmjGy/tGLT1nEBqIWvDS1kEVHfTszB
	/8INh93f2JJdyfZM8NBaNsDS1wMWETHdZmfyYjD5ND6JEoIlUI3b+aG187i0EHjS
	VAICs8TUKlACpTUVGkgS8ARpuE1/iidCqWnX+Vvh00nD26NH+sbTDV6mtTHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738764539; x=1738850939; bh=cXAd9KahuafJz0Vurbx2aGuy2s3l59fDG2W
	bk2eC8D0=; b=KDI5vMbzIdtxMW+xT67/RiCIynbIaxhD9FgQsox+a27GAcqvDOC
	qj8lVzS00kAqlRWMwenOAnBa6YJD8vsnw5tsSIAfA//mKdNaTZo9370B9Xe6u6T/
	ilCZuZ115TvuITieHYXWqY4C/KXtfcDQAq6q2DsnwvY514UpRJMnamYnZjsE4/WC
	bvBCl/CnEMmIFgWjvAd7yO5qyJHafvyIWEKBc9YTx1VdiOKvrY+FLTPAQAEKKb6B
	GRcTBqZf7cAR1WW3h2Fmg3gXITaxNTciRBunNsz53nQnAbkcPri9u2OTuW3S1SdD
	JbvCH3UHH+Ib3qTGrU1QmYfQy1cXHMpa97g==
X-ME-Sender: <xms:-3CjZ0m5zr4gICBca-kQk87_5xkgV6O8GVZqHuHh_pDCwHdTUNrt9w>
    <xme:-3CjZz2Wvl1CU1Xr1iV-SjjJa7DJIfTDSaWFm1F3vgpXJufqUv1rsiLsEUDxmtSOv
    XtNM90pvHIVZnBOgA>
X-ME-Received: <xmr:-3CjZyoevYLyPQqVYSlqHzVPYf5EbtnTF2ozM3MxOi_Pcgm1YMZudXMaG2zlWX3hfnN05ueLDuPZvI9VN9jEkIRJQsQBz6dtMzRS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-3CjZwkAOxOjBoPg2om3lq2apq2hzPBDxp7cc0mlWNDbyEn7vge2sQ>
    <xmx:-3CjZy3etkRgwnz60_BDZF5cp__U0NQZYZh3UudNGk2G_fyRILE1Mg>
    <xmx:-3CjZ3uj2-VnoxwtXq-7FrTCd2YFj0y0Jxfp_Ghr9gjg9arTwl1aWQ>
    <xmx:-3CjZ-WuZgUzmrZqM4FjucNA0D8zTV48BY_tQzHn8M5ggqk6uwdSXw>
    <xmx:-3CjZ7kpnjCnHzghPT0NpoZTDyfdiel2PiY1uCfGuX2CR0xJtyIgYZGe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 09:08:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] difftool: eliminate use of global variables
In-Reply-To: <20250204225501.597873-1-davvid@gmail.com> (David Aguilar's
	message of "Tue, 4 Feb 2025 14:55:00 -0800")
References: <20250204225501.597873-1-davvid@gmail.com>
Date: Wed, 05 Feb 2025 06:08:57 -0800
Message-ID: <xmqqzfj0pjpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Aguilar <davvid@gmail.com> writes:

> Remove the 'USE_THE_REPOSITORY_VARIABLE' macro now that all state is
> passed to each function from callers.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/difftool.c | 95 +++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 39 deletions(-)

Looking good.  Queued.



> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 03a8bb92a9..cd1e5882e3 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -12,8 +12,6 @@
>   * Copyright (C) 2016 Johannes Schindelin
>   */
>  
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "builtin.h"
>  
>  #include "abspath.h"
> @@ -36,18 +34,27 @@
>  #include "entry.h"
>  #include "setup.h"
>  
> -static int trust_exit_code;
> -
>  static const char *const builtin_difftool_usage[] = {
>  	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
>  	NULL
>  };
>  
> +struct difftool_state {
> +	int has_symlinks;
> +	int symlinks;
> +	int trust_exit_code;
> +};
> +
>  static int difftool_config(const char *var, const char *value,
>  			   const struct config_context *ctx, void *cb)
>  {
> +	struct difftool_state *dt_state = (struct difftool_state *)cb;
>  	if (!strcmp(var, "difftool.trustexitcode")) {
> -		trust_exit_code = git_config_bool(var, value);
> +		dt_state->trust_exit_code = git_config_bool(var, value);
> +		return 0;
> +	}
> +	if (!strcmp(var, "core.symlinks")) {
> +		dt_state->has_symlinks = git_config_bool(var, value);
>  		return 0;
>  	}
>  
> @@ -63,7 +70,8 @@ static int print_tool_help(void)
>  	return run_command(&cmd);
>  }
>  
> -static int parse_index_info(char *p, int *mode1, int *mode2,
> +static int parse_index_info(struct repository *repo,
> +			    char *p, int *mode1, int *mode2,
>  			    struct object_id *oid1, struct object_id *oid2,
>  			    char *status)
>  {
> @@ -75,11 +83,11 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
>  	*mode2 = (int)strtol(p + 1, &p, 8);
>  	if (*p != ' ')
>  		return error("expected ' ', got '%c'", *p);
> -	if (parse_oid_hex(++p, oid1, (const char **)&p))
> +	if (parse_oid_hex_algop(++p, oid1, (const char **)&p, repo->hash_algo))
>  		return error("expected object ID, got '%s'", p);
>  	if (*p != ' ')
>  		return error("expected ' ', got '%c'", *p);
> -	if (parse_oid_hex(++p, oid2, (const char **)&p))
> +	if (parse_oid_hex_algop(++p, oid2, (const char **)&p, repo->hash_algo))
>  		return error("expected object ID, got '%s'", p);
>  	if (*p != ' ')
>  		return error("expected ' ', got '%c'", *p);
> @@ -106,7 +114,8 @@ static void add_path(struct strbuf *buf, size_t base_len, const char *path)
>  /*
>   * Determine whether we can simply reuse the file in the worktree.
>   */
> -static int use_wt_file(const char *workdir, const char *name,
> +static int use_wt_file(struct repository *repo,
> +		       const char *workdir, const char *name,
>  		       struct object_id *oid)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> @@ -121,7 +130,7 @@ static int use_wt_file(const char *workdir, const char *name,
>  		int fd = open(buf.buf, O_RDONLY);
>  
>  		if (fd >= 0 &&
> -		    !index_fd(the_repository->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
> +		    !index_fd(repo->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
>  			if (is_null_oid(oid)) {
>  				oidcpy(oid, &wt_oid);
>  				use = 1;
> @@ -212,13 +221,14 @@ static int path_entry_cmp(const void *cmp_data UNUSED,
>  	return strcmp(a->path, key ? key : b->path);
>  }
>  
> -static void changed_files(struct hashmap *result, const char *index_path,
> +static void changed_files(struct repository *repo,
> +			  struct hashmap *result, const char *index_path,
>  			  const char *workdir)
>  {
>  	struct child_process update_index = CHILD_PROCESS_INIT;
>  	struct child_process diff_files = CHILD_PROCESS_INIT;
>  	struct strbuf buf = STRBUF_INIT;
> -	const char *git_dir = absolute_path(repo_get_git_dir(the_repository));
> +	const char *git_dir = absolute_path(repo_get_git_dir(repo));
>  	FILE *fp;
>  
>  	strvec_pushl(&update_index.args,
> @@ -291,13 +301,15 @@ static int ensure_leading_directories(char *path)
>   * to compare the readlink(2) result as text, even on a filesystem that is
>   * capable of doing a symbolic link.
>   */
> -static char *get_symlink(const struct object_id *oid, const char *path)
> +static char *get_symlink(struct repository *repo,
> +			 struct difftool_state *dt_state,
> +			 const struct object_id *oid, const char *path)
>  {
>  	char *data;
>  	if (is_null_oid(oid)) {
>  		/* The symlink is unknown to Git so read from the filesystem */
>  		struct strbuf link = STRBUF_INIT;
> -		if (has_symlinks) {
> +		if (dt_state->has_symlinks) {
>  			if (strbuf_readlink(&link, path, strlen(path)))
>  				die(_("could not read symlink %s"), path);
>  		} else if (strbuf_read_file(&link, path, 128))
> @@ -307,8 +319,7 @@ static char *get_symlink(const struct object_id *oid, const char *path)
>  	} else {
>  		enum object_type type;
>  		unsigned long size;
> -		data = repo_read_object_file(the_repository, oid, &type,
> -					     &size);
> +		data = repo_read_object_file(repo, oid, &type, &size);
>  		if (!data)
>  			die(_("could not read object %s for symlink %s"),
>  				oid_to_hex(oid), path);
> @@ -355,7 +366,9 @@ static void write_standin_files(struct pair_entry *entry,
>  		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
>  }
>  
> -static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
> +static int run_dir_diff(struct repository *repo,
> +			struct difftool_state *dt_state,
> +			const char *extcmd, const char *prefix,
>  			struct child_process *child)
>  {
>  	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
> @@ -375,7 +388,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
>  	struct hashmap_iter iter;
>  	struct pair_entry *entry;
> -	struct index_state wtindex = INDEX_STATE_INIT(the_repository);
> +	struct index_state wtindex = INDEX_STATE_INIT(repo);
>  	struct checkout lstate, rstate;
>  	int err = 0;
>  	struct child_process cmd = CHILD_PROCESS_INIT;
> @@ -383,7 +396,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  	struct hashmap tmp_modified = HASHMAP_INIT(path_entry_cmp, NULL);
>  	int indices_loaded = 0;
>  
> -	workdir = repo_get_work_tree(the_repository);
> +	workdir = repo_get_work_tree(repo);
>  
>  	/* Setup temp directories */
>  	tmp = getenv("TMPDIR");
> @@ -438,8 +451,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  			       "not supported in\n"
>  			       "directory diff mode ('-d' and '--dir-diff')."));
>  
> -		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
> -				     &status))
> +		if (parse_index_info(repo, info.buf, &lmode, &rmode, &loid, &roid, &status))
>  			break;
>  		if (strbuf_getline_nul(&lpath, fp))
>  			break;
> @@ -469,13 +481,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		}
>  
>  		if (S_ISLNK(lmode)) {
> -			char *content = get_symlink(&loid, src_path);
> +			char *content = get_symlink(repo, dt_state, &loid, src_path);
>  			add_left_or_right(&symlinks2, src_path, content, 0);
>  			free(content);
>  		}
>  
>  		if (S_ISLNK(rmode)) {
> -			char *content = get_symlink(&roid, dst_path);
> +			char *content = get_symlink(repo, dt_state, &roid, dst_path);
>  			add_left_or_right(&symlinks2, dst_path, content, 1);
>  			free(content);
>  		}
> @@ -500,7 +512,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  			}
>  			hashmap_add(&working_tree_dups, &entry->entry);
>  
> -			if (!use_wt_file(workdir, dst_path, &roid)) {
> +			if (!use_wt_file(repo, workdir, dst_path, &roid)) {
>  				if (checkout_path(rmode, &roid, dst_path,
>  						  &rstate)) {
>  					ret = error("could not write '%s'",
> @@ -528,7 +540,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  					goto finish;
>  				}
>  				add_path(&wtdir, wtdir_len, dst_path);
> -				if (symlinks) {
> +				if (dt_state->symlinks) {
>  					if (symlink(wtdir.buf, rdir.buf)) {
>  						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
>  						goto finish;
> @@ -614,7 +626,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		if (lstat(rdir.buf, &st))
>  			continue;
>  
> -		if ((symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
> +		if ((dt_state->symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
>  			continue;
>  
>  		if (!indices_loaded) {
> @@ -626,9 +638,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  				ret = error("could not write %s", buf.buf);
>  				goto finish;
>  			}
> -			changed_files(&wt_modified, buf.buf, workdir);
> +			changed_files(repo, &wt_modified, buf.buf, workdir);
>  			strbuf_setlen(&rdir, rdir_len);
> -			changed_files(&tmp_modified, buf.buf, rdir.buf);
> +			changed_files(repo, &tmp_modified, buf.buf, rdir.buf);
>  			add_path(&rdir, rdir_len, name);
>  			indices_loaded = 1;
>  		}
> @@ -702,11 +714,15 @@ static int run_file_diff(int prompt, const char *prefix,
>  int cmd_difftool(int argc,
>  		 const char **argv,
>  		 const char *prefix,
> -		 struct repository *repo UNUSED)
> +		 struct repository *repo)
>  {
> -	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
> -	    tool_help = 0, no_index = 0;
> +	int use_gui_tool = -1, dir_diff = 0, prompt = -1, tool_help = 0, no_index = 0;
>  	static char *difftool_cmd = NULL, *extcmd = NULL;
> +	struct difftool_state dt_state = {
> +		.has_symlinks = 1,
> +		.symlinks = 1,
> +		.trust_exit_code = 0
> +	};
>  	struct option builtin_difftool_options[] = {
>  		OPT_BOOL('g', "gui", &use_gui_tool,
>  			 N_("use `diff.guitool` instead of `diff.tool`")),
> @@ -717,14 +733,14 @@ int cmd_difftool(int argc,
>  			0, PARSE_OPT_NONEG),
>  		OPT_SET_INT_F(0, "prompt", &prompt, NULL,
>  			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
> -		OPT_BOOL(0, "symlinks", &symlinks,
> +		OPT_BOOL(0, "symlinks", &dt_state.symlinks,
>  			 N_("use symlinks in dir-diff mode")),
>  		OPT_STRING('t', "tool", &difftool_cmd, N_("tool"),
>  			   N_("use the specified diff tool")),
>  		OPT_BOOL(0, "tool-help", &tool_help,
>  			 N_("print a list of diff tools that may be used with "
>  			    "`--tool`")),
> -		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
> +		OPT_BOOL(0, "trust-exit-code", &dt_state.trust_exit_code,
>  			 N_("make 'git-difftool' exit when an invoked diff "
>  			    "tool returns a non-zero exit code")),
>  		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
> @@ -734,8 +750,9 @@ int cmd_difftool(int argc,
>  	};
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
> -	git_config(difftool_config, NULL);
> -	symlinks = has_symlinks;
> +	if (repo)
> +		repo_config(repo, difftool_config, &dt_state);
> +	dt_state.symlinks = dt_state.has_symlinks;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
>  			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |
> @@ -749,8 +766,8 @@ int cmd_difftool(int argc,
>  
>  	if (!no_index){
>  		setup_work_tree();
> -		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
> -		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
> +		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(repo)), 1);
> +		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(repo)), 1);
>  	} else if (dir_diff)
>  		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
>  
> @@ -783,7 +800,7 @@ int cmd_difftool(int argc,
>  	}
>  
>  	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
> -	       trust_exit_code ? "true" : "false", 1);
> +	       dt_state.trust_exit_code ? "true" : "false", 1);
>  
>  	/*
>  	 * In directory diff mode, 'git-difftool--helper' is called once
> @@ -799,6 +816,6 @@ int cmd_difftool(int argc,
>  	strvec_pushv(&child.args, argv);
>  
>  	if (dir_diff)
> -		return run_dir_diff(extcmd, symlinks, prefix, &child);
> +		return run_dir_diff(repo, &dt_state, extcmd, prefix, &child);
>  	return run_file_diff(prompt, prefix, &child);
>  }
