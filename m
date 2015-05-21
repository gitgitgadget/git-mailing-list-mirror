From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v11 2/5] command-list.txt: add the common groups block
Date: Thu, 21 May 2015 19:39:19 +0200
Message-ID: <1432229962-21405-3-git-send-email-sebastien.guimmara@gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 19:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUSa-0000Z9-AH
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbbEURkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 13:40:37 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33032 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038AbbEURk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:40:29 -0400
Received: by wicmx19 with SMTP id mx19so19913265wic.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IgiTDbxoY4YNvMitnbw50py+ZjVwP3HmNFtscnCAq6U=;
        b=IWJ8uwSZ75COPF6HmGQACqPKW1uyeMB+SbnyGklTcucNjzVYwrbrqr7USsafazt2rX
         UP8XmeQ1zLDqfwZ0PiOr+PlU3wR9PaNJxd/NPQH48B50DMJUNUXH1L9OY0roFq0YsAiu
         VCOt4P3udXFaa6fYxlN47C+8f8b1+0vsknk4VA/ftL+RLbw1WsgvSNvXBAlUwSBdH9uF
         Kln4xzUsqO9BGhEEBf7p8nXI1hiSi6aBgwjKHuyMbFN3yXfbGvj+MIM/nGW3x7e+Im71
         J+/HmbBlRAE3KL6cqQli38kljdlWg5IKXQa+MDdzw+krP2utJOHmEGBEGFbQKjKGr6xR
         DU1A==
X-Received: by 10.194.201.71 with SMTP id jy7mr7173377wjc.93.1432230028453;
        Thu, 21 May 2015 10:40:28 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v3sm3660231wix.8.2015.05.21.10.40.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 10:40:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269622>

The ultimate goal is for "git help" to display common commands in
groups rather than alphabetically. As a first step, define the
groups in a new block, and then assign a group to each
common command.

Add a block at the beginning of command-list.txt:

    init         start a working area (see also: git help tutorial)
    worktree     work on the current change (see also:[...]
    info         examine the history and state (see also: git [...]
    history      grow, mark and tweak your history
    remote       collaborate (see also: git help workflows)

storing information about common commands group, then map each common
command to a group:

    git-add          mainporcelain        common worktree

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by:  Emma Jane Hogbin Westby <emma.westby@gmail.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Documentation/howto/new-command.txt |  4 ++-
 command-list.txt                    | 51 ++++++++++++++++++++++-------=
--------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
index d7de5a3..6d772bd 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
 that categorizes commands by type, so they can be listed in appropriat=
e
 subsections in the documentation's summary command list.  Add an entry
 for yours.  To understand the categories, look at git-commands.txt
-in the main directory.
+in the main directory.  If the new command is part of the typical Git
+workflow and you believe it common enough to be mentioned in 'git help=
',
+map this command to a common group in the column [common].
=20
 7. Give the maintainer one paragraph to include in the RelNotes file
 to describe the new feature; a good place to do so is in the cover
diff --git a/command-list.txt b/command-list.txt
index 181a9c2..32ddab3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,14 @@
+# common commands are grouped by themes
+# these groups are output by 'git help' in the order declared here.
+# map each common command in the command list to one of these groups.
+### common groups (do not change this line)
+init         start a working area (see also: git help tutorial)
+worktree     work on the current change (see also: git help everyday)
+info         examine the history and state (see also: git help revisio=
ns)
+history      grow, mark and tweak your common history
+remote       collaborate (see also: git help workflows)
+
+# List of known git commands.
 ### command list (do not change this line)
 # command name                          category [deprecated] [common]
 git-add                                 mainporcelain common
@@ -6,24 +17,24 @@ git-annotate                            ancillaryint=
errogators
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
-git-bisect                              mainporcelain common
+git-bisect                              mainporcelain           common=
 info
 git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain common
+git-branch                              mainporcelain           common=
 history
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain common
+git-checkout                            mainporcelain           common=
 history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
-git-clone                               mainporcelain common
+git-clone                               mainporcelain           common=
 init
 git-column                              purehelpers
-git-commit                              mainporcelain common
+git-commit                              mainporcelain           common=
 history
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
@@ -35,14 +46,14 @@ git-cvsimport                           foreignscmi=
nterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain common
+git-diff                                mainporcelain           common=
 history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
-git-fetch                               mainporcelain common
+git-fetch                               mainporcelain           common=
 remote
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
@@ -51,7 +62,7 @@ git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain           common=
 info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators
@@ -60,17 +71,17 @@ git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain common
+git-init                                mainporcelain           common=
 init
 git-instaweb                            ancillaryinterrogators
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
-git-log                                 mainporcelain common
+git-log                                 mainporcelain           common=
 info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
-git-merge                               mainporcelain common
+git-merge                               mainporcelain           common=
 history
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
@@ -79,7 +90,7 @@ git-mergetool                           ancillarymani=
pulators
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain common
+git-mv                                  mainporcelain           common=
 worktree
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
@@ -90,11 +101,11 @@ git-parse-remote                        synchelper=
s
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain common
-git-push                                mainporcelain common
+git-pull                                mainporcelain           common=
 remote
+git-push                                mainporcelain           common=
 remote
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain common
+git-rebase                              mainporcelain           common=
 history
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
@@ -103,28 +114,28 @@ git-repack                              ancillary=
manipulators
 git-replace                             ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain common
+git-reset                               mainporcelain           common=
 worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain common
+git-rm                                  mainporcelain           common=
 worktree
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
-git-show                                mainporcelain common
+git-show                                mainporcelain           common=
 info
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
-git-status                              mainporcelain common
+git-status                              mainporcelain           common=
 info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain common
+git-tag                                 mainporcelain           common=
 history
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
--=20
2.4.0.GIT
