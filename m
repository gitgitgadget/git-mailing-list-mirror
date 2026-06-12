Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C6393DC0
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288999; cv=none; b=unjncmbbrGEl4KpbJLHJiiWrZNLGGzJ2B2Zuys56518VAo1nc3L6hxlkEBvoda14o6lzy83aLudc82rb3ODSTgNQq7XO8YrrumQQ8TzxQHEtwHVWF26Ut0QPMuoe3+TZnE89G5MWtcxHkqus4Bmo6OOgpdnPVctzFXq/H4+f/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288999; c=relaxed/simple;
	bh=PXi/60T8mBVE98dA3eM4kqwRmP8jhu06Gu1/+/hkzec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DligYjNVSKDwFD7+LO7SemQ4yQ8qdEQJ69mZLKWClc1refghNkRWePffg+T9nUKo2HVCSuog+SlwmIOFOA2yP4wQDL14XWJlSXMC17yEyJWJ+dPMRjYHoqtDRbM6lRHcmG+fKRR7Jhg2KZ3zythsTZL+Rh/iBZNfYFcioWz/KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQDQdKk3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQDQdKk3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f52af13so1062705b3a.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781288997; x=1781893797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmNqQ4TNInbt3EAZyDboSRKMGKUauOjQCy3M4sfFc1I=;
        b=MQDQdKk3qg30r2Z9Or6M2r5EdQpn+1i5Dums/iDZHSOyvbeXoBtw+0riXewltlakRV
         Ry9+7vsC2fd3ShDLW5Bf1Y3yy7qOz4e1jSmZpeLQ0k8DWbOsK9TQ2qKzp2a4++asqd7j
         PNyE3HullO93M+Ufr7mlJ3VQlOYiAwKpnOp4gtCS3mGqZQevcChzOitYwctjfuhI8Ja6
         dtkdJkDEVVe/WTZjGQFQj7GGS6x0wP9aAPdJz9/GOalwlD6trXS+s+V2ZFwqFI2XV8n3
         PUVy+xN2qqM+draZKKabqcRrungQNej7N1ZHbVfFjsr8ZJSH2QrW5iXujOvVCwoDbQwN
         UJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781288997; x=1781893797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmNqQ4TNInbt3EAZyDboSRKMGKUauOjQCy3M4sfFc1I=;
        b=mgvoNHsGV1y1jAYNowayigG4UAhTEMUW46W25YHs05fzZdhKbjhc3VXME+0b0IIxt5
         /u1ijqUXwoUXTlSc5Up8HQ+4a8oobbyw3v6bHUznIU+v0ZKPfJ20FVMQZ/v1UnUvXrBM
         lR+gZvn44ZkLq3IsoHghiql5/vR5kO7pIt69rMRBJJgi/xKMDxKz0eBufjc4+tMItJyP
         b7e8j2UwvPXW1wrX0sO6oWEoOmDiX+hdgLROZBhhAhP7c/OeOFsDptLYo97yKC9UkcAc
         sw/UrAeDMbaw510hH+KFfaIXJhBiW557kN95sbFKcwKojqMA8ycGjlohEi6XnnB8UJC7
         4Hwg==
X-Forwarded-Encrypted: i=1; AFNElJ+IXe/Jktlk3NL7nSJBWpWjBYllX/BbPGnKZl89Uv0FxduNBgI5n7oILVPie5sy/3fVZvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcqUiytBD8bD1i+i1Oheqy6KYGio6tuu/vXdxMUqGt1eA3UfJ
	p2IM9HfAxgSUu67dk+CTzLbNtbt55C0r4h9C9MLb2K+VMt8sq4Q51EKI
X-Gm-Gg: Acq92OH0FxtQF7Rzbo2AqLftdRp8scgx1YFAe9qyVlwBFCG8ChbOvK9YuElhZpSqFb3
	+a0I94+lcMX2loyRAAsaQGHcBhusZvZafHgC+5OkyriUgJct2EXi6AQcdsBS7Uax303DrGyLr3T
	Y+wKVgzXokQEN8ZxhmrkK2LaMYx9N7RusbBiXsvP5aJtzJA48wxbjgk+dKsNFIIhequEiVHb8sj
	rnYNIw6OM9UgJoAf3VLvcFJNWRwRG3T9ojOlQVGaynwGi8eZnG+4iBnyG+dJGaUqKY2oy9xcFMj
	todqCh0Gbyt8MVaGhV8qApa0R+DZIxNjwMq8c70lVX+dMyeqDFIY7k4rZe4YwB9umJ9FjiPa/x6
	qCYQbtk821q3pD5fQFKCRPqNNUHUaritdrnFXe5KoOG/ohXrrmaVI6LAx1qttil0MYx8E1ya6Rn
	24yECwtH0PUOh14cfdrREJVrcSDDbSZ1+kPorrh0I67VQBsN80nrvJPumUO5Zp6UZ4hLBLWPQPj
	D2P5XXFGZs7hMscymutTTP1RdcxXoqrXOb1Hz9Za06i
X-Received: by 2002:a05:6a00:a24e:b0:842:46a6:e2db with SMTP id d2e1a72fcca58-844e1998f8fmr847414b3a.19.1781288996445;
        Fri, 12 Jun 2026 11:29:56 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm3341488b3a.32.2026.06.12.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:29:55 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v3 0/4] teach git repo info to handle path keys
Date: Fri, 12 Jun 2026 23:58:43 +0530
Message-ID: <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series teaches `git repo info` to handle `path.*`
keys, allowing scripts to reliably discover core
repository paths without resorting to `git rev-parse`.

The patches are structured as follows:

1. path: Extract the localized path-formatting logic
   out of `rev-parse` and expose it globally via
   `path.h` using clear append semantics.

2. rev-parse: Refactor the command to leverage the
   newly shared path engine.

3. repo: Introduce `path.commondir.absolute` and
   `path.commondir.relative` alongside a robust,
   isolated test helper.

4. repo: Introduce `path.gitdir.absolute` and
   `path.gitdir.relative` using the same standardized
   formatting rules.

Since all the questions were answered
I have removed them from this cover letter.

Changes since v2:

* Renamed the shared helper from `format_path()` to
  `append_formatted_path()`, and renamed the `buf`
  parameter to `dest` to better reflect its
  append-style behavior (Lucas, Phillip).

* Introduced a dedicated `PATH_FORMAT_DEFAULT`
  enumerator. This removes the awkward `-1`
  sentinel in `print_path()` while preserving enum
  type safety (Phillip, Justin).

* Handled `PATH_FORMAT_DEFAULT` as
  `PATH_FORMAT_UNMODIFIED` inside
  `append_formatted_path()`, while intercepting it
  in `print_path()` for rev-parse-specific fallback
  behavior (Justin).

* Replaced the `else if` chain in `append_formatted_path()` with a 
  clean `switch` statement setup (Justin, Lucas).

* Reordered the `commondir` and `gitdir` patches so
  the parameterized test helper
  (`test_repo_info_path`) is introduced first,
  establishing the isolated test infrastructure up
  front (Justin).

* Reworked the test helper to accept a label,
  `repo_name`, and `path_suffix`; moved repository
  creation into the helper for isolation; and
  replaced `eval` by capturing `$PWD` before
  changing directories (Justin, Lucas).

* Corrected trailer ordering so `Signed-off-by`
  appears after `Mentored-by` (Kristoffer).

* Cleaned up minor trailing whitespace issues across
  the patch array declarations.

Tagging Justin Tobler, Lucas Seiki Oshiro, Junio,
Phillip Wood, brian m. carlson, and Ayush Jha.

Thanks for taking another look!


K Jayatheerth (4):
  path: introduce append_formatted_path() for shared path formatting
  rev-parse: use append_formatted_path() for path formatting
  repo: add path.commondir with absolute and relative suffix formatting
  repo: add path.gitdir with absolute and relative suffix formatting

 Documentation/git-repo.adoc |  15 ++++++
 builtin/repo.c              |  50 +++++++++++++++++
 builtin/rev-parse.c         | 103 ++++++++----------------------------
 path.c                      |  70 ++++++++++++++++++++++++
 path.h                      |  36 +++++++++++++
 t/t1900-repo-info.sh        |  68 ++++++++++++++++++++++++
 6 files changed, 262 insertions(+), 80 deletions(-)

Range-diff against v2:
1:  c1f1e87fe9 ! 1:  a396b4f8e6 path: introduce format_path() for centralized path formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    path: introduce format_path() for centralized path formatting
    +    path: introduce append_formatted_path() for shared path formatting
     
    -    The path-formatting logic inside `builtin/rev-parse.c` handles absolute,
    -    canonical, and relative formatting rules based on user-supplied options.
    -    However, this logic is tightly coupled to `rev-parse` and writes directly
    -    to stdout.
    +    The path-formatting logic in builtin/rev-parse.c is tightly coupled
    +    to that command and writes directly to stdout, making it impossible
    +    for other builtins to reuse.
     
    -    To allow other builtins (such as the upcoming `git repo` path keys) to
    -    re-use this logic, extract the core path-formatting algorithm into a centralized
    -    helper function, `format_path()`, in `path.c`.
    -
    -    Expose a single, streamlined `path_format` enum in `path.h` to let callers
    -    explicitly declare their formatting strategy (UNMODIFIED, RELATIVE,
    -    RELATIVE_IF_SHARED, or CANONICAL). This decouples the core algorithm from
    -    the localized fallback mechanics specific to `rev-parse`.
    +    Extract the core algorithm into append_formatted_path() in path.c
    +    and expose a path_format enum in path.h so that any builtin can
    +    format paths consistently without duplicating logic.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ path.c: char *xdg_cache_home(const char *filename)
      	return NULL;
      }
      
    -+void format_path(struct strbuf *buf, const char *path,
    -+		 const char *prefix, enum path_format format)
    ++void append_formatted_path(struct strbuf *dest, const char *path,
    ++			   const char *prefix, enum path_format format)
     +{
    -+	if (format == PATH_FORMAT_UNMODIFIED) {
    -+		strbuf_addstr(buf, path);
    -+		return;
    -+	}
    ++	switch (format) {
    ++	case PATH_FORMAT_DEFAULT:
    ++	case PATH_FORMAT_UNMODIFIED:
    ++		strbuf_addstr(dest, path);
    ++		break;
     +
    -+	if (format == PATH_FORMAT_RELATIVE) {
    ++	case PATH_FORMAT_RELATIVE: {
     +		struct strbuf relative_buf = STRBUF_INIT;
     +		struct strbuf real_path = STRBUF_INIT;
     +		struct strbuf real_prefix = STRBUF_INIT;
    @@ path.c: char *xdg_cache_home(const char *filename)
     +			prefix = real_prefix.buf;
     +		}
     +
    -+		strbuf_addstr(buf, relative_path(path, prefix, &relative_buf));
    ++		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
     +
     +		strbuf_release(&relative_buf);
     +		strbuf_release(&real_path);
     +		strbuf_release(&real_prefix);
     +		free(cwd);
    -+	} else if (format == PATH_FORMAT_RELATIVE_IF_SHARED) {
    ++		break;
    ++	}
    ++
    ++	case PATH_FORMAT_RELATIVE_IF_SHARED: {
     +		struct strbuf relative_buf = STRBUF_INIT;
     +
     +		/*
    @@ path.c: char *xdg_cache_home(const char *filename)
     +		 * default the prefix to the current working directory. Doing so
     +		 * would cause a relative path to always be produced if possible.
     +		 */
    -+		strbuf_addstr(buf, relative_path(path, prefix, &relative_buf));
    ++		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
     +		strbuf_release(&relative_buf);
    -+	} else if (format == PATH_FORMAT_CANONICAL) {
    ++		break;
    ++	}
    ++
    ++	case PATH_FORMAT_CANONICAL: {
     +		struct strbuf canonical_buf = STRBUF_INIT;
     +
     +		strbuf_realpath_forgiving(&canonical_buf, path, 1);
    -+		strbuf_addbuf(buf, &canonical_buf);
    ++		strbuf_addbuf(dest, &canonical_buf);
     +
     +		strbuf_release(&canonical_buf);
    ++		break;
    ++	}
    ++
    ++	default:
    ++		BUG("unknown path_format value %d", format);
     +	}
     +}
     +
    @@ path.h: enum scld_error safe_create_leading_directories_no_share(char *path);
     + * The formatting strategy to apply when writing a path into a buffer.
     + */
     +enum path_format {
    ++	/*
    ++	 * Represents the default formatting behavior. Treated as
    ++	 * PATH_FORMAT_UNMODIFIED by append_formatted_path().
    ++	 */
    ++	PATH_FORMAT_DEFAULT,
    ++
     +	/* Output the path exactly as-is without any modifications. */
     +	PATH_FORMAT_UNMODIFIED,
     +
    @@ path.h: enum scld_error safe_create_leading_directories_no_share(char *path);
     + * Format a path according to the specified formatting strategy and append
     + * the result to the given strbuf.
     + *
    -+ * `buf`    : The string buffer to append the formatted path to.
    ++ * `dest`   : The string buffer to append the formatted path to.
     + * `path`   : The path string that needs to be formatted.
     + * `prefix` : The directory prefix to calculate relative offsets against.
     + * Pass NULL to default to the current working directory where applicable.
     + * `format` : The formatting behavior rule to execute.
     + */
    -+void format_path(struct strbuf *buf, const char *path,
    -+		 const char *prefix, enum path_format format);
    ++void append_formatted_path(struct strbuf *dest, const char *path,
    ++			   const char *prefix, enum path_format format);
     +
      # ifdef USE_THE_REPOSITORY_VARIABLE
      #  include "strbuf.h"
2:  2cc3e671af ! 2:  16198f96d1 rev-parse: use format_path for path formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    rev-parse: use format_path for path formatting
    +    rev-parse: use append_formatted_path() for path formatting
     
    -    Now that the core path-formatting logic has been abstracted into
    -    format_path() inside path.c, remove the localized duplicate formatting
    -    mechanics from builtin/rev-parse.c.
    +    Now that path formatting logic lives in a shared helper, keeping a
    +    duplicate implementation in rev-parse is unnecessary and risks the
    +    two diverging over time.
     
    -    Drop the usage of the old local format_type and default_type enums,
    -    and update print_path() to act as a light wrapper around the new shared
    -    engine. Resolve user-provided formatting flags directly within rev-parse
    -    to pass the final determined path_format to format_path().
    +    Replace the local format_type and default_type enums and the
    +    hand-rolled formatting logic with a call to append_formatted_path().
    +    Introduce PATH_FORMAT_DEFAULT as the initial value of arg_path_format
    +    so that per-path fallback behavior is resolved in print_path() rather
    +    than leaked into the shared helper.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char
     -
     -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
     +static void print_path(const char *path, const char *prefix,
    -+		       int arg_path_format, enum path_format def_format)
    ++		       enum path_format arg_path_format, enum path_format def_format)
      {
     -	char *cwd = NULL;
     -	/*
    @@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char
     -	}
     -	free(cwd);
     +	struct strbuf sb = STRBUF_INIT;
    -+	enum path_format fmt = (arg_path_format != -1) ? arg_path_format : def_format;
    ++	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
     +
    -+	format_path(&sb, path, prefix, fmt);
    ++	append_formatted_path(&sb, path, prefix, fmt);
     +	puts(sb.buf);
     +
     +	strbuf_release(&sb);
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
      	struct strbuf buf = STRBUF_INIT;
      	int seen_end_of_options = 0;
     -	enum format_type format = FORMAT_DEFAULT;
    -+	int arg_path_format = -1;
    ++	enum path_format arg_path_format = PATH_FORMAT_DEFAULT;
      
      	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
      
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
      				char *cwd;
      				int len;
     -				enum format_type wanted = format;
    -+				int wanted = arg_path_format;
    ++				enum path_format wanted = arg_path_format;
      				if (arg[2] == 'g') {	/* --git-dir */
      					if (gitdir) {
     -						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
4:  61b5d69306 ! 3:  7de41faa04 repo: add path.commondir with absolute and relative suffix formatting
    @@ Metadata
      ## Commit message ##
         repo: add path.commondir with absolute and relative suffix formatting
     
    -    In standard Git repositories, the Git directory and the common directory
    -    are identical. However, in environments utilizing multiple worktrees, the
    -    local working state ($GIT_DIR) is separated from the shared central data
    -    ($GIT_COMMON_DIR). Scripts require a reliable way to discover this shared
    -    path.
    +    Scripts working with worktree setups need a reliable way to discover
    +    the common directory, which diverges from the git directory when
    +    multiple worktrees are in use. There is no way to retrieve this path
    +    from git repo info today.
     
    -    Introduce `path.commondir.absolute` and `path.commondir.relative` keys
    -    to `git repo info`. Similar to the `path.gitdir` keys, exposing explicit
    -    format variants removes the ambiguity of default fallbacks. Both keys are
    -    evaluated via the `format_path()` engine.
    +    Introduce path.commondir.absolute and path.commondir.relative keys.
    +    Exposing explicit format variants rather than a single key with a
    +    default avoids ambiguity for scripts that require predictable output.
     
    -    Insert the new keys into the `repo_info_field` array in lexicographical
    -    order to maintain the integrity of binary search lookups.
    -
    -    Utilize the parameterized `test_repo_info_path` helper to validate the
    -    worktree edge cases. This ensures that path resolution correctly respects
    -    $GIT_COMMON_DIR when defined and safely falls back to $GIT_DIR otherwise.
    +    Add a test helper test_repo_info_path that creates isolated
    +    repositories per test case to prevent state leaks, captures the repo
    +    root before changing directories to avoid eval, and accepts an optional
    +    init_command to cover environment variable overrides such as
    +    GIT_COMMON_DIR and GIT_DIR.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc: values that they return:
     +	The path to the Git repository's common directory relative to
     +	the current working directory.
     +
    - `path.gitdir.absolute`::
    - 	The canonical absolute path to the Git repository directory (the `.git` directory).
    - 
    + `references.format`::
    + 	The reference storage format. The valid values are:
    + +
     
      ## builtin/repo.c ##
    +@@
    + #include "hex.h"
    + #include "odb.h"
    + #include "parse-options.h"
    ++#include "path.h"
    + #include "path-walk.h"
    + #include "progress.h"
    + #include "quote.h"
    + #include "ref-filter.h"
    + #include "refs.h"
    + #include "revision.h"
    ++#include "setup.h"
    + #include "strbuf.h"
    + #include "string-list.h"
    + #include "shallow.h"
     @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct strbuf *buf)
      	return 0;
      }
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!common_dir)
     +		return error(_("unable to get common directory"));
     +
    -+	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	append_formatted_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!common_dir)
     +		return error(_("unable to get common directory"));
     +
    -+	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	append_formatted_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
    - static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_references_format(struct repository *repo, struct strbuf *buf)
      {
    - 	const char *git_dir = repo_get_git_dir(repo);
    + 	strbuf_addstr(buf,
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "layout.bare", get_layout_bare },
      	{ "layout.shallow", get_layout_shallow },
      	{ "object.format", get_object_format },
     +	{ "path.commondir.absolute", get_path_commondir_absolute },
     +	{ "path.commondir.relative", get_path_commondir_relative },
    - 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
    - 	{ "path.gitdir.relative", get_path_gitdir_relative },
      	{ "references.format", get_references_format },
    + };
    + 
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_expect_success 'setup test repository layout for path fields' '
    - 	mkdir -p test-repo/sub
    +@@ t/t1900-repo-info.sh: test_expect_success 'git repo info -h shows only repo info usage' '
    + 	test_grep ! "git repo structure" actual
      '
      
    -+test_expect_success 'setup custom-common for commondir tests' '
    -+	git init --bare test-repo/custom-common
    -+'
    -+
    -+test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/.git"' '../.git'
    -+test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/custom-common"' '../custom-common' 'GIT_COMMON_DIR="$(cd .. && pwd)/custom-common" GIT_DIR=../.git'
    -+test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/.git"' '../.git' 'GIT_DIR=../.git'
    - test_repo_info_path 'gitdir' 'echo "$(cd .. && pwd)/.git"' '../.git'
    - 
    ++# Helper function to test path keys in both absolute and relative formats.
    ++# $1: label for the test
    ++# $2: field_name (e.g., commondir)
    ++# $3: unique repo name for isolation
    ++# $4: expect_absolute (suffix appended to repo root)
    ++# $5: expect_relative (the relative path string expected)
    ++# $6: init_command (extra setup like exporting env vars)
    ++test_repo_info_path () {
    ++	label=$1
    ++	field_name=$2
    ++	repo_name=$3
    ++	expect_absolute_suffix=$4
    ++	expect_relative=$5
    ++	init_command=$6
    ++
    ++	absolute_root="$repo_name-absolute"
    ++	relative_root="$repo_name-relative"
    ++
    ++	test_expect_success "setup: $label" '
    ++		git init "$absolute_root" &&
    ++		git init "$relative_root" &&
    ++		mkdir -p "$absolute_root/sub" "$relative_root/sub"
    ++	'
    ++
    ++	test_expect_success "absolute: $label" '
    ++		(
    ++			cd "$absolute_root/sub" &&
    ++			ROOT="$(test-tool path-utils real_path "..")" && export ROOT &&
    ++			eval "$init_command" &&
    ++			expect_path="$ROOT${expect_absolute_suffix:+/$expect_absolute_suffix}" &&
    ++			echo "path.$field_name.absolute=$expect_path" >expect &&
    ++			git repo info "path.$field_name.absolute" >actual &&
    ++			test_cmp expect actual
    ++		)
    ++	'
    ++
    ++	test_expect_success "relative: $label" '
    ++		(
    ++			cd "$relative_root/sub" &&
    ++			ROOT="$(test-tool path-utils real_path "..")" && export ROOT &&
    ++			eval "$init_command" &&
    ++			echo "path.$field_name.relative=$expect_relative" >expect &&
    ++			git repo info "path.$field_name.relative" >actual &&
    ++			test_cmp expect actual
    ++		)
    ++	'
    ++}
    ++
    ++test_repo_info_path 'commondir standard' 'commondir' 'commondir-std' \
    ++	'.git' '../.git'
    ++
    ++test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' 'commondir' \
    ++	'commondir-envs' 'custom-common' '../custom-common' \
    ++	'GIT_COMMON_DIR="$ROOT/custom-common" && export GIT_COMMON_DIR &&
    ++	 GIT_DIR="../.git" && export GIT_DIR &&
    ++	 git init --bare "$ROOT/custom-common"'
    ++
    ++test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
    ++	'commondir-only-gitdir' '.git' '../.git' \
    ++	'GIT_DIR="../.git" && export GIT_DIR'
    ++
      test_done
3:  ca95d51f6e ! 4:  ffd6a5bb16 repo: add path.gitdir with absolute and relative suffix formatting
    @@ Metadata
      ## Commit message ##
         repo: add path.gitdir with absolute and relative suffix formatting
     
    -    Scripts often need to locate the `.git` directory. While `git rev-parse`
    -    provides this, it relies on command-line flags to dictate path formatting.
    +    Scripts need a stable way to locate the git directory without
    +    parsing rev-parse output or relying on its flag-driven path format
    +    selection. There is no way to retrieve this path from git repo info
    +    today.
     
    -    Introduce `path.gitdir.absolute` and `path.gitdir.relative` keys to
    -    `git repo info`. Exposing separate format-specific keys instead of a base
    -    `path.gitdir` key avoids default fallbacks and requires callers to state
    -    their format requirements explicitly. Both keys use `format_path()` to
    -    resolve paths.
    -
    -    To test these keys, introduce the `test_repo_info_path` helper in
    -    `t/t1900-repo-info.sh`. The helper evaluates paths dynamically and accepts
    -    environment variable prefixes. This prepares the test suite for future path
    -    keys that depend on environment overrides, such as `commondir`.
    +    Introduce path.gitdir.absolute and path.gitdir.relative keys,
    +    consistent with the path.commondir keys added in the previous patch.
    +    Reuse the test_repo_info_path helper introduced there to validate
    +    both variants.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Commit message
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
    - `object.format`::
    - 	The object format (hash algorithm) used in the repository.
    + 	The path to the Git repository's common directory relative to
    + 	the current working directory.
      
     +`path.gitdir.absolute`::
     +	The canonical absolute path to the Git repository directory (the `.git` directory).
    @@ Documentation/git-repo.adoc: values that they return:
      +
     
      ## builtin/repo.c ##
    -@@
    - #include "hex.h"
    - #include "odb.h"
    - #include "parse-options.h"
    -+#include "path.h"
    - #include "path-walk.h"
    - #include "progress.h"
    - #include "quote.h"
    - #include "ref-filter.h"
    - #include "refs.h"
    - #include "revision.h"
    -+#include "setup.h"
    - #include "strbuf.h"
    - #include "string-list.h"
    - #include "shallow.h"
    -@@ builtin/repo.c: static int get_object_format(struct repository *repo, struct strbuf *buf)
    +@@ builtin/repo.c: static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
      	return 0;
      }
      
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!git_dir)
     +		return error(_("unable to get git directory"));
     +
    -+	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!git_dir)
     +		return error(_("unable to get git directory"));
     +
    -+	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
      {
      	strbuf_addstr(buf,
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    - 	{ "layout.bare", get_layout_bare },
    - 	{ "layout.shallow", get_layout_shallow },
      	{ "object.format", get_object_format },
    + 	{ "path.commondir.absolute", get_path_commondir_absolute },
    + 	{ "path.commondir.relative", get_path_commondir_relative },
     +	{ "path.gitdir.absolute", get_path_gitdir_absolute },
     +	{ "path.gitdir.relative", get_path_gitdir_relative },
      	{ "references.format", get_references_format },
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_expect_success 'git repo info -h shows only repo info usage' '
    - 	test_grep ! "git repo structure" actual
    - '
    +@@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
    + 	'commondir-only-gitdir' '.git' '../.git' \
    + 	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_repo_info_path () {
    -+	field_name=$1
    -+	expect_absolute_eval=$2
    -+	expect_relative=$3
    -+	env_prefix=$4
    -+
    -+	test_expect_success "query individual key: path.$field_name.absolute${env_prefix:+ ($env_prefix)}" '
    -+		(
    -+			cd test-repo/sub &&
    -+			expect_absolute=$(eval "$expect_absolute_eval") &&
    -+			echo "path.$field_name.absolute=$expect_absolute" >expect &&
    -+			eval "${env_prefix:+$env_prefix }git repo info \"path.$field_name.absolute\"" >actual &&
    -+			test_cmp expect actual
    -+		)
    -+	'
    -+
    -+	test_expect_success "query individual key: path.$field_name.relative${env_prefix:+ ($env_prefix)}" '
    -+		(
    -+			cd test-repo/sub &&
    -+			echo "path.$field_name.relative=$expect_relative" >expect &&
    -+			eval "${env_prefix:+$env_prefix }git repo info \"path.$field_name.relative\"" >actual &&
    -+			test_cmp expect actual
    -+		)
    -+	'
    -+}
    -+
    -+test_expect_success 'setup test repository layout for path fields' '
    -+	git init test-repo &&
    -+	mkdir -p test-repo/sub
    -+'
    ++test_repo_info_path 'gitdir standard' 'gitdir' 'gitdir-std' \
    ++	'.git' '../.git'
     +
    -+test_repo_info_path 'gitdir' 'echo "$(cd .. && pwd)/.git"' '../.git'
    ++test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
    ++	'gitdir-env' '.git' '../.git' \
    ++	'GIT_DIR="../.git" && export GIT_DIR'
     +
      test_done
-- 
2.54.0
