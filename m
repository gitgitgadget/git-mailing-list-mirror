Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A8B640
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672256; cv=none; b=SWuR99AHeANSZ+D7cneyHycixoTVMBVvRG+XbL+bWPWBILZ8K1bN6ghafCQQ/jEx0P375K5cOvUclT8ARHYVuThDyQ8XDsGEMSFn/YjCo6s63ePh4zRITr/+euzRrWxVnh35ENAYDs4B24Hz/NHQKtBXafln9P1EVZHx0T/TIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672256; c=relaxed/simple;
	bh=bmh7qsMwEwD6/i2Fw5GQhwji8MpUCJhKS5Y/uV9tMCU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rrxMV1LTLqs0KBoc1+eslvsv/osTabXWAvdieNLmiV7PLjwirx0TQSD/yFnS2CcZKst1AdPQE+1nAHdk7qd2nfBLvLSZlRx/EJvAT8aNQQk8+pB+lFaiGnolQ7z3yzS7rbAi+L9pI8mYTAZv3pVQbseczrrSHcmMm9K41rfeJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoBBxn9/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoBBxn9/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb49f63238so414894685a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772672252; x=1773277052; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGxmJ14gPj8r/BsAZqyEnr8GpoOG0gDtBVB3rgXwpHU=;
        b=PoBBxn9/+kWGh9qK60jjKhierLwv0FPQtel5p10wm7j5xCWWwuEuYS8o6mLeentKUy
         +xmB6uuEQFiM1WcoHIhNbmwTKRyDMbCUuwfeJRZ80j6f00hd+0pay2jPvrQJH8w+pfxg
         k3qS1T5Mkn00t4sb1d4f5K6y+Nl8UEh3b3JzlpmfZLEvmOiNiEWWOCQc2/h/uBkgVFzl
         PYLcoY5XoYiqYG1/DaXEqE+OL7rtzwof7psF5l6bjI8KJvljnMQuLUd5U0zgDXelzUGl
         hSsrnJmQcUP1iXKqJ3zWrw+++YNDHlMtt3+rL+d7PgEzx1JnKcRgTBIbMxNB0poFVJaN
         UuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772672252; x=1773277052;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zGxmJ14gPj8r/BsAZqyEnr8GpoOG0gDtBVB3rgXwpHU=;
        b=uhC2iGy6ZmZLhSVTg3Fzp18p2IYIxMCbq+Fv6wg9bKqNHGIpfd1E7pHXraZuuIgvSj
         yu2B+oGsaFlohHmDiQaKzHmzUJQmh4aVXWdaSPbPXxaqqdrlZcZSIuTSsrXKQivSqMwr
         CCIjlP+3FxnlYnb2yjmiOQkvCoRK//Ugf6UAX/3KZLUoeLdqcstwsg7v6iMe1MCkvBXs
         wJ9DCnLo50L66Kizp6sq3wC3L+LEG+CaDRvA039JTzd435BxA/0QSPSbAzB6Ya+6W9Ui
         7PLI7d3hQXBr202BnXSKRTA+yozvYRDzZU+eP3p8+lbMkrUeFdxkuGsg1PZx/mh8OnXS
         QDqw==
X-Gm-Message-State: AOJu0Yyl10+jYskv8W/k77kk9W+WQqUQDGbKmnd1r7bUykPUyTrkXr02
	56thFNgRNa1/05+OXUL4UHnM6WbUHj+HVAFScQxHB4/Gvh95d0vMRix6OAl/nkgq
X-Gm-Gg: ATEYQzyblzRPyLNzmEquQ4ak1vqyYIKEVqndZAanoELW9JDf+bRNXpqLzaL5nyYYtId
	wcy51yh3j1hdOIe9nE9g7J4osm1eoBR+l+MHgIT3xTEQfpOCEw0Ej/8FlmWT6DHm+AYmRQuGVAN
	oJQpuaR5h+3hdChYZTdzOmQjcu9/zXfte9O3hg5U2eGmG/HBRnxiJAMtlGQKwx1DzQSNS43eXMH
	Db8hKESZFEKiO/4ulJDWfnzTawN+tLjll+RB20qd8eXhSt9S7IJm2NwABL0DDckp5jxbn4yMvgy
	7qx0IR61EVeegnpNlrI0HkFSL5JwMd/GWr19c+Op2ov8Ow/T6jTWMqW+IGHmBC97EGbANxSfap8
	SgZwjmFn5C/ncRGdPt26djtXzWNJooKM/lbE+UBxctWDT6etySAaz09YQTC9D6ChqFENB6Jop3G
	nhwFLOHKzpPZzg+SIGxa5F7vAF
X-Received: by 2002:a05:620a:4609:b0:8c9:fc46:235c with SMTP id af79cd13be357-8cd5afc1082mr505053385a.71.1772672252272;
        Wed, 04 Mar 2026 16:57:32 -0800 (PST)
Received: from [127.0.0.1] ([20.161.47.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf659210sm1746498785a.8.2026.03.04.16.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:57:31 -0800 (PST)
Message-Id: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
In-Reply-To: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
From: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:57:31 +0000
Subject: [PATCH v2] clone: add clone.<url>.defaultObjectFilter config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: ps@pks.im,
    christian.couder@gmail.com,
    jonathantanmy@google.com,
    me@ttaylorr.com,
    gitster@pobox.com,
    Jeff King <peff@peff.net>,
    Alan Braithwaite <alan@braithwaite.dev>,
    Alan Braithwaite <alan@braithwaite.dev>

From: Alan Braithwaite <alan@braithwaite.dev>

Add a new configuration option that lets users specify a default
partial clone filter per URL pattern.  When cloning a repository
whose URL matches a configured pattern, git-clone automatically
applies the filter, equivalent to passing --filter on the command
line.

    [clone "https://github.com/"]
        defaultObjectFilter = blob:limit=5m

    [clone "https://internal.corp.com/large-project/"]
        defaultObjectFilter = blob:none

URL matching uses the existing urlmatch_config_entry() infrastructure,
following the same rules as http.<url>.* — you can match a domain,
a namespace path, or a specific project, and the most specific match
wins.

The config only affects the initial clone.  Once the clone completes,
the filter is recorded in remote.<name>.partialCloneFilter, so
subsequent fetches inherit it automatically.  An explicit --filter
flag on the command line takes precedence.

Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
honored; a bare clone.defaultObjectFilter without a URL subsection
is ignored.

Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
---
    fetch, clone: add fetch.blobSizeLimit config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2058

Range-diff vs v1:

 1:  818b64e2e2 ! 1:  4a73edd2e8 fetch, clone: add fetch.blobSizeLimit config
     @@ Metadata
      Author: Alan Braithwaite <alan@braithwaite.dev>
      
       ## Commit message ##
     -    fetch, clone: add fetch.blobSizeLimit config
     +    clone: add clone.<url>.defaultObjectFilter config
      
     -    External tools like git-lfs and git-fat use the filter clean/smudge
     -    mechanism to manage large binary objects, but this requires pointer
     -    files, a separate storage backend, and careful coordination. Git's
     -    partial clone infrastructure provides a more native approach: large
     -    blobs can be excluded at the protocol level during fetch and lazily
     -    retrieved on demand. However, enabling this requires passing
     -    `--filter=blob:limit=<size>` on every clone, which is not
     -    discoverable and cannot be set as a global default.
     +    Add a new configuration option that lets users specify a default
     +    partial clone filter per URL pattern.  When cloning a repository
     +    whose URL matches a configured pattern, git-clone automatically
     +    applies the filter, equivalent to passing --filter on the command
     +    line.
      
     -    Add a new `fetch.blobSizeLimit` configuration option that enables
     -    size-based partial clone behavior globally. When set, both `git
     -    clone` and `git fetch` automatically apply a `blob:limit=<size>`
     -    filter. Blobs larger than the threshold that are not needed for the
     -    current worktree are excluded from the transfer and lazily fetched
     -    on demand when needed (e.g., during checkout, diff, or merge).
     +        [clone "https://github.com/"]
     +            defaultObjectFilter = blob:limit=5m
      
     -    This makes it easy to work with repositories that have accumulated
     -    large binary files in their history, without downloading all of
     -    them upfront.
     +        [clone "https://internal.corp.com/large-project/"]
     +            defaultObjectFilter = blob:none
      
     -    The precedence order is:
     -      1. Explicit `--filter=` on the command line (highest)
     -      2. Existing `remote.<name>.partialclonefilter`
     -      3. `fetch.blobSizeLimit` (new, lowest)
     +    URL matching uses the existing urlmatch_config_entry() infrastructure,
     +    following the same rules as http.<url>.* — you can match a domain,
     +    a namespace path, or a specific project, and the most specific match
     +    wins.
      
     -    Once a clone or fetch applies this setting, the remote is registered
     -    as a promisor remote with the corresponding filter spec, so
     -    subsequent fetches inherit it automatically. If the server does not
     -    support object filtering, the setting is silently ignored.
     +    The config only affects the initial clone.  Once the clone completes,
     +    the filter is recorded in remote.<name>.partialCloneFilter, so
     +    subsequent fetches inherit it automatically.  An explicit --filter
     +    flag on the command line takes precedence.
     +
     +    Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
     +    honored; a bare clone.defaultObjectFilter without a URL subsection
     +    is ignored.
      
          Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
      
     - ## Documentation/config/fetch.adoc ##
     -@@ Documentation/config/fetch.adoc: config setting.
     - 	file helps performance of many Git commands, including `git merge-base`,
     - 	`git push -f`, and `git log --graph`. Defaults to `false`.
     - 
     -+`fetch.blobSizeLimit`::
     -+	When set to a size value (e.g., `1m`, `100k`, `1g`), both
     -+	linkgit:git-clone[1] and linkgit:git-fetch[1] will automatically
     -+	use `--filter=blob:limit=<value>` to enable partial clone
     -+	behavior. Blobs larger than this threshold are excluded from the
     -+	initial transfer and lazily fetched on demand when needed (e.g.,
     -+	during checkout).
     + ## Documentation/config/clone.adoc ##
     +@@ Documentation/config/clone.adoc: endif::[]
     + 	If a partial clone filter is provided (see `--filter` in
     + 	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
     + 	the filter to submodules.
     ++
     ++`clone.<url>.defaultObjectFilter`::
     ++	When set to a filter spec string (e.g., `blob:limit=1m`,
     ++	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
     ++	use `--filter=<value>` when the clone URL matches `<url>`.
     ++	Objects matching the filter are excluded from the initial
     ++	transfer and lazily fetched on demand (e.g., during checkout).
     ++	Subsequent fetches inherit the filter via the per-remote config
     ++	that is written during the clone.
      ++
     -+This provides a convenient way to enable size-based partial clones
     -+globally without passing `--filter` on every command. Once a clone or
     -+fetch applies this setting, the remote is registered as a promisor
     -+remote with the corresponding filter, so subsequent fetches inherit
     -+the filter automatically.
     ++The URL matching follows the same rules as `http.<url>.*` (see
     ++linkgit:git-config[1]).  The most specific URL match wins.  You can
     ++match a complete domain, a namespace, or a specific project:
      ++
     -+An explicit `--filter` option on the command line takes precedence over
     -+this config. An existing `remote.<name>.partialclonefilter` also takes
     -+precedence. If the server does not support object filtering, the
     -+setting is silently ignored.
     ++----
     ++[clone "https://github.com/"]
     ++    defaultObjectFilter = blob:limit=5m
      +
     - `fetch.bundleURI`::
     - 	This value stores a URI for downloading Git object data from a bundle
     - 	URI before performing an incremental fetch from the origin Git server.
     ++[clone "https://internal.corp.com/large-project/"]
     ++    defaultObjectFilter = blob:none
     ++----
     +++
     ++An explicit `--filter` option on the command line takes precedence
     ++over this config.  Only affects the initial clone; it has no effect
     ++on later fetches into an existing repository.  If the server does
     ++not support object filtering, the setting is silently ignored.
      
       ## builtin/clone.c ##
     -@@ builtin/clone.c: static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
     - static int max_jobs = -1;
     - static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
     - static int config_filter_submodules = -1;    /* unspecified */
     -+static char *config_blob_size_limit;
     - static int option_remote_submodules;
     - 
     - static int recurse_submodules_cb(const struct option *opt,
     +@@
     + #include "path.h"
     + #include "pkt-line.h"
     + #include "list-objects-filter-options.h"
     ++#include "urlmatch.h"
     + #include "hook.h"
     + #include "bundle.h"
     + #include "bundle-uri.h"
      @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v,
     - 		config_reject_shallow = git_config_bool(k, v);
     - 	if (!strcmp(k, "clone.filtersubmodules"))
     - 		config_filter_submodules = git_config_bool(k, v);
     -+	if (!strcmp(k, "fetch.blobsizelimit")) {
     -+		free(config_blob_size_limit);
     -+		git_config_string(&config_blob_size_limit, k, v);
     -+	}
     - 
       	return git_default_config(k, v, ctx, cb);
       }
     -@@ builtin/clone.c: int cmd_clone(int argc,
     - 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
     - 			     builtin_clone_usage, 0);
       
     -+	if (!filter_options.choice && config_blob_size_limit) {
     -+		struct strbuf buf = STRBUF_INIT;
     -+		strbuf_addf(&buf, "blob:limit=%s", config_blob_size_limit);
     -+		parse_list_objects_filter(&filter_options, buf.buf);
     -+		strbuf_release(&buf);
     ++struct clone_filter_data {
     ++	char *default_object_filter;
     ++};
     ++
     ++static int clone_filter_collect(const char *var, const char *value,
     ++				const struct config_context *ctx UNUSED,
     ++				void *cb)
     ++{
     ++	struct clone_filter_data *data = cb;
     ++
     ++	if (!strcmp(var, "clone.defaultobjectfilter")) {
     ++		free(data->default_object_filter);
     ++		data->default_object_filter = xstrdup(value);
      +	}
     ++	return 0;
     ++}
     ++
     ++/*
     ++ * Look up clone.<url>.defaultObjectFilter using the urlmatch
     ++ * infrastructure.  Only URL-qualified forms are supported; a bare
     ++ * clone.defaultObjectFilter (without a URL) is ignored.
     ++ */
     ++static char *get_default_object_filter(const char *url)
     ++{
     ++	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
     ++	struct clone_filter_data data = { 0 };
     ++	struct string_list_item *item;
     ++	char *normalized_url;
     ++
     ++	config.section = "clone";
     ++	config.key = "defaultobjectfilter";
     ++	config.collect_fn = clone_filter_collect;
     ++	config.cascade_fn = git_clone_config;
     ++	config.cb = &data;
     ++
     ++	normalized_url = url_normalize(url, &config.url);
     ++
     ++	repo_config(the_repository, urlmatch_config_entry, &config);
     ++	free(normalized_url);
      +
     - 	if (argc > 2)
     - 		usage_msg_opt(_("Too many arguments."),
     - 			builtin_clone_usage, builtin_clone_options);
     -@@ builtin/clone.c: int cmd_clone(int argc,
     - 		       ref_storage_format);
     - 
     - 	list_objects_filter_release(&filter_options);
     -+	free(config_blob_size_limit);
     - 
     - 	string_list_clear(&option_not, 0);
     - 	string_list_clear(&option_config, 0);
     -
     - ## builtin/fetch.c ##
     -@@ builtin/fetch.c: struct fetch_config {
     - 	int recurse_submodules;
     - 	int parallel;
     - 	int submodule_fetch_jobs;
     -+	char *blob_size_limit;
     - };
     - 
     - static int git_fetch_config(const char *k, const char *v,
     -@@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
     - 		return 0;
     - 	}
     - 
     -+	if (!strcmp(k, "fetch.blobsizelimit"))
     -+		return git_config_string(&fetch_config->blob_size_limit, k, v);
     -+
     - 	if (!strcmp(k, "fetch.output")) {
     - 		if (!v)
     - 			return config_error_nonbool(k);
     -@@ builtin/fetch.c: static int fetch_multiple(struct string_list *list, int max_children,
     -  * or inherit the default filter-spec from the config.
     -  */
     - static inline void fetch_one_setup_partial(struct remote *remote,
     --					   struct list_objects_filter_options *filter_options)
     -+					   struct list_objects_filter_options *filter_options,
     -+					   const struct fetch_config *config)
     - {
     - 	/*
     - 	 * Explicit --no-filter argument overrides everything, regardless
     -@@ builtin/fetch.c: static inline void fetch_one_setup_partial(struct remote *remote,
     - 		return;
     - 
     - 	/*
     --	 * If no prior partial clone/fetch and the current fetch DID NOT
     --	 * request a partial-fetch, do a normal fetch.
     -+	 * If no prior partial clone/fetch, the current fetch did not
     -+	 * request a partial-fetch, and no global blob size limit is
     -+	 * configured, do a normal fetch.
     - 	 */
     --	if (!repo_has_promisor_remote(the_repository) && !filter_options->choice)
     -+	if (!repo_has_promisor_remote(the_repository) &&
     -+	    !filter_options->choice && !config->blob_size_limit)
     - 		return;
     - 
     - 	/*
     -@@ builtin/fetch.c: static inline void fetch_one_setup_partial(struct remote *remote,
     - 	/*
     - 	 * Do a partial-fetch from the promisor remote using either the
     - 	 * explicitly given filter-spec or inherit the filter-spec from
     --	 * the config.
     -+	 * the per-remote config.
     ++	/*
     ++	 * Reject the bare form clone.defaultObjectFilter (no URL
     ++	 * subsection).  urlmatch stores the best match in vars with
     ++	 * hostmatch_len == 0 for non-URL-qualified entries; discard
     ++	 * the result if that is what we got.
      +	 */
     -+	if (repo_has_promisor_remote(the_repository)) {
     -+		partial_clone_get_default_filter_spec(filter_options,
     -+						      remote->name);
     -+		if (filter_options->choice)
     -+			return;
     ++	item = string_list_lookup(&config.vars, "defaultobjectfilter");
     ++	if (item) {
     ++		const struct urlmatch_item *m = item->util;
     ++		if (!m->hostmatch_len && !m->pathmatch_len) {
     ++			FREE_AND_NULL(data.default_object_filter);
     ++		}
      +	}
      +
     -+	/*
     -+	 * Fall back to the global fetch.blobSizeLimit config. This
     -+	 * enables partial clone behavior without requiring --filter
     -+	 * on the command line or a pre-existing promisor remote.
     - 	 */
     --	if (!filter_options->choice)
     --		partial_clone_get_default_filter_spec(filter_options, remote->name);
     --	return;
     -+	if (!filter_options->choice && config->blob_size_limit) {
     -+		struct strbuf buf = STRBUF_INIT;
     -+		strbuf_addf(&buf, "blob:limit=%s", config->blob_size_limit);
     -+		parse_list_objects_filter(filter_options, buf.buf);
     -+		strbuf_release(&buf);
     -+		partial_clone_register(remote->name, filter_options);
     -+	}
     - }
     ++	urlmatch_config_release(&config);
     ++
     ++	return data.default_object_filter;
     ++}
     ++
     + static int write_one_config(const char *key, const char *value,
     + 			    const struct config_context *ctx,
     + 			    void *data)
     +@@ builtin/clone.c: int cmd_clone(int argc,
     + 	} else
     + 		die(_("repository '%s' does not exist"), repo_name);
       
     - static int fetch_one(struct remote *remote, int argc, const char **argv,
     -@@ builtin/fetch.c: int cmd_fetch(int argc,
     - 		oidset_clear(&acked_commits);
     - 		trace2_region_leave("fetch", "negotiate-only", the_repository);
     - 	} else if (remote) {
     --		if (filter_options.choice || repo_has_promisor_remote(the_repository)) {
     -+		if (filter_options.choice || repo_has_promisor_remote(the_repository) ||
     -+		    config.blob_size_limit) {
     - 			trace2_region_enter("fetch", "setup-partial", the_repository);
     --			fetch_one_setup_partial(remote, &filter_options);
     -+			fetch_one_setup_partial(remote, &filter_options, &config);
     - 			trace2_region_leave("fetch", "setup-partial", the_repository);
     - 		}
     - 		trace2_region_enter("fetch", "fetch-one", the_repository);
     -@@ builtin/fetch.c: int cmd_fetch(int argc,
     -  cleanup:
     - 	string_list_clear(&list, 0);
     - 	list_objects_filter_release(&filter_options);
     -+	free(config.blob_size_limit);
     - 	return result;
     - }
     ++	if (!filter_options.choice) {
     ++		char *config_filter = get_default_object_filter(repo);
     ++		if (config_filter) {
     ++			parse_list_objects_filter(&filter_options, config_filter);
     ++			free(config_filter);
     ++		}
     ++	}
     ++
     + 	/* no need to be strict, transport_set_option() will validate it again */
     + 	if (option_depth && atoi(option_depth) < 1)
     + 		die(_("depth %s is not a positive number"), option_depth);
      
       ## t/t5616-partial-clone.sh ##
      @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non-promisor commits, gc work
       	git -C partial gc --prune=now
       '
       
     -+# Test fetch.blobSizeLimit config
     ++# Test clone.<url>.defaultObjectFilter config
     ++
     ++test_expect_success 'setup for clone.defaultObjectFilter tests' '
     ++	git init default-filter-src &&
     ++	echo "small" >default-filter-src/small.txt &&
     ++	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
     ++	git -C default-filter-src add . &&
     ++	git -C default-filter-src commit -m "initial" &&
     ++
     ++	git clone --bare "file://$(pwd)/default-filter-src" default-filter-srv.bare &&
     ++	git -C default-filter-srv.bare config --local uploadpack.allowfilter 1 &&
     ++	git -C default-filter-srv.bare config --local uploadpack.allowanysha1inwant 1
     ++'
      +
     -+test_expect_success 'setup for fetch.blobSizeLimit tests' '
     -+	git init blob-limit-src &&
     -+	echo "small" >blob-limit-src/small.txt &&
     -+	dd if=/dev/zero of=blob-limit-src/large.bin bs=1024 count=100 2>/dev/null &&
     -+	git -C blob-limit-src add . &&
     -+	git -C blob-limit-src commit -m "initial" &&
     ++test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
     ++		"$SERVER_URL" default-filter-clone &&
      +
     -+	git clone --bare "file://$(pwd)/blob-limit-src" blob-limit-srv.bare &&
     -+	git -C blob-limit-srv.bare config --local uploadpack.allowfilter 1 &&
     -+	git -C blob-limit-srv.bare config --local uploadpack.allowanysha1inwant 1
     ++	test "$(git -C default-filter-clone config --local remote.origin.promisor)" = "true" &&
     ++	test "$(git -C default-filter-clone config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
      +'
      +
     -+test_expect_success 'clone with fetch.blobSizeLimit config applies filter' '
     -+	git -c fetch.blobSizeLimit=1k clone \
     -+		"file://$(pwd)/blob-limit-srv.bare" blob-limit-clone &&
     ++test_expect_success 'clone with --filter overrides clone.<url>.defaultObjectFilter' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" \
     ++		clone --filter=blob:none "$SERVER_URL" default-filter-override &&
      +
     -+	test "$(git -C blob-limit-clone config --local remote.origin.promisor)" = "true" &&
     -+	test "$(git -C blob-limit-clone config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
     ++	test "$(git -C default-filter-override config --local remote.origin.partialclonefilter)" = "blob:none"
      +'
      +
     -+test_expect_success 'clone with --filter overrides fetch.blobSizeLimit' '
     -+	git -c fetch.blobSizeLimit=1k clone --filter=blob:none \
     -+		"file://$(pwd)/blob-limit-srv.bare" blob-limit-override &&
     ++test_expect_success 'clone with clone.<url>.defaultObjectFilter=blob:none works' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" clone \
     ++		"$SERVER_URL" default-filter-blobnone &&
      +
     -+	test "$(git -C blob-limit-override config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	test "$(git -C default-filter-blobnone config --local remote.origin.promisor)" = "true" &&
     ++	test "$(git -C default-filter-blobnone config --local remote.origin.partialclonefilter)" = "blob:none"
      +'
      +
     -+test_expect_success 'fetch with fetch.blobSizeLimit registers promisor remote' '
     -+	git clone --no-checkout "file://$(pwd)/blob-limit-srv.bare" blob-limit-fetch &&
     ++test_expect_success 'clone.<url>.defaultObjectFilter with tree:0 works' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git -c "clone.$SERVER_URL.defaultObjectFilter=tree:0" clone \
     ++		"$SERVER_URL" default-filter-tree0 &&
      +
     -+	# Sanity: not yet a partial clone
     -+	test_must_fail git -C blob-limit-fetch config --local remote.origin.promisor &&
     -+
     -+	# Add a new commit to the server
     -+	echo "new-small" >blob-limit-src/new-small.txt &&
     -+	dd if=/dev/zero of=blob-limit-src/new-large.bin bs=1024 count=100 2>/dev/null &&
     -+	git -C blob-limit-src add . &&
     -+	git -C blob-limit-src commit -m "second" &&
     -+	git -C blob-limit-src push "file://$(pwd)/blob-limit-srv.bare" main &&
     ++	test "$(git -C default-filter-tree0 config --local remote.origin.promisor)" = "true" &&
     ++	test "$(git -C default-filter-tree0 config --local remote.origin.partialclonefilter)" = "tree:0"
     ++'
      +
     -+	# Fetch with the config set
     -+	git -C blob-limit-fetch -c fetch.blobSizeLimit=1k fetch origin &&
     ++test_expect_success 'most specific URL match wins for clone.defaultObjectFilter' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git \
     ++		-c "clone.file://.defaultObjectFilter=blob:limit=1k" \
     ++		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
     ++		clone "$SERVER_URL" default-filter-url-specific &&
      +
     -+	test "$(git -C blob-limit-fetch config --local remote.origin.promisor)" = "true" &&
     -+	test "$(git -C blob-limit-fetch config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
     ++	test "$(git -C default-filter-url-specific config --local remote.origin.partialclonefilter)" = "blob:none"
      +'
      +
     -+test_expect_success 'fetch.blobSizeLimit does not override existing partialclonefilter' '
     -+	git clone --filter=blob:none \
     -+		"file://$(pwd)/blob-limit-srv.bare" blob-limit-existing &&
     ++test_expect_success 'non-matching URL does not apply clone.defaultObjectFilter' '
     ++	git \
     ++		-c "clone.https://other.example.com/.defaultObjectFilter=blob:none" \
     ++		clone "file://$(pwd)/default-filter-srv.bare" default-filter-url-nomatch &&
      +
     -+	test "$(git -C blob-limit-existing config --local remote.origin.partialclonefilter)" = "blob:none" &&
     ++	test_must_fail git -C default-filter-url-nomatch config --local remote.origin.promisor
     ++'
      +
     -+	# Fetch with a different blobSizeLimit; existing filter should win
     -+	git -C blob-limit-existing -c fetch.blobSizeLimit=1k fetch origin &&
     ++test_expect_success 'bare clone.defaultObjectFilter without URL is ignored' '
     ++	git -c clone.defaultObjectFilter=blob:none \
     ++		clone "file://$(pwd)/default-filter-srv.bare" default-filter-bare-key &&
      +
     -+	test "$(git -C blob-limit-existing config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	test_must_fail git -C default-filter-bare-key config --local remote.origin.promisor
      +'
       
       . "$TEST_DIRECTORY"/lib-httpd.sh


 Documentation/config/clone.adoc | 26 ++++++++++++
 builtin/clone.c                 | 68 ++++++++++++++++++++++++++++++
 t/t5616-partial-clone.sh        | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/Documentation/config/clone.adoc b/Documentation/config/clone.adoc
index 0a10efd174..5805ab51c2 100644
--- a/Documentation/config/clone.adoc
+++ b/Documentation/config/clone.adoc
@@ -21,3 +21,29 @@ endif::[]
 	If a partial clone filter is provided (see `--filter` in
 	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
 	the filter to submodules.
+
+`clone.<url>.defaultObjectFilter`::
+	When set to a filter spec string (e.g., `blob:limit=1m`,
+	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
+	use `--filter=<value>` when the clone URL matches `<url>`.
+	Objects matching the filter are excluded from the initial
+	transfer and lazily fetched on demand (e.g., during checkout).
+	Subsequent fetches inherit the filter via the per-remote config
+	that is written during the clone.
++
+The URL matching follows the same rules as `http.<url>.*` (see
+linkgit:git-config[1]).  The most specific URL match wins.  You can
+match a complete domain, a namespace, or a specific project:
++
+----
+[clone "https://github.com/"]
+    defaultObjectFilter = blob:limit=5m
+
+[clone "https://internal.corp.com/large-project/"]
+    defaultObjectFilter = blob:none
+----
++
+An explicit `--filter` option on the command line takes precedence
+over this config.  Only affects the initial clone; it has no effect
+on later fetches into an existing repository.  If the server does
+not support object filtering, the setting is silently ignored.
diff --git a/builtin/clone.c b/builtin/clone.c
index 45d8fa0eed..5e20b5343d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -44,6 +44,7 @@
 #include "path.h"
 #include "pkt-line.h"
 #include "list-objects-filter-options.h"
+#include "urlmatch.h"
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
@@ -757,6 +758,65 @@ static int git_clone_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, cb);
 }
 
+struct clone_filter_data {
+	char *default_object_filter;
+};
+
+static int clone_filter_collect(const char *var, const char *value,
+				const struct config_context *ctx UNUSED,
+				void *cb)
+{
+	struct clone_filter_data *data = cb;
+
+	if (!strcmp(var, "clone.defaultobjectfilter")) {
+		free(data->default_object_filter);
+		data->default_object_filter = xstrdup(value);
+	}
+	return 0;
+}
+
+/*
+ * Look up clone.<url>.defaultObjectFilter using the urlmatch
+ * infrastructure.  Only URL-qualified forms are supported; a bare
+ * clone.defaultObjectFilter (without a URL) is ignored.
+ */
+static char *get_default_object_filter(const char *url)
+{
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
+	struct clone_filter_data data = { 0 };
+	struct string_list_item *item;
+	char *normalized_url;
+
+	config.section = "clone";
+	config.key = "defaultobjectfilter";
+	config.collect_fn = clone_filter_collect;
+	config.cascade_fn = git_clone_config;
+	config.cb = &data;
+
+	normalized_url = url_normalize(url, &config.url);
+
+	repo_config(the_repository, urlmatch_config_entry, &config);
+	free(normalized_url);
+
+	/*
+	 * Reject the bare form clone.defaultObjectFilter (no URL
+	 * subsection).  urlmatch stores the best match in vars with
+	 * hostmatch_len == 0 for non-URL-qualified entries; discard
+	 * the result if that is what we got.
+	 */
+	item = string_list_lookup(&config.vars, "defaultobjectfilter");
+	if (item) {
+		const struct urlmatch_item *m = item->util;
+		if (!m->hostmatch_len && !m->pathmatch_len) {
+			FREE_AND_NULL(data.default_object_filter);
+		}
+	}
+
+	urlmatch_config_release(&config);
+
+	return data.default_object_filter;
+}
+
 static int write_one_config(const char *key, const char *value,
 			    const struct config_context *ctx,
 			    void *data)
@@ -1057,6 +1117,14 @@ int cmd_clone(int argc,
 	} else
 		die(_("repository '%s' does not exist"), repo_name);
 
+	if (!filter_options.choice) {
+		char *config_filter = get_default_object_filter(repo);
+		if (config_filter) {
+			parse_list_objects_filter(&filter_options, config_filter);
+			free(config_filter);
+		}
+	}
+
 	/* no need to be strict, transport_set_option() will validate it again */
 	if (option_depth && atoi(option_depth) < 1)
 		die(_("depth %s is not a positive number"), option_depth);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1e354e057f..33010f3b7d 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -722,6 +722,79 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+# Test clone.<url>.defaultObjectFilter config
+
+test_expect_success 'setup for clone.defaultObjectFilter tests' '
+	git init default-filter-src &&
+	echo "small" >default-filter-src/small.txt &&
+	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
+	git -C default-filter-src add . &&
+	git -C default-filter-src commit -m "initial" &&
+
+	git clone --bare "file://$(pwd)/default-filter-src" default-filter-srv.bare &&
+	git -C default-filter-srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C default-filter-srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
+		"$SERVER_URL" default-filter-clone &&
+
+	test "$(git -C default-filter-clone config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-clone config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
+'
+
+test_expect_success 'clone with --filter overrides clone.<url>.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" \
+		clone --filter=blob:none "$SERVER_URL" default-filter-override &&
+
+	test "$(git -C default-filter-override config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'clone with clone.<url>.defaultObjectFilter=blob:none works' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" clone \
+		"$SERVER_URL" default-filter-blobnone &&
+
+	test "$(git -C default-filter-blobnone config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-blobnone config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'clone.<url>.defaultObjectFilter with tree:0 works' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=tree:0" clone \
+		"$SERVER_URL" default-filter-tree0 &&
+
+	test "$(git -C default-filter-tree0 config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-tree0 config --local remote.origin.partialclonefilter)" = "tree:0"
+'
+
+test_expect_success 'most specific URL match wins for clone.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git \
+		-c "clone.file://.defaultObjectFilter=blob:limit=1k" \
+		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
+		clone "$SERVER_URL" default-filter-url-specific &&
+
+	test "$(git -C default-filter-url-specific config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'non-matching URL does not apply clone.defaultObjectFilter' '
+	git \
+		-c "clone.https://other.example.com/.defaultObjectFilter=blob:none" \
+		clone "file://$(pwd)/default-filter-srv.bare" default-filter-url-nomatch &&
+
+	test_must_fail git -C default-filter-url-nomatch config --local remote.origin.promisor
+'
+
+test_expect_success 'bare clone.defaultObjectFilter without URL is ignored' '
+	git -c clone.defaultObjectFilter=blob:none \
+		clone "file://$(pwd)/default-filter-srv.bare" default-filter-bare-key &&
+
+	test_must_fail git -C default-filter-bare-key config --local remote.origin.promisor
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
