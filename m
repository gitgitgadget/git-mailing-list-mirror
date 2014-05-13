From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 04/29] Allow "guilt import-commit" to run from a dir which contains spaces.
Date: Tue, 13 May 2014 22:30:40 +0200
Message-ID: <1400013065-27919-5-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:33:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJNq-0000OY-4a
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbaEMUcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:32:52 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:61439 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaEMUcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:32:45 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so703905lbd.14
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UA4CV5QZjKTjK6OCHjrG+iVoPlXNho3hEvLJWc8rlmw=;
        b=a1JYeswqKO8igHAEEwghCPjs4LsQAMjWhlOkQzHMsHmzPpuHsNPe/KPVKbhO1bYgRu
         Jay/24oRDp0dI75AtaC5vO11pCNcaviCuRtEAgc8ba2gcgaMZfYGNke7phYwJUXE0UlF
         WlKOwZyd3/XWecCBsH51SRgQp3wGX1DlqWKCohvo+i3tJbWAmLgk2TytZGgUsjkE/pV4
         KT0dVbolORR9fIUHzCmbt8Fmp2Rjk9BrQm0xH1Rb+FY7xjxn0QZ2w1USpe+zYfEF20Ar
         XpbSvJOkmtEd428oC7vma2M/GOtfmAp0820ik58EPEzmJGL24HTwjiSlY6Vf3aoPcH8/
         Rsvg==
X-Gm-Message-State: ALoCoQlV83UxpM+pODlxrfQzzXK9Kza1tdx6DRFUqcWLGd/b3wnJQvh7IoLgnCOvmUaiILzcp/hx
X-Received: by 10.152.5.202 with SMTP id u10mr3383179lau.42.1400013163869;
        Tue, 13 May 2014 13:32:43 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.32.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:32:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248819>

Signed-off-by: Per Cederqvist <cederp@opera.com>
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
