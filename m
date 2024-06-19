Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F307C6EB
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834294; cv=none; b=UxdLRjQIS1sQzPWKfYSFBLnbbahXWGsR+iQbQxZ9ZE2fTCKPNNUglPWzDy+mZp0Gy229jV77x99dJA1PucTAMgiJYX9fmGbwZ2XE7IYc8NeAumgqGQ4raJh//JZzrjzxKmfa0rhZPX5l1yDiP4lZ9fyKljUtvaE8JavGWPEa164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834294; c=relaxed/simple;
	bh=mWtnvBQ4Brn5VK1494y7BI5hwnrLY2B8G1yPYnUGk+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DbbtP7MjPSlam5DEWFEUTTw667qse6N9k5ohSIDZmzt5mdDntPTvgM29L3xXXigAXKexjuIBmkgzVfw8UJoMmckeECoXirMtc4OkYJAM5Fpt0wMvWrO2vKT0pNBUsMRgIxM0j5bz+bhmdbnKVKflZNKtZ+ThRUl6j2kNbnbnmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYCCums2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYCCums2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217990f997so2226735e9.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834289; x=1719439089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFw859FGztU1PWb71NGJO+5I2q1Jn4Kz7/l6yFw7XHQ=;
        b=HYCCums22G5BlOnE2ttT++NWu+uzp4tlmKLsYZHMW3F54miZtBjqnAudY3QFhCDgxQ
         O2XpasMsIgL7eV1Lfrhmur3RxQVQpmyfGzyEnQo5OZyWN1GoTb4hyPYSfhd3XN4q8fRs
         tDGcR1j+S6JbOGWMHPV2A4Zv7MAyyM6Qq2CQo0h+KdFwW+OfXQ3jk3kpycSBpXeVJBSC
         RRRfr/p554NOtpOXF1weGzXzGrjWtpcJV59IHKyAP+ZThp/gvsjtI2ZJla2ui9ET9p0C
         WwPUF8UQ07f+IzoiU82xdToAF8LvghLPqxiguSjYZ/Xpz5SYgjd+Lgl1qPkVQHOaYV+J
         N0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834289; x=1719439089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFw859FGztU1PWb71NGJO+5I2q1Jn4Kz7/l6yFw7XHQ=;
        b=HnlB2iS84Wjqj/wIlwPeUDddToSF8BNAh7q/9ZZ1r38aTZkraiwEJmvVdUjtd2CyIA
         VIH1uN4/gkMxirNuyQoGQXm7qhYOFE6r1JvFZoa2uHeJu3cpXlkrl5jqEkCmQ6o7KL1J
         +10JcupdJdC8eVxhustt874pLw7EZAncE4UMIB5YA4sH0O70V+EwodloUHlbZ636kR1K
         gK0l5xurHJwcLp/hgcu1gwmFn2xRzn4fQGJ1TUQrgCEek+BxA7swIZjcqi1kE4oyfZZ2
         EA6qpiOV/0YuN7Q2PFFOMXVrP5lU+n9C9A7OZAEjcLdDDnzK3UqplVkK1wam7l8M0Q+d
         JjMQ==
X-Gm-Message-State: AOJu0YxX8zQEUFdr0YPx3v8l8P0vCwSvN+7qe1jlPI0V65EYRmyywOHJ
	D4vROSLq5D/zGs1997eWtQlwt5EE1RtkwUjZsgJd5R6P3AGCwuglGOaC6g==
X-Google-Smtp-Source: AGHT+IHoeUYodEED7IedjpOEC5HITjlxxYLo4J3cmtOJTSLCry1t5IY5jSsMhGue0JmvHLdz38/mjg==
X-Received: by 2002:a05:600c:1504:b0:421:494c:9e74 with SMTP id 5b1f17b1804b1-424751842d5mr24803545e9.23.1718834288117;
        Wed, 19 Jun 2024 14:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be836sm3855875e9.12.2024.06.19.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:07 -0700 (PDT)
Message-Id: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:48 +0000
Subject: [PATCH v2 00/17] mktree: support more flexible usage
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>

The goal of this series is to make 'git mktree' a much more flexible and
powerful tool for constructing arbitrary trees in memory without the use of
an index or worktree. The main additions are:

 * Using an optional "base tree" to add or replace entries in an existing
   tree rather than creating a new one from scratch.
   * Building off of this, having entries with mode "0" indicate "remove
     this entry, if it exists, from the tree"
 * Handling tree entries inside of subtrees (e.g., folder1/my-file.txt)

It also introduces some quality-of-life updates:

 * Using the same input parsing as 'update-index' to allow a wider variety
   of tree entry formats.
 * Adding deduplication of input entries & more thorough validation of
   inputs (with an option to disable both - plus input sorting - if desired
   with '--literally').

The implementation change underpinning the new features is completely
revamping how the tree is constructed in memory. Instead of writing a single
tree object into a strbuf and hashing it into the object database, we
construct an in-core sparse index and write out the root tree, as well as
any new subtrees, using the cache tree infrastructure.

The series is organized as follows:

 * Commits 1-3 contain miscellaneous small renames/refactors to make the
   code more readable & prepare for larger refactoring later.
 * Commits 4-7 generalize the input parsing performed by 'read_index_info()'
   in 'update-index' and update 'mktree' to use it.
 * Commit 8 removes the check on object existence & type from submodule
   entries.
 * Commit 9 adds the '--literally' option to 'mktree'. Practically, this
   option allows tests that currently use 'mktree' to generate corrupt trees
   to continue functioning after we strengthen input validations.
 * Commits 10 & 11 add input path validation & entry deduplication,
   respectively.
 * Commit 12 replaces the strbuf-to-object tree creation with construction
   of an in-core index & writing out the cache tree.
 * Commits 13-15 add the ability to add tree entries to an existing "base"
   tree. Takes 3 commits to do it because it requires a bit of finesse
   around directory/file deduplication and iterating over a tree with
   'read_tree()' with a parallel iteration over the input tree entries.
 * Commit 16 allows for deeper paths in the input.
 * Commit 17 adds handling for mode '0' as "removal" entries.

I also plan to add a '--strict' option that runs 'fsck' checks on the new
tree(s) before writing to the object database (similar to 'mkttag
--strict'), but this series is pretty long as it is and that part can easily
be separated out into its own series.


Changes since V1
================

 * Renamed 'tree_entry_array' & 'tree_entry_iterator' functions to
   'tree_entry_array' & 'tree_entry_iterator', respectively.
 * Removed the return value from 'tree_entry_iterator_advance'.
 * Added call to 'tree_entry_array_clear' in 'tree_entry_array_release',
   updated both methods to optionally free tree entries based on a
   'free_entries' arg.
 * Updated 'read_index_info()':
   * Replaced INDEX_INFO_EMPTY_LINE with INDEX_INFO_UNRECOGNIZED_LINE which
     is returned when any "malformed" line is found, setting an input strbuf
     to the line contents for the caller to deal with.
   * Updated default object type value (when no type info is specified) to
     'OBJ_ANY' from 'OBJ_NONE'.
 * Updated 'mktree' to 'die()' on malformed line with "input format error",
   rather than 'error()' with "malformed input line", to avoid unnecessarily
   changing the error message.
 * Removed check for object existence & type when the entry type is a
   submodule, rearranged checks for readability.
 * Replaced use of 'grep' with 'test_grep' in new/updated tests.
 * Wrapped lines in documentation updates to 76 characters.
 * Applied documentation refactor patch in [1].
 * Dropped '[--]' from the 'mktree' usage string.

[1] https://lore.kernel.org/git/xmqqle3aovpq.fsf@gitster.g/

Thanks!

 * Victoria

Victoria Dye (17):
  mktree: use OPT_BOOL
  mktree: rename treeent to tree_entry
  mktree: use non-static tree_entry array
  update-index: generalize 'read_index_info'
  index-info.c: return unrecognized lines to caller
  index-info.c: parse object type in provided in read_index_info
  mktree: use read_index_info to read stdin lines
  mktree.c: do not fail on mismatched submodule type
  mktree: add a --literally option
  mktree: validate paths more carefully
  mktree: overwrite duplicate entries
  mktree: create tree using an in-core index
  mktree: use iterator struct to add tree entries to index
  mktree: add directory-file conflict hashmap
  mktree: optionally add to an existing tree
  mktree: allow deeper paths in input
  mktree: remove entries when mode is 0

 Documentation/git-mktree.txt         |  50 ++-
 Documentation/git-update-index.txt   |  16 +-
 Documentation/index-info-formats.txt |  13 +
 Makefile                             |   1 +
 builtin/mktree.c                     | 592 ++++++++++++++++++++++-----
 builtin/update-index.c               | 135 ++----
 index-info.c                         | 100 +++++
 index-info.h                         |  15 +
 t/t1010-mktree.sh                    | 350 +++++++++++++++-
 t/t1014-read-tree-confusing.sh       |   6 +-
 t/t1450-fsck.sh                      |   4 +-
 t/t1601-index-bogus.sh               |   2 +-
 t/t1700-split-index.sh               |   6 +-
 t/t2107-update-index-basic.sh        |  32 ++
 t/t7008-filter-branch-null-sha1.sh   |   6 +-
 t/t7417-submodule-path-url.sh        |   2 +-
 t/t7450-bad-git-dotfiles.sh          |   8 +-
 17 files changed, 1088 insertions(+), 250 deletions(-)
 create mode 100644 Documentation/index-info-formats.txt
 create mode 100644 index-info.c
 create mode 100644 index-info.h


base-commit: 8d94cfb54504f2ec9edc7ca3eb5c29a3dd3675ae
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1746%2Fvdye%2Fvdye%2Fmktree-recursive-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1746/vdye/vdye/mktree-recursive-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1746

Range-diff vs v1:

  1:  074dc98acc7 =  1:  074dc98acc7 mktree: use OPT_BOOL
  2:  4558f35e7bf =  2:  4558f35e7bf mktree: rename treeent to tree_entry
  3:  5ade145352f !  3:  d0d5523a32b mktree: use non-static tree_entry array
     @@ builtin/mktree.c
      +	size_t nr, alloc;
      +	struct tree_entry **entries;
      +};
     - 
     --static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
     ++
      +static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entry *ent)
      +{
      +	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
      +	arr->entries[arr->nr++] = ent;
      +}
      +
     -+static void clear_tree_entry_array(struct tree_entry_array *arr)
     ++static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entries)
      +{
     -+	for (size_t i = 0; i < arr->nr; i++)
     -+		FREE_AND_NULL(arr->entries[i]);
     ++	if (free_entries) {
     ++		for (size_t i = 0; i < arr->nr; i++)
     ++			FREE_AND_NULL(arr->entries[i]);
     ++	}
      +	arr->nr = 0;
      +}
     -+
     -+static void release_tree_entry_array(struct tree_entry_array *arr)
     + 
     +-static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
     ++static void tree_entry_array_release(struct tree_entry_array *arr, int free_entries)
      +{
     ++	tree_entry_array_clear(arr, free_entries);
      +	FREE_AND_NULL(arr->entries);
     -+	arr->nr = arr->alloc = 0;
     ++	arr->alloc = 0;
      +}
      +
      +static void append_to_tree(unsigned mode, struct object_id *oid, const char *path,
     @@ builtin/mktree.c: static void append_to_tree(unsigned mode, struct object_id *oi
       
      -	ALLOC_GROW(entries, used + 1, alloc);
      -	entries[used++] = ent;
     -+	/* Append the update */
      +	tree_entry_array_push(arr, ent);
       }
       
     @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
       			fflush(stdout);
       		}
      -		used=0; /* reset tree entry buffer for re-use in batch mode */
     -+		clear_tree_entry_array(&arr); /* reset tree entry buffer for re-use in batch mode */
     ++		tree_entry_array_clear(&arr, 1); /* reset tree entry buffer for re-use in batch mode */
       	}
      +
     -+	release_tree_entry_array(&arr);
     ++	tree_entry_array_release(&arr, 1);
       	strbuf_release(&sb);
       	return 0;
       }
  4:  9d0689e9c28 !  4:  f5473764236 update-index: generalize 'read_index_info'
     @@ Commit message
          callback 'apply_index_info()' to verify the parsed line and update the index
          according to its contents.
      
     -    The input parsing done by 'read_index_info()' is similar to, but more
     -    flexible than, the parsing done in 'mktree' by 'mktree_line()' (handling not
     -    only 'git ls-tree' output but also the outputs of 'git apply --index-info'
     -    and 'git ls-files --stage' outputs). To make 'mktree' more flexible, a later
     -    patch will replace mktree's custom parsing with 'read_index_info()'.
     +    Switching to using a callback to validate the parsed entry in 'update-index'
     +    results in a slight change to the error message indicating a file could not
     +    be removed from the index. The original implementation uses the raw, quoted
     +    pathname in the error message, whereas the callback (without access to the
     +    raw pathname) uses the unquoted value. However, this change makes the failed
     +    removal message consistent with all other error messages in the function,
     +    and that consistency is likely more beneficial than not to a user.
      
     +    The motivation for this change is to consolidate the already-similar input
     +    parsing logic in 'git update-index' and 'git mktree', avoiding code
     +    duplication and the associated maintenance burden. The input formats
     +    accepted by 'update-index' are a superset of those accepted by 'mktree', so
     +    in a later commit we can replace the input parsing of the latter with
     +    'read_index_info()' without breaking existing usage.
     +
     +    Co-authored-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     + ## Documentation/git-update-index.txt ##
     +@@ Documentation/git-update-index.txt: USING --INDEX-INFO
     + 
     + `--index-info` is a more powerful mechanism that lets you feed
     + multiple entry definitions from the standard input, and designed
     +-specifically for scripts.  It can take inputs of three formats:
     ++specifically for scripts.  It can take inputs in the following formats:
     + 
     +-    . mode SP type SP sha1          TAB path
     +-+
     +-This format is to stuff `git ls-tree` output into the index.
     +-
     +-    . mode         SP sha1 SP stage TAB path
     +-+
     +-This format is to put higher order stages into the
     +-index file and matches 'git ls-files --stage' output.
     +-
     +-    . mode         SP sha1          TAB path
     +-+
     +-This format is no longer produced by any Git command, but is
     +-and will continue to be supported by `update-index --index-info`.
     ++include::index-info-formats.txt[]
     + 
     + To place a higher stage entry to the index, the path should
     + first be removed by feeding a mode=0 entry for the path, and
     +
     + ## Documentation/index-info-formats.txt (new) ##
     +@@
     ++    . mode SP type SP sha1          TAB path
     +++
     ++This format is to use `git ls-tree` output.
     ++
     ++    . mode         SP sha1 SP stage TAB path
     +++
     ++This format allows higher order stages to appear and
     ++matches 'git ls-files --stage' output.
     ++
     ++    . mode         SP sha1          TAB path
     +++
     ++This format is no longer produced by any Git command, but is
     ++and will continue to be supported.
     +
       ## Makefile ##
      @@ Makefile: LIB_OBJS += hex.o
       LIB_OBJS += hex-ll.o
     @@ builtin/update-index.c: static void update_one(const char *path)
       
       static const char * const update_index_usage[] = {
      @@ builtin/update-index.c: static enum parse_opt_result stdin_cacheinfo_callback(
     + 	struct parse_opt_ctx_t *ctx, const struct option *opt,
       	const char *arg, int unset)
       {
     - 	int *nul_term_line = opt->value;
     -+	int ret;
     +-	int *nul_term_line = opt->value;
     ++	int ret = 0;
       
       	BUG_ON_OPT_NEG(unset);
       	BUG_ON_OPT_ARG(arg);
     -@@ builtin/update-index.c: static enum parse_opt_result stdin_cacheinfo_callback(
     - 	if (ctx->argc != 1)
     - 		return error("option '%s' must be the last argument", opt->long_name);
     - 	allow_add = allow_replace = allow_remove = 1;
     + 
     +-	if (ctx->argc != 1)
     +-		return error("option '%s' must be the last argument", opt->long_name);
     +-	allow_add = allow_replace = allow_remove = 1;
      -	read_index_info(*nul_term_line);
     -+	ret = read_index_info(*nul_term_line, apply_index_info, NULL);
     -+	if (ret)
     -+		return -1;
     +-	return 0;
     ++	if (ctx->argc != 1) {
     ++		ret = error("option '%s' must be the last argument", opt->long_name);
     ++	} else {
     ++		int *nul_term_line = opt->value;
      +
     - 	return 0;
     ++		allow_add = allow_replace = allow_remove = 1;
     ++		ret = read_index_info(*nul_term_line, apply_index_info, NULL);
     ++		if (ret)
     ++			ret = -1;
     ++	}
     ++
     ++	return ret;
       }
       
     + static enum parse_opt_result stdin_callback(
      
       ## index-info.c (new) ##
      @@
     @@ index-info.c (new)
      +		continue;
      +
      +	bad_line:
     -+		ret = error("malformed input line '%s'", buf.buf);
     -+		break;
     ++		die("malformed input line '%s'", buf.buf);
      +	}
      +	strbuf_release(&buf);
      +	strbuf_release(&uq);
     @@ t/t2107-update-index-basic.sh: test_expect_success '--index-version' '
      +	# empty line
      +	echo "" |
      +	test_must_fail git update-index --index-info 2>err &&
     -+	grep "malformed input line" err &&
     ++	test_grep "malformed input line" err &&
      +
      +	# bad whitespace
      +	printf "100644 $EMPTY_BLOB A" |
      +	test_must_fail git update-index --index-info 2>err &&
     -+	grep "malformed input line" err &&
     ++	test_grep "malformed input line" err &&
      +
      +	# invalid stage value
      +	printf "100644 $EMPTY_BLOB 5\tA" |
      +	test_must_fail git update-index --index-info 2>err &&
     -+	grep "malformed input line" err &&
     ++	test_grep "malformed input line" err &&
      +
      +	# invalid OID length
      +	printf "100755 abc123\tA" |
      +	test_must_fail git update-index --index-info 2>err &&
     -+	grep "malformed input line" err &&
     ++	test_grep "malformed input line" err &&
      +
      +	# bad quoting
      +	printf "100644 $EMPTY_BLOB\t\"A" |
      +	test_must_fail git update-index --index-info 2>err &&
     -+	grep "bad quoting of path name" err
     ++	test_grep "bad quoting of path name" err
      +'
      +
       test_done
  5:  7e3bcc16e23 !  5:  4f4d54c8d07 index-info.c: identify empty input lines in read_index_info
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    index-info.c: identify empty input lines in read_index_info
     +    index-info.c: return unrecognized lines to caller
      
     -    Update 'read_index_info()' to return INDEX_INFO_EMPTY_LINE (value 1), rather
     -    than the default error code (value -1) when the function encounters an empty
     -    line in stdin. This grants the caller the flexibility to handle such
     -    scenarios differently than a typical error. In the case of 'update-index',
     -    we'll still exit with a "malformed input line" error. However, when
     -    'read_index_info()' is used to process the input to 'mktree' in a later
     -    patch, the empty line return value will signal a new tree in --batch mode.
     +    Update 'read_index_info()' to return INDEX_INFO_UNRECOGNIZED_LINE (value 1),
     +    rather than die()-ing when the function encounters a line that cannot be
     +    parsed according to one of the accepted formats. This grants the caller the
     +    flexibility to fall back on custom handling for such lines rather than a
     +    returning a catch-all error. In the case of 'update-index', we'll still exit
     +    with a "malformed input line" error. However, when 'read_index_info()' is
     +    used to process the input to 'mktree' in a later patch, an empty line return
     +    value will signal a new tree in --batch mode.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/update-index.c ##
      @@ builtin/update-index.c: static enum parse_opt_result stdin_cacheinfo_callback(
     - 		return error("option '%s' must be the last argument", opt->long_name);
     - 	allow_add = allow_replace = allow_remove = 1;
     - 	ret = read_index_info(*nul_term_line, apply_index_info, NULL);
     --	if (ret)
     -+	if (ret == INDEX_INFO_EMPTY_LINE)
     -+		return error("malformed input line ''");
     -+	else if (ret < 0)
     - 		return -1;
     - 
     - 	return 0;
     + 		ret = error("option '%s' must be the last argument", opt->long_name);
     + 	} else {
     + 		int *nul_term_line = opt->value;
     ++		struct strbuf line = STRBUF_INIT;
     + 
     + 		allow_add = allow_replace = allow_remove = 1;
     +-		ret = read_index_info(*nul_term_line, apply_index_info, NULL);
     +-		if (ret)
     ++		ret = read_index_info(*nul_term_line, apply_index_info, NULL, &line);
     ++
     ++		if (ret == INDEX_INFO_UNRECOGNIZED_LINE)
     ++			ret = error("malformed input line '%s'", line.buf);
     ++		else if (ret)
     + 			ret = -1;
     ++		strbuf_release(&line);
     + 	}
     + 
     + 	return ret;
      
       ## index-info.c ##
     +@@
     + #include "strbuf.h"
     + #include "quote.h"
     + 
     +-int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
     ++int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
     ++		    struct strbuf *line)
     + {
     + 	const int hexsz = the_hash_algo->hexsz;
     +-	struct strbuf buf = STRBUF_INIT;
     + 	struct strbuf uq = STRBUF_INIT;
     + 	strbuf_getline_fn getline_fn;
     + 	int ret = 0;
     + 
     + 	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
     +-	while (getline_fn(&buf, stdin) != EOF) {
     ++	while (getline_fn(line, stdin) != EOF) {
     + 		char *ptr, *tab;
     + 		char *path_name;
     + 		struct object_id oid;
     +@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
     + 		 * index file and matches "git ls-files --stage" output.
     + 		 */
     + 		errno = 0;
     +-		ul = strtoul(buf.buf, &ptr, 8);
     +-		if (ptr == buf.buf || *ptr != ' '
     ++		ul = strtoul(line->buf, &ptr, 8);
     ++		if (ptr == line->buf || *ptr != ' '
     + 		    || errno || (unsigned int) ul != ul)
     + 			goto bad_line;
     + 		mode = ul;
      @@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
     - 		unsigned long ul;
     - 		int stage;
     + 		continue;
       
     -+		if (!buf.len) {
     -+			ret = INDEX_INFO_EMPTY_LINE;
     -+			break;
     -+		}
     -+
     - 		/* This reads lines formatted in one of three formats:
     - 		 *
     - 		 * (1) mode         SP sha1          TAB path
     + 	bad_line:
     +-		die("malformed input line '%s'", buf.buf);
     ++		ret = INDEX_INFO_UNRECOGNIZED_LINE;
     ++		break;
     + 	}
     +-	strbuf_release(&buf);
     + 	strbuf_release(&uq);
     ++	if (!ret)
     ++		strbuf_reset(line);
     + 
     + 	return ret;
     + }
      
       ## index-info.h ##
      @@
       
       typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
       
     -+#define INDEX_INFO_EMPTY_LINE 1
     ++#define INDEX_INFO_UNRECOGNIZED_LINE 1
      +
       /* Iterate over parsed index info from stdin */
     - int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata);
     +-int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata);
     ++int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
     ++		    struct strbuf *line);
       
     + #endif /* INDEX_INFO_H */
  6:  f56eee0b48d !  6:  472efcaf1dd index-info.c: parse object type in provided in read_index_info
     @@ Commit message
          by 'read_index_info()' (i.e. on lines formatted like the output of 'git
          ls-tree'), parse it into an 'enum object_type' and provide it to the
          'read_index_info()' callback as an argument. If the type is not provided,
     -    pass 'OBJ_NONE' instead. If the object type is invalid, return an error.
     +    pass 'OBJ_ANY' instead. If the object type is invalid, return an error.
      
          The goal of this change is to allow for more thorough validation of the
          provided object type (e.g. against the provided mode) in 'mktree' once
     @@ builtin/update-index.c: static void update_one(const char *path)
       	if (!verify_path(path_name, mode)) {
      
       ## index-info.c ##
     -@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
     +@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
       		char *ptr, *tab;
       		char *path_name;
       		struct object_id oid;
     -+		enum object_type obj_type = OBJ_NONE;
     ++		enum object_type obj_type = OBJ_ANY;
       		unsigned int mode;
       		unsigned long ul;
       		int stage;
     -@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
     +@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
       
       		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
       			stage = tab[-1] - '0';
     @@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void
       		if (!nul_term_line && path_name[0] == '"') {
       			strbuf_reset(&uq);
       			if (unquote_c_style(&uq, path_name, NULL)) {
     -@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
     +@@ index-info.c: int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
       			path_name = uq.buf;
       		}
       
     @@ index-info.h
      -typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
      +typedef int (*each_index_info_fn)(unsigned int, struct object_id *, enum object_type, int, const char *, void *);
       
     - #define INDEX_INFO_EMPTY_LINE 1
     + #define INDEX_INFO_UNRECOGNIZED_LINE 1
       
      
       ## t/t2107-update-index-basic.sh ##
      @@ t/t2107-update-index-basic.sh: test_expect_success '--index-info fails on malformed input' '
       	test_must_fail git update-index --index-info 2>err &&
     - 	grep "malformed input line" err &&
     + 	test_grep "malformed input line" err &&
       
      +	# invalid type
      +	printf "100644 bad $EMPTY_BLOB\tA" |
      +	test_must_fail git update-index --index-info 2>err &&
     -+	grep "invalid object type" err &&
     ++	test_grep "invalid object type" err &&
      +
       	# invalid stage value
       	printf "100644 $EMPTY_BLOB 5\tA" |
  7:  8d1e1eaa70b !  7:  9dc8e16a7fc mktree: use read_index_info to read stdin lines
     @@ Commit message
          across the commands (avoiding the need for two similar implementations for
          input parsing) and adds flexibility to mktree.
      
     +    It should be noted that, while the error messages are largely preserved in
     +    the refactor, one does change: "fatal: invalid quoting" is now "error: bad
     +    quoting of path name".
     +
          Update 'Documentation/git-mktree.txt' to reflect the more permissive input
     -    format.
     +    format, as well as make a note about rejecting stage values higher than 0.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-mktree.txt ##
     @@ Documentation/git-mktree.txt: SYNOPSIS
      -a tree object.  The order of the tree entries is normalized by mktree so
      -pre-sorting the input is not required.  The object name of the tree object
      -built is written to the standard output.
     -+Reads entry information from stdin and creates a tree object from those entries.
     -+The object name of the tree object built is written to the standard output.
     ++Reads entry information from stdin and creates a tree object from those
     ++entries. The object name of the tree object built is written to the standard
     ++output.
       
       OPTIONS
       -------
     @@ Documentation/git-mktree.txt: OPTIONS
      +INPUT FORMAT
      +------------
      +Tree entries may be specified in any of the formats compatible with the
     -+`--index-info` option to linkgit:git-update-index[1]. The order of the tree
     -+entries is normalized by `mktree` so pre-sorting the input by path is not
     -+required.
     ++`--index-info` option to linkgit:git-update-index[1]:
     ++
     ++include::index-info-formats.txt[]
     ++
     ++Note that if the `stage` of a tree entry is given, the value must be 0.
     ++Higher stages represent conflicted files in an index; this information
     ++cannot be represented in a tree object. The command will fail without
     ++writing the tree if a higher order stage is specified for any entry.
     ++
     ++The order of the tree entries is normalized by `mktree` so pre-sorting the
     ++input by path is not required.
      +
       GIT
       ---
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
      +};
      +
      +static int mktree_line(unsigned int mode, struct object_id *oid,
     -+		       enum object_type obj_type, int stage UNUSED,
     ++		       enum object_type obj_type, int stage,
      +		       const char *path, void *cbdata)
       {
      -	char *ptr, *ntr;
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
      -			die("invalid quoting");
      -		path = to_free = strbuf_detach(&p_uq, NULL);
      -	}
     -+	if (obj_type && mode_type != obj_type)
     -+		die("object type (%s) doesn't match mode type (%s)",
     -+		    type_name(obj_type), type_name(mode_type));
     ++	if (stage)
     ++		die(_("path '%s' is unmerged"), path);
       
      -	/*
      -	 * Object type is redundantly derivable three ways.
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
      -		die("entry '%s' object type (%s) doesn't match mode type (%s)",
      -			path, ptr, type_name(mode_type));
      -	}
     ++	if (obj_type != OBJ_ANY && mode_type != obj_type)
     ++		die("object type (%s) doesn't match mode type (%s)",
     ++		    type_name(obj_type), type_name(mode_type));
     ++
      +	oi.typep = &parsed_obj_type;
       
      -	/* Check the type of object identified by oid without fetching objects */
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
       				     OBJECT_INFO_QUICK |
       				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
      -		obj_type = -1;
     -+		parsed_obj_type = -1;
     - 
     +-
      -	if (obj_type < 0) {
      -		if (allow_missing) {
      -			; /* no problem - missing objects are presumed to be of the right type */
     -+	if (parsed_obj_type < 0) {
     -+		if (data->allow_missing || S_ISGITLINK(mode)) {
     -+			; /* no problem - missing objects & submodules are presumed to be of the right type */
     - 		} else {
     +-		} else {
      -			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
      -		}
      -	} else {
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
      -			 */
      -			die("entry '%s' object %s is a %s but specified type was (%s)",
      -				path, oid_to_hex(&oid), type_name(obj_type), type_name(mode_type));
     +-		}
     ++		parsed_obj_type = -1;
     ++
     ++	if (parsed_obj_type < 0) {
     ++		/*
     ++		 * There are two conditions where the object being missing
     ++		 * is acceptable:
     ++		 *
     ++		 * - We're explicitly allowing it with --missing.
     ++		 * - The object is a submodule, which we wouldn't expect to
     ++		 *   be in this repo anyway.
     ++		 *
     ++		 * If neither condition is met, die().
     ++		 */
     ++		if (!data->allow_missing && !S_ISGITLINK(mode))
      +			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
     - 		}
     ++
      +	} else if (parsed_obj_type != mode_type) {
      +		/*
      +		 * The object exists but is of the wrong type.
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
       	struct tree_entry_array arr = { 0 };
      -	strbuf_getline_fn getline_fn;
      +	struct mktree_line_data mktree_line_data = { .arr = &arr };
     ++	struct strbuf line = STRBUF_INIT;
      +	int ret;
       
       	const struct option option[] = {
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
      -				break;
      -			}
      -			if (sb.buf[0] == '\0') {
     --				/* empty lines denote tree boundaries in batch mode */
     --				if (is_batch_mode)
     --					break;
     --				die("input format error: (blank line only valid in batch mode)");
     --			}
     --			mktree_line(sb.buf, nul_term_line, allow_missing, &arr);
     --		}
     --		if (is_batch_mode && got_eof && arr.nr < 1) {
      +
      +	do {
     -+		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data);
     ++		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data, &line);
      +		if (ret < 0)
      +			break;
      +
     -+		/* empty lines denote tree boundaries in batch mode */
     -+		if (ret > 0 && !is_batch_mode)
     -+			die("input format error: (blank line only valid in batch mode)");
     ++		if (ret == INDEX_INFO_UNRECOGNIZED_LINE) {
     ++			if (line.len)
     ++				die("input format error: %s", line.buf);
     ++			else if (!is_batch_mode)
     + 				/* empty lines denote tree boundaries in batch mode */
     +-				if (is_batch_mode)
     +-					break;
     + 				die("input format error: (blank line only valid in batch mode)");
     +-			}
     +-			mktree_line(sb.buf, nul_term_line, allow_missing, &arr);
     + 		}
     +-		if (is_batch_mode && got_eof && arr.nr < 1) {
      +
      +		if (is_batch_mode && !ret && arr.nr < 1) {
       			/*
     @@ builtin/mktree.c: static const char *mktree_usage[] = {
      @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
       			fflush(stdout);
       		}
     - 		clear_tree_entry_array(&arr); /* reset tree entry buffer for re-use in batch mode */
     + 		tree_entry_array_clear(&arr, 1); /* reset tree entry buffer for re-use in batch mode */
      -	}
      +	} while (ret > 0);
       
     - 	release_tree_entry_array(&arr);
     ++	strbuf_release(&line);
     + 	tree_entry_array_release(&arr, 1);
      -	strbuf_release(&sb);
      -	return 0;
      +	return !!ret;
     @@ t/t1010-mktree.sh: test_expect_success 'ls-tree output in wrong order given to m
      +	tree_oid="$(cat tree)" &&
      +	printf "160000 commit $tree_oid\tA" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "object $tree_oid is a tree but specified type was (commit)" err
     ++	test_grep "object $tree_oid is a tree but specified type was (commit)" err
      +'
      +
       test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
     @@ t/t1010-mktree.sh: test_expect_success 'mktree refuses to read ls-tree -r output
      +	# empty line without --batch
      +	echo "" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "blank line only valid in batch mode" err &&
     ++	test_grep "blank line only valid in batch mode" err &&
      +
      +	# bad whitespace
      +	printf "100644 blob $EMPTY_BLOB A" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "malformed input line" err &&
     ++	test_grep "input format error" err &&
      +
      +	# invalid type
      +	printf "100644 bad $EMPTY_BLOB\tA" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "invalid object type" err &&
     ++	test_grep "invalid object type" err &&
      +
      +	# invalid OID length
      +	printf "100755 blob abc123\tA" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "malformed input line" err &&
     ++	test_grep "input format error" err &&
      +
      +	# bad quoting
      +	printf "100644 blob $EMPTY_BLOB\t\"A" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "bad quoting of path name" err
     ++	test_grep "bad quoting of path name" err
      +'
      +
      +test_expect_success 'mktree fails on mode mismatch' '
     @@ t/t1010-mktree.sh: test_expect_success 'mktree refuses to read ls-tree -r output
      +	# mode-type mismatch
      +	printf "100644 tree $tree_oid\tA" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "object type (tree) doesn${SQ}t match mode type (blob)" err &&
     ++	test_grep "object type (tree) doesn${SQ}t match mode type (blob)" err &&
      +
      +	# mode-object mismatch (no --missing)
      +	printf "100644 $tree_oid\tA" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "object $tree_oid is a tree but specified type was (blob)" err
     ++	test_grep "object $tree_oid is a tree but specified type was (blob)" err
      +'
      +
       test_done
  -:  ----------- >  8:  8a3264afd0c mktree.c: do not fail on mismatched submodule type
  8:  b497dc90687 !  9:  e640a385b3d mktree: add a --literally option
     @@ Documentation/git-mktree.txt: OPTIONS
       
      +--literally::
      +	Create the tree from the tree entries provided to stdin in the order
     -+	they are provided without performing additional sorting, deduplication,
     -+	or path validation on them. This option is primarily useful for creating
     -+	invalid tree objects to use in tests of how Git deals with various forms
     -+	of tree corruption.
     ++	they are provided without performing additional sorting,
     ++	deduplication, or path validation on them. This option is primarily
     ++	useful for creating invalid tree objects to use in tests of how Git
     ++	deals with various forms of tree corruption.
      +
       --batch::
       	Allow building of more than one tree object before exiting.  Each
       	tree is separated by a single blank line. The final newline is
      
       ## builtin/mktree.c ##
     -@@ builtin/mktree.c: static void release_tree_entry_array(struct tree_entry_array *arr)
     +@@ builtin/mktree.c: static void tree_entry_array_release(struct tree_entry_array *arr, int free_entr
       }
       
       static void append_to_tree(unsigned mode, struct object_id *oid, const char *path,
     @@ builtin/mktree.c: static void write_tree(struct tree_entry_array *arr, struct ob
       
       static int mktree_line(unsigned int mode, struct object_id *oid,
      @@ builtin/mktree.c: static int mktree_line(unsigned int mode, struct object_id *oid,
     - 		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
     + 		}
       	}
       
      -	append_to_tree(mode, oid, path, data->arr);
     @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
      
       ## t/t1010-mktree.sh ##
      @@ t/t1010-mktree.sh: test_expect_success 'mktree fails on mode mismatch' '
     - 	grep "object $tree_oid is a tree but specified type was (blob)" err
     + 	test_grep "object $tree_oid is a tree but specified type was (blob)" err
       '
       
      +test_expect_success '--literally can create invalid trees' '
     @@ t/t1010-mktree.sh: test_expect_success 'mktree fails on mode mismatch' '
      +	} | git mktree --literally >tree.bad &&
      +	git cat-file tree $(cat tree.bad) >top.bad &&
      +	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
     -+	grep "contains duplicate file entries" err &&
     ++	test_grep "contains duplicate file entries" err &&
      +
      +	# disallowed path
      +	{
     @@ t/t1010-mktree.sh: test_expect_success 'mktree fails on mode mismatch' '
      +	} | git mktree --literally >tree.bad &&
      +	git cat-file tree $(cat tree.bad) >top.bad &&
      +	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
     -+	grep "contains ${SQ}.git${SQ}" err &&
     ++	test_grep "contains ${SQ}.git${SQ}" err &&
      +
      +	# nested entry
      +	{
     @@ t/t1010-mktree.sh: test_expect_success 'mktree fails on mode mismatch' '
      +	} | git mktree --literally >tree.bad &&
      +	git cat-file tree $(cat tree.bad) >top.bad &&
      +	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
     -+	grep "contains full pathnames" err &&
     ++	test_grep "contains full pathnames" err &&
      +
      +	# bad entry ordering
      +	{
     @@ t/t1010-mktree.sh: test_expect_success 'mktree fails on mode mismatch' '
      +	} | git mktree --literally >tree.bad &&
      +	git cat-file tree $(cat tree.bad) >top.bad &&
      +	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
     -+	grep "not properly sorted" err
     ++	test_grep "not properly sorted" err
      +'
      +
       test_done
  9:  4f9f77e693c ! 10:  2eb207064f8 mktree: validate paths more carefully
     @@ builtin/mktree.c: static void append_to_tree(unsigned mode, struct object_id *oi
      
       ## t/t1010-mktree.sh ##
      @@ t/t1010-mktree.sh: test_expect_success '--literally can create invalid trees' '
     - 	grep "not properly sorted" err
     + 	test_grep "not properly sorted" err
       '
       
      +test_expect_success 'mktree validates path' '
     @@ t/t1010-mktree.sh: test_expect_success '--literally can create invalid trees' '
      +	# Invalid: blob with trailing slash
      +	printf "100644 blob $blob_oid\ttest/" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "invalid path ${SQ}test/${SQ}" err &&
     ++	test_grep "invalid path ${SQ}test/${SQ}" err &&
      +
      +	# Invalid: dotdot
      +	printf "040000 tree $tree_oid\t../" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "invalid path ${SQ}../${SQ}" err &&
     ++	test_grep "invalid path ${SQ}../${SQ}" err &&
      +
      +	# Invalid: dot
      +	printf "040000 tree $tree_oid\t." |
      +	test_must_fail git mktree 2>err &&
     -+	grep "invalid path ${SQ}.${SQ}" err &&
     ++	test_grep "invalid path ${SQ}.${SQ}" err &&
      +
      +	# Invalid: .git
      +	printf "040000 tree $tree_oid\t.git/" |
      +	test_must_fail git mktree 2>err &&
     -+	grep "invalid path ${SQ}.git/${SQ}" err
     ++	test_grep "invalid path ${SQ}.git/${SQ}" err
      +'
      +
       test_done
 10:  b59a4ad8ab4 ! 11:  fb555658057 mktree: overwrite duplicate entries
     @@ Commit message
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-mktree.txt ##
     -@@ Documentation/git-mktree.txt: OPTIONS
     - INPUT FORMAT
     - ------------
     - Tree entries may be specified in any of the formats compatible with the
     --`--index-info` option to linkgit:git-update-index[1]. The order of the tree
     --entries is normalized by `mktree` so pre-sorting the input by path is not
     --required.
     -+`--index-info` option to linkgit:git-update-index[1].
     -+
     -+The order of the tree entries is normalized by `mktree` so pre-sorting the input
     -+by path is not required. Multiple entries provided with the same path are
     -+deduplicated, with only the last one specified added to the tree.
     +@@ Documentation/git-mktree.txt: cannot be represented in a tree object. The command will fail without
     + writing the tree if a higher order stage is specified for any entry.
     + 
     + The order of the tree entries is normalized by `mktree` so pre-sorting the
     +-input by path is not required.
     ++input by path is not required. Multiple entries provided with the same path
     ++are deduplicated, with only the last one specified added to the tree.
       
       GIT
       ---
     @@ builtin/mktree.c
       	struct object_id oid;
       	int len;
      @@ builtin/mktree.c: static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
     + 	ent->len = len;
       	oidcpy(&ent->oid, oid);
       
     - 	/* Append the update */
      +	ent->order = arr->nr;
       	tree_entry_array_push(arr, ent);
       }
     @@ t/t1010-mktree.sh: test_expect_success '--literally can create invalid trees' '
       
       	# Valid: tree with or without trailing slash, blob without trailing slash
      @@ t/t1010-mktree.sh: test_expect_success 'mktree validates path' '
     - 	grep "invalid path ${SQ}.git/${SQ}" err
     + 	test_grep "invalid path ${SQ}.git/${SQ}" err
       '
       
      +test_expect_success 'mktree with duplicate entries' '
 11:  130413f2404 = 12:  2333775ba5b mktree: create tree using an in-core index
 12:  94d6615d634 ! 13:  56f28efff54 mktree: use iterator struct to add tree entries to index
     @@ builtin/mktree.c: static void sort_and_dedup_tree_entry_array(struct tree_entry_
      +	} priv;
      +};
      +
     -+static void init_tree_entry_iterator(struct tree_entry_iterator *iter,
     ++static void tree_entry_iterator_init(struct tree_entry_iterator *iter,
      +				     struct tree_entry_array *arr)
      +{
      +	iter->priv.arr = arr;
     @@ builtin/mktree.c: static void sort_and_dedup_tree_entry_array(struct tree_entry_
      +}
      +
      +/*
     -+ * Advance the tree entry iterator to the next entry in the array. If no entries
     -+ * remain, 'current' is set to NULL. Returns the previous 'current' value of the
     -+ * iterator.
     ++ * Advance the tree entry iterator to the next entry in the array. If no
     ++ * entries remain, 'current' is set to NULL.
      + */
     -+static struct tree_entry *advance_tree_entry_iterator(struct tree_entry_iterator *iter)
     ++static void tree_entry_iterator_advance(struct tree_entry_iterator *iter)
      +{
     -+	struct tree_entry *prev = iter->current;
      +	iter->current = (iter->priv.idx + 1) < iter->priv.arr->nr
      +			? iter->priv.arr->entries[++iter->priv.idx]
      +			: NULL;
     -+	return prev;
      +}
      +
       static int add_tree_entry_to_index(struct index_state *istate,
     @@ builtin/mktree.c: static int add_tree_entry_to_index(struct index_state *istate,
       static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
       {
      +	struct tree_entry_iterator iter = { NULL };
     -+	struct tree_entry *ent;
       	struct index_state istate = INDEX_STATE_INIT(the_repository);
       	istate.sparse_index = 1;
       
     @@ builtin/mktree.c: static int add_tree_entry_to_index(struct index_state *istate,
      -	/* Construct an in-memory index from the provided entries */
      -	for (size_t i = 0; i < arr->nr; i++) {
      -		struct tree_entry *ent = arr->entries[i];
     -+	init_tree_entry_iterator(&iter, arr);
     - 
     ++	tree_entry_iterator_init(&iter, arr);
     ++
      +	/* Construct an in-memory index from the provided entries & base tree */
     -+	while ((ent = advance_tree_entry_iterator(&iter))) {
     ++	while (iter.current) {
     ++		struct tree_entry *ent = iter.current;
     ++		tree_entry_iterator_advance(&iter);
     + 
       		if (add_tree_entry_to_index(&istate, ent))
       			die(_("failed to add tree entry '%s'"), ent->name);
     - 	}
 13:  68acdd3c5ee ! 14:  6f6d78ae7ac mktree: add directory-file conflict hashmap
     @@ builtin/mktree.c: static inline size_t df_path_len(size_t pathlen, unsigned int
      +	       name_compare(e1->name, e1_len, e2->name, e2_len);
      +}
      +
     -+static void init_tree_entry_array(struct tree_entry_array *arr)
     ++static void tree_entry_array_init(struct tree_entry_array *arr)
      +{
      +	hashmap_init(&arr->df_name_hash, df_name_hash_cmp, NULL, 0);
      +}
     @@ builtin/mktree.c: static inline size_t df_path_len(size_t pathlen, unsigned int
       static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entry *ent)
       {
       	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
     -@@ builtin/mktree.c: static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entr
     - 
     - static void clear_tree_entry_array(struct tree_entry_array *arr)
     - {
     -+	hashmap_clear(&arr->df_name_hash);
     - 	for (size_t i = 0; i < arr->nr; i++)
     - 		FREE_AND_NULL(arr->entries[i]);
     +@@ builtin/mktree.c: static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entrie
     + 			FREE_AND_NULL(arr->entries[i]);
     + 	}
       	arr->nr = 0;
     -@@ builtin/mktree.c: static void clear_tree_entry_array(struct tree_entry_array *arr)
     - 
     - static void release_tree_entry_array(struct tree_entry_array *arr)
     - {
      +	hashmap_clear(&arr->df_name_hash);
     - 	FREE_AND_NULL(arr->entries);
     - 	arr->nr = arr->alloc = 0;
       }
     + 
     + static void tree_entry_array_release(struct tree_entry_array *arr, int free_entries)
      @@ builtin/mktree.c: static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
       	/* Sort again to order the entries for tree insertion */
       	ignore_mode = 0;
     @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
       
       	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
       
     -+	init_tree_entry_array(&arr);
     ++	tree_entry_array_init(&arr);
      +
       	do {
     - 		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data);
     + 		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data, &line);
       		if (ret < 0)
 14:  df0c50dfea3 ! 15:  4b88f84b933 mktree: optionally add to an existing tree
     @@ Documentation/git-mktree.txt: git-mktree - Build a tree-object from formatted tr
       --------
       [verse]
      -'git mktree' [-z] [--missing] [--literally] [--batch]
     -+'git mktree' [-z] [--missing] [--literally] [--batch] [--] [<tree-ish>]
     ++'git mktree' [-z] [--missing] [--literally] [--batch] [<tree-ish>]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-mktree.txt: OPTIONS
       	with NUL.
       
      +<tree-ish>::
     -+	If provided, the tree entries provided in stdin are added to this tree
     -+	rather than a new empty one, replacing existing entries with identical
     -+	names. Not compatible with `--literally`.
     ++	If provided, the tree entries provided in stdin are added to this
     ++	tree rather than a new empty one, replacing existing entries with
     ++	identical names. Not compatible with `--literally`.
      +
       INPUT FORMAT
       ------------
     @@ builtin/mktree.c
       #include "object-store-ll.h"
       
       struct tree_entry {
     -@@ builtin/mktree.c: static struct tree_entry *advance_tree_entry_iterator(struct tree_entry_iterator
     - 	return prev;
     +@@ builtin/mktree.c: static void tree_entry_iterator_advance(struct tree_entry_iterator *iter)
     + 			: NULL;
       }
       
      -static int add_tree_entry_to_index(struct index_state *istate,
     @@ builtin/mktree.c: static struct tree_entry *advance_tree_entry_iterator(struct t
      +				 unsigned mode, void *context)
       {
      -	struct tree_entry_iterator iter = { NULL };
     +-	struct index_state istate = INDEX_STATE_INIT(the_repository);
     +-	istate.sparse_index = 1;
      +	int result;
      +	struct tree_entry *base_tree_ent;
      +	struct build_index_data *cbdata = context;
     @@ builtin/mktree.c: static struct tree_entry *advance_tree_entry_iterator(struct t
      +		int cmp = name_compare(ent->name, ent->len,
      +				       base_tree_ent->name, base_tree_ent->len);
      +		if (!cmp || cmp < 0) {
     -+			advance_tree_entry_iterator(&cbdata->iter);
     ++			tree_entry_iterator_advance(&cbdata->iter);
      +
      +			if (add_tree_entry_to_index(cbdata, ent) < 0) {
      +				result = error(_("failed to add tree entry '%s'"), ent->name);
     @@ builtin/mktree.c: static struct tree_entry *advance_tree_entry_iterator(struct t
      +		       struct object_id *oid)
      +{
      +	struct build_index_data cbdata = { 0 };
     - 	struct tree_entry *ent;
     --	struct index_state istate = INDEX_STATE_INIT(the_repository);
     --	istate.sparse_index = 1;
      +	struct pathspec ps = { 0 };
       
       	sort_and_dedup_tree_entry_array(arr);
       
     --	init_tree_entry_iterator(&iter, arr);
     +-	tree_entry_iterator_init(&iter, arr);
      +	index_state_init(&cbdata.istate, the_repository);
      +	cbdata.istate.sparse_index = 1;
     -+	init_tree_entry_iterator(&cbdata.iter, arr);
     ++	tree_entry_iterator_init(&cbdata.iter, arr);
      +	cbdata.df_name_hash = &arr->df_name_hash;
       
       	/* Construct an in-memory index from the provided entries & base tree */
     --	while ((ent = advance_tree_entry_iterator(&iter))) {
     --		if (add_tree_entry_to_index(&istate, ent))
     +-	while (iter.current) {
     +-		struct tree_entry *ent = iter.current;
     +-		tree_entry_iterator_advance(&iter);
      +	if (base_tree &&
      +	    read_tree(the_repository, base_tree, &ps, build_index_from_tree, &cbdata) < 0)
      +		die(_("failed to create tree"));
      +
     -+	while ((ent = advance_tree_entry_iterator(&cbdata.iter))) {
     ++	while (cbdata.iter.current) {
     ++		struct tree_entry *ent = cbdata.iter.current;
     ++		tree_entry_iterator_advance(&cbdata.iter);
     + 
     +-		if (add_tree_entry_to_index(&istate, ent))
      +		if (add_tree_entry_to_index(&cbdata, ent))
       			die(_("failed to add tree entry '%s'"), ent->name);
       	}
     @@ builtin/mktree.c: static void write_tree_literally(struct tree_entry_array *arr,
       
       static const char *mktree_usage[] = {
      -	"git mktree [-z] [--missing] [--literally] [--batch]",
     -+	"git mktree [-z] [--missing] [--literally] [--batch] [--] [<tree-ish>]",
     ++	"git mktree [-z] [--missing] [--literally] [--batch] [<tree-ish>]",
       	NULL
       };
       
      @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
     - 	int is_batch_mode = 0;
       	struct tree_entry_array arr = { 0 };
       	struct mktree_line_data mktree_line_data = { .arr = &arr };
     + 	struct strbuf line = STRBUF_INIT;
      +	struct tree *base_tree = NULL;
       	int ret;
       
     @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
      +			die(_("not a tree object: %s"), oid_to_hex(&base_tree_oid));
      +	}
       
     - 	init_tree_entry_array(&arr);
     + 	tree_entry_array_init(&arr);
       
      @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
       			if (mktree_line_data.literally)
 15:  058354f45f7 ! 16:  46756c4e314 mktree: allow deeper paths in input
     @@ Commit message
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-mktree.txt ##
     -@@ Documentation/git-mktree.txt: INPUT FORMAT
     - Tree entries may be specified in any of the formats compatible with the
     - `--index-info` option to linkgit:git-update-index[1].
     +@@ Documentation/git-mktree.txt: Higher stages represent conflicted files in an index; this information
     + cannot be represented in a tree object. The command will fail without
     + writing the tree if a higher order stage is specified for any entry.
       
      +Entries may use full pathnames containing directory separators to specify
     -+entries nested within one or more directories. These entries are inserted into
     -+the appropriate tree in the base tree-ish if one exists. Otherwise, empty parent
     -+trees are created to contain the entries.
     ++entries nested within one or more directories. These entries are inserted
     ++into the appropriate tree in the base tree-ish if one exists. Otherwise,
     ++empty parent trees are created to contain the entries.
      +
     - The order of the tree entries is normalized by `mktree` so pre-sorting the input
     - by path is not required. Multiple entries provided with the same path are
     - deduplicated, with only the last one specified added to the tree.
     + The order of the tree entries is normalized by `mktree` so pre-sorting the
     + input by path is not required. Multiple entries provided with the same path
     + are deduplicated, with only the last one specified added to the tree.
      
       ## builtin/mktree.c ##
      @@ builtin/mktree.c: struct tree_entry {
     @@ builtin/mktree.c: static void tree_entry_array_push(struct tree_entry_array *arr
      +	return arr->entries[--arr->nr];
      +}
      +
     - static void clear_tree_entry_array(struct tree_entry_array *arr)
     + static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entries)
       {
     - 	hashmap_clear(&arr->df_name_hash);
     + 	if (free_entries) {
      @@ builtin/mktree.c: static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
       
       		if (!verify_path(ent->name, mode))
     @@ builtin/mktree.c: static void sort_and_dedup_tree_entry_array(struct tree_entry_
      +			}
      +		}
      +
     -+		release_tree_entry_array(&parent_dir_ents);
     ++		tree_entry_array_release(&parent_dir_ents, 0);
      +	}
      +
       	/* Finally, initialize the directory-file conflict hash map */
     @@ builtin/mktree.c: static int build_index_from_tree(const struct object_id *oid,
      +		cmp = name_compare(ent->name, ent->len,
      +				   base_tree_ent->name, base_tree_ent->len);
       		if (!cmp || cmp < 0) {
     - 			advance_tree_entry_iterator(&cbdata->iter);
     + 			tree_entry_iterator_advance(&cbdata->iter);
       
      @@ builtin/mktree.c: static int build_index_from_tree(const struct object_id *oid,
       				goto cleanup_and_return;
     @@ builtin/mktree.c: static int build_index_from_tree(const struct object_id *oid,
      
       ## t/t1010-mktree.sh ##
      @@ t/t1010-mktree.sh: test_expect_success 'mktree with invalid submodule OIDs' '
     - 	grep "object $tree_oid is a tree but specified type was (commit)" err
     + 	done
       '
       
      -test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
     @@ t/t1010-mktree.sh: test_expect_success 'mktree with base tree' '
      +		printf "100644 blob $blob_oid\ttest/deeper\n"
      +	} |
      +	test_must_fail git mktree 2>err &&
     -+	grep "You have both test and test/deeper" err &&
     ++	test_grep "You have both test and test/deeper" err &&
      +
      +	{
      +		printf "100644 blob $blob_oid\tfolder/one/deeper/deep\n"
      +	} |
      +	test_must_fail git mktree $tree_oid 2>err &&
     -+	grep "You have both folder/one and folder/one/deeper/deep" err
     ++	test_grep "You have both folder/one and folder/one/deeper/deep" err
      +'
      +
       test_done
 16:  a90d6d0c943 ! 17:  d392c440b8a mktree: remove entries when mode is 0
     @@ Commit message
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-mktree.txt ##
     -@@ Documentation/git-mktree.txt: entries nested within one or more directories. These entries are inserted into
     - the appropriate tree in the base tree-ish if one exists. Otherwise, empty parent
     - trees are created to contain the entries.
     +@@ Documentation/git-mktree.txt: entries nested within one or more directories. These entries are inserted
     + into the appropriate tree in the base tree-ish if one exists. Otherwise,
     + empty parent trees are created to contain the entries.
       
     -+An entry with a mode of "0" will remove an entry of the same name from the base
     -+tree-ish. If no tree-ish argument is given, or the entry does not exist in that
     -+tree, the entry is ignored.
     ++An entry with a mode of "0" will remove an entry of the same name from the
     ++base tree-ish. If no tree-ish argument is given, or the entry does not exist
     ++in that tree, the entry is ignored.
      +
     - The order of the tree entries is normalized by `mktree` so pre-sorting the input
     - by path is not required. Multiple entries provided with the same path are
     - deduplicated, with only the last one specified added to the tree.
     + The order of the tree entries is normalized by `mktree` so pre-sorting the
     + input by path is not required. Multiple entries provided with the same path
     + are deduplicated, with only the last one specified added to the tree.
      
       ## builtin/mktree.c ##
      @@ builtin/mktree.c: struct tree_entry {
     @@ builtin/mktree.c: static int build_index_from_tree(const struct object_id *oid,
       		int ret = 0;
       		struct pathspec ps = { 0 };
      @@ builtin/mktree.c: static int mktree_line(unsigned int mode, struct object_id *oid,
     - 		       const char *path, void *cbdata)
     - {
     - 	struct mktree_line_data *data = cbdata;
     --	enum object_type mode_type = object_type(mode);
     --	struct object_info oi = OBJECT_INFO_INIT;
     --	enum object_type parsed_obj_type;
     - 
     --	if (obj_type && mode_type != obj_type)
     --		die("object type (%s) doesn't match mode type (%s)",
     --		    type_name(obj_type), type_name(mode_type));
     -+	if (mode) {
     -+		struct object_info oi = OBJECT_INFO_INIT;
     -+		enum object_type parsed_obj_type;
     -+		enum object_type mode_type = object_type(mode);
     - 
     --	oi.typep = &parsed_obj_type;
     -+		if (obj_type && mode_type != obj_type)
     -+			die("object type (%s) doesn't match mode type (%s)",
     -+			    type_name(obj_type), type_name(mode_type));
     + 	if (stage)
     + 		die(_("path '%s' is unmerged"), path);
       
     --	if (oid_object_info_extended(the_repository, oid, &oi,
     --				     OBJECT_INFO_LOOKUP_REPLACE |
     --				     OBJECT_INFO_QUICK |
     --				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
     --		parsed_obj_type = -1;
     -+		oi.typep = &parsed_obj_type;
     - 
     --	if (parsed_obj_type < 0) {
     --		if (data->allow_missing || S_ISGITLINK(mode)) {
     --			; /* no problem - missing objects & submodules are presumed to be of the right type */
     --		} else {
     --			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
     -+		if (oid_object_info_extended(the_repository, oid, &oi,
     -+					     OBJECT_INFO_LOOKUP_REPLACE |
     -+					     OBJECT_INFO_QUICK |
     -+					     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
     -+			parsed_obj_type = -1;
     ++	/* OID ignored for zero-mode entries; append unconditionally */
     ++	if (!mode)
     ++		goto append_entry;
      +
     -+		if (parsed_obj_type < 0) {
     -+			if (data->allow_missing || S_ISGITLINK(mode)) {
     -+				; /* no problem - missing objects & submodules are presumed to be of the right type */
     -+			} else {
     -+				die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
     -+			}
     -+		} else if (parsed_obj_type != mode_type) {
     -+			/*
     -+			* The object exists but is of the wrong type.
     -+			* This is a problem regardless of allow_missing
     -+			* because the new tree entry will never be correct.
     -+			*/
     -+			die("entry '%s' object %s is a %s but specified type was (%s)",
     -+			path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
     + 	if (obj_type != OBJ_ANY && mode_type != obj_type)
     + 		die("object type (%s) doesn't match mode type (%s)",
     + 		    type_name(obj_type), type_name(mode_type));
     +@@ builtin/mktree.c: static int mktree_line(unsigned int mode, struct object_id *oid,
       		}
     --	} else if (parsed_obj_type != mode_type) {
     --		/*
     --		 * The object exists but is of the wrong type.
     --		 * This is a problem regardless of allow_missing
     --		 * because the new tree entry will never be correct.
     --		 */
     --		die("entry '%s' object %s is a %s but specified type was (%s)",
     --		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
       	}
       
     ++append_entry:
       	append_to_tree(mode, oid, path, data->arr, data->literally);
     + 	return 0;
     + }
      
       ## t/t1010-mktree.sh ##
      @@ t/t1010-mktree.sh: test_expect_success 'mktree fails on directory-file conflict' '
     - 	grep "You have both folder/one and folder/one/deeper/deep" err
     + 	test_grep "You have both folder/one and folder/one/deeper/deep" err
       '
       
      +test_expect_success 'mktree with remove entries' '

-- 
gitgitgadget
