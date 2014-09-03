From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 3/3] revert/cherry-pick --no-verify: Update documentation
Date: Wed,  3 Sep 2014 16:03:54 +0200
Message-ID: <1409753034-9459-4-git-send-email-johan@herland.net>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
Cc: =?UTF-8?q?Lars=20Gullik=20Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 16:13:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPBJS-0005PY-NE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 16:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbaICONZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 10:13:25 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:38118 "EHLO
	alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbaICONY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 10:13:24 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Sep 2014 10:13:24 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AigFAJwfB1StJV2T/2dsb2JhbABZgw2BKtAaAYELFneEBAEFeRBRVxmIQr1oARePTQeETAWGFatmg2M7L4JPAQEB
X-IronPort-AV: E=Sophos;i="5.04,457,1406592000"; 
   d="scan'208";a="74511595"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-1.cisco.com with ESMTP; 03 Sep 2014 14:04:07 +0000
Received: from jherland.rd.tandberg.com ([10.47.39.59])
	by rcdn-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id s83E41HD005685;
	Wed, 3 Sep 2014 14:04:06 GMT
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1409753034-9459-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256391>

Add --no-verify to the revert and cherry-pick man pages. Also mention
revert and cherry-pick in the corresponding documentation for the
pre-commit and commit-msg hooks.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-cherry-pick.txt |  4 ++++
 Documentation/git-revert.txt      |  4 ++++
 Documentation/githooks.txt        | 20 ++++++++++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1c03c79..f56818f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -97,6 +97,10 @@ OPTIONS
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
 
+--no-verify::
+	This option bypasses the pre-commit and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cceb5f2..c9fb148 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -80,6 +80,10 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
+--no-verify::
+	This option bypasses the pre-commit and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 -S[<key-id>]::
 --gpg-sign[=<key-id>]::
 	GPG-sign commits.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..9c3bf6c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -72,11 +72,11 @@ the outcome of 'git am'.
 pre-commit
 ~~~~~~~~~~
 
-This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes no parameter, and is
-invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with non-zero status from this script
-causes the 'git commit' to abort.
+This hook is invoked by 'git commit' (including 'git revert' and
+'git cherry-pick'), and can be bypassed with `--no-verify` option.
+It takes no parameter, and is invoked before obtaining the proposed
+commit log message and making a commit.  Exiting with non-zero
+status from this script causes the 'git commit' to abort.
 
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
@@ -114,11 +114,11 @@ out the `Conflicts:` part of a merge's commit message.
 commit-msg
 ~~~~~~~~~~
 
-This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes a single parameter, the
-name of the file that holds the proposed commit log message.
-Exiting with non-zero status causes the 'git commit' to
-abort.
+This hook is invoked by 'git commit' (including 'git revert'
+and 'git cherry-pick'), and can be bypassed with `--no-verify`
+option.  It takes a single parameter, the name of the file that
+holds the proposed commit log message. Exiting with non-zero
+status causes the 'git commit' to abort.
 
 The hook is allowed to edit the message file in place, and can
 be used to normalize the message into some project standard
-- 
2.0.0.rc4.501.gdaf83ca
