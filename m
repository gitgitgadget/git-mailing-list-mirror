Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956231C01
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702568; cv=none; b=tmg4vTDx5wz2E1xiwdVqSxiaJx1w4JIylaDeu558dfO3xTpaXKFtPQgSDzvmYjHuwhhDdlZy+wmF3IkSEANDNUcHHkrldryf7bX1kn6cffHBDMdln/X+peEUdDTpi2+ZXCcDgsrBcvQTDFNOToMUOlW27wEI2fFwx2soZf1LAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702568; c=relaxed/simple;
	bh=1/zZmz5HHwXxg6cPYx72f/WKYG89sQ/6XrLQoJaw7x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOtw0L0NK1J6saIFqsi576Viw1n9D0TB9YGYSmiShCLUihxCqeAcT7nJYzwlhT9M2XYZKsdVDXjC/2lg4cuURyOalZaVoohsReCtk/aelfFMW1q6ue8Cc99lOqE09qR4G7xhjGyC0Nd6VDnf1BMmUp+wzlShLAWWUIont/07BfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksFCSMoZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksFCSMoZ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f3d1280f3dso490483b6e.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702565; x=1741307365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ySjvnKQoNGb2kUzsQipw/3c8Shp1GSQjAHZPXct3Eo=;
        b=ksFCSMoZu3blr0Eyv3HADCfAS/sBd0iu1e+WJH92jpKFQ32ZSFvaiBuOl+bX8tofSH
         abc6YtWf/FFMkwbRKMNB80MHZu3yRzyFjfvxjTK5lm4iTFhSngpla/g7h8228b9FUrCG
         6OJYj4cnzxBxi5nhimjefIW3Ky1g8GNGHpImYf5ulF3CwxB7C0ktdY0k+fhVUURZLH3B
         7IvNjf0857SCaATsRyGi8AtJKpFrC+nnXWHAvOK/vbQQKsapHaUbEcusIucyCxRGBsDJ
         xnYgQAnDdI43EhXXfxL/zbM5KmagIlSifuYm1Os/9pg5JyQUY2HzET69Zy1hoVkgIMvR
         ikTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702565; x=1741307365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ySjvnKQoNGb2kUzsQipw/3c8Shp1GSQjAHZPXct3Eo=;
        b=b21XEZ7ReoUHdREPxCUWVwYa9tsCv/LrVcDz3LUxvPLQUqcq10t2EYVb2qHs5O2ouy
         7Cj+OvB7hSQPTZZLQat5jnG6kLfOzsMvPYX9uA+fLxDaRaBklzBvzIBZY79hsM2N6VoK
         p1bSvwhwt4pApmOdqtpLhQnbY1jNNRuk2+xQmidSy1J3UwW9XoY32ec+qvILCEXw3VzX
         /3uw05vwlyYxExKwyhwtZ45p14LaUoACF2XtwW8UgDQWspumrD5eR4E4XoSFi4C1/6rs
         Sp6+NTCcXc12lE6i9cQFh1mWg79gtbhGwqwIgSL1jfNWpLlExYJwNJYfPKg0Wv7EUXBA
         Tfjw==
X-Gm-Message-State: AOJu0YxHgcRMYUM3eTSuRzcAIR3BLLgOIep/E8KFWuNck9VSLYDPtm+s
	DUYqP8z7gIsmcj3e5lTP7KYMV9Gl6OdQ/gT7r58jUVYaqVfhmhHwi+DMRZrB
X-Gm-Gg: ASbGncvlgd9PGMBpN3ZC4hW2XGGye0ABWjT0EfzyVN5ngn5QT46OWk+nmCzQFFusMOb
	yX6z0y0lO3bNMACAvsZi4XBGQdav8kjwane6q2mcImH+r6C53a28FFPF8Pb62XIdnHqsu0V7rk4
	9/znGmQxUk2SpXk+/sH5xLfE8GVMsMcoX21ywSyY7c+v8GYmDA6+1tk7lTwKJnWKjQ+TKCXfZ9s
	EIkWcut58ItbMi/NWKov7DO5MeREw96wnSdQcuryr46ZMssljAenRA8kwolF8fc6lUCbBTHmeUl
	Ad+pgqfJkcL49buros7fUB5eZhFlRVcsRQ==
X-Google-Smtp-Source: AGHT+IGt2Z0G+z0z9cVYE6Hucx7yvQP3b82gZV+VGWaUYqYtSqSOoagZ8wx0l/rQbiTI0pGK0ycWDQ==
X-Received: by 2002:a05:6808:2e96:b0:3f4:435:cb0e with SMTP id 5614622812f47-3f558517273mr1155370b6e.9.1740702564959;
        Thu, 27 Feb 2025 16:29:24 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaab9c8f9sm456509eaf.19.2025.02.27.16.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:29:24 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/4] batch blob diff generation
Date: Thu, 27 Feb 2025 18:26:00 -0600
Message-ID: <20250228002604.3859939-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225233925.1345086-1-jltobler@gmail.com>
References: <20250225233925.1345086-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1) it is possible to generate a diff directly between
two blobs. This is particularly useful when the pre-image and post-image
blobs are known and we only care about the diff between them.
Unfortunately, if a user has a batch of known blob pairs to compute
diffs for, there is currently not a way to do so via a single Git
process.

To enable support for batch diffs of multiple blob pairs, this series
introduces a new diff plumbing command git-diff-pairs(1) based on a
previous patch series submitted by Peff[1]. This command uses
NUL-delimited raw diffs as its source of input to control exactly which
filepairs are diffed. The advantage of using the raw diff format is that
it already has diff status type and object context information embedded
in each line making it more efficient to generate diffs with as we can
avoid having to peel revisions to get some the same info.

For example:

    git diff-tree -r -z -M $old $new |
    git diff-pairs -p -z

Here the output of git-diff-tree(1) is fed to git-diff-pairs(1) to
generate the same output that would be expected from `git diff-tree -p
-M`. While by itself not particularly useful, this means it is possible
to split git-diff-tree(1) output across multiple git-diff-pairs(1)
processes. Such a feature is useful on the server-side where diffs
bewteen a large set of changes may not be feasible all at once due to
timeout concerns.

This command can be viewed as a backend tool that exposes Git's diff
machinery. In its current form, the frontend that generates the raw diff
lines used as input is expected to most of the heavy lifting (ie.
pathspec limiting, tree object expansion).

This series is structured as follows:

    - Patch 1 adds some new helper functions to get access to the queued
      `diff_filepair` after `diff_queue()` is invoked.

    - Patch 2 adds a new diff_options field that can be used to disable
      diff filepair status resolution. This prevents rename/copy
      statuses set from stdin from being altered when `diffcore_std()`
      is invoked.

    - Patch 3 introduces the new git-diff-pairs(1) plumbing command.

    - Patch 4 allows git-diff-pairs(1) to immediately compute diffs
      queued on stdin when a NUL-byte is written after a raw input line
      instead of waiting for stdin to close.

Changes since V3:

    - Instead of relying on found_follow to prevent `diffcore_std()`
      from mutating diff filepair statuses, a new `diff_options` field,
      `skip_resolving_statuses` is introduced to achieve the same result
      in a more specific manner.

    - Parsing of diff options is now handled directly instead of going
      through `setup_revisions()`. This is done to so the diff options
      can be appended to the usage options and printed in the usage
      message.

    - Swapped to using `strbuf_getwholeline()` during stdin parsing to
      make the line termiantor more configurable in the future.

    - Stopped printing the usage message on errors to avoid masking the
      underlying error message.

    - Added test setup to exercise submodule change diffs.

    - Other small minor cleanups.

Changes since V2:

    - Pathspecs are not supported and thus rejected when provided as
      arguments. It should be possible in a future series to add support
      though.

    - Tree objects present in `diff-pairs` input are rejected. Support
      for tree objects could be added in the future, but for now they
      are rejected to enable to future support in a backwards compatible
      manner.

    - The -z option is required by git-diff-pairs(1). The NUL-delimited
      raw diff format is the only accepted form of input. Consequently,
      NUL-delimited output is the only option in the `--raw` mode.

    - git-diff-pairs(1) defaults to patch output instead of raw output.
      This better fits the intended usecase of the command.

    - A NUL-byte is now always used as the delimiter between batches of
      file pair diffs when queued diffs are explicitly computed by
      writing a NUL-byte on stdin.

    - Several other small cleanups and fixes along with documentation
      changes.

Changes since V1:

    - Changed from git-diff-blob(1) to git-diff-pairs(1) based on a
      previously submitted series.

    - Instead of each line containing a pair of blob revisions, the raw
      diff format is used as input which already has diff status and
      object context embedded.

-Justin

[1]: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>

Justin Tobler (4):
  diff: return diff_filepair from diff queue helpers
  diff: add option to skip resolving diff statuses
  builtin: introduce diff-pairs command
  builtin/diff-pairs: allow explicit diff queue flush

 .gitignore                        |   1 +
 Documentation/git-diff-pairs.adoc |  60 +++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/diff-pairs.c              | 209 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 diff.c                            |  72 +++++++---
 diff.h                            |  33 +++++
 git.c                             |   1 +
 meson.build                       |   1 +
 t/meson.build                     |   1 +
 t/t4070-diff-pairs.sh             |  90 +++++++++++++
 13 files changed, 451 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-diff-pairs.adoc
 create mode 100644 builtin/diff-pairs.c
 create mode 100755 t/t4070-diff-pairs.sh

Range-diff against v3:
1:  d19b164914 ! 1:  b2e5486442 diff: return diff_filepair from diff queue helpers
    @@ Commit message
     
         Split out the queuing operations into `diff_queue_addremove()` and
         `diff_queue_change()` which also return a handle to the queued
    -    `diff_filepair`.
    +    `diff_filepair`. Both `diff_addremove()` and `diff_change()` are
    +    reimplemented as thin wrappers around the new functions.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
-:  ---------- > 2:  31d80d99ae diff: add option to skip resolving diff statuses
2:  991aaea3a9 ! 3:  3722c02112 builtin: introduce diff-pairs command
    @@ Commit message
         machinery to produce various forms of output such as patch or raw.
     
         The raw format was originally designed as an interchange format and
    -    represents the contents of the diff_queue_diff list making it possible
    +    represents the contents of the diff_queued_diff list making it possible
         to break the diff pipeline into separate stages. For example,
         git-diff-tree(1) can be used as a frontend to compute file pairs to
         queue and feed its raw output to git-diff-pairs(1) to compute patches.
    -    With this, batches of diffs can be progessively generated without having
    -    to recompute rename detection or retrieve object context. Something like
    +    With this, batches of diffs can be progressively generated without
    +    having to recompute renames or retrieve object context. Something like
         the following:
     
                 git diff-tree -r -z -M $old $new |
    @@ builtin.h: int cmd_diagnose(int argc, const char **argv, const char *prefix, str
      ## builtin/diff-pairs.c (new) ##
     @@
     +#include "builtin.h"
    -+#include "commit.h"
     +#include "config.h"
     +#include "diff.h"
     +#include "diffcore.h"
     +#include "gettext.h"
    ++#include "hash.h"
     +#include "hex.h"
     +#include "object.h"
     +#include "parse-options.h"
     +#include "revision.h"
     +#include "strbuf.h"
     +
    -+static unsigned parse_mode_or_die(const char *mode, const char **endp)
    ++static unsigned parse_mode_or_die(const char *mode, const char **end)
     +{
     +	uint16_t ret;
     +
    -+	*endp = parse_mode(mode, &ret);
    -+	if (!*endp)
    ++	*end = parse_mode(mode, &ret);
    ++	if (!*end)
     +		die(_("unable to parse mode: %s"), mode);
     +	return ret;
     +}
     +
    -+static void parse_oid_or_die(const char *p, struct object_id *oid,
    -+			     const char **endp, const struct git_hash_algo *algop)
    ++static void parse_oid_or_die(const char *hex, struct object_id *oid,
    ++			     const char **end, const struct git_hash_algo *algop)
     +{
    -+	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
    -+		die(_("unable to parse object id: %s"), p);
    -+}
    -+
    -+static void flush_diff_queue(struct diff_options *options)
    -+{
    -+	/*
    -+	 * If rename detection is not requested, use rename information from the
    -+	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
    -+	 * does not mess with rename information already present in queued
    -+	 * filepairs.
    -+	 */
    -+	if (!options->detect_rename)
    -+		options->found_follow = 1;
    -+	diffcore_std(options);
    -+	diff_flush(options);
    ++	if (parse_oid_hex_algop(hex, oid, end, algop) || *(*end)++ != ' ')
    ++		die(_("unable to parse object id: %s"), hex);
     +}
     +
     +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
    @@ builtin/diff-pairs.c (new)
     +	struct strbuf path_dst = STRBUF_INIT;
     +	struct strbuf path = STRBUF_INIT;
     +	struct strbuf meta = STRBUF_INIT;
    ++	struct option *parseopts;
     +	struct rev_info revs;
    ++	int line_term = '\0';
     +	int ret;
     +
    -+	const char * const usage[] = {
    ++	const char * const usagestr[] = {
     +		N_("git diff-pairs -z [<diff-options>]"),
     +		NULL
     +	};
     +	struct option options[] = {
     +		OPT_END()
     +	};
    -+	struct option *parseopts = add_diff_options(options, &revs.diffopt);
    -+
    -+	show_usage_with_options_if_asked(argc, argv, usage, parseopts);
     +
     +	repo_init_revisions(repo, &revs, prefix);
    ++
    ++	/*
    ++	 * Diff options are usually parsed implicitly as part of
    ++	 * setup_revisions(). Explicitly handle parsing to ensure options are
    ++	 * printed in the usage message.
    ++	 */
    ++	parseopts = add_diff_options(options, &revs.diffopt);
    ++	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
    ++
     +	repo_config(repo, git_diff_basic_config, NULL);
     +	revs.disable_stdin = 1;
     +	revs.abbrev = 0;
     +	revs.diff = 1;
     +
    ++	argc = parse_options(argc, argv, prefix, parseopts, usagestr,
    ++			     PARSE_OPT_KEEP_UNKNOWN_OPT |
    ++			     PARSE_OPT_KEEP_DASHDASH |
    ++			     PARSE_OPT_KEEP_ARGV0);
    ++
     +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
    -+		usage_with_options(usage, parseopts);
    ++		usagef(_("unrecognized argument: %s"), argv[0]);
     +
     +	/*
     +	 * With the -z option, both command input and raw output are
    -+	 * NUL-delimited (this mode does not effect patch output). At present
    ++	 * NUL-delimited (this mode does not affect patch output). At present
     +	 * only NUL-delimited raw diff formatted input is supported.
     +	 */
    -+	if (revs.diffopt.line_termination) {
    -+		error(_("working without -z is not supported"));
    -+		usage_with_options(usage, parseopts);
    -+	}
    ++	if (revs.diffopt.line_termination)
    ++		usage(_("working without -z is not supported"));
     +
    -+	if (revs.prune_data.nr) {
    -+		error(_("pathspec arguments not supported"));
    -+		usage_with_options(usage, parseopts);
    -+	}
    ++	if (revs.prune_data.nr)
    ++		usage(_("pathspec arguments not supported"));
     +
     +	if (revs.pending.nr || revs.max_count != -1 ||
     +	    revs.min_age != (timestamp_t)-1 ||
    -+	    revs.max_age != (timestamp_t)-1) {
    -+		error(_("revision arguments not allowed"));
    -+		usage_with_options(usage, parseopts);
    -+	}
    ++	    revs.max_age != (timestamp_t)-1)
    ++		usage(_("revision arguments not allowed"));
     +
     +	if (!revs.diffopt.output_format)
     +		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
     +
    ++	/*
    ++	 * If rename detection is not requested, use rename information from the
    ++	 * raw diff formatted input. Setting skip_resolving_statuses ensures
    ++	 * diffcore_std() does not mess with rename information already present
    ++	 * in queued filepairs.
    ++	 */
    ++	if (!revs.diffopt.detect_rename)
    ++		revs.diffopt.skip_resolving_statuses = 1;
    ++
     +	while (1) {
     +		struct object_id oid_a, oid_b;
     +		struct diff_filepair *pair;
    @@ builtin/diff-pairs.c (new)
     +		const char *p;
     +		char status;
     +
    -+		if (strbuf_getline_nul(&meta, stdin) == EOF)
    ++		if (strbuf_getwholeline(&meta, stdin, line_term) == EOF)
     +			break;
     +
     +		p = meta.buf;
    @@ builtin/diff-pairs.c (new)
     +
     +		status = *p++;
     +
    -+		if (strbuf_getline_nul(&path, stdin) == EOF)
    ++		if (strbuf_getwholeline(&path, stdin, line_term) == EOF)
     +			die(_("got EOF while reading path"));
     +
     +		switch (status) {
    @@ builtin/diff-pairs.c (new)
     +			break;
     +
     +		case DIFF_STATUS_RENAMED:
    -+		case DIFF_STATUS_COPIED:
    -+			{
    ++		case DIFF_STATUS_COPIED: {
     +				struct diff_filespec *a, *b;
     +				unsigned int score;
     +
    -+				if (strbuf_getline_nul(&path_dst, stdin) == EOF)
    ++				if (strbuf_getwholeline(&path_dst, stdin, line_term) == EOF)
     +					die(_("got EOF while reading destination path"));
     +
     +				a = alloc_filespec(path.buf);
    @@ builtin/diff-pairs.c (new)
     +		}
     +	}
     +
    -+	flush_diff_queue(&revs.diffopt);
    ++	diffcore_std(&revs.diffopt);
    ++	diff_flush(&revs.diffopt);
     +	ret = diff_result_code(&revs);
     +
     +	strbuf_release(&path_dst);
    @@ t/t4070-diff-pairs.sh (new)
     +. ./test-lib.sh
     +
     +# This creates a diff with added, modified, deleted, renamed, copied, and
    -+# typechange entries. That includes one in a subdirectory for non-recursive
    -+# tests, and both exact and inexact similarity scores.
    ++# typechange entries. This includes a submodule to test submodule diff support.
     +test_expect_success 'setup' '
    ++	test_config_global protocol.file.allow always &&
    ++	test_create_repo sub &&
    ++	test_commit -C sub initial &&
    ++
    ++	test_create_repo main &&
    ++	cd main &&
     +	echo to-be-gone >deleted &&
     +	echo original >modified &&
     +	echo now-a-file >symlink &&
    @@ t/t4070-diff-pairs.sh (new)
     +	git commit -m base &&
     +	git tag base &&
     +
    ++	git submodule add ../sub &&
     +	echo now-here >added &&
     +	echo new >modified &&
     +	rm deleted &&
    @@ t/t4070-diff-pairs.sh (new)
     +
     +test_expect_success 'diff-pairs recreates --raw' '
     +	git diff-tree -r -M -C -C -z base new >expect &&
    -+	git diff-tree -r -M -C -C -z base new |
    -+	git diff-pairs --raw -z >actual &&
    ++	git diff-pairs --raw -z >actual <expect &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t4070-diff-pairs.sh (new)
     +	git diff-tree -r base new |
     +	test_must_fail git diff-pairs >out 2>err &&
     +
    ++	echo "usage: working without -z is not supported" >expect &&
     +	test_must_be_empty out &&
    -+	grep "error: working without -z is not supported" err
    ++	test_cmp expect err
     +'
     +
     +test_expect_success 'diff-pairs does not support tree objects as input' '
    @@ t/t4070-diff-pairs.sh (new)
     +	git diff-tree -r -z base new |
     +	test_must_fail git diff-pairs -z -- new >out 2>err &&
     +
    ++	echo "usage: pathspec arguments not supported" >expect &&
     +	test_must_be_empty out &&
    -+	grep "error: pathspec arguments not supported" err
    ++	test_cmp expect err
     +'
     +
     +test_done
3:  26c1c80b66 ! 4:  a4809cbd80 builtin/diff-pairs: allow explicit diff queue flush
    @@ Documentation/git-diff-pairs.adoc: in the NUL-terminated raw output format as ge
     
      ## builtin/diff-pairs.c ##
     @@ builtin/diff-pairs.c: int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
    + 	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
      
    - 	repo_init_revisions(repo, &revs, prefix);
      	repo_config(repo, git_diff_basic_config, NULL);
     +	revs.diffopt.no_free = 1;
      	revs.disable_stdin = 1;
    @@ builtin/diff-pairs.c: int cmd_diff_pairs(int argc, const char **argv, const char
      
      		p = meta.buf;
     +		if (!*p) {
    -+			flush_diff_queue(&revs.diffopt);
    ++			diffcore_std(&revs.diffopt);
    ++			diff_flush(&revs.diffopt);
     +			/*
     +			 * When the diff queue is explicitly flushed, append a
     +			 * NUL byte to separate batches of diffs.
    @@ builtin/diff-pairs.c: int cmd_diff_pairs(int argc, const char **argv, const char
      	}
      
     +	revs.diffopt.no_free = 0;
    - 	flush_diff_queue(&revs.diffopt);
    + 	diffcore_std(&revs.diffopt);
    + 	diff_flush(&revs.diffopt);
      	ret = diff_result_code(&revs);
    - 
     
      ## t/t4070-diff-pairs.sh ##
     @@ t/t4070-diff-pairs.sh: test_expect_success 'diff-pairs does not support pathspec arguments' '
    - 	grep "error: pathspec arguments not supported" err
    + 	test_cmp expect err
      '
      
     +test_expect_success 'diff-pairs explicit queue flush' '
-- 
2.48.1

