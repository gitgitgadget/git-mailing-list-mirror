Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899323F38A
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778648; cv=none; b=BcRO4LAZOX4vjH7hnc7sezMk5XZAbBfzOCPQeqRxwSCYcaVLI/2uiolZimnU/FES6tKa7ODjbPbbHVsy4Ecioio7iUbOdM6X/tda06vIUaAdd9lFPdz0W7o7csxlltdQUo4AMYYiznzuPCk/Omn61IqAzDW5g/s7i8dcoS2q9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778648; c=relaxed/simple;
	bh=ib/4MDhLHjNDO3P7Y/f07oe1S0nlzrHtkSf+B31KFoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTShFdFrZLv189ylQTp863sgUDIeuii7UcYteZqJb9kXCI0weN0oSsMgBM84vjvAWF0ODEKV9X7Fe52354tWlfI5lyq6ErKxYAdPuYqc7IhAFdx0rNKohwOIe+DZNt6NB8HfcXdyyag2YM0lULUi30uUfIDMagOu5w8rckshYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWACCIut; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWACCIut"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e10e6a1ceso733367a34.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740778645; x=1741383445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqwNbV4QR1qzEy8ggk1OtLeHjsS+FvxwDTVFj+F5qQY=;
        b=gWACCIut6y0W59J93DTp8NHNsI5eEy+aWb8mfTZWoJAHyhrM4AMp7LWDYJFB94rmbw
         QY3HConjG361wBLlZydOUwzh0xffM824u63o9UUkfHWzLssoXsA6p4/lHW0hihjhNxhT
         fQDHui4SVqSUn8Cw4tFmT1WWsfdxPfKrGA9KVxP1+hbs+VObNgZAsuOSv/5OI7iGX1Yb
         T9LV3UR+K7jqcjPnA3e1cuAwF/wNhYQvnT2XZyz8nL8EYjkO21WbU76EMlnT9mB+jzkq
         y6BEguObhu2t/vFVyl55DU0syMxOYEPg9LzP0bXkrFu+hzv/wlv1j0Y2MoJGtWEh/vU9
         LcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740778645; x=1741383445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqwNbV4QR1qzEy8ggk1OtLeHjsS+FvxwDTVFj+F5qQY=;
        b=SZUrAv4CKi5AjnD9Z8Gd3ZhQMBlgAVxmYDer9DkwqCzzqiKtnzXOvDr4SmCEcCF1xJ
         xWS428R4OO2tFe6u5rKXRuhgOwgMV4HEyDPljrPwQV2aO4BbkvlJKH9f3ze+kUMj28fu
         yVPIWQ9R86fAy3XHsPNVEpSP6J7w5h/3VczTsNXz9WiwhESVTv462L6MVPJpcdwIK6Lg
         nz7Jrso61pQofn7rsekuFnYXyNjvsRW4Mo6s8wDnfiYtbRE4Zm46JgtZf6qmZBuiyhUL
         lYQlWONxPtAeOIaOAkiWJJHmMIpTEYZUeoLbvlTuC5q+OeVOJlL759SqL0TJ//RuM5aj
         D8jg==
X-Gm-Message-State: AOJu0YygT7V9yhVedIgbWsdqVzSHVgAfbGxfUJhrkvGG5pkkQ97t0giV
	E6WR3nQgBT1r/q5aEECvkFGIQscGKb9oNp1QHY03gr//9Eu3JMhtW/naTiAy
X-Gm-Gg: ASbGncu4m/PZ+2N6nday2w0eP8mM0p4Zq/7it3nbSTTJP+IVlaTmappFmLMWV4gzGcu
	rWjRc1t6a+eT8Isr9m24GaaX+4OfctG2VpUOCMgU5EJgCsemPOD7rsq+dUUmcSvIU0yGuCY5My/
	tXWZjmPMvJLUel2S0E4tWJqSRJPjtHlI2tdIUOpiTfDm15gKT35jeOIfTTtfbOdgLmZMeUExQI/
	XV5eBUB3vxrGAkNRj93AAVBUAS/lVFMFxgUMrNxWMbLlWWXDXGG5jTNKfwBERzOUcgRqkgHvCTV
	Ts0n9mpq6r7j7vCgVOw9s8kpiHYfy7/vkTw4NYw+8oWeMVawe0f4
X-Google-Smtp-Source: AGHT+IGfDBd7MZ2uiipd+8A1gz8u2h/koCYcPOiG05bh8EuYjTT4isQq6guUZHQ07pUO+OUVxXr77Q==
X-Received: by 2002:a05:6830:2587:b0:727:345d:3b7b with SMTP id 46e09a7af769-728b82677admr3461183a34.5.1740778644867;
        Fri, 28 Feb 2025 13:37:24 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaad46205sm783589eaf.36.2025.02.28.13.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:37:24 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 0/4] batch blob diff generation
Date: Fri, 28 Feb 2025 15:33:42 -0600
Message-ID: <20250228213346.1335224-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228002604.3859939-1-jltobler@gmail.com>
References: <20250228002604.3859939-1-jltobler@gmail.com>
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

Changes since V4:

    - Renamed usage and options variables to better follow convention.

    - Removed unneeded PARSE_OPT_KEEP_UNKNOWN_OPT from
      `parse_options()`.

    - Instead of using the deprecated `test_create_repo ()` in the
      tests, plain git-init(1) is used.

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
 builtin/diff-pairs.c              | 207 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 diff.c                            |  72 ++++++++---
 diff.h                            |  33 +++++
 git.c                             |   1 +
 meson.build                       |   1 +
 t/meson.build                     |   1 +
 t/t4070-diff-pairs.sh             |  90 +++++++++++++
 13 files changed, 449 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-diff-pairs.adoc
 create mode 100644 builtin/diff-pairs.c
 create mode 100755 t/t4070-diff-pairs.sh

Range-diff against v4:
1:  b2e5486442 = 1:  b2e5486442 diff: return diff_filepair from diff queue helpers
2:  31d80d99ae = 2:  31d80d99ae diff: add option to skip resolving diff statuses
3:  3722c02112 ! 3:  1024a4290c builtin: introduce diff-pairs command
    @@ builtin/diff-pairs.c (new)
     +	int line_term = '\0';
     +	int ret;
     +
    -+	const char * const usagestr[] = {
    ++	const char * const builtin_diff_pairs_usage[] = {
     +		N_("git diff-pairs -z [<diff-options>]"),
     +		NULL
     +	};
    -+	struct option options[] = {
    ++	struct option builtin_diff_pairs_options[] = {
     +		OPT_END()
     +	};
     +
    @@ builtin/diff-pairs.c (new)
     +	 * setup_revisions(). Explicitly handle parsing to ensure options are
     +	 * printed in the usage message.
     +	 */
    -+	parseopts = add_diff_options(options, &revs.diffopt);
    -+	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
    ++	parseopts = add_diff_options(builtin_diff_pairs_options, &revs.diffopt);
    ++	show_usage_with_options_if_asked(argc, argv, builtin_diff_pairs_usage, parseopts);
     +
     +	repo_config(repo, git_diff_basic_config, NULL);
     +	revs.disable_stdin = 1;
     +	revs.abbrev = 0;
     +	revs.diff = 1;
     +
    -+	argc = parse_options(argc, argv, prefix, parseopts, usagestr,
    -+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
    -+			     PARSE_OPT_KEEP_DASHDASH |
    -+			     PARSE_OPT_KEEP_ARGV0);
    ++	argc = parse_options(argc, argv, prefix, parseopts, builtin_diff_pairs_usage,
    ++			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_DASHDASH);
     +
     +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
     +		usagef(_("unrecognized argument: %s"), argv[0]);
    @@ t/t4070-diff-pairs.sh (new)
     +# typechange entries. This includes a submodule to test submodule diff support.
     +test_expect_success 'setup' '
     +	test_config_global protocol.file.allow always &&
    -+	test_create_repo sub &&
    ++	git init sub &&
     +	test_commit -C sub initial &&
     +
    -+	test_create_repo main &&
    ++	git init main &&
     +	cd main &&
     +	echo to-be-gone >deleted &&
     +	echo original >modified &&
4:  a4809cbd80 ! 4:  56f21b664e builtin/diff-pairs: allow explicit diff queue flush
    @@ Documentation/git-diff-pairs.adoc: in the NUL-terminated raw output format as ge
     
      ## builtin/diff-pairs.c ##
     @@ builtin/diff-pairs.c: int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
    - 	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
    + 	show_usage_with_options_if_asked(argc, argv, builtin_diff_pairs_usage, parseopts);
      
      	repo_config(repo, git_diff_basic_config, NULL);
     +	revs.diffopt.no_free = 1;
-- 
2.49.0.rc0

