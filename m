From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 3/7] git-clone - Set remotes.origin config variable
Date: Sun,  3 Feb 2008 12:31:03 -0500
Message-ID: <1202059867-1184-4-git-send-email-mlevedahl@gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-2-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-3-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 03 18:32:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLihj-0000tY-1J
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298AbYBCRbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756631AbYBCRbY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:31:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:37993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbYBCRbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:31:23 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1719736fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i1Qb4El+FAyNuJoc5xZZ2AHVD9XGOx6jYvymczMMyCA=;
        b=DiPNoiVoaGzjIUs33AbNjXK81ViCzzoeUGWH5GqgZKBb/3EOHP8dIfoRAqJxpXA0xIRRFdptOpmIBQoEHN86I+6EZzKj+aIl/qC4b+y+QnG5WSx/5jg1XoaiJwddC84Z+43tl3oMBnm/ioRi+3e7XfTJlxtRPprrsnnVImb1FFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NllhqSUmmBLVEV6WrvcTzWFPILLhvvuqRZomGwbLXBDIP0Tck42MPXiBqKKNz971B5eHo4LqmhVS4NPn0xT30sjXjEYo/ni4bZOtHnxa/zjWzGWHSphO5iDMFwlAwndBLQ/jJrxGUtZ77o6pQyMP5MemoElT8tiuiW3CQUqMz7E=
Received: by 10.86.72.15 with SMTP id u15mr5681374fga.11.1202059882282;
        Sun, 03 Feb 2008 09:31:22 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id l19sm8463628fgb.0.2008.02.03.09.31.19
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:31:21 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059867-1184-3-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72382>

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
