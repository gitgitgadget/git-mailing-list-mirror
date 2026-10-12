Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8946EF6A
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796241; cv=none; b=EAPsS61rBDmw9KK353bk/t1Pr35SMwV0W+9uuECGJe2TwGmgKue8BkpH/e3mbb7dzG0ioC1C9ooM1sE3QgphcpZoErxB2rXIZkpEIY9SvzXmMgrJ7ZQeMiqyPiowKUoukWN/KzXvJ3rYALho5G20ahH3bZ05jSL4day7ZejikWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796241; c=relaxed/simple;
	bh=bRRECTSzRVWCsrCazJEaxDX3/qxi2skq83RV87W9dT0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l5UNdnselZGsKxBHLvWiq+4FgIckD0U3x+FOJ1ycNq/pwaQBIQwA731voZaMg43Cpbocu7V15CUaah/KZZDx5zzHoYV/WS4AWbSGR8qVKmQTNb5UFKYx5s3IqYA72Q05CStybvu9TzFz+7mkO8NpwYjI4ZD/zJGY5P/f3MwUisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnpranSC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnpranSC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d05d51553so10131395e9.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791796236; x=1792401036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7nnoV6cus5YfV+ese6diqwLrFZdLR4M19ed0NOAHPg=;
        b=DnpranSCBlK6Kihu2d6x3+eHBYsXHhwW7otoikvHLX7qkiwiJoMorBicwsVItjPXsK
         N/KU8gYBISv0aRC3TrRq88sUg/11+musgi2ebOzBhbrrOtDHA0uqpGlMOpI0vlNK1+WC
         3mv9al3gyxQVpfRuolU+sSmdiAQkaDrrydvI7//8VfBjPscvIlFRAXwt8MTpocadF5nn
         Ue/IpC92MQLq5u/ZpLF+xSY+XXI2zLZ/4iiRCELg9rALZVGF4w79Ya1dP2v8qHVFbBgO
         /uVTEk5qJSXUjn+NPQzsAkbndAkCRIWE+lkwwDeslmB7+ai1dTQN5r7pqAd9lB+mY2Wh
         Qi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796236; x=1792401036;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7nnoV6cus5YfV+ese6diqwLrFZdLR4M19ed0NOAHPg=;
        b=IBWTPSsFT7Wbm2DEn3+CaW7ofhJsSfT1PT8jOEnXwBhEozr1vrd4H4vca1Hqk+Mv61
         VbcbK7sWqHHzevT0wVbeYl/ulHagxPEuBmqVZU13VbmDMj3sfICKsZDubq3JHV53PdWP
         laMk8pz9bSEOnr8/iskGDWaOqbIZ4QiPS/kaEdc3f5ntZY32rtzHC9glR23mTiNGt2WJ
         CZpNoi9dlvYcsvUKSmKHa9saZG7AUkXftt4BlN6Vn6XnWD4OSgfaTJK8lzMSMN7ey+Wc
         fpyg5akOvZk7V0GxM8NoPZmvvekx3ovAunTIuw4v6iLeqN2Ppk2kZhPmsZDfze0flP5f
         Ulgg==
X-Forwarded-Encrypted: i=1; AKwUvBx79eSSv3pcn00hcZ2khfehZRKy7QyUFDeStEvhNhBcVI+BnZS4Nhn8OhKNhSjcJ6f2BE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAOjwVR40eYJ38UwujTMz2Z8AQAw5ajvxAkJfKt+EEiPUvZlHc
	5M4yFCats0BCnTX4V/HFO2DIrc4IzHY+lP65Oz4NOUSD4DwGOHLRaPVV
X-Gm-Gg: AYBFou2Ez4+N/Ipbi3qoOv746Cq9TDUp3Cj2JNJXI82ALJSoJwN13QMTZlh5eD6Fv2G
	wpiQe6SHHmSoZi9PZchNZZkR6/psE8sewhMqIL5vetRK17m528tARSlRpDGYCryx7rr7J+U+xxY
	HryBJFED+KmZwvsO8qgbbBpHwmbF0r0Wc0grrwoPNk8i7wqJED9EV4ZVDKbnN/YrbMWUsAKbgT4
	g9scpA2pkzg9YzRv3aTW1CCszdhwnwVUfXH+zo/xu9PwgcaaDBjOxSgQJvUX3bVtwwI6qHHqjo8
	oXhzRjNN9kcCGf5nI8kRkPWL+zSPv/D3FwhZ+qrNpLopkENIHms/1btEVuu43GCro5cJLPiks8a
	8RNAnMuL3jrxDcxFeWtKgdHrfLqPgN5Ofa43cG1VFeqs5sf63zw38Tj7vyuEVxYNBb9Kg3BgVmw
	6oGFczUC/Ou8BYi6L/btfStXk4tzCtstQEGgYDBU9LJSswV2wKbA4lSx4DGL8On6ALoUCmAuHp2
	aoodC37sDtg/xRnP5Mn9c5BvRPKB3Tw29D15oa7HYBaMoBt16S6
X-Received: by 2002:a05:600c:524a:b0:4a1:8824:c9ba with SMTP id 5b1f17b1804b1-4a18e49234fmr166388125e9.18.1791796235943;
        Mon, 12 Oct 2026 02:10:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm17404758f8f.39.2026.10.12.02.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:10:35 -0700 (PDT)
Message-ID: <e3b68210-7558-4f95-bc3c-eb57b1065790@gmail.com>
Date: Mon, 12 Oct 2026 10:10:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Abhijeetsingh Meena <abhijeet040403@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>, Ravi Mistry <rmistry@google.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v3.git.1791757294.gitgitgadget@gmail.com>
 <72a87d1c34bba81cb760e47436a39cb249e42278.1791757294.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <72a87d1c34bba81cb760e47436a39cb249e42278.1791757294.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ravi

On 11/10/2026 23:21, Ravi Mistry via GitGitGadget wrote:
> From: Ravi Mistry <rmistry@google.com>
> 
> git-blame(1) can ignore a list of commits specified via
> --ignore-revs-file or the blame.ignoreRevsFile configuration option.
> This is useful for skipping uninteresting revisions such as tree-wide
> formatting changes, large-scale refactors, and code modernizations that
> would otherwise obscure genuine historical authorship.
> 
> When revision-ignoring was introduced in commit ae3f36dea1 ("blame: add
> blame.ignoreRevsFile config option", 2019-10-18), it intentionally
> avoided adopting a default ignore file. At the time, the capability was
> new and unproven, so avoiding unrequested filesystem I/O or unexpected
> attribution shifts took priority over a project-wide default.
> Requiring explicit opt-in per clone was therefore the prudent design.
> 
> Since then, maintaining a .git-blame-ignore-revs file in the repository
> root has become the de facto standard across the Git ecosystem, adopted
> by major hosting platforms (GitHub, GitLab, Gerrit) and prominent open
> source projects (such as Chromium and LLVM). As a consequence,
> developers frequently encounter a jarring mismatch: web interfaces
> seamlessly ignore formatting commits, but local git-blame(1) and
> git-annotate(1) runs do not, unless each user manually configures
> blame.ignoreRevsFile for every local checkout.

This is nicely explained

> Teach git-blame(1) and git-annotate(1) to automatically add the
> HEAD:.git-blame-ignore-revs blob, if it exists, as the initial element
> in the list of ignore-revs files in both bare and non-bare
> repositories. Reading the committed blob from HEAD rather than the
> working tree ensures that local runs match hosting platforms even when
> an untracked .git-blame-ignore-revs file is present or a tracked one
> has uncommitted local changes.

I can see we'd want to use the committed version in a bare repository, 
but it seems strange to me to ignore uncommitted changes in a non-bare 
repository. We don't do that for other special files like 
.gitattributes. It is rather inconvinient if the user has to explicitly 
pass the file inorder to test the effect of local modification to 
.git-brame-ignore-revs. To me it would make more sense to automatically 
use .git-blame-ignore-revs file from the working tree when that path is 
tracked by git.

I did wonder if we wanted to automatically support 
.git-blame-ignore-revs in the root of a subtree, but I don't think there 
is an easy way to do that without visiting all the directories 
containing tracked files which makes it too expensive.

One final thought - do we want to limit the size of the blob that we're 
prepared to parse as we do for .gitattributes? I had a very quick look 
at the khash code which is used by 'struct oidset' and it seems to use 
32 bit integers for the number of entries. I did not spend anytime 
trying to figure out what happens if you try and store 2^32 entires.

Thanks

Phillip

> To ensure consistent precedence and override semantics:
> - The default HEAD:.git-blame-ignore-revs entry is added before reading
>    configuration and CLI options, preserving user and repository config
>    overrides.
> - In git_blame_config(), blame.ignoreRevsFile entries are appended via
>    string_list_append() rather than inserted in sorted order via
>    string_list_insert() so that configuration entries preserve their
>    order relative to the initial default entry.
> - The HEAD:.git-blame-ignore-revs tree entry is resolved quietly via
>    get_oid_with_context(). Its mode is checked with S_ISREG() before
>    reading the object so that non-regular tree entries (such as a
>    committed symbolic link whose blob stores a target path rather than
>    revision IDs, a subdirectory, or a gitlink) are skipped instead of
>    being read and rejected as malformed object names. The blob is parsed
>    in memory via a new oidset_parse_buffer_carefully() helper in
>    oidset.c that shares line parsing with oidset_parse_file_carefully().
> - In build_ignorelist(), ignore-revs entries are processed starting
>    after the last empty string entry. This ensures setting
>    blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
>    --no-ignore-revs-file cleanly discards the default blob without
>    attempting to read or parse it, allowing users to bypass a malformed
>    default blob.
> 
> Update documentation in blame-options.adoc and config/blame.adoc, and
> add comprehensive test coverage in t8013 for the default blob lookup,
> subdirectory invocations, bare repositories, uncommitted and untracked
> working-tree files, CLI and config overrides, committed symlink
> entries, and comments and whitespace handling.
> 
> Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ravi Mistry <rmistry@google.com>
> ---
>   Documentation/blame-options.adoc |   8 +-
>   Documentation/config/blame.adoc  |   9 +-
>   builtin/blame.c                  |  45 +++++++-
>   oidset.c                         |  84 +++++++++-----
>   oidset.h                         |   9 ++
>   t/t8013-blame-ignore-revs.sh     | 182 +++++++++++++++++++++++++++++++
>   6 files changed, 301 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
> index 1ae1222b6b..8d59dcc8f3 100644
> --- a/Documentation/blame-options.adoc
> +++ b/Documentation/blame-options.adoc
> @@ -132,9 +132,11 @@ take effect.
>   `--ignore-revs-file <file>`::
>   	Ignore revisions listed in _<file>_, which must be in the same format as an
>   	`fsck.skipList`.  This option may be repeated, and these files will be
> -	processed after any files specified with the `blame.ignoreRevsFile` config
> -	option.  An empty file name, `""`, will clear the list of revs from
> -	previously processed files.
> +	processed after the default `HEAD:.git-blame-ignore-revs` blob (if it
> +	exists) and any files specified with the `blame.ignoreRevsFile` config
> +	option.  An empty file name, `""`, or `--no-ignore-revs-file` will clear
> +	the list of revs from previously processed files, including the default
> +	`HEAD:.git-blame-ignore-revs` blob.
>   
>   `--color-lines`::
>   	Color line annotations in the default format differently if they come from
> diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
> index 4d047c1790..153d4ab524 100644
> --- a/Documentation/config/blame.adoc
> +++ b/Documentation/config/blame.adoc
> @@ -23,9 +23,12 @@ blame.showRoot::
>   blame.ignoreRevsFile::
>   	Ignore revisions listed in the file, one unabbreviated object name per
>   	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
> -	`#` are ignored.  This option may be repeated multiple times.  Empty
> -	file names will reset the list of ignored revisions.  This option will
> -	be handled before the command line option `--ignore-revs-file`.
> +	`#` are ignored.  If the `HEAD:.git-blame-ignore-revs` blob exists, it
> +	is added as the initial element in the list of ignore-revs files.
> +	Other files listed in the configuration are also used, but an empty
> +	element makes all elements that appeared before in the list forgotten.
> +	This option will be handled before the command line option
> +	`--ignore-revs-file`.
>   
>   blame.markUnblamableLines::
>   	Mark lines that were changed by an ignored revision that we could not
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 6741a7b9df..f5b944f182 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -769,7 +769,7 @@ static int git_blame_config(const char *var, const char *value,
>   		if (ret)
>   			return ret;
>   		if (str)
> -			string_list_insert(&ignore_revs_file_list, str);
> +			string_list_append(&ignore_revs_file_list, str);
>   		free(str);
>   		return 0;
>   	}
> @@ -946,17 +946,52 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
>   	}
>   }
>   
> +static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
> +					   const char *name)
> +{
> +	struct object_context oc;
> +	struct object_id oid;
> +	enum object_type type;
> +	size_t size;
> +	char *buf;
> +
> +	if (get_oid_with_context(sb->repo, name, GET_OID_QUIETLY,
> +				 &oid, &oc))
> +		goto out;
> +	if (!S_ISREG(oc.mode))
> +		goto out;
> +
> +	buf = odb_read_object(sb->repo->objects, &oid, &type, &size);
> +	if (!buf)
> +		goto out;
> +	if (type == OBJ_BLOB)
> +		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
> +					      sb->repo->hash_algo,
> +					      peel_to_commit_oid, sb);
> +	free(buf);
> +
> +out:
> +	object_context_release(&oc);
> +}
> +
>   static void build_ignorelist(struct blame_scoreboard *sb,
>   			     struct string_list *ignore_revs_file_list,
>   			     struct string_list *ignore_rev_list)
>   {
>   	struct string_list_item *i;
>   	struct object_id oid;
> +	size_t start_idx = 0, idx;
> +
> +	for (idx = 0; idx < ignore_revs_file_list->nr; idx++) {
> +		if (!*ignore_revs_file_list->items[idx].string)
> +			start_idx = idx + 1;
> +	}
>   
>   	oidset_init(&sb->ignore_list, 0);
> -	for_each_string_list_item(i, ignore_revs_file_list) {
> -		if (!strcmp(i->string, ""))
> -			oidset_clear(&sb->ignore_list);
> +	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {
> +		i = &ignore_revs_file_list->items[idx];
> +		if (i->util)
> +			parse_default_ignore_revs_blob(sb, i->string);
>   		else
>   			oidset_parse_file_carefully(&sb->ignore_list, i->string,
>   						    the_repository->hash_algo,
> @@ -1036,6 +1071,8 @@ int cmd_blame(int argc,
>   	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
>   
>   	setup_default_color_by_age();
> +	string_list_append(&ignore_revs_file_list,
> +			   "HEAD:.git-blame-ignore-revs")->util = &sb;
>   	repo_config(the_repository, git_blame_config, &output_option);
>   	repo_init_revisions(the_repository, &revs, NULL);
>   	revs.date_mode = blame_date_mode;
> diff --git a/oidset.c b/oidset.c
> index 90d39204d3..8469d03b9b 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -70,44 +70,76 @@ void oidset_parse_file(struct oidset *set, const char *path,
>   	oidset_parse_file_carefully(set, path, algop, NULL, NULL);
>   }
>   
> +static void parse_oidset_line(struct oidset *set, struct strbuf *sb,
> +			      const struct git_hash_algo *algop,
> +			      oidset_parse_tweak_fn fn, void *cbdata)
> +{
> +	const char *p;
> +	const char *name;
> +	struct object_id oid;
> +
> +	if (memchr(sb->buf, '\0', sb->len))
> +		die("invalid object name: %s", sb->buf);
> +
> +	/*
> +	 * Allow trailing comments, leading whitespace
> +	 * (including before commits), and empty or whitespace
> +	 * only lines.
> +	 */
> +	name = strchr(sb->buf, '#');
> +	if (name)
> +		strbuf_setlen(sb, name - sb->buf);
> +	strbuf_trim(sb);
> +	if (!sb->len)
> +		return;
> +
> +	if (parse_oid_hex_algop(sb->buf, &oid, &p, algop) || *p != '\0')
> +		die("invalid object name: %s", sb->buf);
> +	if (fn && fn(&oid, cbdata))
> +		return;
> +	oidset_insert(set, &oid);
> +}
> +
>   void oidset_parse_file_carefully(struct oidset *set, const char *path,
>   				 const struct git_hash_algo *algop,
>   				 oidset_parse_tweak_fn fn, void *cbdata)
>   {
>   	FILE *fp;
>   	struct strbuf sb = STRBUF_INIT;
> -	struct object_id oid;
>   
>   	fp = fopen(path, "r");
>   	if (!fp)
>   		die("could not open object name list: %s", path);
> -	while (!strbuf_getline(&sb, fp)) {
> -		const char *p;
> -		const char *name;
> -
> -		if (memchr(sb.buf, '\0', sb.len))
> -			die("invalid object name: %s", sb.buf);
> -
> -		/*
> -		 * Allow trailing comments, leading whitespace
> -		 * (including before commits), and empty or whitespace
> -		 * only lines.
> -		 */
> -		name = strchr(sb.buf, '#');
> -		if (name)
> -			strbuf_setlen(&sb, name - sb.buf);
> -		strbuf_trim(&sb);
> -		if (!sb.len)
> -			continue;
> -
> -		if (parse_oid_hex_algop(sb.buf, &oid, &p, algop) || *p != '\0')
> -			die("invalid object name: %s", sb.buf);
> -		if (fn && fn(&oid, cbdata))
> -			continue;
> -		oidset_insert(set, &oid);
> -	}
> +	while (!strbuf_getline(&sb, fp))
> +		parse_oidset_line(set, &sb, algop, fn, cbdata);
>   	if (ferror(fp))
>   		die_errno("Could not read '%s'", path);
>   	fclose(fp);
>   	strbuf_release(&sb);
>   }
> +
> +void oidset_parse_buffer_carefully(struct oidset *set, const char *buf,
> +				   size_t size,
> +				   const struct git_hash_algo *algop,
> +				   oidset_parse_tweak_fn fn, void *cbdata)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *p = buf, *end;
> +
> +	if (!size)
> +		return;
> +	end = buf + size;
> +
> +	while (p < end) {
> +		const char *nl = memchr(p, '\n', end - p);
> +		size_t len = (nl ? nl : end) - p;
> +
> +		strbuf_reset(&sb);
> +		if (len && p[len - 1] == '\r')
> +			len--;
> +		strbuf_add(&sb, p, len);
> +		parse_oidset_line(set, &sb, algop, fn, cbdata);
> +		p = nl ? nl + 1 : end;
> +	}
> +	strbuf_release(&sb);
> +}
> diff --git a/oidset.h b/oidset.h
> index e0f1a6ff4f..667c390842 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -98,6 +98,15 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
>   				 const struct git_hash_algo *algop,
>   				 oidset_parse_tweak_fn fn, void *cbdata);
>   
> +/*
> + * Similar to oidset_parse_file_carefully(), but parses lines from an
> + * in-memory buffer of 'size' bytes.
> + */
> +void oidset_parse_buffer_carefully(struct oidset *set, const char *buf,
> +				   size_t size,
> +				   const struct git_hash_algo *algop,
> +				   oidset_parse_tweak_fn fn, void *cbdata);
> +
>   struct oidset_iter {
>   	const kh_oid_set_t *set;
>   	khiter_t iter;
> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index 70fe509a64..3e1b5291aa 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -365,4 +365,186 @@ test_expect_success 'ignore-revs-file peels chained tags and skips missing tag t
>   	test_cmp expect actual
>   '
>   
> +# Tests for default HEAD:.git-blame-ignore-revs blob
> +test_expect_success 'setup default HEAD:.git-blame-ignore-revs' '
> +	git checkout -b default-file-branch &&
> +	test_write_lines line1 line2 >def-file &&
> +	git add def-file &&
> +	test_tick &&
> +	git commit -m "default base" &&
> +	git tag DEF_A &&
> +
> +	test_write_lines line1-modified line2-modified >def-file &&
> +	git add def-file &&
> +	test_tick &&
> +	git commit -m "default mod" &&
> +	git tag DEF_B &&
> +
> +	git rev-parse DEF_B >.git-blame-ignore-revs &&
> +	git add .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "add .git-blame-ignore-revs"
> +'
> +
> +test_expect_success 'default HEAD:.git-blame-ignore-revs is used by default' '
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_A >expect &&
> +	test_cmp expect actual &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'default HEAD:.git-blame-ignore-revs respected by git annotate' '
> +	git rev-parse --short DEF_A >expect_sha &&
> +	git annotate def-file >actual &&
> +	test_grep "^$(cat expect_sha)" actual
> +'
> +
> +test_expect_success 'default HEAD:.git-blame-ignore-revs works from subdirectory' '
> +	mkdir -p sub &&
> +	(
> +		cd sub &&
> +		git blame --line-porcelain ../def-file >blame_raw &&
> +		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +		git rev-parse DEF_A >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'default HEAD:.git-blame-ignore-revs respected in bare repo' '
> +	test_when_finished "rm -rf bare.git" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'uncommitted .git-blame-ignore-revs changes in working tree are ignored' '
> +	test_when_finished "git checkout -- .git-blame-ignore-revs" &&
> +	echo "invalid-oid-value" >.git-blame-ignore-revs &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --no-ignore-revs-file' '
> +	git blame --line-porcelain --no-ignore-revs-file def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_B >expect &&
> +	test_cmp expect actual &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --ignore-revs-file ""' '
> +	git blame --line-porcelain --ignore-revs-file "" def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_B >expect &&
> +	test_cmp expect actual &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'disable default HEAD:.git-blame-ignore-revs with blame.ignoreRevsFile=""' '
> +	test_config blame.ignoreRevsFile "" &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_B >expect &&
> +	test_cmp expect actual &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'default HEAD:.git-blame-ignore-revs handles comments and whitespace' '
> +	rev_def_b=$(git rev-parse DEF_B) &&
> +	{
> +		echo "# Leading comment" &&
> +		echo "" &&
> +		echo "   $rev_def_b   # inline comment" &&
> +		echo "# Trailing comment"
> +	} >.git-blame-ignore-revs &&
> +	git add .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "comments and whitespace in .git-blame-ignore-revs" &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'empty default HEAD:.git-blame-ignore-revs is harmless' '
> +	: >.git-blame-ignore-revs &&
> +	git add .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "empty .git-blame-ignore-revs" &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_B >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'committed symlink .git-blame-ignore-revs in HEAD is ignored' '
> +	git rm -f .git-blame-ignore-revs &&
> +	git rev-parse DEF_B >target_file &&
> +	test_ln_s_add target_file .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "symlink .git-blame-ignore-revs" &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_B >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'malformed default HEAD:.git-blame-ignore-revs fails but can be bypassed' '
> +	git rm -f .git-blame-ignore-revs &&
> +	echo "invalid-oid-value" >.git-blame-ignore-revs &&
> +	git add .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "malformed .git-blame-ignore-revs" &&
> +	test_must_fail git blame def-file &&
> +	git blame --no-ignore-revs-file def-file &&
> +	git blame --ignore-revs-file "" def-file &&
> +	git -c blame.ignoreRevsFile="" blame def-file &&
> +
> +	rev_def_b=$(git rev-parse DEF_B) &&
> +	printf "%sQgarbage\n" "$rev_def_b" | q_to_nul >.git-blame-ignore-revs &&
> +	git add .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "NUL in .git-blame-ignore-revs" &&
> +	test_must_fail git blame def-file 2>err &&
> +	test_grep "invalid object name:" err
> +'
> +
> +test_expect_success 'default HEAD:.git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
> +	git rev-parse DEF_B >.git-blame-ignore-revs &&
> +	test_write_lines line1-modified line2-c >def-file &&
> +	git add .git-blame-ignore-revs def-file &&
> +	test_tick &&
> +	git commit -m C &&
> +	git tag DEF_C &&
> +	git rev-parse DEF_C >custom_ignore &&
> +	test_config blame.ignoreRevsFile custom_ignore &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_A >expect &&
> +	test_cmp expect actual &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'blame works when HEAD:.git-blame-ignore-revs does not exist and ignores untracked file' '
> +	git rm -f .git-blame-ignore-revs &&
> +	test_tick &&
> +	git commit -m "remove .git-blame-ignore-revs" &&
> +	git rev-parse DEF_B >.git-blame-ignore-revs &&
> +	git blame --line-porcelain def-file >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
> +	git rev-parse DEF_B >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_done

