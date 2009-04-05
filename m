From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/2] git: remote stage
Date: Sun,  5 Apr 2009 16:48:50 +0300
Message-ID: <1238939331-10152-2-git-send-email-felipe.contreras@gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 15:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqSkG-0004wg-Ro
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 15:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZDENtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 09:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbZDENtK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 09:49:10 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:63104 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbZDENtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 09:49:08 -0400
Received: by bwz17 with SMTP id 17so1527794bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Wndemii9rBdgsv1cRnS9Asuv2CH/pj3D6BJL+ECCN+E=;
        b=SGAPdOyckuFvBYbhP9WugcrS+QrFH1rcSYDuA6ELy5Kc6cfDEsYpVJboj5Fb6xceTH
         8SuhmFHrLtqvgs4ZzUR/p0g1X0DQTR5/sOfyv/HqM/uJx1wr2K08+Ctd9CAbnslhzer/
         0DALAJ+RuthxSWSGCQ6aeL9sbvAFKkQDoAJn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HVY/3mASboSSs0KLST/CWDzrpzU/+THK38Bs77yd62F2IQTWr7uAXFHSUIugb9KNdU
         WGXZvEnfBhOCRn0moPL8+f4W2cmXnKadUpXZG464hORC0IfrGpih9E1Hy7pgJXedS9L8
         WTd1zj8EJp4sYTnalD/Bhxtc1O1hBQK1s10MM=
Received: by 10.223.112.202 with SMTP id x10mr2735068fap.68.1238939344054;
        Sun, 05 Apr 2009 06:49:04 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm1757196fks.5.2009.04.05.06.49.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 06:49:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.406.g45db3f
In-Reply-To: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115664>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt |   19 -------------------
 Makefile                    |    1 -
 git.c                       |    1 -
 3 files changed, 0 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/git-stage.txt

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
deleted file mode 100644
index 7f251a5..0000000
--- a/Documentation/git-stage.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-git-stage(1)
-==============
-
-NAME
-----
-git-stage - Add file contents to the staging area
-
-
-SYNOPSIS
---------
-[verse]
-'git stage' args...
-
-
-DESCRIPTION
------------
-
-This is a synonym for linkgit:git-add[1].  Please refer to the
-documentation of that command.
diff --git a/Makefile b/Makefile
index 7867eac..0c3de6b 100644
--- a/Makefile
+++ b/Makefile
@@ -345,7 +345,6 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
-BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
diff --git a/git.c b/git.c
index c2b181e..ebc3ccb 100644
--- a/git.c
+++ b/git.c
@@ -267,7 +267,6 @@ static void handle_internal_command(int argc, const char **argv)
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
-- 
1.6.2.2.406.g45db3f
