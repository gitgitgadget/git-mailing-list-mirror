Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42FC2D0D3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCB1206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZXMxAFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfLPPsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39727 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfLPPsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id b72so5211313wme.4
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6yWN+udvhMJUK+ZIuestDJzgmxP2crVpiW3pHw4g7fA=;
        b=LZXMxAFbBogX/ZVNQRUUe2yIid7NMx+8I2If7YZp4qUC3ZmTNqVcppGzZIrnl6VYMS
         kPfYxqAkDwVreaTwP/jY6ulvzIQQ15ujrlcYuaQlbv9GmBcsqZS36kc1pKOJliwC4arR
         LMbspEFESRxLzyhmchoTZqFXwha4ySvKeeYIPGYnKxCuHh3Gpq/591Rue8heurMC7rvd
         QOeLXd55ZEgVhs+/SiosWvDT0c2KbGvd2MuOkf94udpin5UMJscvu1AC2dNeOBert/4M
         qtQCqBirSUPapiw1gEkk+yM/rABSWhQ6LAmKBqht6uwYRK1ynyQf+vFHCn3z+bRDzRZw
         9r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6yWN+udvhMJUK+ZIuestDJzgmxP2crVpiW3pHw4g7fA=;
        b=t+U73LXxfHAX+WIIbKlkwa/F46O0TvVVJ154JabGgLENSVB+Tp/zlxsWTWj7EhR18U
         Z0jgaEM40ssLadlgbyb51dfJurfCwd8TjhM+VGj8PWnf8nAY2IP2QqHUkC6jWuHDKNln
         i5YzgWkAlRkzUnpGQZCK3ZeK83qBK44TwWVjaDoWXrN8u1c2UO/r5NGr85HfSETYd/bu
         1JlX38Az85FVrR0U68a3nt+jyihAzmXTDIa1trZDTl4QvZsTyKf0yUZys2miODiO/wF5
         /S9ev/PzNQAAlIRWeul81J3ZOOwFLS4WkmIpFPYNwQSNrxoSPpO/quzu1h61AeHV7KiX
         mOhQ==
X-Gm-Message-State: APjAAAUhaN4lB4fUdoTc/eSLGFT7W1MmhcqbutJiIU1i+1+Kkcd6UEyd
        lqWQ130ZgaHRZFoTWVHfEn6BT/TF
X-Google-Smtp-Source: APXvYqwyLQfalgIXQ6KGkZ6vXLbnZF5L7YDKdmQTmCAU9UYm/VAcs25WjYK1NiQNSK0DDxhb85sj1A==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr32184118wmf.65.1576511288036;
        Mon, 16 Dec 2019 07:48:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm20886630wmd.1.2019.12.16.07.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:07 -0800 (PST)
Message-Id: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:48 +0000
Subject: [PATCH v2 00/18] Extend --pathspec-from-file to git add, checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic continues the effort to support `--pathspec-from-file` in various
commands [1][2]. It also includes some refactorings that I developed while
working on it - previously submitted separately [3][4] which was probably a
mistake.

Anatomy of the branch:
  checkout, restore: support the --pathspec-from-file option
    Extends `--pathspec-from-file` to `git checkout/restore`.

  t2024: cover more cases
    Some new tests for cases that I deemed worthy while working
    on `parse_branchname_arg()` refactoring.

  parse_branchname_arg(): refactor the decision making
  parse_branchname_arg(): update code comments
  parse_branchname_arg(): introduce expect_commit_only
  parse_branchname_arg(): easier to understand variables
    These patches prepare for `|| opts->pathspec_from_file` addition in
    `git checkout/restore` patch. Without this refactoring, I found it
    pretty hard to modify the old code.

  checkout: die() on ambiguous tracking branches
  parse_branchname_arg(): extract part as new function
    Initially I was trying to remove some inconsistency standing in the
    way of `git checkout/restore` patch. Later I figured that this change
    is worthy on its own: it prevents some pretty surprising behavior of
    git.

  doc: restore: synchronize <pathspec> description
  doc: checkout: synchronize <pathspec> description
  doc: checkout: fix broken text reference
  doc: checkout: remove duplicate synopsis
    Some polishing of docs in preparation for `git checkout/restore` patch.

  add: support the --pathspec-from-file option
  cmd_add: prepare for next patch
    Extends `--pathspec-from-file` to `git add`.

  commit: forbid --pathspec-from-file --all
  t7107, t7526: directly test parse_pathspec_file()
    Some polishing of merged topic [1].

CC'ing people who shown interest in any of the previous topics, thanks for
your reviews!

[1] https://public-inbox.org/git/pull.445.git.1572895605.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/20191204203911.237056-1-emilyshaffer@google.com/
[3] https://public-inbox.org/git/pull.477.git.1574848137.gitgitgadget@gmail.com/
[4] https://public-inbox.org/git/pull.479.git.1574969538.gitgitgadget@gmail.com/

Changes since V1:
----------------
@Junio please note that V1 was already substantially different from
what you merged into `next`.

1) Added tests for error scenarios related to --pathspec-from-file.
2) Restored tests for --pathspec-file-nul: they are valuable for every
   command, because they verify that specific commands handle the
   commandline option correctly.
3) Dropped old tests for `git restore` that I forgot to delete when I
   made commit `t7107, t7526: directly test parse_pathspec_file()`.

Alexandr Miloslavskiy (18):
  t7107, t7526: directly test parse_pathspec_file()
  t7526: add tests for error conditions
  t7107: add tests for error conditions
  commit: forbid --pathspec-from-file --all
  cmd_add: prepare for next patch
  add: support the --pathspec-from-file option
  doc: checkout: remove duplicate synopsis
  doc: checkout: fix broken text reference
  doc: checkout: synchronize <pathspec> description
  doc: restore: synchronize <pathspec> description
  parse_branchname_arg(): extract part as new function
  checkout: die() on ambiguous tracking branches
  parse_branchname_arg(): easier to understand variables
  parse_branchname_arg(): introduce expect_commit_only
  parse_branchname_arg(): update code comments
  parse_branchname_arg(): refactor the decision making
  t2024: cover more cases
  checkout, restore: support the --pathspec-from-file option

 Documentation/git-add.txt           |  16 +-
 Documentation/git-checkout.txt      |  50 +++--
 Documentation/git-restore.txt       |  26 ++-
 Makefile                            |   1 +
 builtin/add.c                       |  60 ++++--
 builtin/checkout.c                  | 279 ++++++++++++++--------------
 builtin/commit.c                    |   3 +
 t/helper/test-parse-pathspec-file.c |  34 ++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      |  89 +++++++++
 t/t2024-checkout-dwim.sh            |  55 +++++-
 t/t2026-checkout-pathspec-file.sh   |  90 +++++++++
 t/t2072-restore-pathspec-file.sh    |  91 +++++++++
 t/t3704-add-pathspec-file.sh        |  86 +++++++++
 t/t7107-reset-pathspec-file.sh      |  98 ++--------
 t/t7526-commit-pathspec-file.sh     |  83 +++------
 t/t9902-completion.sh               |   2 +
 18 files changed, 743 insertions(+), 322 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh
 create mode 100755 t/t2026-checkout-pathspec-file.sh
 create mode 100755 t/t2072-restore-pathspec-file.sh
 create mode 100755 t/t3704-add-pathspec-file.sh


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-490%2FSyntevoAlex%2F%230207_pathspec_from_file_2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-490/SyntevoAlex/#0207_pathspec_from_file_2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/490

Range-diff vs v1:

  1:  bfdd7a4b56 !  1:  8d5fb9f40b t7107, t7526: directly test parse_pathspec_file()
     @@ -225,18 +225,14 @@
      -'
      -
      -test_expect_success 'NUL delimiters' '
     --	restore_checkpoint &&
     --
     --	git rm fileA.t fileB.t &&
     --	printf "fileA.t\0fileB.t\0" | git reset --pathspec-from-file=- --pathspec-file-nul &&
     --
     --	cat >expect <<-\EOF &&
     --	 D fileA.t
     --	 D fileB.t
     --	EOF
     --	verify_expect
     --'
     --
     ++test_expect_success '--pathspec-file-nul' '
     + 	restore_checkpoint &&
     + 
     + 	git rm fileA.t fileB.t &&
     +@@
     + 	verify_expect
     + '
     + 
      -test_expect_success 'LF delimiters' '
      -	restore_checkpoint &&
      -
     @@ -361,17 +357,14 @@
      -'
      -
      -test_expect_success 'NUL delimiters' '
     --	restore_checkpoint &&
     --
     --	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
     --
     --	cat >expect <<-\EOF &&
     --	A	fileA.t
     --	A	fileB.t
     --	EOF
     --	verify_expect
     --'
     --
     ++test_expect_success '--pathspec-file-nul' '
     + 	restore_checkpoint &&
     + 
     + 	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
     +@@
     + 	verify_expect
     + '
     + 
      -test_expect_success 'LF delimiters' '
      -	restore_checkpoint &&
      -
  -:  ---------- >  2:  c7cd46d3a3 t7526: add tests for error conditions
  -:  ---------- >  3:  b09d74c347 t7107: add tests for error conditions
  2:  c0980519ed !  4:  deeb860a85 commit: forbid --pathspec-from-file --all
     @@ -20,7 +20,7 @@
      
          [1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)
      
     -    Co-authored-by: Phillip Wood <phillip.wood123@gmail.com>
     +    Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
       diff --git a/builtin/commit.c b/builtin/commit.c
     @@ -36,3 +36,17 @@
       		if (pathspec.nr)
       			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
       
     +
     + diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
     + --- a/t/t7526-commit-pathspec-file.sh
     + +++ b/t/t7526-commit-pathspec-file.sh
     +@@
     + 	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
     + 	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     + 
     ++	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file with \-a does not make sense" err &&
     ++
     + 	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
     + 	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
  3:  3690964942 =  5:  204a0a4446 cmd_add: prepare for next patch
  4:  0328fdafbb !  6:  1ea5f17847 add: support the --pathspec-from-file option
     @@ -156,6 +156,18 @@
      +	verify_expect
      +'
      +
     ++test_expect_success '--pathspec-file-nul' '
     ++	restore_checkpoint &&
     ++
     ++	printf "fileA.t\0fileB.t\0" | git add --pathspec-from-file=- --pathspec-file-nul &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	A  fileA.t
     ++	A  fileB.t
     ++	EOF
     ++	verify_expect
     ++'
     ++
      +test_expect_success 'only touches what was listed' '
      +	restore_checkpoint &&
      +
     @@ -168,4 +180,29 @@
      +	verify_expect
      +'
      +
     ++test_expect_success 'error conditions' '
     ++	restore_checkpoint &&
     ++	echo fileA.t >list &&
     ++	>empty_list &&
     ++
     ++	test_must_fail git add --pathspec-from-file=- --interactive <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     ++
     ++	test_must_fail git add --pathspec-from-file=- --patch <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     ++
     ++	test_must_fail git add --pathspec-from-file=- --edit <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-edit" err &&
     ++
     ++	test_must_fail git add --pathspec-from-file=- -- fileA.t <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++
     ++	test_must_fail git add --pathspec-file-nul 2>err &&
     ++	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
     ++	
     ++	# This case succeeds, but still prints to stderr
     ++	git add --pathspec-from-file=- <empty_list 2>err &&
     ++	test_i18ngrep "Nothing specified, nothing added." err
     ++'
     ++
      +test_done
  5:  8677db4b9e =  7:  3d0fcf6ba5 doc: checkout: remove duplicate synopsis
  6:  2d87b6433b =  8:  85f7ccc4e0 doc: checkout: fix broken text reference
  7:  6288a7fa36 =  9:  db6e40d004 doc: checkout: synchronize <pathspec> description
  8:  d2f277bb58 = 10:  c88cbf453a doc: restore: synchronize <pathspec> description
  9:  891d1b91cf = 11:  2c23bd602d parse_branchname_arg(): extract part as new function
 10:  271e8ed3ab = 12:  efd6876874 checkout: die() on ambiguous tracking branches
 11:  a0a884b384 = 13:  2498825230 parse_branchname_arg(): easier to understand variables
 12:  a6b77f9b23 = 14:  2350dc282e parse_branchname_arg(): introduce expect_commit_only
 13:  4e2bb6663c = 15:  46f676b8e0 parse_branchname_arg(): update code comments
 14:  010fd76331 = 16:  319151e4e9 parse_branchname_arg(): refactor the decision making
 15:  ffbc405920 = 17:  542eb709ca t2024: cover more cases
 16:  9af2de98de ! 18:  c293d72832 checkout, restore: support the --pathspec-from-file option
     @@ -218,6 +218,18 @@
      +	verify_expect
      +'
      +
     ++test_expect_success '--pathspec-file-nul' '
     ++	restore_checkpoint &&
     ++
     ++	printf "fileA.t\0fileB.t\0" | git checkout --pathspec-from-file=- --pathspec-file-nul HEAD^1 &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	M  fileA.t
     ++	M  fileB.t
     ++	EOF
     ++	verify_expect
     ++'
     ++
      +test_expect_success 'only touches what was listed' '
      +	restore_checkpoint &&
      +
     @@ -230,6 +242,23 @@
      +	verify_expect
      +'
      +
     ++test_expect_success 'error conditions' '
     ++	restore_checkpoint &&
     ++	echo fileA.t >list &&
     ++
     ++	test_must_fail git checkout --pathspec-from-file=- --detach <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-detach" err &&
     ++
     ++	test_must_fail git checkout --pathspec-from-file=- --patch <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-patch" err &&
     ++
     ++	test_must_fail git checkout --pathspec-from-file=- -- fileA.t <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++
     ++	test_must_fail git checkout --pathspec-file-nul 2>err &&
     ++	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err
     ++'
     ++
      +test_done
      
       diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
     @@ -274,7 +303,7 @@
      +	test_cmp expect actual
      +}
      +
     -+test_expect_success '--pathspec-from-file from stdin' '
     ++test_expect_success 'simplest' '
      +	restore_checkpoint &&
      +
      +	echo fileA.t | git restore --pathspec-from-file=- --source=HEAD^1 &&
     @@ -285,19 +314,7 @@
      +	verify_expect
      +'
      +
     -+test_expect_success '--pathspec-from-file from file' '
     -+	restore_checkpoint &&
     -+
     -+	echo fileA.t >list &&
     -+	git restore --pathspec-from-file=list --source=HEAD^1 &&
     -+
     -+	cat >expect <<-\EOF &&
     -+	 M fileA.t
     -+	EOF
     -+	verify_expect
     -+'
     -+
     -+test_expect_success 'NUL delimiters' '
     ++test_expect_success '--pathspec-file-nul' '
      +	restore_checkpoint &&
      +
      +	printf "fileA.t\0fileB.t\0" | git restore --pathspec-from-file=- --pathspec-file-nul --source=HEAD^1 &&
     @@ -309,70 +326,34 @@
      +	verify_expect
      +'
      +
     -+test_expect_success 'LF delimiters' '
     -+	restore_checkpoint &&
     -+
     -+	printf "fileA.t\nfileB.t\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     -+
     -+	cat >expect <<-\EOF &&
     -+	 M fileA.t
     -+	 M fileB.t
     -+	EOF
     -+	verify_expect
     -+'
     -+
     -+test_expect_success 'no trailing delimiter' '
     -+	restore_checkpoint &&
     -+
     -+	printf "fileA.t\nfileB.t" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     -+
     -+	cat >expect <<-\EOF &&
     -+	 M fileA.t
     -+	 M fileB.t
     -+	EOF
     -+	verify_expect
     -+'
     -+
     -+test_expect_success 'CRLF delimiters' '
     ++test_expect_success 'only touches what was listed' '
      +	restore_checkpoint &&
      +
     -+	printf "fileA.t\r\nfileB.t\r\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     ++	printf "fileB.t\nfileC.t\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
      +
      +	cat >expect <<-\EOF &&
     -+	 M fileA.t
      +	 M fileB.t
     ++	 M fileC.t
      +	EOF
      +	verify_expect
      +'
      +
     -+test_expect_success 'quotes' '
     -+	restore_checkpoint &&
     -+
     -+	printf "\"file\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     -+
     -+	cat >expect <<-\EOF &&
     -+	 M fileA.t
     -+	EOF
     -+	verify_expect
     -+'
     -+
     -+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
     ++test_expect_success 'error conditions' '
      +	restore_checkpoint &&
     ++	echo fileA.t >list &&
     ++	>empty_list &&
      +
     -+	printf "\"file\\101.t\"" >list &&
     -+	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
     -+'
     ++	test_must_fail git restore --pathspec-from-file=- --patch --source=HEAD^1 <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-patch" err &&
      +
     -+test_expect_success 'only touches what was listed' '
     -+	restore_checkpoint &&
     ++	test_must_fail git restore --pathspec-from-file=- --source=HEAD^1 -- fileA.t <list 2>err &&
     ++	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
      +
     -+	printf "fileB.t\nfileC.t\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     ++	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
     ++	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
      +
     -+	cat >expect <<-\EOF &&
     -+	 M fileB.t
     -+	 M fileC.t
     -+	EOF
     -+	verify_expect
     ++	test_must_fail git restore --pathspec-from-file=- --source=HEAD^1 <empty_list 2>err &&
     ++	test_i18ngrep "you must specify path(s) to restore" err
      +'
      +
      +test_done

-- 
gitgitgadget
