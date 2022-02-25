Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B8EC433FE
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiBYTbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiBYTb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:31:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729F1D0365
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j22so5912628wrb.13
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Bd9ku/ntE8A5dqvKW+1LIgn5IMrPmCd+9WdN2lRO83g=;
        b=ih714ye49/bAjObup8mCmnKCEYgb/fhRT1qE2Lyugrt32FqUS8GHAMXrpr5AhJGzIe
         6Z6+7mShDbkJRPDBQ6rPut2C03aD7PGqo6oSZl8PI3T++A15bQdHv9Lcjsd1YgkFrpqG
         IHOOKXvxn9W5RFZJe/b5+c+dmsXZNivZAiYHtp5mYeM0oo3x1JaumqlkuVZcgTOp8v49
         qaRgUlOUTajacylR8mKGGVDHF2wU6opGrATidAapEkyZQ4Tr3v2t0DjHFWJbEnTLl3rB
         vfRBoE7BXomhnobpUdnvF1raoD8aQX+Cl5dFbdmEpzTiRIY2LcAbexGWtrfn8bk5F3aJ
         qvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Bd9ku/ntE8A5dqvKW+1LIgn5IMrPmCd+9WdN2lRO83g=;
        b=x5Zv56zxdWgdx22H4zT2fhniK6AJhuxeH85etuXh/+Llrayqf31QFDJQgF0sUeGxFW
         jt8+1iz5myPEVICKQ5cwhoL8bP/bO7ZQOEMpPMeCMCSljuwDwaocdhUeZeJigZyd5ZE/
         Dp0yae6ItjpcjAViacuuVSgGaWkyNCqKlbQP27632dgM64/N2eq4n/ISwngVI7GHVN81
         4PrJAKbnhMWsQRFMManhzAagBXAf8hKrHlat4LWQBNkquVhJwCfNA1Gkw08GCa2wVbk8
         QF98lQuaa0Wx1u+b77P87uYMZRouSaj9v4fXcxnnyFveynsANxHI9/siQBiqRccBxdt9
         ylVA==
X-Gm-Message-State: AOAM5315nS0nM33Tq5JZfn0Xl+1eNdqR70QoAqgqITWbfttTjQc6kvhU
        AzN7yF4sIAaWldZsvyToX66xPeYybGc=
X-Google-Smtp-Source: ABdhPJwc1SgAZP1shOmsfD+ZN1kf0fpvQ9vM479vlJENRhJY8XXU7SuZepQ121jPwOA+zKyvoTDAGw==
X-Received: by 2002:adf:c3cc:0:b0:1ed:b641:6ee2 with SMTP id d12-20020adfc3cc000000b001edb6416ee2mr7207590wrg.529.1645817453394;
        Fri, 25 Feb 2022 11:30:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5228000000b001ea76210986sm3023012wra.58.2022.02.25.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:30:52 -0800 (PST)
Message-Id: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 19:30:49 +0000
Subject: [PATCH v3 0/3] libify reflog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], there was a discussion around a bug report of stash not recovering
in the middle of the process when killed with ctl-c. It turned out to not be
a bug we need to fix. However, out of that discussion came the idea of
libifying reflog. This can stand alone as a code improvement.

stash.c currently shells out to call reflog to delete reflogs. Libify reflog
delete and call it from both builtin/reflog.c and builtin/stash.c.

This patch has three parts:

 * add missing test coverage for git stash delete
 * libify reflog's delete functionality and move some of the helpers into a
   reflog.c library and call reflog_delete from builtin/reflog.c
 * call reflog_delete from builtin/stash.c

Updates since v2:

 * removed unnecessary includes
 * adjusted wrapping/whitespace in reflog.h
 * adjusted test to be isolated from other tests since currently tests for
   stash depend on each other. There was some discussion around this and
   even a possibility to refactor the tests. However, it would have been a
   larger effort than is worth for this series, so instead I just made one
   of the tests I added be isolated from the others.

Updates since v1:

 * added missing test coverage
 * squashed 1/3 and 2/3 together
 * moved enum into reflog.c
 * updated object.h's flag allocation mapping

 1. https://lore.kernel.org/git/220126.86h79qe692.gmgdl@evledraar.gmail.com/

John Cai (3):
  stash: add tests to ensure reflog --rewrite --updatref behavior
  reflog: libify delete reflog function and helpers
  stash: call reflog_delete() in reflog.c

 Makefile         |   1 +
 builtin/reflog.c | 455 +----------------------------------------------
 builtin/stash.c  |  18 +-
 object.h         |   2 +-
 reflog.c         | 432 ++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  43 +++++
 t/t3903-stash.sh |  65 +++++--
 7 files changed, 539 insertions(+), 477 deletions(-)
 create mode 100644 reflog.c
 create mode 100644 reflog.h


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1218%2Fjohn-cai%2Fjc-libify-reflog-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1218/john-cai/jc-libify-reflog-v3
Pull-Request: https://github.com/git/git/pull/1218

Range-diff vs v2:

 1:  6e136b62ca4 ! 1:  33299825fc4 stash: add test to ensure reflog --rewrite --updatref behavior
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    stash: add test to ensure reflog --rewrite --updatref behavior
     +    stash: add tests to ensure reflog --rewrite --updatref behavior
      
          There is missing test coverage to ensure that the resulting reflogs
          after a git stash drop has had its old oid rewritten if applicable, and
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## t/t3903-stash.sh ##
     +@@ t/t3903-stash.sh: diff_cmp () {
     + 	rm -f "$1.compare" "$2.compare"
     + }
     + 
     +-test_expect_success 'stash some dirty working directory' '
     +-	echo 1 >file &&
     +-	git add file &&
     +-	echo unrelated >other-file &&
     +-	git add other-file &&
     ++setup_stash() {
     ++	repo_dir=$1
     ++	if test -z $repo_dir; then
     ++		repo_dir="."
     ++	fi
     ++
     ++	echo 1 >$repo_dir/file &&
     ++	git -C $repo_dir add file &&
     ++	echo unrelated >$repo_dir/other-file &&
     ++	git -C $repo_dir add other-file &&
     + 	test_tick &&
     +-	git commit -m initial &&
     +-	echo 2 >file &&
     ++	git -C $repo_dir commit -m initial &&
     ++	echo 2 >$repo_dir/file &&
     + 	git add file &&
     +-	echo 3 >file &&
     ++	echo 3 >$repo_dir/file &&
     + 	test_tick &&
     +-	git stash &&
     +-	git diff-files --quiet &&
     +-	git diff-index --cached --quiet HEAD
     ++	git -C $repo_dir stash &&
     ++	git -C $repo_dir diff-files --quiet &&
     ++	git -C $repo_dir diff-index --cached --quiet HEAD
     ++}
     ++
     ++test_expect_success 'stash some dirty working directory' '
     ++	setup_stash
     + '
     + 
     + cat >expect <<EOF
      @@ t/t3903-stash.sh: test_expect_success 'drop middle stash by index' '
       	test 1 = $(git show HEAD:file)
       '
     @@ t/t3903-stash.sh: test_expect_success 'drop middle stash by index' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
     -+	git reset --hard &&
     -+	echo 9 >file &&
     -+	git stash &&
     -+	oid="$(git rev-parse stash@{0})" &&
     -+	git stash drop stash@{1} &&
     -+	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
     ++test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
     ++	git init repo &&
     ++	setup_stash repo &&
     ++	echo 9 >repo/file &&
     ++
     ++	old_oid="$(git -C repo rev-parse stash@{0})" &&
     ++	git -C repo stash &&
     ++	new_oid="$(git -C repo rev-parse stash@{0})" &&
     ++
     ++	cat >expect <<-EOF &&
     ++	$(test_oid zero) $old_oid
     ++	$old_oid $new_oid
     ++	EOF
     ++	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	git -C repo stash drop stash@{1} &&
     ++	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
      +	cat >expect <<-EOF &&
     -+	$(test_oid zero) $oid
     ++	$(test_oid zero) $new_oid
      +	EOF
      +	test_cmp expect actual
      +'
     @@ t/t3903-stash.sh: test_expect_success 'drop middle stash by index' '
       test_expect_success 'stash pop' '
       	git reset --hard &&
       	git stash pop &&
     --	test 3 = $(cat file) &&
     -+	test 9 = $(cat file) &&
     - 	test 1 = $(git show :file) &&
     - 	test 1 = $(git show HEAD:file) &&
     - 	test 0 = $(git stash list | wc -l)
 2:  e7c950218b1 ! 2:  33adfee4ca6 reflog: libify delete reflog function and helpers
     @@ builtin/reflog.c
      @@
       #include "builtin.h"
       #include "config.h"
     - #include "lockfile.h"
     +-#include "lockfile.h"
      -#include "object-store.h"
     - #include "repository.h"
     +-#include "repository.h"
      -#include "commit.h"
      -#include "refs.h"
     - #include "dir.h"
     +-#include "dir.h"
      -#include "tree-walk.h"
     - #include "diff.h"
     +-#include "diff.h"
       #include "revision.h"
       #include "reachable.h"
       #include "worktree.h"
     @@ object.h: struct object_array {
       ## reflog.c (new) ##
      @@
      +#include "cache.h"
     -+#include "commit.h"
      +#include "object-store.h"
     -+#include "reachable.h"
      +#include "reflog.h"
      +#include "refs.h"
      +#include "revision.h"
     -+#include "tree-walk.h"
      +#include "worktree.h"
      +
      +/* Remember to update object flag allocation in object.h */
     @@ reflog.h (new)
      @@
      +#ifndef REFLOG_H
      +#define REFLOG_H
     -+
      +#include "refs.h"
      +
      +struct cmd_reflog_expire_cb {
     @@ reflog.h (new)
      +	unsigned int dry_run:1;
      +};
      +
     -+int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose);
     -+
     ++int reflog_delete(const char *rev, enum expire_reflog_flags flags,
     ++		  int verbose);
      +void reflog_expiry_cleanup(void *cb_data);
     -+
      +void reflog_expiry_prepare(const char *refname, const struct object_id *oid,
      +			   void *cb_data);
     -+
      +int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
      +			     const char *email, timestamp_t timestamp, int tz,
      +			     const char *message, void *cb_data);
     -+
      +int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
      +		     const char *email, timestamp_t timestamp, int tz,
      +		     const char *message, void *cb_data);
     -+
      +int should_expire_reflog_ent_verbose(struct object_id *ooid,
      +				     struct object_id *noid,
      +				     const char *email,
      +				     timestamp_t timestamp, int tz,
      +				     const char *message, void *cb_data);
     -+
      +#endif /* REFLOG_H */
 3:  a023a70092b = 3:  b17d8e5d43a stash: call reflog_delete() in reflog.c

-- 
gitgitgadget
