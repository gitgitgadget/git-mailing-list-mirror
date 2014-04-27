From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 4/5] patch-id: change default to stable
Date: Sun, 27 Apr 2014 21:15:54 +0300
Message-ID: <1398622524-26207-4-git-send-email-mst@redhat.com>
References: <1398622524-26207-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTcd-0000hy-GJ
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbaD0SQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbaD0SPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:15:18 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIF9El018931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 27 Apr 2014 14:15:09 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s3RIF4jW008049;
	Sun, 27 Apr 2014 14:15:06 -0400
Content-Disposition: inline
In-Reply-To: <1398622524-26207-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247215>

--stable has been the default in 'next' for a few weeks with no ill
effects.
Change the default to that so that users don't have to remember to
enable it.

Update documentation to match behaviour change.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/patch-id.c             | 4 ++--
 Documentation/git-patch-id.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 77db873..e11a6a7 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -185,9 +185,9 @@ int cmd_patch_id(int argc, const char **argv, const char *prefix)
 
 	git_config(git_patch_id_config, &stable);
 
-	/* If nothing is set, default to unstable. */
+	/* If nothing is set, default to stable. */
 	if (stable < 0)
-		stable = 0;
+		stable = 1;
 
 	if (argc == 2 && !strcmp(argv[1], "--stable"))
 		stable = 1;
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index fa562d3..1e2ca75 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -43,7 +43,7 @@ OPTIONS
 	   of "-O<orderfile>", thereby making existing databases storing such
 	   "unstable" or historical patch-ids unusable.
 
-	This is the default if patchid.stable is set to true.
+	This is the default.
 
 --unstable::
 	Use an "unstable" hash as the patch ID. With this option,
@@ -52,7 +52,7 @@ OPTIONS
 	patch-ids produced by git 1.9 and older (who do not deal with reordered
 	patches) may want to use this option.
 
-	This is the default.
+	This is the default if patchid.stable is set to false.
 
 <patch>::
 	The diff to create the ID of.
-- 
MST
