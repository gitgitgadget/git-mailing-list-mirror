Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B941F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeD2STW (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:22 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38215 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754054AbeD2STQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id z130-v6so9377410lff.5
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdJPpY+vtcQHINKTJAwLQQ43yHkoQqUq9xF3LY250/U=;
        b=ZsQrStqxcnIO1d1s4c1ohBMb06gA2EjMGVhuOHdxVafvoi+b3yCx+9HP0DKbSotrv7
         /mLfBhr7qcR6XiCdIn5gx7UVxbUWouelzi6XtzoQ89suTt9TMv08KljW3o4jv4rTdDMg
         1u/yNyWVgi9iWkco7xJedWJ6r8MbqrDXVjU/3HWE/mNw0RTkEFqWAN2XAG0CJzNCp5Kq
         +ZblkQqMrrcM4lkaKI0CPmQW6d/KAa0OCRMfnp0PbwMTud/VimnQDVteLaZ270P2lGnh
         WdWW9/RIk3GXSqna5QUgJcrRG5bBoqlZLEbj9Hf0elV58jV10s65SFXRVDen7VOW03J8
         YbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdJPpY+vtcQHINKTJAwLQQ43yHkoQqUq9xF3LY250/U=;
        b=Mz376oU4sJht8HOltzPRSck5eEhUlfvRfOzJNbViMLgpcviryM7BoScMhizyj/An8Q
         pV+Hx1r4Wf8bSQJeHd4Y5uUcpzcQ5JrVUot3Ygdgp5eit1kdIO481FhncMY8u4A0cp2X
         qTJTa2/VYgoWR6gzcvok2HUN196yfbBXfXFCIxo7Nu10UyE86ET7oqIcxoOYW+A2BzMM
         oTxWe/rdiAZMQLf6HkzligTpObESv70yTRROWBJNAft102uPeFocoEuScqaFu0HEhLdc
         Tb3B8vKUIP4Hp3F5+acxW0EWg9iVaI4CqS1KL8rlqekZnErVrYrDdmSK0ohDKtMRa0Fn
         anIg==
X-Gm-Message-State: ALQs6tCRtAPy5PUSwba26NxkJSARbhwZT0FDDpjJizqi9KSZBtiUMY4b
        Ue7Q8e7H9uLQ81nxkQfPgSo=
X-Google-Smtp-Source: AB8JxZqp2c9hGlU6mn0DUIJDHsPpk4DnyL7Xd4Q4XOizcCWMnWn0onIL9Oz0d9qawSNJXD8xl3CxmQ==
X-Received: by 2002:a2e:94c8:: with SMTP id r8-v6mr1542998ljh.118.1525025954429;
        Sun, 29 Apr 2018 11:19:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 10/10] completion: let git provide the completable command list
Date:   Sun, 29 Apr 2018 20:18:44 +0200
Message-Id: <20180429181844.21325-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180429181844.21325-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of maintaining a separate list of command classification,
which often could go out of date, let's centralize the information
back in git.

While the function in git-completion.bash implies "list porcelain
commands", that's not exactly what it does. It gets all commands (aka
--list-cmds=main,others) then exclude certain non-porcelain ones. We
could almost recreate this list two lists list-mainporcelain and
others. The non-porcelain-but-included-anyway is added by the third
category list-complete.

list-complete does not recreate exactly the command list before this
patch though. The following commands are not part of neither
list-mainporcelain nor list-complete and as a result no longer
completes:

- annotate             obsolete, discouraged to use
- difftool-helper      not an end user command
- filter-branch        not often used
- get-tar-commit-id    not often used
- imap-send            not often used
- interpreter-trailers not for interactive use
- lost-found           obsolete
- p4                   too short and probably not often used (*)
- peek-remote          deprecated
- svn                  same category as p4 (*)
- tar-tree             obsolete
- verify-commit        not often used

Note that the current completion script incorrectly classifies
filter-branch as porcelain and t9902 tests this behavior. We keep it
this way in t9902 because this test does not really care which
particular command is porcelain or plubmbing, they're just names.

(*) to be fair, send-email command which is in the same
foreignscminterface group as svn and p4 does get completion, just
because it's used by git and kernel development. So maybe should
include them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt                       |  37 ++++----
 contrib/completion/git-completion.bash | 117 ++++++-------------------
 t/t9902-completion.sh                  |   5 +-
 3 files changed, 48 insertions(+), 111 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 99ddc231c1..40776b9587 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -3,11 +3,11 @@
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
-git-apply                               plumbingmanipulators
+git-apply                               plumbingmanipulators            complete
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
-git-blame                               ancillaryinterrogators
+git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
@@ -17,7 +17,7 @@ git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain           history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
-git-cherry                              ancillaryinterrogators
+git-cherry                              ancillaryinterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
@@ -25,7 +25,7 @@ git-clone                               mainporcelain           init
 git-column                              purehelpers
 git-commit                              mainporcelain           history
 git-commit-tree                         plumbingmanipulators
-git-config                              ancillarymanipulators
+git-config                              ancillarymanipulators           complete
 git-count-objects                       ancillaryinterrogators
 git-credential                          purehelpers
 git-credential-cache                    purehelpers
@@ -39,7 +39,7 @@ git-diff                                mainporcelain           history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
-git-difftool                            ancillaryinterrogators
+git-difftool                            ancillaryinterrogators          complete
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain           remote
@@ -48,20 +48,20 @@ git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck                                ancillaryinterrogators
+git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help                                ancillaryinterrogators
+git-help                                ancillaryinterrogators          complete
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
-git-instaweb                            ancillaryinterrogators
+git-instaweb                            ancillaryinterrogators          complete
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
 git-log                                 mainporcelain           info
@@ -75,12 +75,12 @@ git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
-git-mergetool                           ancillarymanipulators
+git-mergetool                           ancillarymanipulators           complete
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
-git-name-rev                            plumbinginterrogators
+git-name-rev                            plumbinginterrogators           complete
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
@@ -96,28 +96,29 @@ git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
-git-reflog                              ancillarymanipulators
-git-remote                              ancillarymanipulators
-git-repack                              ancillarymanipulators
-git-replace                             ancillarymanipulators
-git-request-pull                        foreignscminterface
+git-reflog                              ancillarymanipulators           complete
+git-remote                              ancillarymanipulators           complete
+git-repack                              ancillarymanipulators           complete
+git-replace                             ancillarymanipulators           complete
+git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain           worktree
-git-send-email                          foreignscminterface
+git-send-email                          foreignscminterface             complete
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain           info
-git-show-branch                         ancillaryinterrogators
+git-show-branch                         ancillaryinterrogators          complete
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
+git-stage                                                               complete
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
@@ -136,7 +137,7 @@ git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
-git-whatchanged                         ancillaryinterrogators
+git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           guide
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 50d14a93dc..b27008b2f0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -830,18 +830,30 @@ __git_complete_strategy ()
 }
 
 __git_commands () {
-	if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
-	then
-		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
-	else
-		git --list-cmds=main,others
-	fi
+	case "$1" in
+	porcelain)
+		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		then
+			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		else
+			git --list-cmds=list-mainporcelain,others,list-complete
+		fi
+		;;
+	all)
+		if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
+		then
+			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST"
+		else
+			git --list-cmds=main,others
+		fi
+		;;
+	esac
 }
 
-__git_list_all_commands ()
+__git_list_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(__git_commands)
+	for i in $(__git_commands $1)
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -850,6 +862,11 @@ __git_list_all_commands ()
 	done
 }
 
+__git_list_all_commands ()
+{
+	__git_list_commands all
+}
+
 __git_all_commands=
 __git_compute_all_commands ()
 {
@@ -859,89 +876,7 @@ __git_compute_all_commands ()
 
 __git_list_porcelain_commands ()
 {
-	local i IFS=" "$'\n'
-	__git_compute_all_commands
-	for i in $__git_all_commands
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		applymbox)        : ask gittus;;
-		applypatch)       : ask gittus;;
-		archimport)       : import;;
-		cat-file)         : plumbing;;
-		check-attr)       : plumbing;;
-		check-ignore)     : plumbing;;
-		check-mailmap)    : plumbing;;
-		check-ref-format) : plumbing;;
-		checkout-index)   : plumbing;;
-		column)           : internal helper;;
-		commit-tree)      : plumbing;;
-		count-objects)    : infrequent;;
-		credential)       : credentials;;
-		credential-*)     : credentials helper;;
-		cvsexportcommit)  : export;;
-		cvsimport)        : import;;
-		cvsserver)        : daemon;;
-		daemon)           : daemon;;
-		diff-files)       : plumbing;;
-		diff-index)       : plumbing;;
-		diff-tree)        : plumbing;;
-		fast-import)      : import;;
-		fast-export)      : export;;
-		fsck-objects)     : plumbing;;
-		fetch-pack)       : plumbing;;
-		fmt-merge-msg)    : plumbing;;
-		for-each-ref)     : plumbing;;
-		hash-object)      : plumbing;;
-		http-*)           : transport;;
-		index-pack)       : plumbing;;
-		init-db)          : deprecated;;
-		local-fetch)      : plumbing;;
-		ls-files)         : plumbing;;
-		ls-remote)        : plumbing;;
-		ls-tree)          : plumbing;;
-		mailinfo)         : plumbing;;
-		mailsplit)        : plumbing;;
-		merge-*)          : plumbing;;
-		mktree)           : plumbing;;
-		mktag)            : plumbing;;
-		pack-objects)     : plumbing;;
-		pack-redundant)   : plumbing;;
-		pack-refs)        : plumbing;;
-		parse-remote)     : plumbing;;
-		patch-id)         : plumbing;;
-		prune)            : plumbing;;
-		prune-packed)     : plumbing;;
-		quiltimport)      : import;;
-		read-tree)        : plumbing;;
-		receive-pack)     : plumbing;;
-		remote-*)         : transport;;
-		rerere)           : plumbing;;
-		rev-list)         : plumbing;;
-		rev-parse)        : plumbing;;
-		runstatus)        : plumbing;;
-		sh-setup)         : internal;;
-		shell)            : daemon;;
-		show-ref)         : plumbing;;
-		send-pack)        : plumbing;;
-		show-index)       : plumbing;;
-		ssh-*)            : transport;;
-		stripspace)       : plumbing;;
-		symbolic-ref)     : plumbing;;
-		unpack-file)      : plumbing;;
-		unpack-objects)   : plumbing;;
-		update-index)     : plumbing;;
-		update-ref)       : plumbing;;
-		update-server-info) : daemon;;
-		upload-archive)   : plumbing;;
-		upload-pack)      : plumbing;;
-		write-tree)       : plumbing;;
-		var)              : infrequent;;
-		verify-pack)      : infrequent;;
-		verify-tag)       : plumbing;;
-		*) echo $i;;
-		esac
-	done
+	__git_list_commands porcelain
 }
 
 __git_porcelain_commands=
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1b34caa1e1..2f16679380 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,7 +13,7 @@ complete ()
 	return 0
 }
 
-# Be careful when updating this list:
+# Be careful when updating these lists:
 #
 # (1) The build tree may have build artifact from different branch, or
 #     the user's $PATH may have a random executable that may begin
@@ -30,7 +30,8 @@ complete ()
 #     completion for "git <TAB>", and a plumbing is excluded.  "add",
 #     "filter-branch" and "ls-files" are listed for this.
 
-GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout filter-branch'
 
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
-- 
2.17.0.664.g8924eee37a

