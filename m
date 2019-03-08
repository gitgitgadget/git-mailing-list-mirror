Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD2B20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCHJ6B (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37978 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfCHJ6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so13783284pfn.5
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dly3KbrQ6/W16+h3SAR7GPnnVuA29YzmWivf+okQ4+o=;
        b=kze/4pDz/paD8ww7yxLUdqf/WO4jQVCGSbku6oLnkz5DfBVMDzf3QuBDDRrh7LkKOe
         9BHQQPyyPiqDydtTzDSc3Jiycc4vLVmS4CwuAKz3hm4PNcV+bXYHCnnJPbrpES2ZH0Wf
         eBy2vDaDvvihMIyEYGuuHE/ptj9IHJoSySQV+LYYWdrHFIU4SXWZwsPna9vrx1npshTn
         sZ3lGO34RGXoubyP5puQMT5i3Ka0oJ9cPH9kXs7G7MetQgzGkZTWF42g84Z56KsPb9pp
         vGNEWJYb0iWhmtHoeMQGQOSmwshaCKkY3jsh7XsMbz+ypSGnFTYtfq8zlSs/d2/W9sjn
         d9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dly3KbrQ6/W16+h3SAR7GPnnVuA29YzmWivf+okQ4+o=;
        b=GCs6Jfm5ZfvmE3C/wmb6lpjou/gY/Hwdd6K0K224GIyhxUyWiTxGAFLP5oyTIMx7XW
         Y0vRA2g7iXtLcsAAQh3O4FPP7Xjdo+PfykQWn2u1oOeYaXkS2QCX3Bw1Cjo/yPTJhb07
         FLf3nHlB6mgj2EVPzGI9Ii6r8HCF2q5DnIKXiIRVtfSsSHmhffs4xF7yfjvgMxmwa4ew
         +iXDkLhq4JhQ24yviKBXzSlNrEYfYp2q97U7qNoVErpihhK6UpyyL+c4Ep6NoQk5TEw7
         Y7TYonhGzHoV3RXjHo7xv3iMvd9RNQm0M5NnxbihUx6CCBWkh3hx6lgLAMRzdWHRvEwF
         0DWA==
X-Gm-Message-State: APjAAAXqe3IuoOn5Xhbtw8ANATKmD4SG4pwJWSkzUUiRYNamIaz/BLRI
        f2Sm3ODuO8kPBr0KS9fercM=
X-Google-Smtp-Source: APXvYqxc8kyn0HUbhLIHKf5k+qLpxZX6EzytLdnxKd38IxMri68KRXwi8zkHvYvZ5AN+zpZ0YwdbLA==
X-Received: by 2002:a63:4e57:: with SMTP id o23mr14957381pgl.368.1552039079434;
        Fri, 08 Mar 2019 01:57:59 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 20sm16105763pfs.182.2019.03.08.01.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:57:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:57:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 00/21] Add new command "switch"
Date:   Fri,  8 Mar 2019 16:57:31 +0700
Message-Id: <20190308095752.8574-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 contains document and completion updates based on v2's feedback. It
also contains some extra git-checkout.txt updates (blame Eric for this,
he points out problems in git-switch.txt and makes me want to go fix
git-checkout.txt too).

The series is now based on 'master' (yay!)

Nguyễn Thái Ngọc Duy (21):
  git-checkout.txt: spell out --no-option
  git-checkout.txt: fix one syntax line
  doc: document --overwrite-ignore
  git-checkout.txt: fix monospace typeset
  t: rename t2014-switch.sh to t2014-checkout-switch.sh
  checkout: factor out some code in parse_branchname_arg()
  checkout: make "opts" in cmd_checkout() a pointer
  checkout: move 'confict_style' and 'dwim_..' to checkout_opts
  checkout: split options[] array in three pieces
  checkout: split part of it to new command 'switch'
  switch: better names for -b and -B
  switch: remove -l
  switch: stop accepting pathspec
  switch: reject "do nothing" case
  switch: only allow explicit detached HEAD
  switch: add short option for --detach
  switch: no implicit dwim, use --guess to dwim
  switch: no worktree status unless real branch switch happens
  t: add tests for switch
  completion: support switch
  doc: promote "git switch"

 .gitignore                                    |   1 +
 Documentation/config/advice.txt               |  13 +-
 Documentation/config/branch.txt               |   4 +-
 Documentation/config/checkout.txt             |  17 +-
 Documentation/config/diff.txt                 |   3 +-
 Documentation/git-branch.txt                  |  12 +-
 Documentation/git-check-ref-format.txt        |   3 +-
 Documentation/git-checkout.txt                | 119 +++--
 Documentation/git-format-patch.txt            |   2 +-
 Documentation/git-merge-base.txt              |   2 +-
 Documentation/git-merge.txt                   |   5 +
 Documentation/git-rebase.txt                  |   2 +-
 Documentation/git-remote.txt                  |   2 +-
 Documentation/git-rerere.txt                  |  10 +-
 Documentation/git-reset.txt                   |  20 +-
 Documentation/git-stash.txt                   |   9 +-
 Documentation/git-switch.txt                  | 259 ++++++++++
 Documentation/gitattributes.txt               |   3 +-
 Documentation/gitcore-tutorial.txt            |  19 +-
 Documentation/giteveryday.txt                 |  24 +-
 Documentation/githooks.txt                    |   8 +-
 Documentation/gittutorial.txt                 |   4 +-
 Documentation/gitworkflows.txt                |   3 +-
 Documentation/revisions.txt                   |   2 +-
 Documentation/user-manual.txt                 |  56 +--
 Makefile                                      |   1 +
 advice.c                                      |  11 +-
 builtin.h                                     |   1 +
 builtin/checkout.c                            | 471 +++++++++---------
 command-list.txt                              |   1 +
 contrib/completion/git-completion.bash        |  27 +
 git.c                                         |   1 +
 parse-options-cb.c                            |  17 +
 parse-options.h                               |   1 +
 sha1-name.c                                   |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  14 -
 ...014-switch.sh => t2014-checkout-switch.sh} |   0
 t/t2020-checkout-detach.sh                    |  16 +-
 t/t2060-switch.sh                             |  87 ++++
 39 files changed, 837 insertions(+), 415 deletions(-)
 create mode 100644 Documentation/git-switch.txt
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)
 create mode 100755 t/t2060-switch.sh

Range-diff dựa trên v2:
 -:  ---------- >  1:  949f3dd4fd git-checkout.txt: spell out --no-option
 1:  8358b9ca36 =  2:  1ddbbae3e2 git-checkout.txt: fix one syntax line
 2:  1686ccbf8d !  3:  b0cb2372db doc: document --overwrite-ignore
    @@ -14,14 +14,15 @@
      	out anyway. In other words, the ref can be held by more than one
      	worktree.
      
    -+--[no-]overwrite-ignore::
    ++--overwrite-ignore::
    ++--no-overwrite-ignore::
     +	Silently overwrite ignored files when switching branches. This
    -+	is the default behavior. Use --no-overwrite-ignore to abort
    ++	is the default behavior. Use `--no-overwrite-ignore` to abort
     +	the operation when the new branch contains ignored files.
     +
    - --[no-]recurse-submodules::
    + --recurse-submodules::
    + --no-recurse-submodules::
      	Using --recurse-submodules will update the content of all initialized
    - 	submodules according to the commit recorded in the superproject. If
     
      diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
      --- a/Documentation/git-merge.txt
    @@ -30,9 +31,10 @@
      	Allow the rerere mechanism to update the index with the
      	result of auto-conflict resolution if possible.
      
    -+--[no-]overwrite-ignore::
    ++--overwrite-ignore::
    ++--no-overwrite-ignore::
     +	Silently overwrite ignored files from the merge result. This
    -+	is the default behavior. Use --no-overwrite-ignore to abort.
    ++	is the default behavior. Use `--no-overwrite-ignore` to abort.
     +
      --abort::
      	Abort the current conflict resolution process, and
 -:  ---------- >  4:  5b165524d1 git-checkout.txt: fix monospace typeset
 3:  1e34862ad8 =  5:  a4240a888e t: rename t2014-switch.sh to t2014-checkout-switch.sh
 4:  aba8f41f73 =  6:  dc4a8e8933 checkout: factor out some code in parse_branchname_arg()
 5:  f165322652 =  7:  f0d933c2ac checkout: make "opts" in cmd_checkout() a pointer
 6:  75f9a38e85 =  8:  0aa541689c checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 7:  9188718493 =  9:  84ca42bb26 checkout: split options[] array in three pieces
 8:  b5af7d22fd ! 10:  e983c8bb2c checkout: split part of it to new command switch
    @@ -1,6 +1,6 @@
     Author: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
     
    -    checkout: split part of it to new command switch
    +    checkout: split part of it to new command 'switch'
     
         "git checkout" doing too many things is a source of confusion for many
         users (and it even bites old timers sometimes). To remedy that, the
    @@ -180,7 +180,7 @@
     ++
     +You can use the `"@{-N}"` syntax to refer to the N-th last
     +branch/commit switched to "git switch" or "git checkout"
    -+operation. You may also specify `-` which is synonymous to `"@{-1}`.
    ++operation. You may also specify `-` which is synonymous to `"@{-1}"`.
     ++
     +As a special case, you may use `"A...B"` as a shortcut for the merge
     +base of `A` and `B` if there is exactly one merge base. You can leave
    @@ -188,8 +188,8 @@
     +
     +-c <new-branch>::
     +--create <new-branch>::
    -+	Create a new branch named <new-branch> starting at
    -+	<start-point> before switching to the branch. This is a
    ++	Create a new branch named `<new-branch>` starting at
    ++	`<start-point>` before switching to the branch. This is a
     +	convenient shortcut for:
     ++
     +------------
    @@ -199,8 +199,8 @@
     +
     +-C <new-branch>::
     +--force-create <new-branch>::
    -+	Similar to `--create` except that if <new-branch> already
    -+	exists, it will be reset to <start-point>. This is a
    ++	Similar to `--create` except that if `<new-branch>` already
    ++	exists, it will be reset to `<start-point>`. This is a
     +	convenient shortcut for:
     ++
     +------------
    @@ -216,8 +216,8 @@
     +
     +-g::
     +--guess::
    -+	If <branch> is not found but there does exist a tracking
    -+	branch in exactly one remote (call it <remote>) with a
    ++	If `<branch>` is not found but there does exist a tracking
    ++	branch in exactly one remote (call it `<remote>`) with a
     +	matching name, treat as equivalent to
     ++
     +------------
    @@ -243,7 +243,8 @@
     +	the switching target. This is used to throw away local
     +	changes.
     +
    -+--[no-]progress::
    ++--progress::
    ++--no-progress::
     +	Progress status is reported on the standard error stream
     +	by default when it is attached to a terminal, unless `--quiet`
     +	is specified. This flag enables progress reporting even if not
    @@ -292,8 +293,8 @@
     +	"merge" style, shows the original contents).
     +
     +--orphan <new-branch>::
    -+	Create a new 'orphan' branch, named <new-branch>, started from
    -+	<start-point> and switch to it. See explanation of the same
    ++	Create a new 'orphan' branch, named `<new-branch>`, started from
    ++	`<start-point>` and switch to it. See explanation of the same
     +	option in linkgit:git-checkout[1] for details.
     +
     +--ignore-other-worktrees::
    @@ -302,7 +303,8 @@
     +	the ref out anyway. In other words, the ref can be held by
     +	more than one worktree.
     +
    -+--[no-]recurse-submodules::
    ++--recurse-submodules::
    ++--no-recurse-submodules::
     +	Using --recurse-submodules will update the content of all initialized
     +	submodules according to the commit recorded in the superproject. If
     +	local modifications in a submodule would be overwritten the checkout
 9:  5be400099c ! 11:  5491932cc8 switch: better names for -b and -B
    @@ -3,9 +3,9 @@
         switch: better names for -b and -B
     
         The shortcut of these options do not make much sense when used with
    -    switch. And their descriptions are also tied to checkout
    -    out. Move -b/-B to cmd_checkout() and new -c/-C with the same
    -    functionality in cmd_switch_branch()
    +    switch. And their descriptions are also tied to checkout. Move -b/-B
    +    to cmd_checkout() and new -c/-C with the same functionality in
    +    cmd_switch_branch()
     
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
10:  38cfc1fada = 12:  e0f1247b09 switch: remove -l
11:  7f0abab72c = 13:  f7ff1a7df6 switch: stop accepting pathspec
12:  386ba95007 = 14:  0750d63d38 switch: reject "do nothing" case
13:  e488c7d8ca = 15:  bcd843146d switch: only allow explicit detached HEAD
14:  9cd5f63c01 = 16:  d5cc55525d switch: add short option for --detach
15:  fc31b3d4f3 ! 17:  4a27400a58 switch: no implicit dwim, use --guess to dwim
    @@ -15,13 +15,13 @@
      --- a/Documentation/git-checkout.txt
      +++ b/Documentation/git-checkout.txt
     @@
    - 	<branch>.
    + 	`<branch>`.
      +
    - If <branch> is not found but there does exist a tracking branch in
    --exactly one remote (call it <remote>) with a matching name, treat as
    + If `<branch>` is not found but there does exist a tracking branch in
    +-exactly one remote (call it `<remote>`) with a matching name, treat as
     -equivalent to
    -+exactly one remote (call it <remote>) with a matching name and
    -+--no-guess is not specified, treat as equivalent to
    ++exactly one remote (call it `<remote>`) with a matching name and
    ++`--no-guess` is not specified, treat as equivalent to
      +
      ------------
      $ git checkout -b <branch> --track <remote>/<branch>
    @@ -36,16 +36,17 @@
     -'origin' remote. See also `checkout.defaultRemote` in
     -linkgit:git-config[1].
     -+
    - You could omit <branch>, in which case the command degenerates to
    + You could omit `<branch>`, in which case the command degenerates to
      "check out the current branch", which is a glorified no-op with
      rather expensive side-effects to show only the tracking information,
     @@
      	Do not set up "upstream" configuration, even if the
      	branch.autoSetupMerge configuration variable is true.
      
    -+--[no-]guess::
    -+	If <branch> is not found but there does exist a tracking
    -+	branch in exactly one remote (call it <remote>) with a
    ++--guess::
    ++--no-guess::
    ++	If `<branch>` is not found but there does exist a tracking
    ++	branch in exactly one remote (call it `<remote>`) with a
     +	matching name, treat as equivalent to
     ++
     +------------
    @@ -74,9 +75,9 @@
     -	Do not attempt to create a branch if a remote tracking branch
     -	of the same name exists.
     -
    - --[no-]overlay::
    + --overlay::
    + --no-overlay::
      	In the default overlay mode, `git checkout` never
    - 	removes files from the index or the working tree.  When
     
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
16:  761f953b40 = 18:  f7dd33abe6 switch: no worktree status unless real branch switch happens
17:  206f1bda79 = 19:  5b182abea8 t: add tests for switch
18:  3cfb2913eb ! 20:  1575064fe6 completion: support switch
    @@ -28,10 +28,11 @@
     +		local track_opt= only_local_ref=n
     +		if [ -n "$(__git_find_on_cmdline "-g --guess")" ]; then
     +			track_opt='--track'
    -+		elif [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
    ++		fi
    ++		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
     +			only_local_ref=y
     +		fi
    -+		if [ $only_local_ref = y ]; then
    ++		if [ $only_local_ref = y -a -n "$track_opt"]; then
     +			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
     +		else
     +			__git_complete_refs $track_opt
19:  2d018878bd ! 21:  8ed01ad0c5 doc: promote "git switch"
    @@ -317,9 +317,9 @@
      
      ------------
     -$ git checkout mybranch
    -+$ git switch mybranch
    - $ git reset --hard master^2
    +-$ git reset --hard master^2
     -$ git checkout master
    ++$ git switch -C mybranch master^2
     +$ git switch master
      $ git reset --hard master^
      ------------
    @@ -400,7 +400,7 @@
     -$ git checkout pu && git reset --hard next <7>
     +$ git switch -c hold/linus && git am -3 -i -s ./+hold-linus <5>
     +$ git switch topic/one && git rebase master <6>
    -+$ git switch pu && git reset --hard next <7>
    ++$ git switch -C pu next <7>
      $ git merge topic/one topic/two && git merge hold/linus <8>
     -$ git checkout maint
     +$ git switch maint
    @@ -430,6 +430,20 @@
      
      Check that the change you made is no longer visible, since it was
     
    + diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
    + --- a/Documentation/gitworkflows.txt
    + +++ b/Documentation/gitworkflows.txt
    +@@
    + .Rewind and rebuild next
    + [caption="Recipe: "]
    + =====================================
    +-* `git checkout next`
    +-* `git reset --hard master`
    ++* `git switch -C next master`
    + * `git merge ai/topic_in_next1`
    + * `git merge ai/topic_in_next2`
    + * ...
    +
      diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
      --- a/Documentation/revisions.txt
      +++ b/Documentation/revisions.txt
-- 
2.21.0.rc1.337.gdf7f8d0522

