From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 3/7] git-clone - Set remotes.origin config variable
Date: Sun,  3 Feb 2008 12:20:45 -0500
Message-ID: <1202059249-3532-4-git-send-email-mlevedahl@gmail.com>
References: <1202059249-3532-1-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-2-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-3-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Feb 03 18:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLiXX-00062p-KQ
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758594AbYBCRVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYBCRVJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:21:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:20267 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833AbYBCRVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:21:04 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1716427fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i1Qb4El+FAyNuJoc5xZZ2AHVD9XGOx6jYvymczMMyCA=;
        b=eFv28su1ETbcWOQzgJbNGJ+juw7PnHslT+1/KQmV6iRCDmXi4pujsfVCnwTJhWU82/OJH7p7cJjJ8yHckYQvn2i5PogBsdi6ziYolnusiKojoKDtb4tAKQWgD0aR61xYauOfq5XRcnJyAYUXlO3MV8IK8yaSnXCXQlVv/Yf6aIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WU34a9uA2NVy4d37PonfZsrlXPJsTAYckiQRiZgLdPM8o1u/yzsbrQnH/W0n5ZCyGCqyd00FGVtgkwvMzXNf4GWMqJfIh4lR6acn222I5Ag149vcLHhk4kFJZXSAi01GE8AU1V8b2EiM1nODBNklZQjLca8tiveSgSLBBRyPgwo=
Received: by 10.82.184.2 with SMTP id h2mr11186111buf.22.1202059263207;
        Sun, 03 Feb 2008 09:21:03 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id x6sm4293526gvf.0.2008.02.03.09.21.00
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:21:02 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059249-3532-3-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72370>

This records the users choice of default remote name (by default "origin")
as given by the -o option.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-clone.txt |    3 ++-
 git-clone.sh                |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2341881..f15aecd 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -103,7 +103,8 @@ OPTIONS
 --origin <name>::
 -o <name>::
 	Instead of using the remote name 'origin' to keep track
-	of the upstream repository, use <name> instead.
+	of the upstream repository, use <name> instead. The name
+	is recorded in the core.origin config variable.
 
 --upload-pack <upload-pack>::
 -u <upload-pack>::
diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..7208d68 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -242,6 +242,7 @@ fi &&
 export GIT_DIR &&
 GIT_CONFIG="$GIT_DIR/config" git-init $quiet ${template+"$template"} || usage
 
+git config core.origin $origin
 if test -n "$bare"
 then
 	GIT_CONFIG="$GIT_DIR/config" git config core.bare true
-- 
1.5.4.18.g43c18
