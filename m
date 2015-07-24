From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/6] Documentation/config: mention "now" and "never" for 'expire' settings
Date: Fri, 24 Jul 2015 00:00:53 -0400
Message-ID: <1437710457-38592-3-git-send-email-sunshine@sunshineco.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUB8-0004MA-1a
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbbGXEBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:42 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35357 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbGXEBe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:34 -0400
Received: by iecri3 with SMTP id ri3so9644677iec.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MWpxTJqMC1BZQRfNR8tUJ1IAn7LrMUov3gAMsB9JU6g=;
        b=fkgC2dqS/8/+p+OJBJ00y0JNozJLOyVlXGtPHi5cTKxrf4f9YfoAXdvd52srPyp1ZH
         twP0HFk2r6g8+FiykNy5qPnZUD0SWHS21vvPe2CX3PYj3YNlpyMfgT++ffiWBsOhGYqj
         QKpcBbITuErJWAL28g9zkFC6KfVg2y1hXmuFq7zq9vkrd5pUxkJe1C4oKDW2yq3FAAir
         hEf2/pBWi2U0MRNmM6vUGRBcU8M4Sqx2iRDaJInJ86ZGiKrz800pkpFHpfQqRlX3W1MJ
         laN8bXeAwinbIn0WF50LM3r96E/jTH7GFN9e7jhLiMBh4lVDDKfLoLYBtLcJZ2SZLQLd
         nYlA==
X-Received: by 10.50.77.49 with SMTP id p17mr2943156igw.72.1437710494241;
        Thu, 23 Jul 2015 21:01:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
In-Reply-To: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274539>

In addition to approxidate-style values ("2.months.ago", "yesterday"),
consumers of 'gc.*expire*' configuration variables also accept and
respect 'now'/'all' ("do it immediately") and 'never'/'false' ("suppress
entirely").

Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Reference: http://article.gmane.org/gmane.comp.version-control.git/274325

I sneaked in a minor whitespace fix.

 Documentation/config.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1a8a399..cc920c0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1307,20 +1307,22 @@ gc.packRefs::
 gc.pruneExpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
 	Override the grace period with this config variable.  The value
-	"now" may be used to disable this  grace period and always prune
-	unreachable objects immediately.
+	"now" may be used to disable this grace period and always prune
+	unreachable objects immediately; or "never" to suppress pruning.
 
 gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
 	This config variable can be used to set a different grace
 	period. The value "now" may be used to disable the grace
-	period and prune $GIT_DIR/worktrees immediately.
+	period and prune $GIT_DIR/worktrees immediately; or "never" to
+	suppress pruning.
 
 gc.reflogExpire::
 gc.<pattern>.reflogExpire::
 	'git reflog expire' removes reflog entries older than
-	this time; defaults to 90 days.  With "<pattern>" (e.g.
+	this time; defaults to 90 days. The value "all" expires all
+	entries; and "false" disables expiration. With "<pattern>" (e.g.
 	"refs/stash") in the middle the setting applies only to
 	the refs that match the <pattern>.
 
@@ -1328,7 +1330,8 @@ gc.reflogExpireUnreachable::
 gc.<ref>.reflogExpireUnreachable::
 	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
-	defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
+	defaults to 30 days. The value "all" expires all entries; and
+	"false" disables expiration. With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
 
-- 
2.5.0.rc3.407.g68aafd0
