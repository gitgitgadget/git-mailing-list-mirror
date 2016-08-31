Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6EA1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 12:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbcHaMdJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 08:33:09 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:36735 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbcHaMdI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 08:33:08 -0400
Received: (qmail 13731 invoked from network); 31 Aug 2016 12:33:06 -0000
Received: (qmail 8348 invoked from network); 31 Aug 2016 12:33:06 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 31 Aug 2016 12:33:04 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 06/11] i18n: add--interactive: i18n of help_patch_cmd
Date:   Wed, 31 Aug 2016 12:31:25 +0000
Message-Id: <1472646690-9699-7-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark help message of help_patch_cmd for translation.  The message must
be unfolded to be free of variables so we can have high quality
translations.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 65 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5b89b97..acbfa4e 100755
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
2.7.4

