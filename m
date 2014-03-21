From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 04/28] Allow "guilt import-commit" to run from a dir which contains spaces.
Date: Fri, 21 Mar 2014 08:31:42 +0100
Message-ID: <1395387126-13681-5-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyg-00045e-6U
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339AbaCUHdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:24 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:60225 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbaCUHdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:06 -0400
Received: by mail-la0-f49.google.com with SMTP id mc6so1373188lab.36
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kOxqFDr3Y0JE85iceJB5pXmMSc7LDzJuJtvVYcRUILA=;
        b=Ir3fVcqJyi+bXJAtEgCRcN5Y4V32tWzJxsGZqjSNVWr7eELJJN5aZbcac8i6S65kzf
         NW84WtEn+ohynHLPyVX7pi+PhQIXEbI6OTjOJU0Z29qzf/KZFUhnpzZ1JJwljJZcfOeK
         27sT2gIfG+2MOFceIhJjpHS04FYkenhE5BRcYj0cHfCNmc1KrkbL6GyBdYKri5OZXQ0P
         xqm0+5zi/Y/+zsxFCH5oZf/k/UHmE4s9EOynN4zszjSAJBOgyORoTZiryQCUB9b4hSc5
         jTHxpS6+/URzIB6j9SsRdCikJXonP73gjKg52YB37Qm9ReS5SGAMZoTV0Fuccuzm1ids
         DvGA==
X-Gm-Message-State: ALoCoQkU+83svhopC7h7gwbYiT2gT/oNowrj4mTvYgtH2pAyPMyBQ/SmGZIyc088xDt5ueC7jn/u
X-Received: by 10.112.50.194 with SMTP id e2mr31439047lbo.4.1395387184702;
        Fri, 21 Mar 2014 00:33:04 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244670>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-import-commit | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/guilt-import-commit b/guilt-import-commit
index 20dcee2..9488ded 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -23,7 +23,7 @@ if ! must_commit_first; then
 fi
 
 disp "About to begin conversion..." >&2
-disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
+disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
 
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
+disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
 
 }
-- 
1.8.3.1
