Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29E01F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756918AbeEJIr2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:28 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39442 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756897AbeEJIrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id j193-v6so1824126lfg.6
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IR41N97CZn4hTYf62LpPsAfRc8iPgr8n1/lt47aElBM=;
        b=WCMmiKaWjpDpTNw+92g1ZlDDtzQw1X+3ymIe88HzwSNynTdOrPGlc4gsSP6P5cl+TT
         Ni8ot+5YswLtoLGtxPHuIyiWt4L0QjG8w3n/HeHFx1roxFHTHAaWp/QnqjdTRTApHTs8
         28evGq+0juSVPG5hsmFCUoM8QUP7qyN1Y+eHxqOh4SpJB5nUsTg84Ot4QkwD8KPiWuAl
         R0CfTVjJ2isam0Acjk53hbzV/ZkMgxeoHQYXdiqyCTaIvAOKnc/kERVTv3akqIGU2WJn
         +Is9vWmJvF5W2qmCsGGMpF1BZAdIG8jIBjoCKPIVzir0bNgMFNKk1e2GXsS3fFVRFExM
         zhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IR41N97CZn4hTYf62LpPsAfRc8iPgr8n1/lt47aElBM=;
        b=fWK8K1xU/tD/3GaJXwzdmllM2/+MmClHW9GlOi6kMvWUm3SmuenPvetFRX5SK1unti
         98FzRKq1F8n6sqRGMG3rQpC9U1G8PuF8TFu+Diq9RK9bTQX7h+VxxTf15/5OkUszcFFD
         aAftI6E40hALQEUn4lLO6v/Qy40LqxXXKOi+K4KhmvhSwWIdBCb2YEsHUKTxGO1lnHfS
         BT4hr88tpW5xiCbeohkge90XA1m5msqairTorwwCDx69Fd5x1U3B1yh/NFLtKspfu5iK
         VjU+LchhT1h5ZXcjeoQEQYcviFSSvghvvCKCtusnRlE/7R3vqz6dNI9tahsTATEZIE1l
         U5gA==
X-Gm-Message-State: ALKqPwdMRNJxSBTGBcF7vGs1i/dp7zPDFFqbr6T9in4/Sbo3OQ0xdaN+
        n3z8y2Lf03Iofr6lh0lEyT8=
X-Google-Smtp-Source: AB8JxZom/zuOjU3jGaJAKFaM/ZWwLzHFOTkZGmMxvXS5vEvI8cfogpnMAgMKCItTh9qzpdKXhgbehA==
X-Received: by 2002:a2e:8993:: with SMTP id c19-v6mr492647lji.123.1525942032102;
        Thu, 10 May 2018 01:47:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 12/13] completion: let git provide the completable command list
Date:   Thu, 10 May 2018 10:46:51 +0200
Message-Id: <20180510084652.25880-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
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
index 9c70c69193..3e21ddfcfb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,11 +47,11 @@
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
@@ -61,7 +61,7 @@ git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain           history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
-git-cherry                              ancillaryinterrogators
+git-cherry                              ancillaryinterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
@@ -69,7 +69,7 @@ git-clone                               mainporcelain           init
 git-column                              purehelpers
 git-commit                              mainporcelain           history
 git-commit-tree                         plumbingmanipulators
-git-config                              ancillarymanipulators
+git-config                              ancillarymanipulators           complete
 git-count-objects                       ancillaryinterrogators
 git-credential                          purehelpers
 git-credential-cache                    purehelpers
@@ -83,7 +83,7 @@ git-diff                                mainporcelain           history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
-git-difftool                            ancillaryinterrogators
+git-difftool                            ancillaryinterrogators          complete
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain           remote
@@ -92,20 +92,20 @@ git-filter-branch                       ancillarymanipulators
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
@@ -119,12 +119,12 @@ git-merge-base                          plumbinginterrogators
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
@@ -140,28 +140,29 @@ git-quiltimport                         foreignscminterface
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
@@ -180,7 +181,7 @@ git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
-git-whatchanged                         ancillaryinterrogators
+git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           guide
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4e724a5b76..908692ea52 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -835,18 +835,30 @@ __git_complete_strategy ()
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
@@ -855,6 +867,11 @@ __git_list_all_commands ()
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
@@ -864,89 +881,7 @@ __git_compute_all_commands ()
 
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
2.17.0.705.g3525833791

