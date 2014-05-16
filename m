From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 04/31] Allow "guilt import-commit" to run from a dir which contains spaces.
Date: Fri, 16 May 2014 16:45:51 +0200
Message-ID: <1400251578-17221-5-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:47:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJQM-0006of-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368AbaEPOro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:47:44 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:37721 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbaEPOrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:47:41 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so2013942lbg.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=exG+NY04RyH24CNGpYs4objeDz4BiQMelKb64eiM/mE=;
        b=EdkbWsb25k2R7dFBsOWjPKxRGkesdYBaNjAC+THB4HXI3V5NVoBLt3E7iWysHfITRH
         Qb4rqCHeyGNDR2eXTVOVp3fYEePtfzfgDizeD49JOhpLZRT7qiSfigRqQRNtYUg8xXSh
         JlVqop4kTQu23C3f5geZvDyN7r8r/OtnXJWm5WweLu0JmQ1u59aVXlAqb4Zxok2d2HJg
         ZmdyaN0KHJ7YeWp3+hVt6v8HPaaCpwNQRWcJlFhzK1N6OdHMbuHZW3v3eh3zzokac/wH
         1/rSi4LNpJyAEG2KfSLLReWYkU8Cizj3zyzAF1gBXZaPUKE7ligeOBxCTgiSDDOhqR8c
         F/tw==
X-Gm-Message-State: ALoCoQnQ4Stij6Iz6guGzoJdjjZuR5Lt54oXH3/RUDHu8iPmuXylZYMLHq34A8hTMPCLmVgFVUk1
X-Received: by 10.113.5.40 with SMTP id cj8mr1752964lbd.69.1400251660259;
        Fri, 16 May 2014 07:47:40 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.47.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:47:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249312>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-import-commit | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/guilt-import-commit b/guilt-import-commit
index 20dcee2..f14647c 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -23,7 +23,7 @@ if ! must_commit_first; then
 fi
 
 disp "About to begin conversion..." >&2
-disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
+disp "Current head: `git rev-parse \`git_branch\``" >&2
 
 for rev in `git rev-list $rhash`; do
 	s=`git log --pretty=oneline -1 $rev | cut -c 42-`
@@ -46,7 +46,7 @@ for rev in `git rev-list $rhash`; do
 		do_make_header $rev
 		echo ""
 		git diff --binary $rev^..$rev
-	) > $GUILT_DIR/$branch/$fname
+	) > "$GUILT_DIR/$branch/$fname"
 
 	# FIXME: grab the GIT_AUTHOR_DATE from the commit object and set the
 	# timestamp on the patch
@@ -68,6 +68,6 @@ for rev in `git rev-list $rhash`; do
 done
 
 disp "Done." >&2
-disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
+disp "Current head: `git rev-parse \`git_branch\``" >&2
 
 }
-- 
1.8.3.1
