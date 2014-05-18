From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 04/33] Allow "guilt import-commit" to run from a dir which contains spaces.
Date: Sun, 18 May 2014 23:59:40 +0200
Message-ID: <1400450409-30998-5-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:04:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Bi-00078z-O1
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbaERWEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:04:07 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:39608 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaERWEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:04:05 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so3438727lbv.35
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=exG+NY04RyH24CNGpYs4objeDz4BiQMelKb64eiM/mE=;
        b=JIdCEJJ1K0P047BzseZpvltGy7FvEUq3/xn6vD1XqD1TkHvKtrfinhA7eZBk3X4nuR
         ldsxghVlfrDf1j12JwNcuEe+3pU19lLOWk01sNJ9XK+C4St/iMao/kwQkWfHoWzFtWT6
         jg15FEa/+UawY1EFer0aClqdQNm55pVk0gQTfZR9YyHeJV2JlryMBzd0BJcCs3bYze/0
         VTwjQXC7tHclsTRHDI47zGcV3C8mYPVx2yvq6aDgvPqWcC1eIIhVUThSXEBY5ZzwZjdm
         2GHQuEQ1NrkcrvJTxw8AJiFXKRRlFYbMzYAoixcQCR+KB58U3sXCbHFXW4eYk81ui7O5
         KHhg==
X-Gm-Message-State: ALoCoQnkPi3xhsG1/7AlIfk1Wp5kUlGwZftEkXST5yIDfUs/se1f9zFk1i7uXqG6Ns+QaPBBtMEa
X-Received: by 10.152.4.137 with SMTP id k9mr13205894lak.46.1400450643605;
        Sun, 18 May 2014 15:04:03 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.04.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:04:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249519>

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
