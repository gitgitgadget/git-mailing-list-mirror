From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 8/8] describe docs: note that <commit> is optional
Date: Sat, 18 Dec 2010 00:38:45 -0500
Message-ID: <1292650725-21149-9-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVz-0006oi-2K
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab0LRFjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:25 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0LRFjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:08 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so1366776qwa.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dgUg4WsWClHyPzJ8sAzn0EfJudCcckhOIxNet7cm94c=;
        b=kEaJEmMsiXwYWWsrrLD0jtuZBmFVpi+hoisyh8hsu+D//UN8Yr84pfczDXDOtlOQ5L
         OhFA1HhyudnhBu+egKH8Hl6kBdIC6XZiVlJzy660naIWItq1PKDLptHPgvPbzMPNt7/S
         sdoxIpAB+dtYyhg9V3NBOuGleJpJMu8h4+knc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V089vmnZTY7y3I4VR3eLYrBM5g4NrIwH3NdZHdQSGca/W4TqoYUk6Vd3U/5KQ7KVGj
         /DiSbBU/ZJAzOV0k7w3xx44ipfep/EnL1zNlKI5ohKrIdc+zXEp6Ab8hNztSnnNj7TiA
         2Bj45/Bmyj1VoDZODyNzj2Bk+8dzerzG1VPPI=
Received: by 10.224.60.194 with SMTP id q2mr1590403qah.128.1292650748137;
        Fri, 17 Dec 2010 21:39:08 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:07 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163904>

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-describe.txt |    3 ++-
 Documentation/gitcli.txt       |    2 +-
 builtin/describe.c             |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index ad173ed..8006d59 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -9,7 +9,7 @@ git-describe - Show the most recent tag that is reachable from a commit
 SYNOPSIS
 --------
 [verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <commit>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit>...]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
 
 DESCRIPTION
@@ -28,6 +28,7 @@ OPTIONS
 -------
 <commit>...::
 	Commit object names to describe.
+	If not given, defaults to HEAD.
 
 --dirty[=<mark>]::
 	Describe the working tree.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index b56e7c3..e57f88c 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,7 +81,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <commit>...
+usage: git describe [options] [<commit>...]
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
diff --git a/builtin/describe.c b/builtin/describe.c
index 4b5a217..82da278 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -12,7 +12,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git describe [options] <commit>...",
+	"git describe [options] [<commit>...]",
 	"git describe [options] --dirty",
 	NULL
 };
-- 
1.7.3.2
