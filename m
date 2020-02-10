Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13E3C3B186
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA0320873
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orRIS6TC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgBJOp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgBJOpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so8093723wrt.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RPR75WqNjRiPFZluERYw+kFPakFb3d2sFfl88TFev0w=;
        b=orRIS6TC03207wPA/3uHpaPJezT+pBqAtmgLcs3P8s23j4P38JCr+Sfdrnt7juh3az
         06HWwD7Jv/dkc1HrgenX6OAgecIBdDurCGeEsZPkvtu7yoS3UTz/eAZ0vUdzMMJPInsZ
         2Xmh+IUWXtXxHWzqb+LK5WAWxli48yIsmtU3bwgL6ANSfi+4X23Ik9yDHRNrIrr4xDx2
         wU09I6zpGvEH+kiP77W2NGS27mNe1QjGuST2SwnMIde7W9M4F4QBP2gPr4y17stVR4ls
         8ExVZPpJnAF0QncC90U5G2l1Vq9vextLze/wVhO5iVQPy9d9ISJsuLhJsGWCMee11xCW
         b4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RPR75WqNjRiPFZluERYw+kFPakFb3d2sFfl88TFev0w=;
        b=BU4N1moQU6yzA8F3o5MadCcGyK/tQAw7cWy9OLVzow4ECRlW39pSix5bkHmpFnk+DX
         rlPnoB+3rh0V6CjfIINVW1yR1VXaNVR9jX5erItBU0ruC6qfFvAW20d+IclU2ig7jV1L
         WS8ZRSPKQL2eskemAi6cOzJ9BZoIRP2HFuG4U3wrjNbRBowY3+a+Eag3nxlWIX7FWh2Z
         GHF1lA56KTLTFSJcLhks8/58UIncDD+97DDFZgVuDX4tRipOn7Ts/bi83uuvd8pBgyfB
         avQ/ZCVXDRCxEk2Qy0uVD1ZK0oPClFIDk3w2q++sRyTHdpMh+Kuv2ftluxbgvGsu8nex
         DLdQ==
X-Gm-Message-State: APjAAAXzbD4c4lziajnEF+xwhMbYZElH1DZIltb5hCzHg7Tz2lnR7Xzd
        OUfsSSBzi2jxiRVOJ8CZsFtXW++c
X-Google-Smtp-Source: APXvYqz0ITr/Sf/xdHUXMwigDPYXF9/R5UAr3wCzA6zmu3Tx04edEPgyDg7jXRohy4QLzgWxv3lKoQ==
X-Received: by 2002:adf:e641:: with SMTP id b1mr2407099wrn.34.1581345949431;
        Mon, 10 Feb 2020 06:45:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm852842wrw.52.2020.02.10.06.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:48 -0800 (PST)
Message-Id: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:39 +0000
Subject: [PATCH v2 0/8] Support --pathspec-from-file in rm, stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V1
------------------
Some polishing based on code review in V1
1) Improved error message for the case where pathspec is not given to `git rm`
2) Removed explicit variable initialization to 0 / NULL
3) Polishing in docs for `git stash`

------------------
This series continues the effort to support `--pathspec-from-file`
in various git commands. Series already in `master`: [1][2]

Cc'ing Paul-Sebastian Ungureanu because I touched his git stash code.

[1] https://public-inbox.org/git/pull.445.git.1572895605.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/

Alexandr Miloslavskiy (8):
  doc: rm: synchronize <pathspec> description
  rm: support the --pathspec-from-file option
  doc: stash: split options from description (1)
  doc: stash: split options from description (2)
  doc: stash: document more options
  doc: stash: synchronize <pathspec> description
  stash: eliminate crude option parsing
  stash push: support the --pathspec-from-file option

 Documentation/git-rm.txt       |  61 +++++++-------
 Documentation/git-stash.txt    | 144 +++++++++++++++++++++++----------
 builtin/rm.c                   |  28 +++++--
 builtin/stash.c                |  79 +++++++++---------
 t/t3601-rm-pathspec-file.sh    |  79 ++++++++++++++++++
 t/t3903-stash.sh               |   5 ++
 t/t3909-stash-pathspec-file.sh | 100 +++++++++++++++++++++++
 7 files changed, 381 insertions(+), 115 deletions(-)
 create mode 100755 t/t3601-rm-pathspec-file.sh
 create mode 100755 t/t3909-stash-pathspec-file.sh


base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-530%2FSyntevoAlex%2F%230207(git)_pathspec_from_file_3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-530/SyntevoAlex/#0207(git)_pathspec_from_file_3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/530

Range-diff vs v1:

 1:  23387f8391 = 1:  2e8c8ad815 doc: rm: synchronize <pathspec> description
 2:  5611e3ae32 ! 2:  7ccbab52e5 rm: support the --pathspec-from-file option
     @@ -64,8 +64,8 @@
       
       static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
      -static int ignore_unmatch = 0;
     -+static int ignore_unmatch = 0, pathspec_file_nul = 0;
     -+static char *pathspec_from_file = NULL;
     ++static int ignore_unmatch = 0, pathspec_file_nul;
     ++static char *pathspec_from_file;
       
       static struct option builtin_rm_options[] = {
       	OPT__DRY_RUN(&show_only, N_("dry run")),
     @@ -101,7 +101,7 @@
      +	}
      +
      +	if (!pathspec.nr)
     -+		die(_("Nothing specified, nothing removed"));
     ++		die(_("No pathspec was given. Which files should I remove?"));
       
       	if (!index_only)
       		setup_work_tree();
     @@ -196,7 +196,7 @@
      +	
      +	>empty_list &&
      +	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
     -+	test_i18ngrep -e "Nothing specified, nothing removed" err
     ++	test_i18ngrep -e "No pathspec was given. Which files should I remove?" err
      +'
      +
      +test_done
 3:  0824bba210 = 3:  8c212fc0ed doc: stash: split options from description (1)
 4:  708363241f ! 4:  db3a96720c doc: stash: split options from description (2)
     @@ -3,17 +3,28 @@
          doc: stash: split options from description (2)
      
          Together with the previous patch, this brings docs for `git stash` to
     -    the common layout used for most other commands (see for example docs for
     -    `git add`, `git commit`, `git checkout`, `git reset`) where all options
     -    are documented in a separate list.
     +    the common layout used for most other commands (see for example docs
     +    for `git add`, `git commit`, `git checkout`, `git reset`) where all
     +    options are documented in a separate list.
      
     -    I have decided to use alphabetical sorting in the list of options. Other
     -    docs often sort in order of appearance or order of importance, but in
     -    this case it wouldn't be easy to read the list where options from
     -    multiple sub-commands are mixed together.
     +    After some thinking and having a look at docs for `git svn` and
     +    `git `submodule`, I have arrived at following conclusions:
     +      * Options should be described in a list rather then text to
     +        facilitate lookup for user.
     +      * Single list is better then multiple lists because it avoids
     +        copy&pasting descriptions between subcommands (or, without
     +        copy&pasting, user will have to look up missing options in other
     +        subcommands).
     +      * As a consequence, commands section should only give brief info and
     +        list possible options. Since options have good enough names, user
     +            will only need to look up the "interesting" options.
     +      * Every option should list which subcommands support it.
      
     -    There is some text editing done to make old descriptions better fit into
     -    the list-style format.
     +    I have decided to use alphabetical sorting in the list of options to
     +    facilitate lookup for user.
     +
     +    There is some text editing done to make old descriptions better fit
     +    into the list-style format.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     @@ -26,10 +37,40 @@
       
      -OPTIONS
      --------
     --
     ++COMMANDS
     ++--------
     + 
       push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
       
     - 	Save your local modifications to a new 'stash entry' and roll them
     +@@
     + 
     + 	Show the changes recorded in the stash entry as a diff between the
     + 	stashed contents and the commit back when the stash entry was first
     +-	created. When no `<stash>` is given, it shows the latest one.
     ++	created.
     + 	By default, the command shows the diffstat, but it will accept any
     + 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
     + 	to view the second most recent entry in patch form).
     +@@
     + 	the commit at which the `<stash>` was originally created, applies the
     + 	changes recorded in `<stash>` to the new working tree and index.
     + 	If that succeeds, and `<stash>` is a reference of the form
     +-	`stash@{<revision>}`, it then drops the `<stash>`. When no `<stash>`
     +-	is given, applies the latest one.
     ++	`stash@{<revision>}`, it then drops the `<stash>`.
     + +
     + This is useful if the branch on which you ran `git stash push` has
     + changed enough that `git stash apply` fails due to conflicts. Since
     +@@
     + drop [-q|--quiet] [<stash>]::
     + 
     + 	Remove a single stash entry from the list of stash entries.
     +-	When no `<stash>` is given, it removes the latest one.
     +-	i.e. `stash@{0}`, otherwise `<stash>` must be a valid stash
     +-	log reference of the form `stash@{<revision>}`.
     + 
     + create::
     + 
      @@
       	reflog.  This is intended to be useful for scripts.  It is
       	probably not the command you want to use; see "push" above.
     @@ -40,15 +81,43 @@
      -If the `--include-untracked` option is used, all untracked files are also
      -stashed and then cleaned up with `git clean`, leaving the working directory
      -in a very clean state.
     --
     ++OPTIONS
     ++-------
     ++-a::
     ++--all::
     ++	This option is only valid for `push` and `save` commands.
     +++
     ++All ignored and untracked files are also stashed and then cleaned
     ++up with `git clean`.
     + 
      -If the `--index` option is used, then tries to reinstate not only the working
      -tree's changes, but also the index's ones. However, this can fail, when you
      -have conflicts (which are stored in the index, where you therefore can no
      -longer apply the changes as they were originally).
     --
     ++-u::
     ++--include-untracked::
     ++	This option is only valid for `push` and `save` commands.
     +++
     ++All untracked files are also stashed and then cleaned up with
     ++`git clean`.
     + 
      -If the `--keep-index` option is used, all changes already added to the
      -index are left intact.
     --
     ++--index::
     ++	This option is only valid for `pop` and `apply` commands.
     +++
     ++Tries to reinstate not only the working tree's changes, but also
     ++the index's ones. However, this can fail, when you have conflicts
     ++(which are stored in the index, where you therefore can no longer
     ++apply the changes as they were originally).
     ++
     ++-k::
     ++--keep-index::
     ++--no-keep-index::
     ++	This option is only valid for `push` and `save` commands.
     +++
     ++All changes already added to the index are left intact.
     + 
      -With `--patch`, you can interactively select hunks from the diff
      -between HEAD and the working tree to be stashed.  The stash entry is
      -constructed such that its index state is the same as the index state
     @@ -56,38 +125,17 @@
      -selected interactively.  The selected changes are then rolled back
      -from your worktree. See the ``Interactive Mode'' section of
      -linkgit:git-add[1] to learn how to operate the `--patch` mode.
     -+OPTIONS
     -+-------
     -+-a::
     -+--all::
     -+	All ignored and untracked files are also stashed and then cleaned
     -+	up with `git clean`.
     -+
     -+-u::
     -+--include-untracked::
     -+	All untracked files are also stashed and then cleaned up with
     -+	`git clean`.
     -+
     -+--index::
     -+	Tries to reinstate not only the working tree's changes, but also
     -+	the index's ones. However, this can fail, when you have conflicts
     -+	(which are stored in the index, where you therefore can no longer
     -+	apply the changes as they were originally).
     -+
     -+-k::
     -+--keep-index::
     -+--no-keep-index::
     -+	All changes already added to the index are left intact.
     -+
      +-p::
      +--patch::
     -+	Interactively select hunks from the diff between HEAD and the
     -+	working tree to be stashed.  The stash entry is constructed such
     -+	that its index state is the same as the index state of your
     -+	repository, and its worktree contains only the changes you selected
     -+	interactively.  The selected changes are then rolled back from your
     -+	worktree. See the ``Interactive Mode'' section of linkgit:git-add[1]
     -+	to learn how to operate the `--patch` mode.
     ++	This option is only valid for `push` and `save` commands.
     +++
     ++Interactively select hunks from the diff between HEAD and the
     ++working tree to be stashed.  The stash entry is constructed such
     ++that its index state is the same as the index state of your
     ++repository, and its worktree contains only the changes you selected
     ++interactively.  The selected changes are then rolled back from your
     ++worktree. See the ``Interactive Mode'' section of linkgit:git-add[1]
     ++to learn how to operate the `--patch` mode.
       +
       The `--patch` option implies `--keep-index`.  You can use 
       `--no-keep-index` to override this.
     @@ -97,17 +145,23 @@
      -entries and working tree files are then rolled back to the state in
      -HEAD only for these files, too, leaving files that do not match the
      -pathspec intact.
     -+<pathspec>...::
     -+	The new stash entry records the modified states only for the files
     -+	that match the pathspec.  The index entries and working tree files
     -+	are then rolled back to the state in HEAD only for these files,
     -+	too, leaving files that do not match the pathspec intact.
     - 
     +-
      -When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
      -be a reference of the form `stash@{<revision>}`.
     ++<pathspec>...::
     ++	This option is only valid for `push` command.
     +++
     ++The new stash entry records the modified states only for the files
     ++that match the pathspec.  The index entries and working tree files
     ++are then rolled back to the state in HEAD only for these files,
     ++too, leaving files that do not match the pathspec intact.
     ++
      +<stash>::
     -+	A reference of the form `stash@{<revision>}`. When no `<stash>` is
     -+	given, the latest stash is assumed (that is, `stash@{0}`).
     ++	This option is only valid for `apply`, `branch`, `drop`, `pop`,
     ++	`show` commands.
     +++
     ++A reference of the form `stash@{<revision>}`. When no `<stash>` is
     ++given, the latest stash is assumed (that is, `stash@{0}`).
       
       DISCUSSION
       ----------
 5:  8a5f2dbe9e ! 5:  f91ec08b47 doc: stash: document more options
     @@ -13,11 +13,16 @@
       
      +-q::
      +--quiet::
     -+	Quiet, suppress feedback messages.
     ++	This option is only valid for `apply`, `drop`, `pop`, `push`,
     ++	`save`, `store` commands.
     +++
     ++Quiet, suppress feedback messages.
      +
      +\--::
     -+	Separates pathspec from options for disambiguation purposes.
     ++	This option is only valid for `push` command.
     +++
     ++Separates pathspec from options for disambiguation purposes.
      +
       <pathspec>...::
     - 	The new stash entry records the modified states only for the files
     - 	that match the pathspec.  The index entries and working tree files
     + 	This option is only valid for `push` command.
     + +
 6:  5e17a0c470 ! 6:  04e2fd5865 doc: stash: synchronize <pathspec> description
     @@ -30,11 +30,11 @@
       	message.
       
      @@
     - 	that match the pathspec.  The index entries and working tree files
     - 	are then rolled back to the state in HEAD only for these files,
     - 	too, leaving files that do not match the pathspec intact.
     + that match the pathspec.  The index entries and working tree files
     + are then rolled back to the state in HEAD only for these files,
     + too, leaving files that do not match the pathspec intact.
      ++
      +For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
       
       <stash>::
     - 	A reference of the form `stash@{<revision>}`. When no `<stash>` is
     + 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
 7:  7a8d36d49f = 7:  0558cbbe38 stash: eliminate crude option parsing
 8:  721410233b ! 8:  0c6f28dc68 stash push: support the --pathspec-from-file option
     @@ -22,8 +22,8 @@
       'git stash' clear
       'git stash' create [<message>]
      @@
     - is also possible). Stashes may also be referenced by specifying just the
     - stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
     + COMMANDS
     + --------
       
      -push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
      +push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
     @@ -35,21 +35,25 @@
       `--no-keep-index` to override this.
       
      +--pathspec-from-file=<file>::
     -+	Pathspec is passed in `<file>` instead of commandline args. If
     -+	`<file>` is exactly `-` then standard input is used. Pathspec
     -+	elements are separated by LF or CR/LF. Pathspec elements can be
     -+	quoted as explained for the configuration variable `core.quotePath`
     -+	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
     -+	global `--literal-pathspecs`.
     ++	This option is only valid for `push` command.
     +++
     ++Pathspec is passed in `<file>` instead of commandline args. If
     ++`<file>` is exactly `-` then standard input is used. Pathspec
     ++elements are separated by LF or CR/LF. Pathspec elements can be
     ++quoted as explained for the configuration variable `core.quotePath`
     ++(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
     ++global `--literal-pathspecs`.
      +
      +--pathspec-file-nul::
     -+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
     -+	separated with NUL character and all other characters are taken
     -+	literally (including newlines and quotes).
     ++	This option is only valid for `push` command.
     +++
     ++Only meaningful with `--pathspec-from-file`. Pathspec elements are
     ++separated with NUL character and all other characters are taken
     ++literally (including newlines and quotes).
      +
       -q::
       --quiet::
     - 	Quiet, suppress feedback messages.
     + 	This option is only valid for `apply`, `drop`, `pop`, `push`,
      
       diff --git a/builtin/stash.c b/builtin/stash.c
       --- a/builtin/stash.c

-- 
gitgitgadget
