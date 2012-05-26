From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv2 2/2] t7512-status-warnings.sh: better advices for git status
Date: Sat, 26 May 2012 14:38:25 +0200
Message-ID: <1338035905-24166-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGGR-0001fL-RX
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab2EZMid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 08:38:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54072 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab2EZMib (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:38:31 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4QCUKLm006728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2012 14:30:20 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4QCcQ3X023906;
	Sat, 26 May 2012 14:38:26 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4QCcQ2S024358;
	Sat, 26 May 2012 14:38:26 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4QCcQ71024357;
	Sat, 26 May 2012 14:38:26 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 26 May 2012 14:30:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4QCUKLm006728
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338640222.7112@GkXk+HNxEsAiSPYwnM5cHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198557>

The following tests include several cases in which the user
needs to run 'git status' to know his current situation, whether there're
conflicts or he's in rebase/bisect/am progress.

Also, the test t7060-wtstatus.sh is now compatible with the new warning messages.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen Lucien <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
---
The 3 tests about 'am' are currently not successful because it's still
not implemented.

 t/t7060-wtstatus.sh        |    2 +
 t/t7512-status-warnings.sh |  280 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 282 insertions(+), 0 deletions(-)
 create mode 100755 t/t7512-status-warnings.sh

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index b8cb490..d9a1e18 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -30,6 +30,8 @@ test_expect_success 'Report new path with conflict' '
 
 cat >expect <<EOF
 # On branch side
+# You have unmerged paths: fix conflicts and then commit the result.
+#
 # Unmerged paths:
 #   (use "git add/rm <file>..." as appropriate to mark resolution)
 #
diff --git a/t/t7512-status-warnings.sh b/t/t7512-status-warnings.sh
new file mode 100755
index 0000000..ef3531f
--- /dev/null
+++ b/t/t7512-status-warnings.sh
@@ -0,0 +1,280 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
+#		     Thomas Nguy, Khoi Nguyen
+#		     Grenoble INP Ensimag
+#
+
+test_description='git status advices'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success 'status when conflicts unresolved' '
+	git init --shared --bare conflict_test.git &&
+	git clone conflict_test.git test1 &&
+	git clone conflict_test.git test2 &&
+	cd ./test1 &&
+	test_commit A main.txt one &&
+	cd ../test2 &&
+	test_commit B main.txt two &&
+	git push --all &&
+	cd ../test1 &&
+	test_must_fail git pull &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Your branch and '\''origin/master'\'' have diverged,
+	# and have 1 and 1 different commit each, respectively.
+	#
+	# You have unmerged paths: fix conflicts and then commit the result.
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both added:         main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when conflicts resolved before commit' '
+	echo one > main.txt &&
+	git add main.txt &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Your branch and '\''origin/master'\'' have diverged,
+	# and have 1 and 1 different commit each, respectively.
+	#
+	# You are still merging, run "git commit" to conclude merge.
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+
+
+test_expect_success 'status when rebase in progress before resolving conflicts' '
+	git commit -m "one" &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing: fix conflicts and then run "git rebase -- continue".
+	# If you would prefer to skip this patch, instead run "git rebase --skip".
+	# To check out  the original branch and stop rebasing run "git rebase --abort".
+	#
+	# Unmerged paths:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+
+test_expect_success 'status when rebase in progress before rebase --continue' '
+	test_when_finished "cd ../ && rm -rf test1 test2 conflict_test.git" &&
+	echo three >main.txt &&
+	git add main.txt &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing: all conflicts fixed; run "git rebase --continue".
+	#
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when rebasing -i in edit mode' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git fake-editor.sh" &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	git rebase -i HEAD~2 &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing in a rebase progress.
+	# You can amend the commit with
+	#	git commit --amend
+	# Once you are satisfied with your changes, run
+	#	git rebase --continue
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output &&
+	git rebase --abort
+'
+
+
+
+test_expect_success 'status in am progress : file already exists' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one main.txt "one  " &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are currently in am progress :
+	# One of the files added by the patch already exists in index !
+	# When you have resolved this problem run "git am --resolved".
+	# If you would prefer to skip this patch, instead run "git am --skip".
+	# To restore the original branch and stop patching run "git am --abort".
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	Maildir/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+
+test_expect_success 'status in am progress : file does not exist' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one main.txt "one" &&
+	git rm main.txt &&
+	git commit -m "delete main.txt" &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are currently in am progress :
+	# One of the files deleted by the patch does not exist in index !
+	# When you have resolved this problem run "git am --resolved".
+	# If you would prefer to skip this patch, instead run "git am --skip".
+	# To restore the original branch and stop patching run "git am --abort".
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	Maildir/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+
+test_expect_success 'status in am progress : patch corrupted/wrong format' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one one.txt "one" &&
+	test_commit two two.txt "two" &&
+	test_commit three three.txt "three" &&
+	git format-patch -3 -oMaildir &&
+	git rm one.txt two.txt three.txt &&
+	git commit -m "delete all" &&
+	echo error >Maildir/0002-two.patch &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are currently in am progress :
+	# One of the patches is empty or corrupted !
+	# When you have resolved this problem run "git am --resolved".
+	# If you would prefer to skip this patch, instead run "git am --skip".
+	# To restore the original branch and stop patching run "git am --abort".
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	Maildir/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+
+test_expect_success 'status when bisecting' '
+	git init git &&
+	cd git &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	git bisect start &&
+	git bisect bad &&
+	git bisect good one &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently bisecting.
+	# To get back to the original branch run "git bisect reset"
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+test_done
-- 
1.7.8
