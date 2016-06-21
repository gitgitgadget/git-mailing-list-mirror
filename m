Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F28520189
	for <e@80x24.org>; Tue, 21 Jun 2016 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbcFULqA (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:46:00 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:43884 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751857AbcFULp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:45:59 -0400
Received: (qmail 2470 invoked from network); 21 Jun 2016 11:45:56 -0000
Received: (qmail 1542 invoked from network); 21 Jun 2016 11:45:56 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:45:51 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/11] i18n: add--interactive: i18n of help_patch_cmd
Date:	Tue, 21 Jun 2016 11:44:08 +0000
Message-Id: <20160621114413.9467-6-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark help message of help_patch_cmd for translation.  The message must
be unfolded to be free of variables so we can have hight quality
translations.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 65 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 909f396..af715b3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1179,15 +1179,58 @@ sub edit_hunk_loop {
 }
 
 sub help_patch_cmd {
-	my $verb = lc $patch_mode_flavour{VERB};
-	my $target = $patch_mode_flavour{TARGET};
-	print colored $help_color, <<EOF ;
-y - $verb this hunk$target
-n - do not $verb this hunk$target
-q - quit; do not $verb this hunk or any of the remaining ones
-a - $verb this hunk and all later hunks in the file
-d - do not $verb this hunk or any of the later hunks in the file
-g - select a hunk to go to
+	if ($patch_mode eq 'stage') {
+		print colored $help_color, __(
+"y - stage this hunk
+n - do not stage this hunk
+q - quit; do not stage this hunk or any of the remaining ones
+a - stage this hunk and all later hunks in the file
+d - do not stage this hunk or any of the later hunks in the file");
+	} elsif ($patch_mode eq 'stash') {
+		print colored $help_color, __(
+"y - stash this hunk
+n - do not stash this hunk
+q - quit; do not stash this hunk or any of the remaining ones
+a - stash this hunk and all later hunks in the file
+d - do not stash this hunk or any of the later hunks in the file");
+	} elsif ($patch_mode eq 'reset_head') {
+		print colored $help_color, __(
+"y - unstage this hunk
+n - do not unstage this hunk
+q - quit; do not unstage this hunk or any of the remaining ones
+a - unstage this hunk and all later hunks in the file
+d - do not unstage this hunk or any of the later hunks in the file");
+	} elsif ($patch_mode eq 'reset_nothead') {
+		print colored $help_color, __(
+"y - apply this hunk to index
+n - do not apply this hunk to index
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file");
+	} elsif ($patch_mode eq 'checkout_index') {
+		print colored $help_color, __(
+"y - discard this hunk from worktree
+n - do not discard this hunk from worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file");
+	} elsif ($patch_mode eq 'checkout_head') {
+		print colored $help_color, __(
+"y - discard this hunk from index and worktree
+n - do not discard this hunk from index and worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file");
+	} elsif ($patch_mode eq 'checkout_nothead') {
+		print colored $help_color, __(
+"y - apply this hunk to index and worktree
+n - do not apply this hunk to index and worktree
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file");
+	}
+	print colored $help_color, "\n", __(
+"g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
@@ -1195,8 +1238,8 @@ k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
-? - print help
-EOF
+? - print help"),
+"\n";
 }
 
 sub apply_patch {
-- 
2.6.6

