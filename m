Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F6C2D0D2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510820716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skTUSFFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLSSCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:01 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43345 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSSCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:01 -0500
Received: by mail-ed1-f50.google.com with SMTP id dc19so5755328edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TN2zuFk9trC6EDlJ7m37ODMpOaNuYVJ74AlNoAKXJpY=;
        b=skTUSFFrhpDHf+BHubX/6Gt6bOk4SVvelzLhV5fyLpp5MBcAi21h1o/A70bCHvQ99X
         SETqEhJSqe4I+5BWsCvsUUgWX05y1hNJ7SdkRsoag94hN9RGbaA4Gpj+IkcTuXpptghZ
         nZ5IoSPJAxoku8SJ9ui3UqAqUguUEGP5KaErHDwn7njOasKHBb5HukgwqxCx4axOP8db
         O5NJSkZ7hULbX44TrJ3OwGk8IFNBleB/aVljQZZYnj3TmTNOietItS3+oepguCIU7vRo
         Q8H+VUIsCrZnWvRXb+gMKTBt3J6hvPzEYwOQo85/P1ky9EY9cGNQYNVRTK9P3tsXGlq0
         QIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TN2zuFk9trC6EDlJ7m37ODMpOaNuYVJ74AlNoAKXJpY=;
        b=B3f+k8YGaCBoaNR0fwP1NNE2B/YK5TdOVNob9BD2BLlqwyPN+gqAaZDD0mssQDl/LP
         R9X+SyRT2sIHZKi3uPnNY8Hvk1qvr4ZRkmP81Pvx7FaZB5XecTUC1Shx/T/li7gEVdvo
         Ikuak2slLG3hAkcOmFqYSkRXogdH3zVc2rdtuRVpcsG46T1xYYhpjzbw64qqFDwJvIxB
         I0E3mr7IofQscdcs5QxGxZRiyGOGWWl5nbn4VndlZIR9r8AB+g7y42Drm5LPX4Gf3mj4
         KbqXJTFc1fzIHnrqqqB9z1lDcdoB5iZzVzq/SzwRJX71FYgjgiMDbuKyVHqv4QyryCGU
         ofaQ==
X-Gm-Message-State: APjAAAWu7/iFWa5s3Ht+RlgUsf/z2MZ/ZAjYE7Hm6VxWsW8XyNhXJ21v
        uj1jp95bQHX357oMLNIXmWR1oEFe
X-Google-Smtp-Source: APXvYqzSN98JsZtpkeZM/xVL+BFm/LOTBjle/u8PrDnuxPQhhyh5EcSoZwiweNQjrjpQdGGAPfT+3g==
X-Received: by 2002:a17:906:260b:: with SMTP id h11mr10861854ejc.327.1576778516706;
        Thu, 19 Dec 2019 10:01:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dx7sm642190ejb.81.2019.12.19.10.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:01:56 -0800 (PST)
Message-Id: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:37 +0000
Subject: [PATCH v3 00/18] Extend --pathspec-from-file to git add, checkout
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

Changes since V2:
----------------
Rebased branch on top of modern master.
Improved code according to code review suggestions in [4] and this topic:
1) Shuffled changes between `parse_branchname_arg()` commits
2) New commit `parse_branchname_arg(): simplify argument eating` with a detailed commit message.
3) Further improved commit `parse_branchname_arg(): easier to understand variables`
4) Fixed an oversight where after refactoring, `parse_branchname_arg()` could eat `--` in `git switch` - this is more of a theoretical problem because `--` is not expected there anyway.
5) Changed aggressive `\-\-` escaping in tests to use `test_i18ngrep -e` instead

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
  parse_branchname_arg(): simplify argument eating
  parse_branchname_arg(): update code comments
  parse_branchname_arg(): refactor the decision making
  t2024: cover more cases
  checkout, restore: support the --pathspec-from-file option

 Documentation/git-add.txt           |  16 +-
 Documentation/git-checkout.txt      |  50 +++--
 Documentation/git-restore.txt       |  26 ++-
 Makefile                            |   1 +
 builtin/add.c                       |  60 ++++--
 builtin/checkout.c                  | 277 ++++++++++++++--------------
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
 18 files changed, 742 insertions(+), 321 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh
 create mode 100755 t/t2026-checkout-pathspec-file.sh
 create mode 100755 t/t2072-restore-pathspec-file.sh
 create mode 100755 t/t3704-add-pathspec-file.sh


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-490%2FSyntevoAlex%2F%230207_pathspec_from_file_2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-490/SyntevoAlex/#0207_pathspec_from_file_2-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/490

Range-diff vs v2:

  1:  8d5fb9f40b =  1:  8526d1d805 t7107, t7526: directly test parse_pathspec_file()
  2:  c7cd46d3a3 !  2:  14d30dd0e1 t7526: add tests for error conditions
     @@ -18,22 +18,22 @@
      +	>empty_list &&
      +
      +	test_must_fail git commit --pathspec-from-file=- --interactive -m "Commit" <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
      +
      +	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
      +
      +	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      +
      +	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
     -+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
     ++	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
      +
      +	test_must_fail git commit --pathspec-from-file=- --include -m "Commit" <empty_list 2>err &&
     -+	test_i18ngrep "No paths with \-\-include/\-\-only does not make sense." err &&
     ++	test_i18ngrep -e "No paths with --include/--only does not make sense." err &&
      +
      +	test_must_fail git commit --pathspec-from-file=- --only -m "Commit" <empty_list 2>err &&
     -+	test_i18ngrep "No paths with \-\-include/\-\-only does not make sense." err
     ++	test_i18ngrep -e "No paths with --include/--only does not make sense." err
      +'
      +
       test_done
  3:  b09d74c347 !  3:  b1cc4a960d t7107: add tests for error conditions
     @@ -17,13 +17,13 @@
      +	echo fileA.t >list &&
      +
      +	test_must_fail git reset --pathspec-from-file=- --patch <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
      +
      +	test_must_fail git reset --pathspec-from-file=- -- fileA.t <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      +
      +	test_must_fail git reset --pathspec-file-nul 2>err &&
     -+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err
     ++	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
      +'
      +
       test_done
  4:  deeb860a85 !  4:  f0be90601e commit: forbid --pathspec-from-file --all
     @@ -42,11 +42,11 @@
       +++ b/t/t7526-commit-pathspec-file.sh
      @@
       	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
     - 	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
       
      +	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file with \-a does not make sense" err &&
     ++	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
      +
       	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
     - 	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
       
  5:  204a0a4446 =  5:  2153350ac4 cmd_add: prepare for next patch
  6:  1ea5f17847 !  6:  c8e59903f7 add: support the --pathspec-from-file option
     @@ -186,23 +186,23 @@
      +	>empty_list &&
      +
      +	test_must_fail git add --pathspec-from-file=- --interactive <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
      +
      +	test_must_fail git add --pathspec-from-file=- --patch <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
      +
      +	test_must_fail git add --pathspec-from-file=- --edit <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-edit" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --edit" err &&
      +
      +	test_must_fail git add --pathspec-from-file=- -- fileA.t <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      +
      +	test_must_fail git add --pathspec-file-nul 2>err &&
     -+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
     ++	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
      +	
      +	# This case succeeds, but still prints to stderr
      +	git add --pathspec-from-file=- <empty_list 2>err &&
     -+	test_i18ngrep "Nothing specified, nothing added." err
     ++	test_i18ngrep -e "Nothing specified, nothing added." err
      +'
      +
      +test_done
  7:  3d0fcf6ba5 =  7:  5a4a538fa6 doc: checkout: remove duplicate synopsis
  8:  85f7ccc4e0 =  8:  daf0d6c536 doc: checkout: fix broken text reference
  9:  db6e40d004 =  9:  1d981b199f doc: checkout: synchronize <pathspec> description
 10:  c88cbf453a = 10:  137b697327 doc: restore: synchronize <pathspec> description
 11:  2c23bd602d = 11:  f53bb13e43 parse_branchname_arg(): extract part as new function
 12:  efd6876874 = 12:  58b65d2011 checkout: die() on ambiguous tracking branches
 14:  2350dc282e ! 13:  dd35cad0d9 parse_branchname_arg(): introduce expect_commit_only
     @@ -1,8 +1,13 @@
      Author: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     -    parse_branchname_arg(): introduce expect_commit_only
     +    parse_branchname_arg(): easier to understand variables
      
     -    `has_dash_dash` unexpectedly takes `opts->accept_pathspec` into account.
     +    `dash_dash_pos` was only calculated under `opts->accept_pathspec`. This
     +    is unexpected to readers and made it harder to reason about the code.
     +
     +    Fix this by restoring the expected meaning.
     +
     +    `has_dash_dash` also takes `opts->accept_pathspec` into account.
          While this may sound clever at first sight, it becomes pretty hard to
          reason (and not be a victim) about code, especially in combination with
          `argc` here:
     @@ -12,10 +17,11 @@
                      opts->accept_pathspec)
                          recover_with_dwim = 0;
      
     -    Introduce a new non-obfuscated variable to reduce the amount of diffs in
     -    next patch.
     +    Fix this by giving variable a better name and rewriting the above
     +    mentioned condition (it's easier to verify if you notice that it only
     +    holds when `opts->accept_pathspec` is true).
      
     -    This should not change behavior in any way.
     +    This patch is not expected to change behavior in any way.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     @@ -23,23 +29,49 @@
       --- a/builtin/checkout.c
       +++ b/builtin/checkout.c
      @@
     - 	const char **new_branch = &opts->new_branch;
     + 	int argcount = 0;
       	const char *arg;
       	int dash_dash_pos;
      -	int has_dash_dash = 0;
     -+	int has_dash_dash = 0, expect_commit_only = 0;
     ++	int arg0_cant_be_pathspec = 0;
       	int i;
       
       	/*
      @@
     - 		    die(_("only one reference expected, %d given."), dash_dash_pos);
     + 	if (!opts->accept_pathspec) {
     + 		if (argc > 1)
     + 			die(_("only one reference expected"));
     +-		has_dash_dash = 1; /* helps disambiguate */
     ++		arg0_cant_be_pathspec = 1;
       	}
       
     + 	arg = argv[0];
     + 	dash_dash_pos = -1;
     + 	for (i = 0; i < argc; i++) {
     +-		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
     ++		if (!strcmp(argv[i], "--")) {
     + 			dash_dash_pos = i;
     + 			break;
     + 		}
     + 	}
     +-	if (dash_dash_pos == 0)
     +-		return 1; /* case (2) */
     +-	else if (dash_dash_pos == 1)
     +-		has_dash_dash = 1; /* case (3) or (1) */
     +-	else if (dash_dash_pos >= 2)
     +-		die(_("only one reference expected, %d given."), dash_dash_pos);
      -	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
     -+	if (has_dash_dash)
     -+	    expect_commit_only = 1;
      +
     -+	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
     ++	if (opts->accept_pathspec) {
     ++		if (dash_dash_pos == 0)
     ++			return 1; /* case (2) */
     ++		else if (dash_dash_pos == 1)
     ++			arg0_cant_be_pathspec = 1; /* case (3) or (1) */
     ++		else if (dash_dash_pos >= 2)
     ++			die(_("only one reference expected, %d given."), dash_dash_pos);
     ++	}
     ++
     ++	opts->count_checkout_paths = !opts->quiet && !arg0_cant_be_pathspec;
       
       	if (!strcmp(arg, "-"))
       		arg = "@{-1}";
     @@ -48,29 +80,39 @@
       		int recover_with_dwim = dwim_new_local_branch_ok;
       
      -		int could_be_checkout_paths = !has_dash_dash &&
     -+		int could_be_checkout_paths = !expect_commit_only &&
     ++		int could_be_checkout_paths = !arg0_cant_be_pathspec &&
       			check_filename(opts->prefix, arg);
       
      -		if (!has_dash_dash && !no_wildcard(arg))
     -+		if (!expect_commit_only && !no_wildcard(arg))
     ++		if (!arg0_cant_be_pathspec && !no_wildcard(arg))
       			recover_with_dwim = 0;
       
       		/*
     + 		 * Accept "git checkout foo", "git checkout foo --"
     + 		 * and "git switch foo" as candidates for dwim.
     + 		 */
     +-		if (!(argc == 1 && !has_dash_dash) &&
     +-		    !(argc == 2 && has_dash_dash) &&
     ++		if (!(argc == 1 && dash_dash_pos == -1) &&
     ++		    !(argc == 2 && dash_dash_pos == 1) &&
     + 		    opts->accept_pathspec)
     + 			recover_with_dwim = 0;
     + 
      @@
       		}
       
       		if (!recover_with_dwim) {
      -			if (has_dash_dash)
     -+			if (expect_commit_only)
     ++			if (arg0_cant_be_pathspec)
       				die(_("invalid reference: %s"), arg);
     - 			return 0;
     + 			return argcount;
       		}
      @@
       	if (!opts->source_tree)                   /* case (1): want a tree */
       		die(_("reference is not a tree: %s"), arg);
       
      -	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
     -+	if (!expect_commit_only) {	/* case (3).(d) -> (1) */
     ++	if (!arg0_cant_be_pathspec) {	/* case (3).(d) -> (1) */
       		/*
       		 * Do not complain the most common case
       		 *	git checkout branch
 13:  2498825230 ! 14:  dc6e351796 parse_branchname_arg(): easier to understand variables
     @@ -1,15 +1,27 @@
      Author: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     -    parse_branchname_arg(): easier to understand variables
     +    parse_branchname_arg(): simplify argument eating
      
     -    `dash_dash_pos` was only calculated under `opts->accept_pathspec`. This
     -    is unexpected to readers and made it harder to reason about the code.
     -    Fix this by restoring the expected meaning.
     +    This patch abolishes two pieces of obfuscated code.
      
     -    Simplify the code by dropping `argcount` and useless `argc` / `argv`
     -    manipulations.
     +    First is `if (argc)` condition, which in fact means "more then one arg"
     +    due to `argc++` above.
      
     -    This should not change behavior in any way.
     +    Second is by far harder to grasp:
     +        if (!arg0_cant_be_pathspec) {...} else if (opts->accept_pathspec)
     +    that is,
     +            if (opts->accept_pathspec && arg0_cant_be_pathspec)
     +    which (quite unexpectedly) actually means
     +        if (opts->accept_pathspec && dash_dash_pos == 1)
     +    and aims to "eat" that `--`.
     +
     +    Make both pieces easier to read by rewriting obfuscated conditions.
     +
     +    With both solved, I could keep argcount++/argv++/argc-- in the very end
     +    of the function, but that was obviously useless code in this case, so I
     +    deleted them as well.
     +
     +    This patch is not expected to change behavior in any way.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     @@ -23,39 +35,10 @@
      -	int argcount = 0;
       	const char *arg;
       	int dash_dash_pos;
     - 	int has_dash_dash = 0;
     -@@
     - 	arg = argv[0];
     - 	dash_dash_pos = -1;
     - 	for (i = 0; i < argc; i++) {
     --		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
     -+		if (!strcmp(argv[i], "--")) {
     - 			dash_dash_pos = i;
     - 			break;
     - 		}
     - 	}
     --	if (dash_dash_pos == 0)
     --		return 1; /* case (2) */
     --	else if (dash_dash_pos == 1)
     --		has_dash_dash = 1; /* case (3) or (1) */
     --	else if (dash_dash_pos >= 2)
     --		die(_("only one reference expected, %d given."), dash_dash_pos);
     -+
     -+	if (opts->accept_pathspec) {
     -+	    if (dash_dash_pos == 0)
     -+		    return 1; /* case (2) */
     -+	    else if (dash_dash_pos == 1)
     -+		    has_dash_dash = 1; /* case (3) or (1) */
     -+	    else if (dash_dash_pos >= 2)
     -+		    die(_("only one reference expected, %d given."), dash_dash_pos);
     -+	}
     -+
     - 	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
     - 
     - 	if (!strcmp(arg, "-"))
     + 	int arg0_cant_be_pathspec = 0;
      @@
       		if (!recover_with_dwim) {
     - 			if (has_dash_dash)
     + 			if (arg0_cant_be_pathspec)
       				die(_("invalid reference: %s"), arg);
      -			return argcount;
      +			return 0;
     @@ -84,7 +67,7 @@
       	}
       
      -	return argcount;
     -+	return (dash_dash_pos == 1) ? 2 : 1;
     ++	return (opts->accept_pathspec && dash_dash_pos == 1) ? 2 : 1;
       }
       
       static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 15:  46f676b8e0 ! 15:  7989f0c5cf parse_branchname_arg(): update code comments
     @@ -80,14 +80,14 @@
      @@
       
       	if (opts->accept_pathspec) {
     - 	    if (dash_dash_pos == 0)
     --		    return 1; /* case (2) */
     -+		    return 1;
     - 	    else if (dash_dash_pos == 1)
     --		    has_dash_dash = 1; /* case (3) or (1) */
     -+		    has_dash_dash = 1;
     - 	    else if (dash_dash_pos >= 2)
     - 		    die(_("only one reference expected, %d given."), dash_dash_pos);
     + 		if (dash_dash_pos == 0)
     +-			return 1; /* case (2) */
     ++			return 1;
     + 		else if (dash_dash_pos == 1)
     +-			arg0_cant_be_pathspec = 1; /* case (3) or (1) */
     ++			arg0_cant_be_pathspec = 1;
     + 		else if (dash_dash_pos >= 2)
     + 			die(_("only one reference expected, %d given."), dash_dash_pos);
       	}
      @@
       		arg = "@{-1}";
     @@ -103,17 +103,17 @@
      -		 */
       		int recover_with_dwim = dwim_new_local_branch_ok;
       
     - 		int could_be_checkout_paths = !expect_commit_only &&
     + 		int could_be_checkout_paths = !arg0_cant_be_pathspec &&
      @@
     - 		if (!expect_commit_only && !no_wildcard(arg))
     + 		if (!arg0_cant_be_pathspec && !no_wildcard(arg))
       			recover_with_dwim = 0;
       
      -		/*
      -		 * Accept "git checkout foo", "git checkout foo --"
      -		 * and "git switch foo" as candidates for dwim.
      -		 */
     - 		if (!(argc == 1 && !has_dash_dash) &&
     - 		    !(argc == 2 && has_dash_dash) &&
     + 		if (!(argc == 1 && dash_dash_pos == -1) &&
     + 		    !(argc == 2 && dash_dash_pos == 1) &&
       		    opts->accept_pathspec)
      @@
       			if (remote) {
     @@ -132,7 +132,7 @@
      +	if (!opts->source_tree)
       		die(_("reference is not a tree: %s"), arg);
       
     --	if (!expect_commit_only) {	/* case (3).(d) -> (1) */
     +-	if (!arg0_cant_be_pathspec) {	/* case (3).(d) -> (1) */
      -		/*
      -		 * Do not complain the most common case
      -		 *	git checkout branch
     @@ -142,8 +142,8 @@
      -		if (argc > 1)
      -			verify_non_filename(opts->prefix, arg);
      -	}
     -+	if (!expect_commit_only && argc > 1)
     ++	if (!arg0_cant_be_pathspec && argc > 1)
      +		verify_non_filename(opts->prefix, arg);
       
     - 	return (dash_dash_pos == 1) ? 2 : 1;
     + 	return (opts->accept_pathspec && dash_dash_pos == 1) ? 2 : 1;
       }
 16:  319151e4e9 ! 16:  e0bdd5bd1e parse_branchname_arg(): refactor the decision making
     @@ -34,10 +34,10 @@
       	const char **new_branch = &opts->new_branch;
       	const char *arg;
      -	int dash_dash_pos;
     --	int has_dash_dash = 0, expect_commit_only = 0;
     +-	int arg0_cant_be_pathspec = 0;
      -	int i;
      +	int dash_dash_pos, i;
     -+	int recover_with_dwim, expect_commit_only;
     ++	int recover_with_dwim, arg0_cant_be_pathspec;
       
       	/*
       	 * Resolve ambiguity where argv[0] may be <pathspec> or <commit>.
     @@ -51,25 +51,22 @@
      -	if (!opts->accept_pathspec) {
      -		if (argc > 1)
      -			die(_("only one reference expected"));
     --		has_dash_dash = 1; /* helps disambiguate */
     +-		arg0_cant_be_pathspec = 1;
      -	}
     --
     -+	 
     + 
       	arg = argv[0];
       	dash_dash_pos = -1;
     - 	for (i = 0; i < argc; i++) {
      @@
       		}
       	}
       
      -	if (opts->accept_pathspec) {
     --	    if (dash_dash_pos == 0)
     --		    return 1;
     --	    else if (dash_dash_pos == 1)
     --		    has_dash_dash = 1;
     --	    else if (dash_dash_pos >= 2)
     --		    die(_("only one reference expected, %d given."), dash_dash_pos);
     --	}
     +-		if (dash_dash_pos == 0)
     +-			return 1;
     +-		else if (dash_dash_pos == 1)
     +-			arg0_cant_be_pathspec = 1;
     +-		else if (dash_dash_pos >= 2)
     +-			die(_("only one reference expected, %d given."), dash_dash_pos);
      +	if (dash_dash_pos == -1) {
      +		if (argc == 0) {
      +			/* 'git checkout/switch/restore' */
     @@ -89,7 +86,7 @@
      +		 * Absence of '--' leaves <pathspec>/<commit> ambiguity.
      +		 * Try to resolve it with additional knowledge about pathspec args.
      +		 */
     -+		expect_commit_only = !opts->accept_pathspec;
     ++		arg0_cant_be_pathspec = !opts->accept_pathspec;
      +	} else if (dash_dash_pos == 0) {
      +		/* 'git checkout/switch/restore -- [...]' */
      +		return 1;  /* Eat '--' */
     @@ -106,32 +103,29 @@
      +			/* 'git checkout/restore <commit> -- <pathspec> [...]' */
      +			recover_with_dwim = 0;
      +		}
     - 
     --	if (has_dash_dash)
     --	    expect_commit_only = 1;
     ++
      +		/* Presence of '--' makes it certain that arg is <commit> */
     -+		expect_commit_only = 1;
     ++		arg0_cant_be_pathspec = 1;
      +	} else {
      +		/* 'git checkout/switch/restore <commit> <unxpected> [...] -- [...]' */
      +		die(_("only one reference expected, %d given."), dash_dash_pos);
     -+	}
     - 
     - 	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
     + 	}
       
     + 	opts->count_checkout_paths = !opts->quiet && !arg0_cant_be_pathspec;
      @@
       		arg = "@{-1}";
       
       	if (get_oid_mb(arg, rev)) {
      -		int recover_with_dwim = dwim_new_local_branch_ok;
      -
     - 		int could_be_checkout_paths = !expect_commit_only &&
     + 		int could_be_checkout_paths = !arg0_cant_be_pathspec &&
       			check_filename(opts->prefix, arg);
       
     - 		if (!expect_commit_only && !no_wildcard(arg))
     + 		if (!arg0_cant_be_pathspec && !no_wildcard(arg))
       			recover_with_dwim = 0;
       
     --		if (!(argc == 1 && !has_dash_dash) &&
     --		    !(argc == 2 && has_dash_dash) &&
     +-		if (!(argc == 1 && dash_dash_pos == -1) &&
     +-		    !(argc == 2 && dash_dash_pos == 1) &&
      -		    opts->accept_pathspec)
      -			recover_with_dwim = 0;
      -
 17:  542eb709ca = 17:  121d3f06a6 t2024: cover more cases
 18:  c293d72832 ! 18:  7324e091ba checkout, restore: support the --pathspec-from-file option
     @@ -105,8 +105,8 @@
       		 * Absence of '--' leaves <pathspec>/<commit> ambiguity.
       		 * Try to resolve it with additional knowledge about pathspec args.
       		 */
     --		expect_commit_only = !opts->accept_pathspec;
     -+		expect_commit_only = !opts->accept_pathspec || opts->pathspec_from_file;
     +-		arg0_cant_be_pathspec = !opts->accept_pathspec;
     ++		arg0_cant_be_pathspec = !opts->accept_pathspec || opts->pathspec_from_file;
       	} else if (dash_dash_pos == 0) {
       		/* 'git checkout/switch/restore -- [...]' */
       		return 1;  /* Eat '--' */
     @@ -247,16 +247,16 @@
      +	echo fileA.t >list &&
      +
      +	test_must_fail git checkout --pathspec-from-file=- --detach <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-detach" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --detach" err &&
      +
      +	test_must_fail git checkout --pathspec-from-file=- --patch <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
      +
      +	test_must_fail git checkout --pathspec-from-file=- -- fileA.t <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      +
      +	test_must_fail git checkout --pathspec-file-nul 2>err &&
     -+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err
     ++	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
      +'
      +
      +test_done
     @@ -344,16 +344,16 @@
      +	>empty_list &&
      +
      +	test_must_fail git restore --pathspec-from-file=- --patch --source=HEAD^1 <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-patch" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
      +
      +	test_must_fail git restore --pathspec-from-file=- --source=HEAD^1 -- fileA.t <list 2>err &&
     -+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
     ++	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      +
      +	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
     -+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
     ++	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
      +
      +	test_must_fail git restore --pathspec-from-file=- --source=HEAD^1 <empty_list 2>err &&
     -+	test_i18ngrep "you must specify path(s) to restore" err
     ++	test_i18ngrep -e "you must specify path(s) to restore" err
      +'
      +
      +test_done

-- 
gitgitgadget
