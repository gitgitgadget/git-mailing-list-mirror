Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6461EA7C0
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848893; cv=none; b=sJgftv7bJaKTRfsOhJTPIP5u+LGhTLelaKy6VU/KJhpHfU3h+eRZs8uhztlYu4dO0Hzmyr20d8rLbWmk655PKevdBaLjDUtq3/kP1veik+e/OOBQfxe6ZLqVGrUgLY1DvFBQ3NYEAArIadi5iNKn49jQpO0vxN9eS9mlct5HnBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848893; c=relaxed/simple;
	bh=ekuhqeidYLxLtdyRrJ9asLdh09N3tRfIe9cYYeuVpbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBTCHr9tXFuddi0bWe4XlKd7iJf+hkMnc8Sso07VfsI1rAsXHlfS7MSVlAc5wzYzOnjRpL4rgGHeWSmtaNRdqQ03prlZ1xzg8me9N1kwxkO06CY/dcx0/+5cQdxN+k46CNP4P+cZhbL6DlasDs8hidqaDDj8V6SW4K1jxa+q2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=amwqBvnW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRJvN+6o; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="amwqBvnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRJvN+6o"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25DDF254010F;
	Thu,  6 Feb 2025 08:34:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 06 Feb 2025 08:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738848889; x=1738935289; bh=RiqLUiIVzh
	+f+aXxcSNpvKI4g66diAEwiORe5Azttfs=; b=amwqBvnW7p3HlNSiZEbUCuWE0j
	TFf+MCZsUwkSGxFzHUaJt4bzlhHpbjTgMQMkWGl+vQDzXFnps9UmIgK/8G1uBDlL
	0eJ7GklTwQQTK0dfiVkuFlHhkchnrwwKk2gY1KEkdN3TDVjiOP2hQVyzkA/jLtxj
	NSL8cssbi8DRRvQpYbAHnJGjJZEwrHRl0Iuec4QWVaPeBlbyjhT1McQTHXM/erCI
	Q0hlumwIwfev04W2f+ArYWza2akbL7s941fdCpQhMBDRaF0stpInoTqcT/hpxN4s
	ahmmPRr7mkWh8kdG/K8r+V7di929tEL2YmlI5gjjYbFCB7jWfGj9Ym72JjVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738848889; x=1738935289; bh=RiqLUiIVzh+f+aXxcSNpvKI4g66diAEwiOR
	e5Azttfs=; b=eRJvN+6oPMgEdKd14PQzizDlLRoOtKQtA3Wzv1XqMNJ0gcXvfrE
	tWik1fTms1A/ev+s7Aqf41MgQRh4Wcfi4bd4dnvplcKq3ic7QKtt1UIuwuWNqhwC
	+G4bjGJACh6SFxAkAoC3BGGZhl+cSrrUU2o27O+vZnhBS9Eo4RjDjlAJZ2fOR8HF
	NpLBO93wxwBMizVIqZYrO/MEbQ68SKHvdUd8jRnXrFnqYCz1SFdXO8JgrjNh2c1T
	kFk2r7yPMu4GtI5NHJtYt0Rn6VmCP1+1lDCsALCKlNSAfi5jjDWx/VnKVfJnPS6x
	vlpez5ae3dLamnx1KW74YISVA+IpdYwIqkA==
X-ME-Sender: <xms:ebqkZzPpbsc1C99uvzwRwShZP9wm2NEcjVskk-gF6CLh9DVjd8oEYA>
    <xme:ebqkZ984twyxnLvwsmEcQwo7F9xD7ML12Nm6loQkllhWO0_wgulA9-yjwstf_h76U
    KZSDcldFmCBzeaBGw>
X-ME-Received: <xmr:ebqkZyTpD85T3x_OPcDGKIWBilk2xyfPZTzjupaCFgyx_cFBwOq4a0y4uRTpRmLn2KqrC7GMu7HhWScXa1oENTCk7WmKI10BWo1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ebqkZ3sIUHLVNMw-mvj-3_xADCG2XMwGJHeq4nf332nYV36kQy-SJw>
    <xmx:ebqkZ7fiWUscn6lBaiMqv75XJFWNSLIgm-u1-ewb0giVQSNOsL7yJQ>
    <xmx:ebqkZz2OkApIwzY_Uc4n-dB2BR46PkLueksrN36nfzkOZHRYJBYMdw>
    <xmx:ebqkZ3_vMNjMq9nQaQZAVlHsvUrNN5Wo5WDufXUL0surv3uWYYdBpg>
    <xmx:ebqkZ9u4bABWip1_buY1qwqkemS4l0lPIjDqvxYFh-ILVUjUTGeFKaGP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 08:34:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Elijah Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] difftool: eliminate use of global variables
In-Reply-To: <20250206042010.865947-1-davvid@gmail.com> (David Aguilar's
	message of "Wed, 5 Feb 2025 20:20:08 -0800")
References: <20250206042010.865947-1-davvid@gmail.com>
Date: Thu, 06 Feb 2025 05:34:47 -0800
Message-ID: <xmqqy0yjjix4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Aguilar <davvid@gmail.com> writes:

> Move difftool's global variables into a difftools_option struct
> in preparation for removal of USE_THE_REPOSITORY_VARIABLE.

Both may be good things, but I am puzzled by the "in preparation
for" part of the above description.  Would it require we lose these
three global variables if we wanted to pass through a repository
instance through the callchain instead of relying on implicit use of
the_repository?

Aren't these pretty much independent and orthogonal?


>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/difftool.c | 51 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 03a8bb92a9..0b6b92aee0 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -36,18 +36,27 @@
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
> +struct difftool_options {
> +	int has_symlinks;
> +	int symlinks;
> +	int trust_exit_code;
> +};
> +
>  static int difftool_config(const char *var, const char *value,
>  			   const struct config_context *ctx, void *cb)
>  {
> +	struct difftool_options *dt_options = (struct difftool_options *)cb;
>  	if (!strcmp(var, "difftool.trustexitcode")) {
> -		trust_exit_code = git_config_bool(var, value);
> +		dt_options->trust_exit_code = git_config_bool(var, value);
> +		return 0;
> +	}
> +	if (!strcmp(var, "core.symlinks")) {
> +		dt_options->has_symlinks = git_config_bool(var, value);
>  		return 0;
>  	}
>  
> @@ -291,13 +300,14 @@ static int ensure_leading_directories(char *path)
>   * to compare the readlink(2) result as text, even on a filesystem that is
>   * capable of doing a symbolic link.
>   */
> -static char *get_symlink(const struct object_id *oid, const char *path)
> +static char *get_symlink(struct difftool_options *dt_options,
> +			 const struct object_id *oid, const char *path)
>  {
>  	char *data;
>  	if (is_null_oid(oid)) {
>  		/* The symlink is unknown to Git so read from the filesystem */
>  		struct strbuf link = STRBUF_INIT;
> -		if (has_symlinks) {
> +		if (dt_options->has_symlinks) {
>  			if (strbuf_readlink(&link, path, strlen(path)))
>  				die(_("could not read symlink %s"), path);
>  		} else if (strbuf_read_file(&link, path, 128))
> @@ -355,7 +365,8 @@ static void write_standin_files(struct pair_entry *entry,
>  		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
>  }
>  
> -static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
> +static int run_dir_diff(struct difftool_options *dt_options,
> +			const char *extcmd, const char *prefix,
>  			struct child_process *child)
>  {
>  	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
> @@ -469,13 +480,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		}
>  
>  		if (S_ISLNK(lmode)) {
> -			char *content = get_symlink(&loid, src_path);
> +			char *content = get_symlink(dt_options, &loid, src_path);
>  			add_left_or_right(&symlinks2, src_path, content, 0);
>  			free(content);
>  		}
>  
>  		if (S_ISLNK(rmode)) {
> -			char *content = get_symlink(&roid, dst_path);
> +			char *content = get_symlink(dt_options, &roid, dst_path);
>  			add_left_or_right(&symlinks2, dst_path, content, 1);
>  			free(content);
>  		}
> @@ -528,7 +539,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  					goto finish;
>  				}
>  				add_path(&wtdir, wtdir_len, dst_path);
> -				if (symlinks) {
> +				if (dt_options->symlinks) {
>  					if (symlink(wtdir.buf, rdir.buf)) {
>  						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
>  						goto finish;
> @@ -614,7 +625,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		if (lstat(rdir.buf, &st))
>  			continue;
>  
> -		if ((symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
> +		if ((dt_options->symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
>  			continue;
>  
>  		if (!indices_loaded) {
> @@ -704,9 +715,13 @@ int cmd_difftool(int argc,
>  		 const char *prefix,
>  		 struct repository *repo UNUSED)
>  {
> -	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
> -	    tool_help = 0, no_index = 0;
> +	int use_gui_tool = -1, dir_diff = 0, prompt = -1, tool_help = 0, no_index = 0;
>  	static char *difftool_cmd = NULL, *extcmd = NULL;
> +	struct difftool_options dt_options = {
> +		.has_symlinks = 1,
> +		.symlinks = 1,
> +		.trust_exit_code = 0
> +	};
>  	struct option builtin_difftool_options[] = {
>  		OPT_BOOL('g', "gui", &use_gui_tool,
>  			 N_("use `diff.guitool` instead of `diff.tool`")),
> @@ -717,14 +732,14 @@ int cmd_difftool(int argc,
>  			0, PARSE_OPT_NONEG),
>  		OPT_SET_INT_F(0, "prompt", &prompt, NULL,
>  			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
> -		OPT_BOOL(0, "symlinks", &symlinks,
> +		OPT_BOOL(0, "symlinks", &dt_options.symlinks,
>  			 N_("use symlinks in dir-diff mode")),
>  		OPT_STRING('t', "tool", &difftool_cmd, N_("tool"),
>  			   N_("use the specified diff tool")),
>  		OPT_BOOL(0, "tool-help", &tool_help,
>  			 N_("print a list of diff tools that may be used with "
>  			    "`--tool`")),
> -		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
> +		OPT_BOOL(0, "trust-exit-code", &dt_options.trust_exit_code,
>  			 N_("make 'git-difftool' exit when an invoked diff "
>  			    "tool returns a non-zero exit code")),
>  		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
> @@ -734,8 +749,8 @@ int cmd_difftool(int argc,
>  	};
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
> -	git_config(difftool_config, NULL);
> -	symlinks = has_symlinks;
> +	git_config(difftool_config, &dt_options);
> +	dt_options.symlinks = dt_options.has_symlinks;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
>  			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |
> @@ -783,7 +798,7 @@ int cmd_difftool(int argc,
>  	}
>  
>  	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
> -	       trust_exit_code ? "true" : "false", 1);
> +	       dt_options.trust_exit_code ? "true" : "false", 1);
>  
>  	/*
>  	 * In directory diff mode, 'git-difftool--helper' is called once
> @@ -799,6 +814,6 @@ int cmd_difftool(int argc,
>  	strvec_pushv(&child.args, argv);
>  
>  	if (dir_diff)
> -		return run_dir_diff(extcmd, symlinks, prefix, &child);
> +		return run_dir_diff(&dt_options, extcmd, prefix, &child);
>  	return run_file_diff(prompt, prefix, &child);
>  }
