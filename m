From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/6] Documentation/config: mention "now" and "never" for 'expire' settings
Date: Tue, 28 Jul 2015 16:06:10 -0400
Message-ID: <1438113975-4915-2-git-send-email-sunshine@sunshineco.com>
References: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB9G-0001VV-Q6
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbbG1UGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:06:46 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35095 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbG1UGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:06:45 -0400
Received: by igr7 with SMTP id 7so132338208igr.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dctCdcnqCbh96qqTbjHQRC9E/z9RvhIb17dMVqq+6Do=;
        b=LhHXwsC46LzFHb2FclI5eIyKsWZ1LSJ77XcCwYS8Bg0stAC5h8iufUpIM2i9cL/tBm
         X78Zi6mJalPK9qPLZUj+i8hk81UQN3r2+sA0kj609+l4A+5XWDB/Ynw8Kp0TeO+29Mtz
         N45cS3X8tIQP1CGgdU85krJg/k0xSHc9x33sFh7qjuEaP7s3GgaljHEC3Cd8xCN+YfnL
         p00mycVdddJ+0neT7bOqg5/6SGfMmJ91yhFCbgMRf76i4XTZiU4HGPkQMOOTPOhE6Vlv
         qj/0NYOxMU+5d73lf+IwSSUIr7wX4oIzef6MeULXKGRPunEByXDXOBbPvrqxoufhkNC8
         7oeQ==
X-Received: by 10.50.102.68 with SMTP id fm4mr10403943igb.25.1438114004649;
        Tue, 28 Jul 2015 13:06:44 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id r16sm15195896ioe.19.2015.07.28.13.06.43
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 13:06:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.490.g8c70279
In-Reply-To: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274828>

In addition to approxidate-style values ("2.months.ago", "yesterday"),
consumers of 'gc.*expire*' configuration variables also accept and
respect 'now' ("do it immediately") and 'never' ("suppress entirely").

Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1:
* grammatical corrections
* use "now"/"never" consistently; avoid "all"/"false"

 Documentation/config.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 583d24f..e09ee02 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1226,20 +1226,24 @@ gc.packrefs::
 gc.pruneexpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
 	Override the grace period with this config variable.  The value
-	"now" may be used to disable this  grace period and always prune
-	unreachable objects immediately.
+	"now" may be used to disable this grace period and always prune
+	unreachable objects immediately, or "never" may be used to
+	suppress pruning.
 
 gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
 	This config variable can be used to set a different grace
 	period. The value "now" may be used to disable the grace
-	period and prune $GIT_DIR/worktrees immediately.
+	period and prune $GIT_DIR/worktrees immediately, or "never"
+	may be used to suppress pruning.
 
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
-	this time; defaults to 90 days.  With "<pattern>" (e.g.
+	this time; defaults to 90 days. The value "now" expires all
+	entries immediately, and "never" suppresses expiration
+	altogether. With "<pattern>" (e.g.
 	"refs/stash") in the middle the setting applies only to
 	the refs that match the <pattern>.
 
@@ -1247,7 +1251,9 @@ gc.reflogexpireunreachable::
 gc.<ref>.reflogexpireunreachable::
 	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
-	defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
+	defaults to 30 days. The value "now" expires all entries
+	immediately, and "never" suppresses expiration altogether.
+	With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
 
-- 
2.5.0.rc3.490.g8c70279
