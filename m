Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29162047F
	for <e@80x24.org>; Wed, 26 Jul 2017 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdGZNSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 09:18:41 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:35032
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750907AbdGZNSj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 09:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1501075117;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=UkdUSM/2l3p5IkiD+HqQKnNk9grphLQyzFUrR2nybss=;
        b=CSlDsFBtEb+bN6I1B/oLpSu95nQIg7f5fxknHqiW0pElVF2pb2HvTCGsmIEl7w1W
        NLnzMhCLuA62/Zd7tUewm6NqMxjRZH6W+OIGiwrEN7ZuU1ioBk3jHRXkrND6PjcKn1X
        FT39Y+2nZlb23yMfq2ci5D8Nv5RqyrN7tQSnoP44=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015d7f0c9403-16bd1de5-3b6c-4d23-a3fb-75a26c378c62-000000@eu-west-1.amazonses.com>
Subject: [PATCH] remote: split and simplify messages
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Jul 2017 13:18:37 +0000
X-SES-Outgoing: 2017.07.26-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Splitting a single sentence across multiple lines could
degrade readability. Further, long messages are likely
to be ignored by users.

Split the sentences and simplify it to improve their readability.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 remote.c                   | 18 ++++-----
 t/t2020-checkout-detach.sh |  3 +-
 t/t7508-status.sh          | 96 +++++++++++++++++++++++-----------------------
 3 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/remote.c b/remote.c
index 60d004392109f..e4e241d5e20f4 100644
--- a/remote.c
+++ b/remote.c
@@ -2093,10 +2093,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
 		strbuf_addf(sb,
-			Q_("Your branch is behind '%s' by %d commit, "
-			       "and can be fast-forwarded.\n",
-			   "Your branch is behind '%s' by %d commits, "
-			       "and can be fast-forwarded.\n",
+			Q_("Your branch is behind '%s' by %d commit.\n"
+			       "It can be fast-forwarded.\n",
+			   "Your branch is behind '%s' by %d commits.\n"
+			       "It can be fast-forwarded.\n",
 			   theirs),
 			base, theirs);
 		if (advice_status_hints)
@@ -2104,12 +2104,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
+			Q_("Your branch and '%s' have diverged.\n"
+			       "They have %d and %d different commit, respectively.\n",
+			   "Your branch and '%s' have diverged.\n"
+			       "They have %d and %d different commits, respectively.\n",
 			   ours + theirs),
 			base, ours, theirs);
 		if (advice_status_hints)
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index fbb4ee9bb42db..4e1c74c878560 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -150,7 +150,8 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 '
 
 cat >expect <<'EOF'
-Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
+Your branch is behind 'master' by 1 commit.
+It can be fast-forwarded.
   (use "git pull" to update your local branch)
 EOF
 test_expect_success 'tracking count is accurate after orphan check' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 43d19a9b22920..fd7f27ee01ab0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -88,8 +88,8 @@ EOF
 test_expect_success 'status --column' '
 	cat >expect <<\EOF &&
 # On branch master
-# Your branch and '\''upstream'\'' have diverged,
-# and have 1 and 2 different commits each, respectively.
+# Your branch and '\''upstream'\'' have diverged.
+# They have 1 and 2 different commits, respectively.
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
@@ -122,8 +122,8 @@ test_expect_success 'status --column status.displayCommentPrefix=false' '
 
 cat >expect <<\EOF
 # On branch master
-# Your branch and 'upstream' have diverged,
-# and have 1 and 2 different commits each, respectively.
+# Your branch and 'upstream' have diverged.
+# They have 1 and 2 different commits, respectively.
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
@@ -199,8 +199,8 @@ test_expect_success 'commit ignores status.displayCommentPrefix=false in COMMIT_
 
 cat >expect <<\EOF
 On branch master
-Your branch and 'upstream' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and 'upstream' have diverged.
+They have 1 and 2 different commits, respectively.
 
 Changes to be committed:
 	new file:   dir2/added
@@ -272,8 +272,8 @@ test_expect_success 'status with gitignore' '
 
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -341,8 +341,8 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -414,8 +414,8 @@ test_expect_success 'setup dir3' '
 test_expect_success 'status -uno' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -444,8 +444,8 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 test_expect_success 'status -uno (advice.statusHints false)' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
 
 Changes to be committed:
 	new file:   dir2/added
@@ -478,8 +478,8 @@ test_expect_success 'status -s (status.showUntrackedFiles no)' '
 test_expect_success 'status -unormal' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -536,8 +536,8 @@ test_expect_success 'status -s (status.showUntrackedFiles normal)' '
 test_expect_success 'status -uall' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -599,8 +599,8 @@ test_expect_success 'status -s (status.showUntrackedFiles all)' '
 test_expect_success 'status with relative paths' '
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -670,8 +670,8 @@ test_expect_success 'setup unique colors' '
 test_expect_success 'status with color.ui' '
 	cat >expect <<\EOF &&
 On branch <GREEN>master<RESET>
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -796,8 +796,8 @@ test_expect_success 'status --porcelain respects -b' '
 test_expect_success 'status without relative paths' '
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -846,8 +846,8 @@ test_expect_success 'status -s without relative paths' '
 test_expect_success 'dry-run of partial commit excluding new file in index' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -890,8 +890,8 @@ test_expect_success 'setup status submodule summary' '
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -950,8 +950,8 @@ head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 test_expect_success 'status submodule summary' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1012,8 +1012,8 @@ test_expect_success 'status -s submodule summary' '
 test_expect_success 'status submodule summary (clean submodule): commit' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes not staged for commit:
@@ -1062,8 +1062,8 @@ test_expect_success 'status -z implies porcelain' '
 test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1119,8 +1119,8 @@ touch .gitmodules
 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1231,8 +1231,8 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1291,8 +1291,8 @@ head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1375,8 +1375,8 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 
 cat > expect << EOF
 ; On branch master
-; Your branch and 'upstream' have diverged,
-; and have 2 and 2 different commits each, respectively.
+; Your branch and 'upstream' have diverged.
+; They have 2 and 2 different commits, respectively.
 ;   (use "git pull" to merge the remote branch into yours)
 ;
 ; Changes to be committed:
@@ -1426,8 +1426,8 @@ test_expect_success "status (core.commentchar with two chars with submodule summ
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes not staged for commit:
@@ -1454,8 +1454,8 @@ EOF
 test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summary' '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1577,8 +1577,8 @@ test_expect_success 'git commit --dry-run will show a staged but ignored submodu
 	git add sm &&
 	cat >expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:

--
https://github.com/git/git/pull/391
